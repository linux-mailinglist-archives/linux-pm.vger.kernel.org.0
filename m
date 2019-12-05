Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFC911426C
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 15:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbfLEOSZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 09:18:25 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:60391 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729240AbfLEOSZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Dec 2019 09:18:25 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191205141822euoutp027164ccb4b8bcafa01dba9d991d71f787~df2HIKRAo1325613256euoutp02p
        for <linux-pm@vger.kernel.org>; Thu,  5 Dec 2019 14:18:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191205141822euoutp027164ccb4b8bcafa01dba9d991d71f787~df2HIKRAo1325613256euoutp02p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575555502;
        bh=M6wOm/SmUdZkY0C9E6xQoJFvr3w3HxXkttU5iQwAelA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=rkh0R2xNAWWEY/7vMV/7I2btIdxNUs8Rg+gtG3sny7jeAXwdGXjyu3qiwsIIeGqpA
         H7JpjwYOGKmEFaPMlsus+2eymfMP2J8DBsEgTwBZpVibWp0ikYKi/4lWqNEHwVhtcV
         FSukDLxY6PPbC+AKxmvn2/EUVjPB3hxXLcJV7XJU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191205141822eucas1p2c9ae50b258b607d1273a1696de63a815~df2G2Re9H2093220932eucas1p2v;
        Thu,  5 Dec 2019 14:18:22 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 41.06.60679.EA119ED5; Thu,  5
        Dec 2019 14:18:22 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191205141821eucas1p25a45bb5a633e8f806b29306e81e36d4a~df2Gg5i242108021080eucas1p2b;
        Thu,  5 Dec 2019 14:18:21 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191205141821eusmtrp2b4e7117bff3f12de9b2da3db691dc05d~df2GgNrx73066430664eusmtrp2y;
        Thu,  5 Dec 2019 14:18:21 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-ec-5de911aeb588
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 20.9B.07950.DA119ED5; Thu,  5
        Dec 2019 14:18:21 +0000 (GMT)
