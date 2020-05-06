Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A4A1C6DD1
	for <lists+linux-pm@lfdr.de>; Wed,  6 May 2020 11:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbgEFJ5s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 May 2020 05:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729298AbgEFJ5r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 May 2020 05:57:47 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29E8C061A10
        for <linux-pm@vger.kernel.org>; Wed,  6 May 2020 02:57:46 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id 1so608546vsl.9
        for <linux-pm@vger.kernel.org>; Wed, 06 May 2020 02:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cLVRESBoKPDQJtZ+ThuiAcYI3TdQCvmpu5N5ap/84vg=;
        b=QvHcHNJv4TLk4yeHfEs21Cb+swsgc5BqyQVaDr8vGh+oOkIyjdNVK6vBnsXKt1Ro9p
         lrbWbY9rsYAi6JYMsF181p9daiS8QWD+IGymftoG3EZHH7QOWQ8B704TB8nGmamk5N0/
         UcjaM/2y/cqADBsPMReZoS3BUAf7j50WZZo6mRAVi2C3JyeTqzjhgNLISHmn+Wi7wSZ9
         DmFgpjYKj+Iq8cdZyHzkwPUNn9cl+6zFjGKtkD2UE4xcQ70GFSHB9M1QyCPFzHABYV57
         ZnRi4yBgQdUQelQh1HBHv32p1LwaKnuyUf7AfoAPkacmfXnsltTrRNejAN8HBeSPOuaF
         5Eyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cLVRESBoKPDQJtZ+ThuiAcYI3TdQCvmpu5N5ap/84vg=;
        b=KQeA/acCXbipZQRJvUoT2sD3KwtjvWzCzUDGon8rr1a88nEUDtAQnGaVzAbAOtO/ye
         29QadGoZ+YpxHesRxkIhRQghOwavI3bSjZ40Ujl48lzxzIxx2KUnynagkD/78pAL07Tn
         22F5csheWTj9bg9AWKLtamHle41XW3137ezguUbjd4M4zxNS3x/9nValwThf0ccMOfSi
         /cFrfY6TJx976dkIrbrLaYTYrfG6QhjDhgm+/Xgwo0cdLA/BPcNxNDwtX0I3DYkahCE+
         pcw4Qq4yT47ZnSRZakZAVoudSveHOCDI3eDA/E9UErhPVVYDdpzKvjBBf5J4DAyEe6bg
         LoeA==
X-Gm-Message-State: AGi0Pub3bYrPGCpuIphWcnH/VZwMT6rmtt7wmjSG0i8U4TZDWRPlv5w+
        zy59rWO5K9ml/hf/QsBcwXExEk0YBmJnEsSRJKNKEcqbvto=
X-Google-Smtp-Source: APiQypKLOZf+1q8lOTy5vDVF1evQNddQakrlqUF5XgociHzpoFintL/zhnSsv06HVF3oEHG2Eb1/X7JPOcMW2F7Qklo=
X-Received: by 2002:a05:6102:407:: with SMTP id d7mr6020126vsq.159.1588759065941;
 Wed, 06 May 2020 02:57:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200429103644.5492-1-daniel.lezcano@linaro.org> <20200429103644.5492-4-daniel.lezcano@linaro.org>
In-Reply-To: <20200429103644.5492-4-daniel.lezcano@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 6 May 2020 15:27:10 +0530
Message-ID: <CAHLCerPJkwi9o5p6UheC+bkdkSYu1fZu5jjWrOjWeSk8+R75ZQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] thermal: cpuidle: Register cpuidle cooling device
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
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

On Wed, Apr 29, 2020 at 4:07 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The cpuidle driver can be used as a cooling device by injecting idle
> cycles. The DT binding for the idle state added an optional

Incomplete sentence.

> When the property is set, register the cpuidle driver with the idle
> state node pointer as a cooling device. The thermal framework will do
> the association automatically with the thermal zone via the
> cooling-device defined in the device tree cooling-maps section.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Conditionally,

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>


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
>         return 0;
>
>  out_kfree_drv:
> --
> 2.17.1
>
