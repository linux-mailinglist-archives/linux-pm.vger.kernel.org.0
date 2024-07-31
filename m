Return-Path: <linux-pm+bounces-11747-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75370942C99
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 12:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C5CD280C44
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 10:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7331AC42D;
	Wed, 31 Jul 2024 10:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Et6Youco"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B331AB536;
	Wed, 31 Jul 2024 10:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722423334; cv=none; b=DPh0lS/rPufKQdoXMGx3pv0nczHX1AVVDmDLpc3LN8kDm1oE9wUzOSGCoz63OBohsCB/r8c75XvGr3Fl0xfpcvSsFdrt6akaUvLhrg3Z9gkb9n5tyniWUTDVGE9K/i+phVESyrjxRemHimiuLI1dpGyUQxAZb42Vqa0yAQIScog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722423334; c=relaxed/simple;
	bh=PwE1B7FOzMNsmjsFKcTbij4x21K1f8NS7rm6VdbzxhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LOrsxdovefayuAywy04iZDO95MkvA065qiH0SFMJLJiv9oBc7hXEhWaKaJyO8RwMRnK1htCW0IGtYPT9tFTolGcIppHc+f71mo4dCR4lJxwQL9nVHldGNWIJu2AEJzL0VtA0qER4lOS/KngzAly953rln6imHrIU2NNfTxBwx2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Et6Youco; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6760C4AF09;
	Wed, 31 Jul 2024 10:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722423333;
	bh=PwE1B7FOzMNsmjsFKcTbij4x21K1f8NS7rm6VdbzxhI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Et6Youco9f3Q59OFO5ML82YxJvy2noV8asHBlScqt3dS9YSHGpwqLWAaiKrUXwd0N
	 aCrK9gFLpDn/i338phI24TnQp+7Wemu9aYhEpkL5NHVOoNJV5l2OR6XiQI3t0H8YcZ
	 Mt3fydCrU3xot/jogPr/OwiwtDNvFu4D1+R0jhyf0ZTP+TFgUI8rWNhYtOFnltlFc9
	 pTp8NfiBgwxoxFqoTQrD92Wgc3yMZ7Jfyo7orc6UJqKupgNdiVGFlRDKOIstKr52+N
	 RlInnXnHuKL8PY+hSo1DQYtZIRmaZEkwqA+AZ4J3grQWv97kAEtJcIftMjfYECztHl
	 G7j37pDWPmxWA==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5d5bc409181so471326eaf.0;
        Wed, 31 Jul 2024 03:55:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWvIkxtmJq0vAfCE3tPjcWz/eqDvv2zNCm/W9qlljpbC/hc3/t2p5lvZwZo0YXO90wa0Z+9rSmZzlXFAn+3RTpxPypxw2kH7UOsXn9EBYPEFeKAG0xzyfux8yf2HFixnCalIxeuRyM=
X-Gm-Message-State: AOJu0YzwtimkJijmG6MslyInaBlXn5M0jabRfk67wUAnhnm4NGnqw7pi
	8ZFNe3Rqkb4i6PWLGXeGv5L5QozzzPeigYiA/9IQB9Yx9UDstFBeJ4Rkd+datwVgKcC8yAJ5bx9
	SX8iOZ2XKNpjTkyWho5QhF9fDrvk=
X-Google-Smtp-Source: AGHT+IF3mwaof78bUAile+r201DovwlYdj7zYmsB5qr4SR+Kk6wmL/PELwGld4/eCC2xC4biXHf29yTRctpdsncfdFw=
X-Received: by 2002:a4a:a542:0:b0:5c7:b587:40a7 with SMTP id
 006d021491bc7-5d5b15373c5mr11631542eaf.1.1722423333003; Wed, 31 Jul 2024
 03:55:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731024518.126716-1-luoxueqin@kylinos.cn> <20240731024518.126716-3-luoxueqin@kylinos.cn>
