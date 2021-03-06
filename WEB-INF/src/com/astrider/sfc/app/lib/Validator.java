package com.astrider.sfc.app.lib;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.astrider.sfc.app.annotation.Column;
import com.astrider.sfc.app.annotation.Valid;
import com.astrider.sfc.app.lib.FlashMessage.Type;
import com.astrider.sfc.app.lib.util.StringUtils;
/**
 * Validator
 * 
 * @author astrider
 *         <p>
 *         ValueObject用バリデータ。
 *         Validアノテーションの内容に応じてValidationを実行し、FlashMessage形式でエラーメッセージを生成する。
 *         </p>
 * 
 * @param <T>
 *            ValueObject
 */
public class Validator<T extends BaseVo> {
	private FlashMessage flashMessage = new FlashMessage();
	private T vo;

	/**
	 * コンストラクタ.
	 * 
	 * @param 対象ValueObject
	 * 
	 */
	public Validator(T vo) {
		this.vo = vo;
		flashMessage.setMessageType(Type.WARNING);
	}

	/**
	 * エラーメッセージを取得.
	 * 
	 * @return FlashMessage
	 */
	public FlashMessage getFlashMessage() {
		return flashMessage;
	}

	/**
	 * 全Fieldに対してValidationを実行.
	 * 
	 * @return Valid or not
	 */
	public boolean valid() {
		boolean result = true;

		Field[] declaredFields = vo.getClass().getDeclaredFields();
		for (Field f : declaredFields) {
			f.setAccessible(true);
			result = validateField(f) && result;
		}
		return result;
	}

	private boolean validateField(Field f) {
		boolean result = true;
		Valid v = f.getAnnotation(Valid.class);
		if (v == null) {
			return true;
		}

		for (Method vm : v.getClass().getDeclaredMethods()) {
			try {
				if (vm.getReturnType().equals(Boolean.TYPE) && !vm.getName().equals("equals")) {
					if ((Boolean) vm.invoke(v)) {
						Method method = this.getClass().getMethod(vm.getName(), Field.class, Valid.class);
						result = (Boolean) method.invoke(this, f, v) && result;
					}
				}
			} catch (NoSuchMethodException e) {
				e.printStackTrace();
			} catch (SecurityException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			} catch (IllegalArgumentException e) {
				e.printStackTrace();
			} catch (InvocationTargetException e) {
				e.printStackTrace();
			}
		}
		return result;
	}

	/**
	 * isNotNull.
	 * 
	 * @param f
	 * @return 正否
	 */
	public boolean isNotNull(Field f) {
		boolean valid = false;
		try {
			valid = f.get(vo) != null;
		} catch (IllegalArgumentException e) {
			valid = false;
		} catch (IllegalAccessException e) {
			valid = false;
		}
		if (!valid) {
			Column c = f.getAnnotation(Column.class);
			String logicalName = c.logic();
			String errorMessage = "が未入力です";
			flashMessage.addMessage(logicalName + errorMessage);
		}
		return valid;
	}

	/**
	 * isNotNull.
	 * 
	 * @param f
	 * @param v
	 * @return 正否
	 */
	public boolean isNotNull(Field f, Valid v) {
		return isNotNull(f);
	}

	/**
	 * isNotBlank.
	 * 
	 * @param f
	 * @param v
	 * @return 正否
	 */
	public boolean isNotBlank(Field f, Valid v) {
		boolean valid = false;
		try {
			if (f.get(vo) == null) {
				valid = true;
			} else {
				String value = String.valueOf(f.get(vo));
				valid = StringUtils.isNotEmpty(value);
			}
		} catch (ClassCastException e) {
			valid = false;
		} catch (IllegalArgumentException e) {
			valid = false;
		} catch (IllegalAccessException e) {
			valid = false;
		}

		if (!valid) {
			Column c = f.getAnnotation(Column.class);
			String logicalName = c.logic();
			String errorMessage = "が未入力です";
			flashMessage.addMessage(logicalName + errorMessage);
		}

		return valid;
	}

	/**
	 * isLength.
	 * 
	 * @param f
	 * @param v
	 * @return 正否
	 *         <p>
	 *         length要素と併用
	 *         </p>
	 */
	public boolean isLength(Field f, Valid v) {
		boolean valid = false;
		try {
			if (f.get(vo) == null) {
				valid = true;
			} else {
				String value = String.valueOf(f.get(vo));
				valid = v.length() == value.length();
			}
		} catch (IllegalArgumentException e) {
			valid = false;
		} catch (IllegalAccessException e) {
			valid = false;
		}

		if (!valid) {
			Column c = f.getAnnotation(Column.class);
			String logicalName = c.logic();
			String errorMessage = "の長さは" + v.length() + "文字にする必要があります";
			flashMessage.addMessage(logicalName + errorMessage);
		}

		return valid;
	}

	/**
	 * isMinLength.
	 * 
	 * @param f
	 * @param v
	 * @return 正否
	 *         <p>
	 *         minLength要素を併用
	 *         </p>
	 */
	public boolean isMinLength(Field f, Valid v) {
		boolean valid = false;
		try {
			if (f.get(vo) == null) {
				valid = true;
			} else {
				String value = String.valueOf(f.get(vo));
				valid = v.minLength() <= value.length();
			}
		} catch (IllegalArgumentException e) {
			valid = false;
		} catch (IllegalAccessException e) {
			valid = false;
		}

		if (!valid) {
			Column c = f.getAnnotation(Column.class);
			String logicalName = c.logic();
			String errorMessage = "の長さは" + v.minLength() + "文字以上にする必要があります";
			flashMessage.addMessage(logicalName + errorMessage);
		}
		return valid;
	}

