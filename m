Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C134539FC
	for <lists+linux-pm@lfdr.de>; Tue, 16 Nov 2021 20:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239928AbhKPTVE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Nov 2021 14:21:04 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:45880 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239898AbhKPTVB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Nov 2021 14:21:01 -0500
Received: by mail-oi1-f177.google.com with SMTP id 7so662623oip.12;
        Tue, 16 Nov 2021 11:18:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TTvFtjePqYy8/bWJfKa4DKuObvTrDIUpJzc+4i5mPdA=;
        b=ijJOTy66ik9RLn342zlGMn80178UfvFsv1KF4vW/7kLtj2aPZPZs42sAlOU1lMPr5U
         2xgM4+q2eW7wRrncmf2U19RhlUzXgE/sOeayEAAgJK9DvCvNwbzWIVNqmVBIU5SXbrR4
         gnVh+6RHxFG3qU+ZE8wmcL17hJIBrDN7EQNpGN1n41XUCZQh9WTMnWeBnUBEi0bkOssq
         d58v7txzgjfU3CGdVq8YwNCbDCnRqGrZ56am9QUy8Mih+TV6ZRVJfiq8ck8h3FNXTqRn
         v9ygf5MaGaPnKT7dmTUwEb4mXbJ8C1Hb3ISRZDY3XTUeIIhPrLeR7vsY0nnMTvGI6wm8
         /DQg==
X-Gm-Message-State: AOAM530S0RnfRuGjnnPhXpeYfR6SBRQNH32pn8PZzPQ2z1lC78rP4Uxt
        YZTW46z7YYlXZhWXNrPCwJR5B3eNxRIo6ZpPvNs=
X-Google-Smtp-Source: ABdhPJxYO+zq1DAU1AR3tPlnB/PzNYlAUBmjsYAsFucF3Qi06b/Ww8KfCP3VOpFHMSVyJ6uYzvInk4F+Gr1Ld0QeoDM=
X-Received: by 2002:a05:6808:14c2:: with SMTP id f2mr8602093oiw.154.1637090283239;
 Tue, 16 Nov 2021 11:18:03 -0800 (PST)
MIME-Version: 1.0
References: <20211108111347.3928294-1-arnd@kernel.org>
In-Reply-To: <20211108111347.3928294-1-arnd@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 16 Nov 2021 20:17:52 +0100
Message-ID: <CAJZ5v0iXCRMF+reCUy_OJRuYuxuJ=YOf5r_cozBg-BxZVfRtqQ@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/int340x: limit Kconfig to 64-bit
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 8, 2021 at 12:13 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> 32-bit processors cannot generally access 64-bit MMIO registers
> atomically, and it is unknown in which order the two halves of
> this registers would need to be read:
>
> drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c: In function 'send_mbox_cmd':
> drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c:79:37: error: implicit declaration of function 'readq'; did you mean 'readl'? [-Werror=implicit-function-declaration]
>    79 |                         *cmd_resp = readq((void __iomem *) (proc_priv->mmio_base + MBOX_OFFSET_DATA));
>       |                                     ^~~~~
>       |                                     readl
>
> The driver already does not build for anything other than x86,
> so limit it further to x86-64.
>
> Fixes: aeb58c860dc5 ("thermal/drivers/int340x: processor_thermal: Suppot 64 bit RFIM responses")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/thermal/intel/int340x_thermal/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/Kconfig b/drivers/thermal/intel/int340x_thermal/Kconfig
> index 45c31f3d6054..5d046de96a5d 100644
> --- a/drivers/thermal/intel/int340x_thermal/Kconfig
> +++ b/drivers/thermal/intel/int340x_thermal/Kconfig
> @@ -5,12 +5,12 @@
>
>  config INT340X_THERMAL
>         tristate "ACPI INT340X thermal drivers"
> -       depends on X86 && ACPI && PCI
> +       depends on X86_64 && ACPI && PCI
>         select THERMAL_GOV_USER_SPACE
>         select ACPI_THERMAL_REL
>         select ACPI_FAN
>         select INTEL_SOC_DTS_IOSF_CORE
> -       select PROC_THERMAL_MMIO_RAPL if X86_64 && POWERCAP
> +       select PROC_THERMAL_MMIO_RAPL if POWERCAP
>         help
>           Newer laptops and tablets that use ACPI may have thermal sensors and
>           other devices with thermal control capabilities outside the core
> --

Applied as 5.16-rc2 material, thanks!
