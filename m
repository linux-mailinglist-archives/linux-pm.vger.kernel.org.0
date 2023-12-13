Return-Path: <linux-pm+bounces-1116-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC0F811CA8
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 19:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9BE928297F
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 18:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC4525542;
	Wed, 13 Dec 2023 18:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gjR1spsA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32F2BD
	for <linux-pm@vger.kernel.org>; Wed, 13 Dec 2023 10:35:34 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40c38e292c8so29617215e9.0
        for <linux-pm@vger.kernel.org>; Wed, 13 Dec 2023 10:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702492533; x=1703097333; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LKuXKmjVQly0gMamhDtWw1YWn3TXGpnwbH4HprFkcGY=;
        b=gjR1spsA2Rtqyzhqi6voBLugr8gv1be0Rapc3PTL4KGB5+uf5P8J8Dd7Cyoa5QOSYj
         IywapeKzIXTtiNYjTCTXdXKEXZ3YBZqCu/z/VufhIfKqmCG8SCrShAs0GrMH+rrqxOW4
         Goro4+Ki7Mqz1NQ6xrCh9ildwH4GuZCoBR3B/WZh4mx5uliRpEU45dqdv2kJSBcDOjNF
         BuXVOxApCsf34P76iYckvRU4Zs8xQQ6//mHs/Cz89+Xit7rOb9Y92YkDrjBM/EADhJf7
         XTnfZTjObSdRGz8LOeNiDOruAmvSwOB3avB/zladHp0Cyff/r/vroNy/EUHpCu7sX1WD
         NARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702492533; x=1703097333;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LKuXKmjVQly0gMamhDtWw1YWn3TXGpnwbH4HprFkcGY=;
        b=nM4xWBIkmjd2m/ITY6DjWLd9p5yNS0QJpYE/Sa+gEMf6Y2ELL8RhOwbzrWoCvyphhx
         Ugurp9sSymkRPCtD0Y50c+TiMpvLOQuu0OgDRSpkoref7vkk036/9BkJN8R3wL2VyXHN
         +/ZvSj4UrEs34x4TPEqYg+yoMzpfTWI+qH13Gzm0inw/WFrRySqmffCJLJ6395ufBejn
         quTZHd8QFriMo7cbNJqUkxSXUEo5kKhkMXQkAt7wt6XUadYRUxAfemhjsGF/pEEBNUTx
         7mnneUAoRy0t9CGrt0JC9JYjcG++t+8XfcGmXwxluH7lENpzcHbSWyvxsZVqTOmeVxWc
         ci8A==
X-Gm-Message-State: AOJu0YztS98QXSopmIsBV4abFecThdSw7yZUBwpFCRB8Zqq31vco28XI
	2YMTSE8PQtZNLw7O2T9pW/iGcA==
X-Google-Smtp-Source: AGHT+IFg4pLRGqtc/rV+c7DRYDWM8gkTNa6NSBAq8yymhR0IIqd0e9PySnVe75eGgSRg1Awy6L1YgA==
X-Received: by 2002:a05:600c:b50:b0:40b:5e26:237f with SMTP id k16-20020a05600c0b5000b0040b5e26237fmr4099882wmr.48.1702492533155;
        Wed, 13 Dec 2023 10:35:33 -0800 (PST)
Received: from [192.168.1.83] (host-92-17-96-230.as13285.net. [92.17.96.230])
        by smtp.gmail.com with ESMTPSA id b16-20020a05600c4e1000b0040c310abc4bsm21834012wmq.43.2023.12.13.10.35.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 10:35:32 -0800 (PST)
Message-ID: <9f8566b8-71d3-4dbd-8bde-f9a4cfde8372@linaro.org>
Date: Wed, 13 Dec 2023 18:35:31 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] PM: QoS: Add a performance QoS
Content-Language: en-US
To: Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc: lina.iyer@linaro.org, lukasz.luba@arm.com, quic_manafm@quicinc.com,
 quic_priyjain@quicinc.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231213175818.2826876-1-daniel.lezcano@linaro.org>
 <20231213175818.2826876-2-daniel.lezcano@linaro.org>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20231213175818.2826876-2-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Daniel,

On 13/12/2023 17:58, Daniel Lezcano wrote:
> Currently cpufreq and devfreq are using the freq QoS to aggregate the
> requests for frequency ranges.
> 
> However, there are new devices wanting to act not on a frequency range
> but on a performance index range. Those need also to export to
> userspace the knob to act on their performance limits.
> 
> This change provides a performance limiter QoS based on a minimum /
> maximum performance values. At init time, the limits of the interval
> are 0 / 1024. It is up to the backend to convert the 1024 to the
> maximum performance state. So if the performance must be limited to
> 50%, it should set to maximum limit to 512 where the backend will end
> up by converting (max performance index / 2). The same applies for the
> minimum. Obviously, the min can not be greater than the max.

