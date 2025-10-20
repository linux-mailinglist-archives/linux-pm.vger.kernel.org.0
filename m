Return-Path: <linux-pm+bounces-36496-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 16468BF2D22
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 19:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB4674E2938
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 17:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DB3221DB5;
	Mon, 20 Oct 2025 17:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtQ8DmAr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBA71C3C11
	for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 17:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760983002; cv=none; b=n/uyyesoG8aRGQcRp24+jE8MMOOwTOGYNPFEvn1l/imyA+GS6jETf5AZRQUpZIeJSihLzQCbgxNahQTOUkKueqQHmMnFAsQU43kor1JO/ewnVFZIjn58XdTCTPqFpJcUJyAlxDmkCcBONRy4TpbnFFkDoKwvv562avyfOvv7+y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760983002; c=relaxed/simple;
	bh=hZJrhcXonKyf15VqKCM3Ypdr4hu28hHAvn/h/5Q6C2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fiRsuEc5eEkeCDKBDFtzWOzFBjKfA2rGOIHVFPV46cbyBCu3DH/WjU3uHXy+jErBcnkNsc0QJiFed40Xn9r9B6fM2VyZcI+T6UMAhRj9Yv0O0xea69lSXvPgBYdUekZgI6L+HRp4Xv1JDTUBXtOw2dK6KaTpYNjKHkFcXXiqtxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtQ8DmAr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C254C4CEF9
	for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 17:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760983002;
	bh=hZJrhcXonKyf15VqKCM3Ypdr4hu28hHAvn/h/5Q6C2Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZtQ8DmArOTCm6YKJFeUU8H7G0hCOKcQahiledRzsgTpD463SdARIHKl3qxK6m+7WW
	 jiB3O6tdyHK1TMikJe4V0AHc/0FBsY7fJTglK8j6rUv55pcJ8WEIu6x8HGEekflz8g
	 BkHPHfN6ZgjOUt7dT4sz4Ao9pksfsoGIfgxC3f0ncoBy9oMDQKs2VlPF3roO48IibD
	 ELujsP/LZheZDbmNVKZWzSQKw2CVAnVWUwMby/bQCl4u1taSgvoK3W8CIwe8jjRjsj
	 xc435xvT3Cof9ubWRMMV/kxUnZGpow/mpAoCeA93R7Lx1cPEFmI02ZTzQfvz6EXnR6
	 jkR94Fnd7RP0g==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7c28bf230feso1946058a34.0
        for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 10:56:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUqlkuuEmG+ZKmc78zHVCFVMkqc1hVoBI1pXfIQ6ryN2+WHX37ICPek6p+SZasOi24YWmTJ4CqYEA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPd3r4GT7R3mvx+2IKAfYA6xi0E2ukJpW04PsSxDOd8pbYK773
	H0AKUp6v6oTmNHUM9WHa6NWpId/y3nnysaeWgfv9nEhbJecH4ap8m8io5HXmPMCcGcPjZ1q5zmC
	0o5RbtRj3GNyjS6fq6sR5gtADH3uhChI=
X-Google-Smtp-Source: AGHT+IFJGZuS5F6rV+z2SHPhZp+IMToXcTV5pJX9M4CsVEqOUn+X+uAmN9jVU/7qtLVsAHFMlwNJL6FO9lpcPxiRVA4=
X-Received: by 2002:a05:6808:14c5:b0:441:8f74:f03 with SMTP id
 5614622812f47-443a1b0529bmr5920415b6e.32.1760983001504; Mon, 20 Oct 2025
 10:56:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919124437.3075016-1-kaushlendra.kumar@intel.com>
