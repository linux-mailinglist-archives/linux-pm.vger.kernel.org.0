Return-Path: <linux-pm+bounces-22298-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4308BA399F3
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 12:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B19F7A4131
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 11:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78A62397AA;
	Tue, 18 Feb 2025 11:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n0zjKGCf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E863123CF1F
	for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2025 11:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739877005; cv=none; b=HFaHWHS47NF3erbx8+9lxJh6eUaJYwqKLHKwRC0SNvDGOMkwQphmowaGl2Pclxh1BvSRa6ziN+ewGENaooCX4OAaRSY9+vazU7yUxLGzPzLuDts8lvddxDEP9FacAsIQ0xMQ983wkY4oSusEBRGvFdL+0Tvj/3jAdKhgQ5UsGus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739877005; c=relaxed/simple;
	bh=NXHNjkP9fyKMEmNMjHzJ6qYQRe9g0RNuw9w6xp6qFwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hHuj6XxV8Oe7jo4ClMykZMjQGtStSgBOAjs/x642qh0x3Qn811KsvNKs+CuumZo+vvbprH+LIJsJEQlYeso5upof56PjyFNOuQgdxm/1F7GdRak6q7umWd4+LVCNqUCu9hJOxMXWa8R3I01OXlBRCM1tG72hMj2cUK7UAq0Yyuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n0zjKGCf; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e5dc39ede40so3031120276.1
        for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2025 03:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739877003; x=1740481803; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K3ttRw4WtfoPQJNKd0VXXYu2qHT5cqSTvGY4bcJ3Gyo=;
        b=n0zjKGCfm4ANVdrKJbV9RSg+1EQiBH9XYQ47w86fWBvbvPFUOf/2x8+SUlsXybi24I
         xyPZieCloAQXW9gFi9w5pHgNMOmtKyAtdzIOVBgI2DNSTLRkHBW6csUEol2WWMbgMaYG
         ti5qPrp92TGyDpQscThp84kxHttZy8pda5QNGh1j9meBQWYTpTHjJjlZz4iD9XOJBQJ8
         rYt6JvmBb711Ig1wI/yI8P2ZNuFUZC3rzyGK2Dh1u0r0VCaNEFlLXXomTtbs5MZCFh/N
         xMZoJMWmkF9cQCBEE4urLrqLpMcq69rikqCTY8AUzC3XHqtKTauzUMroZqw1u3hgSxrX
         isPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739877003; x=1740481803;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K3ttRw4WtfoPQJNKd0VXXYu2qHT5cqSTvGY4bcJ3Gyo=;
        b=BMT+dNR++hZCUvjyZPnfdINL0OL3Pdmw5qxh0HnQh/2wUjB6FYhyTxyrBxqYyTjnA/
         XXX8ru/vKH1Z6fcSZHHjW6BoS7r2ezI50gsZBmyseC/vgQAP9ejgbjQhG+iU9ZYtJxXU
         a0nn4yomM26ag76Zip19BXwmFPtzns0Tl02jFQJgvz/xnRyBLfC8AmwM7zASx1dzPoBh
         2mWe3W1ldCjtnPT55Unwk4jRml/RUHZZb8QePNDw/Nt2dV7/dlTioKZkSXIhNvWR//Vg
         9TRfSs4kWDaBOJCixsO0ELpU4iD1WxkuNvD75vAzLciAopeZE9aQgS0t5u+XvCGdsiSl
         bgPw==
X-Gm-Message-State: AOJu0YzksC3VuWqkgLal6mBXfnGccUA2ZnthP5eMCb+TK8U1x1MTUQIl
	FVQv8NFh+jALMSbGCb00aORDgTNi43O3mR5QOI0Q0zujs31VSWv6JdV9WMcCvzs1+PzjPxNnQr1
	xYNyCHj0pGgr2UL+ya70sR+X0DQfISAqyr7oHoA==
X-Gm-Gg: ASbGncssc1tO+x2A1SVwMdMYhHZyDw7M4i/8l/ykvB8+5FB5FsuxHiJbnjfY+lo0RWc
	i88Jm1RyK/vQkVVUTdkKl2G7a1oFY0xosN4qmKllnNi1BFegfetsqiuGrt8c7mFkCHVY8Hqs4ng
	==
