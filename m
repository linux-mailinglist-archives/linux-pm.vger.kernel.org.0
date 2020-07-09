Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA8621A55D
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jul 2020 19:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgGIRAw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jul 2020 13:00:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:47626 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbgGIRAv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 Jul 2020 13:00:51 -0400
IronPort-SDR: pr92ZLzmvhfdbO0gLPdzqeZmKfxerIjCoPMVTyGzZsJhMmPV48bk6D8x0ndGOSiLQh+9xS2AqJ
 wXwCogQS5bdA==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="232915650"
X-IronPort-AV: E=Sophos;i="5.75,332,1589266800"; 
   d="scan'208";a="232915650"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 10:00:46 -0700
IronPort-SDR: ReqF61yT9GNlrJ2FoKQId9/N0nD7svQY92hCP2NuekQC6dLMzXqDS8Zi+SwBTQPG+D9Hk3HL9p
 qoxFDAc9sRGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,332,1589266800"; 
   d="scan'208";a="457976840"
Received: from rpantang-mobl.amr.corp.intel.com ([10.212.22.171])
  by orsmga005.jf.intel.com with ESMTP; 09 Jul 2020 10:00:44 -0700
Message-ID: <e4e13cdad78f8593b5c307b5130e416bdc1dccbf.camel@linux.intel.com>
Subject: Re: [PATCH] thermal/int340x_thermal: Prevent page fault on
 .set_mode() op
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Bartosz Szczepanek <bsz@semihalf.com>,
        Matthew Garrett <mjg59@google.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Radoslaw Biernacki <rad@semihalf.com>,
        Alex Levin <levinale@google.com>
Date:   Thu, 09 Jul 2020 10:00:43 -0700
In-Reply-To: <20200708134613.131555-1-bsz@semihalf.com>
References: <20200708134613.131555-1-bsz@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2020-07-08 at 15:46 +0200, Bartosz Szczepanek wrote:
> Starting from commit "thermal/int340x_thermal: Don't require IDSP to
> exist", priv->current_uuid_index is initialized to -1. This value may
> be passed to int3400_thermal_run_osc() from int3400_thermal_set_mode,
> contributing to page fault when accessing int3400_thermal_uuids array
> at index -1.
> 
> This commit adds a check on uuid value to int3400_thermal_run_osc.
> 
> Signed-off-by: Bartosz Szczepanek <bsz@semihalf.com>
Reviewed-by: Pandruvada, Srinivas <srinivas.pandruvada@linux.intel.com>

> ---
>  drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> index 0b3a62655843..12448ccd27f1 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> @@ -216,11 +216,16 @@ static int int3400_thermal_run_osc(acpi_handle
> handle,
>  	acpi_status status;
>  	int result = 0;
>  	struct acpi_osc_context context = {
> -		.uuid_str = int3400_thermal_uuids[uuid],
> +		.uuid_str = NULL,
>  		.rev = 1,
>  		.cap.length = 8,
>  	};
>  
> +	if (uuid < 0 || uuid >= INT3400_THERMAL_MAXIMUM_UUID)
> +		return -EINVAL;
> +
> +	context.uuid_str = int3400_thermal_uuids[uuid];
> +
>  	buf[OSC_QUERY_DWORD] = 0;
>  	buf[OSC_SUPPORT_DWORD] = enable;
>  

