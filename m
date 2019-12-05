Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE3C1138CB
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 01:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbfLEA2z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Dec 2019 19:28:55 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45498 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728098AbfLEA2z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Dec 2019 19:28:55 -0500
Received: by mail-pf1-f195.google.com with SMTP id 2so672805pfg.12
        for <linux-pm@vger.kernel.org>; Wed, 04 Dec 2019 16:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SGY5BaGmXPT4uINL+GyoXg56qoXAYBQaLO6/xgRHma4=;
        b=FJorzEs/rvBItm1FmCRV2mBoSNDcbOQvwQ4LVJuPXo5sTum/hnaH7R4hHLaeCJ2wPD
         9YrUlr4QdbumgMqE5/sMPclp2qVp/ke49xnD/E+3xOjZoIf/Zy9iSxVdq6TxZvejeSbp
         1FrtCc1i1yZYBH97fZRUPA0CHGv4jfbqZ3tPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SGY5BaGmXPT4uINL+GyoXg56qoXAYBQaLO6/xgRHma4=;
        b=h0NOd9n7RSt9WhS8prQtZf2Y0nQNN7OhvLh8iWF2CLygRtOeSywX4zZG80GrHTR7/c
         7dcMVS+4vnuZ6QX/TBfdWdG2zrPBzvuwQifMZ5MLMXKrhS9P95u/3TrzYfozwdx2+Sms
         xzHutmVf+DXcSw1ICQrksk/15qs7ZgFHAuB+/StWQxfjkVuIp2bCJLTLtamgxXMipliG
         VTo7XxDtksUocPRfeVgU/e/WgwsGkU0iiIv0gKejBo89unP0gIZknJnu8FNrZqJoFG9O
         zTAF8qiZyMj5mrV4tdAaK8ndLzzo/6cdPqcQWOtewgGW9nWmZsgBTQMUQDbTo7NWCgWx
         mpJw==
X-Gm-Message-State: APjAAAUeAgEnp9EoaTjjBPLiDJd6duPj3k48OySl0i/nqCyTuLsgKoYO
        Yh8oLYEQRbcKyqswb+aaupNw0Q==
X-Google-Smtp-Source: APXvYqwpgYDILUAMuwTZDSGEg6W50s5IG9cah1dtrGom1AZPWmk7U9Vykphx+N7HiXjhGFaZSx/dZw==
X-Received: by 2002:a63:480f:: with SMTP id v15mr6310765pga.201.1575505734304;
        Wed, 04 Dec 2019 16:28:54 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id d6sm7108603pju.8.2019.12.04.16.28.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2019 16:28:53 -0800 (PST)
Date:   Wed, 4 Dec 2019 16:28:52 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Kamil Konieczny <k.konieczny@samsung.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH v2 3/3] devfreq: move statistics to separate struct
Message-ID: <20191205002852.GJ228856@google.com>
References: <20191204150018.5234-1-k.konieczny@samsung.com>
 <CGME20191204150034eucas1p1b6e7f43a6be59ed2e0a4e55ccdefc750@eucas1p1.samsung.com>
 <20191204150018.5234-4-k.konieczny@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191204150018.5234-4-k.konieczny@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Wed, Dec 04, 2019 at 04:00:18PM +0100, Kamil Konieczny wrote:
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
> + * @freq_table:		List of frequencies in ascending order.
> + * @max_state:		The size of freq_table.
> + * @total_trans:	Number of devfreq transitions.
> + * @trans_table:	Statistics of devfreq transitions.
> + * @time_in_state:	Statistics of devfreq states.
> + * @last_stat_updated:	The last time stats were updated.
> + */
> +struct devfreq_stats {
> +	unsigned long *freq_table;

nit: trans_stat_show() is the only place where 'freq_table' is
used. Instead of 'duplicating' it (I know, it's just a pointer)
you could use a local pointer 'freq_table' in trans_stat_show().

> +	unsigned int max_state;

nit: max_state is also a bit of a corner case. It's not really a 'stat' and
it is already available in struct devfreq_dev_profile, it doesn't seem a
huge inconvenient to take it from there.

> +
> +	unsigned int total_trans;
> +	unsigned int *trans_table;
> +	u64 *time_in_state;
> +	unsigned long long last_stat_updated;

nit: the name 'last_stat_updated' is somewhat redundant, since the
field is part of a struct called 'devfreq_stats'. 'last_updated' or
'last_update' would be concise enough IMO.

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
>  
>  	struct srcu_notifier_head transition_notifier_list;
>  };

My comments above are just suggestions:

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

