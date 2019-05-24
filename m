Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E940D28F28
	for <lists+linux-pm@lfdr.de>; Fri, 24 May 2019 04:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfEXCf0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 May 2019 22:35:26 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34932 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731752AbfEXCf0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 May 2019 22:35:26 -0400
Received: by mail-pg1-f196.google.com with SMTP id t1so4169077pgc.2
        for <linux-pm@vger.kernel.org>; Thu, 23 May 2019 19:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LUgxF60OTbMNy6s9uKVW7xrioq5cVfZVd0zFDDAFqlw=;
        b=u4FWXcJdVxSz1D6T13Oos61aUkRj0YPmoQxmuOBysegqCOzy+UcdOYwhO9uPB/3WGa
         TJun0F5NiHv+ze7ixzIsPL9C2E5LVPcSVokfxnMjffkdS/JlSQ6JYur2EI+N1hi/JKS/
         YlKC6rCdiz85St2dppaTALQSXIaNkbsGD+zVekrQyYY4O1MzI5OZ0MxYJJX+pb6Y7tv0
         +g0mdIHpV/O4dK4X808iEqDXJmj0eVIh4/2HqhZ7zptM0EaK8PWdEc+3Nq39GU3B/ORf
         6xbNaQC9DvT6NQNZ4GtjS6HkidfnL6ot0+cGBj7TRor+0UoY5kenk7uPOvXHPMe2vo7h
         Mw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LUgxF60OTbMNy6s9uKVW7xrioq5cVfZVd0zFDDAFqlw=;
        b=fHKlTDjZt2s1/1/WESyuLHFJBIIOrzNWFp9lscWxdKGmboQwNxYhZNOF6KutH7v5Ls
         R5LqpQK9e+Ohsh/GbOFlQVAmE3qroI+TpMx5ZYgoXlAk+ZqEliij0t3QiJRzYFnFyL/A
         1wVOWt/rLLg+cN/ebAEXLQLRFBS7QI/J7SUF67AjdCIMq03CpwjmzWnT6UHRJwaIcOIY
         IymzUEsXp8ISJ4te0aUyr8CqtUyavwgSgKQI3q+Z/wVbRKdR2CdUXa4w0K85xj2cVzCx
         7azaUsRM+Ijp0zEdaC9dbsgNvtG3DCYrZWhiYe7un9nH8VMHk8YDvPAk8NM90E85IITD
         RiIA==
X-Gm-Message-State: APjAAAXlesv+Ep/ehsRMkhGdNSyjyf7dLCCbWHjAMBFmoVf5sES2yHok
        NpvHtqYc+JptshiDbGokV5g=
X-Google-Smtp-Source: APXvYqw+Q7RI96c5sW7zGe1fJrVlfONSlLFLUaqFBTeLwPGfJEMkryo7m9NeAX4ZUwEbak7xLPMYHQ==
X-Received: by 2002:a17:90a:2a85:: with SMTP id j5mr6132025pjd.107.1558665324869;
        Thu, 23 May 2019 19:35:24 -0700 (PDT)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id j2sm810050pfb.157.2019.05.23.19.35.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 19:35:24 -0700 (PDT)
Date:   Thu, 23 May 2019 19:35:22 -0700
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
Subject: Re: [PATCH v2 2/4] nvme: add thermal zone infrastructure
Message-ID: <20190524023520.GC1936@localhost.localdomain>
References: <1558454649-28783-1-git-send-email-akinobu.mita@gmail.com>
 <1558454649-28783-3-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558454649-28783-3-git-send-email-akinobu.mita@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Mita,

On Wed, May 22, 2019 at 01:04:07AM +0900, Akinobu Mita wrote:
> The NVMe controller reports up to nine temperature values in the SMART /
> Health log page (the composite temperature and temperature sensor 1 through
> temperature sensor 8).

Is this a fixed number or we should be more flexible on the amount of
sensors?

> The temperature threshold feature (Feature Identifier 04h) configures the
> asynchronous event request command to complete when the temperature is
> crossed its corresponding temperature threshold.
> 
> This adds infrastructure to provide these temperatures and thresholds via
> thermal zone devices.
> 
> The nvme_thermal_zones_register() creates up to nine thermal zone devices
> for all implemented temperature sensors including the composite
> temperature.

great!

> 
> /sys/class/thermal/thermal_zone[0-*]:
>     |---temp: Temperature
>     |---trip_point_0_temp: Over temperature threshold
> 
> The thermal_zone[0-*] contains a symlink to the corresponding nvme device.
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
> Cc: Minwoo Im <minwoo.im.dev@gmail.com>
> Cc: Kenneth Heitke <kenneth.heitke@intel.com>
> Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> ---
> * v2
> - s/correspoinding/corresponding/ typo in commit log
> - Borrowed nvme_get_features() from Keith's patch
> - Temperature threshold notification is splitted into another patch
> - Change the data type of 'sensor' to unsigned
> - Add BUILD_BUG_ON for the array size of tzdev member in nvme_ctrl
> - Add WARN_ON_ONCE for paranoid checks
> - Fix off-by-one error in nvme_get_temp
> - Validate 'sensor' where the value is actually used
> - Define and utilize two enums related to the temperature threshold feature
> - Remove hysteresis value for this trip point and don't utilize the under
>   temperature threshold
> - Print error message for thermal_zone_device_register() failure
> - Add function comments for nvme_thermal_zones_{,un}register
> - Suppress non-fatal errors from nvme_thermal_zones_register()
> - Add comment about implemented temperature sensors 
> - Instead of creating a new 'thermal_work', append async smart event's
>   action to the existing async_event_work
> - Add comment for tzdev member in nvme_ctrl
> 
>  drivers/nvme/host/core.c | 265 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/nvme/host/nvme.h |  27 +++++
>  include/linux/nvme.h     |   5 +
>  3 files changed, 297 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index c04df80..0ec303c 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2179,6 +2179,271 @@ static void nvme_set_latency_tolerance(struct device *dev, s32 val)
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

