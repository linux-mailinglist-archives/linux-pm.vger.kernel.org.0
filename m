Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90DB5FBDBF
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2019 02:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfKNB5M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 20:57:12 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:53062 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfKNB5M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Nov 2019 20:57:12 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191114015708epoutp04379f368ae6c2256040764c9f69c4a009~W5L7s8k9O1876718767epoutp046
        for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2019 01:57:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191114015708epoutp04379f368ae6c2256040764c9f69c4a009~W5L7s8k9O1876718767epoutp046
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573696628;
        bh=+p2bWoVto7KhkPJxdL4vv44kLGOYKuDdFh7byFPtH1U=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=SOAeCywnnWtaUMASHXqTvVp4VapHRrNtaNZZ77cTIVqAT05qF+scmai53eOA2M+1Y
         TEuCkVjEvu3mfkvIrdYh7ALa6+w1iPHnWzYZCWZJ3BnpTsO3OWtQ/LtoNudxqRI0BB
         bKu11oqDXjF66E3sxUXSqossgEjamAdnzN9lI6Q0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191114015708epcas1p41003b0952a12dbe55bd04f90f8d34476~W5L7XBRq31425214252epcas1p4R;
        Thu, 14 Nov 2019 01:57:08 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.152]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47D4Nc1532zMqYkq; Thu, 14 Nov
        2019 01:57:04 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        A3.89.04068.074BCCD5; Thu, 14 Nov 2019 10:57:04 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191114015703epcas1p2e8c4eed763fae8754d9aa8a2740226fc~W5L3GpLKZ1143411434epcas1p2Z;
        Thu, 14 Nov 2019 01:57:03 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191114015703epsmtrp296dd0952c00d809498cfc6ea9b7813e5~W5L3FzCij0198901989epsmtrp2n;
        Thu, 14 Nov 2019 01:57:03 +0000 (GMT)
X-AuditID: b6c32a39-f5fff70000000fe4-05-5dccb4708d98
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3F.60.25663.F64BCCD5; Thu, 14 Nov 2019 10:57:03 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191114015703epsmtip113bb9be563050f71cb2ffcfa63e238ce~W5L21TObb1818918189epsmtip1R;
        Thu, 14 Nov 2019 01:57:03 +0000 (GMT)
Subject: Re: [PATCH 5/7] devfreq: move transition statistics to devfreq
 profile structure