I really feel like it should be possible to have arbitrary min/max
performance values. As is the case with latency and frequency.
> 
>  1. With the example above, if there is a odd number like 5 for the
>  number of performance indexes and we ask for 512 (so 50%), what would
>  be the performance index computed? (5/2=2 or 5/2=3)? (I would say the
>  minimum otherwise we end up with a performance limit greater than
>  what we actually asked for).

For a device with just a handful of performance indices this is quite a
large margin for error. If there are just 3 for example, and some
algorithm is decreasing the performance level over time (e.g. due to
some thermal condition), the algorithm cannot determine at what point
the devices performance level has actually changed, making debugging and
tuning of behaviour needlessly difficult.

This also leaves it up to the backend driver to decide if it should
round up or down, something that should definitely be handled by the
framework.

Maybe I missed some previous discussion, but isn't this what
operating-points is designed for?

It has an `opp-level` property, but that is meant to be device-specific.
With the `opp-hz` property being the "normalised" values that the
framework deals with.

We would just want some way to defined an `opp-level` as a percentage
(or whatever), with an arbitrary `opp-performance-index` being the
device-specific property.

This also gracefully handles non-linear performance scaling.
> 
>  2. The conversion from 1024 to a performance index will inevatibly
>  end up to a state above or below the percentage given. Shall it be
>  reflected in the value set? eg. We want to apply a performance limit
>  to be 33% maximum. So it is, 1024 x 0.333333 = 314. If there are 20
>  performance indexes, that will be (20 x 314) / 1024 = 6.13, so index
>  6. Shall we convert this index back to the requested performance
>  limit to (6.13 x 1024) / 20 = 307 ? (So requested is 314 but it is
>  actually 307).>
> The end goal is to make the freq QoS and perf QoS to co-exist together
> in the next changes in the different backends. A change of one of the
> QoS impacts the other. For instance if there are 5 performance states
> and we set a performance limit to 80%, then the maximum state will 4.
> 
> For the long term, when those can co-exist, then we can implement a
> cooling device based on the performance Qos which will be generic for
> all devices using this QoS. That will imply the CPUs, the GPUs and any
> devfreq devices. So devfreq and cpufreq cooling devices can be merged
> into a single performance cooling device which will be generic for all
> devices with a performance limit QoS.
> 
> In a similar way, in the future, a power QoS could be added also and a
> power based cooling device. So any device with the energy model and a
> power capping feature can become a cooling device and the power
> computation part in the cooling devices will move to the back ends. We
> will end up with a generic power cooling device compatible with all
> power capable devices.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/base/power/power.h |   2 +
>  drivers/base/power/qos.c   | 158 +++++++++++++++++++++++++-
>  drivers/base/power/sysfs.c |  92 +++++++++++++++
>  include/linux/cpufreq.h    |   2 +
>  include/linux/pm_qos.h     |  42 +++++++
>  kernel/power/qos.c         | 225 +++++++++++++++++++++++++++++++++++++
>  6 files changed, 517 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
> index 922ed457db19..eb1a77a7a0f4 100644
> --- a/drivers/base/power/power.h
> +++ b/drivers/base/power/power.h
> @@ -78,6 +78,8 @@ extern int pm_qos_sysfs_add_flags(struct device *dev);
>  extern void pm_qos_sysfs_remove_flags(struct device *dev);
>  extern int pm_qos_sysfs_add_latency_tolerance(struct device *dev);
>  extern void pm_qos_sysfs_remove_latency_tolerance(struct device *dev);
> +extern int pm_qos_sysfs_add_perf_limit(struct device *dev);
> +extern void pm_qos_sysfs_remove_perf_limit(struct device *dev);
>  extern int dpm_sysfs_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid);
>  
>  #else /* CONFIG_PM */
> diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
> index ae0b9d2573ec..a71cff1f8048 100644
> --- a/drivers/base/power/qos.c
> +++ b/drivers/base/power/qos.c
> @@ -128,6 +128,14 @@ s32 dev_pm_qos_read_value(struct device *dev, enum dev_pm_qos_req_type type)
>  		ret = IS_ERR_OR_NULL(qos) ? PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE
>  			: freq_qos_read_value(&qos->freq, FREQ_QOS_MAX);
>  		break;
> +	case DEV_PM_QOS_MIN_PERF:
> +		ret =  IS_ERR_OR_NULL(qos) ? PM_QOS_MIN_PERF_DEFAULT_VALUE
> +			: perf_qos_read_value(&qos->perf, RANGE_QOS_MIN);
> +		break;
> +	case DEV_PM_QOS_MAX_PERF:
> +		ret =  IS_ERR_OR_NULL(qos) ? PM_QOS_MAX_PERF_DEFAULT_VALUE
> +			: perf_qos_read_value(&qos->perf, RANGE_QOS_MAX);
> +		break;
>  	default:
>  		WARN_ON(1);
>  		ret = 0;
> @@ -177,6 +185,10 @@ static int apply_constraint(struct dev_pm_qos_request *req,
>  		ret = pm_qos_update_flags(&qos->flags, &req->data.flr,
>  					  action, value);
>  		break;
> +	case DEV_PM_QOS_MIN_PERF:
> +	case DEV_PM_QOS_MAX_PERF:
> +		ret = perf_qos_apply(&req->data.perf, action, value);
> +		break;
>  	default:
>  		ret = -EINVAL;
>  	}
> @@ -223,6 +235,20 @@ static int dev_pm_qos_constraints_allocate(struct device *dev)
>  	c->no_constraint_value = PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT;
>  	c->type = PM_QOS_MIN;
>  
> +	c = &qos->perf.lower_bound;
> +	plist_head_init(&c->list);
> +	c->target_value = PM_QOS_MIN_PERF_DEFAULT_VALUE;
> +	c->default_value = PM_QOS_MIN_PERF_DEFAULT_VALUE;
> +	c->no_constraint_value = PM_QOS_MIN_PERF_DEFAULT_VALUE;
> +	c->type = PM_QOS_MAX;
> +
> +	c = &qos->perf.upper_bound;
> +	plist_head_init(&c->list);
> +	c->target_value = PM_QOS_MAX_PERF_DEFAULT_VALUE;
> +	c->default_value = PM_QOS_MAX_PERF_DEFAULT_VALUE;
> +	c->no_constraint_value = PM_QOS_MAX_PERF_DEFAULT_VALUE;
> +	c->type = PM_QOS_MIN;
> +
>  	freq_constraints_init(&qos->freq);
>  
>  	INIT_LIST_HEAD(&qos->flags.list);
> @@ -299,6 +325,20 @@ void dev_pm_qos_constraints_destroy(struct device *dev)
>  		memset(req, 0, sizeof(*req));
>  	}
>  
> +	c = &qos->perf.lower_bound;
> +	plist_for_each_entry_safe(req, tmp, &c->list, data.freq.pnode) {
> +		apply_constraint(req, PM_QOS_REMOVE_REQ,
> +				 PM_QOS_MIN_PERF_DEFAULT_VALUE);
> +		memset(req, 0, sizeof(*req));
> +	}
> +
> +	c = &qos->perf.upper_bound;
> +	plist_for_each_entry_safe(req, tmp, &c->list, data.freq.pnode) {
> +		apply_constraint(req, PM_QOS_REMOVE_REQ,
> +				 PM_QOS_MAX_PERF_DEFAULT_VALUE);
> +		memset(req, 0, sizeof(*req));
> +	}
> +	
>  	f = &qos->flags;
>  	list_for_each_entry_safe(req, tmp, &f->list, data.flr.node) {
>  		apply_constraint(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
> @@ -349,17 +389,32 @@ static int __dev_pm_qos_add_request(struct device *dev,
>  
>  	req->dev = dev;
>  	req->type = type;
> -	if (req->type == DEV_PM_QOS_MIN_FREQUENCY)
> +
> +	switch (type) {
> +	case DEV_PM_QOS_MIN_FREQUENCY:
>  		ret = freq_qos_add_request(&dev->power.qos->freq,
>  					   &req->data.freq,
>  					   FREQ_QOS_MIN, value);
> -	else if (req->type == DEV_PM_QOS_MAX_FREQUENCY)
> +		break;
> +	case DEV_PM_QOS_MAX_FREQUENCY:
>  		ret = freq_qos_add_request(&dev->power.qos->freq,
>  					   &req->data.freq,
>  					   FREQ_QOS_MAX, value);
> -	else
> +		break;
> +	case DEV_PM_QOS_MIN_PERF:
> +		ret = perf_qos_add_request(&dev->power.qos->perf,
> +					   &req->data.perf,
> +					   RANGE_QOS_MIN, value);
> +		break;
> +	case DEV_PM_QOS_MAX_PERF:
> +		ret = perf_qos_add_request(&dev->power.qos->perf,
> +					   &req->data.perf,
> +					   RANGE_QOS_MAX, value);
> +		break;
> +	default:
>  		ret = apply_constraint(req, PM_QOS_ADD_REQ, value);
> -
> +		break;
> +	}
>  	return ret;
>  }
>  
> @@ -427,6 +482,10 @@ static int __dev_pm_qos_update_request(struct dev_pm_qos_request *req,
>  	case DEV_PM_QOS_MAX_FREQUENCY:
>  		curr_value = req->data.freq.pnode.prio;
>  		break;
> +	case DEV_PM_QOS_MIN_PERF:
> +	case DEV_PM_QOS_MAX_PERF:
> +		curr_value = req->data.perf.pnode.prio;
> +		break;
>  	case DEV_PM_QOS_FLAGS:
>  		curr_value = req->data.flr.flags;
>  		break;
> @@ -674,6 +733,14 @@ static void __dev_pm_qos_drop_user_request(struct device *dev,
>  		req = dev->power.qos->flags_req;
>  		dev->power.qos->flags_req = NULL;
>  		break;
> +	case DEV_PM_QOS_MIN_PERF:
> +		req = dev->power.qos->perf_min_req;
> +		dev->power.qos->perf_min_req = NULL;
> +		break;
> +	case DEV_PM_QOS_MAX_PERF:
> +		req = dev->power.qos->perf_max_req;
> +		dev->power.qos->perf_max_req = NULL;
> +		break;
>  	default:
>  		WARN_ON(1);
>  		return;
> @@ -980,3 +1047,86 @@ void dev_pm_qos_hide_latency_tolerance(struct device *dev)
>  	pm_runtime_put(dev);
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_qos_hide_latency_tolerance);
> +
> +int dev_pm_qos_expose_perf_limit(struct device *dev)
> +{
> +	struct dev_pm_qos_request *req_min;
> +	struct dev_pm_qos_request *req_max;
> +	int ret;
> +
> +	if (!device_is_registered(dev))
> +		return -EINVAL;
> +
> +	req_min = kzalloc(sizeof(*req_min), GFP_KERNEL);
> +	if (!req_min)
> +		return -ENOMEM;
> +
> +	req_max = kzalloc(sizeof(*req_max), GFP_KERNEL);
> +	if (!req_max) {
> +		kfree(req_min);
> +		return -ENOMEM;
> +	}
> +	
> +	ret = dev_pm_qos_add_request(dev, req_min, DEV_PM_QOS_MIN_PERF,
> +				     PM_QOS_MIN_PERF_DEFAULT_VALUE);
> +	if (ret < 0) {
> +		kfree(req_min);
> +		kfree(req_max);
> +		return ret;
> +	}
> +
> +	ret = dev_pm_qos_add_request(dev, req_max, DEV_PM_QOS_MAX_PERF,
> +				     PM_QOS_MAX_PERF_DEFAULT_VALUE);
> +	if (ret < 0) {
> +		dev_pm_qos_drop_user_request(dev, DEV_PM_QOS_MIN_PERF);
> +		return ret;
> +	}
> +
> +	mutex_lock(&dev_pm_qos_sysfs_mtx);
> +
> +	mutex_lock(&dev_pm_qos_mtx);
> +
> +	if (IS_ERR_OR_NULL(dev->power.qos))
> +		ret = -ENODEV;
> +	else if (dev->power.qos->perf_min_req || dev->power.qos->perf_max_req)
> +		ret = -EEXIST;
> +
> +	if (ret < 0) {
> +		__dev_pm_qos_drop_user_request(dev, DEV_PM_QOS_MIN_PERF);
> +		__dev_pm_qos_drop_user_request(dev, DEV_PM_QOS_MAX_PERF);
> +		mutex_unlock(&dev_pm_qos_mtx);
> +		goto out;
> +	}
> +
> +	dev->power.qos->perf_min_req = req_min;
> +	dev->power.qos->perf_max_req = req_max;
> +
> +	mutex_unlock(&dev_pm_qos_mtx);
> +
> +	ret = pm_qos_sysfs_add_perf_limit(dev);
> +	if (ret) {
> +		dev_pm_qos_drop_user_request(dev, DEV_PM_QOS_MIN_PERF);
> +		dev_pm_qos_drop_user_request(dev, DEV_PM_QOS_MAX_PERF);
> +	}
> +out:
> +	mutex_unlock(&dev_pm_qos_sysfs_mtx);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_qos_expose_perf_limit);
> +
> +void dev_pm_qos_hide_perf_limit(struct device *dev)
> +{
> +	mutex_lock(&dev_pm_qos_sysfs_mtx);
> +
> +	pm_qos_sysfs_remove_perf_limit(dev);
> +
> +	mutex_lock(&dev_pm_qos_mtx);
> +
> +	__dev_pm_qos_drop_user_request(dev, DEV_PM_QOS_MIN_PERF);
> +	__dev_pm_qos_drop_user_request(dev, DEV_PM_QOS_MAX_PERF);
> +	
> +	mutex_unlock(&dev_pm_qos_mtx);
> +
> +	mutex_unlock(&dev_pm_qos_sysfs_mtx);
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_qos_hide_perf_limit);
> diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
> index a1474fb67db9..5a45191006c1 100644
> --- a/drivers/base/power/sysfs.c
> +++ b/drivers/base/power/sysfs.c
> @@ -317,6 +317,76 @@ static ssize_t pm_qos_no_power_off_store(struct device *dev,
>  
>  static DEVICE_ATTR_RW(pm_qos_no_power_off);
>  
> +
> +static ssize_t pm_qos_perf_limit_min_max_show(struct device *dev,
> +					      struct device_attribute *attr,
> +					      char *buf, bool max)
> +{
> +	s32 value = dev_pm_qos_read_value(dev, max ? DEV_PM_QOS_MAX_PERF :
> +					  DEV_PM_QOS_MIN_PERF);
> +
> +	return sysfs_emit(buf, "%d\n", value);
> +}
> +
> +static ssize_t pm_qos_perf_limit_min_max_store(struct device *dev,
> +					       struct device_attribute *attr,
> +					       const char *buf, size_t n, bool max)
> +{
> +	int ret;
> +	s32 min_value = dev_pm_qos_read_value(dev, DEV_PM_QOS_MIN_PERF);
> +	s32 max_value = dev_pm_qos_read_value(dev, DEV_PM_QOS_MAX_PERF);
> +	s32 new_value;
> +
> +	if (kstrtoint(buf, 0, &new_value))
> +		return -EINVAL;
> +
> +	if (new_value < PM_QOS_MIN_PERF_DEFAULT_VALUE ||
> +	    new_value > PM_QOS_MAX_PERF_DEFAULT_VALUE)
> +		return -EINVAL;
> +
> +	if (max && (new_value < min_value))
> +		return -EINVAL;
> +
> +	if (!max && (new_value > max_value))
> +		return -EINVAL;
> +
> +	ret = dev_pm_qos_update_request(max ? dev->power.qos->perf_max_req :
> +					dev->power.qos->perf_min_req, new_value);
> +
> +	return ret < 0 ? ret : n;
> +}
> +
> +static ssize_t pm_qos_perf_limit_min_show(struct device *dev,
> +						 struct device_attribute *attr,
> +						 char *buf)
> +{
> +	return pm_qos_perf_limit_min_max_show(dev, attr, buf, false);
> +}
> +
> +static ssize_t pm_qos_perf_limit_min_store(struct device *dev,
> +						  struct device_attribute *attr,
> +						  const char *buf, size_t n)
> +{
> +	return pm_qos_perf_limit_min_max_store(dev, attr, buf, n, false);
> +}
> +
> +static ssize_t pm_qos_perf_limit_max_show(struct device *dev,
> +						 struct device_attribute *attr,
> +						 char *buf)
> +{
> +	return pm_qos_perf_limit_min_max_show(dev, attr, buf, true);
> +}
> +
> +static ssize_t pm_qos_perf_limit_max_store(struct device *dev,
> +						  struct device_attribute *attr,
> +						  const char *buf, size_t n)
> +{
> +	return pm_qos_perf_limit_min_max_store(dev, attr, buf, n, true);
> +}
> +
> +static DEVICE_ATTR_RW(pm_qos_perf_limit_min);
> +static DEVICE_ATTR_RW(pm_qos_perf_limit_max);
> +
>  #ifdef CONFIG_PM_SLEEP
>  static const char _enabled[] = "enabled";
>  static const char _disabled[] = "disabled";
> @@ -686,6 +756,17 @@ static struct attribute *pm_qos_flags_attrs[] = {
>  	&dev_attr_pm_qos_no_power_off.attr,
>  	NULL,
>  };
> +
> +static struct attribute *pm_qos_perf_limit_attrs[] = {
> +	&dev_attr_pm_qos_perf_limit_min.attr,
> +	&dev_attr_pm_qos_perf_limit_max.attr,
> +	NULL,
> +};
> +static const struct attribute_group pm_qos_perf_limit_attr_group = {
> +	.name	= power_group_name,
> +	.attrs	= pm_qos_perf_limit_attrs,
> +};
> +
>  static const struct attribute_group pm_qos_flags_attr_group = {
>  	.name	= power_group_name,
>  	.attrs	= pm_qos_flags_attrs,
> @@ -821,6 +902,17 @@ void pm_qos_sysfs_remove_latency_tolerance(struct device *dev)
>  	sysfs_unmerge_group(&dev->kobj, &pm_qos_latency_tolerance_attr_group);
>  }
>  
> +int pm_qos_sysfs_add_perf_limit(struct device *dev)
> +{
> +	return sysfs_merge_group(&dev->kobj,
> +				 &pm_qos_perf_limit_attr_group);
> +}
> +
> +void pm_qos_sysfs_remove_perf_limit(struct device *dev)
> +{
> +	sysfs_unmerge_group(&dev->kobj, &pm_qos_perf_limit_attr_group);
> +}
> +
>  void rpm_sysfs_remove(struct device *dev)
>  {
>  	sysfs_unmerge_group(&dev->kobj, &pm_runtime_attr_group);
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 08a8ba4bfd2d..b33fc4db4277 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -83,6 +83,8 @@ struct cpufreq_policy {
>  	struct range_constraints	constraints;
>  	struct range_qos_request	*min_freq_req;
>  	struct range_qos_request	*max_freq_req;
> +	struct range_qos_request	*min_perf_req;
> +	struct range_qos_request	*max_perf_req;
>  
>  	struct cpufreq_frequency_table	*freq_table;
>  	enum cpufreq_table_sorting freq_table_sorted;
> diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
> index 5f5d967ede32..ab4412877b59 100644
> --- a/include/linux/pm_qos.h
> +++ b/include/linux/pm_qos.h
> @@ -34,6 +34,8 @@ enum pm_qos_flags_status {
>  #define PM_QOS_LATENCY_TOLERANCE_DEFAULT_VALUE	0
>  #define PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE	0
>  #define PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE	FREQ_QOS_MAX_DEFAULT_VALUE
> +#define PM_QOS_MIN_PERF_DEFAULT_VALUE	0
> +#define PM_QOS_MAX_PERF_DEFAULT_VALUE	1024
>  #define PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT	(-1)
>  
>  #define PM_QOS_FLAG_NO_POWER_OFF	(1 << 0)
> @@ -102,6 +104,8 @@ enum dev_pm_qos_req_type {
>  	DEV_PM_QOS_LATENCY_TOLERANCE,
>  	DEV_PM_QOS_MIN_FREQUENCY,
>  	DEV_PM_QOS_MAX_FREQUENCY,
> +	DEV_PM_QOS_MIN_PERF,
> +	DEV_PM_QOS_MAX_PERF,
>  	DEV_PM_QOS_FLAGS,
>  };
>  
> @@ -111,6 +115,7 @@ struct dev_pm_qos_request {
>  		struct plist_node pnode;
>  		struct pm_qos_flags_request flr;
>  		struct range_qos_request freq;
> +		struct range_qos_request perf;
>  	} data;
>  	struct device *dev;
>  };
> @@ -119,10 +124,13 @@ struct dev_pm_qos {
>  	struct pm_qos_constraints resume_latency;
>  	struct pm_qos_constraints latency_tolerance;
>  	struct range_constraints freq;
> +	struct range_constraints perf;
>  	struct pm_qos_flags flags;
>  	struct dev_pm_qos_request *resume_latency_req;
>  	struct dev_pm_qos_request *latency_tolerance_req;
>  	struct dev_pm_qos_request *flags_req;
> +	struct dev_pm_qos_request *perf_min_req;
> +	struct dev_pm_qos_request *perf_max_req;
>  };
>  
>  /* Action requested to pm_qos_update_target */
> @@ -192,6 +200,8 @@ s32 dev_pm_qos_get_user_latency_tolerance(struct device *dev);
>  int dev_pm_qos_update_user_latency_tolerance(struct device *dev, s32 val);
>  int dev_pm_qos_expose_latency_tolerance(struct device *dev);
>  void dev_pm_qos_hide_latency_tolerance(struct device *dev);
> +int dev_pm_qos_expose_perf_limit(struct device *dev);
> +void dev_pm_qos_hide_perf_limit(struct device *dev);
>  
>  static inline s32 dev_pm_qos_requested_resume_latency(struct device *dev)
>  {
> @@ -228,6 +238,10 @@ static inline s32 dev_pm_qos_read_value(struct device *dev,
>  		return PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE;
>  	case DEV_PM_QOS_MAX_FREQUENCY:
>  		return PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE;
> +	case DEV_PM_QOS_MIN_PERF:
> +		return PM_QOS_MIN_PERF_DEFAULT_VALUE;
> +	case DEV_PM_QOS_MAX_PERF:
> +		return PM_QOS_MAX_PERF_DEFAULT_VALUE;
>  	default:
>  		WARN_ON(1);
>  		return 0;
> @@ -281,6 +295,10 @@ static inline int dev_pm_qos_expose_latency_tolerance(struct device *dev)
>  			{ return 0; }
>  static inline void dev_pm_qos_hide_latency_tolerance(struct device *dev) {}
>  
> +static inline int dev_pm_qos_expose_perf_limit(struct device *dev)
> +			{ return 0; }
> +void dev_pm_qos_hide_perf_limit(struct device *dev) {}
> +
>  static inline s32 dev_pm_qos_requested_resume_latency(struct device *dev)
>  {
>  	return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
> @@ -317,4 +335,28 @@ int freq_qos_remove_notifier(struct range_constraints *qos,
>  			     enum range_qos_req_type type,
>  			     struct notifier_block *notifier);
>  
> +static inline int perf_qos_request_active(struct range_qos_request *req)
> +{
> +	return !IS_ERR_OR_NULL(req->qos);
> +}
> +
> +s32 perf_qos_read_value(struct range_constraints *qos,
> +			enum range_qos_req_type type);
> +
> +int perf_qos_apply(struct range_qos_request *req,
> +		   enum pm_qos_req_action action, s32 value);
> +
> +int perf_qos_add_request(struct range_constraints *qos,
> +			 struct range_qos_request *req,
> +			 enum range_qos_req_type type, s32 value);
> +int perf_qos_update_request(struct range_qos_request *req, s32 new_value);
> +int perf_qos_remove_request(struct range_qos_request *req);
> +
> +int perf_qos_add_notifier(struct range_constraints *qos,
> +			  enum range_qos_req_type type,
> +			  struct notifier_block *notifier);
> +int perf_qos_remove_notifier(struct range_constraints *qos,
> +			     enum range_qos_req_type type,
> +			     struct notifier_block *notifier);
> +
>  #endif
> diff --git a/kernel/power/qos.c b/kernel/power/qos.c
> index 39919a2eed73..2787473e6048 100644
> --- a/kernel/power/qos.c
> +++ b/kernel/power/qos.c
> @@ -680,3 +680,228 @@ int freq_qos_remove_notifier(struct range_constraints *qos,
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(freq_qos_remove_notifier);
> +
> +static inline bool perf_qos_value_invalid(s32 value)
> +{
> +	return value < 0 && value != PM_QOS_DEFAULT_VALUE;
> +}
> +
> +/**
> + * perf_qos_apply - Add/modify/remove performance QoS request.
> + * @req: Constraint request to apply.
> + * @action: Action to perform (add/update/remove).
> + * @value: Value to assign to the QoS request.
> + *
> + * This is only meant to be called from inside pm_qos, not drivers.
> + */
> +int perf_qos_apply(struct range_qos_request *req,
> +		   enum pm_qos_req_action action, s32 value)
> +{
> +	int ret;
> +
> +	switch(req->type) {
> +	case RANGE_QOS_MIN:
> +		ret = pm_qos_update_target(&req->qos->lower_bound, &req->pnode,
> +					   action, value);
> +		break;
> +	case RANGE_QOS_MAX:
> +		ret = pm_qos_update_target(&req->qos->upper_bound, &req->pnode,
> +					   action, value);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * perf_qos_read_value - Get performance QoS constraint for a given list.
> + * @qos: Constraints to evaluate.
> + * @type: QoS request type.
> + */
> +s32 perf_qos_read_value(struct range_constraints *qos,
> +			enum range_qos_req_type type)
> +{
> +	s32 ret;
> +
> +	switch (type) {
> +	case RANGE_QOS_MIN:
> +		ret = IS_ERR_OR_NULL(qos) ?
> +			PM_QOS_MIN_PERF_DEFAULT_VALUE :
> +			pm_qos_read_value(&qos->lower_bound);
> +		break;
> +	case RANGE_QOS_MAX:
> +		ret = IS_ERR_OR_NULL(qos) ?
> +			PM_QOS_MAX_PERF_DEFAULT_VALUE :
> +			pm_qos_read_value(&qos->upper_bound);
> +		break;
> +	default:
> +		ret = 0;
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(perf_qos_read_value);
> +
> +/**
> + * perf_qos_add_request - Insert new performance QoS request into a given list.
> + * @qos: Constraints to update.
> + * @req: Preallocated request object.
> + * @type: Request type.
> + * @value: Request value.
> + *
> + * Insert a new entry into the @qos list of requests, recompute the effective
> + * QoS constraint value for that list and initialize the @req object.  The
> + * caller needs to save that object for later use in updates and removal.
> + *
> + * Return 1 if the effective constraint value has changed, 0 if the effective
> + * constraint value has not changed, or a negative error code on failures.
> + */
> +int perf_qos_add_request(struct range_constraints *qos,
> +			 struct range_qos_request *req,
> +			 enum range_qos_req_type type, s32 value)
> +{
> +	int ret;
> +
> +	if (IS_ERR_OR_NULL(qos) || !req || perf_qos_value_invalid(value))
> +		return -EINVAL;
> +
> +	if (WARN(perf_qos_request_active(req),
> +		 "%s() called for active request\n", __func__))
> +		return -EINVAL;
> +
> +	req->qos = qos;
> +	req->type = type;
> +	ret = perf_qos_apply(req, PM_QOS_ADD_REQ, value);
> +	if (ret < 0) {
> +		req->qos = NULL;
> +		req->type = 0;
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(perf_qos_add_request);
> +
> +/**
> + * perf_qos_update_request - Modify existing performance QoS request.
> + * @req: Request to modify.
> + * @new_value: New request value.
> + *
> + * Update an existing performance QoS request along with the effective
> + * constraint value for the list of requests it belongs to.
> + *
> + * Return 1 if the effective constraint value has changed, 0 if the effective
> + * constraint value has not changed, or a negative error code on failures.
> + */
> +int perf_qos_update_request(struct range_qos_request *req, s32 new_value)
> +{
> +	if (!req || perf_qos_value_invalid(new_value))
> +		return -EINVAL;
> +
> +	if (WARN(!perf_qos_request_active(req),
> +		 "%s() called for unknown object\n", __func__))
> +		return -EINVAL;
> +
> +	if (req->pnode.prio == new_value)
> +		return 0;
> +
> +	return perf_qos_apply(req, PM_QOS_UPDATE_REQ, new_value);
> +}
> +EXPORT_SYMBOL_GPL(perf_qos_update_request);
> +
> +/**
> + * perf_qos_remove_request - Remove performance QoS request from its list.
> + * @req: Request to remove.
> + *
> + * Remove the given performance QoS request from the list of
> + * constraints it belongs to and recompute the effective constraint
> + * value for that list.
> + *
> + * Return 1 if the effective constraint value has changed, 0 if the effective
> + * constraint value has not changed, or a negative error code on failures.
> + */
> +int perf_qos_remove_request(struct range_qos_request *req)
> +{
> +	int ret;
> +
> +	if (!req)
> +		return -EINVAL;
> +
> +	if (WARN(!perf_qos_request_active(req),
> +		 "%s() called for unknown object\n", __func__))
> +		return -EINVAL;
> +
> +	ret = perf_qos_apply(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
> +	req->qos = NULL;
> +	req->type = 0;
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(perf_qos_remove_request);
> +
> +/**
> + * perf_qos_add_notifier - Add performance QoS change notifier.
> + * @qos: List of requests to add the notifier to.
> + * @type: Request type.
> + * @notifier: Notifier block to add.
> + */
> +int perf_qos_add_notifier(struct range_constraints *qos,
> +			  enum range_qos_req_type type,
> +			  struct notifier_block *notifier)
> +{
> +	int ret;
> +
> +	if (IS_ERR_OR_NULL(qos) || !notifier)
> +		return -EINVAL;
> +
> +	switch (type) {
> +	case RANGE_QOS_MIN:
> +		ret = blocking_notifier_chain_register(qos->lower_bound.notifiers,
> +						       notifier);
> +		break;
> +	case RANGE_QOS_MAX:
> +		ret = blocking_notifier_chain_register(qos->upper_bound.notifiers,
> +						       notifier);
> +		break;
> +	default:
> +		WARN_ON(1);
> +		ret = -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(perf_qos_add_notifier);
> +
> +/**
> + * perf_qos_remove_notifier - Remove performance QoS change notifier.
> + * @qos: List of requests to remove the notifier from.
> + * @type: Request type.
> + * @notifier: Notifier block to remove.
> + */
> +int perf_qos_remove_notifier(struct range_constraints *qos,
> +			     enum range_qos_req_type type,
> +			     struct notifier_block *notifier)
> +{
> +	int ret;
> +
> +	if (IS_ERR_OR_NULL(qos) || !notifier)
> +		return -EINVAL;
> +
> +	switch (type) {
> +	case RANGE_QOS_MIN:
> +		ret = blocking_notifier_chain_unregister(qos->lower_bound.notifiers,
> +							 notifier);
> +		break;
> +	case RANGE_QOS_MAX:
> +		ret = blocking_notifier_chain_unregister(qos->upper_bound.notifiers,
> +							 notifier);
> +		break;
> +	default:
> +		WARN_ON(1);
> +		ret = -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(perf_qos_remove_notifier);

-- 
// Caleb (they/them)

