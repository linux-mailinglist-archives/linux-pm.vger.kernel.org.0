Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE3D2DFE43
	for <lists+linux-pm@lfdr.de>; Mon, 21 Dec 2020 17:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725777AbgLUQ5a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Dec 2020 11:57:30 -0500
Received: from mga12.intel.com ([192.55.52.136]:64438 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbgLUQ53 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 21 Dec 2020 11:57:29 -0500
IronPort-SDR: 8/MvvolNnReC6CbDENxf4PS3Zdqsup9dQDCmZpEEke+fNMx8QnhaC16Uv++65sgr51pEDQciro
 Wd+XRm+P9V8Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9842"; a="154966005"
X-IronPort-AV: E=Sophos;i="5.78,436,1599548400"; 
   d="scan'208";a="154966005"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 08:55:43 -0800
IronPort-SDR: 8eZRZrJmK6gJn0MUhrhIA82XS/3hhRyRmlL/n/it4y+l1xmJ8wk0JtEtt3N65l3doexW9u83sC
 Y4xvjyGFt2yQ==
X-IronPort-AV: E=Sophos;i="5.78,436,1599548400"; 
   d="scan'208";a="355747567"
Received: from haberchr-mobl.amr.corp.intel.com ([10.212.196.73])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 08:55:37 -0800
Message-ID: <b761af6e0725a204d869a277af68aa4293be0e99.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] thermal: int340x: Add critical callback to override
 default shutdown behavior
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     andrzej.p@collabora.com, mjg59@google.com,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Peter Kaestle <peter@piie.net>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Mon, 21 Dec 2020 08:55:33 -0800
In-Reply-To: <20201221135206.17671-1-kai.heng.feng@canonical.com>
References: <20201221135206.17671-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 (3.38.2-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2020-12-21 at 21:52 +0800, Kai-Heng Feng wrote:
> We are seeing thermal shutdown on Intel based mobile workstations,
> the
> shutdown happens during the first trip handle in
> thermal_zone_device_register():
> kernel: thermal thermal_zone15: critical temperature reached (101 C),
> shutting down
> 
> However, we shouldn't do a thermal shutdown here, since
> 1) We may want to use a dedicated daemon, Intel's thermald in this
> case,
> to handle thermal shutdown.
> 
> 2) For ACPI based system, _CRT doesn't mean shutdown unless it's
> inside
> ThermalZone namespace. ACPI Spec, 11.4.4 _CRT (Critical Temperature):
> "... If this object it present under a device, the device’s driver
> evaluates this object to determine the device’s critical cooling
> temperature trip point. This value may then be used by the device’s
> driver to program an internal device temperature sensor trip point."
> 
> So a "critical trip" here merely means we should take a more
> aggressive
> cooling method.
> 
> As int340x device isn't present under ACPI ThermalZone, override the
> default .critical callback to prevent surprising thermal shutdown.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/thermal/intel/int340x_thermal/int3400_thermal.c     | 6
> ++++++
>  .../thermal/intel/int340x_thermal/int340x_thermal_zone.c    | 6
> ++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> index 823354a1a91a..9778a6dba939 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> @@ -431,9 +431,15 @@ static int int3400_thermal_change_mode(struct
> thermal_zone_device *thermal,
>         return result;
>  }
>  
> +static void int3400_thermal_critical(struct thermal_zone_device
> *thermal)
> +{
> +       dev_dbg(&thermal->device, "%s: critical temperature
> reached\n", thermal->type);
> +}
> +
>  static struct thermal_zone_device_ops int3400_thermal_ops = {
>         .get_temp = int3400_thermal_get_temp,
>         .change_mode = int3400_thermal_change_mode,
> +       .critical = int3400_thermal_critical,
>  };

You don't need for int3400 device. This is a fake sensor.

>  
>  static struct thermal_zone_params int3400_thermal_params = {
> diff --git
> a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> index 6e479deff76b..d1248ba943a4 100644
> --- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> +++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> @@ -146,12 +146,18 @@ static int int340x_thermal_get_trip_hyst(struct
> thermal_zone_device *zone,
>         return 0;
>  }
>  
> +static void int340x_thermal_critical(struct thermal_zone_device
> *zone)
> +{
> +       dev_dbg(&zone->device, "%s: critical temperature reached\n",
> zone->type);
> +}
> +
>  static struct thermal_zone_device_ops int340x_thermal_zone_ops = {
>         .get_temp       = int340x_thermal_get_zone_temp,
>         .get_trip_temp  = int340x_thermal_get_trip_temp,
>         .get_trip_type  = int340x_thermal_get_trip_type,
>         .set_trip_temp  = int340x_thermal_set_trip_temp,
>         .get_trip_hyst =  int340x_thermal_get_trip_hyst,
> +       .critical       = int340x_thermal_critical,
>  };
>  
>  static int int340x_thermal_get_trip_config(acpi_handle handle, char
> *name,

Thanks,
Srinivas


