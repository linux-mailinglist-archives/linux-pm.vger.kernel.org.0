Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA1E530A519
	for <lists+linux-pm@lfdr.de>; Mon,  1 Feb 2021 11:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbhBAKLe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Feb 2021 05:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbhBAKJo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Feb 2021 05:09:44 -0500
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91907C061574
        for <linux-pm@vger.kernel.org>; Mon,  1 Feb 2021 02:09:00 -0800 (PST)
Received: by mail-vk1-xa30.google.com with SMTP id d23so3795959vkf.3
        for <linux-pm@vger.kernel.org>; Mon, 01 Feb 2021 02:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5RCKOWm6pdB8AyLaZ0Rrsns+97YnjtL19FObq56DbaM=;
        b=hPfR1AoYfcZiquipnmCfwNJAFvIf1NCLc3oWmyR4JBbMm9cfaaqKofbLeW24XvyrFN
         08iYvetlEL5zdwk1RVPPgm91a++QLVKTSk/uld/01q5XYQBO/5j7ZmquzfM3Uy2b5SJn
         t6zXEHIDtdMYUEyE1uQ2Lf9Xi3B9m2jcLEVlnyEshKdPSB9rZmBoEfaHO2NG58NcbMB9
         6OqWPPxbaQbjJUF9612tp74+bc8cACHCZlpNgK8Xr9eEJ1ollkRLKES0KjN/KkdyFud+
         Qc7aBBIpo1RE8y0nwVgLEJ1InHBsMjMDoUlUmotjAXIqRR7KOsxxpxoOEAYubxFW0mfD
         rT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5RCKOWm6pdB8AyLaZ0Rrsns+97YnjtL19FObq56DbaM=;
        b=U7v1DkrNBPMk0y1/QvljnmTGhWayf9/87q44PVjvZNYncmlZAwG3NgLw5zGeFwoqrF
         YMya2B8WbnhKVb6b0RNPVEdz9mVvVpcJ6l35cV/ULtiXqa1xC7+fe/ZfVMIxxCCu4Z5H
         gtsq/8xOOGKjKdu4J+Nd3Ytr14ClBPDvWx8fINFogE8h59hX2hRT55HCFjLzux0m/fJ6
         I7COLP8fD6yuIDwmZbGA+g6rDP4ANrqPH9CkCmBZstL0Gv05WnmCvIk7KJgRNk9FfOXs
         oU1q7wsW/KThnDPYwfPN7RKrYG83au1p7x5+XetRt0Q50OrrZsHPSsB8mPOvKZfaGcag
         NsYw==
X-Gm-Message-State: AOAM5304QNfWwLfht7GS38353P+nx34I3r8GOOT3VgE5ycasw6mVKMaS
        As1/aZ70KttKSbpdWVGWW9kwrtn+Ys/xEbxWYldaGw==
X-Google-Smtp-Source: ABdhPJxYwhN75hYopsWmLZymShiPcRCVhsChLIuB0H9arKcqRntfRfpFWLrXLTfGCy8ufTg4kWsEh0Tpno9oy18wvMY=
X-Received: by 2002:a1f:9d87:: with SMTP id g129mr8389213vke.7.1612174139684;
 Mon, 01 Feb 2021 02:08:59 -0800 (PST)
MIME-Version: 1.0
References: <1611736925-32547-1-git-send-email-abaci-bugfix@linux.alibaba.com>
In-Reply-To: <1611736925-32547-1-git-send-email-abaci-bugfix@linux.alibaba.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 1 Feb 2021 11:08:22 +0100
Message-ID: <CAPDyKFrtwFwPjLz7OYOtF4S7WORoyGFgpv9n6xABn-vp3w59dQ@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: Simplify the calculation of variables
To:     Abaci Team <abaci-bugfix@linux.alibaba.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 27 Jan 2021 at 09:42, Abaci Team <abaci-bugfix@linux.alibaba.com> wrote:
>
> Fix the following coccicheck warnings:
>
> ./drivers/base/power/domain.c:938:31-33: WARNING !A || A && B is
> equivalent to !A || B.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Suggested-by: Jiapeng Zhong <oswb@linux.alibaba.com>
> Signed-off-by: Abaci Team <abaci-bugfix@linux.alibaba.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/domain.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 9a14eed..e689710 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -934,8 +934,7 @@ static int genpd_runtime_resume(struct device *dev)
>  err_stop:
>         genpd_stop_dev(genpd, dev);
>  err_poweroff:
> -       if (!pm_runtime_is_irq_safe(dev) ||
> -               (pm_runtime_is_irq_safe(dev) && genpd_is_irq_safe(genpd))) {
> +       if (!pm_runtime_is_irq_safe(dev) || genpd_is_irq_safe(genpd)) {
>                 genpd_lock(genpd);
>                 genpd_power_off(genpd, true, 0);
>                 genpd_unlock(genpd);
> --
> 1.8.3.1
>
