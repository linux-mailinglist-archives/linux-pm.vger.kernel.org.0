Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8ED2C7DD6
	for <lists+linux-pm@lfdr.de>; Mon, 30 Nov 2020 06:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbgK3Fbd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Nov 2020 00:31:33 -0500
Received: from mga09.intel.com ([134.134.136.24]:12625 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbgK3Fbd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 30 Nov 2020 00:31:33 -0500
IronPort-SDR: SEH+QptqA0FOeAyUl9/4yZkivQ1BgisiQjyx3Z/QP1/osr9/h96JeFFzfDMhAwV486xwqs4ruP
 F9t06qbGeZdQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9820"; a="172741147"
X-IronPort-AV: E=Sophos;i="5.78,379,1599548400"; 
   d="scan'208";a="172741147"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2020 21:29:52 -0800
IronPort-SDR: OtD/n4dWVCA6E/Hm4Viw8L82Eqv0GlUTq+p76QVcf3yr7psN0WnuBj/gpB38+Oc8JiuE1ky12l
 bjdBdlrZVF1g==
X-IronPort-AV: E=Sophos;i="5.78,379,1599548400"; 
   d="scan'208";a="329450418"
Received: from bsaysonx-mobl1.amr.corp.intel.com ([10.212.217.168])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2020 21:29:51 -0800
Message-ID: <81f0532f85b4924bad463572fd778db36613d2a8.camel@linux.intel.com>
Subject: Re: [PATCH 2/3] thermal: int340x: Indicate userspace usage
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Peter Kaestle <peter@piie.net>,
        Matthew Garrett <mjg59@google.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Takashi Iwai <tiwai@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Sun, 29 Nov 2020 21:29:51 -0800
In-Reply-To: <20201128175450.12456-2-kai.heng.feng@canonical.com>
References: <20201128175450.12456-1-kai.heng.feng@canonical.com>
         <20201128175450.12456-2-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 2020-11-29 at 01:54 +0800, Kai-Heng Feng wrote:
> The device isn't present under ACPI ThermalZone, and there's a
> dedicated
> userspace daemon for this thermal device.
> 
> Let thermal core know it shouldn't handle trips to avoid surprising
> thermal shutdown.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/thermal/intel/int340x_thermal/int3400_thermal.c     | 1 +
>  .../thermal/intel/int340x_thermal/int340x_thermal_zone.c    | 6 +---
> --
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> index 0966551cbaaa..2002bc96eb3c 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> @@ -439,6 +439,7 @@ static struct thermal_zone_device_ops
> int3400_thermal_ops = {
>  static struct thermal_zone_params int3400_thermal_params = {
>  	.governor_name = "user_space",
>  	.no_hwmon = true,
> +	.userspace = true,
I am copied on only this patch, so I don't know what is this attribute?
I think it is new.

>  };
>  
>  static void int3400_setup_gddv(struct int3400_thermal_priv *priv)
> diff --git
> a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> index 6e479deff76b..a103eb42ef2d 100644
> --- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> +++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> @@ -208,6 +208,7 @@ EXPORT_SYMBOL_GPL(int340x_thermal_read_trips);
>  static struct thermal_zone_params int340x_thermal_params = {
>  	.governor_name = "user_space",
>  	.no_hwmon = true,
> +	.userspace = true,
>  };
>  
>  struct int34x_thermal_zone *int340x_thermal_zone_add(struct
> acpi_device *adev,
> @@ -259,14 +260,9 @@ struct int34x_thermal_zone
> *int340x_thermal_zone_add(struct acpi_device *adev,
>  		ret = PTR_ERR(int34x_thermal_zone->zone);
>  		goto err_thermal_zone;
>  	}
> -	ret = thermal_zone_device_enable(int34x_thermal_zone->zone);
> -	if (ret)
> -		goto err_enable;

What is the effect of this?
The INT340X zones don't need to poll for temperature. When HW notifies
then user space gets notified via user space governor. Not sure if the
not enabling break that path.

Thanks,
Srinivas

>  
>  	return int34x_thermal_zone;
>  
> -err_enable:
> -	thermal_zone_device_unregister(int34x_thermal_zone->zone);
>  err_thermal_zone:
>  	acpi_lpat_free_conversion_table(int34x_thermal_zone-
> >lpat_table);
>  	kfree(int34x_thermal_zone->aux_trips);

