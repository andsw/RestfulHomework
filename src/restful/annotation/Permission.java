package restful.annotation;

public @interface Permission {

	String value() default "user";

}
