Return-Path: <linux-pm+bounces-42335-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NNgBn21iWlLBAUAu9opvQ
	(envelope-from <linux-pm+bounces-42335-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 11:22:53 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B532510E1D2
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 11:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7325D300B461
	for <lists+linux-pm@lfdr.de>; Mon,  9 Feb 2026 10:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BE535E530;
	Mon,  9 Feb 2026 10:21:37 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4BD3446CC;
	Mon,  9 Feb 2026 10:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770632497; cv=none; b=FCWxhl8CA/XByFnsyOH5KvQzcTdpq0PnO/W5xkIR4n/oBCH8YI4Ekkdg9qmqNlQj6oV7VxJ2xDMGPwb3PBQmCLcuqSk1FxHfVCO3oKXoG5dhwCJ0cn7W9TQOtZytTLicd6opNxSs88NiXB6PmexMPjEWdB3e8r6vCcTUs52S3BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770632497; c=relaxed/simple;
	bh=L+pJS1wPc3J6G9S+6WGM79Yv4j3QbXI7LUr5A7k7oXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YT4IkagYJzHDggTWVfpminwwGDyVPRuDxCadab4iHvJ06pm/28bvFHagvMkFGl0ecM5akL+uKVAz7r/Yk1/43gPs0p26FAo23kb3XqQyZGIStF8YKRixAPloA19WskHgjhxP4ov6EThrmDmy79a5N6QcrySXP4D1hDIggvIBYZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1750339;
	Mon,  9 Feb 2026 02:21:29 -0800 (PST)
Received: from [10.57.16.28] (unknown [10.57.16.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA4213F632;
	Mon,  9 Feb 2026 02:21:32 -0800 (PST)
Message-ID: <5d67c958-dbd5-4580-a620-2eb8a6a0f47b@arm.com>
Date: Mon, 9 Feb 2026 10:21:35 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/8] thermal: Add Remote Proc cooling driver
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, krzk+dt@kernel.org,
 casey.connolly@linaro.org, amitk@kernel.org, konradybcio@kernel.org,
 rui.zhang@intel.com, daniel.lezcano@linaro.org, rafael@kernel.org,
 conor+dt@kernel.org, andersson@kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
 mathieu.poirier@linaro.org, mani@kernel.org
References: <20251223123227.1317244-1-gaurav.kohli@oss.qualcomm.com>
 <20251223123227.1317244-2-gaurav.kohli@oss.qualcomm.com>
 <a27b755d-00d2-4350-98ab-0b68ab754770@arm.com>
 <d5fd45e3-68b2-427d-b75a-4c6bb9ed6ecb@oss.qualcomm.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <d5fd45e3-68b2-427d-b75a-4c6bb9ed6ecb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42335-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukasz.luba@arm.com,linux-pm@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.917];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:mid]
X-Rspamd-Queue-Id: B532510E1D2
X-Rspamd-Action: no action



