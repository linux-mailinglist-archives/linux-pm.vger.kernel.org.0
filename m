Return-Path: <linux-pm+bounces-33819-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E004B43711
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 11:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDB631C26E87
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 09:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B402F39DA;
	Thu,  4 Sep 2025 09:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ccGcI1Y/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7633D2F39CF
	for <linux-pm@vger.kernel.org>; Thu,  4 Sep 2025 09:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756978040; cv=none; b=N9idS7WYCk9XOHBRtve/c1FkzeaafohBDe75WHd65fUCFJXW6ZyJE7hCzcg/e+ZXGEBnwb3DIMpFXfX+7hEQFIDjBVMJOaYBuV/xvgV/3UXER7hlBXXoYPgNjFMvIf2t9XdYla8E336jpEV4lVaSOhEJfg3mvu3o7Lc6pSEezTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756978040; c=relaxed/simple;
	bh=m5V5yAwlWcGivcep1LpLjkL/uYuPtGhniYz5NzNVLMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=huFS60xEI2KNSioqyPkKNR6taXE8F+lX+uZZG9AWu3KwLVK2/UEzPAAgDJ039J3sYSc/soK9MAbCrul0qg6wCBMqs3ecfSoD6FCsbHsRkKikkPtBzFeYeEzygINvBT9Y3RILYgqSNupk8AcqsYAngVO/4MxcqMk84Jk7dwuSVMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ccGcI1Y/; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71d6059f490so8133137b3.3
        for <linux-pm@vger.kernel.org>; Thu, 04 Sep 2025 02:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756978037; x=1757582837; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zbvmmOuLIUDxZp1MnPrPCU4uMrAUR6dmAfh6E5KAke8=;
        b=ccGcI1Y/Un3550mew1hvH8pPUzIoh4BPibwfJKYGfNrkx6jxatssq6oLXMKJy4efLJ
         wDmHjW/C4Wnfh0H0IDNXNI1w0Q5Gxcw06i7xfJJF+PYKUGANc3HoZX/Z9KRvhdqe0D8x
         gFO0VJo1+IWr+w5bfg8MY2z9wX+QIYHgNgq8NmYj6VNK+3bc+EDQBPU4+qu29nwY+d6O
         pcgL9RFaucesRuHVHOgrNUnjqflECm4apjVX2aT3y/s28w2Jz50f3B9yODgMXDyp/drj
         tdEbe8mFAGYS+vK25Xm0myGc75dmmuJmAnBBZCBUhcGPnTi4AyPPWRkYhYnjFXslSwQN
         p62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756978037; x=1757582837;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zbvmmOuLIUDxZp1MnPrPCU4uMrAUR6dmAfh6E5KAke8=;
        b=ozlfoGmtLVdMKUASUwYECRLMa3PjcNqDnlEXU2jF3DkzB6p5tSCm7bM8x2X3G9IZVk
         vqbQX8aHb07X6MFH2ncA6SHMxwFkF88skFJzgqUou8MoV243rzV3CDu5Ii2cBvATq2Q0
         oKLwcLN+sUpPSyohg9Ken8iCQGGIwX5KheML9ofiUKfSSdCn4TVKY+pki2A4fHAJZ3jF
         ET02+RFen1c2Ok4zCIdCrHtbpfaOl7+DkFg69hGDffZrTRESa+LRpcRYHutAy2DgO33o
         RXeOGgQTOIZ3fopKc0TRwva9bqIfT4bkGQBLcRsriKaNuArsjGjsXfBJEeuhyNNRN8KP
         338A==
X-Gm-Message-State: AOJu0YxW6HdadAsIOKzSa1J9Jmfb69ti8h5EWP6Lk2DYtc3ifAMNQySW
	x1Pn8W3nJ0MFx4YBAO4Gxs2pdIG6myi3gFOw1DJlN0unKjfDs/FHEVtZWmuulfc1+qEj0foxJdW
	XFNTycwm9htwM1eVYC2WMcoG9/k5FuCBOUXZUkt/ivg==