	/**
	 * isMaxLength.
	 * 
	 * @param f
	 * @param v
	 * @return 正否
	 *         <p>
	 *         maxLength要素を併用
	 *         </p>
	 */
	public boolean isMaxLength(Field f, Valid v) {
		boolean valid = false;
		try {
			if (f.get(vo) == null) {
				valid = true;
			} else {
				String value = String.valueOf(f.get(vo));
				valid = value.length() <= v.maxLength();
			}
		} catch (IllegalArgumentException e) {
			valid = false;
		} catch (IllegalAccessException e) {
			valid = false;
		}

		if (!valid) {
			Column c = f.getAnnotation(Column.class);
			String logicalName = c.logic();
			String errorMessage = "の長さは" + v.maxLength() + "文字以下にする必要があります";
			flashMessage.addMessage(logicalName + errorMessage);
		}
		return valid;
	}

	/**
	 * isMin.
	 * 
	 * @param f
	 * @param v
	 * @return 正否
	 *         <p>
	 *         min要素と併用
	 *         </p>
	 */
	public boolean isMin(Field f, Valid v) {
		boolean valid = false;
		try {
			if (f.get(vo) == null) {
				valid = true;
			} else {
				double value = 0;
				if (f.getType() == Integer.class) {
					value = (Integer) f.get(vo);
				} else if (f.getType() == Float.class) {
					value = (Float) f.get(vo);
				} else if (f.getType() == Double.class) {
					value = (Double) f.get(vo);
				}
				valid = v.min() <= value;
			}
		} catch (IllegalArgumentException e) {
			valid = false;
		} catch (IllegalAccessException e) {
			valid = false;
		}

		if (!valid) {
			Column c = f.getAnnotation(Column.class);
			String logicalName = c.logic();
			String errorMessage = "の値は" + v.min() + "以上にする必要があります";
			flashMessage.addMessage(logicalName + errorMessage);
		}
		return valid;
	}

	/**
	 * isMax.
	 * 
	 * @param f
	 * @param v
	 * @return 正否
	 *         <p>
	 *         max要素と併用
	 *         </p>
	 */
	public boolean isMax(Field f, Valid v) {
		boolean valid = false;
		try {
			if (f.get(vo) == null) {
				valid = true;
			} else {
				double value = 0;
				if (f.getType() == Integer.class) {
					value = (Integer) f.get(vo);
				} else if (f.getType() == Float.class) {
					value = (Float) f.get(vo);
				} else if (f.getType() == Double.class) {
					value = (Double) f.get(vo);
				}
				valid = value <= v.max();
			}
		} catch (IllegalArgumentException e) {
			valid = false;
		} catch (IllegalAccessException e) {
			valid = false;
		}

		if (!valid) {
			Column c = f.getAnnotation(Column.class);
			String logicalName = c.logic();
			String errorMessage = "の値は" + v.max() + "以下にする必要があります";
			flashMessage.addMessage(logicalName + errorMessage);
		}
		return valid;
	}

	/**
	 * isRegexp.
	 * 
	 * @param f
	 * @param v
	 * @return 正否
	 *         <p>
	 *         regexp要素と併用
	 *         </p>
	 */
	public boolean isRegexp(Field f, Valid v) {
		boolean valid = false;
		try {
			if (f.get(vo) == null) {
				valid = true;
			} else {
				valid = checkRegexp(f, v.regexp());
			}
		} catch (IllegalArgumentException e) {
			valid = false;
		} catch (IllegalAccessException e) {
			valid = false;
		}
		return valid;
	}

	/**
	 * isUrl.
	 * 
	 * @param f
	 * @param v
	 * @return 正否
	 *         <p>
	 *         URLであることを確認
	 *         </p>
	 */
	public boolean isUrl(Field f, Valid v) {
		String regex = "^(https?|ftp|file)://[-a-zA-Z0-9+&@#/%?=~_|!:,.;]*[-a-zA-Z0-9+&@#/%=~_|]";
		return checkRegexp(f, regex);
	}

	/**
	 * isEmail.
	 * 
	 * @param f
	 * @param v
	 * @return <p>
	 *         emailであることを確認
	 *         </p>
	 */
	public boolean isEmail(Field f, Valid v) {
		String regex = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";
		return checkRegexp(f, regex);
	}

	/**
	 * isPhone.
	 * 
	 * @param f
	 * @param v
	 * @return 正否
	 *         <p>
	 *         電話番号であることを確認
	 *         </p>
	 */
	public boolean isPhone(Field f, Valid v) {
		String regex = "^\\d{1,4}?-\\d{1,4}?-\\d{1,4}$";
		return checkRegexp(f, regex);
	}

	/**
	 * 正規表現チェッカー
	 * 
	 * @param f
	 * @param regex
	 * @return 正否
	 */
	private boolean checkRegexp(Field f, String regex) {
		boolean valid = false;
		try {
			if (f.get(vo) == null) {
				valid = true;
			}
			String value = (String) f.get(vo);
			Pattern pattern = Pattern.compile(regex);
			Matcher matcher = pattern.matcher(value);
			valid = matcher.matches();
		} catch (IllegalArgumentException e) {
			valid = false;
		} catch (IllegalAccessException e) {
			valid = false;
		}

		if (!valid) {
			Column c = f.getAnnotation(Column.class);
			String logicalName = c.logic();
			String errorMessage = "の値は指定のフォーマットにする必要があります";
			flashMessage.addMessage(logicalName + errorMessage);
		}
		return valid;
	}
}
