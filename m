Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E20447ECC
	for <lists+linux-pm@lfdr.de>; Mon,  8 Nov 2021 12:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239209AbhKHLZP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Nov 2021 06:25:15 -0500
Received: from mga07.intel.com ([134.134.136.100]:7782 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239201AbhKHLZO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Nov 2021 06:25:14 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10161"; a="295647596"
X-IronPort-AV: E=Sophos;i="5.87,218,1631602800"; 
   d="scan'208";a="295647596"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 03:22:30 -0800
X-IronPort-AV: E=Sophos;i="5.87,218,1631602800"; 
   d="scan'208";a="641380569"
Received: from jlalwani-mobl1.gar.corp.intel.com ([10.215.113.236])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 03:22:22 -0800
Message-ID: <82dfc7923e570612c2788341b85d3d125def464d.camel@linux.intel.com>
Subject: Re: [PATCH] thermal/drivers/int340x: limit Kconfig to 64-bit
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 08 Nov 2021 03:22:14 -0800
In-Reply-To: <20211108111347.3928294-1-arnd@kernel.org>
References: <20211108111347.3928294-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2021-11-08 at 12:13 +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> 32-bit processors cannot generally access 64-bit MMIO registers
> atomically, and it is unknown in which order the two halves of
> this registers would need to be read:
> 
> drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c: In
> function 'send_mbox_cmd':
> drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c:79:37:
> error: implicit declaration of function 'readq'; did you mean
> 'readl'? [-Werror=implicit-function-declaration]
>    79 |                         *cmd_resp = readq((void __iomem *)
> (proc_priv->mmio_base + MBOX_OFFSET_DATA));
>       |                                     ^~~~~
>       |                                     readl
> 
> The driver already does not build for anything other than x86,
> so limit it further to x86-64.
> 
> Fixes: aeb58c860dc5 ("thermal/drivers/int340x: processor_thermal:
> Suppot 64 bit RFIM responses")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
>  drivers/thermal/intel/int340x_thermal/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/intel/int340x_thermal/Kconfig
> b/drivers/thermal/intel/int340x_thermal/Kconfig
> index 45c31f3d6054..5d046de96a5d 100644
> --- a/drivers/thermal/intel/int340x_thermal/Kconfig
> +++ b/drivers/thermal/intel/int340x_thermal/Kconfig
> @@ -5,12 +5,12 @@
>  
>  config INT340X_THERMAL
>         tristate "ACPI INT340X thermal drivers"
> -       depends on X86 && ACPI && PCI
> +       depends on X86_64 && ACPI && PCI
>         select THERMAL_GOV_USER_SPACE
>         select ACPI_THERMAL_REL
>         select ACPI_FAN
>         select INTEL_SOC_DTS_IOSF_CORE
> -       select PROC_THERMAL_MMIO_RAPL if X86_64 && POWERCAP
> +       select PROC_THERMAL_MMIO_RAPL if POWERCAP
>         help
>           Newer laptops and tablets that use ACPI may have thermal
> sensors and
>           other devices with thermal control capabilities outside the
> core


