Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04B3F1142B6
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 15:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbfLEObB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 09:31:01 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:44371 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729406AbfLEObA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Dec 2019 09:31:00 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191205143057euoutp013dc4a2cc61180e38e039b4f4c5988f89~dgBGIzjYp0560605606euoutp01F
        for <linux-pm@vger.kernel.org>; Thu,  5 Dec 2019 14:30:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191205143057euoutp013dc4a2cc61180e38e039b4f4c5988f89~dgBGIzjYp0560605606euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575556257;
        bh=LBUGHOlqOw2oVcux4eglZyStaGdi1Tuso5+frSuYAJM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=k7TCxrZqI0u83gwnQzkNw1byqhHxnq/1AtqOE+LfZ0+blj9zVVqBgvyI2Cjr17dl4
         xgbWbz8zqrqOQB7R6TsDH2u0eqV0cLhX1/xJhm0jaUBCR0KyVXxfVPzpQOGMY3fA0n
         Favjww4AhdTxYp33dSZByFcI4ytEGnIt6JRkE5kE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191205143057eucas1p137b6c619119117d003b832a6c3fe7f75~dgBF4Fgsb1959819598eucas1p1E;
        Thu,  5 Dec 2019 14:30:57 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 15.30.60698.1A419ED5; Thu,  5
        Dec 2019 14:30:57 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191205143056eucas1p13056752b96ac9675b31d5d5fbc9d9113~dgBFbCWA52040320403eucas1p1Q;
        Thu,  5 Dec 2019 14:30:56 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191205143056eusmtrp18721a3671df7b29b05a66d9af1bd908a~dgBFaNSgc0939709397eusmtrp1K;
        Thu,  5 Dec 2019 14:30:56 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-06-5de914a15eb1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 37.8D.07950.0A419ED5; Thu,  5
        Dec 2019 14:30:56 +0000 (GMT)
