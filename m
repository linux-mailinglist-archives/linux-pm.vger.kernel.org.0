Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E694465AB
	for <lists+linux-pm@lfdr.de>; Fri,  5 Nov 2021 16:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbhKEP2v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Nov 2021 11:28:51 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:43663 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbhKEP2v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Nov 2021 11:28:51 -0400
Received: by mail-ot1-f50.google.com with SMTP id i16-20020a9d68d0000000b0055c630be045so2874413oto.10;
        Fri, 05 Nov 2021 08:26:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VolqG6iT6Es5wUByf/mLtFzx+VhtW6F9KF9MQ/rKoqI=;
        b=vOmq8bDadmU9CjEQsqp+uKaDiEtelsO6mBqDL/nAjTsCxDM1wAKT8x1w2q/rCY/PY+
         5DEI46KLKLhNw51dUxk9P+So3ipDo62T6q6prx4wTA/RbSxoNtl2vIPMwetuIjSKOtRZ
         cQvdCOvJyuNw9kb7PXiR82CYXqDi0GmO5T+BG+t5zDgMRhZpadaRl4QZCrUx4Ub1ry9z
         QCMQNlLIN9Ylp46AZjDOizkAdOF2nw1A9EhY9TkIGlTKjrc2swxHNpGjjxVT4R2jENi5
         SlvrBf4y87Y+AdOlVqhXKEiWUC5oGBuIbnZKqnJOyIQR9uVaeryi+IEeHq8B8IpFM2CM
         st8Q==
X-Gm-Message-State: AOAM533rbwFPbm+6Atw4KG5MZitnlNhFYxpCv8uVME+65Kz3hS3FzdtT
        SIm7N3K6Ixrj5aeLX/ZMAkQlPniyTAun0Y8uAFY=
X-Google-Smtp-Source: ABdhPJypvx8sZWS8lnJDvr8ZN8tl3/uLyAd1NwQrHn2B5aU6eipXzWkuOXlJzB+YR82NF4YQXUYJveljsf/ZZPRWmWQ=
X-Received: by 2002:a05:6830:3484:: with SMTP id c4mr28549720otu.254.1636125971459;
 Fri, 05 Nov 2021 08:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <20211029215256.20329-1-julianbraha@gmail.com>
In-Reply-To: <20211029215256.20329-1-julianbraha@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 5 Nov 2021 16:26:00 +0100
Message-ID: <CAJZ5v0iGU5UHvZrwk4wuRNQhfJYj=HyTm=3cj8+1UyCa6dwwGw@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: fix unmet dependencies on ARCH_SUSPEND_POSSIBLE
 for ARM_CPU_SUSPEND
To:     Julian Braha <julianbraha@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 29, 2021 at 11:52 PM Julian Braha <julianbraha@gmail.com> wrote:
>
> When ARM_TEGRA_CPUIDLE or ARM_QCOM_SPM_CPUIDLE are selected,
> and ARCH_SUSPEND_POSSIBLE is disabled, Kbuild gives the
> following warnings:
>
> WARNING: unmet direct dependencies detected for ARM_CPU_SUSPEND
>   Depends on [n]: ARCH_SUSPEND_POSSIBLE [=n]
>   Selected by [y]:
>   - ARM_TEGRA_CPUIDLE [=y] && CPU_IDLE [=y] && (ARM [=y] || ARM64) && (ARCH_TEGRA [=n] || COMPILE_TEST [=y]) && !ARM64 && MMU [=y]
>
> and
>
> WARNING: unmet direct dependencies detected for ARM_CPU_SUSPEND
>   Depends on [n]: ARCH_SUSPEND_POSSIBLE [=n]
>   Selected by [y]:
>   - ARM_QCOM_SPM_CPUIDLE [=y] && CPU_IDLE [=y] && (ARM [=y] || ARM64) && (ARCH_QCOM [=n] || COMPILE_TEST [=y]) && !ARM64 && MMU [=y]
>
> This is because these options enable ARM_CPU_SUSPEND
> without selecting or depending on ARCH_SUSPEND_POSSIBLE,
> despite ARM_CPU_SUSPEND depending on ARCH_SUSPEND_POSSIBLE.
>
> These unmet dependency bugs were detected by Kismet,
> a static analysis tool for Kconfig. Please advise if
> this is not the appropriate solution.

The changes make sense to me, but I need the maintainers of the two
affected platforms to tell me that this is OK.

> Signed-off-by: Julian Braha <julianbraha@gmail.com>
> ---
>  drivers/cpuidle/Kconfig.arm | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
> index 15d6c46c0a47..1b4f5ae1ee05 100644
> --- a/drivers/cpuidle/Kconfig.arm
> +++ b/drivers/cpuidle/Kconfig.arm
> @@ -100,6 +100,7 @@ config ARM_MVEBU_V7_CPUIDLE
>  config ARM_TEGRA_CPUIDLE
>         bool "CPU Idle Driver for NVIDIA Tegra SoCs"
>         depends on (ARCH_TEGRA || COMPILE_TEST) && !ARM64 && MMU
> +       depends on ARCH_SUSPEND_POSSIBLE
>         select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
>         select ARM_CPU_SUSPEND
>         help
> @@ -108,6 +109,7 @@ config ARM_TEGRA_CPUIDLE
>  config ARM_QCOM_SPM_CPUIDLE
>         bool "CPU Idle Driver for Qualcomm Subsystem Power Manager (SPM)"
>         depends on (ARCH_QCOM || COMPILE_TEST) && !ARM64 && MMU
> +       depends on ARCH_SUSPEND_POSSIBLE
>         select ARM_CPU_SUSPEND
>         select CPU_IDLE_MULTIPLE_DRIVERS
>         select DT_IDLE_STATES
> --
> 2.30.2
>