To:     Kamil Konieczny <k.konieczny@samsung.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Kamil Konieczny <k.konieczny@partner.samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <72e517d9-725d-b05d-028f-153bb6684df3@samsung.com>
Date:   Thu, 14 Nov 2019 11:02:48 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113091336.5218-6-k.konieczny@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFJsWRmVeSWpSXmKPExsWy7bCmvm7BljOxBpPusFtsnLGe1aJv339G
        iwWfZrBanD+/gd3ibNMbdovLu+awWXzuPcJosfbIXXaL240r2Bw4PTat6mTzOPhuD5NH35ZV
        jB6fN8kFsERl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6
        ZeYA3aKkUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKbAs0CtOzC0uzUvXS87PtTI0
        MDAyBSpMyM7Y3NvCVtAUVzF11y/mBsaT3l2MnBwSAiYSW19NY+li5OIQEtjBKHF54182COcT
        o8TOl83MEM43Rokfvx+wwbSca70OldjLKLHox2QmCOc9UP/Bv4wgVcIC0RLPt31nB7FFBHQl
        3uxYCtbBLHCZSeLa5rNgCTYBLYn9L26AjeUXUJS4+uMxWDOvgJ3EpHcHwGpYBFQlTp+aAFTD
        wSEqECFx+msiRImgxMmZT1hAbE4BG4nmF5PAxjALiEvcejKfCcKWl9j+dg4zxNWf2SSW9dtC
        2C4Sk/eth4oLS7w6voUdwpaS+PxuL9SX1RIrTx4Bh4WEQAejxJb9F1ghEsYS+5eCfMwBtEBT
        Yv0ufYiwosTO33MZIfbySbz72sMKUiIhwCvR0SYEUaIscfnBXSYIW1JicXsn2wRGpVlIvpmF
        5INZSD6YhbBsASPLKkax1ILi3PTUYsMCU+TY3sQITqdaljsYj53zOcQowMGoxMN7QPRMrBBr
        YllxZe4hRgkOZiURXo08oBBvSmJlVWpRfnxRaU5q8SFGU2BYT2SWEk3OB6b6vJJ4Q1MjY2Nj
        CxNDM1NDQyVxXsflS2OFBNITS1KzU1MLUotg+pg4OKUaGKu09cVu56o93ll+qLqXdWmrz9PX
        OzkSD/4+srnYUsVGzWTatK17fQ8LiUcIvH2fo2FtUfmxepeJzZKFUexxnAErmEzabbc58xjY
        H+p/fODd57cZAuWFp5e4Gxf41jjelyq7qylty3fH4bRCTqKbxssHPzgier4Y//nVtTtKaflq
        OdYLYmpTlViKMxINtZiLihMBsQUPHb0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsWy7bCSnG7+ljOxBk2PJSw2zljPatG37z+j
        xYJPM1gtzp/fwG5xtukNu8XlXXPYLD73HmG0WHvkLrvF7cYVbA6cHptWdbJ5HHy3h8mjb8sq
        Ro/Pm+QCWKK4bFJSczLLUov07RK4Mjb3trAVNMVVTN31i7mB8aR3FyMnh4SAicS51uvMXYxc
        HEICuxkl5v+bywKRkJSYdvEoUIIDyBaWOHy4GCQsJPCWUeLzCQ0QW1ggWuL5tu/sILaIgK7E
        mx1LmUFsZoGrTBI7TjtBzDzIKPFzzk2wBJuAlsT+FzfYQGx+AUWJqz8eM4LYvAJ2EpPeHQAb
        xCKgKnH61ASwGlGBCInn229A1QhKnJz5BOw2TgEbieYXk9gglqlL/Jl3CWqxuMStJ/OZIGx5
        ie1v5zBPYBSehaR9FpKWWUhaZiFpWcDIsopRMrWgODc9t9iwwCgvtVyvODG3uDQvXS85P3cT
        IziutLR2MJ44EX+IUYCDUYmHV0LiTKwQa2JZcWXuIUYJDmYlEV6NPKAQb0piZVVqUX58UWlO
        avEhRmkOFiVxXvn8Y5FCAumJJanZqakFqUUwWSYOTqkGxuU37FacP8AnJKAntaA+7keaz1zB
        TKPvASdOnXpg6WfQcF328Y4jwcwJnd8/fjYxnhho0zxH3F49e36n2LGzFXl3my14F99Vq56X
        L5/Bpmg631PzHWtY7/qc8COKlYZ+xpF3tzS8ZTv5R3xHDPvRlIU5qlecA199n2zjrSAhueTA
        4e91QmEHlViKMxINtZiLihMB0Aut46cCAAA=
X-CMS-MailID: 20191114015703epcas1p2e8c4eed763fae8754d9aa8a2740226fc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191113091353eucas1p283be3173c7a9ea726b4767f9cb113f0f
References: <20191113091336.5218-1-k.konieczny@samsung.com>
        <CGME20191113091353eucas1p283be3173c7a9ea726b4767f9cb113f0f@eucas1p2.samsung.com>
        <20191113091336.5218-6-k.konieczny@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Kamil,

The devfreq_dev_profile structure have to only contain the each devfreq device
callback function/data which are used in the devfreq core.

The generated information after registered the devfreq device
with devfreq_add_device() should be stored in the 'struct device'.

The devfreq core need to split out the data between user input
data (struct devfreq_dev_profile) and the initialized/generated data
by core (struct devfreq). It is not same with cpufreq. cpufreq
don't require the any structure like 'devfreq_dev_profile'.

So, I can't agree.

Thanks.
Chanwoo Choi


