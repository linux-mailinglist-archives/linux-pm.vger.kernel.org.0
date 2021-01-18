Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A392FA819
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 18:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436751AbhARR44 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jan 2021 12:56:56 -0500
Received: from foss.arm.com ([217.140.110.172]:40270 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436736AbhARR4z (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 18 Jan 2021 12:56:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29DEE31B;
        Mon, 18 Jan 2021 09:56:09 -0800 (PST)
Received: from [10.57.2.166] (unknown [10.57.2.166])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E068A3F719;
        Mon, 18 Jan 2021 09:56:07 -0800 (PST)
Subject: Re: [PATCH] PM / devfreq: Add sysfs attributes to simple_ondemand
 governor
To:     Greg KH <greg@kroah.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com
References: <20210115170530.22603-1-lukasz.luba@arm.com>
 <YAXCnMsUy3n+asfm@kroah.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <43729797-2d3c-be12-ce72-bfe5bca54fa0@arm.com>
Date:   Mon, 18 Jan 2021 17:56:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <YAXCnMsUy3n+asfm@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 1/18/21 5:17 PM, Greg KH wrote:
> On Fri, Jan 15, 2021 at 05:05:30PM +0000, Lukasz Luba wrote:
>> The simple_ondemand devfreq governor is used by quite a few devices, like
>> GPUs, DSPs, memory controllers, etc. It implements algorithm which tries
>> to predict the device frequency based on past statistics. There are two
>> tunables for the algorithm: 'upthreshold' and 'downdifferential'. These
>> tunables change the behavior of the decision, e.g. how fast to increase
>> the frequency or how rapidly limit the frequency. These values might be
>> different based on the application which is currently running, e.g.
>> different behavior is needed for a game than for web browsing or clean
>> desktop. The patch exports these two tunables so they can be adjusted
>> based on current need. There is also a check with the allowed ranges
>> to make sure the values are correct and safe.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   drivers/devfreq/governor_simpleondemand.c | 135 ++++++++++++++++++++++
>>   1 file changed, 135 insertions(+)
>>
>> diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
>> index d57b82a2b570..4b3c182e0a49 100644
>> --- a/drivers/devfreq/governor_simpleondemand.c
>> +++ b/drivers/devfreq/governor_simpleondemand.c
>> @@ -15,6 +15,7 @@
>>   /* Default constants for DevFreq-Simple-Ondemand (DFSO) */
>>   #define DFSO_UPTHRESHOLD	(90)
>>   #define DFSO_DOWNDIFFERENCTIAL	(5)
>> +#define DFSO_MAX_VALUE		(100)
>>   static int devfreq_simple_ondemand_func(struct devfreq *df,
>>   					unsigned long *freq)
>>   {
>> @@ -84,15 +85,149 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
>>   	return 0;
>>   }
>>   
>> +static ssize_t upthreshold_show(struct device *dev,
>> +				struct device_attribute *attr, char *buf)
>> +{
>> +	struct devfreq_simple_ondemand_data *data;
>> +	struct devfreq *df = to_devfreq(dev);
>> +
>> +	if (!df->data)
>> +		return -EINVAL;
>> +
>> +	data = df->data;
>> +
>> +	return sprintf(buf, "%d\n", data->upthreshold);
> 
> sysfs_emit()?
> 
> Also, you forgot the Documentation/ABI/ updates for new sysfs files :(

True, I will remember next time.

> 
> 
>> +}
>> +
>> +static ssize_t upthreshold_store(struct device *dev,
>> +				 struct device_attribute *attr,
>> +				 const char *buf, size_t count)
>> +{
>> +	struct devfreq_simple_ondemand_data *data;
>> +	struct devfreq *df = to_devfreq(dev);
>> +	unsigned int value;
>> +	int ret;
>> +
>> +	if (!df->data)
>> +		return -EINVAL;
>> +
>> +	data = df->data;
>> +
>> +	ret = kstrtouint(buf, 10, &value);
>> +	if (ret < 0)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&df->lock);
>> +
>> +	if (value > DFSO_MAX_VALUE || value <= data->downdifferential) {
>> +		mutex_unlock(&df->lock);
>> +		return -EINVAL;
>> +	}
>> +
>> +	data->upthreshold = value;
>> +	mutex_unlock(&df->lock);
>> +
>> +	return count;
>> +}
>> +static DEVICE_ATTR_RW(upthreshold);
>> +
>> +static ssize_t downdifferential_show(struct device *dev,
>> +				     struct device_attribute *attr, char *buf)
>> +{
>> +	struct devfreq_simple_ondemand_data *data;
>> +	struct devfreq *df = to_devfreq(dev);
>> +
>> +	if (!df->data)
>> +		return -EINVAL;
>> +
>> +	data = df->data;
>> +
>> +	return sprintf(buf, "%d\n", data->downdifferential);
>> +}
>> +
>> +static ssize_t downdifferential_store(struct device *dev,
>> +				      struct device_attribute *attr,
>> +				      const char *buf, size_t count)
>> +{
>> +	struct devfreq_simple_ondemand_data *data;
>> +	struct devfreq *df = to_devfreq(dev);
>> +	unsigned int value;
>> +	int ret;
>> +
>> +	if (!df->data)
>> +		return -EINVAL;
>> +
>> +	data = df->data;
>> +
>> +	ret = kstrtouint(buf, 10, &value);
>> +	if (ret < 0)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&df->lock);
>> +
>> +	if (value > DFSO_MAX_VALUE || value >= data->upthreshold) {
>> +		mutex_unlock(&df->lock);
>> +		return -EINVAL;
>> +	}
>> +
>> +	data->downdifferential = value;
>> +	mutex_unlock(&df->lock);
>> +
>> +	return count;
>> +}
>> +static DEVICE_ATTR_RW(downdifferential);
>> +
>> +static void devfreq_simple_ondemand_sysfs_setup(struct devfreq *df)
>> +{
>> +	struct devfreq_simple_ondemand_data *data;
>> +	int ret;
>> +
>> +	if (!df->data) {
>> +		/* The memory will be freed automatically */
>> +		df->data = devm_kzalloc(&df->dev,
>> +				sizeof(struct devfreq_simple_ondemand_data),
>> +				GFP_KERNEL);
>> +		if (!df->data) {
>> +			dev_warn(&df->dev, "Unable to allocate memory");
>> +			return;
>> +		}
>> +	}
>> +
>> +	data = df->data;
>> +
>> +	/* After new allocation setup default values, since they are used */
>> +	if (!data->upthreshold)
>> +		data->upthreshold = DFSO_UPTHRESHOLD;
>> +
>> +	if (!data->downdifferential)
>> +		data->downdifferential = DFSO_DOWNDIFFERENCTIAL;
>> +
>> +	ret = sysfs_create_file(&df->dev.kobj, &dev_attr_upthreshold.attr);
>> +	if (ret < 0)
>> +		dev_warn(&df->dev, "Unable to create 'upthreshold' attr\n");
>> +
>> +	ret = sysfs_create_file(&df->dev.kobj, &dev_attr_downdifferential.attr);
>> +	if (ret < 0)
>> +		dev_warn(&df->dev, "Unable to create 'downdifferential' attr\n");
> 
> You just raced with userspace and lost :(
> 
> Please use the default sysfs groups so that it all works properly.
> 
> Huge hint, when calling sysfs_* from a driver, that usually means you
> are doing something wrong.

I should have used kobject_init_and_add() and the default devfreq
sysfs group as a parent.

Thank you for the comments and hints. I'll make use of them next time.

This patch is abandoned, since Chanwoo is already trying to address
the same issue.

Regards,
Lukasz

> 
> thanks,
> 
> greg k-h
> 
