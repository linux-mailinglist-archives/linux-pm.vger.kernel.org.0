Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B242216389
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jul 2020 03:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgGGBx3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jul 2020 21:53:29 -0400
Received: from mga02.intel.com ([134.134.136.20]:4262 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbgGGBx3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 6 Jul 2020 21:53:29 -0400
IronPort-SDR: /fuaNcSky8bWtccpp71V236Px0gIjnBuJvG28EfiitGolJ6aiKkGKSP6lrunoDCEbZ01N3OBPH
 xxB1unmk3NeA==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="135772352"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="135772352"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 18:53:28 -0700
IronPort-SDR: l0zbK3cOr0OZU5OZaXRgNc0Y7SxA3ywxkq6d6jdlepqPlrg30dFVzt5ULi8PbBud7qCksWKNsV
 PlcT4/0qqscg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="297192394"
Received: from zhexindu-mobl.ccr.corp.intel.com ([10.255.31.6])
  by orsmga002.jf.intel.com with ESMTP; 06 Jul 2020 18:53:27 -0700
Message-ID: <0787af45b1fc9054ac7532790283defde7a863e2.camel@intel.com>
Subject: Re: [PATCH v4 2/4] thermal: core: Get thermal zone by id
From:   Zhang Rui <rui.zhang@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     srinivas.pandruvada@linux.intel.com, rkumbako@codeaurora.org,
        amit.kucheria@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Date:   Tue, 07 Jul 2020 09:53:26 +0800
In-Reply-To: <20200706105538.2159-2-daniel.lezcano@linaro.org>
References: <20200706105538.2159-1-daniel.lezcano@linaro.org>
         <20200706105538.2159-2-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2020-07-06 at 12:55 +0200, Daniel Lezcano wrote:
> The next patch will introduce the generic netlink protocol to handle
> events, sampling and command from the thermal framework. In order to
> deal with the thermal zone, it uses its unique identifier to
> characterize it in the message. Passing an integer is more efficient
> than passing an entire string.
> 
> This change provides a function returning back a thermal zone pointer
> corresponding to the identifier passed as parameter.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

Acked-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/thermal/thermal_core.c | 14 ++++++++++++++
>  drivers/thermal/thermal_core.h |  2 ++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/thermal/thermal_core.c
> b/drivers/thermal/thermal_core.c
> index 9caaa0b6d662..5fae1621fb01 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -668,6 +668,20 @@ int for_each_thermal_zone(int (*cb)(struct
> thermal_zone_device *, void *),
>  	return ret;
>  }
>  
> +struct thermal_zone_device *thermal_zone_get_by_id(int id)
> +{
> +	struct thermal_zone_device *tz = NULL;
> +
> +	mutex_lock(&thermal_list_lock);
> +	list_for_each_entry(tz, &thermal_tz_list, node) {
> +		if (tz->id == id)
> +			break;
> +	}
> +	mutex_unlock(&thermal_list_lock);
> +
> +	return tz;
> +}
> +
>  void thermal_zone_device_unbind_exception(struct thermal_zone_device
> *tz,
>  					  const char *cdev_type, size_t
> size)
>  {
> diff --git a/drivers/thermal/thermal_core.h
> b/drivers/thermal/thermal_core.h
> index 71d88dac0791..4f8389efaa62 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -50,6 +50,8 @@ int for_each_thermal_cooling_device(int
> (*cb)(struct thermal_cooling_device *,
>  int for_each_thermal_governor(int (*cb)(struct thermal_governor *,
> void *),
>  			      void *thermal_governor);
>  
> +struct thermal_zone_device *thermal_zone_get_by_id(int id);
> +
>  struct thermal_attr {
>  	struct device_attribute attr;
>  	char name[THERMAL_NAME_LENGTH];

