Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA7A93A0071
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jun 2021 20:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235417AbhFHSnW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Jun 2021 14:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235102AbhFHSlT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Jun 2021 14:41:19 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77182C061224
        for <linux-pm@vger.kernel.org>; Tue,  8 Jun 2021 11:39:14 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id p17so32897839lfc.6
        for <linux-pm@vger.kernel.org>; Tue, 08 Jun 2021 11:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RFVHIAFVezn4A//yU0olDz7nXpJepZN2+RpU9TzzyE8=;
        b=pLX4yrmrJ0rUVnKzsKkQ81cTKwTGWP2ONwJS+KHNRS89xxBiyB9MgfAjB86RnAT/Hk
         Tk9YXvOafQ9vrGquEY5afAb6ZJVNQfCN9PtLNt7UuAv+nOahJtWqQBqX3sZrGVpHs8Lf
         EL4D1BDwIKGForCI1dRNmMgqAJY1yw7Y0syMyClHOIQ4j1dVbVW6qMXHzQKLzUt6wUV+
         fubtP6LfDplz66FfEuMuQIwBCWAPHaJtlF5tZ/bPtAFUKFdfAJx/vbuveJ63671EtKeg
         vNbwDbFy0UN+xu82/bT9McIXfWX4QTaZBqQFrHMk199Nwyr0Td4t9+GDLdAf2Lyn9LZM
         i8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RFVHIAFVezn4A//yU0olDz7nXpJepZN2+RpU9TzzyE8=;
        b=GdPQXp3nGLv1QA1TfZzkLrQ44uE2L2g64KdseDolZuxuPv4tyn944xWXslDMo3z4Jt
         FzRzgDvVXeSDKIk6btmM9gZVKQWxcFbeZUYxS84PnDkpNb7eS7tb/MNG80jnHhELmC/B
         f+nOCxeStyXtedO5+BqHwKfYuumU2RJTzcH4X5/k2MDJutVNSAgrV/dz4Xzx9o5a80Dr
         p80tjSHkKO4PjTN7202oDoVQAeTowYPT+FAsUREsxbbWd1NMjdjWVTZUbXq6t3KqTZfp
         g8JStrAA3gCuYVJHOFKJIyofHqXZW8tqOawjMWhwDnKuBGT3KZ8nFM8T0ywDSTvj7lCd
         ZmJg==
X-Gm-Message-State: AOAM531z0JGzapg/ISlsUcLzxBPE0u2fvU4jYRbxkCsO8t4Wwd9m5uES
        dd60rAaMAppuPHJjS4vW3yUbFfp8fngT1QQW1Sk9yA==
X-Google-Smtp-Source: ABdhPJwSkum5TLbm5F7gzs0qrnq/SuixhE2KyLKYeHZQ7LcH11gymZk7UDXcOBrGLp4Svy45uPgtiw0LT083xIgQJuY=
X-Received: by 2002:a19:4843:: with SMTP id v64mr6200836lfa.374.1623177552600;
 Tue, 08 Jun 2021 11:39:12 -0700 (PDT)
MIME-Version: 1.0
References: <1623145562-111662-1-git-send-email-yang.lee@linux.alibaba.com>
In-Reply-To: <1623145562-111662-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 8 Jun 2021 11:39:01 -0700
Message-ID: <CAKwvOdmyXV09ZxcDqQ6x43f+Eze4h40W2AoKcCmUhGM2gUWsnQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: devfreq_cooling: Fix kernel-doc
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, amitk@kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 8, 2021 at 2:46 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Fix function name in devfreq_cooling.c kernel-doc comment
> to remove a warning found by clang(make W=1 LLVM=1).
>
> drivers/thermal/devfreq_cooling.c:479: warning: expecting prototype for
> devfreq_cooling_em_register_power(). Prototype was for
> devfreq_cooling_em_register() instead.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

That compiler warning doesn't come from kernel-doc.  Your diff looks
good (the comment was wrong), but the commit message is curious.

Usually that warning is from when the function prototype does not
exist for a function with extern linkage.  It looks like that's always
provided though in include/linux/devfreq_cooling.h.  Can you share a
link to the original report?

> ---
>  drivers/thermal/devfreq_cooling.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
> index 3a788ac..5a86cff 100644
> --- a/drivers/thermal/devfreq_cooling.c
> +++ b/drivers/thermal/devfreq_cooling.c
> @@ -458,7 +458,7 @@ struct thermal_cooling_device *devfreq_cooling_register(struct devfreq *df)
>  EXPORT_SYMBOL_GPL(devfreq_cooling_register);
>
>  /**
> - * devfreq_cooling_em_register_power() - Register devfreq cooling device with
> + * devfreq_cooling_em_register() - Register devfreq cooling device with
>   *             power information and automatically register Energy Model (EM)
>   * @df:                Pointer to devfreq device.
>   * @dfc_power: Pointer to devfreq_cooling_power.
> --
> 1.8.3.1
>


-- 
Thanks,
~Nick Desaulniers
