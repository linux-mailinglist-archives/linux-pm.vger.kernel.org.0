Return-Path: <linux-pm+bounces-35094-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8D8B8C688
	for <lists+linux-pm@lfdr.de>; Sat, 20 Sep 2025 13:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDBB47A9882
	for <lists+linux-pm@lfdr.de>; Sat, 20 Sep 2025 11:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914832F9982;
	Sat, 20 Sep 2025 11:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmAKnuPe"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2FE1FBEB9
	for <linux-pm@vger.kernel.org>; Sat, 20 Sep 2025 11:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758366471; cv=none; b=dE16NbHMIQ5bz988XO8O8PSuRhzSq87Z8MyApDYZg00VOkytHZrAS7xxxNY5QX4hjsF+8zj5syyuCz3k6L8SGw3/rD5QnDgpd2fOg0Wz0nMDL1lz1rNevWoWTQl/7ujo/9LBRFvpgaVQSBmtZBsE11Q7RlRznUX4py0UQwgpAec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758366471; c=relaxed/simple;
	bh=TpfP0VJ11G7QI0AQg4mLtUM4/jK7WE+IVpgAzVkuN/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FxvYMFq4M1XHbCZKILZ7uUaIrkZtvZ4/kmkPz0BIEU3dGXeEemDyO4Ho/mZV2xBa1XM4MnAGVEs0hlkN+FnvJ4S3oKV/juqbpjJzKxj+uCCkOAJVYLFjYWPuitBHOGpbY8tDgCFive7oNHFNvE96bC0HC1DWqyvHaQ8s7tQthCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmAKnuPe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20823C4CEFB
	for <linux-pm@vger.kernel.org>; Sat, 20 Sep 2025 11:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758366471;
	bh=TpfP0VJ11G7QI0AQg4mLtUM4/jK7WE+IVpgAzVkuN/U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jmAKnuPeKu1VZuehGomrPgrOdZYCfyVXrQz3X6+MiybZvrU3BEKF4PHo0Akm/HXlS
	 xuif77Mpc7fHBq1nA0YRze6Hg6Xyz8oW9RDYhjXah3X9yZislowUk1MaT8dIpqgnnI
	 C0driG/G6hP7Auz23PPVO8uO/kdyZRjjdViamvD44CGOnPkcyffy/6sNrMhFv0WCBS
	 AoqLippn4waSIWrkPmKVfyfc1aayaiRDLc8k2JdiCYMVP9Sx453qQpBrW46v+otuUI
	 IzHmzDmoRRWx8JLcrrU9Xbj/fUEIZjU3T2SYcs1heXchgX/ZGfxI5Jb38bEsiossXM
	 szZD/HMCHOzKg==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-620b2171204so1514173eaf.0
        for <linux-pm@vger.kernel.org>; Sat, 20 Sep 2025 04:07:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX2fCKnOAN2ci9Ss4nemSGa4WJZPbcI9GaTyfD8rFwIuhpnG4XahD7+uNp4ip5zerNLBGiiM+Q7YA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa+QnTnPbADjgIs0aQTQRfpMnQaxD3vBx7GN1lzI0O7cqUeGu8
	UyPfGAwyYiAr9NGQ7aSq++l7rFkJPwceyL/9KIOkIdhCX8jkHzJ2z8IF+aKKV8JOpnnstNh6nES
	9YYUodK4nqtJugYnTR8e9DJBTjxsEvjY=
X-Google-Smtp-Source: AGHT+IF2uVqf5GAFrjNgl9l1aViZuBf9EzFUZwKFo5HyttmeemXFkxkW+7cNc1rWNoBCpeE2Iu3UZ3uahJkvkn37kQM=
X-Received: by 2002:a05:6808:1394:b0:43b:2829:e642 with SMTP id
 5614622812f47-43d6c2824f7mr2448689b6e.24.1758366470409; Sat, 20 Sep 2025
 04:07:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0gTtTZt7oE0vME0qRo8nZ=KX3DwF46PhyUVe7e85uZaNA@mail.gmail.com>
 <20250919165657.233349-1-vivekyadav1207731111@gmail.com>
