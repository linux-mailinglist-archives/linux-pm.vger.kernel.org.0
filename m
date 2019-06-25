Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2DDE5524C
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2019 16:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730764AbfFYOo6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 10:44:58 -0400
Received: from mga14.intel.com ([192.55.52.115]:29246 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730505AbfFYOo6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Jun 2019 10:44:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2019 07:44:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,416,1557212400"; 
   d="scan'208";a="184511718"
Received: from syhu-mobl.ccr.corp.intel.com ([10.249.173.95])
  by fmsmga004.fm.intel.com with ESMTP; 25 Jun 2019 07:44:54 -0700
Message-ID: <1561473887.19713.6.camel@intel.com>
Subject: Re: [PATCH v4 3/3] nvme: notify thermal framework when temperature
 threshold events occur
From:   Zhang Rui <rui.zhang@intel.com>
To:     Akinobu Mita <akinobu.mita@gmail.com>,
        linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Kenneth Heitke <kenneth.heitke@intel.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Date:   Tue, 25 Jun 2019 22:44:47 +0800
In-Reply-To: <1560439238-4054-4-git-send-email-akinobu.mita@gmail.com>
References: <1560439238-4054-1-git-send-email-akinobu.mita@gmail.com>
         <1560439238-4054-4-git-send-email-akinobu.mita@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 五, 2019-06-14 at 00:20 +0900, Akinobu Mita wrote:
> The NVMe controller supports the temperature threshold feature
> (Feature
> Identifier 04h) that enables to configure the asynchronous event
> request
> command to complete when the temperature is crossed its corresponding
> temperature threshold.
> 
> This enables the reporting of asynchronous events from the controller
> when
> the temperature reached or exceeded a temperature threshold.
> In the case of the temperature threshold conditions, this notifies
> the
> thermal framework.
> 
> The main purpose of this is to turn on a fan when overheated without
> polling the device for the smart log that could prevent the lower
> power
> state transitions.
> 
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Jens Axboe <axboe@fb.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Minwoo Im <minwoo.im.dev@gmail.com>
> Cc: Kenneth Heitke <kenneth.heitke@intel.com>
> Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> ---
> * v4
> - support DT thermal zone device.
> - use bitmap to iterate over implemented sensors
> 
>  drivers/nvme/host/core.c    | 14 ++++++++++++++
>  drivers/nvme/host/nvme.h    |  5 +++++
>  drivers/nvme/host/thermal.c | 12 ++++++++++++
>  include/linux/nvme.h        |  7 +++++++
>  4 files changed, 38 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 4be339b..44dadbb 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1186,6 +1186,9 @@ static void nvme_enable_aen(struct nvme_ctrl
> *ctrl)
>  	u32 result, supported_aens = ctrl->oaes &
> NVME_AEN_SUPPORTED;
>  	int status;
>  
> +	if (IS_ENABLED(CONFIG_THERMAL))
> +		supported_aens |= NVME_SMART_CRIT_TEMPERATURE;
> +
>  	if (!supported_aens)
>  		return;
>  
> @@ -3561,6 +3564,16 @@ void nvme_remove_namespaces(struct nvme_ctrl
> *ctrl)
>  }
>  EXPORT_SYMBOL_GPL(nvme_remove_namespaces);
>  
> +static void nvme_handle_aen_smart(struct nvme_ctrl *ctrl, u32
> result)
> +{
> +	u32 aer_type = result & NVME_AER_TYPE_MASK;
> +	u32 aer_info = (result >> NVME_AER_INFO_SHIFT) &
> NVME_AER_INFO_MASK;
> +
> +	if (aer_type == NVME_AER_SMART &&
> +	    aer_info == NVME_AER_SMART_TEMP_THRESH)
> +		nvme_thermal_notify_framework(ctrl);
> +}
> +
>  static void nvme_aen_uevent(struct nvme_ctrl *ctrl)
>  {
>  	char *envp[2] = { NULL, NULL };
> @@ -3582,6 +3595,7 @@ static void nvme_async_event_work(struct
> work_struct *work)
>  	struct nvme_ctrl *ctrl =
>  		container_of(work, struct nvme_ctrl,
> async_event_work);
>  
> +	nvme_handle_aen_smart(ctrl, ctrl->aen_result);
>  	nvme_aen_uevent(ctrl);
>  	ctrl->ops->submit_async_event(ctrl);
>  }
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index a9c63ea..40325b6 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -605,6 +605,7 @@ static inline struct nvme_ns
> *nvme_get_ns_from_dev(struct device *dev)
>  
>  int nvme_thermal_zones_register(struct nvme_ctrl *ctrl);
>  void nvme_thermal_zones_unregister(struct nvme_ctrl *ctrl);
> +void nvme_thermal_notify_framework(struct nvme_ctrl *ctrl);
>  
>  #else
>  
> @@ -617,6 +618,10 @@ static inline void
> nvme_thermal_zones_unregister(struct nvme_ctrl *ctrl)
>  {
>  }
>  
> +static inline void nvme_thermal_notify_framework(struct nvme_ctrl
> *ctrl)
> +{
> +}
> +
>  #endif /* CONFIG_THERMAL */
>  
>  #endif /* _NVME_H */
> diff --git a/drivers/nvme/host/thermal.c
> b/drivers/nvme/host/thermal.c
> index 18d0e4c..b5e835d 100644
> --- a/drivers/nvme/host/thermal.c
> +++ b/drivers/nvme/host/thermal.c
> @@ -309,3 +309,15 @@ void nvme_thermal_zones_unregister(struct
> nvme_ctrl *ctrl)
>  		__clear_bit(i, ctrl->tz_enabled);
>  	}
>  }
> +
> +void nvme_thermal_notify_framework(struct nvme_ctrl *ctrl)
> +{
> +	int i;
> +
> +	for_each_set_bit(i, ctrl->tz_enabled, ARRAY_SIZE(ctrl->tz))
> {
> +		if (ctrl->tz[i].dev)
> +			thermal_notify_framework(ctrl->tz[i].dev,
> 0);

I'd prefer to use thermal_zone_device_update() here to notify the
thermal framework.
thermal_notify_framework() will be removed sometime later.

thanks,
rui

> +		if (ctrl->tz[i].of_dev)
> +			thermal_notify_framework(ctrl->tz[i].of_dev, 
> 0);
> +	}
> +}
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index f29728b..069b962 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -476,6 +476,7 @@ enum {
>  };
>  
>  enum {
> +	NVME_AER_TYPE_MASK		= 0x7,
>  	NVME_AER_ERROR			= 0,
>  	NVME_AER_SMART			= 1,
>  	NVME_AER_NOTICE			= 2,
> @@ -484,6 +485,12 @@ enum {
>  };
>  
>  enum {
> +	NVME_AER_INFO_SHIFT		= 8,
> +	NVME_AER_INFO_MASK		= 0xff,
> +	NVME_AER_SMART_TEMP_THRESH	= 0x01,
> +};
> +
> +enum {
>  	NVME_AER_NOTICE_NS_CHANGED	= 0x00,
>  	NVME_AER_NOTICE_FW_ACT_STARTING = 0x01,
>  	NVME_AER_NOTICE_ANA		= 0x03,
