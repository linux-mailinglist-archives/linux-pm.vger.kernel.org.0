Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F132DB8B1
	for <lists+linux-pm@lfdr.de>; Wed, 16 Dec 2020 03:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725308AbgLPCAx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Dec 2020 21:00:53 -0500
Received: from mga06.intel.com ([134.134.136.31]:63970 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgLPCAx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 15 Dec 2020 21:00:53 -0500
IronPort-SDR: 5pgIPjkuAJGtA6Gb4APRdWTHsyfTjNbzJLMeFcOwVH/JFr75IwFGADjS6XEqtneYFxMqZlTuAa
 ZuhZkFqkNIqA==
X-IronPort-AV: E=McAfee;i="6000,8403,9836"; a="236566446"
X-IronPort-AV: E=Sophos;i="5.78,423,1599548400"; 
   d="scan'208";a="236566446"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2020 17:59:07 -0800
IronPort-SDR: MfgFO6vskrlsq0llruAwsIxdFDUI2kw90H+sMbFRiefTX04/rZTPoczbwKalmEUCqzgregLjJz
 wv2jZIeUi+3A==
X-IronPort-AV: E=Sophos;i="5.78,423,1599548400"; 
   d="scan'208";a="337918692"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2020 17:59:07 -0800
Message-ID: <46cad4d0f14b33e77d2cead3b87177cfaa3e03cc.camel@linux.intel.com>
Subject: Re: [PATCH] thermal: int340x: Support Alder Lake
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 15 Dec 2020 17:59:06 -0800
In-Reply-To: <20201117194802.503337-1-srinivas.pandruvada@linux.intel.com>
References: <20201117194802.503337-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2020-11-17 at 11:48 -0800, Srinivas Pandruvada wrote:
> Add ACPI IDs for thermal drivers for Alder Lake support.
> 
This patch was not in PULL request.
It is simple patch, adding ids. Can we send as part of second PULL?

Thanks,
Srinivas

> Signed-off-by: Srinivas Pandruvada <
> srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 1 +
>  drivers/thermal/intel/int340x_thermal/int3403_thermal.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> index 0966551cbaaa..823354a1a91a 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> @@ -584,6 +584,7 @@ static int int3400_thermal_remove(struct
> platform_device *pdev)
>  static const struct acpi_device_id int3400_thermal_match[] = {
>  	{"INT3400", 0},
>  	{"INTC1040", 0},
> +	{"INTC1041", 0},
>  	{}
>  };
>  
> diff --git a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
> b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
> index ec1d58c4ceaa..c3c4c4d34542 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
> @@ -284,6 +284,7 @@ static int int3403_remove(struct platform_device
> *pdev)
>  static const struct acpi_device_id int3403_device_ids[] = {
>  	{"INT3403", 0},
>  	{"INTC1043", 0},
> +	{"INTC1046", 0},
>  	{"", 0},
>  };
>  MODULE_DEVICE_TABLE(acpi, int3403_device_ids);

