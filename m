Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA2C1F9546
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jun 2020 13:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbgFOLZk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jun 2020 07:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729680AbgFOLZi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2020 07:25:38 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47647C05BD43
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2020 04:25:38 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id x14so1971793uao.7
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2020 04:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vrKmkhg+c1u0kB4U6Q0PfBV1XmTvqqdQ8hWTNkN5v2k=;
        b=XIIEk3jhhCjnXxJTApUX1KsztsSHxmkhzNIzJiVbqEHf7zAn0F9ATFYCTcxehIn7Db
         PSo6AK16Dk/Mq2bHaFCNXJPKhXFfIyKWlZ64UGJVCrZI5POsNEiNmiXtK4/nrUoQyxE7
         QHFnkyTx7Mf1Cjrktsn7BMYv521Nzaa/sKvQWydv/s1Sx4G5vEEGEzjGrqvH0ubiDc45
         oBYNVXzgJF6M5MhYQLfXHAaZnaB+ow+dxNe5MRjqhZkkny1Gytj8LuYB8sxhWldVtsrz
         jrDMHgw3N8/IG4Ozcd3vnUA3fApwh05lTSBFjbz5aKHtOvycqlLUQb87pFCTW7Ocp/gA
         +uhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vrKmkhg+c1u0kB4U6Q0PfBV1XmTvqqdQ8hWTNkN5v2k=;
        b=DMtP34e+Pex2sqeTk95FNFFUT1vi1vU5x2hMaUqk0RAM/xHJloq/y0tDFGk4dtBA3b
         oTeebmN6vMdVMHLjd3HYd7y7hAuQSOiR6UN1bPmIUJeRRp7COEmVNvineSBgdE5R2C4N
         g0stAnEUfjwcpyFAQbZPNQOTNJhL2aaU/uCdLehYYjFiXtif3Nn77K8pYj37T2udIbNc
         EWTxIySUv2aulHW/+euDgMM15tGRf+LUPZ+0xz46+OgK3c6noTd+s6H/wxne0JqgExvD
         6tFDiffJcMsLtlyL9HWsbxkMUj10oKa2Ux7EBbNN71hXwK64hDhYMgglyWTwaPoLruX2
         jwYw==
X-Gm-Message-State: AOAM5320wieX2OhRQ292FbiZD/zYIXLd/quuEh5nzHrTB6pq79TU92Kb
        etCTzttrsz3K2OLugy0Gh0GVO9YVY4857w9D17Q3SA==
X-Google-Smtp-Source: ABdhPJzqNGqsG+5owbRVG/KlqJGvlwwJKZq02aq94CP4ikq3550XKb+IM6Rhtt+J/C/aq6FLjSiLs0/JETpwhEPnOTc=
X-Received: by 2002:a9f:22e1:: with SMTP id 88mr18170672uan.19.1592220336997;
 Mon, 15 Jun 2020 04:25:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200429103644.5492-1-daniel.lezcano@linaro.org> <20200429103644.5492-4-daniel.lezcano@linaro.org>
In-Reply-To: <20200429103644.5492-4-daniel.lezcano@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 15 Jun 2020 13:25:00 +0200
Message-ID: <CAPDyKFrdzcf5e98EM0VvwxnR0zDFQ851PDLOZ9wpe-LO6n4Abw@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] thermal: cpuidle: Register cpuidle cooling device
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>, lukasz.luba@arm.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "open list:CPU IDLE TIME MANAGEMENT FRAMEWORK" 
        <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CPUIDLE DRIVER - ARM PSCI" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 29 Apr 2020 at 12:37, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> The cpuidle driver can be used as a cooling device by injecting idle
> cycles. The DT binding for the idle state added an optional
>
> When the property is set, register the cpuidle driver with the idle
> state node pointer as a cooling device. The thermal framework will do
> the association automatically with the thermal zone via the
> cooling-device defined in the device tree cooling-maps section.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  - V4:
>    - Do not check the return value as the function does no longer return one
> ---
>  drivers/cpuidle/cpuidle-arm.c  | 3 +++
>  drivers/cpuidle/cpuidle-psci.c | 3 +++
>  2 files changed, 6 insertions(+)
>
> diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
> index 9e5156d39627..8c758920d699 100644
> --- a/drivers/cpuidle/cpuidle-arm.c
> +++ b/drivers/cpuidle/cpuidle-arm.c
> @@ -8,6 +8,7 @@
>
>  #define pr_fmt(fmt) "CPUidle arm: " fmt
>
> +#include <linux/cpu_cooling.h>
>  #include <linux/cpuidle.h>
>  #include <linux/cpumask.h>
>  #include <linux/cpu_pm.h>
> @@ -124,6 +125,8 @@ static int __init arm_idle_init_cpu(int cpu)
>         if (ret)
>                 goto out_kfree_drv;
>
> +       cpuidle_cooling_register(drv);
> +
>         return 0;
>
>  out_kfree_drv:
> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> index bae9140a65a5..1f38e0dfc9b2 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -9,6 +9,7 @@
>  #define pr_fmt(fmt) "CPUidle PSCI: " fmt
>
>  #include <linux/cpuhotplug.h>
> +#include <linux/cpu_cooling.h>
>  #include <linux/cpuidle.h>
>  #include <linux/cpumask.h>
>  #include <linux/cpu_pm.h>
> @@ -313,6 +314,8 @@ static int __init psci_idle_init_cpu(int cpu)
>         if (ret)
>                 goto out_kfree_drv;
>
> +       cpuidle_cooling_register(drv);
> +

Apologies for the late reply, but just noticed this change in v5.8-rc1.

Don't you need a cpuidle_cooling_unregister function? For example,
cpuidle-psci may fail and then calls cpuidle_unregister() to cleans up
things.

Is that okay?

Kind regards
Uffe