In-Reply-To: <20240731024518.126716-3-luoxueqin@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 31 Jul 2024 12:55:21 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iYRXQTTnHic-x7ExOL3OW=RD4CgvgBGWgLUpqVXfsvtA@mail.gmail.com>
Message-ID: <CAJZ5v0iYRXQTTnHic-x7ExOL3OW=RD4CgvgBGWgLUpqVXfsvtA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] PM: Use sysfs_emit() and sysfs_emit_at() in "show" functions
To: xueqin Luo <luoxueqin@kylinos.cn>
Cc: rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, xiongxin@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 4:45=E2=80=AFAM xueqin Luo <luoxueqin@kylinos.cn> w=
rote:
>
> From: Xueqin Luo <luoxueqin@kylinos.cn>
>
> As Documentation/filesystems/sysfs.rst suggested,
> show() should only use sysfs_emit() or sysfs_emit_at() when formatting
> the value to be returned to user space.
>
> No functional change intended.
>
> Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
> ---
>  kernel/power/main.c | 82 +++++++++++++++++++++++++--------------------
>  1 file changed, 45 insertions(+), 37 deletions(-)
>
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index a9e0693aaf69..18948b694205 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -115,7 +115,7 @@ int pm_async_enabled =3D 1;
>  static ssize_t pm_async_show(struct kobject *kobj, struct kobj_attribute=
 *attr,
>                              char *buf)
>  {
> -       return sprintf(buf, "%d\n", pm_async_enabled);
> +       return sysfs_emit(buf, "%d\n", pm_async_enabled);
>  }
>
>  static ssize_t pm_async_store(struct kobject *kobj, struct kobj_attribut=
e *attr,
> @@ -139,8 +139,8 @@ power_attr(pm_async);
>  static ssize_t mem_sleep_show(struct kobject *kobj, struct kobj_attribut=
e *attr,
>                               char *buf)
>  {
> -       char *s =3D buf;
>         suspend_state_t i;
> +       ssize_t sz =3D 0;

Please call the new variable "count", and analogously below and in the
first patch.

>
>         for (i =3D PM_SUSPEND_MIN; i < PM_SUSPEND_MAX; i++) {
>                 if (i >=3D PM_SUSPEND_MEM && cxl_mem_active())
> @@ -149,17 +149,19 @@ static ssize_t mem_sleep_show(struct kobject *kobj,=
 struct kobj_attribute *attr,
>                         const char *label =3D mem_sleep_states[i];
>
>                         if (mem_sleep_current =3D=3D i)
> -                               s +=3D sprintf(s, "[%s] ", label);
> +                               sz +=3D sysfs_emit_at(buf, sz, "[%s] ", l=
abel);
>                         else
> -                               s +=3D sprintf(s, "%s ", label);
> +                               sz +=3D sysfs_emit_at(buf, sz, "%s ", lab=
el);
>                 }
>         }
>
>         /* Convert the last space to a newline if needed. */
> -       if (s !=3D buf)
> -               *(s-1) =3D '\n';
> +       if (sz) {
> +               sz--;
> +               sz +=3D sysfs_emit_at(buf, sz, "\n");
> +       }

Why do you need to update the count var above?  Something like this
should work too AFAICS:

if (count > 0)
        sysfs_emit_at(buf, count - 1, "\n");

Analogously below.

>
> -       return (s - buf);
> +       return sz;
>  }
>
>  static suspend_state_t decode_suspend_state(const char *buf, size_t n)
> @@ -220,7 +222,7 @@ bool sync_on_suspend_enabled =3D !IS_ENABLED(CONFIG_S=
USPEND_SKIP_SYNC);
>  static ssize_t sync_on_suspend_show(struct kobject *kobj,
>                                    struct kobj_attribute *attr, char *buf=
)
>  {
> -       return sprintf(buf, "%d\n", sync_on_suspend_enabled);
> +       return sysfs_emit(buf, "%d\n", sync_on_suspend_enabled);
>  }
>
>  static ssize_t sync_on_suspend_store(struct kobject *kobj,
> @@ -257,22 +259,24 @@ static const char * const pm_tests[__TEST_AFTER_LAS=
T] =3D {
>  static ssize_t pm_test_show(struct kobject *kobj, struct kobj_attribute =
*attr,
>                                 char *buf)
>  {
> -       char *s =3D buf;
>         int level;
> +       size_t sz =3D 0;

Reverse xmas tree order, please.

>
>         for (level =3D TEST_FIRST; level <=3D TEST_MAX; level++)
>                 if (pm_tests[level]) {
>                         if (level =3D=3D pm_test_level)
> -                               s +=3D sprintf(s, "[%s] ", pm_tests[level=
]);
> +                               sz +=3D sysfs_emit_at(buf, sz, "[%s] ", p=
m_tests[level]);
>                         else
> -                               s +=3D sprintf(s, "%s ", pm_tests[level])=
;
> +                               sz +=3D sysfs_emit_at(buf, sz, "%s ", pm_=
tests[level]);
>                 }
>
> -       if (s !=3D buf)
> -               /* convert the last space to a newline */
> -               *(s-1) =3D '\n';
> +       /* Convert the last space to a newline if needed. */
> +       if (sz) {
> +               sz--;
> +               sz +=3D sysfs_emit_at(buf, sz, "\n");
> +       }
>
> -       return (s - buf);
> +       return sz;
>  }
>
>  static ssize_t pm_test_store(struct kobject *kobj, struct kobj_attribute=
 *attr,
> @@ -390,7 +394,7 @@ static const char * const suspend_step_names[] =3D {
>  static ssize_t _name##_show(struct kobject *kobj,              \
>                 struct kobj_attribute *attr, char *buf)         \
>  {                                                              \
> -       return sprintf(buf, format_str, suspend_stats._name);   \
> +       return sysfs_emit(buf, format_str, suspend_stats._name);\
>  }                                                              \
>  static struct kobj_attribute _name =3D __ATTR_RO(_name)
>
> @@ -404,7 +408,7 @@ suspend_attr(max_hw_sleep, "%llu\n");
>  static ssize_t _name##_show(struct kobject *kobj,              \
>                 struct kobj_attribute *attr, char *buf)         \
>  {                                                              \
> -       return sprintf(buf, "%u\n",                             \
> +       return sysfs_emit(buf, "%u\n",                          \
>                        suspend_stats.step_failures[step-1]);    \
>  }                                                              \
>  static struct kobj_attribute _name =3D __ATTR_RO(_name)
> @@ -428,7 +432,7 @@ static ssize_t last_failed_dev_show(struct kobject *k=
obj,
>         index %=3D REC_FAILED_NUM;
>         last_failed_dev =3D suspend_stats.failed_devs[index];
>
> -       return sprintf(buf, "%s\n", last_failed_dev);
> +       return sysfs_emit(buf, "%s\n", last_failed_dev);
>  }
>  static struct kobj_attribute last_failed_dev =3D __ATTR_RO(last_failed_d=
ev);
>
> @@ -442,7 +446,7 @@ static ssize_t last_failed_errno_show(struct kobject =
*kobj,
>         index %=3D REC_FAILED_NUM;
>         last_failed_errno =3D suspend_stats.errno[index];
>
> -       return sprintf(buf, "%d\n", last_failed_errno);
> +       return sysfs_emit(buf, "%d\n", last_failed_errno);
>  }
>  static struct kobj_attribute last_failed_errno =3D __ATTR_RO(last_failed=
_errno);
>
> @@ -456,7 +460,7 @@ static ssize_t last_failed_step_show(struct kobject *=
kobj,
>         index %=3D REC_FAILED_NUM;
>         step =3D suspend_stats.failed_steps[index];
>
> -       return sprintf(buf, "%s\n", suspend_step_names[step]);
> +       return sysfs_emit(buf, "%s\n", suspend_step_names[step]);
>  }
>  static struct kobj_attribute last_failed_step =3D __ATTR_RO(last_failed_=
step);
>
> @@ -571,7 +575,7 @@ bool pm_print_times_enabled;
>  static ssize_t pm_print_times_show(struct kobject *kobj,
>                                    struct kobj_attribute *attr, char *buf=
)
>  {
> -       return sprintf(buf, "%d\n", pm_print_times_enabled);
> +       return sysfs_emit(buf, "%d\n", pm_print_times_enabled);
>  }
>
>  static ssize_t pm_print_times_store(struct kobject *kobj,
> @@ -604,7 +608,7 @@ static ssize_t pm_wakeup_irq_show(struct kobject *kob=
j,
>         if (!pm_wakeup_irq())
>                 return -ENODATA;
>
> -       return sprintf(buf, "%u\n", pm_wakeup_irq());
> +       return sysfs_emit(buf, "%u\n", pm_wakeup_irq());
>  }
>
>  power_attr_ro(pm_wakeup_irq);
> @@ -620,7 +624,7 @@ EXPORT_SYMBOL_GPL(pm_debug_messages_should_print);
>  static ssize_t pm_debug_messages_show(struct kobject *kobj,
>                                       struct kobj_attribute *attr, char *=
buf)
>  {
> -       return sprintf(buf, "%d\n", pm_debug_messages_on);
> +       return sysfs_emit(buf, "%d\n", pm_debug_messages_on);
>  }
>
>  static ssize_t pm_debug_messages_store(struct kobject *kobj,
> @@ -668,21 +672,25 @@ struct kobject *power_kobj;
>  static ssize_t state_show(struct kobject *kobj, struct kobj_attribute *a=
ttr,
>                           char *buf)
>  {
> -       char *s =3D buf;
> +       ssize_t sz =3D 0;
>  #ifdef CONFIG_SUSPEND
>         suspend_state_t i;
>
>         for (i =3D PM_SUSPEND_MIN; i < PM_SUSPEND_MAX; i++)
>                 if (pm_states[i])
> -                       s +=3D sprintf(s,"%s ", pm_states[i]);
> +                       sz +=3D sysfs_emit_at(buf, sz, "%s ", pm_states[i=
]);
>
>  #endif
>         if (hibernation_available())
> -               s +=3D sprintf(s, "disk ");
> -       if (s !=3D buf)
> -               /* convert the last space to a newline */
> -               *(s-1) =3D '\n';
> -       return (s - buf);
> +               sz +=3D sysfs_emit_at(buf, sz, "disk ");
> +
> +       /* Convert the last space to a newline if needed. */
> +       if (sz) {
> +               sz--;
> +               sz +=3D sysfs_emit_at(buf, sz, "\n");
> +       }
> +
> +       return sz;
>  }
>
>  static suspend_state_t decode_state(const char *buf, size_t n)
> @@ -782,7 +790,7 @@ static ssize_t wakeup_count_show(struct kobject *kobj=
,
>         unsigned int val;
>
>         return pm_get_wakeup_count(&val, true) ?
> -               sprintf(buf, "%u\n", val) : -EINTR;
> +               sysfs_emit(buf, "%u\n", val) : -EINTR;
>  }
>
>  static ssize_t wakeup_count_store(struct kobject *kobj,
> @@ -824,17 +832,17 @@ static ssize_t autosleep_show(struct kobject *kobj,
>         suspend_state_t state =3D pm_autosleep_state();
>
>         if (state =3D=3D PM_SUSPEND_ON)
> -               return sprintf(buf, "off\n");
> +               return sysfs_emit(buf, "off\n");
>
>  #ifdef CONFIG_SUSPEND
>         if (state < PM_SUSPEND_MAX)
> -               return sprintf(buf, "%s\n", pm_states[state] ?
> +               return sysfs_emit(buf, "%s\n", pm_states[state] ?
>                                         pm_states[state] : "error");
>  #endif
>  #ifdef CONFIG_HIBERNATION
> -       return sprintf(buf, "disk\n");
> +       return sysfs_emit(buf, "disk\n");
>  #else
> -       return sprintf(buf, "error");
> +       return sysfs_emit(buf, "error\n");
>  #endif
>  }
>
> @@ -903,7 +911,7 @@ int pm_trace_enabled;
>  static ssize_t pm_trace_show(struct kobject *kobj, struct kobj_attribute=
 *attr,
>                              char *buf)
>  {
> -       return sprintf(buf, "%d\n", pm_trace_enabled);
> +       return sysfs_emit(buf, "%d\n", pm_trace_enabled);
>  }
>
>  static ssize_t
> @@ -940,7 +948,7 @@ power_attr_ro(pm_trace_dev_match);
>  static ssize_t pm_freeze_timeout_show(struct kobject *kobj,
>                                       struct kobj_attribute *attr, char *=
buf)
>  {
> -       return sprintf(buf, "%u\n", freeze_timeout_msecs);
> +       return sysfs_emit(buf, "%u\n", freeze_timeout_msecs);
>  }
>
>  static ssize_t pm_freeze_timeout_store(struct kobject *kobj,
> --