X-Google-Smtp-Source: AGHT+IHPKubHAH0Pi1Zg45U5aQK5z2M6ravRhS4x0dWo2wjj+DHKeqdoUN3K55NfHWX9cETDd8ABYa9nLLFDw4SD/PU=
X-Received: by 2002:a05:6902:200e:b0:e57:f841:949f with SMTP id
 3f1490d57ef6-e5dc904c46bmr9500103276.19.1739877002844; Tue, 18 Feb 2025
 03:10:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12617588.O9o76ZdvQC@rjwysocki.net>
In-Reply-To: <12617588.O9o76ZdvQC@rjwysocki.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 18 Feb 2025 12:09:26 +0100
X-Gm-Features: AWEUYZnJEpLOxgFTwflcJJSgimkNtFIn9NlT1KBJUKUK1WBE1F1P0_LpZGuyeGw
Message-ID: <CAPDyKFrEv_DV=zZ57S==pZHQt1oeArYHWNrwthenRbP+VhLoHA@mail.gmail.com>
Subject: Re: [PATCH v1] PM: Rearrange documentation related to __pm_runtime_disable()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Feb 2025 at 21:03, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> There are only two callers of __pm_runtime_disable(), one of which is
> device_suspend_late() and the other is pm_runtime_disable() that has
> its own kerneldoc comment and there are no plans to add any more of
> them.  Since they use different values of the __pm_runtime_disable()
> second parameter, the actual code behavior is different in each case,
> but it is all documented in the __pm_runtime_disable() kerneldoc comment
> which is not particularly straightforward.
>
> For this reason, move the information from the __pm_runtime_disable()
> kerneldoc comment to the pm_runtime_disable() one and into a separate
> comment in device_suspend_late() and remove the __pm_runtime_disable()
> kerneldoc comment altogether.
>
> No functional impact.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Much better!

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/main.c    |    4 ++++
>  drivers/base/power/runtime.c |   14 --------------
>  include/linux/pm_runtime.h   |   15 +++++++++++----
>  3 files changed, 15 insertions(+), 18 deletions(-)
>
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1404,6 +1404,10 @@
>         TRACE_DEVICE(dev);
>         TRACE_SUSPEND(0);
>
> +       /*
> +        * Disable runtime PM for the device without checking if there is a
> +        * pending resume request for it.
> +        */
>         __pm_runtime_disable(dev, false);
>
>         dpm_wait_for_subordinate(dev, async);
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1460,20 +1460,6 @@
>  }
>  EXPORT_SYMBOL_GPL(pm_runtime_barrier);
>
> -/**
> - * __pm_runtime_disable - Disable runtime PM of a device.
> - * @dev: Device to handle.
> - * @check_resume: If set, check if there's a resume request for the device.
> - *
> - * Increment power.disable_depth for the device and if it was zero previously,
> - * cancel all pending runtime PM requests for the device and wait for all
> - * operations in progress to complete.  The device can be either active or
> - * suspended after its runtime PM has been disabled.
> - *
> - * If @check_resume is set and there's a resume request pending when
> - * __pm_runtime_disable() is called and power.disable_depth is zero, the
> - * function will wake up the device before disabling its runtime PM.
> - */
>  void __pm_runtime_disable(struct device *dev, bool check_resume)
>  {
>         spin_lock_irq(&dev->power.lock);
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -556,11 +556,18 @@
>   * pm_runtime_disable - Disable runtime PM for a device.
>   * @dev: Target device.
>   *
> - * Prevent the runtime PM framework from working with @dev (by incrementing its
> - * "blocking" counter).
> + * Prevent the runtime PM framework from working with @dev by incrementing its
> + * "disable" counter.
>   *
> - * For each invocation of this function for @dev there must be a matching
> - * pm_runtime_enable() call in order for runtime PM to be enabled for it.
> + * If the counter is zero when this function runs and there is a pending runtime
> + * resume request for @dev, it will be resumed.  If the counter is still zero at
> + * that point, all of the pending runtime PM requests for @dev will be canceled
> + * and all runtime PM operations in progress involving it will be waited for to
> + * complete.
> + *
> + * For each invocation of this function for @dev, there must be a matching
> + * pm_runtime_enable() call, so that runtime PM is eventually enabled for it
> + * again.
>   */
>  static inline void pm_runtime_disable(struct device *dev)
>  {
>
>
>

