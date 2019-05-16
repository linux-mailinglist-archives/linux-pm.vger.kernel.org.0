Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0FF020FFA
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2019 23:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfEPVZc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 May 2019 17:25:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:59248 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbfEPVZc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 May 2019 17:25:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 May 2019 14:25:32 -0700
Received: from unknown (HELO [10.232.112.136]) ([10.232.112.136])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 16 May 2019 14:25:31 -0700
Subject: Re: [PATCH 1/2] nvme: add thermal zone infrastructure
To:     Akinobu Mita <akinobu.mita@gmail.com>,
        linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org
Cc:     Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, Christoph Hellwig <hch@lst.de>
References: <1557933437-4693-1-git-send-email-akinobu.mita@gmail.com>
 <1557933437-4693-2-git-send-email-akinobu.mita@gmail.com>
From:   "Heitke, Kenneth" <kenneth.heitke@intel.com>
Message-ID: <dcb16af2-acb9-eff1-a2f9-ff8154381723@intel.com>
Date:   Thu, 16 May 2019 15:25:31 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1557933437-4693-2-git-send-email-akinobu.mita@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 5/15/2019 9:17 AM, Akinobu Mita wrote:
> The NVMe controller reports up to nine temperature values in the SMART /
> Health log page (the composite temperature and temperature sensor 1 through
> temperature sensor 8).
> The temperature threshold feature (Feature Identifier 04h) configures the
> asynchronous event request command to complete when the temperature is
> crossed its correspoinding temperature threshold.
> 
> This adds infrastructure to provide these temperatures and thresholds via
> thermal zone devices.
> 
> The nvme_thermal_zones_register() creates up to nine thermal zone devices
> for valid temperature sensors including composite temperature.
> 
> /sys/class/thermal/thermal_zone[0-*]:
>      |---temp: Temperature
>      |---trip_point_0_temp: Over temperature threshold
>      |---trip_point_0_hyst: Under temperature threshold
> 
> The thermal_zone[0-*] contains a symlink to the correspoinding nvme device.
> On the other hand, the following symlinks to the thermal zone devices are
> created in the nvme device sysfs directory.
> 
> - nvme_temp0: Composite temperature
> - nvme_temp1: Temperature sensor 1
> ...
> - nvme_temp8: Temperature sensor 8
> 
> The nvme_thermal_zones_unregister() removes the registered thermal zone
> devices and symlinks.
> 
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Jens Axboe <axboe@fb.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> ---
>   drivers/nvme/host/core.c | 368 ++++++++++++++++++++++++++++++++++++++++++++++-
>   drivers/nvme/host/nvme.h |  24 ++++
>   include/linux/nvme.h     |   4 +
>   3 files changed, 392 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 172551b..a915c6b 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> +
> +static int nvme_tz_type_to_sensor(const char *type)
> +{
> +	int sensor;
> +
> +	if (sscanf(type, "nvme_temp%d", &sensor) != 1)
> +		return -EINVAL;
> +
> +	if (sensor < 0 || sensor > 8)
> +		return -EINVAL;
> +
> +	return sensor;
> +}

I know this has been discussed but it bothers me that this can return a
negative (error code) but then the callers of this function don't check
for errors. If you can prevent the error conditions, can 'sensor' be
treated as unsigned?

> +
> +#define KELVIN_TO_MILLICELSIUS(t) DECI_KELVIN_TO_MILLICELSIUS((t) * 10)
> +#define MILLICELSIUS_TO_KELVIN(t) ((MILLICELSIUS_TO_DECI_KELVIN(t) + 5) / 10)
> +
> +static int nvme_tz_get_temp(struct thermal_zone_device *tzdev,
> +			    int *temp)
> +{
> +	int sensor = nvme_tz_type_to_sensor(tzdev->type);
> +	struct nvme_ctrl *ctrl = tzdev->devdata;
> +	int ret;
> +
> +	ret = nvme_get_temp(ctrl, sensor, temp);
> +	if (!ret)
> +		*temp = KELVIN_TO_MILLICELSIUS(*temp);
> +
> +	return ret;
> +}
