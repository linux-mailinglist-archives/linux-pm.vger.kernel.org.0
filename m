Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04B04114C0B
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2019 06:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbfLFFYG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Dec 2019 00:24:06 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:27192 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfLFFYF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Dec 2019 00:24:05 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191206052400epoutp0213ac3fd268ce414e30d1b62b010ea693~dsM1g3SGA1907019070epoutp02R
        for <linux-pm@vger.kernel.org>; Fri,  6 Dec 2019 05:24:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191206052400epoutp0213ac3fd268ce414e30d1b62b010ea693~dsM1g3SGA1907019070epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575609840;
        bh=vvnxh4w1i9LIW95arbUdbIWWoYK7IZUQGQtBBEjNDY8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=oWLwNKFmTWRO6AUPm4oPC6LXHMXT/ptuZwl2a2JypTQc+M3Di9ZRj+JthoFA1+cX9
         uVQIYUILAPe2UEXh2ibkJcoKsmeNujtdEjSNwxfIQMMzrlcy0IMpDQOvLUm6bxc+q+
         v5hJzS1NDptRNykYtYtIB5oo57ownBTd5gHFmd54=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191206052359epcas1p2a5dff4f9ce7b77db7ecf7fb57e3e65c2~dsMz5mkhO0492104921epcas1p2E;
        Fri,  6 Dec 2019 05:23:59 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.152]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47Tgx859hWzMqYkY; Fri,  6 Dec
        2019 05:23:56 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        40.76.48019.9E5E9ED5; Fri,  6 Dec 2019 14:23:53 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191206052353epcas1p1538852f3d155220ab23693584074d685~dsMuR7_dl0127101271epcas1p1c;
        Fri,  6 Dec 2019 05:23:53 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191206052352epsmtrp258c86402096a7b0200b021e05d13f310~dsMt3Nry62080520805epsmtrp2W;
        Fri,  6 Dec 2019 05:23:52 +0000 (GMT)
X-AuditID: b6c32a38-257ff7000001bb93-07-5de9e5e9ee33
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        13.D8.10238.8E5E9ED5; Fri,  6 Dec 2019 14:23:52 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191206052352epsmtip1ee7d6a8852b806b8efe5ec5dba109289~dsMtr4B1T3052130521epsmtip1p;
        Fri,  6 Dec 2019 05:23:52 +0000 (GMT)
