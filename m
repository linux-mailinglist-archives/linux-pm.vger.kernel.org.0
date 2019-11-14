Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8396FBD9B
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2019 02:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbfKNBqa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 20:46:30 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:63048 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfKNBqa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Nov 2019 20:46:30 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191114014622epoutp039334242407ac5cb77641de7f796d9516~W5Cigpcn_1805518055epoutp03T
        for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2019 01:46:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191114014622epoutp039334242407ac5cb77641de7f796d9516~W5Cigpcn_1805518055epoutp03T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573695982;
        bh=ETZHV/D1P8aQur4fGuxnAaRu9rS7d8NaSd/KyDGj9Ok=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=fOpaukgHgpPOf3HU0uuG+u/yWuOGlpiMRUzip8GXZ8nYUZBe8yfUAvlGe+rrxMhPS
         dQrx3xOON5cC7ZoV6AKf8fpIClfEMnfOXTszQblfh9HrbryvUiFe6/moomWFNWP5Lc
         28f9H2/yDLfFeiiuQFD6VHbqjB21vuwQ+gZ2qpho=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191114014622epcas1p2ebc315e185483cad764014dd6db2384c~W5CiFVpjO2598425984epcas1p2t;
        Thu, 14 Nov 2019 01:46:22 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.153]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47D48D0ClDzMqYkf; Thu, 14 Nov
        2019 01:46:20 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        F6.7E.04085.BE1BCCD5; Thu, 14 Nov 2019 10:46:19 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191114014619epcas1p2786e37229e73ebc896f3e130aa559830~W5CfWY9lY1796017960epcas1p2X;
        Thu, 14 Nov 2019 01:46:19 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191114014619epsmtrp1c85b20e86b14df911c8cbc12577fc424~W5CfVf2LZ0241402414epsmtrp1N;
        Thu, 14 Nov 2019 01:46:19 +0000 (GMT)
X-AuditID: b6c32a37-287189c000000ff5-0d-5dccb1ebc0ca
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4E.02.24756.BE1BCCD5; Thu, 14 Nov 2019 10:46:19 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191114014619epsmtip109eaa2fcdeb0ca6ab6fcb31e1cfdd57f~W5CfFEcWY1137411374epsmtip1r;
        Thu, 14 Nov 2019 01:46:19 +0000 (GMT)
