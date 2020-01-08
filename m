Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D40AF133D61
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2020 09:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbgAHIlq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jan 2020 03:41:46 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:64571 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbgAHIlq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jan 2020 03:41:46 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200108084143epoutp030f1d6d3d63d8af63a31261772fcacfaf~n3L4aEjj20411804118epoutp03F
        for <linux-pm@vger.kernel.org>; Wed,  8 Jan 2020 08:41:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200108084143epoutp030f1d6d3d63d8af63a31261772fcacfaf~n3L4aEjj20411804118epoutp03F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578472903;
        bh=XwL8z7TXx+Ew9jxcqLOZWoFDtsZRTCtw35g8eeRW/a8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Qsu6IhRFrXn9DWldlKD/QItX/OqTSUPKwaLlttWSfWWjfCPZL0s5eDWJG486xCAFt
         xrzm+FCKvp+DCNsHUii8vKyzb0aH1oVPVTudnHYeodbJa+ojX54BcSqkTjLKYpLiiI
         zBNw+qzPzLVewaAISmgiRPjdnOvT0WsnXeCL0QCY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200108084142epcas1p4315dcb47642c1f61f1d63fa84e27fa3e~n3L3hHCBl1694216942epcas1p4O;
        Wed,  8 Jan 2020 08:41:42 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.158]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47t2m31mNkzMqYkZ; Wed,  8 Jan
        2020 08:41:39 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        EC.F6.48498.CB5951E5; Wed,  8 Jan 2020 17:41:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200108084132epcas1p1297db51434f1ce53371e6b6b6ddfb593~n3LuESEsJ0243702437epcas1p13;
        Wed,  8 Jan 2020 08:41:32 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200108084132epsmtrp16326bc3691e0b663d3712fc4c80dc6dd~n3LuDeSem0974209742epsmtrp19;
        Wed,  8 Jan 2020 08:41:32 +0000 (GMT)
X-AuditID: b6c32a36-a55ff7000001bd72-77-5e1595bc43f4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        88.2A.10238.CB5951E5; Wed,  8 Jan 2020 17:41:32 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200108084132epsmtip261c1d7ebac506891ae4bc2bb3f5c27ec~n3Lt06cdq1793017930epsmtip2U;
        Wed,  8 Jan 2020 08:41:32 +0000 (GMT)
Subject: Re: [PATCH] PM / devfreq: Add missing function description and
 rename static functions
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     chanwoo@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com
Organization: Samsung Electronics
Message-ID: <f4acbe47-df19-b9b2-c24e-987a78a5db71@samsung.com>
Date:   Wed, 8 Jan 2020 17:48:39 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <de7b3c55-a058-c8e8-4ebd-b2bb8dacf161@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+LIzCtJLcpLzFFi42LZdlhTV3fPVNE4g7+/jCwm3rjCYnG26Q27
        xeVdc9gsPvceYbS43biCzYHVY9OqTjaPvi2rGD0+b5ILYI7KtslITUxJLVJIzUvOT8nMS7dV
        8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBWqmkUJaYUwoUCkgsLlbSt7Mpyi8tSVXI
        yC8usVVKLUjJKbAs0CtOzC0uzUvXS87PtTI0MDAyBSpMyM64fncba8Gt0IqDJ+czNjAudO1i
        5OCQEDCReP7KuIuRi0NIYAejxKo5exghnE+MEpvPdbJBON8YJV5N6WeF6Tg41wMivpdRYuKM
        aVBF7xklZn+ZyQxSJCyQKPHzIU8XIycHm4CWxP4XN9hAbBEBK4nT/zuYQWxmAW+JxW9XM4LY
        /AKKEld/PAazeQXsJLa072cCsVkEVCROPZgKZosKhEmc3NYCVSMocXLmExYQm1PAXqL/ygNW
        iJniEreezGeCsOUltr+dwwxym4TAZTaJNd+mgy2WEHCR2Dv/NxuELSzx6vgWdghbSuJlfxuU
        XS2x8uQRNojmDkaJLfsvsEIkjCX2L53MBPIks4CmxPpd+hBhRYmdv+cyQizmk3j3tQcaWLwS
        HW1CECXKEpcf3GWCsCUlFrd3sk1gVJqF5J1ZSF6YheSFWQjLFjCyrGIUSy0ozk1PLTYsMEKO
        602M4MSoZbaDcdE5n0OMAhyMSjy8PxaLxAmxJpYVV+YeYpTgYFYS4dXSAQrxpiRWVqUW5ccX
        leakFh9iNAWG9kRmKdHkfGDSziuJNzQ1MjY2tjAxNDM1NFQS5+X4cTFWSCA9sSQ1OzW1ILUI
        po+Jg1OqgXGb3AwuxtfeL99emiQqUda2N/u96WeX8ur+wEJJZbfz9z/yvCgUy192XcmMR4/1
        +erk66tUWhTE900qqNHvcpi863r3itgPWSFbYv6vswnsj7mbU+Nz+OHDP3arG9+sv5yus+6R
        5/bdm758e7C9kDdI/emuE6cE6j797frZd6t7C8caG3uVhbpKLMUZiYZazEXFiQDLW76TogMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsWy7bCSvO6eqaJxBg1veCwm3rjCYnG26Q27
        xeVdc9gsPvceYbS43biCzYHVY9OqTjaPvi2rGD0+b5ILYI7isklJzcksSy3St0vgyrh+dxtr
        wa3QioMn5zM2MC507WLk4JAQMJE4ONeji5GLQ0hgN6PEg1MnmboYOYHikhLTLh5lhqgRljh8
        uBgkLCTwllFiX48riC0skCjR8esUK4jNJqAlsf/FDTYQW0TASuL0/w5mEJtZwFti8dvVjBDz
        DzNK/Ji/ASzBL6AocfXHY0YQm1fATmJL+36wvSwCKhKnHkwFs0UFwiR2LnnMBFEjKHFy5hMW
        EJtTwF6i/8oDVogF6hJ/5l2CWiYucevJfCYIW15i+9s5zBMYhWchaZ+FpGUWkpZZSFoWMLKs
        YpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQIjhEtzR2Ml5fEH2IU4GBU4uH9sVgkTog1
        say4MvcQowQHs5IIr5YOUIg3JbGyKrUoP76oNCe1+BCjNAeLkjjv07xjkUIC6YklqdmpqQWp
        RTBZJg5OqQbGqjsWQfMdH2Ycba4UZGhXzcr4w1puFOu8/diXSd7ur8I85x17zLv4UoH7jqsx
        bMqqJY/dLresXr9MaZHcvrZ6S4uJnHPvbLL80/1Yc3eVrlvfeYem86XzmeYlTf2/3KWg57NG
        cpTCrDLD9O8LXr/6/emYZEnE48d5DF0hwWlW92Q7LkbPLHiixFKckWioxVxUnAgAMrniRo0C
        AAA=