Subject: Re: [PATCH v3 3/3] devfreq: move statistics to separate struct
To:     Kamil Konieczny <k.konieczny@samsung.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Matthias Kaehlcke <mka@chromium.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <61534e36-99c2-6a94-ff0a-3be297bd1b24@samsung.com>
Date:   Fri, 6 Dec 2019 14:30:05 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20191205145527.26117-4-k.konieczny@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNJsWRmVeSWpSXmKPExsWy7bCmge7Lpy9jDe7eNLXYOGM9q8WCTzNY
        Lc6f38BucbbpDbvF5V1z2Cw+9x5htFh75C67xecNjxktbjeuYHPg9JjdcJHFY9OqTjaPvi2r
        GD0+b5ILYInKtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1
        y8wBukVJoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BZoFecmFtcmpeul5yfa2Vo
        YGBkClSYkJ1x88AW5oJOn4qelg+sDYyHbLoYOTkkBEwkHjzbz9rFyMUhJLCDUWLJqv1sEM4n
        Rokpe5YyQzjfGCVWPHnECNOyY1knE0RiL6PEnk0PoVreM0r8a3kOViUs4C7Rv+kXE4gtIqAr
        8WYHxChmgWNMEid/zmMHSbAJaEnsf3GDDcTmF1CUuPrjMVgzr4CdxJGpt8BsFgEVibNbnoPV
        iAqESZzc1gJVIyhxcuYTFhCbU8BWYu7xhWA1zALiEreezGeCsOUltr+dA7ZYQuA3m8Tkfy+B
        ijiAHBeJ2ROSIN4Rlnh1fAs7hC0l8fndXjYIu1pi5ckjbBC9HYwSW/ZfYIVIGEvsXzqZCWQO
        s4CmxPpd+hBhRYmdv+cyQuzlk3j3tYcVYhWvREebEESJssTlB3eZIGxJicXtnWwTGJVmIflm
        FpIPZiH5YBbCsgWMLKsYxVILinPTU4sNC0yQo3sTIzihalnsYNxzzucQowAHoxIP74zPL2KF
        WBPLiitzDzFKcDArifCm872MFeJNSaysSi3Kjy8qzUktPsRoCgzsicxSosn5wGSfVxJvaGpk
        bGxsYWJoZmpoqCTOy/HjYqyQQHpiSWp2ampBahFMHxMHp1QDo5rX5NLJVkVX41gcJOwZlr7c
        axBZl+029fc9jysql+eE7V79aEPFiQ2R6094H5Z7FBXSXJR1L0tqeWtZJWvTjJlSAbtjgu5O
        4moocX75isHr6Lb09pyf/Hv8Jk1ad9jrDbf50gv/+r7oL//H8y/lzIyn7bZHXaVuldW7fA+U
        FYyvz3sl/srXX4mlOCPRUIu5qDgRAHAAyxy+AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsWy7bCSnO6Lpy9jDaaelrfYOGM9q8WCTzNY
        Lc6f38BucbbpDbvF5V1z2Cw+9x5htFh75C67xecNjxktbjeuYHPg9JjdcJHFY9OqTjaPvi2r
        GD0+b5ILYInisklJzcksSy3St0vgyrh5YAtzQadPRU/LB9YGxkM2XYycHBICJhI7lnUygdhC
        ArsZJR6fKIOIS0pMu3iUuYuRA8gWljh8uBii5C2jxIYPbiC2sIC7RP+mX2CtIgK6Em92LAUq
        5+JgFjjGJNE4pYcJxBESOMwosX33enaQKjYBLYn9L26wgdj8AooSV388ZgSxeQXsJI5MvQVm
        swioSJzd8hysRlQgTGLnksdMEDWCEidnPmEBsTkFbCXmHl8IVsMsoC7xZ94lZghbXOLWk/lM
        ELa8xPa3c5gnMArPQtI+C0nLLCQts5C0LGBkWcUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpec
        n7uJERxXWpo7GC8viT/EKMDBqMTDO+Pzi1gh1sSy4srcQ4wSHMxKIrzpfC9jhXhTEiurUovy
        44tKc1KLDzFKc7AoifM+zTsWKSSQnliSmp2aWpBaBJNl4uCUamAU33DkfNia0iq1nqOWWWyS
        F9YZRCnX13qeW71tz4kD7f/K3bs4Ct+ES/z/tfmtxNlH9vO57gu8v2fZ5e8sM+3po+WyDEHz
        tRZvOTDZdcnt85YLjV2fuJqHN514p36pXLlu/rvVlsnMTTP578iWKxzxCpxbHrhs2XPW2rYm
        vtym+czlE8qfFl1XYinOSDTUYi4qTgQAaWiSWKcCAAA=
X-CMS-MailID: 20191206052353epcas1p1538852f3d155220ab23693584074d685
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191205145544eucas1p17e64389fdee24549a523c624c13194d7
References: <20191205145527.26117-1-k.konieczny@samsung.com>
        <CGME20191205145544eucas1p17e64389fdee24549a523c624c13194d7@eucas1p1.samsung.com>
        <20191205145527.26117-4-k.konieczny@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Looks good. But, it include the some clean-up code
regardless of 'struct stats'. So, I modified them as following by myself:

- Remove the code touched the 'devfreq->profile' in this patch
- Use 'devfreq->stats.*' style instead of 'stats->*' in order to
 keep the consistent coding style.

