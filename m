Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCBCF1A5D7C
	for <lists+linux-pm@lfdr.de>; Sun, 12 Apr 2020 10:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgDLIfs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Apr 2020 04:35:48 -0400
Received: from mga03.intel.com ([134.134.136.65]:22370 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbgDLIfs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 12 Apr 2020 04:35:48 -0400
IronPort-SDR: SYCaQUwtwJh1uTj7DT/Urrwo9uVISyMhZBpzPbhoN88YgN1WrMpRgHuHimKWxyOK+tG2foWkw4
 Fx7kANgqk8cg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2020 01:35:48 -0700
IronPort-SDR: 070gcJ/HXzq3ZNsG44fhmAmRZpVKoQEdyhb50h3krgOaEPfgp1yyXjPjzUv28df8UnOjxnNnBZ
 6dGOBwGjeCZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,374,1580803200"; 
   d="scan'208";a="399334741"
Received: from mengling-mobl.ccr.corp.intel.com ([10.255.29.65])
  by orsmga004.jf.intel.com with ESMTP; 12 Apr 2020 01:35:46 -0700
Message-ID: <271484966db322cb052b59833a4babcfb8488d95.camel@intel.com>
Subject: Re: [PATCH V2 1/9] thermal: Move default governor config option to
 the internal header
From:   Zhang Rui <rui.zhang@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     amit.kucheria@verdurent.com,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Sun, 12 Apr 2020 16:35:45 +0800
In-Reply-To: <20200402142747.8307-1-daniel.lezcano@linaro.org>
References: <20200402142747.8307-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi, Daniel,

please feel free to add my Acked-by for the whole patch set.

thanks,
rui

On Thu, 2020-04-02 at 16:27 +0200, Daniel Lezcano wrote:
> The default governor set at compilation time is a thermal internal
> business, no need to export to the global thermal header.
> 
> Move the config options to the internal header.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/thermal_core.h | 11 +++++++++++
>  include/linux/thermal.h        | 11 -----------
>  2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.h
> b/drivers/thermal/thermal_core.h
> index 37cd4e2bead2..828305508556 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -12,6 +12,17 @@
>  #include <linux/device.h>
>  #include <linux/thermal.h>
>  
> +/* Default Thermal Governor */
> +#if defined(CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE)
> +#define DEFAULT_THERMAL_GOVERNOR       "step_wise"
> +#elif defined(CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE)
> +#define DEFAULT_THERMAL_GOVERNOR       "fair_share"
> +#elif defined(CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE)
> +#define DEFAULT_THERMAL_GOVERNOR       "user_space"
> +#elif defined(CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR)
> +#define DEFAULT_THERMAL_GOVERNOR       "power_allocator"
> +#endif
> +
>  /* Initial state of a cooling device during binding */
>  #define THERMAL_NO_TARGET -1UL
>  
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 448841ab0dca..71cff87dcb46 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -32,17 +32,6 @@
>  /* use value, which < 0K, to indicate an invalid/uninitialized
> temperature */
>  #define THERMAL_TEMP_INVALID	-274000
>  
> -/* Default Thermal Governor */
> -#if defined(CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE)
> -#define DEFAULT_THERMAL_GOVERNOR       "step_wise"
> -#elif defined(CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE)
> -#define DEFAULT_THERMAL_GOVERNOR       "fair_share"
> -#elif defined(CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE)
> -#define DEFAULT_THERMAL_GOVERNOR       "user_space"
> -#elif defined(CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR)
> -#define DEFAULT_THERMAL_GOVERNOR       "power_allocator"
> -#endif
> -
>  struct thermal_zone_device;
>  struct thermal_cooling_device;
>  struct thermal_instance;

