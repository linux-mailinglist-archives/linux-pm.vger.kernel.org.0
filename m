Return-Path: <linux-pm+bounces-13965-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8282A9741B3
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 20:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CDDD1F26D12
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 18:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59A218E021;
	Tue, 10 Sep 2024 18:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0LxzoPV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04DE156F2B
	for <linux-pm@vger.kernel.org>; Tue, 10 Sep 2024 18:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725991723; cv=none; b=fiUt7J+WxoMFpfY3Cb8Vo7oWZ7+ZmznO2JcHUz1em9NFu4g4PC/SK3CaPgvQ9MimkARfvnYgabmiW7Z5KcNXcceFHMYtm+yEH8Sepau+IlyikAVK8Vr477KinyQXY3LCDCy8K0dR9hggWhqgWSOuTJlLbTJXr3/yBH/hnZpG1ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725991723; c=relaxed/simple;
	bh=hjpkGzVRcqQqMSoasaxBIQ3q5gmJzuuWPXwe6Cf7S2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/oC/pdtYibuGaX5UeOgnK6zYzO/I6IOMw5q0IVNR2hlDgp/tAFULZq4yVVHMQxEJpE359U/yUtdbTZ3vIuFVKXvUPSy0NKyYCpter0XPtXvSfGgT8EqrSuPrt7dcTDw5MPeQkG64zIL23xULcLrtjZCVmMxqYh2mNYSdZy4EAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0LxzoPV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94710C4CEC4
	for <linux-pm@vger.kernel.org>; Tue, 10 Sep 2024 18:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725991723;
	bh=hjpkGzVRcqQqMSoasaxBIQ3q5gmJzuuWPXwe6Cf7S2A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=l0LxzoPVScFFvvJ1sffEYJAv31p0WSRQPwQYmMshJPZfEtrOJeaYey0AqWl73/POj
	 86ffdlgIOYfWStmEXBrJmuoDbBNtz4jovXQ56jGMGJRsZhQdfIflatXKE/Uzb6ZmsF
	 xWoYdKN1C7v8tMVLFh4rMUofjksbkdcwIeQAVkiStL7pJThWkKYK7QXtMmbQuOZE6p
	 EU+xRFLDqsktDejPYSzrqxO4X+d2M3I2FZUWmvVtT0fEZ+s7qjSQR9COB12ZS8GZfl
	 YUpblHFlb3IeB/uGy4esU0XLDjPPxR1UJ9ivRi2/qqaB0SzYCV1MAlU8O9H+KdLlRW
	 1E2qCfFnnzeZw==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2780827dbafso3210798fac.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Sep 2024 11:08:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX64jRCXkpzuYjzoLNW/vsQkOk00XG3sv/nTaufpncxit0H8dZ2njOckgENqg1BhQGa8gEYiwRfMw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx60AHyUbz2g1tmyPafzM7vOd7F2g4G5OA9sz+vsmxSy5UK1zMg
	QNB5l2tDn3MjaesjWJhpRXO00dc8SrPICyH3aPd/MhHGRY/HpndvdTaV7iZRG4mJSbnsy37Vnfm
	8EMEy8LJs0HlgRqreriSUpSvIN+c=
X-Google-Smtp-Source: AGHT+IEUjlDlR92Gmsq8I5PR7HMMRH+XZJnNamGxsfzz4PuYlXzd+LxGBLjU2ZfCBbOh1nomoFSm/KZhvCFgN2Nis2s=
X-Received: by 2002:a05:6871:28f:b0:254:c777:6327 with SMTP id
 586e51a60fabf-27b82fb7827mr16716071fac.36.1725991722893; Tue, 10 Sep 2024
 11:08:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909080726.16811-1-xiongxin@kylinos.cn>
In-Reply-To: <20240909080726.16811-1-xiongxin@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 10 Sep 2024 20:08:31 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iJ+cTj1OOZZ7iGEgzEtovk5VAOkw8C5E8VPPyp=WUasg@mail.gmail.com>
Message-ID: <CAJZ5v0iJ+cTj1OOZZ7iGEgzEtovk5VAOkw8C5E8VPPyp=WUasg@mail.gmail.com>
Subject: Re: [PATCH v2] PM: sleep: Optimize the pm_debug_messages_should_print()
 condition