In-Reply-To: <20250919124437.3075016-1-kaushlendra.kumar@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 20 Oct 2025 19:56:30 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iCQC4y02v5t2KUbAev6A=jsfem0r4rJy+TgBkUKf5nzA@mail.gmail.com>
X-Gm-Features: AS18NWAASEsLD5nZgLqR1HuMX9bKVsIY-_NJf8zhC3xApdUro9vYjvaKyQu6SeE
Message-ID: <CAJZ5v0iCQC4y02v5t2KUbAev6A=jsfem0r4rJy+TgBkUKf5nzA@mail.gmail.com>
Subject: Re: [PATCH] PM: Introduce CALL_PM_OP macro to reduce code duplication
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Cc: rafael@kernel.org, pavel@kernel.org, gregkh@linuxfoundation.org, 
	dakr@kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 2:46=E2=80=AFPM Kaushlendra Kumar
<kaushlendra.kumar@intel.com> wrote:
>
> Add CALL_PM_OP macro to eliminate repetitive code patterns in power
> management generic operations. Replace identical driver PM callback
> invocation logic across all pm_generic_* functions with a single
> macro that handles the NULL pointer checks and function calls.
>
> This reduces code duplication significantly while maintaining the
> same functionality and improving code maintainability.
>
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
>  drivers/base/power/generic_ops.c | 85 ++++++++++----------------------
>  1 file changed, 25 insertions(+), 60 deletions(-)
>
> diff --git a/drivers/base/power/generic_ops.c b/drivers/base/power/generi=
c_ops.c
> index 6502720bb564..c4fc802b8c65 100644
> --- a/drivers/base/power/generic_ops.c
> +++ b/drivers/base/power/generic_ops.c
> @@ -8,6 +8,13 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/export.h>
>
> +#define CALL_PM_OP(dev, op) \
> +({ \
> +struct device *_dev =3D (dev); \
> +const struct dev_pm_ops *pm =3D _dev->driver ? _dev->driver->pm : NULL; =
\
> +pm && pm->op ? pm->op(_dev) : 0; \
> +})
> +
>  #ifdef CONFIG_PM
>  /**
>   * pm_generic_runtime_suspend - Generic runtime suspend callback for sub=
systems.
> @@ -19,12 +26,7 @@
>   */
>  int pm_generic_runtime_suspend(struct device *dev)
>  {
> -       const struct dev_pm_ops *pm =3D dev->driver ? dev->driver->pm : N=
ULL;
> -       int ret;
> -
> -       ret =3D pm && pm->runtime_suspend ? pm->runtime_suspend(dev) : 0;
> -
> -       return ret;
> +       return CALL_PM_OP(dev, runtime_suspend);
>  }
>  EXPORT_SYMBOL_GPL(pm_generic_runtime_suspend);
>
> @@ -38,12 +40,7 @@ EXPORT_SYMBOL_GPL(pm_generic_runtime_suspend);
>   */
>  int pm_generic_runtime_resume(struct device *dev)
>  {
> -       const struct dev_pm_ops *pm =3D dev->driver ? dev->driver->pm : N=
ULL;
> -       int ret;
> -
> -       ret =3D pm && pm->runtime_resume ? pm->runtime_resume(dev) : 0;
> -
> -       return ret;
> +       return CALL_PM_OP(dev, runtime_resume);
>  }
>  EXPORT_SYMBOL_GPL(pm_generic_runtime_resume);
>  #endif /* CONFIG_PM */
> @@ -72,9 +69,7 @@ int pm_generic_prepare(struct device *dev)
>   */
>  int pm_generic_suspend_noirq(struct device *dev)
>  {
> -       const struct dev_pm_ops *pm =3D dev->driver ? dev->driver->pm : N=
ULL;
> -
> -       return pm && pm->suspend_noirq ? pm->suspend_noirq(dev) : 0;
> +       return CALL_PM_OP(dev, suspend_noirq);
>  }
>  EXPORT_SYMBOL_GPL(pm_generic_suspend_noirq);
>
> @@ -84,9 +79,7 @@ EXPORT_SYMBOL_GPL(pm_generic_suspend_noirq);
>   */
>  int pm_generic_suspend_late(struct device *dev)
>  {
> -       const struct dev_pm_ops *pm =3D dev->driver ? dev->driver->pm : N=
ULL;
> -
> -       return pm && pm->suspend_late ? pm->suspend_late(dev) : 0;
> +       return CALL_PM_OP(dev, suspend_late);
>  }
>  EXPORT_SYMBOL_GPL(pm_generic_suspend_late);
>
> @@ -96,9 +89,7 @@ EXPORT_SYMBOL_GPL(pm_generic_suspend_late);
>   */
>  int pm_generic_suspend(struct device *dev)
>  {
> -       const struct dev_pm_ops *pm =3D dev->driver ? dev->driver->pm : N=
ULL;
> -
> -       return pm && pm->suspend ? pm->suspend(dev) : 0;
> +       return CALL_PM_OP(dev, suspend);
>  }
>  EXPORT_SYMBOL_GPL(pm_generic_suspend);
>
> @@ -108,9 +99,7 @@ EXPORT_SYMBOL_GPL(pm_generic_suspend);
>   */
>  int pm_generic_freeze_noirq(struct device *dev)
>  {
> -       const struct dev_pm_ops *pm =3D dev->driver ? dev->driver->pm : N=
ULL;
> -
> -       return pm && pm->freeze_noirq ? pm->freeze_noirq(dev) : 0;
> +       return CALL_PM_OP(dev, freeze_noirq);
>  }
>  EXPORT_SYMBOL_GPL(pm_generic_freeze_noirq);
>
> @@ -120,9 +109,7 @@ EXPORT_SYMBOL_GPL(pm_generic_freeze_noirq);
>   */
>  int pm_generic_freeze(struct device *dev)
>  {
> -       const struct dev_pm_ops *pm =3D dev->driver ? dev->driver->pm : N=
ULL;
> -
> -       return pm && pm->freeze ? pm->freeze(dev) : 0;
> +       return CALL_PM_OP(dev, freeze);
>  }
>  EXPORT_SYMBOL_GPL(pm_generic_freeze);
>
> @@ -132,9 +119,7 @@ EXPORT_SYMBOL_GPL(pm_generic_freeze);
>   */
>  int pm_generic_poweroff_noirq(struct device *dev)
>  {
> -       const struct dev_pm_ops *pm =3D dev->driver ? dev->driver->pm : N=
ULL;
> -
> -       return pm && pm->poweroff_noirq ? pm->poweroff_noirq(dev) : 0;
> +       return CALL_PM_OP(dev, poweroff_noirq);
>  }
>  EXPORT_SYMBOL_GPL(pm_generic_poweroff_noirq);
>
> @@ -144,9 +129,7 @@ EXPORT_SYMBOL_GPL(pm_generic_poweroff_noirq);
>   */
>  int pm_generic_poweroff_late(struct device *dev)
>  {
> -       const struct dev_pm_ops *pm =3D dev->driver ? dev->driver->pm : N=
ULL;
> -
> -       return pm && pm->poweroff_late ? pm->poweroff_late(dev) : 0;
> +       return CALL_PM_OP(dev, poweroff_late);
>  }
>  EXPORT_SYMBOL_GPL(pm_generic_poweroff_late);
>
> @@ -156,9 +139,7 @@ EXPORT_SYMBOL_GPL(pm_generic_poweroff_late);
>   */
>  int pm_generic_poweroff(struct device *dev)
>  {
> -       const struct dev_pm_ops *pm =3D dev->driver ? dev->driver->pm : N=
ULL;
> -
> -       return pm && pm->poweroff ? pm->poweroff(dev) : 0;
> +       return CALL_PM_OP(dev, poweroff);
>  }
>  EXPORT_SYMBOL_GPL(pm_generic_poweroff);
>
> @@ -168,9 +149,7 @@ EXPORT_SYMBOL_GPL(pm_generic_poweroff);
>   */
>  int pm_generic_thaw_noirq(struct device *dev)
>  {
> -       const struct dev_pm_ops *pm =3D dev->driver ? dev->driver->pm : N=
ULL;
> -
> -       return pm && pm->thaw_noirq ? pm->thaw_noirq(dev) : 0;
> +       return CALL_PM_OP(dev, thaw_noirq);
>  }
>  EXPORT_SYMBOL_GPL(pm_generic_thaw_noirq);
>
> @@ -180,9 +159,7 @@ EXPORT_SYMBOL_GPL(pm_generic_thaw_noirq);
>   */
>  int pm_generic_thaw(struct device *dev)
>  {
> -       const struct dev_pm_ops *pm =3D dev->driver ? dev->driver->pm : N=
ULL;
> -
> -       return pm && pm->thaw ? pm->thaw(dev) : 0;
> +       return CALL_PM_OP(dev, thaw);
>  }
>  EXPORT_SYMBOL_GPL(pm_generic_thaw);
>
> @@ -192,9 +169,7 @@ EXPORT_SYMBOL_GPL(pm_generic_thaw);
>   */
>  int pm_generic_resume_noirq(struct device *dev)
>  {
> -       const struct dev_pm_ops *pm =3D dev->driver ? dev->driver->pm : N=
ULL;
> -
> -       return pm && pm->resume_noirq ? pm->resume_noirq(dev) : 0;
> +       return CALL_PM_OP(dev, resume_noirq);
>  }
>  EXPORT_SYMBOL_GPL(pm_generic_resume_noirq);
>
> @@ -204,9 +179,7 @@ EXPORT_SYMBOL_GPL(pm_generic_resume_noirq);
>   */
>  int pm_generic_resume_early(struct device *dev)
>  {
> -       const struct dev_pm_ops *pm =3D dev->driver ? dev->driver->pm : N=
ULL;
> -
> -       return pm && pm->resume_early ? pm->resume_early(dev) : 0;
> +       return CALL_PM_OP(dev, resume_early);
>  }
>  EXPORT_SYMBOL_GPL(pm_generic_resume_early);
>
> @@ -216,9 +189,7 @@ EXPORT_SYMBOL_GPL(pm_generic_resume_early);
>   */
>  int pm_generic_resume(struct device *dev)
>  {
> -       const struct dev_pm_ops *pm =3D dev->driver ? dev->driver->pm : N=
ULL;
> -
> -       return pm && pm->resume ? pm->resume(dev) : 0;
> +       return CALL_PM_OP(dev, resume);
>  }
>  EXPORT_SYMBOL_GPL(pm_generic_resume);
>
> @@ -228,9 +199,7 @@ EXPORT_SYMBOL_GPL(pm_generic_resume);
>   */
>  int pm_generic_restore_noirq(struct device *dev)
>  {
> -       const struct dev_pm_ops *pm =3D dev->driver ? dev->driver->pm : N=
ULL;
> -
> -       return pm && pm->restore_noirq ? pm->restore_noirq(dev) : 0;
> +       return CALL_PM_OP(dev, restore_noirq);
>  }
>  EXPORT_SYMBOL_GPL(pm_generic_restore_noirq);
>
> @@ -240,9 +209,7 @@ EXPORT_SYMBOL_GPL(pm_generic_restore_noirq);
>   */
>  int pm_generic_restore_early(struct device *dev)
>  {
> -       const struct dev_pm_ops *pm =3D dev->driver ? dev->driver->pm : N=
ULL;
> -
> -       return pm && pm->restore_early ? pm->restore_early(dev) : 0;
> +       return CALL_PM_OP(dev, restore_early);
>  }
>  EXPORT_SYMBOL_GPL(pm_generic_restore_early);
>
> @@ -252,9 +219,7 @@ EXPORT_SYMBOL_GPL(pm_generic_restore_early);
>   */
>  int pm_generic_restore(struct device *dev)
>  {
> -       const struct dev_pm_ops *pm =3D dev->driver ? dev->driver->pm : N=
ULL;
> -
> -       return pm && pm->restore ? pm->restore(dev) : 0;
> +       return CALL_PM_OP(dev, restore);
>  }
>  EXPORT_SYMBOL_GPL(pm_generic_restore);
>
> --

Applied as 6.19 material with some edits in the subject and changelog,
and some white space adjustments.

Thanks!

