import 'package:conditional_builder/conditional_builder.dart';
import 'package:courses_workshop/models/category_model.dart';
import 'package:courses_workshop/models/courses_model.dart';
import 'package:courses_workshop/screens/courses/cubit/courses_cubit.dart';
import 'package:courses_workshop/screens/courses/cubit/courses_states.dart';
import 'package:courses_workshop/shared/colors/common_colors.dart';
import 'package:courses_workshop/shared/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoursesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // this screen designed in three layers
    return BlocProvider(
      create: (context) => CoursesCubit()..getCourses(),
      child: BlocConsumer<CoursesCubit, CoursesStates>(
          listener: (context, state) {},
          builder: (context, state) {
            List<CoursesModel> list = CoursesCubit.get(context).list;

            return ConditionalBuilder(
              condition: state is! CoursesStateLoading,
              builder: (context) => ConditionalBuilder(
                condition: state is! CoursesStateError,
                builder: (context) => ConditionalBuilder(
                  condition: list.length != 0,
                  builder: (context) => SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.only(start: 20, end: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              writeQuickText(
                                text: "Courses ",
                                textAlign: TextAlign.start,
                                fontSize: 28,
                              ),
                              writeQuickText(
                                  text: '\(${list.length}\)',
                                  fontSize: 22,
                                  color: kLightishPurpleColor),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 155,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) =>
                                  drawCategoryCard(categories[index]),
                              separatorBuilder:
                                  (BuildContext context, int index) => SizedBox(
                                width: 20.0,
                              ),
                              itemCount: categories.length,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) =>
                                buildExpandedCourseItem(
                                    startToday: () {
                                      showToast(
                                          message:
                                              "yes Course price is ${list[index].price}\$",
                                          error: false);
                                    },
                                    startDate:
                                        list[index].startDate ?? '2021-01-01',
                                    price:
                                        list[index].price ?? 16.99.toString(),
                                    image: NetworkImage(list[index].image) ??
                                        NetworkImage(
                                            "http://via.placeholder.com/350x150"),
                                    title: list[index].title ?? "Wordpress",
                                    description: list[index].description ??
                                        "Create your own website from scratch ",
                                    initiallyExpanded: false),
                            itemCount: list.length,
                            separatorBuilder:
                                (BuildContext context, int index) => SizedBox(
                              height: 15.0,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                  fallback: (context) => Center(
                    child: writeQuickText(
                        text: 'No Courses Yet',
                        fontSize: 22,
                        color: kGreyColor),
                  ),
                ),
                fallback: (context) => Center(
                  child: writeQuickText(
                      text: 'Error\n\nno Internet\nConnection',
                      fontSize: 22,
                      color: kGreyColor),
                ),
              ),
              fallback: (context) => Center(child: CircularProgressIndicator()),
            );
          }),
    );
  }
}
