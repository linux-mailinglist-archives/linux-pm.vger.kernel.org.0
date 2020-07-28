Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B55C23019F
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jul 2020 07:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgG1FS5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Jul 2020 01:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbgG1FS5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jul 2020 01:18:57 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E530AC061794
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2020 22:18:56 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id s16so4494425ljc.8
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2020 22:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d1pd5Ywk2E8HpE6EvWe6h4xJCwbfyBvC8wvu4GCwgTc=;
        b=vwhLvdoDLId6QUIm/pfUHA8PLqtigEfyJILQw06iOj5ltFtWqjTQf3H0t/V5YIhTB6
         J+Gz86sheq3Sa0NGSWhimwXJMFB/306yZolRJVFg1ZETtRM3I0Fyhw2FFu1kYGI3dayD
         VWKrgctr3nesPgqcxAdagIsrPgv+RWAzr5ukajRMI5dNj+xjKSaIZZOvCI2ByARQtAaP
         MK4FW61s4GZENT8cMWGcTmKB28ouEjc4XJV1bYQ3aEFBU6qPd4zUg65+DLWIFwNuvumP
         Xbmz0Q9kPrkyU0txfH2BcbHCY4clATw0eewVMPj6yDgDZUarJV2GryQhqTdSsLaPYeFH
         j4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d1pd5Ywk2E8HpE6EvWe6h4xJCwbfyBvC8wvu4GCwgTc=;
        b=dBkLxf5FqkugsAxp99FXGc88ZVoJEV367Dzoz8DEzaK/cJKkiFuarHRMObWuTchyWh
         OrCQr8om2whO3hFBjwWSfMDUXMszbGplWbTecIkB+IuKZ7tQJlFc7XDUlJsJLgv1yHTz
         3XeXNoKoKQJ9pPeGA3LmupwvUj2eB/XYqr58PFEfoPN200tLwAzZXbJ7l2uUpGvVGISm
         zMQFooSyFRvdjI1oSQfTCKZDxAGj0dAOJVtYmPl1uBysyqHCDeBm+A3OD7weW5BfthSl
         uCL5xA1oWMMzxF7HnZNMzvDTrF8aByITg0JRcEkcOQOWpJw3BQv5xgP/VjnvNUmzIVeq
         U43Q==
X-Gm-Message-State: AOAM533cXmsuEm8F0tkJWKu2mEnhs3o3zknCnLpFRqhO/ecu6gj226LR
        f5Zu4wpaRPRZNGKUVmK+yEBo4pEftw+m7+V7SdN619UK
X-Google-Smtp-Source: ABdhPJzSYrDhaJpzXv16ums83hk6dVdGlg4CP0Gv+W41Qo65lNfEPpZ0kfi4n0+Razbkcf25fTn7mz+8RImZtZjXKxY=
X-Received: by 2002:a05:651c:1048:: with SMTP id x8mr11224019ljm.346.1595913535104;
 Mon, 27 Jul 2020 22:18:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200728045850.22661-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20200728045850.22661-1-lukas.bulwahn@gmail.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 28 Jul 2020 10:48:43 +0530
Message-ID: <CAP245DW1gY8sbFYxmZdAT_zC4GxT8mSmA8Zwpz28KFhe++e_7A@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update entry to thermal governors file name prefixing
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 28, 2020 at 10:29 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Commit 0015d9a2a727 ("thermal/governors: Prefix all source files with
> gov_") renamed power_allocator.c to gov_power_allocator.c in
> ./drivers/thermal amongst some other file renames, but missed to adjust
> the MAINTAINERS entry.
>
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:
>
>   warning: no file matches    F:    drivers/thermal/power_allocator.c
>
> Update the file entry in MAINTAINERS to the new file name.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Acked-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
> Amit, please ack.
>
> Daniel, please pick this non-urgent minor patch for your -next tree.
>
> applies cleanly on next-20200727
>
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aad65cc8f35d..aa5a11d71f71 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17164,7 +17164,7 @@ M:      Lukasz Luba <lukasz.luba@arm.com>
>  L:     linux-pm@vger.kernel.org
>  S:     Maintained
>  F:     Documentation/driver-api/thermal/power_allocator.rst
> -F:     drivers/thermal/power_allocator.c
> +F:     drivers/thermal/gov_power_allocator.c
>  F:     include/trace/events/thermal_power_allocator.h
>
>  THINKPAD ACPI EXTRAS DRIVER
> --
> 2.17.1
>