Subject: Re: [PATCH 7/7] devfreq: move statistics to separate struct
To:     Kamil Konieczny <k.konieczny@samsung.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Kamil Konieczny <k.konieczny@partner.samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <4942d2ad-fef7-89be-91c1-c02c319546ff@samsung.com>
Date:   Thu, 14 Nov 2019 10:52:04 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113091336.5218-8-k.konieczny@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0hTURzu7G5312x1Wpm//KPmjSAFdde5vIpGkckqA6mICGTd9KLiXtw7
        oweUVpr2tIyyYQ8oyaSaLit7uVLBrC1728uIJr1TKiyjsrbdRf73/b7z/c53vt85hyLUrWQU
        VWix84KFM9HkaPn59piEuA9Nnhxtb28a21TjVLC7Wv8g9uiXGgW72/eBYLu7G5Wsd9NHJevy
        PVKw9y/VkuzXnR2IrelulbGnO3qV7LPSenL2GIOroZI0nD2+0XC9/4rMsKu5ARm+uqZkK1YU
        pRXwXB4vaHhLrjWv0JKfTi9cYpxr1M/UMnFMCptMayycmU+nM7Ky4zILTf7j0ZrVnKnYT2Vz
        okgnzEoTrMV2XlNgFe3pNG/LM9lSbPEiZxaLLfnxuVZzKqPVJur9wpVFBfd8TqWt04HWlHgf
        yEtQ3/ptKIwCnAQ39lYT29BoSo1bEPw+VauQii8I+n+8kUnFNwQ3Nntl/1q8l5uRtHAVgafM
        GSoGEPTUVxIB1QScAZ69m8gAnojj4GNLXdCEwG4Cyi/fDW5F4lhwv30cFI3D0fBwyIcCWIVn
        wf7Dd4IbyfF0aO90+XmKisDL4dYgJ0nGQ9fBPnmADsNp0PJiQYAmcCQ87Tsik/BUuPCpNmgL
        +IASjnzvUEgJMmBoX5NSwhPgfWdzCEfBu93lIbweTnZ1kFJzBYJm951Qsw7cddWygDGBY8B5
        KUGio+Hiz0NIMh4L/YM7FAEJYBVUlKslyTS4/7I3NMTJcGxrJVmFaMeINI4RERwjIjj+mx1F
        8gY0ibeJ5nxeZGy6kdftQsG3G5vcghpvZ7UhTCF6jOpahCdHreBWi2vNbQgogp6ommHxU6o8
        bu06XrAahWITL7YhvX/We4ioiFyr/ydY7EZGn6jT6dgkZqaeYehI1ZwTdTlqnM/Z+SKet/HC
        vz4ZFRZVgmyZzh5jeE/3Iv30qqGKmKyhzouDOQs9y/peCMLw3SdsdVL1KK1vAbehrn4cu2Nx
        ZknK9ugiNCo3MWK7M3ZJ+Xw3tS9R8L5+BBvPnPM914qlv7rid9bcfDw8b8uvSfLkhJeRt3ra
        qwYbMwbuvX1lWHpm7qoNZZg4kDoQfjq8X5P0mZaLBRwTSwgi9xfRneBi0QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsWy7bCSnO7rjWdiDU69lLTYOGM9q0Xfvv+M
        Fgs+zWC16H/8mtni/PkN7BZnm96wW2x6fI3V4vKuOWwWn3uPMFrMOL+PyWLtkbvsFrcbV7A5
        8HhsWtXJ5rF5Sb3HwXd7mDz6tqxi9Pi8SS6ANYrLJiU1J7MstUjfLoEr49Lj9ewFx2cxVjSc
        vcLSwPikuouRk0NCwETi7O4tjF2MXBxCArsZJZp3rmWFSEhKTLt4lLmLkQPIFpY4fLgYouYt
        o0TP7kMsIDXCAi4SZyY1sYHYIgK6Em92LGUGKWIWOMgscW/9I6ipBxklNt5aBDaVTUBLYv+L
        G2Ad/AKKEld/PGYEsXkF7CSmzbvADGKzCKhKHD6+CSwuKhAh8Xz7DagaQYmTM5+wgFzEKWAj
        seOeF0iYWUBd4s+8S8wQtrjErSfzmSBseYntb+cwT2AUnoWkexaSlllIWmYhaVnAyLKKUTK1
        oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM4ArU0dzBeXhJ/iFGAg1GJh/eA6JlYIdbEsuLK
        3EOMEhzMSiK8GnlAId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxP845FCgmkJ5akZqemFqQWwWSZ
        ODilGhiduB3W1GY9UZwyaaPDHJ7/E9U5mcIL75aVRK+cG3x2CR9jxOyZeVETnlpIvbhyMSLb
        923WhURzl59pvhFRLiFC+ddMftlYXzi9IKu79RSL1o5bOv2ZMmpn8qcuOb7fd5LKdq2PLA/k
        D2ueP/Pz+blVmmouwnufCksoa6VIrHusrRA6ud/plKISS3FGoqEWc1FxIgA7AEMZvAIAAA==
X-CMS-MailID: 20191114014619epcas1p2786e37229e73ebc896f3e130aa559830
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191113091354eucas1p265de4985d167814f5080fbdf21b75a0a
References: <20191113091336.5218-1-k.konieczny@samsung.com>
        <CGME20191113091354eucas1p265de4985d167814f5080fbdf21b75a0a@eucas1p2.samsung.com>
        <20191113091336.5218-8-k.konieczny@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Kamil,

The 'freq_table' and 'max_state' in the devfreq_dev_profile
were used in the ARM Mali device driver[1][2][3]. Although ARM Mali
device driver was posted to mainline kernel, they used
them for a long time. It means that this patch break
the compatibility. The ARM Mali drivers are very
important devfreq device driver. 

[1] https://developer.arm.com/tools-and-software/graphics-and-gaming/mali-drivers/bifrost-kernel#
[2] https://developer.arm.com/tools-and-software/graphics-and-gaming/mali-drivers/midgard-kernel
[3] https://developer.arm.com/tools-and-software/graphics-and-gaming/mali-drivers/utgard-kernel

Also, the devfreq device driver specifies their own
information and data into devfreq_dev_profile structure 
before registering the devfreq device with devfreq_add_device().
This patch breaks the basic usage rule of devfreq_dev_profile structure.