In-Reply-To: <20250919165657.233349-1-vivekyadav1207731111@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 20 Sep 2025 13:07:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gooWpNra-EzT1xB+vsL9hLD_1eQm+DS_Jfw8dEtZoRJw@mail.gmail.com>
X-Gm-Features: AS18NWA2wIGm6rW53tbOvfILtPGvc_KCP2IRAYMaTfaPPBtIE1EsaLwVMvUjfdM
Message-ID: <CAJZ5v0gooWpNra-EzT1xB+vsL9hLD_1eQm+DS_Jfw8dEtZoRJw@mail.gmail.com>
Subject: Re: [PATCH v2] cpuidle: sysfs: Use sysfs_emit/sysfs_emit_at instead
 of sprintf/scnprintf
To: vivekyadav1207731111@gmail.com
Cc: joe@perches.com, rafael@kernel.org, daniel.lezcano@linaro.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 6:57=E2=80=AFPM <vivekyadav1207731111@gmail.com> wr=
ote:
>
> From: Vivek Yadav <vivekyadav1207731111@gmail.com>
>
> The ->show() callbacks in sysfs should use sysfs_emit() or
> sysfs_emit_at() when formatting values for user space. These helpers
> are the recommended way to ensure correct buffer handling and
> consistency across the kernel.
>
> See Documentation/filesystems/sysfs.rst for details.
>
> No functional change intended.
>
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Vivek Yadav <vivekyadav1207731111@gmail.com>
> ---
>  drivers/cpuidle/sysfs.c | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
> index d6f5da61cb7d..61de64817604 100644
> --- a/drivers/cpuidle/sysfs.c
> +++ b/drivers/cpuidle/sysfs.c
> @@ -27,14 +27,14 @@ static ssize_t show_available_governors(struct device=
 *dev,
>
>         mutex_lock(&cpuidle_lock);
>         list_for_each_entry(tmp, &cpuidle_governors, governor_list) {
> -               if (i >=3D (ssize_t) (PAGE_SIZE - (CPUIDLE_NAME_LEN + 2))=
)
> +               if (i >=3D (ssize_t)(PAGE_SIZE - (CPUIDLE_NAME_LEN + 2)))
>                         goto out;
>
> -               i +=3D scnprintf(&buf[i], CPUIDLE_NAME_LEN + 1, "%s ", tm=
p->name);
> +               i +=3D sysfs_emit_at(buf, i, "%.*s ", CPUIDLE_NAME_LEN, t=
mp->name);
>         }
>
>  out:
> -       i+=3D sprintf(&buf[i], "\n");
> +       i +=3D sysfs_emit_at(buf, i, "\n");
>         mutex_unlock(&cpuidle_lock);
>         return i;
>  }
> @@ -49,9 +49,9 @@ static ssize_t show_current_driver(struct device *dev,
>         spin_lock(&cpuidle_driver_lock);
>         drv =3D cpuidle_get_driver();
>         if (drv)
> -               ret =3D sprintf(buf, "%s\n", drv->name);
> +               ret =3D sysfs_emit(buf, "%s\n", drv->name);
>         else
> -               ret =3D sprintf(buf, "none\n");
> +               ret =3D sysfs_emit(buf, "none\n");
>         spin_unlock(&cpuidle_driver_lock);
>
>         return ret;
> @@ -65,9 +65,9 @@ static ssize_t show_current_governor(struct device *dev=
,
>
>         mutex_lock(&cpuidle_lock);
>         if (cpuidle_curr_governor)
> -               ret =3D sprintf(buf, "%s\n", cpuidle_curr_governor->name)=
;
> +               ret =3D sysfs_emit(buf, "%s\n", cpuidle_curr_governor->na=
me);
>         else
> -               ret =3D sprintf(buf, "none\n");
> +               ret =3D sysfs_emit(buf, "none\n");
>         mutex_unlock(&cpuidle_lock);
>
>         return ret;
> @@ -230,7 +230,7 @@ static struct cpuidle_state_attr attr_##_name =3D __A=
TTR(_name, 0644, show, store)
>  static ssize_t show_state_##_name(struct cpuidle_state *state, \
>                          struct cpuidle_state_usage *state_usage, char *b=
uf) \
>  { \
> -       return sprintf(buf, "%u\n", state->_name);\
> +       return sysfs_emit(buf, "%u\n", state->_name);\
>  }
>
>  #define define_show_state_ull_function(_name) \
> @@ -238,7 +238,7 @@ static ssize_t show_state_##_name(struct cpuidle_stat=
e *state, \
>                                   struct cpuidle_state_usage *state_usage=
, \
>                                   char *buf)                            \
>  { \
> -       return sprintf(buf, "%llu\n", state_usage->_name);\
> +       return sysfs_emit(buf, "%llu\n", state_usage->_name);\
>  }
>
>  #define define_show_state_str_function(_name) \
> @@ -247,8 +247,8 @@ static ssize_t show_state_##_name(struct cpuidle_stat=
e *state, \
>                                   char *buf)                            \
>  { \
>         if (state->_name[0] =3D=3D '\0')\
> -               return sprintf(buf, "<null>\n");\
> -       return sprintf(buf, "%s\n", state->_name);\
> +               return sysfs_emit(buf, "<null>\n");\
> +       return sysfs_emit(buf, "%s\n", state->_name);\
>  }
>
>  #define define_show_state_time_function(_name) \
> @@ -256,7 +256,7 @@ static ssize_t show_state_##_name(struct cpuidle_stat=
e *state, \
>                                   struct cpuidle_state_usage *state_usage=
, \
>                                   char *buf) \
>  { \
> -       return sprintf(buf, "%llu\n", ktime_to_us(state->_name##_ns)); \
> +       return sysfs_emit(buf, "%llu\n", ktime_to_us(state->_name##_ns));=
 \
>  }
>
>  define_show_state_time_function(exit_latency)
> @@ -273,14 +273,14 @@ static ssize_t show_state_time(struct cpuidle_state=
 *state,
>                                struct cpuidle_state_usage *state_usage,
>                                char *buf)
>  {
> -       return sprintf(buf, "%llu\n", ktime_to_us(state_usage->time_ns));
> +       return sysfs_emit(buf, "%llu\n", ktime_to_us(state_usage->time_ns=
));
>  }
>
>  static ssize_t show_state_disable(struct cpuidle_state *state,
>                                   struct cpuidle_state_usage *state_usage=
,
>                                   char *buf)
>  {
> -       return sprintf(buf, "%llu\n",
> +       return sysfs_emit(buf, "%llu\n",
>                        state_usage->disable & CPUIDLE_STATE_DISABLED_BY_U=
SER);
>  }
>
> @@ -310,7 +310,7 @@ static ssize_t show_state_default_status(struct cpuid=
le_state *state,
>                                           struct cpuidle_state_usage *sta=
te_usage,
>                                           char *buf)
>  {
> -       return sprintf(buf, "%s\n",
> +       return sysfs_emit(buf, "%s\n",
>                        state->flags & CPUIDLE_FLAG_OFF ? "disabled" : "en=
abled");
>  }
>
> @@ -358,7 +358,7 @@ static ssize_t show_state_s2idle_##_name(struct cpuid=
le_state *state, \
>                                          struct cpuidle_state_usage *stat=
e_usage, \
>                                          char *buf)                      =
       \
>  { \
> -       return sprintf(buf, "%llu\n", state_usage->s2idle_##_name);\
> +       return sysfs_emit(buf, "%llu\n", state_usage->s2idle_##_name);\
>  }
>
>  define_show_state_s2idle_ull_function(usage);
> @@ -550,7 +550,7 @@ static ssize_t show_driver_name(struct cpuidle_driver=
 *drv, char *buf)
>         ssize_t ret;
>
>         spin_lock(&cpuidle_driver_lock);
> -       ret =3D sprintf(buf, "%s\n", drv ? drv->name : "none");
> +       ret =3D sysfs_emit(buf, "%s\n", drv ? drv->name : "none");
>         spin_unlock(&cpuidle_driver_lock);
>
>         return ret;
> --

Applied as 6.18 material, thanks!