On 2/9/26 05:28, Gaurav Kohli wrote:
> 
> 
> On 2/2/2026 4:29 PM, Lukasz Luba wrote:
>> Hi Gaurav,
>>
>> On 12/23/25 12:32, Gaurav Kohli wrote:
>>> Add a new generic driver for thermal cooling devices that control
>>> remote processors (modem, DSP, etc.) through various communication
>>> channels.
>>>
>>> This driver provides an abstraction layer between the thermal
>>> subsystem and vendor-specific remote processor communication
>>> mechanisms.
>>
>> Is this the patch about proposing the new cooling
>> device type at last LPC2025 conference (what we've discussed with Amit)?
>>
> 
> thanks Lukasz for review, yes this is the same.
> sorry for late reply, was on leave last week.
> 
>> There was some feedback asking you to add a bit more description
>> into this patch header, please do that (with some background as well).
>>
> 
> Sure, will update.
> 
>>>
>>> Suggested-by: Amit Kucheria <amit.kucheria@oss.qualcomm.com>
>>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>>> ---


[snip]


>>> +struct remoteproc_cooling_ops {
>>> +    int (*get_max_level)(void *devdata, unsigned long *level);
>>> +    int (*get_cur_level)(void *devdata, unsigned long *level);
>>> +    int (*set_cur_level)(void *devdata, unsigned long level);
>>> +};
>>
>> 1. There is no comment for struct and the functions like you did below.
>> 2. Why you need those 3 callbacks?
>>     It looks like they are simple wrappers on stuff in
>>     'struct thermal_cooling_device_ops'.
>>     Please try to get rid of them and re-use the existing fwk callbacks.
>>
> 
> thanks for this suggestion, i will use thermal_cooling_device_ops directly.
> 
>>> +
>>> +/**
>>> + * struct remoteproc_cdev - Remote processor cooling device
>>> + * @cdev: Thermal cooling device handle
>>> + * @ops: Vendor-specific operation callbacks
>>> + * @devdata: Private data for vendor implementation
>>> + * @np: Device tree node associated with this cooling device
>>> + * @lock: Mutex to protect cooling device operations
>>> + */
>>> +struct remoteproc_cdev {
>>
>> Please use the full naming:
>> remoteproc_cooling_device
>>
>>> +    struct thermal_cooling_device *cdev;
>>
>> You don't need to keep it here. AFAICS it's only
>> used in the 'unregister' function. Please check my
>> comment here and then remove this pointer.
>> (It creates uneseccery linkage between those devices).
>>
>>> +    const struct remoteproc_cooling_ops *ops;
>>
>> So here it can be simply:
>> struct thermal_cooling_device_ops cooling_ops;
>>
> 
> yes, i will use this as part of remoteproc_cooling_device struct.
> 
>>> +    void *devdata;
>>> +    struct device_node *np;
>>
>> This 'np' is also not used, remove it please.
>>
>>> +    struct mutex lock;
>>> +};
>>> +
>>> +
>>> +/* Thermal cooling device callbacks */
>>> +
>>> +static int remoteproc_get_max_state(struct thermal_cooling_device 
>>> *cdev,
>>> +                    unsigned long *state)
>>> +{
>>> +    struct remoteproc_cdev *rproc_cdev = cdev->devdata;
>>> +    int ret;
>>> +
>>> +    if (!rproc_cdev || !rproc_cdev->ops)
>>> +        return -EINVAL;
>>
>> This mustn't be changed in runtime accidenly. We don't guard in
>> cpufreq-/devfreq- cooling these callbacks that way. Please drop them.
> 
> Sure, let me rewrite this and update in next version.
> 
>>

[snip]

>>> +
>>> +    if (!name || !ops) {
>>
>> IMO you should check the '!np' here, not the lines below.
>> We can simply bail out very early.
>>
> 
> thanks will put explicit check for np, but please let me know for non 
> np, do we have to add support for non np also.

If your code doesn't use the non-np then let's not implement it.
When there will be a new client, we can refactor slightly the existing
code and make two interfaces for the registration (similat to cpufreq
cooling).

> so they can directly register with thermal_cooling_device_register.
> 
>>> +        return ERR_PTR(-EINVAL);
>>> +    }
>>> +

[snip]

>>> +
>>> +void remoteproc_cooling_unregister(struct remoteproc_cdev *rproc_cdev)
>>
>> Change the API to be alined with cpufreq-cooling and devfreq-cooling
>> types of devices, so:
>>
>> void remoteproc_cooling_unregister(struct thermal_cooling_device *cdev)
>>
>> You still should be able to get the rptoc_cdev like:
>>
>> rproc_cdev = cdev->devdata;
>>
>> and free it.
>>
> 
> thanks, will change something like below
> +       rproc_cdev = cdev->devdata;
> +       thermal_cooling_device_unregister(cdev);

Should work, let see in the new code.


[snip]


>>> +struct remoteproc_cooling_ops {
>>> +    int (*get_max_level)(void *devdata, unsigned long *level);
>>> +    int (*get_cur_level)(void *devdata, unsigned long *level);
>>> +    int (*set_cur_level)(void *devdata, unsigned long level);
>>> +};
>>
>> That duplicate w/ .c file content.
>> We don't need this in the header, please follow the cpufreq-/devfreq-
>> design.
>>
> 
> Yes, with new approach of using thermal_cooling_device_ops directly can
> save this.

Great, looking for the the v2

> 
>>> +
>>> +struct remoteproc_cdev;
>>> +
>>> +#ifdef CONFIG_REMOTEPROC_THERMAL
>>> +
>>> +struct remoteproc_cdev *
>>> +remoteproc_cooling_register(struct device_node *np,
>>> +                 const char *name,
>>> +                 const struct remoteproc_cooling_ops *ops,
>>> +                 void *devdata);
>>> +
>>> +void remoteproc_cooling_unregister(struct remoteproc_cdev *rproc_cdev);
>>> +
>>> +#else /* !CONFIG_REMOTEPROC_THERMAL */
>>> +
>>> +static inline struct remoteproc_cdev *
>>> +remoteproc_cooling_register(struct device_node *np,
>>> +                 const char *name,
>>> +                 const struct remoteproc_cooling_ops *ops,
>>> +                 void *devdata)
>>> +{
>>> +    return ERR_PTR(-EINVAL);
>>> +}
>>
>> Function naming convention here as well
>>
> 
> thanks a lot, let me rewrite as per suggestion and update in newer version.
> 

you're welcome


