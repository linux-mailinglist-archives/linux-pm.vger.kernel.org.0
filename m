Return-Path: <linux-pm+bounces-15984-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A4F9A4413
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 18:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B80151C20ABF
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 16:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C954E2036F2;
	Fri, 18 Oct 2024 16:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePM3feaM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE1E202651;
	Fri, 18 Oct 2024 16:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729269992; cv=none; b=CpVGEfrPhrTA+bP6Bt8BWIOQL+90W39U6muyQJw7lB0iG0VdLfiWf866t20S9D0Uof+Wt6q1ImVBnVzq6auTlT9JzGcv1ffdop+ivIJNTxYLhI04/rh2Zma9epiQDgDxCJXHWkhsEvMCyoxuyd4ttlwaXppRxITOQ9JBH1WIYZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729269992; c=relaxed/simple;
	bh=HvetEVA4zCK8RL7HD2ZOs/3kgdfuNgxZCJtcWYYCeBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wp2e872br0WOo57ghex0Ragd5s+KDimCu0ifaqIPtyZ/6lxKWZlt3H3+D+/4L2C4vrU9y+5hXyCBI3P3EUdp9nEyohp5x7QnxfyCF1IdMPp58SG241jGHhq4BRqcIr9IIs6OU6RYA8/haaetyoeD6+1lYWGITYlKDHoGrUlY4Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePM3feaM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3354CC4CECF;
	Fri, 18 Oct 2024 16:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729269991;
	bh=HvetEVA4zCK8RL7HD2ZOs/3kgdfuNgxZCJtcWYYCeBI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ePM3feaML+QDjb7Hk9W3VtQNSvOD/e6yi0wwNvPZHnc9nBxfQXvqjbmHLxiBE08m5
	 H1jfEEsUwMrnlATY3BdP/4Sid8rJzkxv/oFuj61BOUHaSgfPZf7p7eNQ9+U9KI4Pku
	 NNF6x8xNfg69pvky/iOo46zaBE9EDisG9rrAREk4DbVH5sE4gdzLVY+a8D+Z3/TU39
	 hP5C8bVPDekko9rI4jF4Ik8C6Hj6+RRz80g0xk3XJR5VwIkJqO+o8fEb14e1KdhB9/
	 zcgZbFtwaxaflJQx8kxyaEeDk+uQpgMkIGirIZ92f6lQtXvgtbI/8V91fpulyyflRR
	 Erxp6aDKzs3VQ==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5eb8099f2e2so761071eaf.3;
        Fri, 18 Oct 2024 09:46:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUiX60UwZcWHdqL0k7SvQcGamsAeGyxA8arpFfm07FtWS3zJeElH2DGAYnEeACSYcH860r6GBB0/s+nrASU@vger.kernel.org, AJvYcCV5cmGKyqt56DjJ9wbtTKeEzSBcL2fkgex2tD76bGhXvGcw1soJImPs/PHwrgkVH5tZgXkZb6PTFxnb2DKH@vger.kernel.org, AJvYcCVQ0KBUBoiH+pZj4LV/l0rNtUqge1wMnC0vv5ZD+CVALcVphB0ODHZLsW4E1EU/Bv0JHx+eUF/EpgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsWnd6GEujfQV70mpTGXkeJR3/uQcv85kLGKFbs27gT3QAHV3z
	7lISdri0xeYd1TCrUEM4bZjPRxdi8gj1PfqTSMlQwFet7P7mvG5ai6xmljJ1pFjeuruZWhcPbtY
	dEofBBYxXlkW4hvTNwcpxB/vaygU=
X-Google-Smtp-Source: AGHT+IGXyq0dmldYiwmz+afHivTsSjfiM4J/KBaxukLyYzlQwRaqDq01j8jkT5ZetrgHgl22GBLb8mkwRLI2wrLMxa0=
X-Received: by 2002:a05:6870:ac22:b0:287:b133:8aca with SMTP id
 586e51a60fabf-2892c3425demr3187518fac.25.1729269990416; Fri, 18 Oct 2024
 09:46:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927081018.8608-1-shenlichuan@vivo.com>