X-Gm-Gg: ASbGnctGDkUrAuEJmfisywshg5BF5oSoljEVc62YnqqaHmfOz/anMQhs0UToD9N/YR2
	8ca07RYCZdebADaF45Wix6H6ZIdl3o3Ymf0W26H8TUqV9jcK7+bB0mWNOQnN7svBL0rhqnwHeJg
	uheBKCPJUcTtbEYTC748ekB1neJY+OWwNr/g1Hwi0c5S+tA7mPgb0X9KFdhLzUCrJuKXJx7t1O5
	4Ac/oPikuTP6sldbhM=
X-Google-Smtp-Source: AGHT+IHdZ4C9gIy76k2TL/mh0J4/RFSZEnngxhmBLw1tI+NSOUEGkIf8VYX6cpMLBIYdOMj5QaxWJXdV3lal6fJnTwg=
X-Received: by 2002:a05:690e:4308:b0:5fe:1b7d:8cb7 with SMTP id
 956f58d0204a3-601755b4dfcmr1559312d50.5.1756978037354; Thu, 04 Sep 2025
 02:27:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3381776.aeNJFYEL58@rafael.j.wysocki>
In-Reply-To: <3381776.aeNJFYEL58@rafael.j.wysocki>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 4 Sep 2025 11:26:41 +0200
X-Gm-Features: Ac12FXy9xOgdN1mtLPkFLfyCSrw6qK2l4IQFU4QEEm513md6_ixyqso-UEzQQi4
Message-ID: <CAPDyKFqk343jLYL=x=+7VcUAG_n9xVs8ZhB8x1mytYmm8C8h3g@mail.gmail.com>
Subject: Re: [PATCH v1] PM: sleep: core: Clear power.must_resume in noirq
 suspend error path
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Sept 2025 at 15:55, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> If system suspend is aborted in the "noirq" phase (for instance, due to
> an error returned by one of the device callbacks), power.is_noirq_suspended
> will not be set for some devices and device_resume_noirq() will return
> early for them.  Consequently, noirq resume callbacks will not run for
> them at all because the noirq suspend callbacks have not run for them
> yet.
>
> If any of them has power.must_resume set and late suspend has been
> skipped for it (due to power.smart_suspend), early resume should be
> skipped for it either, or its state may become inconsistent (for
> instance, if the early resume assumes that it will always follow
> noirq resume).
>
> Make that happen by clearing power.must_resume in device_resume_noirq()
> for devices with power.is_noirq_suspended clear that have been left in
> suspend by device_suspend_late(), which will subsequently cause
> device_resume_early() to leave the device in suspend and avoid
> changing its state.
>
> Fixes: 0d4b54c6fee8 ("PM / core: Add LEAVE_SUSPENDED driver flag")
> Link: https://lore.kernel.org/linux-pm/5d692b81-6f58-4e86-9cb0-ede69a09d799@rowland.harvard.edu/
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/main.c |   14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -720,8 +720,20 @@
>         if (dev->power.syscore || dev->power.direct_complete)
>                 goto Out;
>
> -       if (!dev->power.is_noirq_suspended)
> +       if (!dev->power.is_noirq_suspended) {
> +               /*
> +                * This means that system suspend has been aborted in the noirq
> +                * phase before invoking the noirq suspend callback for the
> +                * device, so if device_suspend_late() has left it in suspend,
> +                * device_resume_early() should leave it in suspend either in
> +                * case the early resume of it depends on the noirq resume that
> +                * has not run.
> +                */
> +               if (dev_pm_skip_suspend(dev))
> +                       dev->power.must_resume = false;
> +
>                 goto Out;
> +       }
>
>         if (!dpm_wait_for_superior(dev, async))
>                 goto Out;
>
>
>

