Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACB5326A7
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2019 04:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfFCCgW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 2 Jun 2019 22:36:22 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42327 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFCCgW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 2 Jun 2019 22:36:22 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6so6121360pgd.9
        for <linux-pm@vger.kernel.org>; Sun, 02 Jun 2019 19:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=ckMuPs986VVxHLf8fHAmtwbIodhJowpNnytqifVQjek=;
        b=tNAJhfw1cNlxIMGBD0S/2sP1keihoKb2E6ecx3I6DZuMAEsI2zQn4ouonn1K1D88Iu
         md2xYaunxPA/d3NAjVLWPzHMf76mnCxsN/Jfs8L3z79Wu9OaJPJCLycNIm+wN8xX6zi4
         gqGZAzprmr1ntGh5Lm5hkADq1In+wPAIfBPEE+F4Bta1kHNUDXLGEtM38OfXC9yKtUFy
         szdoFFxZET2CgBM/3PO996qgMkWM3SvT0o65ysKSr38tJtVXj0lwqaLrIMoMjl/MIP4Y
         qBzgcUGvRtoII1V5KY/2890/d3eloIFRzK505l4uWfNmDbjZc7X++JB+JflBvY/cTlKT
         HLXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ckMuPs986VVxHLf8fHAmtwbIodhJowpNnytqifVQjek=;
        b=hGA52e2/q26tLe673gwojfesXIZKyNrj/TOGHT8rxiDLpKhg6wiKzkssGu6baOpVWO
         CUqPOcFWYsf+zFLa0qXiLhEhZdeUG/e8o80CU7S8sXercyG2wq9K/jkE9r0YSKWgLep5
         CWuksSZ+fsLQIG0pnRT+h5qMoONCk3bDTnfgU6149j5f1OOIjbOaemwR81XPgStmimrE
         WPR7L43qQlWpzIiKMMOSnP/f3weIPJHt//HkJcr4zMhs59bneKkdc46KTodJsLbZYHqn
         1T4r5CvY17F0RWNUqg3nC7UJlNxWguKl11rdBMf1n9sNxAwYL8JFX8H2igXy8IHrcl+6
         5xpw==
X-Gm-Message-State: APjAAAVEJRIjpUpvDn9qirA1mewJfFoGD5utgDsXVBL9EndYo3XccTfO
        1rWSkOcAODjCCnnSQ/nQY5I=
X-Google-Smtp-Source: APXvYqzB+G1YzaiQFpgH0pr/+xFvq06ULeMZMF7qpKv3VfZr/71IEWV7qWJ6vnwpJDK/KoPjxXSBaQ==
X-Received: by 2002:a63:2c4a:: with SMTP id s71mr25875710pgs.343.1559529381162;
        Sun, 02 Jun 2019 19:36:21 -0700 (PDT)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id f17sm14378759pgv.16.2019.06.02.19.36.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jun 2019 19:36:20 -0700 (PDT)
Date:   Sun, 2 Jun 2019 19:36:18 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Kenneth Heitke <kenneth.heitke@intel.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH v3 2/3] nvme: add thermal zone devices
Message-ID: <20190603023617.GA8567@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558888143-5121-3-git-send-email-akinobu.mita@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey Mita,

On Mon, May 27, 2019 at 01:29:02AM +0900, Akinobu Mita wrote:
> The NVMe controller reports up to nine temperature values in the SMART /
> Health log page (the composite temperature and temperature sensor 1 through
> temperature sensor 8).
> 
> This provides these temperatures via thermal zone devices.
> 
> Once the controller is identified, the thermal zone devices are created for
> all implemented temperature sensors including the composite temperature.
> 
> /sys/class/thermal/thermal_zone[0-*]:
>     |---type: 'nvme<instance>-temp<sensor>'
>     |---temp: Temperature
>     |---trip_point_0_temp: Over temperature threshold
> 
> The thermal_zone[0-*] contains a 'device' symlink to the corresponding nvme
> device.
> 
> On the other hand, the following symlinks to the thermal zone devices are
> created in the nvme device sysfs directory.
> 
> - temp0: Composite temperature
> - temp1: Temperature sensor 1
> ...
> - temp8: Temperature sensor 8
> 

These questions on V2 are still unanswered:
a. Can we get a more descriptive string into tz->type?
b. Can these APIs support DT probing too?

> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Jens Axboe <axboe@fb.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Minwoo Im <minwoo.im.dev@gmail.com>
> Cc: Kenneth Heitke <kenneth.heitke@intel.com>
> Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> ---
> * v3
> - Change the type name of thermal zone devices from 'nvme_temp<sensor>' to
>   'nvme<instance>_temp<sensor>'
> - Pass a NULL to the status argument of nvme_set_feature()
> - Change the name of symbolic link from 'nvme_temp<sensor>' to 'temp<sensor>'
> - Don't make it fatal error if the device provides a response
> - Don't register thermal zone for composite temperature if smart log reports
>   zero value
> - Move the thermal zones registration and unregistration into the core module.
> 
>  drivers/nvme/host/core.c | 288 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/nvme/host/nvme.h |   9 ++
>  include/linux/nvme.h     |   5 +
>  3 files changed, 302 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index c950916..4c8271a 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2200,6 +2200,289 @@ static void nvme_set_latency_tolerance(struct device *dev, s32 val)
>  	}
>  }
>  
> +#ifdef CONFIG_THERMAL
> +
> +static int nvme_get_temp(struct nvme_ctrl *ctrl, unsigned int sensor, int *temp)
> +{
> +	struct nvme_smart_log *log;
> +	int ret;
> +
> +	BUILD_BUG_ON(ARRAY_SIZE(log->temp_sensor) + 1 !=
> +		     ARRAY_SIZE(ctrl->tzdev));
> +
> +	if (WARN_ON_ONCE(sensor > ARRAY_SIZE(log->temp_sensor)))
> +		return -EINVAL;
> +
> +	log = kzalloc(sizeof(*log), GFP_KERNEL);
> +	if (!log)
> +		return -ENOMEM;
> +
> +	ret = nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_SMART, 0,
> +			   log, sizeof(*log), 0);
> +	if (ret) {
> +		ret = ret > 0 ? -EINVAL : ret;
> +		goto free_log;
> +	}
> +
> +	if (sensor)
> +		*temp = le16_to_cpu(log->temp_sensor[sensor - 1]);
> +	else
> +		*temp = get_unaligned_le16(log->temperature);
> +
> +free_log:
> +	kfree(log);
> +
> +	return ret;
> +}
> +
> +static unsigned int nvme_tz_type_to_sensor(const char *type)
> +{
> +	int instance;
> +	unsigned int sensor;
> +
> +	if (sscanf(type, "nvme%d_temp%u", &instance, &sensor) != 2)
> +		return UINT_MAX;
> +
> +	return sensor;
> +}
> +
> +#define KELVIN_TO_MILLICELSIUS(t) DECI_KELVIN_TO_MILLICELSIUS((t) * 10)
> +#define MILLICELSIUS_TO_KELVIN(t) ((MILLICELSIUS_TO_DECI_KELVIN(t) + 5) / 10)
> +
> +static int nvme_tz_get_temp(struct thermal_zone_device *tzdev, int *temp)
> +{
> +	unsigned int sensor = nvme_tz_type_to_sensor(tzdev->type);
> +	struct nvme_ctrl *ctrl = tzdev->devdata;
> +	int ret;
> +
> +	ret = nvme_get_temp(ctrl, sensor, temp);
> +	if (!ret)
> +		*temp = KELVIN_TO_MILLICELSIUS(*temp);
> +
> +	return ret;
> +}
> +
> +static int nvme_tz_get_trip_type(struct thermal_zone_device *tzdev,
> +				 int trip, enum thermal_trip_type *type)
> +{
> +	*type = THERMAL_TRIP_ACTIVE;
> +
> +	return 0;
> +}
> +
> +static int nvme_get_over_temp_thresh(struct nvme_ctrl *ctrl,
> +				     unsigned int sensor, int *temp)
> +{
> +	unsigned int threshold = sensor << NVME_TEMP_THRESH_SELECT_SHIFT;
> +	int status;
> +	int ret;
> +
> +	if (WARN_ON_ONCE(sensor >= ARRAY_SIZE(ctrl->tzdev)))
> +		return -EINVAL;
> +
> +	ret = nvme_get_features(ctrl, NVME_FEAT_TEMP_THRESH, threshold, NULL, 0,
> +				&status);
> +	if (!ret)
> +		*temp = status & NVME_TEMP_THRESH_MASK;
> +
> +	return ret > 0 ? -EINVAL : ret;
> +}
> +
> +static int nvme_set_over_temp_thresh(struct nvme_ctrl *ctrl,
> +				     unsigned int sensor, int temp)
> +{
> +	unsigned int threshold = sensor << NVME_TEMP_THRESH_SELECT_SHIFT;
> +	int ret;
> +
> +	if (WARN_ON_ONCE(sensor >= ARRAY_SIZE(ctrl->tzdev)))
> +		return -EINVAL;
> +
> +	if (temp > NVME_TEMP_THRESH_MASK)
> +		return -EINVAL;
> +
> +	threshold |= temp & NVME_TEMP_THRESH_MASK;
> +
> +	ret = nvme_set_features(ctrl, NVME_FEAT_TEMP_THRESH, threshold, NULL, 0,
> +				NULL);
> +
> +	return ret > 0 ? -EINVAL : ret;
> +}
> +
> +static int nvme_tz_get_trip_temp(struct thermal_zone_device *tzdev,
> +				 int trip, int *temp)
> +{
> +	unsigned int sensor = nvme_tz_type_to_sensor(tzdev->type);
> +	struct nvme_ctrl *ctrl = tzdev->devdata;
> +	int ret;
> +
> +	ret = nvme_get_over_temp_thresh(ctrl, sensor, temp);
> +	if (!ret)
> +		*temp = KELVIN_TO_MILLICELSIUS(*temp);
> +
> +	return ret;
> +}
> +
> +static int nvme_tz_set_trip_temp(struct thermal_zone_device *tzdev,
> +				 int trip, int temp)
> +{
> +	unsigned int sensor = nvme_tz_type_to_sensor(tzdev->type);
> +	struct nvme_ctrl *ctrl = tzdev->devdata;
> +
> +	temp = MILLICELSIUS_TO_KELVIN(temp);
> +
> +	return nvme_set_over_temp_thresh(ctrl, sensor, temp);
> +}
> +
> +static struct thermal_zone_device_ops nvme_tz_ops = {
> +	.get_temp = nvme_tz_get_temp,
> +	.get_trip_type = nvme_tz_get_trip_type,
> +	.get_trip_temp = nvme_tz_get_trip_temp,
> +	.set_trip_temp = nvme_tz_set_trip_temp,
> +};
> +
> +static struct thermal_zone_params nvme_tz_params = {
> +	.governor_name = "user_space",

Also,

Was there any particular reason why defaulting to user_space here?

> +	.no_hwmon = true,
> +};
> +
> +static struct thermal_zone_device *
> +nvme_thermal_zone_register(struct nvme_ctrl *ctrl, unsigned int sensor)
> +{
> +	struct thermal_zone_device *tzdev;
> +	char name[THERMAL_NAME_LENGTH];
> +	int ret;
> +
> +	snprintf(name, sizeof(name), "nvme%d_temp%u", ctrl->instance, sensor);
> +
> +	tzdev = thermal_zone_device_register(name, 1, 1, ctrl, &nvme_tz_ops,
> +					     &nvme_tz_params, 0, 0);
> +	if (IS_ERR(tzdev)) {
> +		dev_err(ctrl->device,
> +			"Failed to register thermal zone device: %ld\n",
> +			PTR_ERR(tzdev));
> +		return tzdev;
> +	}
> +
> +	snprintf(name, sizeof(name), "temp%d", sensor);
> +	ret = sysfs_create_link(&ctrl->ctrl_device.kobj, &tzdev->device.kobj,
> +				name);
> +	if (ret)
> +		goto device_unregister;
> +
> +	ret = sysfs_create_link(&tzdev->device.kobj,
> +				&ctrl->ctrl_device.kobj, "device");
> +	if (ret)
> +		goto remove_link;
> +
> +	return tzdev;
> +
> +remove_link:
> +	sysfs_remove_link(&ctrl->ctrl_device.kobj, name);
> +device_unregister:
> +	thermal_zone_device_unregister(tzdev);
> +
> +	return ERR_PTR(ret);
> +}
> +
> +/**
> + * nvme_thermal_zones_register() - register nvme thermal zone devices
> + * @ctrl: controller instance
> + *
> + * This function creates up to nine thermal zone devices for all implemented
> + * temperature sensors including the composite temperature.
> + * Each thermal zone device provides a single trip point temperature that is
> + * associated with an over temperature threshold.
> + */
> +static int nvme_thermal_zones_register(struct nvme_ctrl *ctrl)
> +{
> +	struct nvme_smart_log *log;
> +	int ret;
> +	int i;
> +
> +	log = kzalloc(sizeof(*log), GFP_KERNEL);
> +	if (!log)
> +		return 0; /* non-fatal error */

I am not sure about this API design here. I would leave the error
handling and judging if this is fatal or not to the caller. 
I mean, if I ask to register a nvme thermal zone and I get
a 0 as response, I would assume the thermal zone exists from
now on, right?

> +
> +	ret = nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_SMART, 0,
> +			   log, sizeof(*log), 0);
> +	if (ret) {
> +		dev_err(ctrl->device, "Failed to get SMART log: %d\n", ret);
> +		/* If the device provided a response, then it's non-fatal */
> +		if (ret > 0)
> +			ret = 0;
> +		goto free_log;

Once again, hiding errors is never a strategy that scales..

> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(ctrl->tzdev); i++) {
> +		struct thermal_zone_device *tzdev;
> +		int temp;
> +
> +		if (i)
> +			temp = le16_to_cpu(log->temp_sensor[i - 1]);
> +		else
> +			temp = get_unaligned_le16(log->temperature);
> +
> +		/*
> +		 * All implemented temperature sensors report a non-zero value
> +		 * in temperature sensor fields in the smart log page.
> +		 */
> +		if (!temp)
> +			continue;
> +		if (ctrl->tzdev[i])
> +			continue;
> +
> +		tzdev = nvme_thermal_zone_register(ctrl, i);
> +		if (!IS_ERR(tzdev))
> +			ctrl->tzdev[i] = tzdev;

Here again, I would not hide errors, the API should propagate errors
if something goes wrong.

> +	}
> +
> +free_log:
> +	kfree(log);
> +
> +	return ret;
> +}
> +
> +/**
> + * nvme_thermal_zones_unregister() - unregister nvme thermal zone devices
> + * @ctrl: controller instance
> + *
> + * This function removes the registered thermal zone devices and symlinks.
> + */
> +static void nvme_thermal_zones_unregister(struct nvme_ctrl *ctrl)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(ctrl->tzdev); i++) {
> +		struct thermal_zone_device *tzdev = ctrl->tzdev[i];
> +		char name[20];
> +
> +		if (!tzdev)
> +			continue;
> +
> +		sysfs_remove_link(&tzdev->device.kobj, "device");
> +
> +		snprintf(name, sizeof(name), "temp%d", i);
> +		sysfs_remove_link(&ctrl->ctrl_device.kobj, name);
> +
> +		thermal_zone_device_unregister(tzdev);
> +
> +		ctrl->tzdev[i] = NULL;
> +	}
> +}
> +
> +#else
> +
> +static inline int nvme_thermal_zones_register(struct nvme_ctrl *ctrl)
> +{
> +	return 0;
> +}
> +
> +static inline void nvme_thermal_zones_unregister(struct nvme_ctrl *ctrl)
> +{
> +}
> +
> +#endif /* CONFIG_THERMAL */
> +
>  struct nvme_core_quirk_entry {
>  	/*
>  	 * NVMe model and firmware strings are padded with spaces.  For
> @@ -2754,6 +3037,10 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
>  	if (ret < 0)
>  		return ret;
>  
> +	ret = nvme_thermal_zones_register(ctrl);
> +	if (ret < 0)
> +		return ret;


I would definitely keep this code the way it is here in
nvme_init_identify(), but if I read this right, your
nvme_thermal_zones_register() will never return < 0, and therefore this
condition is never met.

I would suggest you simply propagate the errors and keep this piece
of code the way it is, propagating errors too.

> +
>  	ctrl->identified = true;
>  
>  	return 0;
> @@ -3756,6 +4043,7 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
>  {
>  	nvme_mpath_stop(ctrl);
>  	nvme_stop_keep_alive(ctrl);
> +	nvme_thermal_zones_unregister(ctrl);
>  	flush_work(&ctrl->async_event_work);
>  	cancel_work_sync(&ctrl->fw_act_work);
>  }
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 802aa19..53f0b24 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -15,6 +15,7 @@
>  #include <linux/sed-opal.h>
>  #include <linux/fault-inject.h>
>  #include <linux/rcupdate.h>
> +#include <linux/thermal.h>
>  
>  extern unsigned int nvme_io_timeout;
>  #define NVME_IO_TIMEOUT	(nvme_io_timeout * HZ)
> @@ -248,6 +249,14 @@ struct nvme_ctrl {
>  
>  	struct page *discard_page;
>  	unsigned long discard_page_busy;
> +
> +#ifdef CONFIG_THERMAL
> +	/*
> +	 * tzdev[0]: composite temperature
> +	 * tzdev[1-8]: temperature sensor 1 through 8
> +	 */
> +	struct thermal_zone_device *tzdev[9];
> +#endif
>  };
>  
>  enum nvme_iopolicy {
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 658ac75..54f0a13 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -780,6 +780,11 @@ struct nvme_write_zeroes_cmd {
>  
>  /* Features */
>  
> +enum {
> +	NVME_TEMP_THRESH_MASK		= 0xffff,
> +	NVME_TEMP_THRESH_SELECT_SHIFT	= 16,
> +};
> +
>  struct nvme_feat_auto_pst {
>  	__le64 entries[32];
>  };
> -- 
> 2.7.4
> 