On 12/5/19 11:55 PM, Kamil Konieczny wrote:
> Count time and transitions between devfreq frequencies in separate struct
> for improved code readability and maintenance.
> 
> Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v3:
> - removed freq_table and max_state from struct devfreq_stats as they are
>   already present in struct devfreq_dev_profile
> - renamed last_stat_updated to last_update, as 'stat' is already present
>   in struct devfreq_stats
> - define struct devfreq_stats stats; in devfreq as there is only one
>   stats per devfreq
> - improve descriptions of devfreq_stats and stats
> - use profile instead of devfreq->profile in devfreq_add_device, as this
>   var is already parameter
> - added Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> 
> Changes in v2:
> - squash three patches into one, do not modify devfreq_profile and separate stats
>   into devfreq_stats
> ---
>  drivers/devfreq/devfreq.c | 67 ++++++++++++++++++++-------------------
>  include/linux/devfreq.h   | 26 +++++++++------
>  2 files changed, 51 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 218eb64d7f28..bcd7e92d2cf3 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -198,6 +198,7 @@ static int set_freq_table(struct devfreq *devfreq)
>   */
>  int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>  {
> +	struct devfreq_stats *stats = &devfreq->stats;
>  	int lev, prev_lev, ret = 0;
>  	u64 cur_time;
>  
> @@ -214,9 +215,7 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>  		goto out;
>  	}
>  
> -	devfreq->time_in_state[prev_lev] +=
> -			 cur_time - devfreq->last_stat_updated;
> -
> +	stats->time_in_state[prev_lev] += cur_time - stats->last_update;
>  	lev = devfreq_get_freq_level(devfreq, freq);
>  	if (lev < 0) {
>  		ret = lev;
> @@ -224,13 +223,13 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>  	}
>  
>  	if (lev != prev_lev) {
> -		devfreq->trans_table[(prev_lev *
> -				devfreq->profile->max_state) + lev]++;
> -		devfreq->total_trans++;
> +		stats->trans_table[(prev_lev * devfreq->profile->max_state) +
> +				   lev]++;
> +		stats->total_trans++;
>  	}
>  
>  out:
> -	devfreq->last_stat_updated = cur_time;
> +	stats->last_update = cur_time;
>  	return ret;
>  }
>  EXPORT_SYMBOL(devfreq_update_status);
> @@ -525,7 +524,7 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
>  			msecs_to_jiffies(devfreq->profile->polling_ms));
>  
>  out_update:
> -	devfreq->last_stat_updated = get_jiffies_64();
> +	devfreq->stats.last_update = get_jiffies_64();
>  	devfreq->stop_polling = false;
>  
>  	if (devfreq->profile->get_cur_freq &&
> @@ -735,28 +734,29 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  		goto err_out;
>  	}
>  
> -	devfreq->trans_table = devm_kzalloc(&devfreq->dev,
> +	devfreq->stats.trans_table = devm_kzalloc(&devfreq->dev,
>  			array3_size(sizeof(unsigned int),
> -				    devfreq->profile->max_state,
> -				    devfreq->profile->max_state),

It is not good touching the 'devfreq->profile' variable
that is not related to 'struct devfreq_stats'. Just keep the previous code.


> +				    profile->max_state,
> +				    profile->max_state),
>  			GFP_KERNEL);
> -	if (!devfreq->trans_table) {
> +	if (!devfreq->stats.trans_table) {
>  		mutex_unlock(&devfreq->lock);
>  		err = -ENOMEM;
>  		goto err_devfreq;
>  	}
>  
> -	devfreq->time_in_state = devm_kcalloc(&devfreq->dev,
> -			devfreq->profile->max_state,
> -			sizeof(*devfreq->time_in_state),
> +	devfreq->stats.time_in_state = devm_kcalloc(&devfreq->dev,
> +			profile->max_state,

ditto. Just keep the previous code.

> +			sizeof(*devfreq->stats.time_in_state),
>  			GFP_KERNEL);
> -	if (!devfreq->time_in_state) {
> +	if (!devfreq->stats.time_in_state) {
>  		mutex_unlock(&devfreq->lock);
>  		err = -ENOMEM;
>  		goto err_devfreq;
>  	}
>  
> -	devfreq->last_stat_updated = get_jiffies_64();
> +	devfreq->stats.last_update = get_jiffies_64();
> +	devfreq->stats.total_trans = 0;
>  
>  	srcu_init_notifier_head(&devfreq->transition_notifier_list);
>  
> @@ -1435,9 +1435,11 @@ static ssize_t trans_stat_show(struct device *dev,
>  			       struct device_attribute *attr, char *buf)
>  {
>  	struct devfreq *devfreq = to_devfreq(dev);
> +	struct devfreq_stats *stats = &devfreq->stats;
> +	unsigned int max_state = devfreq->profile->max_state;
> +	unsigned long *freq_table = devfreq->profile->freq_table;
>  	ssize_t len;
>  	int i, j;
> -	unsigned int max_state = devfreq->profile->max_state;

It is not good touching the 'devfreq->profile' variable
that is not related to 'struct devfreq_stats'.

>  
>  	if (max_state == 0)
>  		return sprintf(buf, "Not Supported.\n");
> @@ -1453,29 +1455,27 @@ static ssize_t trans_stat_show(struct device *dev,
>  	len = sprintf(buf, "     From  :   To\n");
>  	len += sprintf(buf + len, "           :");
>  	for (i = 0; i < max_state; i++)
> -		len += sprintf(buf + len, "%10lu",
> -				devfreq->profile->freq_table[i]);
> +		len += sprintf(buf + len, "%10lu", freq_table[i]);

It is not good touching the 'devfreq->profile' variable
that is not related to 'struct devfreq_stats'.

>  
>  	len += sprintf(buf + len, "   time(ms)\n");
>  
>  	for (i = 0; i < max_state; i++) {
> -		if (devfreq->profile->freq_table[i]
> -					== devfreq->previous_freq) {
> +		if (freq_table[i] == devfreq->previous_freq)

ditto.

>  			len += sprintf(buf + len, "*");
> -		} else {

Don't touch the something if it is not related to 'struct devfreq_stats'

> +		else
>  			len += sprintf(buf + len, " ");
> -		}

ditto.

> -		len += sprintf(buf + len, "%10lu:",
> -				devfreq->profile->freq_table[i]);
> +
> +		len += sprintf(buf + len, "%10lu:", freq_table[i]);

ditto.

>  		for (j = 0; j < max_state; j++)
>  			len += sprintf(buf + len, "%10u",
> -				devfreq->trans_table[(i * max_state) + j]);
> +				stats->trans_table[(i * max_state) + j]);
> +
>  		len += sprintf(buf + len, "%10llu\n", (u64)
> -			jiffies64_to_msecs(devfreq->time_in_state[i]));
> +			jiffies64_to_msecs(stats->time_in_state[i]));
>  	}
>  
>  	len += sprintf(buf + len, "Total transition : %u\n",
> -					devfreq->total_trans);
> +					stats->total_trans);
>  	return len;
>  }
>  
> @@ -1484,6 +1484,7 @@ static ssize_t trans_stat_store(struct device *dev,
>  				const char *buf, size_t count)
>  {
>  	struct devfreq *df = to_devfreq(dev);
> +	struct devfreq_stats *stats = &df->stats;
>  	unsigned int cnt = df->profile->max_state;
>  	int err, value;
>  
> @@ -1495,10 +1496,10 @@ static ssize_t trans_stat_store(struct device *dev,
>  		return count;
>  
>  	mutex_lock(&df->lock);
> -	memset(df->time_in_state, 0, cnt * sizeof(u64));
> -	memset(df->trans_table, 0, cnt * cnt * sizeof(int));
> -	df->last_stat_updated = get_jiffies_64();
> -	df->total_trans = 0;
> +	memset(stats->time_in_state, 0, cnt * sizeof(u64));
> +	memset(stats->trans_table, 0, cnt * cnt * sizeof(int));
> +	stats->last_update = get_jiffies_64();
> +	stats->total_trans = 0;
>  	mutex_unlock(&df->lock);
>  
>  	return count;
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index 41f15e7a22b8..de2fdc56aa5b 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -106,6 +106,20 @@ struct devfreq_dev_profile {
>  	unsigned int max_state;
>  };
>  
> +/**
> + * struct devfreq_stats - Statistics of devfreq device behavior
> + * @total_trans:	Number of devfreq transitions.
> + * @trans_table:	Statistics of devfreq transitions.
> + * @time_in_state:	Statistics of devfreq states.
> + * @last_update:	The last time stats were updated.
> + */
> +struct devfreq_stats {
> +	unsigned int total_trans;
> +	unsigned int *trans_table;
> +	u64 *time_in_state;
> +	u64 last_update;
> +};
> +
>  /**
>   * struct devfreq - Device devfreq structure
>   * @node:	list node - contains the devices with devfreq that have been
> @@ -131,10 +145,7 @@ struct devfreq_dev_profile {
>   * @suspend_freq:	 frequency of a device set during suspend phase.
>   * @resume_freq:	 frequency of a device set in resume phase.
>   * @suspend_count:	 suspend requests counter for a device.
> - * @total_trans:	Number of devfreq transitions
> - * @trans_table:	Statistics of devfreq transitions
> - * @time_in_state:	Statistics of devfreq states
> - * @last_stat_updated:	The last time stat updated
> + * @stats:	Statistics of devfreq device behavior
>   * @transition_notifier_list: list head of DEVFREQ_TRANSITION_NOTIFIER notifier
>   *
>   * This structure stores the devfreq information for a give device.
> @@ -171,11 +182,8 @@ struct devfreq {
>  	unsigned long resume_freq;
>  	atomic_t suspend_count;
>  
> -	/* information for device frequency transition */
> -	unsigned int total_trans;
> -	unsigned int *trans_table;
> -	u64 *time_in_state;
> -	u64 last_stat_updated;
> +	/* information for device frequency transitions */
> +	struct devfreq_stats stats;
>  
>  	struct srcu_notifier_head transition_notifier_list;
>  };
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