To: Xiong Xin <xiongxin@kylinos.cn>
Cc: rafael@kernel.org, mario.limonciello@amd.com, len.brown@intel.com, 
	pavel@ucw.cz, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 10:07=E2=80=AFAM Xiong Xin <xiongxin@kylinos.cn> wro=
te:
>
> From: xiongxin <xiongxin@kylinos.cn>
>
> pm_pr_dbg() is useful when debugging suspend and hibernate processes. In
> commit cdb8c100d8a4 ("include/linux/suspend.h: Only show pm_pr_dbg
> messages at suspend/resume") using pm_suspend_target_state to limits the
> output range of pm_pr_dbg(), causes the original pm_pr_dbg() output
> range to change.
>
> In the suspend process, pm_pr_dbg() is called before setting
> pm_suspend_target_state. As a result, this part of the log cannot be
> output.
>
> pm_pr_dbg() also outputs debug logs for hibernate, but
> pm_suspend_target_state is not set, resulting in hibernate debug logs
> can only be output through dynamic debug, which is very inconvenient.
>
> Expand the scope of the state variable in state_store() and add judgment
> on it in pm_debug_messages_should_print() to extend the debugging output
> of pm_pr_dbg() to suspend and hibernate processes.
>
> Fixes: cdb8c100d8a4 ("include/linux/suspend.h: Only show pm_pr_dbg messag=
es at suspend/resume").
> Signed-off-by: xiongxin <xiongxin@kylinos.cn>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  kernel/power/main.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index a9e0693aaf69..a376107efbb4 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -559,6 +559,8 @@ late_initcall(pm_debugfs_init);
>
>  #endif /* CONFIG_PM_SLEEP */
>
> +static suspend_state_t pm_state =3D PM_SUSPEND_ON;
> +
>  #ifdef CONFIG_PM_SLEEP_DEBUG
>  /*
>   * pm_print_times: print time taken by devices to suspend and resume.
> @@ -613,7 +615,9 @@ bool pm_debug_messages_on __read_mostly;
>
>  bool pm_debug_messages_should_print(void)
>  {
> -       return pm_debug_messages_on && pm_suspend_target_state !=3D PM_SU=
SPEND_ON;
> +       return pm_debug_messages_on &&
> +              (pm_suspend_target_state !=3D PM_SUSPEND_ON ||
> +               pm_state !=3D PM_SUSPEND_ON);
>  }
>  EXPORT_SYMBOL_GPL(pm_debug_messages_should_print);
>
> @@ -715,7 +719,6 @@ static suspend_state_t decode_state(const char *buf, =
size_t n)
>  static ssize_t state_store(struct kobject *kobj, struct kobj_attribute *=
attr,
>                            const char *buf, size_t n)
>  {
> -       suspend_state_t state;
>         int error;
>
>         error =3D pm_autosleep_lock();
> @@ -727,18 +730,20 @@ static ssize_t state_store(struct kobject *kobj, st=
ruct kobj_attribute *attr,
>                 goto out;
>         }
>
> -       state =3D decode_state(buf, n);
> -       if (state < PM_SUSPEND_MAX) {
> -               if (state =3D=3D PM_SUSPEND_MEM)
> -                       state =3D mem_sleep_current;
> +       pm_state =3D decode_state(buf, n);
> +       if (pm_state < PM_SUSPEND_MAX) {
> +               if (pm_state =3D=3D PM_SUSPEND_MEM)
> +                       pm_state =3D mem_sleep_current;
>
> -               error =3D pm_suspend(state);
> -       } else if (state =3D=3D PM_SUSPEND_MAX) {
> +               error =3D pm_suspend(pm_state);
> +       } else if (pm_state =3D=3D PM_SUSPEND_MAX) {
>                 error =3D hibernate();
>         } else {
>                 error =3D -EINVAL;
>         }
>
> +       pm_state =3D PM_SUSPEND_ON;
> +
>   out:
>         pm_autosleep_unlock();
>         return error ? error : n;
> --

This would only work for transitions started via /sys/power/state
AFAICS, but there are other ways to start them (eg. autosleep).

