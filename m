Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A69B2FCCD7
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2019 19:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfKNSLF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Nov 2019 13:11:05 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:34077 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfKNSLF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Nov 2019 13:11:05 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191114181102euoutp0284348cb77275a1067247b543d64bea0b~XGeQfaCf-0776607766euoutp02f
        for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2019 18:11:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191114181102euoutp0284348cb77275a1067247b543d64bea0b~XGeQfaCf-0776607766euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573755062;
        bh=nSZ0mbKouPogXQjKg1tS1E50s2Hv9keJH38scoNvolk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=IdbDDNjKJl5F1BN1I8+um46XsiRucuv9viIXvmwAo5uwuboXaDtW5WD7wVf0AQEvN
         GTRLOjsU64QmhjPuHD32YRa5EiYgdwhEinaLXp4gGHu2KF3M0ndU7ICjVW7dT1FMn/
         MZN006BjPkHmcKEOGBUbHIYtqI5L0xGqyeh+A6YA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191114181102eucas1p28c90a8b12ddac58d23d8583a0954d6ae~XGeQM1oXp3096030960eucas1p24;
        Thu, 14 Nov 2019 18:11:02 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id C9.0B.04374.5B89DCD5; Thu, 14
        Nov 2019 18:11:01 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191114181101eucas1p1327a7dc61bcca949e6ebae41526ae2bb~XGePqqaJs0527305273eucas1p19;
        Thu, 14 Nov 2019 18:11:01 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191114181101eusmtrp129e25dbaa734cb978911cb6cc032de8b~XGePp6xe62784427844eusmtrp1h;
        Thu, 14 Nov 2019 18:11:01 +0000 (GMT)
X-AuditID: cbfec7f5-4ddff70000001116-de-5dcd98b59b4d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 37.1D.04166.5B89DCD5; Thu, 14
        Nov 2019 18:11:01 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191114181100eusmtip102c1f543af3ff600d7087f54ce335e5c~XGePGT2x52497824978eusmtip1J;
        Thu, 14 Nov 2019 18:11:00 +0000 (GMT)
Subject: Re: [PATCH 5/7] devfreq: move transition statistics to devfreq
 profile structure
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Kamil Konieczny <k.konieczny@samsung.com>
Cc:     Kamil Konieczny <k.konieczny@partner.samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <55818555-e512-46bf-4ad5-ae9dcb27d32e@samsung.com>
Date:   Thu, 14 Nov 2019 19:10:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <72e517d9-725d-b05d-028f-153bb6684df3@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsWy7djP87pbZ5yNNXh93Mbi+pfnrBZ9+/4z
        Wiz4NIPV4vz5DewWZ5vesFtc3jWHzeJz7xFGi7VH7rJb3G5cwebA6bFpVSebx8F3e5g8+ras
        YvT4vEkugCWKyyYlNSezLLVI3y6BK+PI05VMBd0pFa2XHzE1MH4L6GLk5JAQMJE4//woaxcj
        F4eQwApGib8PH0M5XxglzkxZzAzhfGaUOL27mwmmZeH8NhaIxHJGiVu3PzJCOG8ZJebumsMC
        UiUsEC3xfNt3dhBbRCBUYtK1ZWAdzAKzmSR2Nt0FG8UmYCUxsX0VI4jNK2An8ebADqDlHBws
        AqoS70/ZgYRFBSIkPj04zApRIihxcuYTsPmcAvYSP99cBoszC4hL3HoynwnClpfY/nYO2NkS
        AvvYJRatfgw2U0LAReLQg1iID4QlXh3fwg5hy0icntzDAlG/DhgAHS+gmrczSiyf/I8Nospa
        4vDxi2CDmAU0Jdbv0ocIO0qs+L6CBWI+n8SNt4IQN/BJTNo2nRkizCvR0SYEUa0msWHZBjaY
        tV07VzJPYFSaheSzWUi+mYXkm1kIexcwsqxiFE8tLc5NTy02zkst1ytOzC0uzUvXS87P3cQI
        TEen/x3/uoNx35+kQ4wCHIxKPLwHRM/ECrEmlhVX5h5ilOBgVhLhnfIWKMSbklhZlVqUH19U
        mpNafIhRmoNFSZy3muFBtJBAemJJanZqakFqEUyWiYNTqoHxVJWxk8LOKu6jAYd2HE+xTNrt
        +VBHMNIlwH9u5aeKYjvtQP/yK/d+fY0zlAhP/dB8rJv7md3ciglpvvIlFU8LwtmDz+gvmbaz
        fmXmrYQwrfsV9z/xPzxh8GqzzqrZk1Uu+b50u+TNv7jcZu5yxrhXM/rfHTugnhye9kur265Q
        XXpefeU2XlklluKMREMt5qLiRADWSYZiQwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsVy+t/xu7pbZ5yNNWi/KGpx/ctzVou+ff8Z
        LRZ8msFqcf78BnaLs01v2C0u75rDZvG59wijxdojd9ktbjeuYHPg9Ni0qpPN4+C7PUwefVtW
        MXp83iQXwBKlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqk
        b5egl3Hk6Uqmgu6UitbLj5gaGL8FdDFyckgImEgsnN/G0sXIxSEksJRRYv3HDaxdjBxACRmJ
        4+vLIGqEJf5c62KDqHnNKDH5xAtmkISwQLTE823f2UFsEYFQiVMbJ4MVMQvMZZL40v+XHaLj
        G6PE9Ocf2ECq2ASsJCa2r2IEsXkF7CTeHNgBto1FQFXi/Sk7kLCoQITE4R2zoEoEJU7OfMIC
        YnMK2Ev8fHOZFcRmFlCX+DPvEjOELS5x68l8JghbXmL72znMExiFZiFpn4WkZRaSlllIWhYw
        sqxiFEktLc5Nzy021CtOzC0uzUvXS87P3cQIjL9tx35u3sF4aWPwIUYBDkYlHt4DomdihVgT
        y4orcw8xSnAwK4nwTnkLFOJNSaysSi3Kjy8qzUktPsRoCvTbRGYp0eR8YGrIK4k3NDU0t7A0
        NDc2NzazUBLn7RA4GCMkkJ5YkpqdmlqQWgTTx8TBKdXAOMO1L/X8vUOLe9yueD0ykaqUWbfj
        8g5mf8OvKtcvRKQc/pvJUfDrvvppe/+cwCnCyiWXcuUvyDQL2ni8uqsrEqK3wcm15qfon5bH
        6zefd1ygtn1NscS37utR0c1mE7u4MwOvC6x6ZPyyVWDXo+TOSzrZAkbltr6zRYKqK3N9//+/
        y/7y8bY6JZbijERDLeai4kQAtQ1X+9UCAAA=