X-CMS-MailID: 20200108084132epcas1p1297db51434f1ce53371e6b6b6ddfb593
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200107012826epcas1p17480af9ce779b3c17f6a815cc78ed25b
References: <CGME20200107012826epcas1p17480af9ce779b3c17f6a815cc78ed25b@epcas1p1.samsung.com>
        <20200107013523.27177-1-cw00.choi@samsung.com>
        <de7b3c55-a058-c8e8-4ebd-b2bb8dacf161@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1/8/20 2:03 PM, Chanwoo Choi wrote:
> On 1/7/20 10:35 AM, Chanwoo Choi wrote:
>> Rename internal function name used by devfreq core without 'devfreq_'
>> prefix in order to separate them from the exported functions.
>> And add missing function description for improving the readability.
>>
>> Lastly, add the comments of devfreq_add_device to increase
>> the understanding of behavior of devfreq_add_device.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  drivers/devfreq/devfreq.c | 81 +++++++++++++++++++++++++++++++--------
>>  1 file changed, 64 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index acd21345a070..254f11b31824 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -48,7 +48,7 @@ static LIST_HEAD(devfreq_list);
>>  static DEFINE_MUTEX(devfreq_list_lock);
>>  
>>  /**
>> - * find_device_devfreq() - find devfreq struct using device pointer
>> + * find_device_devfreq() - Find devfreq struct using device pointer
>>   * @dev:	device pointer used to lookup device devfreq.
>>   *
>>   * Search the list of device devfreqs and return the matched device's
>> @@ -73,6 +73,13 @@ static struct devfreq *find_device_devfreq(struct device *dev)
>>  	return ERR_PTR(-ENODEV);
>>  }
>>  
>> +/**
>> + * find_available_min_freq() - Find available min frequency via OPP interface
>> + * @devfreq:	the devfreq instance
>> + *
>> + * Find available minimum frequency among the active OPP entries
>> + * because could either enable or disable the frequency by using OPP interface.
>> + */
>>  static unsigned long find_available_min_freq(struct devfreq *devfreq)
>>  {
>>  	struct dev_pm_opp *opp;
>> @@ -87,6 +94,13 @@ static unsigned long find_available_min_freq(struct devfreq *devfreq)
>>  	return min_freq;
>>  }
>>  
>> +/**
>> + * find_available_max_freq() - Find available max frequency via OPP interface
>> + * @devfreq:	the devfreq instance
>> + *
>> + * Find available maximum frequency among the active OPP entries
>> + * because could either enable or disable the frequency by using OPP interface.
>> + */
>>  static unsigned long find_available_max_freq(struct devfreq *devfreq)
>>  {
>>  	struct dev_pm_opp *opp;
>> @@ -150,11 +164,11 @@ static void get_freq_range(struct devfreq *devfreq,
>>  }
>>  
>>  /**
>> - * devfreq_get_freq_level() - Lookup freq_table for the frequency
>> + * get_freq_level() - Lookup freq_table for the frequency
>>   * @devfreq:	the devfreq instance
>>   * @freq:	the target frequency
>>   */
>> -static int devfreq_get_freq_level(struct devfreq *devfreq, unsigned long freq)
>> +static int get_freq_level(struct devfreq *devfreq, unsigned long freq)
>>  {
>>  	int lev;
>>  
>> @@ -165,6 +179,13 @@ static int devfreq_get_freq_level(struct devfreq *devfreq, unsigned long freq)
>>  	return -EINVAL;
>>  }
>>  
>> +/**
>> + * set_freq_table() - Fill out the freq_table of devfreq instance
>> + * @devfreq:	the devfreq instance
>> + *
>> + * If freq_table array is NULL, fill out the freq_table array
>> + * by using OPP interface because OPP is mandatory.
>> + */
>>  static int set_freq_table(struct devfreq *devfreq)
>>  {
>>  	struct devfreq_dev_profile *profile = devfreq->profile;
>> @@ -218,7 +239,7 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>>  	if (!devfreq->previous_freq)
>>  		goto out;
>>  
>> -	prev_lev = devfreq_get_freq_level(devfreq, devfreq->previous_freq);
>> +	prev_lev = get_freq_level(devfreq, devfreq->previous_freq);
>>  	if (prev_lev < 0) {
>>  		ret = prev_lev;
>>  		goto out;
>> @@ -227,7 +248,7 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>>  	devfreq->stats.time_in_state[prev_lev] +=
>>  			cur_time - devfreq->stats.last_update;
>>  
>> -	lev = devfreq_get_freq_level(devfreq, freq);
>> +	lev = get_freq_level(devfreq, freq);
>>  	if (lev < 0) {
>>  		ret = lev;
>>  		goto out;
>> @@ -246,7 +267,7 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>>  EXPORT_SYMBOL(devfreq_update_status);
>>  
>>  /**
>> - * find_devfreq_governor() - find devfreq governor from name
>> + * find_devfreq_governor() - Find devfreq governor from name
>>   * @name:	name of the governor
>>   *
>>   * Search the list of devfreq governors and return the matched
>> @@ -314,8 +335,17 @@ static struct devfreq_governor *try_then_request_governor(const char *name)
>>  	return governor;
>>  }
>>  
>> -static int devfreq_notify_transition(struct devfreq *devfreq,
>> -		struct devfreq_freqs *freqs, unsigned int state)
>> +/**
>> + * notify_transition() - Send the transition notification
>> + * @name:	name of the governor
>> + * @freqs:	the data containing the both old and new frequency
>> + * @state:	the kind of notification
>> + *
>> + * Send the transition notification to the registered receivers
>> + * in order to inform the frequency change.
>> + */
>> +static int notify_transition(struct devfreq *devfreq,
>> +			struct devfreq_freqs *freqs, unsigned int state)
>>  {
>>  	if (!devfreq)
>>  		return -EINVAL;
>> @@ -337,8 +367,17 @@ static int devfreq_notify_transition(struct devfreq *devfreq,
>>  	return 0;
>>  }
>>  
>> -static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
>> -			      u32 flags)
>> +/**
>> + * set_target() - Set target frequency of devfreq instance
>> + * @devfreq:	the devfreq instance
>> + * @new_freq:	the target frequency
>> + * @flags:	flags handed from devfreq framework
>> + *
>> + * Set the target frequency of which is decided by governor
>> + * and then is adjusted with constraints.
>> + */
>> +static int set_target(struct devfreq *devfreq,
>> +			unsigned long new_freq, u32 flags)
>>  {
>>  	struct devfreq_freqs freqs;
>>  	unsigned long cur_freq;
>> @@ -351,17 +390,17 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
>>  
>>  	freqs.old = cur_freq;
>>  	freqs.new = new_freq;
>> -	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_PRECHANGE);
>> +	notify_transition(devfreq, &freqs, DEVFREQ_PRECHANGE);
>>  
>>  	err = devfreq->profile->target(devfreq->dev.parent, &new_freq, flags);
>>  	if (err) {
>>  		freqs.new = cur_freq;
>> -		devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
>> +		notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
>>  		return err;
>>  	}
>>  
>>  	freqs.new = new_freq;
>> -	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
>> +	notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
>>  
>>  	if (devfreq_update_status(devfreq, new_freq))
>>  		dev_err(&devfreq->dev,
>> @@ -413,7 +452,7 @@ int update_devfreq(struct devfreq *devfreq)
>>  		flags |= DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use LUB */
>>  	}
>>  
>> -	return devfreq_set_target(devfreq, freq, flags);
>> +	return set_target(devfreq, freq, flags);
>>  
>>  }
>>  EXPORT_SYMBOL(update_devfreq);
>> @@ -421,7 +460,6 @@ EXPORT_SYMBOL(update_devfreq);
>>  /**
>>   * devfreq_monitor() - Periodically poll devfreq objects.
>>   * @work:	the work struct used to run devfreq_monitor periodically.
>> - *
>>   */
>>  static void devfreq_monitor(struct work_struct *work)
>>  {
>> @@ -739,11 +777,13 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>  	static atomic_t devfreq_no = ATOMIC_INIT(-1);
>>  	int err = 0;
>>  
>> +	/* Check the parameter is valid */
>>  	if (!dev || !profile || !governor_name) {
>>  		dev_err(dev, "%s: Invalid parameters.\n", __func__);
>>  		return ERR_PTR(-EINVAL);
>>  	}
>>  
>> +	/* Check the device is already added or not */
>>  	mutex_lock(&devfreq_list_lock);
>>  	devfreq = find_device_devfreq(dev);
>>  	mutex_unlock(&devfreq_list_lock);
>> @@ -754,6 +794,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>  		goto err_out;
>>  	}
>>  
>> +	/* Initialize the devfreq instance */
>>  	devfreq = kzalloc(sizeof(struct devfreq), GFP_KERNEL);
>>  	if (!devfreq) {
>>  		err = -ENOMEM;
>> @@ -798,6 +839,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>  	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
>>  	atomic_set(&devfreq->suspend_count, 0);
>>  
>> +	/* Register a device for devfreq instance */
>>  	dev_set_name(&devfreq->dev, "devfreq%d",
>>  				atomic_inc_return(&devfreq_no));
>>  	err = device_register(&devfreq->dev);
>> @@ -807,6 +849,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>  		goto err_out;
>>  	}
>>  
>> +	/* Initialize the statistics of devfreq device behavior */
>>  	devfreq->stats.trans_table = devm_kzalloc(&devfreq->dev,
>>  			array3_size(sizeof(unsigned int),
>>  				    devfreq->profile->max_state,
>> @@ -831,10 +874,12 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>  	devfreq->stats.total_trans = 0;
>>  	devfreq->stats.last_update = get_jiffies_64();
>>  
>> +	/* Initialize notifiers for informing the transition of devfreq */
>>  	srcu_init_notifier_head(&devfreq->transition_notifier_list);
>>  
>>  	mutex_unlock(&devfreq->lock);
>>  
>> +	/* Initialize PM QoS for applying the constraints */
>>  	err = dev_pm_qos_add_request(dev, &devfreq->user_min_freq_req,
>>  				     DEV_PM_QOS_MIN_FREQUENCY, 0);
>>  	if (err < 0)
>> @@ -859,6 +904,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>  
>>  	mutex_lock(&devfreq_list_lock);
>>  
>> +	/* Find the devfreq governor and start */
>>  	governor = try_then_request_governor(devfreq->governor_name);
>>  	if (IS_ERR(governor)) {
>>  		dev_err(dev, "%s: Unable to find governor for the device\n",
>> @@ -876,6 +922,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>  		goto err_init;
>>  	}
>>  
>> +	/* Add the devfreq instance to global devfreq list finally */
>>  	list_add(&devfreq->node, &devfreq_list);
>>  
>>  	mutex_unlock(&devfreq_list_lock);
>> @@ -1076,7 +1123,7 @@ int devfreq_suspend_device(struct devfreq *devfreq)
>>  
>>  	if (devfreq->suspend_freq) {
>>  		mutex_lock(&devfreq->lock);
>> -		ret = devfreq_set_target(devfreq, devfreq->suspend_freq, 0);
>> +		ret = set_target(devfreq, devfreq->suspend_freq, 0);
>>  		mutex_unlock(&devfreq->lock);
>>  		if (ret)
>>  			return ret;
>> @@ -1106,7 +1153,7 @@ int devfreq_resume_device(struct devfreq *devfreq)
>>  
>>  	if (devfreq->resume_freq) {
>>  		mutex_lock(&devfreq->lock);
>> -		ret = devfreq_set_target(devfreq, devfreq->resume_freq, 0);
>> +		ret = set_target(devfreq, devfreq->resume_freq, 0);
>>  		mutex_unlock(&devfreq->lock);
>>  		if (ret)
>>  			return ret;
>>
> 
> Applied it.
> 

I'm sorry. Drop this patch because it is not enough to add
the missing description for functions. I'll add the more description
and then resend it.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