In-Reply-To: <20240927081018.8608-1-shenlichuan@vivo.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 18 Oct 2024 18:46:19 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h3ZfsjOn05xBzpmFVi2Cm5Coa7006YRSGfoCe+HBv1ww@mail.gmail.com>
Message-ID: <CAJZ5v0h3ZfsjOn05xBzpmFVi2Cm5Coa7006YRSGfoCe+HBv1ww@mail.gmail.com>
Subject: Re: [PATCH v1] cpuidle: Correct some typos in comments
To: Shen Lichuan <shenlichuan@vivo.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 10:10=E2=80=AFAM Shen Lichuan <shenlichuan@vivo.com=
> wrote:
>
> Fixed some confusing typos that were currently identified with codespell,
> the details are as follows:
>
> -in the code comments:
> drivers/cpuidle/cpuidle-arm.c:142: registeration =3D=3D> registration
> drivers/cpuidle/cpuidle-qcom-spm.c:51: accidently =3D=3D> accidentally
> drivers/cpuidle/cpuidle.c:409: dependant =3D=3D> dependent
> drivers/cpuidle/driver.c:264: occuring =3D=3D> occurring
> drivers/cpuidle/driver.c:299: occuring =3D=3D> occurring
>
> Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
> ---
>  drivers/cpuidle/cpuidle-arm.c      | 2 +-
>  drivers/cpuidle/cpuidle-qcom-spm.c | 2 +-
>  drivers/cpuidle/cpuidle.c          | 2 +-
>  drivers/cpuidle/driver.c           | 4 ++--
>  4 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.=
c
> index 7cfb980a357d..caba6f4bb1b7 100644
> --- a/drivers/cpuidle/cpuidle-arm.c
> +++ b/drivers/cpuidle/cpuidle-arm.c
> @@ -139,7 +139,7 @@ static int __init arm_idle_init_cpu(int cpu)
>   *
>   * Initializes arm cpuidle driver for all CPUs, if any CPU fails
>   * to register cpuidle driver then rollback to cancel all CPUs
> - * registeration.
> + * registration.
>   */
>  static int __init arm_idle_init(void)
>  {
> diff --git a/drivers/cpuidle/cpuidle-qcom-spm.c b/drivers/cpuidle/cpuidle=
-qcom-spm.c
> index 1fc9968eae19..3ab240e0e122 100644
> --- a/drivers/cpuidle/cpuidle-qcom-spm.c
> +++ b/drivers/cpuidle/cpuidle-qcom-spm.c
> @@ -48,7 +48,7 @@ static int qcom_cpu_spc(struct spm_driver_data *drv)
>         ret =3D cpu_suspend(0, qcom_pm_collapse);
>         /*
>          * ARM common code executes WFI without calling into our driver a=
nd
> -        * if the SPM mode is not reset, then we may accidently power dow=
n the
> +        * if the SPM mode is not reset, then we may accidentally power d=
own the
>          * cpu when we intended only to gate the cpu clock.
>          * Ensure the state is set to standby before returning.
>          */
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 9e418aec1755..06ace16f9e71 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -406,7 +406,7 @@ void cpuidle_reflect(struct cpuidle_device *dev, int =
index)
>   * Min polling interval of 10usec is a guess. It is assuming that
>   * for most users, the time for a single ping-pong workload like
>   * perf bench pipe would generally complete within 10usec but
> - * this is hardware dependant. Actual time can be estimated with
> + * this is hardware dependent. Actual time can be estimated with
>   *
>   * perf bench sched pipe -l 10000
>   *
> diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
> index cf5873cc45dc..9bbfa594c442 100644
> --- a/drivers/cpuidle/driver.c
> +++ b/drivers/cpuidle/driver.c
> @@ -261,7 +261,7 @@ static void __cpuidle_unregister_driver(struct cpuidl=
e_driver *drv)
>   * @drv: a pointer to a valid struct cpuidle_driver
>   *
>   * Register the driver under a lock to prevent concurrent attempts to
> - * [un]register the driver from occuring at the same time.
> + * [un]register the driver from occurring at the same time.
>   *
>   * Returns 0 on success, a negative error code (returned by
>   * __cpuidle_register_driver()) otherwise.
> @@ -296,7 +296,7 @@ EXPORT_SYMBOL_GPL(cpuidle_register_driver);
>   * @drv: a pointer to a valid struct cpuidle_driver
>   *
>   * Unregisters the cpuidle driver under a lock to prevent concurrent att=
empts
> - * to [un]register the driver from occuring at the same time.  @drv has =
to
> + * to [un]register the driver from occurring at the same time.  @drv has=
 to
>   * match the currently registered driver.
>   */
>  void cpuidle_unregister_driver(struct cpuidle_driver *drv)
> --

Applied as 6.13 material, thanks!