X-CMS-MailID: 20191114181101eucas1p1327a7dc61bcca949e6ebae41526ae2bb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191113091353eucas1p283be3173c7a9ea726b4767f9cb113f0f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191113091353eucas1p283be3173c7a9ea726b4767f9cb113f0f
References: <20191113091336.5218-1-k.konieczny@samsung.com>
        <CGME20191113091353eucas1p283be3173c7a9ea726b4767f9cb113f0f@eucas1p2.samsung.com>
        <20191113091336.5218-6-k.konieczny@samsung.com>
        <72e517d9-725d-b05d-028f-153bb6684df3@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Chanwoo,

On 11/14/19 3:02 AM, Chanwoo Choi wrote:
> Hi Kamil,
> 
> The devfreq_dev_profile structure have to only contain the each devfreq device
> callback function/data which are used in the devfreq core.
> 
> The generated information after registered the devfreq device
> with devfreq_add_device() should be stored in the 'struct device'.
> 
> The devfreq core need to split out the data between user input
> data (struct devfreq_dev_profile) and the initialized/generated data
> by core (struct devfreq). It is not same with cpufreq. cpufreq

How's about doing it the other way around -> moving 'freq_table' and
'max_state' from 'struct devfreq_dev_profile' to 'struct devfreq'?

They are both initialized/generated by the core during
devfreq_add_device()->set_freq_table() for all in-kernel drivers.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics 

