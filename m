Return-Path: <linux-pm+bounces-35998-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 466BEBD5CE2
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 20:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C9934F0388
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 18:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDB42D8DD0;
	Mon, 13 Oct 2025 18:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/Ry6Mw7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71152D8DB9
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 18:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760381812; cv=none; b=Hz8pqsA1MmE3wJ21j7UJpfuMj8QF3DNn/mHHfZsjJSkybLvN7d4lo650luKM7EcWO+CPdIvcvD6/zWBVTCp2ktB62fqNjLV9O0hjNCQ4sjyXZwJ1/Onx/IuOHrBtz1Ma576C0F1ZYoecYfYq1L8JZ5yuvVS396LTacCLxAbPW74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760381812; c=relaxed/simple;
	bh=VIxcHzxRj1Y4xLO+Ack8jelbO6dg1q89WS2BkhliRiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WEYdiufT45iUoU0rMDOAr9m8ftSLn+sNZpJ5UC8jw3ASPfHNCmyPet3jMS5QHDlAzxaSl55pzsnUodoTcTBue3THLKvNJ2xqEz37SNl6XLB3bEbRNU0xAVfFpJCG4gs2c9d07mJebchAOIgLDvj4FFRNmPWmVXLp6J9nmOy1He0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/Ry6Mw7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E433C4CEF8
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 18:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760381812;
	bh=VIxcHzxRj1Y4xLO+Ack8jelbO6dg1q89WS2BkhliRiA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=s/Ry6Mw7xoGKgxO0xF+yu6q4TKYW+vLi8dLHlxVLladBqkUyGjJrq5MrZJVNRj4NL
	 CfxcXWrMsEBYz+pG/NwRS6ZMUjElqSzwnsmz9WehIIic17r/1IE0iBguXRuqpFBUYZ
	 vChcdnth1guqiZUcKJASt0GgJcrxjbyRA/u9ASV/rLqd8k58rDQFoEmfgy109Ew9WI
	 GqFTDVf4TM6F2ah7nrQ7Qm1KQMGAaG2/zePX32SuZ843aVuNdVmIXmI9lva/kzx62n
	 eG3N8PV28tujx1uKWi+amzFUhQIhfwZBtH0zDZUykSLR7ZLn0UdtdDPlFdyYWunoKM
	 R+oZdE7D1YODg==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-43f8116a163so2039027b6e.1
        for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 11:56:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWY75gNftXKh2iN1ysUHoKBwmzlyIc1wfTqzevQkix0vuBctobdq3/ch5Od7Cj0P/bT819QkLSktQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgEOaSxsKxDys0VnDCj4b3RZsV+DL2yJOo5awcgLRvZJFcWSeH
	8i4roo2l80EpxGR6nU0SEdtXAIrupgeL9c6OV9ItNFR4KNloYCUQt2Mt0cPUke63CwyhKmjfuaL
	b+hVBzsfdVeahv1OGUG/vNDUtBbi7tL0=
X-Google-Smtp-Source: AGHT+IFApQxsZxrQ6+IJkEmgM0Dw6Mqbr4BdNxaz213IlRL/JDDm611SZqMg3kBwCnBz2l4QvH+tjqum5xQoaF/z6h4=
X-Received: by 2002:a05:6808:ec3:b0:43f:4995:bb7d with SMTP id
 5614622812f47-4417b2d2326mr10337565b6e.7.1760381811398; Mon, 13 Oct 2025
 11:56:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919124437.3075016-1-kaushlendra.kumar@intel.com>
In-Reply-To: <20250919124437.3075016-1-kaushlendra.kumar@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 13 Oct 2025 20:56:40 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iXAO6Z1t-LeGgutsJRbfL7+Xtszq0h_pG+QFfPbfET7Q@mail.gmail.com>
X-Gm-Features: AS18NWDtDJ2oDrP6IELD_jJ2bR5YPAjTMiSWmaoC5qCzAn40sguCn7m88uCIEmI
Message-ID: <CAJZ5v0iXAO6Z1t-LeGgutsJRbfL7+Xtszq0h_pG+QFfPbfET7Q@mail.gmail.com>
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

Why don't you include the function signature and symbol export into the mac=
ro?

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
> 2.34.1
>

