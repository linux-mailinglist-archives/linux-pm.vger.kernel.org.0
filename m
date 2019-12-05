Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70CDE113964
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 02:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfLEBj7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Dec 2019 20:39:59 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:21992 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728321AbfLEBj6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Dec 2019 20:39:58 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191205013954epoutp031ef9453923854bfd7a15bee353172ba9~dVf42UBwd2823428234epoutp03x
        for <linux-pm@vger.kernel.org>; Thu,  5 Dec 2019 01:39:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191205013954epoutp031ef9453923854bfd7a15bee353172ba9~dVf42UBwd2823428234epoutp03x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575509995;
        bh=Oen/BZ4nHuK59SCJ3/7TEzX5BQ5jhiau93R7/9rMCHE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=P6npovJD3GV/0ZpmTG4B8cyowBN1WP2bICMwjOSSEgnpJYAXBjQJOKG0Jn2JCCiha
         BomnjRLkmUWfcjtE5O7MOu2QH8Vn36T55YOuOMwcU5rjgaebp3fudsPb3LQM3ti3lu
         XObLogzezbBfA0YE3AFHB+f9fpBQIB1xP4FG2pz0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191205013954epcas1p2c5fd64539222a380514069461dc4ad63~dVf4gBb1u2158221582epcas1p2i;
        Thu,  5 Dec 2019 01:39:54 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.153]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47Sz143sKMzMqYkj; Thu,  5 Dec
        2019 01:39:52 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        E3.73.48019.3EF58ED5; Thu,  5 Dec 2019 10:39:47 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191205013947epcas1p41f02dd65aadd1586c7c0916877229b87~dVfxsrMSw0802308023epcas1p4j;
        Thu,  5 Dec 2019 01:39:47 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191205013947epsmtrp2528896711cdce69b7c6c124dcfbf67a8~dVfxr9Fsk0448804488epsmtrp2u;
        Thu,  5 Dec 2019 01:39:47 +0000 (GMT)
X-AuditID: b6c32a38-23fff7000001bb93-0a-5de85fe3c5ff
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8F.20.10238.3EF58ED5; Thu,  5 Dec 2019 10:39:47 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191205013947epsmtip19bd04f40d2ca2aab0df997b83b31c1e5~dVfxdUZKt0562305623epsmtip1-;
        Thu,  5 Dec 2019 01:39:47 +0000 (GMT)