> don't require the any structure like 'devfreq_dev_profile'.
> 
> So, I can't agree.
> 
> Thanks.
> Chanwoo Choi
> 
> 
> On 11/13/19 6:13 PM, Kamil Konieczny wrote:
>> Move transition statistics to devfreq profile structure. This is for
>> preparation for moving transition statistics into separate struct.
>> It is safe to do as frequency table and maximum state information are
>> already present in devfreq profile structure and there are no devfreq
>> drivers using more than one instance of devfreq structure per devfreq
>> profile one.
>>
>> It also makes devfreq code more similar to cpufreq one.
>>
>> Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
>> ---
>>  drivers/devfreq/devfreq.c | 115 +++++++++++++++++++-------------------
>>  include/linux/devfreq.h   |  25 ++++-----
>>  2 files changed, 70 insertions(+), 70 deletions(-)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index 6e5a17f4c92c..70533b787744 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -128,7 +128,7 @@ static int set_freq_table(struct devfreq *devfreq)
>>  
>>  	profile->max_state = count;
>>  	profile->freq_table = devm_kcalloc(devfreq->dev.parent,
>> -					profile->max_state,
>> +					count,
>>  					sizeof(*profile->freq_table),
>>  					GFP_KERNEL);
>>  	if (!profile->freq_table) {
>> @@ -157,29 +157,30 @@ static int set_freq_table(struct devfreq *devfreq)
>>   */
>>  int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>>  {
>> -	int lev, prev_lev, ret = 0;
>> +	struct devfreq_dev_profile *profile = devfreq->profile;
>>  	unsigned long long cur_time;
>> +	int lev, prev_lev, ret = 0;
>>  
>>  	cur_time = get_jiffies_64();
>>  
>>  	/* Immediately exit if previous_freq is not initialized yet. */
>>  	if (!devfreq->previous_freq) {
>> -		spin_lock(&devfreq->stats_lock);
>> -		devfreq->last_time = cur_time;
>> -		spin_unlock(&devfreq->stats_lock);
>> +		spin_lock(&profile->stats_lock);
>> +		profile->last_time = cur_time;
>> +		spin_unlock(&profile->stats_lock);
>>  		return 0;
>>  	}
>>  
>>  	prev_lev = devfreq_get_freq_level(devfreq, devfreq->previous_freq);
>>  
>> -	spin_lock(&devfreq->stats_lock);
>> +	spin_lock(&profile->stats_lock);
>>  	if (prev_lev < 0) {
>>  		ret = prev_lev;
>>  		goto out;
>>  	}
>>  
>> -	devfreq->time_in_state[prev_lev] +=
>> -			 cur_time - devfreq->last_time;
>> +	profile->time_in_state[prev_lev] +=
>> +			 cur_time - profile->last_time;
>>  	lev = devfreq_get_freq_level(devfreq, freq);
>>  	if (lev < 0) {
>>  		ret = lev;
>> @@ -187,14 +188,14 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>>  	}
>>  
>>  	if (lev != prev_lev) {
>> -		devfreq->trans_table[(prev_lev *
>> -				devfreq->profile->max_state) + lev]++;
>> -		devfreq->total_trans++;
>> +		profile->trans_table[(prev_lev *
>> +				profile->max_state) + lev]++;
>> +		profile->total_trans++;
>>  	}
>>  
>>  out:
>> -	devfreq->last_time = cur_time;
>> -	spin_unlock(&devfreq->stats_lock);
>> +	profile->last_time = cur_time;
>> +	spin_unlock(&profile->stats_lock);
>>  	return ret;
>>  }
>>  EXPORT_SYMBOL(devfreq_update_status);
>> @@ -474,23 +475,23 @@ EXPORT_SYMBOL(devfreq_monitor_suspend);
>>  void devfreq_monitor_resume(struct devfreq *devfreq)
>>  {
>>  	unsigned long freq;
>> +	struct devfreq_dev_profile *profile = devfreq->profile;
>>  
>>  	mutex_lock(&devfreq->lock);
>>  	if (!devfreq->stop_polling)
>>  		goto out;
>>  
>> -	if (!delayed_work_pending(&devfreq->work) &&
>> -			devfreq->profile->polling_ms)
>> +	if (!delayed_work_pending(&devfreq->work) && profile->polling_ms)
>>  		queue_delayed_work(devfreq_wq, &devfreq->work,
>> -			msecs_to_jiffies(devfreq->profile->polling_ms));
>> +			msecs_to_jiffies(profile->polling_ms));
>>  
>> -	spin_lock(&devfreq->stats_lock);
>> -	devfreq->last_time = get_jiffies_64();
>> -	spin_unlock(&devfreq->stats_lock);
>> +	spin_lock(&profile->stats_lock);
>> +	profile->last_time = get_jiffies_64();
>> +	spin_unlock(&profile->stats_lock);
>>  	devfreq->stop_polling = false;
>>  
>> -	if (devfreq->profile->get_cur_freq &&
>> -		!devfreq->profile->get_cur_freq(devfreq->dev.parent, &freq))
>> +	if (profile->get_cur_freq &&
>> +	    !profile->get_cur_freq(devfreq->dev.parent, &freq))
>>  		devfreq->previous_freq = freq;
>>  
>>  out:
>> @@ -657,7 +658,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>  	devfreq->data = data;
>>  	devfreq->nb.notifier_call = devfreq_notifier_call;
>>  
>> -	if (!devfreq->profile->max_state && !devfreq->profile->freq_table) {
>> +	if (!profile->max_state && !profile->freq_table) {
>>  		mutex_unlock(&devfreq->lock);
>>  		err = set_freq_table(devfreq);
>>  		if (err < 0)
>> @@ -693,29 +694,29 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>  		goto err_out;
>>  	}
>>  
>> -	devfreq->trans_table = devm_kzalloc(&devfreq->dev,
>> -			array3_size(sizeof(unsigned int),
>> -				    devfreq->profile->max_state,
>> -				    devfreq->profile->max_state),
>> -			GFP_KERNEL);
>> -	if (!devfreq->trans_table) {
>> +	profile->trans_table = devm_kzalloc(&devfreq->dev,
>> +					    array3_size(sizeof(unsigned int),
>> +							profile->max_state,
>> +							profile->max_state),
>> +					    GFP_KERNEL);
>> +	if (!profile->trans_table) {
>>  		mutex_unlock(&devfreq->lock);
>>  		err = -ENOMEM;
>>  		goto err_devfreq;
>>  	}
>>  
>> -	devfreq->time_in_state = devm_kcalloc(&devfreq->dev,
>> -			devfreq->profile->max_state,
>> -			sizeof(*devfreq->time_in_state),
>> -			GFP_KERNEL);
>> -	if (!devfreq->time_in_state) {
>> +	profile->time_in_state = devm_kcalloc(&devfreq->dev,
>> +					      profile->max_state,
>> +					      sizeof(*profile->time_in_state),
>> +					      GFP_KERNEL);
>> +	if (!profile->time_in_state) {
>>  		mutex_unlock(&devfreq->lock);
>>  		err = -ENOMEM;
>>  		goto err_devfreq;
>>  	}
>>  
>> -	devfreq->last_time = get_jiffies_64();
>> -	spin_lock_init(&devfreq->stats_lock);
>> +	profile->last_time = get_jiffies_64();
>> +	spin_lock_init(&profile->stats_lock);
>>  
>>  	srcu_init_notifier_head(&devfreq->transition_notifier_list);
>>  
>> @@ -1402,9 +1403,10 @@ static ssize_t trans_stat_show(struct device *dev,
>>  			       struct device_attribute *attr, char *buf)
>>  {
>>  	struct devfreq *devfreq = to_devfreq(dev);
>> +	struct devfreq_dev_profile *profile = devfreq->profile;
>>  	ssize_t len;
>>  	int i, j;
>> -	unsigned int max_state = devfreq->profile->max_state;
>> +	unsigned int max_state = profile->max_state;
>>  
>>  	if (!devfreq->stop_polling &&
>>  			devfreq_update_status(devfreq, devfreq->previous_freq))
>> @@ -1415,46 +1417,45 @@ static ssize_t trans_stat_show(struct device *dev,
>>  	len = sprintf(buf, "     From  :   To\n");
>>  	len += sprintf(buf + len, "           :");
>>  
>> -	spin_lock(&devfreq->stats_lock);
>> +	spin_lock(&profile->stats_lock);
>>  	for (i = 0; i < max_state; i++)
>>  		len += sprintf(buf + len, "%10lu",
>> -				devfreq->profile->freq_table[i]);
>> +				profile->freq_table[i]);
>>  
>>  	len += sprintf(buf + len, "   time(ms)\n");
>>  
>>  	for (i = 0; i < max_state; i++) {
>> -		if (devfreq->profile->freq_table[i]
>> -					== devfreq->previous_freq) {
>> +		if (profile->freq_table[i] == devfreq->previous_freq)
>>  			len += sprintf(buf + len, "*");
>> -		} else {
>> +		else
>>  			len += sprintf(buf + len, " ");
>> -		}
>> +
>>  		len += sprintf(buf + len, "%10lu:",
>> -				devfreq->profile->freq_table[i]);
>> +				profile->freq_table[i]);
>>  		for (j = 0; j < max_state; j++)
>>  			len += sprintf(buf + len, "%10u",
>> -				devfreq->trans_table[(i * max_state) + j]);
>> +				profile->trans_table[(i * max_state) + j]);
>>  		len += sprintf(buf + len, "%10llu\n", (u64)
>> -			jiffies64_to_msecs(devfreq->time_in_state[i]));
>> +			jiffies64_to_msecs(profile->time_in_state[i]));
>>  	}
>>  
>>  	len += sprintf(buf + len, "Total transition : %u\n",
>> -					devfreq->total_trans);
>> -	spin_unlock(&devfreq->stats_lock);
>> +					profile->total_trans);
>> +	spin_unlock(&profile->stats_lock);
>>  	return len;
>>  }
>>  static DEVICE_ATTR_RO(trans_stat);
>>  
>> -static void defvreq_stats_clear_table(struct devfreq *devfreq)
>> +static void defvreq_stats_clear_table(struct devfreq_dev_profile *profile)
>>  {
>> -	unsigned int count = devfreq->profile->max_state;
>> -
>> -	spin_lock(&devfreq->stats_lock);
>> -	memset(devfreq->time_in_state, 0, count * sizeof(u64));
>> -	memset(devfreq->trans_table, 0, count * count * sizeof(int));
>> -	devfreq->last_time = get_jiffies_64();
>> -	devfreq->total_trans = 0;
>> -	spin_unlock(&devfreq->stats_lock);
>> +	unsigned int count = profile->max_state;
>> +
>> +	spin_lock(&profile->stats_lock);
>> +	memset(profile->time_in_state, 0, count * sizeof(u64));
>> +	memset(profile->trans_table, 0, count * count * sizeof(int));
>> +	profile->last_time = get_jiffies_64();
>> +	profile->total_trans = 0;
>> +	spin_unlock(&profile->stats_lock);
>>  }
>>  
>>  static ssize_t trans_reset_store(struct device *dev,
>> @@ -1464,7 +1465,7 @@ static ssize_t trans_reset_store(struct device *dev,
>>  {
>>  	struct devfreq *devfreq = to_devfreq(dev);
>>  
>> -	defvreq_stats_clear_table(devfreq);
>> +	defvreq_stats_clear_table(devfreq->profile);
>>  
>>  	return count;
>>  }
>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>> index 2ddf25993f7d..4ceb2a517a9c 100644
>> --- a/include/linux/devfreq.h
>> +++ b/include/linux/devfreq.h
>> @@ -91,6 +91,12 @@ struct devfreq_dev_status {
>>   * @freq_table:		Optional list of frequencies to support statistics
>>   *			and freq_table must be generated in ascending order.
>>   * @max_state:		The size of freq_table.
>> + * @total_trans:	Number of devfreq transitions
>> + * @trans_table:	Statistics of devfreq transitions
>> + * @time_in_state:	Statistics of devfreq states
>> + * @last_time:		The last time stats were updated
>> + * @stats_lock:		Lock protecting trans_table, time_in_state,
>> + *			last_time and total_trans used for statistics
>>   */
>>  struct devfreq_dev_profile {
>>  	unsigned long initial_freq;
>> @@ -104,6 +110,12 @@ struct devfreq_dev_profile {
>>  
>>  	unsigned long *freq_table;
>>  	unsigned int max_state;
>> +	/* information for device frequency transition */
>> +	unsigned int total_trans;
>> +	unsigned int *trans_table;
>> +	u64 *time_in_state;
>> +	unsigned long long last_time;
>> +	spinlock_t stats_lock;
>>  };
>>  
>>  /**
>> @@ -131,12 +143,6 @@ struct devfreq_dev_profile {
>>   * @suspend_freq:	 frequency of a device set during suspend phase.
>>   * @resume_freq:	 frequency of a device set in resume phase.
>>   * @suspend_count:	 suspend requests counter for a device.
>> - * @total_trans:	Number of devfreq transitions
>> - * @trans_table:	Statistics of devfreq transitions
>> - * @time_in_state:	Statistics of devfreq states
>> - * @last_time:		The last time stats were updated
>> - * @stats_lock:		Lock protecting trans_table, time_in_state, last_time
>> - *			and total_trans used for statistics
>>   * @transition_notifier_list: list head of DEVFREQ_TRANSITION_NOTIFIER notifier
>>   *
>>   * This structure stores the devfreq information for a give device.
>> @@ -173,13 +179,6 @@ struct devfreq {
>>  	unsigned long resume_freq;
>>  	atomic_t suspend_count;
>>  
>> -	/* information for device frequency transition */
>> -	unsigned int total_trans;
>> -	unsigned int *trans_table;
>> -	u64 *time_in_state;
>> -	unsigned long long last_time;
>> -	spinlock_t stats_lock;
>> -
>>  	struct srcu_notifier_head transition_notifier_list;
>>  };
>>  
>>