When would this be triggered?

> +
> +	if (WARN_ON_ONCE(sensor > ARRAY_SIZE(log->temp_sensor)))
> +		return -EINVAL;
> +
> +	log = kzalloc(sizeof(*log), GFP_KERNEL);

Do we really need to allocate memory every time we want to read
temperature? Is this struct too large to fit stack?

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
> +	if (!*temp)
> +		ret = -EINVAL;
> +
> +free_log:
> +	kfree(log);
> +
> +	return ret;
> +}
> +
> +static unsigned int nvme_tz_type_to_sensor(const char *type)
> +{
> +	unsigned int sensor;
> +
> +	if (sscanf(type, "nvme_temp%u", &sensor) != 1)
> +		return UINT_MAX;
> +
> +	return sensor;
> +}
> +
> +#define KELVIN_TO_MILLICELSIUS(t) DECI_KELVIN_TO_MILLICELSIUS((t) * 10)
> +#define MILLICELSIUS_TO_KELVIN(t) ((MILLICELSIUS_TO_DECI_KELVIN(t) + 5) / 10)
> +
> +static int nvme_tz_get_temp(struct thermal_zone_device *tzdev,
> +			    int *temp)
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
> +	int status;
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
> +				&status);
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
> +	.no_hwmon = true,
> +};
> +
> +static struct thermal_zone_device *
> +nvme_thermal_zone_register(struct nvme_ctrl *ctrl, unsigned int sensor)
> +{
> +	struct thermal_zone_device *tzdev;
> +	char type[THERMAL_NAME_LENGTH];
> +	int ret;
> +
> +	snprintf(type, sizeof(type), "nvme_temp%d", sensor);
> +

Do we have something more meaningful or descriptive here? A more
interesting type would be a string that could remind of the sensor
location. Unless nvme_temp0 is enough to understand where this
temperature is coming from, I would ask to get something more
descriptive.

> +	tzdev = thermal_zone_device_register(type, 1, 1, ctrl, &nvme_tz_ops,
> +					     &nvme_tz_params, 0, 0);

Have you considered if there is a use case for using of-thermal here?

> +	if (IS_ERR(tzdev)) {
> +		dev_err(ctrl->device,
> +			"Failed to register thermal zone device: %ld\n",
> +			PTR_ERR(tzdev));
> +		return tzdev;
> +	}
> +
> +	ret = sysfs_create_link(&ctrl->ctrl_device.kobj,
> +				&tzdev->device.kobj, type);
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
> +	sysfs_remove_link(&ctrl->ctrl_device.kobj, type);
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
> +int nvme_thermal_zones_register(struct nvme_ctrl *ctrl)
> +{
> +	struct nvme_smart_log *log;
> +	int ret;
> +	int i;
> +
> +	log = kzalloc(sizeof(*log), GFP_KERNEL);
> +	if (!log)
> +		return 0; /* non-fatal error */
> +
> +	ret = nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_SMART, 0,
> +			   log, sizeof(*log), 0);
> +	if (ret) {
> +		dev_err(ctrl->device, "Failed to get SMART log: %d\n", ret);
> +		ret = ret > 0 ? -EINVAL : ret;
> +		goto free_log;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(ctrl->tzdev); i++) {
> +		struct thermal_zone_device *tzdev;
> +
> +		/*
> +		 * All implemented temperature sensors report a non-zero value
> +		 * in temperature sensor fields in the smart log page.
> +		 */
> +		if (i && !le16_to_cpu(log->temp_sensor[i - 1]))
> +			continue;
> +		if (ctrl->tzdev[i])
> +			continue;
> +
> +		tzdev = nvme_thermal_zone_register(ctrl, i);
> +		if (!IS_ERR(tzdev))
> +			ctrl->tzdev[i] = tzdev;
> +	}
> +
> +free_log:
> +	kfree(log);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(nvme_thermal_zones_register);
> +
> +/**
> + * nvme_thermal_zones_unregister() - unregister nvme thermal zone devices
> + * @ctrl: controller instance
> + *
> + * This function removes the registered thermal zone devices and symlinks.
> + */
> +void nvme_thermal_zones_unregister(struct nvme_ctrl *ctrl)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(ctrl->tzdev); i++) {
> +		struct thermal_zone_device *tzdev = ctrl->tzdev[i];
> +
> +		if (!tzdev)
> +			continue;
> +
> +		sysfs_remove_link(&tzdev->device.kobj, "device");
> +		sysfs_remove_link(&ctrl->ctrl_device.kobj, tzdev->type);
> +		thermal_zone_device_unregister(tzdev);
> +
> +		ctrl->tzdev[i] = NULL;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(nvme_thermal_zones_unregister);
> +
> +#endif /* CONFIG_THERMAL */
> +
>  struct nvme_core_quirk_entry {
>  	/*
>  	 * NVMe model and firmware strings are padded with spaces.  For
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index bb673b8..0bc4e85 100644
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
> @@ -559,6 +568,24 @@ static inline void nvme_mpath_stop(struct nvme_ctrl *ctrl)
>  }
>  #endif /* CONFIG_NVME_MULTIPATH */
>  
> +#ifdef CONFIG_THERMAL
> +
> +int nvme_thermal_zones_register(struct nvme_ctrl *ctrl);
> +void nvme_thermal_zones_unregister(struct nvme_ctrl *ctrl);
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
>  #ifdef CONFIG_NVM
>  int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node);
>  void nvme_nvm_unregister(struct nvme_ns *ns);
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