Subject: Re: [PATCH v2 3/3] devfreq: move statistics to separate struct
To:     Kamil Konieczny <k.konieczny@samsung.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <0298e7c0-72ea-ad1d-1a69-68bfaf0d62d1@samsung.com>
Date:   Thu, 5 Dec 2019 10:46:01 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20191204150018.5234-4-k.konieczny@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAJsWRmVeSWpSXmKPExsWy7bCmnu7j+BexBr1HNC02zljParHg0wxW
        i/PnN7BbnG16w25xedccNovPvUcYLdYeuctucbtxBZsDh8emVZ1sHn1bVjF6fN4kF8AclW2T
        kZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA3SBkkJZYk4p
        UCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAskCvODG3uDQvXS85P9fK0MDAyBSoMCE74/q+
        f8wF030rFmydzNLAeNO2i5GDQ0LAROLMupouRi4OIYEdjBIv2rcwdjFyAjmfGCXW/XOASHxj
        lFgz8TMbSAKk4cWK7ywQib2MEgdPdrFCOO8ZJR6c72AFqRIWcJd4v6OJHcQWEdCVeLNjKTNI
        EbPAPCaJN9MugBWxCWhJ7H9xA2wsv4CixNUfj8F28wrYSezvmcAMYrMIqEgcm/yOBcQWFQiT
        OLmtBapGUOLkzCdgcU4BG4nTcxeBzWEWEJe49WQ+E4QtL7H97RywxRIC79kkzh65wgTxg4tE
        ++oOFghbWOLV8S3sELaUxOd3e6H+rJZYefIIG0RzB6PElv0QV0sIGEvsXzqZCRR6zAKaEut3
        6UOEFSV2/p7LCLGYT+Ld1x5WSADzSnS0CUGUKEtcfnAX6gRJicXtnWwTGJVmIXlnFpIXZiF5
        YRbCsgWMLKsYxVILinPTU4sNC0yQY3sTIzh1alnsYNxzzucQowAHoxIPb8Om57FCrIllxZW5
        hxglOJiVRHi3STyNFeJNSaysSi3Kjy8qzUktPsRoCgzticxSosn5wLSeVxJvaGpkbGxsYWJo
        ZmpoqCTOy/HjYqyQQHpiSWp2ampBahFMHxMHp1QD48xaz6unW0WXv1714IiumY/OhP+BQi+7
        bwpNstOb+eaos1KeRfeS6qcJVfUaneyCT5ifddy4q/ojXkpiwYOpT6w3G1T/iPqyRKtv5q6M
        p3+SCg5UZJyVvXnY8RK38u/M5B41LhvfOP1lnNvyHrVeurM6IDTkwQmeuqCPO1q8l2dk6Bq4
        zwk+pMRSnJFoqMVcVJwIAMq0bZ2zAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LZdlhJTvdx/ItYg32ruCw2zljParHg0wxW
        i/PnN7BbnG16w25xedccNovPvUcYLdYeuctucbtxBZsDh8emVZ1sHn1bVjF6fN4kF8AcxWWT
        kpqTWZZapG+XwJVxfd8/5oLpvhULtk5maWC8advFyMkhIWAi8WLFd5YuRi4OIYHdjBLPVv1k
        hEhISky7eJS5i5EDyBaWOHy4GKLmLaNE5/LbzCA1wgLuEu93NLGD2CICuhJvdixlBiliFljA
        JDH/5kSoqQcZJS53HGABqWIT0JLY/+IGG4jNL6AocfXHY7BtvAJ2Evt7JoBNZRFQkTg2+R1Y
        vahAmMTOJY+ZIGoEJU7OfAIW5xSwkTg9dxHYHGYBdYk/8y4xQ9jiEreezGeCsOUltr+dwzyB
        UXgWkvZZSFpmIWmZhaRlASPLKkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M4DjS0tzB
        eHlJ/CFGAQ5GJR7ehk3PY4VYE8uKK3MPMUpwMCuJ8G6TeBorxJuSWFmVWpQfX1Sak1p8iFGa
        g0VJnPdp3rFIIYH0xJLU7NTUgtQimCwTB6dUA6Ot5aGW5Y/4Zldcdxd59LXr5FKZzmWH8zRn
        iHq2tVfl+0q+KIw4eWVNYPneEO5eyYKPp391Ps3K/PVsx4s9/CUy+rGRs47Z+wXOevZx9SeN
        GbtkumMnxhow1jvc+D7RceH0g/6NmRlfqgNUPq1fazD3y2luriUaybP/7wnPuvjnZEVv7p6w
        jR+VWIozEg21mIuKEwHjYGbQnwIAAA==
X-CMS-MailID: 20191205013947epcas1p41f02dd65aadd1586c7c0916877229b87
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191204150034eucas1p1b6e7f43a6be59ed2e0a4e55ccdefc750
References: <20191204150018.5234-1-k.konieczny@samsung.com>
        <CGME20191204150034eucas1p1b6e7f43a6be59ed2e0a4e55ccdefc750@eucas1p1.samsung.com>
        <20191204150018.5234-4-k.konieczny@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/5/19 12:00 AM, Kamil Konieczny wrote:
> Count time and transitions between devfreq frequencies in separate struct
> for improved code readability and maintenance.
> 
> Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
> ---
> Changes in v2:
>  squash three patches into one, do not modify devfreq_profile and separate stats
>  into devfreq_stats
> 
>  drivers/devfreq/devfreq.c | 68 +++++++++++++++++++++++----------------
>  include/linux/devfreq.h   | 31 ++++++++++++------
>  2 files changed, 62 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 901af3b66a76..4d50c8f10bd2 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -198,6 +198,7 @@ static int set_freq_table(struct devfreq *devfreq)
>   */
>  int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>  {
> +	struct devfreq_stats *stats = devfreq->stats;
>  	int lev, prev_lev, ret = 0;
>  	unsigned long long cur_time;
>  
> @@ -214,8 +215,8 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>  		goto out;
>  	}
>  
> -	devfreq->time_in_state[prev_lev] +=
> -			 cur_time - devfreq->last_stat_updated;
> +	stats->time_in_state[prev_lev] +=
> +			 cur_time - stats->last_stat_updated;
>  
>  	lev = devfreq_get_freq_level(devfreq, freq);
>  	if (lev < 0) {
> @@ -224,13 +225,12 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>  	}
>  
>  	if (lev != prev_lev) {
> -		devfreq->trans_table[(prev_lev *
> -				devfreq->profile->max_state) + lev]++;
> -		devfreq->total_trans++;
> +		stats->trans_table[(prev_lev * stats->max_state) + lev]++;
> +		stats->total_trans++;
>  	}
>  
>  out:
> -	devfreq->last_stat_updated = cur_time;
> +	stats->last_stat_updated = cur_time;
>  	return ret;
>  }
>  EXPORT_SYMBOL(devfreq_update_status);
> @@ -525,7 +525,7 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
>  			msecs_to_jiffies(devfreq->profile->polling_ms));
>  
>  out_update:
> -	devfreq->last_stat_updated = get_jiffies_64();
> +	devfreq->stats->last_stat_updated = get_jiffies_64();
>  	devfreq->stop_polling = false;
>  
>  	if (devfreq->profile->get_cur_freq &&
> @@ -735,28 +735,38 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  		goto err_out;
>  	}
>  
> -	devfreq->trans_table = devm_kzalloc(&devfreq->dev,
> +	devfreq->stats = devm_kzalloc(&devfreq->dev, sizeof(*devfreq->stats),
> +				      GFP_KERNEL);

Each devfreq has only one stats structure always. Don't need to define
it with pointer type. It is enough to define as following without pointer type:

	struct devfreq_stats stats;


> +	if (!devfreq->stats) {
> +		mutex_unlock(&devfreq->lock);
> +		err = -ENOMEM;
> +		goto err_devfreq;
> +	}
> +
> +	devfreq->stats->freq_table = devfreq->profile->freq_table;
> +	devfreq->stats->max_state = devfreq->profile->max_state;
> +	devfreq->stats->trans_table = devm_kzalloc(&devfreq->dev,
>  			array3_size(sizeof(unsigned int),
> -				    devfreq->profile->max_state,
> -				    devfreq->profile->max_state),
> +				    devfreq->stats->max_state,
> +				    devfreq->stats->max_state),
>  			GFP_KERNEL);
> -	if (!devfreq->trans_table) {
> +	if (!devfreq->stats->trans_table) {
>  		mutex_unlock(&devfreq->lock);
>  		err = -ENOMEM;
>  		goto err_devfreq;
>  	}
>  
> -	devfreq->time_in_state = devm_kcalloc(&devfreq->dev,
> -			devfreq->profile->max_state,
> -			sizeof(*devfreq->time_in_state),
> +	devfreq->stats->time_in_state = devm_kcalloc(&devfreq->dev,
> +			devfreq->stats->max_state,
> +			sizeof(*devfreq->stats->time_in_state),
>  			GFP_KERNEL);

Actually, this patch will be conflict with patch[1].
[1] https://www.spinics.net/lists/arm-kernel/msg768822.html

First of all, I have to merge patches[1][2] for the devfreq pm-qos
during v5.5-rc period. It requires the linux-pm's maintainer.
[2] https://www.spinics.net/lists/arm-kernel/msg769761.html

After finishing the job[1][2], I'll merge this patch
if finished the review of this patch. Just share the possible merge
conflict to you.


> -	if (!devfreq->time_in_state) {
> +	if (!devfreq->stats->time_in_state) {
>  		mutex_unlock(&devfreq->lock);
>  		err = -ENOMEM;
>  		goto err_devfreq;
>  	}
>  
> -	devfreq->last_stat_updated = get_jiffies_64();
> +	devfreq->stats->last_stat_updated = get_jiffies_64();
>  
>  	srcu_init_notifier_head(&devfreq->transition_notifier_list);
>  
> @@ -1435,9 +1445,10 @@ static ssize_t trans_stat_show(struct device *dev,
>  			       struct device_attribute *attr, char *buf)
>  {
>  	struct devfreq *devfreq = to_devfreq(dev);
> +	struct devfreq_stats *stats = devfreq->stats;
> +	unsigned int max_state = stats->max_state;
>  	ssize_t len;
>  	int i, j;
> -	unsigned int max_state = devfreq->profile->max_state;
>  
>  	if (max_state == 0)
>  		return sprintf(buf, "Not Supported.\n");
> @@ -1454,28 +1465,28 @@ static ssize_t trans_stat_show(struct device *dev,
>  	len += sprintf(buf + len, "           :");
>  	for (i = 0; i < max_state; i++)
>  		len += sprintf(buf + len, "%10lu",
> -				devfreq->profile->freq_table[i]);
> +				stats->freq_table[i]);
>  
>  	len += sprintf(buf + len, "   time(ms)\n");
>  
>  	for (i = 0; i < max_state; i++) {
> -		if (devfreq->profile->freq_table[i]
> +		if (stats->freq_table[i]
>  					== devfreq->previous_freq) {
>  			len += sprintf(buf + len, "*");
>  		} else {
>  			len += sprintf(buf + len, " ");
>  		}
>  		len += sprintf(buf + len, "%10lu:",
> -				devfreq->profile->freq_table[i]);
> +				stats->freq_table[i]);
>  		for (j = 0; j < max_state; j++)
>  			len += sprintf(buf + len, "%10u",
> -				devfreq->trans_table[(i * max_state) + j]);
> +				stats->trans_table[(i * max_state) + j]);
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
> @@ -1484,16 +1495,17 @@ static ssize_t trans_stat_store(struct device *dev,
>  				const char *buf, size_t count)
>  {
>  	struct devfreq *df = to_devfreq(dev);
> -	unsigned int cnt = df->profile->max_state;
> +	struct devfreq_stats *stats = df->stats;
> +	unsigned int cnt = stats->max_state;
>  
>  	if (cnt == 0)
>  		return count;
>  
>  	mutex_lock(&df->lock);
> -	memset(df->time_in_state, 0, cnt * sizeof(u64));
> -	memset(df->trans_table, 0, cnt * cnt * sizeof(int));
> -	df->last_stat_updated = get_jiffies_64();
> -	df->total_trans = 0;
> +	memset(stats->time_in_state, 0, cnt * sizeof(u64));
> +	memset(stats->trans_table, 0, cnt * cnt * sizeof(int));
> +	stats->last_stat_updated = get_jiffies_64();
> +	stats->total_trans = 0;
>  	mutex_unlock(&df->lock);
>  
>  	return count;
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index b81a86e47fb9..2715719924e7 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -106,6 +106,25 @@ struct devfreq_dev_profile {
>  	unsigned int max_state;
>  };
>  
> +/**
> + * struct devfreq_stats - Devfreq's transitions stats counters

Devfreq's transitions stats counters -> Statistics of devfreq device behavior

> + * @freq_table:		List of frequencies in ascending order.
> + * @max_state:		The size of freq_table.
> + * @total_trans:	Number of devfreq transitions.
> + * @trans_table:	Statistics of devfreq transitions.
> + * @time_in_state:	Statistics of devfreq states.
> + * @last_stat_updated:	The last time stats were updated.
> + */
> +struct devfreq_stats {
> +	unsigned long *freq_table;
> +	unsigned int max_state;

Acutally, I'm sorry I has not yet completely agreed to move
'freq_table and 'max_state' from struct devfreq to struct devfreq_stats.
It has not any critical benefit and any problem.
So, don't move 'freq_table' and 'max_state'. 

> +
> +	unsigned int total_trans;
> +	unsigned int *trans_table;
> +	u64 *time_in_state;
> +	unsigned long long last_stat_updated;
> +};
> +
>  /**
>   * struct devfreq - Device devfreq structure
>   * @node:	list node - contains the devices with devfreq that have been
> @@ -131,10 +150,7 @@ struct devfreq_dev_profile {
>   * @suspend_freq:	 frequency of a device set during suspend phase.
>   * @resume_freq:	 frequency of a device set in resume phase.
>   * @suspend_count:	 suspend requests counter for a device.
> - * @total_trans:	Number of devfreq transitions
> - * @trans_table:	Statistics of devfreq transitions
> - * @time_in_state:	Statistics of devfreq states
> - * @last_stat_updated:	The last time stat updated
> + * @stats:	Statistics of devfreq transitions and states times

Statistics of devfreq transitions and states times
-> Statistics of devfreq device behavior

>   * @transition_notifier_list: list head of DEVFREQ_TRANSITION_NOTIFIER notifier
>   *
>   * This structure stores the devfreq information for a give device.
> @@ -171,11 +187,8 @@ struct devfreq {
>  	unsigned long resume_freq;
>  	atomic_t suspend_count;
>  
> -	/* information for device frequency transition */
> -	unsigned int total_trans;
> -	unsigned int *trans_table;
> -	u64 *time_in_state;
> -	unsigned long long last_stat_updated;
> +	/* information for device frequency transitions */
> +	struct devfreq_stats *stats;

Each devfreq has only one stats structure always. Don't need to define
it with pointer type. It is enough to define as following without pointer type:

	struct devfreq_stats stats;

>  
>  	struct srcu_notifier_head transition_notifier_list;
>  };
> 




-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
