Return-Path: <linux-pm+bounces-33884-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B60B4467B
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 21:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 45D9F4E1CFF
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 19:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE87326C3AC;
	Thu,  4 Sep 2025 19:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPsj5hMX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0C126C391;
	Thu,  4 Sep 2025 19:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757014556; cv=none; b=g3+54PbpajQxSEpD/wkLYsaeYbSxvBLZYC4zk5tkmbKiabWiAnBi29D9aA/R2eocRLOleunIuo+i/G+I0fiU2xpAK/V4ZIFSpHxNbjcXR0yOgYuvwYFwkdtfUjUXiagm/yexGz91H6Z5n3DHfIGDBhV42CDIChvxMiLOfhjo2gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757014556; c=relaxed/simple;
	bh=jDs7p00i6UOtKWdROmQyoqSnQHwd4KapxwOB5494hvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IHHdoILlPx+26XTR1LzEQWQ44DQukOL7AGvnCWyVoriwv7tNEqrMH9x7FoQcs6BbAgtWq+ag0ZyP6C0MZgxxEH2DJbducyOLL1fWCY7IkJqobXxg3ZidcO4bwuIoQGidgBGuVr3JA5dOWVwP2pshLbFVMY1+QiAxXsKdFkcgmNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPsj5hMX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB24FC4CEF1;
	Thu,  4 Sep 2025 19:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757014555;
	bh=jDs7p00i6UOtKWdROmQyoqSnQHwd4KapxwOB5494hvk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VPsj5hMXbsJk7+19y9SBKgKCsQydxHqO8PyVkmIyY5woR6mvVAIBvHoSevR99UCuD
	 fWz1e3AmHgIiwEGck4lUbZGZKOnpxRp8k2sTVivXqnp7mVw6f2b9Z2/g9E7122JTS9
	 k8bTtz4c6aIhddPFp1z1iHiVG2Q9YYrjC0L6/7i8Xs3E2N++oxfdUgKp7sswIObV55
	 RAM+02fGZ8TBJycznVEKP//MCGJMsg8618Hr63EHRS5b9TChoQW/H3N3ZkD6/7yNKq
	 Utt5aop7+JL6VXfAZMcucSzbpJafrGmlxMRjlM4ORp0BPS479AjpkBv0D/rFDFVdp+
	 c4Dfif48RulUw==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-74526ca79c2so672972a34.3;
        Thu, 04 Sep 2025 12:35:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2cD2lzltzgvfwIdcxnJoO6AKQdgZIOa1u4pDsJNGTnmtg+YrJSP/iU/T6Yy3cUdBfwvfNe36ArVfj8PI=@vger.kernel.org, AJvYcCVVIYf02r5wPGLu39bj1NODSuAlpVwly+afje7HDSifEeemnXhdEGO+rMowd4WALO7Bw8ccCnGWCRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzytY91XDgVM8m7WwznH43ygdjVm+TlHCmijUU7zeGyFWVaF5nL
	BtDN2En1f5iDmU4/LBwU7YlbyT7+1+al9hC/vV3u7uo28MkklTk52bcJ1ZYSz3ogKDvg/O6+VY0
	AwhJfHyXDzVdY9Bk6DRU8f6tPgBhQQxA=
X-Google-Smtp-Source: AGHT+IFbDVUkOR2oFA/bcez8jL9GRyu9uLaT7u4abAl0aiilKDwn5aVIULY7Nk5+m/CybhJ82+i9C1JAAH9F1vYxFLw=
X-Received: by 2002:a05:6808:8292:b0:438:1adb:248f with SMTP id
 5614622812f47-4381adb25e5mr4280150b6e.27.1757014555160; Thu, 04 Sep 2025
 12:35:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825185807.57668-1-vivekyadav1207731111@gmail.com>
In-Reply-To: <20250825185807.57668-1-vivekyadav1207731111@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Sep 2025 21:35:43 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gfrTvLgs=PdmRbRRN05GE4Bk8Q7hJdtQfyk3VqaOz7FQ@mail.gmail.com>
X-Gm-Features: Ac12FXyIdAkve35YQAht4PDr-aLjEZqibWHxw4SI6REqMWQk_QBh7TvokGelwbI
Message-ID: <CAJZ5v0gfrTvLgs=PdmRbRRN05GE4Bk8Q7hJdtQfyk3VqaOz7FQ@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: sysfs: Use sysfs_emit/sysfs_emit_at instead of sprintf/scnprintf
To: vivekyadav1207731111@gmail.com
Cc: daniel.lezcano@linaro.org, rafael@kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, joe@perches.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 8:58=E2=80=AFPM <vivekyadav1207731111@gmail.com> wr=
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
>  drivers/cpuidle/sysfs.c | 38 +++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
> index d6f5da61cb7d..c7af09460b74 100644
> --- a/drivers/cpuidle/sysfs.c
> +++ b/drivers/cpuidle/sysfs.c
> @@ -22,21 +22,21 @@ static ssize_t show_available_governors(struct device=
 *dev,
>                                         struct device_attribute *attr,
>                                         char *buf)
>  {
> -       ssize_t i =3D 0;
> +       ssize_t len =3D 0;

The variable rename is not necessary or even useful AFAICS ->

>         struct cpuidle_governor *tmp;
>
>         mutex_lock(&cpuidle_lock);
>         list_for_each_entry(tmp, &cpuidle_governors, governor_list) {
> -               if (i >=3D (ssize_t) (PAGE_SIZE - (CPUIDLE_NAME_LEN + 2))=
)
> +               if (len >=3D (ssize_t)(PAGE_SIZE - (CPUIDLE_NAME_LEN + 2)=
))
>                         goto out;
>
> -               i +=3D scnprintf(&buf[i], CPUIDLE_NAME_LEN + 1, "%s ", tm=
p->name);
> +               len +=3D sysfs_emit_at(buf, len, "%.*s ", CPUIDLE_NAME_LE=
N, tmp->name);

-> because the second argument here is still an offset relative to
buf, isn't it?

>         }
>
>  out:
> -       i+=3D sprintf(&buf[i], "\n");
> +       len +=3D sysfs_emit_at(buf, len, "\n");
>         mutex_unlock(&cpuidle_lock);
> -       return i;
> +       return len;
>  }
>
>  static ssize_t show_current_driver(struct device *dev,
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