Received: from [106.120.51.18] (unknown [106.120.51.18]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191205143056eusmtip274eb1d648bcc7eb4cc45faa218a92601~dgBE5QIQB0600306003eusmtip2H;
        Thu,  5 Dec 2019 14:30:56 +0000 (GMT)
Subject: Re: [PATCH v2 3/3] devfreq: move statistics to separate struct
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
From:   Kamil Konieczny <k.konieczny@samsung.com>
Message-ID: <19ef31a6-c9dd-2eb6-fc7f-cdc6a26140b0@samsung.com>
Date:   Thu, 5 Dec 2019 15:30:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <0298e7c0-72ea-ad1d-1a69-68bfaf0d62d1@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsWy7djPc7oLRV7GGjTsY7PYOGM9q8X1L89Z
        Lc6f38BucbbpDbvF5V1z2Cw+9x5htFh75C67xe3GFWwOHB6bVnWyefRtWcXo8XmTXABzFJdN
        SmpOZllqkb5dAldG15qpzAUdQRVbFzezNjA+duxi5OSQEDCRWPHnF3MXIxeHkMAKRonFzQuA
        HA4g5wujxAR9iPhnRonvHf2sMA0PJ3xmhUgsZ5T427UQLCEk8JZRonWWP4gtLOAu8X5HEzuI
        LSKgITHz7xVGkAZmgXlMEm+mXQBrYBPQlzh49iQLiM0rYCfxZdZSNhCbRUBFYuvddnaQK0QF
        IiROf02EKBGUODnzCVg5p4C9xPSr8xlBbGYBcYlbT+YzQdjyEtvfzgH7RkJgE7vE+t7fbBBX
        u0js//kH6gNhiVfHt7BD2DISpyf3sEDY5RJPF/axQzS3MEo8aP8IlbCWOHz8IivIQcwCmhLr
        d+mDmBICjhKrp8pDmHwSN94KQpzAJzFp23RmiDCvREebEMQMVYnnp3qYIGxpia7/61gnMCrN
        QvLYLCTPzELyzCyEtQsYWVYxiqeWFuempxYb56WW6xUn5haX5qXrJefnbmIEppzT/45/3cG4
        70/SIUYBDkYlHt4Zn1/ECrEmlhVX5h5ilOBgVhLhTed7GSvEm5JYWZValB9fVJqTWnyIUZqD
        RUmct5rhQbSQQHpiSWp2ampBahFMlomDU6qBUW3D00pl2+dZgedUGe9P2LxhbdS5478nKa/P
        W3B8bt/eXb0azwKzeWbH/n26WTzp+b+VJ/ujFsfYczVukZER5OUwn3j//DFBceWfRzecLbez
        z9c145nU+O67+edFl9fm7uxNsY6ss3LJbrpuH94TM7tCh63viul52fNHpXSDXri8EH/KFGP1
        S4mlOCPRUIu5qDgRAG1pqLE1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsVy+t/xe7oLRF7GGtz4r2yxccZ6VovrX56z
        Wpw/v4Hd4mzTG3aLy7vmsFl87j3CaLH2yF12i9uNK9gcODw2repk8+jbsorR4/MmuQDmKD2b
        ovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MrjVTmQs6
        giq2Lm5mbWB87NjFyMkhIWAi8XDCZ9YuRi4OIYGljBIrelcyQySkJRpPr2aCsIUl/lzrYoMo
        es0o8fXldnaQhLCAu8T7HU1gtoiAhsTMv1cYQYqYBRYwScy/OZEFJCEk8I1RYvaUehCbTUBf
        4uDZk2BxXgE7iS+zlrKB2CwCKhJb77aDDRIViJB4vv0GI0SNoMTJmU/A6jkF7CWmX50PFmcW
        UJf4M+8SM4QtLnHryXwmCFteYvvbOcwTGIVmIWmfhaRlFpKWWUhaFjCyrGIUSS0tzk3PLTbS
        K07MLS7NS9dLzs/dxAiMtm3Hfm7Zwdj1LvgQowAHoxIP74zPL2KFWBPLiitzDzFKcDArifCm
        872MFeJNSaysSi3Kjy8qzUktPsRoCvTcRGYp0eR8YCLIK4k3NDU0t7A0NDc2NzazUBLn7RA4
        GCMkkJ5YkpqdmlqQWgTTx8TBKdXAeMilcJ9QmdmuWVtLGqe41Xr6r/nJF39iii3bTU+ly9Mi
        XP5KFH0uE3E6sEfUtOdDrc6dvicmO1Z6Wd/rP3NK9e9Kswr/Uu0ZvzfX7ix5u+wUa+XTC507
        WX8v38t1+3lKBPteSdNDXC+nvzqe0X/xxKENb89ek53KsHCOZBcf33nLqzv+xXokhSuxFGck
        GmoxFxUnAgAspOTMzAIAAA==
X-CMS-MailID: 20191205143056eucas1p13056752b96ac9675b31d5d5fbc9d9113
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191204150034eucas1p1b6e7f43a6be59ed2e0a4e55ccdefc750
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191204150034eucas1p1b6e7f43a6be59ed2e0a4e55ccdefc750
References: <20191204150018.5234-1-k.konieczny@samsung.com>
        <CGME20191204150034eucas1p1b6e7f43a6be59ed2e0a4e55ccdefc750@eucas1p1.samsung.com>
        <20191204150018.5234-4-k.konieczny@samsung.com>
        <0298e7c0-72ea-ad1d-1a69-68bfaf0d62d1@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Chanwoo,

On 05.12.2019 02:46, Chanwoo Choi wrote:
> On 12/5/19 12:00 AM, Kamil Konieczny wrote:
>> Count time and transitions between devfreq frequencies in separate struct
>> for improved code readability and maintenance.
>>
>> Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
>> ---
>> Changes in v2:
>>  squash three patches into one, do not modify devfreq_profile and separate stats
>>  into devfreq_stats
>>
>>  drivers/devfreq/devfreq.c | 68 +++++++++++++++++++++++----------------
>>  include/linux/devfreq.h   | 31 ++++++++++++------
>>  2 files changed, 62 insertions(+), 37 deletions(-)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index 901af3b66a76..4d50c8f10bd2 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -198,6 +198,7 @@ static int set_freq_table(struct devfreq *devfreq)
>>   */
>>  int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>>  {
>> +	struct devfreq_stats *stats = devfreq->stats;
>>  	int lev, prev_lev, ret = 0;
>>  	unsigned long long cur_time;
>>  
>> @@ -214,8 +215,8 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>>  		goto out;
>>  	}
>>  
>> -	devfreq->time_in_state[prev_lev] +=
>> -			 cur_time - devfreq->last_stat_updated;
>> +	stats->time_in_state[prev_lev] +=
>> +			 cur_time - stats->last_stat_updated;
>>  
>>  	lev = devfreq_get_freq_level(devfreq, freq);
>>  	if (lev < 0) {
>> @@ -224,13 +225,12 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>>  	}
>>  
>>  	if (lev != prev_lev) {
>> -		devfreq->trans_table[(prev_lev *
>> -				devfreq->profile->max_state) + lev]++;
>> -		devfreq->total_trans++;
>> +		stats->trans_table[(prev_lev * stats->max_state) + lev]++;
>> +		stats->total_trans++;
>>  	}
>>  
>>  out:
>> -	devfreq->last_stat_updated = cur_time;
>> +	stats->last_stat_updated = cur_time;
>>  	return ret;
>>  }
>>  EXPORT_SYMBOL(devfreq_update_status);
>> @@ -525,7 +525,7 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
>>  			msecs_to_jiffies(devfreq->profile->polling_ms));
>>  
>>  out_update:
>> -	devfreq->last_stat_updated = get_jiffies_64();
>> +	devfreq->stats->last_stat_updated = get_jiffies_64();
>>  	devfreq->stop_polling = false;
>>  
>>  	if (devfreq->profile->get_cur_freq &&
>> @@ -735,28 +735,38 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>  		goto err_out;
>>  	}
>>  
>> -	devfreq->trans_table = devm_kzalloc(&devfreq->dev,
>> +	devfreq->stats = devm_kzalloc(&devfreq->dev, sizeof(*devfreq->stats),
>> +				      GFP_KERNEL);
> 
> Each devfreq has only one stats structure always. Don't need to define
> it with pointer type. It is enough to define as following without pointer type:
> 
> 	struct devfreq_stats stats;
> 
Good point, I will change this.

>> +	if (!devfreq->stats) {
>> +		mutex_unlock(&devfreq->lock);
>> +		err = -ENOMEM;
>> +		goto err_devfreq;
>> +	}
>> +
>> +	devfreq->stats->freq_table = devfreq->profile->freq_table;
>> +	devfreq->stats->max_state = devfreq->profile->max_state;
>> +	devfreq->stats->trans_table = devm_kzalloc(&devfreq->dev,
>>  			array3_size(sizeof(unsigned int),
>> -				    devfreq->profile->max_state,
>> -				    devfreq->profile->max_state),
>> +				    devfreq->stats->max_state,
>> +				    devfreq->stats->max_state),
>>  			GFP_KERNEL);
>> -	if (!devfreq->trans_table) {
>> +	if (!devfreq->stats->trans_table) {
>>  		mutex_unlock(&devfreq->lock);
>>  		err = -ENOMEM;
>>  		goto err_devfreq;
>>  	}
>>  
>> -	devfreq->time_in_state = devm_kcalloc(&devfreq->dev,
>> -			devfreq->profile->max_state,
>> -			sizeof(*devfreq->time_in_state),
>> +	devfreq->stats->time_in_state = devm_kcalloc(&devfreq->dev,
>> +			devfreq->stats->max_state,
>> +			sizeof(*devfreq->stats->time_in_state),
>>  			GFP_KERNEL);
> 
> Actually, this patch will be conflict with patch[1].
> [1] https://www.spinics.net/lists/arm-kernel/msg768822.html
> 
> First of all, I have to merge patches[1][2] for the devfreq pm-qos
> during v5.5-rc period. It requires the linux-pm's maintainer.
> [2] https://www.spinics.net/lists/arm-kernel/msg769761.html
> 
> After finishing the job[1][2], I'll merge this patch
> if finished the review of this patch. Just share the possible merge
> conflict to you.
> 

Ok, I will rebase and send when you will need this,
please remind me when it happens.

> 
>> -	if (!devfreq->time_in_state) {
>> +	if (!devfreq->stats->time_in_state) {
>>  		mutex_unlock(&devfreq->lock);
>>  		err = -ENOMEM;
>>  		goto err_devfreq;
>>  	}
>>  
>> -	devfreq->last_stat_updated = get_jiffies_64();
>> +	devfreq->stats->last_stat_updated = get_jiffies_64();
>>  
>>  	srcu_init_notifier_head(&devfreq->transition_notifier_list);
>>  
>> @@ -1435,9 +1445,10 @@ static ssize_t trans_stat_show(struct device *dev,
>>  			       struct device_attribute *attr, char *buf)
>>  {
>>  	struct devfreq *devfreq = to_devfreq(dev);
>> +	struct devfreq_stats *stats = devfreq->stats;
>> +	unsigned int max_state = stats->max_state;
>>  	ssize_t len;
>>  	int i, j;
>> -	unsigned int max_state = devfreq->profile->max_state;
>>  
>>  	if (max_state == 0)
>>  		return sprintf(buf, "Not Supported.\n");
>> @@ -1454,28 +1465,28 @@ static ssize_t trans_stat_show(struct device *dev,
>>  	len += sprintf(buf + len, "           :");
>>  	for (i = 0; i < max_state; i++)
>>  		len += sprintf(buf + len, "%10lu",
>> -				devfreq->profile->freq_table[i]);
>> +				stats->freq_table[i]);
>>  
>>  	len += sprintf(buf + len, "   time(ms)\n");
>>  
>>  	for (i = 0; i < max_state; i++) {
>> -		if (devfreq->profile->freq_table[i]
>> +		if (stats->freq_table[i]
>>  					== devfreq->previous_freq) {
>>  			len += sprintf(buf + len, "*");
>>  		} else {
>>  			len += sprintf(buf + len, " ");
>>  		}
>>  		len += sprintf(buf + len, "%10lu:",
>> -				devfreq->profile->freq_table[i]);
>> +				stats->freq_table[i]);
>>  		for (j = 0; j < max_state; j++)
>>  			len += sprintf(buf + len, "%10u",
>> -				devfreq->trans_table[(i * max_state) + j]);
>> +				stats->trans_table[(i * max_state) + j]);
>>  		len += sprintf(buf + len, "%10llu\n", (u64)
>> -			jiffies64_to_msecs(devfreq->time_in_state[i]));
>> +			jiffies64_to_msecs(stats->time_in_state[i]));
>>  	}
>>  
>>  	len += sprintf(buf + len, "Total transition : %u\n",
>> -					devfreq->total_trans);
>> +					stats->total_trans);
>>  	return len;
>>  }
>>  
>> @@ -1484,16 +1495,17 @@ static ssize_t trans_stat_store(struct device *dev,
>>  				const char *buf, size_t count)
>>  {
>>  	struct devfreq *df = to_devfreq(dev);
>> -	unsigned int cnt = df->profile->max_state;
>> +	struct devfreq_stats *stats = df->stats;
>> +	unsigned int cnt = stats->max_state;
>>  
>>  	if (cnt == 0)
>>  		return count;
>>  
>>  	mutex_lock(&df->lock);
>> -	memset(df->time_in_state, 0, cnt * sizeof(u64));
>> -	memset(df->trans_table, 0, cnt * cnt * sizeof(int));
>> -	df->last_stat_updated = get_jiffies_64();
>> -	df->total_trans = 0;
>> +	memset(stats->time_in_state, 0, cnt * sizeof(u64));
>> +	memset(stats->trans_table, 0, cnt * cnt * sizeof(int));
>> +	stats->last_stat_updated = get_jiffies_64();
>> +	stats->total_trans = 0;
>>  	mutex_unlock(&df->lock);
>>  
>>  	return count;
>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>> index b81a86e47fb9..2715719924e7 100644
>> --- a/include/linux/devfreq.h
>> +++ b/include/linux/devfreq.h
>> @@ -106,6 +106,25 @@ struct devfreq_dev_profile {
>>  	unsigned int max_state;
>>  };
>>  
>> +/**
>> + * struct devfreq_stats - Devfreq's transitions stats counters
> 
> Devfreq's transitions stats counters -> Statistics of devfreq device behavior

Thanks, changed.

>> + * @freq_table:		List of frequencies in ascending order.
>> + * @max_state:		The size of freq_table.
>> + * @total_trans:	Number of devfreq transitions.
>> + * @trans_table:	Statistics of devfreq transitions.
>> + * @time_in_state:	Statistics of devfreq states.
>> + * @last_stat_updated:	The last time stats were updated.
>> + */
>> +struct devfreq_stats {
>> +	unsigned long *freq_table;
>> +	unsigned int max_state;
> 
> Acutally, I'm sorry I has not yet completely agreed to move
> 'freq_table and 'max_state' from struct devfreq to struct devfreq_stats.
> It has not any critical benefit and any problem.
> So, don't move 'freq_table' and 'max_state'. 

I removed these two from devfreq_stats and use devfreq->profile as in original
devfreq code.

> 
>> +
>> +	unsigned int total_trans;
>> +	unsigned int *trans_table;
>> +	u64 *time_in_state;
>> +	unsigned long long last_stat_updated;
>> +};
>> +
>>  /**
>>   * struct devfreq - Device devfreq structure
>>   * @node:	list node - contains the devices with devfreq that have been
>> @@ -131,10 +150,7 @@ struct devfreq_dev_profile {
>>   * @suspend_freq:	 frequency of a device set during suspend phase.
>>   * @resume_freq:	 frequency of a device set in resume phase.
>>   * @suspend_count:	 suspend requests counter for a device.
>> - * @total_trans:	Number of devfreq transitions
>> - * @trans_table:	Statistics of devfreq transitions
>> - * @time_in_state:	Statistics of devfreq states
>> - * @last_stat_updated:	The last time stat updated
>> + * @stats:	Statistics of devfreq transitions and states times
> 
> Statistics of devfreq transitions and states times
> -> Statistics of devfreq device behavior
>

Ok.
 
>>   * @transition_notifier_list: list head of DEVFREQ_TRANSITION_NOTIFIER notifier
>>   *
>>   * This structure stores the devfreq information for a give device.
>> @@ -171,11 +187,8 @@ struct devfreq {
>>  	unsigned long resume_freq;
>>  	atomic_t suspend_count;
>>  
>> -	/* information for device frequency transition */
>> -	unsigned int total_trans;
>> -	unsigned int *trans_table;
>> -	u64 *time_in_state;
>> -	unsigned long long last_stat_updated;
>> +	/* information for device frequency transitions */
>> +	struct devfreq_stats *stats;
> 
> Each devfreq has only one stats structure always. Don't need to define
> it with pointer type. It is enough to define as following without pointer type:
> 
> 	struct devfreq_stats stats;
> 
>>  
>>  	struct srcu_notifier_head transition_notifier_list;
>>  };
>>
-- 
Best regards,
Kamil Konieczny
Samsung R&D Institute Poland