So, I can't agree this patch. Not ack.

Regards,
Chanwoo Choi

On 11/13/19 6:13 PM, Kamil Konieczny wrote:
> Count time and transitions between devfreq frequencies in separate struct
> for improved code readability and maintenance.
> 
> Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
> ---
>  drivers/devfreq/devfreq.c          | 156 ++++++++++++++++-------------
>  drivers/devfreq/exynos-bus.c       |   6 +-
>  drivers/devfreq/governor_passive.c |  26 +++--
>  include/linux/devfreq.h            |  43 ++++----
>  4 files changed, 129 insertions(+), 102 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index d79412b0de59..d85867a91230 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -105,10 +105,11 @@ static unsigned long find_available_max_freq(struct devfreq *devfreq)
>   */
>  static int devfreq_get_freq_level(struct devfreq *devfreq, unsigned long freq)
>  {
> +	struct devfreq_stats *stats = devfreq->profile->stats;
>  	int lev;
>  
> -	for (lev = 0; lev < devfreq->profile->max_state; lev++)
> -		if (freq == devfreq->profile->freq_table[lev])
> +	for (lev = 0; lev < stats->max_state; lev++)
> +		if (freq == stats->freq_table[lev])
>  			return lev;
>  
>  	return -EINVAL;
> @@ -117,56 +118,64 @@ static int devfreq_get_freq_level(struct devfreq *devfreq, unsigned long freq)
>  static int set_freq_table(struct devfreq *devfreq)
>  {
>  	struct devfreq_dev_profile *profile = devfreq->profile;
> +	struct devfreq_stats *stats;
>  	struct dev_pm_opp *opp;
>  	unsigned long freq;
> -	int i, count;
> +	int i, count, err = -ENOMEM;
>  
>  	/* Initialize the freq_table from OPP table */
>  	count = dev_pm_opp_get_opp_count(devfreq->dev.parent);
>  	if (count <= 0)
>  		return -EINVAL;
>  
> -	profile->max_state = count;
> -	profile->freq_table = devm_kcalloc(devfreq->dev.parent,
> -					count,
> -					sizeof(*profile->freq_table),
> -					GFP_KERNEL);
> -	if (!profile->freq_table) {
> -		profile->max_state = 0;
> +	stats = devm_kzalloc(devfreq->dev.parent,
> +			     sizeof(struct devfreq_stats), GFP_KERNEL);
> +	if (!stats)
>  		return -ENOMEM;
> -	}
>  
> -	for (i = 0, freq = 0; i < profile->max_state; i++, freq++) {
> +	profile->stats = stats;
> +	stats->max_state = count;
> +	stats->freq_table = devm_kcalloc(devfreq->dev.parent,
> +					 count,
> +					 sizeof(*stats->freq_table),
> +					 GFP_KERNEL);
> +	if (!stats->freq_table)
> +		goto err_no_mem;
> +
> +	for (i = 0, freq = 0; i < count; i++, freq++) {
>  		opp = dev_pm_opp_find_freq_ceil(devfreq->dev.parent, &freq);
>  		if (IS_ERR(opp)) {
> -			devm_kfree(devfreq->dev.parent, profile->freq_table);
> -			profile->max_state = 0;
> -			return PTR_ERR(opp);
> +			devm_kfree(devfreq->dev.parent, stats->freq_table);
> +			stats->max_state = 0;
> +			err = PTR_ERR(opp);
> +			goto err_no_mem;
>  		}
>  		dev_pm_opp_put(opp);
> -		profile->freq_table[i] = freq;
> +		stats->freq_table[i] = freq;
>  	}
>  
> -	profile->trans_table = devm_kzalloc(devfreq->dev.parent,
> -					    array3_size(sizeof(unsigned int),
> -							count, count),
> -					    GFP_KERNEL);
> -	if (!profile->trans_table)
> +	stats->trans_table = devm_kzalloc(devfreq->dev.parent,
> +					  array3_size(sizeof(unsigned int),
> +						      count, count),
> +					  GFP_KERNEL);
> +	if (!stats->trans_table)
>  		goto err_no_mem;
>  
> -	profile->time_in_state = devm_kcalloc(devfreq->dev.parent, count,
> -					      sizeof(*profile->time_in_state),
> -					      GFP_KERNEL);
> -	if (!profile->time_in_state)
> +	stats->time_in_state = devm_kcalloc(devfreq->dev.parent, count,
> +					    sizeof(*stats->time_in_state),
> +					    GFP_KERNEL);
> +	if (!stats->time_in_state)
>  		goto err_no_mem;
>  
> -	profile->last_time = get_jiffies_64();
> -	spin_lock_init(&profile->stats_lock);
> +	stats->last_time = get_jiffies_64();
> +	spin_lock_init(&stats->stats_lock);
>  
>  	return 0;
>  err_no_mem:
> -	profile->max_state = 0;
> -	return -ENOMEM;
> +	stats->max_state = 0;
> +	devm_kfree(devfreq->dev.parent, profile->stats);
> +	profile->stats = NULL;
> +	return err;
>  }
>  
>  /**
> @@ -176,7 +185,7 @@ static int set_freq_table(struct devfreq *devfreq)
>   */
>  int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>  {
> -	struct devfreq_dev_profile *profile = devfreq->profile;
> +	struct devfreq_stats *stats = devfreq->profile->stats;
>  	unsigned long long cur_time;
>  	int lev, prev_lev, ret = 0;
>  
> @@ -184,22 +193,21 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>  
>  	/* Immediately exit if previous_freq is not initialized yet. */
>  	if (!devfreq->previous_freq) {
> -		spin_lock(&profile->stats_lock);
> -		profile->last_time = cur_time;
> -		spin_unlock(&profile->stats_lock);
> +		spin_lock(&stats->stats_lock);
> +		stats->last_time = cur_time;
> +		spin_unlock(&stats->stats_lock);
>  		return 0;
>  	}
>  
>  	prev_lev = devfreq_get_freq_level(devfreq, devfreq->previous_freq);
>  
> -	spin_lock(&profile->stats_lock);
> +	spin_lock(&stats->stats_lock);
>  	if (prev_lev < 0) {
>  		ret = prev_lev;
>  		goto out;
>  	}
>  
> -	profile->time_in_state[prev_lev] +=
> -			 cur_time - profile->last_time;
> +	stats->time_in_state[prev_lev] += cur_time - stats->last_time;
>  	lev = devfreq_get_freq_level(devfreq, freq);
>  	if (lev < 0) {
>  		ret = lev;
> @@ -207,14 +215,14 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>  	}
>  
>  	if (lev != prev_lev) {
> -		profile->trans_table[(prev_lev *
> -				profile->max_state) + lev]++;
> -		profile->total_trans++;
> +		stats->trans_table[(prev_lev *
> +				stats->max_state) + lev]++;
> +		stats->total_trans++;
>  	}
>  
>  out:
> -	profile->last_time = cur_time;
> -	spin_unlock(&profile->stats_lock);
> +	stats->last_time = cur_time;
> +	spin_unlock(&stats->stats_lock);
>  	return ret;
>  }
>  EXPORT_SYMBOL(devfreq_update_status);
> @@ -504,9 +512,9 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
>  		queue_delayed_work(devfreq_wq, &devfreq->work,
>  			msecs_to_jiffies(profile->polling_ms));
>  
> -	spin_lock(&profile->stats_lock);
> -	profile->last_time = get_jiffies_64();
> -	spin_unlock(&profile->stats_lock);
> +	spin_lock(&profile->stats->stats_lock);
> +	profile->stats->last_time = get_jiffies_64();
> +	spin_unlock(&profile->stats->stats_lock);
>  	devfreq->stop_polling = false;
>  
>  	if (profile->get_cur_freq &&
> @@ -677,7 +685,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	devfreq->data = data;
>  	devfreq->nb.notifier_call = devfreq_notifier_call;
>  
> -	if (!profile->max_state && !profile->freq_table) {
> +	if (!profile->stats) {
>  		mutex_unlock(&devfreq->lock);
>  		err = set_freq_table(devfreq);
>  		if (err < 0)
> @@ -1282,6 +1290,7 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
>  			      const char *buf, size_t count)
>  {
>  	struct devfreq *df = to_devfreq(dev);
> +	struct devfreq_stats *stats = df->profile->stats;
>  	unsigned long value;
>  	int ret;
>  
> @@ -1297,13 +1306,13 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
>  			goto unlock;
>  		}
>  	} else {
> -		unsigned long *freq_table = df->profile->freq_table;
> +		unsigned long *freq_table = stats->freq_table;
>  
>  		/* Get minimum frequency according to sorting order */
> -		if (freq_table[0] < freq_table[df->profile->max_state - 1])
> +		if (freq_table[0] < freq_table[stats->max_state - 1])
>  			value = freq_table[0];
>  		else
> -			value = freq_table[df->profile->max_state - 1];
> +			value = freq_table[stats->max_state - 1];
>  	}
>  
>  	df->min_freq = value;
> @@ -1326,6 +1335,7 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
>  			      const char *buf, size_t count)
>  {
>  	struct devfreq *df = to_devfreq(dev);
> +	struct devfreq_stats *stats = df->profile->stats;
>  	unsigned long value;
>  	int ret;
>  
> @@ -1341,11 +1351,11 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
>  			goto unlock;
>  		}
>  	} else {
> -		unsigned long *freq_table = df->profile->freq_table;
> +		unsigned long *freq_table = stats->freq_table;
>  
>  		/* Get maximum frequency according to sorting order */
> -		if (freq_table[0] < freq_table[df->profile->max_state - 1])
> -			value = freq_table[df->profile->max_state - 1];
> +		if (freq_table[0] < freq_table[stats->max_state - 1])
> +			value = freq_table[stats->max_state - 1];
>  		else
>  			value = freq_table[0];
>  	}
> @@ -1373,14 +1383,15 @@ static ssize_t available_frequencies_show(struct device *d,
>  					  char *buf)
>  {
>  	struct devfreq *df = to_devfreq(d);
> +	struct devfreq_stats *stats = df->profile->stats;
>  	ssize_t count = 0;
>  	int i;
>  
>  	mutex_lock(&df->lock);
>  
> -	for (i = 0; i < df->profile->max_state; i++)
> +	for (i = 0; i < stats->max_state; i++)
>  		count += scnprintf(&buf[count], (PAGE_SIZE - count - 2),
> -				"%lu ", df->profile->freq_table[i]);
> +				"%lu ", stats->freq_table[i]);
>  
>  	mutex_unlock(&df->lock);
>  	/* Truncate the trailing space */
> @@ -1398,9 +1409,10 @@ static ssize_t trans_stat_show(struct device *dev,
>  {
>  	struct devfreq *devfreq = to_devfreq(dev);
>  	struct devfreq_dev_profile *profile = devfreq->profile;
> +	struct devfreq_stats *stats = profile->stats;
> +	unsigned int max_state = stats->max_state;
>  	ssize_t len;
>  	int i, j;
> -	unsigned int max_state = profile->max_state;
>  
>  	if (!devfreq->stop_polling &&
>  			devfreq_update_status(devfreq, devfreq->previous_freq))
> @@ -1411,45 +1423,45 @@ static ssize_t trans_stat_show(struct device *dev,
>  	len = sprintf(buf, "     From  :   To\n");
>  	len += sprintf(buf + len, "           :");
>  
> -	spin_lock(&profile->stats_lock);
> +	spin_lock(&stats->stats_lock);
>  	for (i = 0; i < max_state; i++)
>  		len += sprintf(buf + len, "%10lu",
> -				profile->freq_table[i]);
> +				stats->freq_table[i]);
>  
>  	len += sprintf(buf + len, "   time(ms)\n");
>  
>  	for (i = 0; i < max_state; i++) {
> -		if (profile->freq_table[i] == devfreq->previous_freq)
> +		if (stats->freq_table[i] == devfreq->previous_freq)
>  			len += sprintf(buf + len, "*");
>  		else
>  			len += sprintf(buf + len, " ");
>  
>  		len += sprintf(buf + len, "%10lu:",
> -				profile->freq_table[i]);
> +				stats->freq_table[i]);
>  		for (j = 0; j < max_state; j++)
>  			len += sprintf(buf + len, "%10u",
> -				profile->trans_table[(i * max_state) + j]);
> +				stats->trans_table[(i * max_state) + j]);
>  		len += sprintf(buf + len, "%10llu\n", (u64)
> -			jiffies64_to_msecs(profile->time_in_state[i]));
> +			jiffies64_to_msecs(stats->time_in_state[i]));
>  	}
>  
>  	len += sprintf(buf + len, "Total transition : %u\n",
> -					profile->total_trans);
> -	spin_unlock(&profile->stats_lock);
> +					stats->total_trans);
> +	spin_unlock(&stats->stats_lock);
>  	return len;
>  }
>  static DEVICE_ATTR_RO(trans_stat);
>  
> -static void defvreq_stats_clear_table(struct devfreq_dev_profile *profile)
> +static void defvreq_stats_clear_table(struct devfreq_stats *stats)
>  {
> -	unsigned int count = profile->max_state;
> -
> -	spin_lock(&profile->stats_lock);
> -	memset(profile->time_in_state, 0, count * sizeof(u64));
> -	memset(profile->trans_table, 0, count * count * sizeof(int));
> -	profile->last_time = get_jiffies_64();
> -	profile->total_trans = 0;
> -	spin_unlock(&profile->stats_lock);
> +	unsigned int count = stats->max_state;
> +
> +	spin_lock(&stats->stats_lock);
> +	memset(stats->time_in_state, 0, count * sizeof(u64));
> +	memset(stats->trans_table, 0, count * count * sizeof(int));
> +	stats->last_time = get_jiffies_64();
> +	stats->total_trans = 0;
> +	spin_unlock(&stats->stats_lock);
>  }
>  
>  static ssize_t trans_reset_store(struct device *dev,
> @@ -1459,7 +1471,7 @@ static ssize_t trans_reset_store(struct device *dev,
>  {
>  	struct devfreq *devfreq = to_devfreq(dev);
>  
> -	defvreq_stats_clear_table(devfreq->profile);
> +	defvreq_stats_clear_table(devfreq->profile->stats);
>  
>  	return count;
>  }
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index d9f377912c10..b212aae2bb3e 100644
> --- a/drivers/devfreq/exynos-bus.c
> +++ b/drivers/devfreq/exynos-bus.c
> @@ -496,9 +496,9 @@ static int exynos_bus_probe(struct platform_device *pdev)
>  	}
>  
>  out:
> -	max_state = bus->devfreq->profile->max_state;
> -	min_freq = (bus->devfreq->profile->freq_table[0] / 1000);
> -	max_freq = (bus->devfreq->profile->freq_table[max_state - 1] / 1000);
> +	max_state = profile->stats->max_state;
> +	min_freq = (profile->stats->freq_table[0] / 1000);
> +	max_freq = (profile->stats->freq_table[max_state - 1] / 1000);
>  	pr_info("exynos-bus: new bus device registered: %s (%6ld KHz ~ %6ld KHz)\n",
>  			dev_name(dev), min_freq, max_freq);
>  
> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
> index 58308948b863..b2d87a88335c 100644
> --- a/drivers/devfreq/governor_passive.c
> +++ b/drivers/devfreq/governor_passive.c
> @@ -18,6 +18,8 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>  	struct devfreq_passive_data *p_data
>  			= (struct devfreq_passive_data *)devfreq->data;
>  	struct devfreq *parent_devfreq = (struct devfreq *)p_data->parent;
> +	struct devfreq_stats *parent_stats = parent_devfreq->profile->stats;
> +	struct devfreq_stats *stats;
>  	unsigned long child_freq = ULONG_MAX;
>  	struct dev_pm_opp *opp;
>  	int i, count, ret = 0;
> @@ -47,10 +49,14 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>  	 * device. And then the index is used for getting the suitable
>  	 * new frequency for passive devfreq device.
>  	 */
> -	if (!devfreq->profile || !devfreq->profile->freq_table
> -		|| devfreq->profile->max_state <= 0)
> +	if (!devfreq->profile || !devfreq->profile->stats ||
> +	    devfreq->profile->stats->max_state <= 0 ||
> +	    !parent_devfreq->profile ||	!parent_devfreq->profile->stats ||
> +	    parent_devfreq->profile->stats->max_state <= 0)
>  		return -EINVAL;
>  
> +	stats = devfreq->profile->stats;
> +	parent_stats = parent_devfreq->profile->stats;
>  	/*
>  	 * The passive governor have to get the correct frequency from OPP
>  	 * list of parent device. Because in this case, *freq is temporary
> @@ -68,21 +74,21 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>  	 * Get the OPP table's index of decided freqeuncy by governor
>  	 * of parent device.
>  	 */
> -	for (i = 0; i < parent_devfreq->profile->max_state; i++)
> -		if (parent_devfreq->profile->freq_table[i] == *freq)
> +	for (i = 0; i < parent_stats->max_state; i++)
> +		if (parent_stats->freq_table[i] == *freq)
>  			break;
>  
> -	if (i == parent_devfreq->profile->max_state) {
> +	if (i == parent_stats->max_state) {
>  		ret = -EINVAL;
>  		goto out;
>  	}
>  
>  	/* Get the suitable frequency by using index of parent device. */
> -	if (i < devfreq->profile->max_state) {
> -		child_freq = devfreq->profile->freq_table[i];
> +	if (i < stats->max_state) {
> +		child_freq = stats->freq_table[i];
>  	} else {
> -		count = devfreq->profile->max_state;
> -		child_freq = devfreq->profile->freq_table[count - 1];
> +		count = stats->max_state;
> +		child_freq = stats->freq_table[count - 1];
>  	}
>  
>  	/* Return the suitable frequency for passive device. */
> @@ -109,7 +115,7 @@ static int update_devfreq_passive(struct devfreq *devfreq, unsigned long freq)
>  	if (ret < 0)
>  		goto out;
>  
> -	if (devfreq->profile->freq_table
> +	if (devfreq->profile->stats
>  		&& (devfreq_update_status(devfreq, freq)))
>  		dev_err(&devfreq->dev,
>  			"Couldn't update frequency transition information.\n");
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index 4ceb2a517a9c..8459af1a1583 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -64,6 +64,30 @@ struct devfreq_dev_status {
>   */
>  #define DEVFREQ_FLAG_LEAST_UPPER_BOUND		0x1
>  
> +/**
> + * struct devfreq_stats - Devfreq's transitions stats counters
> + * @freq_table:		Optional list of frequencies to support statistics
> + *			and freq_table must be generated in ascending order.
> + * @max_state:		The size of freq_table.
> + * @total_trans:	Number of devfreq transitions
> + * @trans_table:	Statistics of devfreq transitions
> + * @time_in_state:	Statistics of devfreq states
> + * @last_time:		The last time stats were updated
> + * @stats_lock:		Lock protecting trans_table, time_in_state,
> + *			last_time and total_trans used for statistics
> + */
> +struct devfreq_stats {
> +	unsigned long *freq_table;
> +	unsigned int max_state;
> +
> +	/* information for device frequency transition */
> +	unsigned int total_trans;
> +	unsigned int *trans_table;
> +	u64 *time_in_state;
> +	unsigned long long last_time;
> +	spinlock_t stats_lock;
> +};
> +
>  /**
>   * struct devfreq_dev_profile - Devfreq's user device profile
>   * @initial_freq:	The operating frequency when devfreq_add_device() is
> @@ -88,15 +112,7 @@ struct devfreq_dev_status {
>   *			from devfreq_remove_device() call. If the user
>   *			has registered devfreq->nb at a notifier-head,
>   *			this is the time to unregister it.
> - * @freq_table:		Optional list of frequencies to support statistics
> - *			and freq_table must be generated in ascending order.
> - * @max_state:		The size of freq_table.
> - * @total_trans:	Number of devfreq transitions
> - * @trans_table:	Statistics of devfreq transitions
> - * @time_in_state:	Statistics of devfreq states
> - * @last_time:		The last time stats were updated
> - * @stats_lock:		Lock protecting trans_table, time_in_state,
> - *			last_time and total_trans used for statistics
> + * @stats:		Statistics of devfreq states and state transitions
>   */
>  struct devfreq_dev_profile {
>  	unsigned long initial_freq;
> @@ -108,14 +124,7 @@ struct devfreq_dev_profile {
>  	int (*get_cur_freq)(struct device *dev, unsigned long *freq);
>  	void (*exit)(struct device *dev);
>  
> -	unsigned long *freq_table;
> -	unsigned int max_state;
> -	/* information for device frequency transition */
> -	unsigned int total_trans;
> -	unsigned int *trans_table;
> -	u64 *time_in_state;
> -	unsigned long long last_time;
> -	spinlock_t stats_lock;
> +	struct devfreq_stats *stats;
>  };
>  
>  /**
> 
