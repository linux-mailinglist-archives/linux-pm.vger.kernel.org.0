Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 980E72FAE5E
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jan 2021 02:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392282AbhASBiN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 18 Jan 2021 20:38:13 -0500
Received: from mga17.intel.com ([192.55.52.151]:22878 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729202AbhASBiN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 18 Jan 2021 20:38:13 -0500
IronPort-SDR: wlOK/UyGXgNp/srMc05MbBEkpaq2VK64eJgqznsoak1P2Lp+r42Ue504HQz/jrH6/G+MO5K+Xt
 pn8Qjjid72PA==
X-IronPort-AV: E=McAfee;i="6000,8403,9868"; a="158638312"
X-IronPort-AV: E=Sophos;i="5.79,357,1602572400"; 
   d="scan'208";a="158638312"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 17:37:29 -0800
IronPort-SDR: IMpdu4T63VIM+bChb5MYAewAOXgHALm0u+c7vuT9WUL14I53PJrMyd3+He/PiceT1Gl45+nd4p
 fGu69FRltqRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,357,1602572400"; 
   d="scan'208";a="347022832"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga007.fm.intel.com with ESMTP; 18 Jan 2021 17:37:29 -0800
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 18 Jan 2021 17:37:28 -0800
Received: from shsmsx603.ccr.corp.intel.com (10.109.6.143) by
 SHSMSX605.ccr.corp.intel.com (10.109.6.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 19 Jan 2021 09:37:27 +0800
Received: from shsmsx603.ccr.corp.intel.com ([10.109.6.143]) by
 SHSMSX603.ccr.corp.intel.com ([10.109.6.143]) with mapi id 15.01.1713.004;
 Tue, 19 Jan 2021 09:37:27 +0800
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     Guenter Roeck <linux@roeck-us.net>, Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Amit Kucheria <amitk@kernel.org>,
        "open list:PWM FAN DRIVER" <linux-hwmon@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KHADAS MCU MFD DRIVER" <linux-amlogic@lists.infradead.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH v2] thermal/core: Make cooling device state change private
Thread-Topic: [PATCH v2] thermal/core: Make cooling device state change
 private
Thread-Index: AQHW7cDP1uLeJF14xUSIfMisXKv/LaouK6iQ
Date:   Tue, 19 Jan 2021 01:37:27 +0000
Message-ID: <2514d8a204c04b4695da7b73bd2ff848@intel.com>
References: <20210118173824.9970-1-daniel.lezcano@linaro.org>
In-Reply-To: <20210118173824.9970-1-daniel.lezcano@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



> -----Original Message-----
> From: Daniel Lezcano <daniel.lezcano@linaro.org>
> Sent: Tuesday, January 19, 2021 1:38 AM
> To: daniel.lezcano@linaro.org; Zhang, Rui <rui.zhang@intel.com>
> Cc: Guenter Roeck <linux@roeck-us.net>; Kamil Debski <kamil@wypas.org>;
> Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>; Jean Delvare
> <jdelvare@suse.com>; Neil Armstrong <narmstrong@baylibre.com>; Amit
> Kucheria <amitk@kernel.org>; open list:PWM FAN DRIVER <linux-
> hwmon@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>; open
> list:KHADAS MCU MFD DRIVER <linux-amlogic@lists.infradead.org>; open
> list:THERMAL <linux-pm@vger.kernel.org>
> Subject: [PATCH v2] thermal/core: Make cooling device state change private
> Importance: High
> 
> The change of the cooling device state should be used by the governor or at
> least by the core code, not by the drivers themselves.
> 
> Remove the API usage and move the function declaration to the internal
> headers.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Zhang Rui <rui.zhang@intel.com>

Thanks,
rui
> ---
>  drivers/hwmon/pwm-fan.c          | 1 -
>  drivers/thermal/khadas_mcu_fan.c | 1 -
>  drivers/thermal/thermal_core.h   | 2 ++
>  include/linux/thermal.h          | 3 ---
>  4 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c index
> bdba2143021a..0b1159ceac9b 100644
> --- a/drivers/hwmon/pwm-fan.c
> +++ b/drivers/hwmon/pwm-fan.c
> @@ -378,7 +378,6 @@ static int pwm_fan_probe(struct platform_device
> *pdev)
>  			return ret;
>  		}
>  		ctx->cdev = cdev;
> -		thermal_cdev_update(cdev);
>  	}
> 
>  	return 0;
> diff --git a/drivers/thermal/khadas_mcu_fan.c
> b/drivers/thermal/khadas_mcu_fan.c
> index 9eadd2d6413e..d35e5313bea4 100644
> --- a/drivers/thermal/khadas_mcu_fan.c
> +++ b/drivers/thermal/khadas_mcu_fan.c
> @@ -100,7 +100,6 @@ static int khadas_mcu_fan_probe(struct
> platform_device *pdev)
>  		return ret;
>  	}
>  	ctx->cdev = cdev;
> -	thermal_cdev_update(cdev);
> 
>  	return 0;
>  }
> diff --git a/drivers/thermal/thermal_core.h
> b/drivers/thermal/thermal_core.h index 90f9a80c8b23..86b8cef7310e 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -65,6 +65,8 @@ static inline bool cdev_is_power_actor(struct
> thermal_cooling_device *cdev)
>  		cdev->ops->power2state;
>  }
> 
> +void thermal_cdev_update(struct thermal_cooling_device *);
> +
>  /**
>   * struct thermal_trip - representation of a point in temperature domain
>   * @np: pointer to struct device_node that this trip point was created from
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h index
> 1e686404951b..6ac7bb1d2b1f 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -390,7 +390,6 @@ int thermal_zone_get_temp(struct
> thermal_zone_device *tz, int *temp);  int thermal_zone_get_slope(struct
> thermal_zone_device *tz);  int thermal_zone_get_offset(struct
> thermal_zone_device *tz);
> 
> -void thermal_cdev_update(struct thermal_cooling_device *);  void
> thermal_notify_framework(struct thermal_zone_device *, int);  int
> thermal_zone_device_enable(struct thermal_zone_device *tz);  int
> thermal_zone_device_disable(struct thermal_zone_device *tz); @@ -437,8
> +436,6 @@ static inline int thermal_zone_get_offset(
>  		struct thermal_zone_device *tz)
>  { return -ENODEV; }
> 
> -static inline void thermal_cdev_update(struct thermal_cooling_device
> *cdev) -{ }  static inline void thermal_notify_framework(struct
> thermal_zone_device *tz,
>  	int trip)
>  { }
> --
> 2.17.1