On 11/13/19 6:13 PM, Kamil Konieczny wrote:
> Move transition statistics to devfreq profile structure. This is for
> preparation for moving transition statistics into separate struct.
> It is safe to do as frequency table and maximum state information are
> already present in devfreq profile structure and there are no devfreq
> drivers using more than one instance of devfreq structure per devfreq
> profile one.
> 
> It also makes devfreq code more similar to cpufreq one.
> 
> Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 115 +++++++++++++++++++-------------------
>  include/linux/devfreq.h   |  25 ++++-----
>  2 files changed, 70 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 6e5a17f4c92c..70533b787744 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -128,7 +128,7 @@ static int set_freq_table(struct devfreq *devfreq)
>  
>  	profile->max_state = count;
>  	profile->freq_table = devm_kcalloc(devfreq->dev.parent,
> -					profile->max_state,
> +					count,
>  					sizeof(*profile->freq_table),
>  					GFP_KERNEL);
>  	if (!profile->freq_table) {
> @@ -157,29 +157,30 @@ static int set_freq_table(struct devfreq *devfreq)
>   */
>  int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>  {
> -	int lev, prev_lev, ret = 0;
> +	struct devfreq_dev_profile *profile = devfreq->profile;
>  	unsigned long long cur_time;
> +	int lev, prev_lev, ret = 0;
>  
>  	cur_time = get_jiffies_64();
>  
>  	/* Immediately exit if previous_freq is not initialized yet. */
>  	if (!devfreq->previous_freq) {
> -		spin_lock(&devfreq->stats_lock);
> -		devfreq->last_time = cur_time;
> -		spin_unlock(&devfreq->stats_lock);
> +		spin_lock(&profile->stats_lock);
> +		profile->last_time = cur_time;
> +		spin_unlock(&profile->stats_lock);
>  		return 0;
>  	}
>  
>  	prev_lev = devfreq_get_freq_level(devfreq, devfreq->previous_freq);
>  
> -	spin_lock(&devfreq->stats_lock);
> +	spin_lock(&profile->stats_lock);
>  	if (prev_lev < 0) {
>  		ret = prev_lev;
>  		goto out;
>  	}
>  
> -	devfreq->time_in_state[prev_lev] +=
> -			 cur_time - devfreq->last_time;
> +	profile->time_in_state[prev_lev] +=
> +			 cur_time - profile->last_time;
>  	lev = devfreq_get_freq_level(devfreq, freq);
>  	if (lev < 0) {
>  		ret = lev;
> @@ -187,14 +188,14 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>  	}
>  
>  	if (lev != prev_lev) {
> -		devfreq->trans_table[(prev_lev *
> -				devfreq->profile->max_state) + lev]++;
> -		devfreq->total_trans++;
> +		profile->trans_table[(prev_lev *
> +				profile->max_state) + lev]++;
> +		profile->total_trans++;
>  	}
>  
>  out:
> -	devfreq->last_time = cur_time;
> -	spin_unlock(&devfreq->stats_lock);
> +	profile->last_time = cur_time;
> +	spin_unlock(&profile->stats_lock);
>  	return ret;
>  }
>  EXPORT_SYMBOL(devfreq_update_status);
> @@ -474,23 +475,23 @@ EXPORT_SYMBOL(devfreq_monitor_suspend);
>  void devfreq_monitor_resume(struct devfreq *devfreq)
>  {
>  	unsigned long freq;
> +	struct devfreq_dev_profile *profile = devfreq->profile;
>  
>  	mutex_lock(&devfreq->lock);
>  	if (!devfreq->stop_polling)
>  		goto out;
>  
> -	if (!delayed_work_pending(&devfreq->work) &&
> -			devfreq->profile->polling_ms)
> +	if (!delayed_work_pending(&devfreq->work) && profile->polling_ms)
>  		queue_delayed_work(devfreq_wq, &devfreq->work,
> -			msecs_to_jiffies(devfreq->profile->polling_ms));
> +			msecs_to_jiffies(profile->polling_ms));
>  
> -	spin_lock(&devfreq->stats_lock);
> -	devfreq->last_time = get_jiffies_64();
> -	spin_unlock(&devfreq->stats_lock);
> +	spin_lock(&profile->stats_lock);
> +	profile->last_time = get_jiffies_64();
> +	spin_unlock(&profile->stats_lock);
>  	devfreq->stop_polling = false;
>  
> -	if (devfreq->profile->get_cur_freq &&
> -		!devfreq->profile->get_cur_freq(devfreq->dev.parent, &freq))
> +	if (profile->get_cur_freq &&
> +	    !profile->get_cur_freq(devfreq->dev.parent, &freq))
>  		devfreq->previous_freq = freq;
>  
>  out:
> @@ -657,7 +658,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	devfreq->data = data;
>  	devfreq->nb.notifier_call = devfreq_notifier_call;
>  
> -	if (!devfreq->profile->max_state && !devfreq->profile->freq_table) {
> +	if (!profile->max_state && !profile->freq_table) {
>  		mutex_unlock(&devfreq->lock);
>  		err = set_freq_table(devfreq);
>  		if (err < 0)
> @@ -693,29 +694,29 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  		goto err_out;
>  	}
>  
> -	devfreq->trans_table = devm_kzalloc(&devfreq->dev,
> -			array3_size(sizeof(unsigned int),
> -				    devfreq->profile->max_state,
> -				    devfreq->profile->max_state),
> -			GFP_KERNEL);
> -	if (!devfreq->trans_table) {
> +	profile->trans_table = devm_kzalloc(&devfreq->dev,
> +					    array3_size(sizeof(unsigned int),
> +							profile->max_state,
> +							profile->max_state),
> +					    GFP_KERNEL);
> +	if (!profile->trans_table) {
>  		mutex_unlock(&devfreq->lock);
>  		err = -ENOMEM;
>  		goto err_devfreq;
>  	}
>  
> -	devfreq->time_in_state = devm_kcalloc(&devfreq->dev,
> -			devfreq->profile->max_state,
> -			sizeof(*devfreq->time_in_state),
> -			GFP_KERNEL);
> -	if (!devfreq->time_in_state) {
> +	profile->time_in_state = devm_kcalloc(&devfreq->dev,
> +					      profile->max_state,
> +					      sizeof(*profile->time_in_state),
> +					      GFP_KERNEL);
> +	if (!profile->time_in_state) {
>  		mutex_unlock(&devfreq->lock);
>  		err = -ENOMEM;
>  		goto err_devfreq;
>  	}
>  
> -	devfreq->last_time = get_jiffies_64();
> -	spin_lock_init(&devfreq->stats_lock);
> +	profile->last_time = get_jiffies_64();
> +	spin_lock_init(&profile->stats_lock);
>  
>  	srcu_init_notifier_head(&devfreq->transition_notifier_list);
>  
> @@ -1402,9 +1403,10 @@ static ssize_t trans_stat_show(struct device *dev,
>  			       struct device_attribute *attr, char *buf)
>  {
>  	struct devfreq *devfreq = to_devfreq(dev);
> +	struct devfreq_dev_profile *profile = devfreq->profile;
>  	ssize_t len;
>  	int i, j;
> -	unsigned int max_state = devfreq->profile->max_state;
> +	unsigned int max_state = profile->max_state;
>  
>  	if (!devfreq->stop_polling &&
>  			devfreq_update_status(devfreq, devfreq->previous_freq))
> @@ -1415,46 +1417,45 @@ static ssize_t trans_stat_show(struct device *dev,
>  	len = sprintf(buf, "     From  :   To\n");
>  	len += sprintf(buf + len, "           :");
>  
> -	spin_lock(&devfreq->stats_lock);
> +	spin_lock(&profile->stats_lock);
>  	for (i = 0; i < max_state; i++)
>  		len += sprintf(buf + len, "%10lu",
> -				devfreq->profile->freq_table[i]);
> +				profile->freq_table[i]);
>  
>  	len += sprintf(buf + len, "   time(ms)\n");
>  
>  	for (i = 0; i < max_state; i++) {
> -		if (devfreq->profile->freq_table[i]
> -					== devfreq->previous_freq) {
> +		if (profile->freq_table[i] == devfreq->previous_freq)
>  			len += sprintf(buf + len, "*");
> -		} else {
> +		else
>  			len += sprintf(buf + len, " ");
> -		}
> +
>  		len += sprintf(buf + len, "%10lu:",
> -				devfreq->profile->freq_table[i]);
> +				profile->freq_table[i]);
>  		for (j = 0; j < max_state; j++)
>  			len += sprintf(buf + len, "%10u",
> -				devfreq->trans_table[(i * max_state) + j]);
> +				profile->trans_table[(i * max_state) + j]);
>  		len += sprintf(buf + len, "%10llu\n", (u64)
> -			jiffies64_to_msecs(devfreq->time_in_state[i]));
> +			jiffies64_to_msecs(profile->time_in_state[i]));
>  	}
>  
>  	len += sprintf(buf + len, "Total transition : %u\n",
> -					devfreq->total_trans);
> -	spin_unlock(&devfreq->stats_lock);
> +					profile->total_trans);
> +	spin_unlock(&profile->stats_lock);
>  	return len;
>  }
>  static DEVICE_ATTR_RO(trans_stat);
>  
> -static void defvreq_stats_clear_table(struct devfreq *devfreq)
> +static void defvreq_stats_clear_table(struct devfreq_dev_profile *profile)
>  {
> -	unsigned int count = devfreq->profile->max_state;
> -
> -	spin_lock(&devfreq->stats_lock);
> -	memset(devfreq->time_in_state, 0, count * sizeof(u64));
> -	memset(devfreq->trans_table, 0, count * count * sizeof(int));
> -	devfreq->last_time = get_jiffies_64();
> -	devfreq->total_trans = 0;
> -	spin_unlock(&devfreq->stats_lock);
> +	unsigned int count = profile->max_state;
> +
> +	spin_lock(&profile->stats_lock);
> +	memset(profile->time_in_state, 0, count * sizeof(u64));
> +	memset(profile->trans_table, 0, count * count * sizeof(int));
> +	profile->last_time = get_jiffies_64();
> +	profile->total_trans = 0;
> +	spin_unlock(&profile->stats_lock);
>  }
>  
>  static ssize_t trans_reset_store(struct device *dev,
> @@ -1464,7 +1465,7 @@ static ssize_t trans_reset_store(struct device *dev,
>  {
>  	struct devfreq *devfreq = to_devfreq(dev);
>  
> -	defvreq_stats_clear_table(devfreq);
> +	defvreq_stats_clear_table(devfreq->profile);
>  
>  	return count;
>  }
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index 2ddf25993f7d..4ceb2a517a9c 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -91,6 +91,12 @@ struct devfreq_dev_status {
>   * @freq_table:		Optional list of frequencies to support statistics
>   *			and freq_table must be generated in ascending order.
>   * @max_state:		The size of freq_table.
> + * @total_trans:	Number of devfreq transitions
> + * @trans_table:	Statistics of devfreq transitions
> + * @time_in_state:	Statistics of devfreq states
> + * @last_time:		The last time stats were updated
> + * @stats_lock:		Lock protecting trans_table, time_in_state,
> + *			last_time and total_trans used for statistics
>   */
>  struct devfreq_dev_profile {
>  	unsigned long initial_freq;
> @@ -104,6 +110,12 @@ struct devfreq_dev_profile {
>  
>  	unsigned long *freq_table;
>  	unsigned int max_state;
> +	/* information for device frequency transition */
> +	unsigned int total_trans;
> +	unsigned int *trans_table;
> +	u64 *time_in_state;
> +	unsigned long long last_time;
> +	spinlock_t stats_lock;
>  };
>  
>  /**
> @@ -131,12 +143,6 @@ struct devfreq_dev_profile {
>   * @suspend_freq:	 frequency of a device set during suspend phase.
>   * @resume_freq:	 frequency of a device set in resume phase.
>   * @suspend_count:	 suspend requests counter for a device.
> - * @total_trans:	Number of devfreq transitions
> - * @trans_table:	Statistics of devfreq transitions
> - * @time_in_state:	Statistics of devfreq states
> - * @last_time:		The last time stats were updated
> - * @stats_lock:		Lock protecting trans_table, time_in_state, last_time
> - *			and total_trans used for statistics
>   * @transition_notifier_list: list head of DEVFREQ_TRANSITION_NOTIFIER notifier
>   *
>   * This structure stores the devfreq information for a give device.
> @@ -173,13 +179,6 @@ struct devfreq {
>  	unsigned long resume_freq;
>  	atomic_t suspend_count;
>  
> -	/* information for device frequency transition */
> -	unsigned int total_trans;
> -	unsigned int *trans_table;
> -	u64 *time_in_state;
> -	unsigned long long last_time;
> -	spinlock_t stats_lock;
> -
>  	struct srcu_notifier_head transition_notifier_list;
>  };
>  
> 