Received: from [106.120.51.18] (unknown [106.120.51.18]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191205141821eusmtip28b4a5a2d9b7da162bdf533d07127ff94~df2F9l0iS2970329703eusmtip2e;
        Thu,  5 Dec 2019 14:18:21 +0000 (GMT)
Subject: Re: [PATCH v2 3/3] devfreq: move statistics to separate struct
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
From:   Kamil Konieczny <k.konieczny@samsung.com>
Message-ID: <d2bc3e5f-3170-4dff-9ce6-ceb2555ae0ba@samsung.com>
Date:   Thu, 5 Dec 2019 15:18:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191205002852.GJ228856@google.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsWy7djP87rrBF/GGryczm+xccZ6VovrX56z
        Wpw/v4Hd4mzTG3aLy7vmsFl87j3CaLH2yF12i88bHjNa3G5cwebA6TG74SKLx6ZVnWwefVtW
        MXp83iQXwBLFZZOSmpNZllqkb5fAlfHk2H62gh0+FbO72tkaGJfZdjFyckgImEh82nWHqYuR
        i0NIYAWjxKuGIywQzhdGiZlv17ODVAkJfGaU+HWGB6bjUucBNoii5YwSk9v6odrfMkq83L6J
        GaRKWMBd4v2OJrBuEQENiSe/zzOCFDELHGOS2HXoLytIgk1AX+Lg2ZMsIDavgJ3EhdMNTCA2
        i4CKxL7/v4BWcHCICkRInP6aCFEiKHFy5hOwck4BQ4nWo/vBxjALiEvcejKfCcKWl9j+dg4z
        yC4JgV3sEn+3T2eDONtF4v3DY6wQtrDEq+Nb2CFsGYn/OyGaJQTKJZ4u7GOHaG5hlHjQ/pEF
        ImEtcfj4RVaQg5gFNCXW79IHMSUEHCVWT5WHMPkkbrwVhDiBT2LStunMEGFeiY42IYgZqhLP
        T/VALZKW6Pq/jnUCo9IsJI/NQvLMLCTPzEJYu4CRZRWjeGppcW56arFRXmq5XnFibnFpXrpe
        cn7uJkZgKjr97/iXHYy7/iQdYhTgYFTi4Z3x+UWsEGtiWXFl7iFGCQ5mJRHedL6XsUK8KYmV
        ValF+fFFpTmpxYcYpTlYlMR5qxkeRAsJpCeWpGanphakFsFkmTg4pRoYlb/l821//7jw8d0L
        d3euWaWh3nUltkHsu0W+1uYTC7r0G8T0Y8yDjgWorGKrbDmfEWm57bP/nWLRyX8LVgbczH6e
        q6FRoNr5sdMh+NffonsbQp7MOZ9x3G573F6p2y/0X8ya6tb1MeHo1MfmbSFsThEGc9xX7tn3
        QfZ3h2a/48KE7QHqOtVpSizFGYmGWsxFxYkA5qwqn0EDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsVy+t/xe7prBV/GGkzrMrPYOGM9q8X1L89Z
        Lc6f38BucbbpDbvF5V1z2Cw+9x5htFh75C67xecNjxktbjeuYHPg9JjdcJHFY9OqTjaPvi2r
        GD0+b5ILYInSsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3S
        t0vQy3hybD9bwQ6fitld7WwNjMtsuxg5OSQETCQudR5g62Lk4hASWMooMfPuJ3aIhLRE4+nV
        TBC2sMSfa11QRa8ZJT4DHQySEBZwl3i/ownMFhHQkHjy+zwjSBGzwDEmiQeLXjJDdLxglPhx
        dzMLSBWbgL7EwbMnwWxeATuJC6cbwFawCKhI7Pv/iw3EFhWIkHi+/QYjRI2gxMmZT8DqOQUM
        JVqP7mcFsZkF1CX+zLvEDGGLS9x6Mp8JwpaX2P52DvMERqFZSNpnIWmZhaRlFpKWBYwsqxhF
        UkuLc9Nzi430ihNzi0vz0vWS83M3MQJjcNuxn1t2MHa9Cz7EKMDBqMTDO+Pzi1gh1sSy4src
        Q4wSHMxKIrzpfC9jhXhTEiurUovy44tKc1KLDzGaAj03kVlKNDkfmB7ySuINTQ3NLSwNzY3N
        jc0slMR5OwQOxggJpCeWpGanphakFsH0MXFwSjUwLrlQEOu+893S9WqbuC/kz1/1OqNlmYz9
        +ZzOGwqZs2sDlYp+W7rN/s0d4RouGuR+wyP3o+6r13ozfax/Pevy/V21dBW/UJYZ96aVd88q
        3rZbNfNIicOFVQ8NEpkd6wvlZpof/Sd9IPNEYE/o00N/hIy+KU36csfj5j0P1u5rVVwlecYJ
        l37uUWIpzkg01GIuKk4EALi/ar/XAgAA
X-CMS-MailID: 20191205141821eucas1p25a45bb5a633e8f806b29306e81e36d4a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191204150034eucas1p1b6e7f43a6be59ed2e0a4e55ccdefc750
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191204150034eucas1p1b6e7f43a6be59ed2e0a4e55ccdefc750
References: <20191204150018.5234-1-k.konieczny@samsung.com>
        <CGME20191204150034eucas1p1b6e7f43a6be59ed2e0a4e55ccdefc750@eucas1p1.samsung.com>
        <20191204150018.5234-4-k.konieczny@samsung.com>
        <20191205002852.GJ228856@google.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

thank you for review, I will follow you suggestions in v3.

On 05.12.2019 01:28, Matthias Kaehlcke wrote:
> Hi,
> 
> On Wed, Dec 04, 2019 at 04:00:18PM +0100, Kamil Konieczny wrote:
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
>> + * @freq_table:		List of frequencies in ascending order.
>> + * @max_state:		The size of freq_table.
>> + * @total_trans:	Number of devfreq transitions.
>> + * @trans_table:	Statistics of devfreq transitions.
>> + * @time_in_state:	Statistics of devfreq states.
>> + * @last_stat_updated:	The last time stats were updated.
>> + */
>> +struct devfreq_stats {
>> +	unsigned long *freq_table;
> 
> nit: trans_stat_show() is the only place where 'freq_table' is
> used. Instead of 'duplicating' it (I know, it's just a pointer)
> you could use a local pointer 'freq_table' in trans_stat_show().
> 
>> +	unsigned int max_state;
> 
> nit: max_state is also a bit of a corner case. It's not really a 'stat' and
> it is already available in struct devfreq_dev_profile, it doesn't seem a
> huge inconvenient to take it from there.

Good hints, I will change this.

>> +
>> +	unsigned int total_trans;
>> +	unsigned int *trans_table;
>> +	u64 *time_in_state;
>> +	unsigned long long last_stat_updated;
> 
> nit: the name 'last_stat_updated' is somewhat redundant, since the
> field is part of a struct called 'devfreq_stats'. 'last_updated' or
> 'last_update' would be concise enough IMO.

This is also good hint.

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
>>  
>>  	struct srcu_notifier_head transition_notifier_list;
>>  };
> 
> My comments above are just suggestions:
> 
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

-- 
Best regards,
Kamil Konieczny
Samsung R&D Institute Poland

