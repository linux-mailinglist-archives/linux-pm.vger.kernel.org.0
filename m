Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 369B4114C11
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2019 06:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfLFFaH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Dec 2019 00:30:07 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:22024 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfLFFaH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Dec 2019 00:30:07 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191206053003epoutp0304003cad9b65bde00d29bbc7444727a8~dsSHbgH3x0363603636epoutp03E
        for <linux-pm@vger.kernel.org>; Fri,  6 Dec 2019 05:30:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191206053003epoutp0304003cad9b65bde00d29bbc7444727a8~dsSHbgH3x0363603636epoutp03E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575610203;
        bh=GG5MUxpWQ7809fVXXhPZYMif8ZzXORDkwT23qiPKBAY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=IlXlGiIkY/2e9XQYil1r0fAE2eaY01jyA2LD83ZFyC2A47GOX48DKlQHlR6FhXcK9
         poTL66RnZvl4UvXaDB/UBEgCzJH+SV8D/rr52QDSg2O43W53sGOINYqzDMewX91f5T
         4lnGLmb6MADXW7mCDeOlIS/NgBsH7kQ+wO8fK7Nw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191206053002epcas1p257f22c58142e6ca684b50614fb218b28~dsSGmpQEW0609506095epcas1p24;
        Fri,  6 Dec 2019 05:30:02 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.154]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47Th482VlfzMqYkZ; Fri,  6 Dec
        2019 05:30:00 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        79.E7.48019.457E9ED5; Fri,  6 Dec 2019 14:29:56 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191206052955epcas1p34c376e4336b832c469751d13f115b855~dsR-7tv620382203822epcas1p30;
        Fri,  6 Dec 2019 05:29:55 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191206052955epsmtrp10de98b84a0a097692259cd7045d0890f~dsR-6xTXm1384813848epsmtrp1v;
        Fri,  6 Dec 2019 05:29:55 +0000 (GMT)
X-AuditID: b6c32a38-23fff7000001bb93-06-5de9e75400d9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        60.2B.06569.357E9ED5; Fri,  6 Dec 2019 14:29:55 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191206052955epsmtip262edf22dc744042b5861d84afc289f74~dsR-vN6u-2620426204epsmtip2e;
        Fri,  6 Dec 2019 05:29:55 +0000 (GMT)
Subject: Re: [PATCH v4] PM / devfreq: Move statistics to separate struct
 devfreq_stats
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     rafael.j.wysocki@intel.com, myungjoo.ham@samsung.com,
        b.zolnierkie@samsung.com, gregkh@linuxfoundation.org,
        krzk@kernel.org, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, mchehab@kernel.org, cpgs@samsung.com,
        Kamil Konieczny <k.konieczny@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <af1a2fd9-f717-ed23-1130-a0dad169c7e6@samsung.com>
Date:   Fri, 6 Dec 2019 14:36:08 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20191206053340.18706-1-cw00.choi@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0hTcRTH+W27D8Vrt2l5kB7zGoSWj5uubpYRZLFISDAijGk3d9lkz3Zn
        78BS0jR7EJVJkpGVaWUNKRN1ZUKssAcRhWFUrnI9LBzVYhZtu4v873PO73zP+X1/D1Ku7MET
        yTKLQ7BbeBODRytu3E3JSFv3wavN9LSQ3PWGDozz9qdwlec6cK55vAHjHj26RnCD+z4T3NPu
        0zjnqx9A3JWBYYK74JyQcS/3tuLcSOsXYnmM5lyPV6Zxth3ANa6my4TmUGcb0vicswqwIuNS
        g8DrBLtKsJRadWUWfS6zprBkRYl6YSabxi7mFjEqC28Wcpm8/IK0VWWm4PYY1VbeVB5MFfCi
        yGQsW2q3ljsElcEqOnIZwaYz2Rbb0kXeLJZb9OmlVnMOm5m5QB0s3GQ0jNU9wWy+7O1H7rtR
        BQqk1qIoEuhs8NX3yWpRNKmkuxAcqprApWAcgeezRy4FPxC0359Q/JMM/TyOSQu9CO601iMp
        +Irg6JuqYDOSjKM3QNun6SFBPJ0Do9UfiRDL6ToZtHzDQ4zTqeAafRHmKXQSPPOPoBBT9DIY
        fFsrD7GCngNf3x8ID55Grwf3japIzVRwn/IoQqOi6CVw4XaR1D4BhjxnZBLPhptfTocNAH2S
        gN7Bh5hkIA/GnndHOA4+3uskJE4E7+H9Ed4Fl9wDuCSuQdDpehwRZIHr/LGwRzmdAh3dGVI6
        CW4FmpDEFFRcD0T8xsLY94NYqDyUr9mvlEqS4enrYdkRlNw4yU3jJAuNkyw0/h/WjBRtaLpg
        E816QWRt2ZMv24nCLzeV60I9D/P7EU0iJoZq8I1qlRi/Vdxh7kdAypl4Sh/r1SopHb9jp2C3
        ltjLTYLYj9TBwz4qT5xWag3+A4ujhFUvyMrK4rLZhWqWZRIo0v9Eq6T1vEMwCoJNsP/Tycio
        xAqUt3akcF9LT8u2DUbH7s2/52P1f/y/+mY/cC9ZndsRGx33asJobmdmanLaVRcLqT+D4omp
        QxsTAtqLM1YeJIb9m4qu2nXUOzJ/5h2ibmAco/qSHrhq/fMMMbprla2VV19Xf9qd16Tbs6Vq
        za3lxXPHo2vWLUpvcqYXVycHoPnt2Z2MQjTwbKrcLvJ/AfpRaqzPAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsWy7bCSvG7w85exBjNb5S02zljPavHykKZF
        8+L1bBYLPs1gtTh/fgO7xdmmN+wWl3fNYbP43HuE0WLtkbvsFss2/WGyuN24gs3i8Yq37A48
        Hov3vGTy2LSqk81j/9w17B59W1YxenzeJBfAGsVlk5Kak1mWWqRvl8CV8a77ImvBZ5OKCadO
        MjYw/tbqYuTkkBAwkbj1fSprFyMXh5DAbkaJR2c/skMkJCWmXTzK3MXIAWQLSxw+XAxR85ZR
        YvbdHUwgcWGBCIlVr8VAykUErCRetL9iB6lhFuhmkrg5A6QGpOEgo8TUu8vBhrIJaEnsf3GD
        DcTmF1CUuPrjMSOIzStgJ3H2URcziM0ioCLx/lknC4gtKhAmsXPJYyaIGkGJkzOfsIAs5hSw
        llh2IAokzCygLvFn3iVmCFtc4taT+UwQtrzE9rdzmCcwCs9C0j0LScssJC2zkLQsYGRZxSiZ
        WlCcm55bbFhglJdarlecmFtcmpeul5yfu4kRHH1aWjsYT5yIP8QowMGoxMM74/OLWCHWxLLi
        ytxDjBIczEoivOl8L2OFeFMSK6tSi/Lji0pzUosPMUpzsCiJ88rnH4sUEkhPLEnNTk0tSC2C
        yTJxcEo1MFbqlui+KL1Ymxaw5v4xMQXh/lhz2w+35mnGbth98G2TsP3PqVzlM+23a+d06Lyo
        FPYWnKZ0fk/1qVzO/KU3eDZNffbY/+ah/H8dHR93z7OMV7X7n2zBbGH32vHN06N6TfJprXIn
        8y/OyMqYdbdHY21i07Zml9y13P1/VyhyTdNcE+Cb81ZkihJLcUaioRZzUXEiAO2Akka6AgAA
X-CMS-MailID: 20191206052955epcas1p34c376e4336b832c469751d13f115b855
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191206052729epcas1p110d11c728db1ebd7487c8c5fe936df21
References: <20191205145527.26117-4-k.konieczny@samsung.com>
        <CGME20191206052729epcas1p110d11c728db1ebd7487c8c5fe936df21@epcas1p1.samsung.com>
        <20191206053340.18706-1-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/6/19 2:33 PM, Chanwoo Choi wrote:
> From: Kamil Konieczny <k.konieczny@samsung.com>
> 
> Count time and transitions between devfreq frequencies in separate
> struct devfreq_stats for improved code readability and maintenance.
> 
> Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> [cw00.choi: Fix the merge conflict in trasn_stat_store]
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 44 ++++++++++++++++++++-------------------
>  include/linux/devfreq.h   | 26 +++++++++++++++--------
>  2 files changed, 40 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index df31f430051d..1786a86b1779 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -214,8 +214,8 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>  		goto out;
>  	}
>  
> -	devfreq->time_in_state[prev_lev] +=
> -			 cur_time - devfreq->last_stat_updated;
> +	devfreq->stats.time_in_state[prev_lev] +=
> +			cur_time - devfreq->stats.last_update;
>  
>  	lev = devfreq_get_freq_level(devfreq, freq);
>  	if (lev < 0) {
> @@ -224,13 +224,13 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>  	}
>  
>  	if (lev != prev_lev) {
> -		devfreq->trans_table[(prev_lev *
> -				devfreq->profile->max_state) + lev]++;
> -		devfreq->total_trans++;
> +		devfreq->stats.trans_table[
> +			(prev_lev * devfreq->profile->max_state) + lev]++;
> +		devfreq->stats.total_trans++;
>  	}
>  
>  out:
> -	devfreq->last_stat_updated = cur_time;
> +	devfreq->stats.last_update = cur_time;
>  	return ret;
>  }
>  EXPORT_SYMBOL(devfreq_update_status);
> @@ -525,7 +525,7 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
>  			msecs_to_jiffies(devfreq->profile->polling_ms));
>  
>  out_update:
> -	devfreq->last_stat_updated = get_jiffies_64();
> +	devfreq->stats.last_update = get_jiffies_64();
>  	devfreq->stop_polling = false;
>  
>  	if (devfreq->profile->get_cur_freq &&
> @@ -735,28 +735,29 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  		goto err_out;
>  	}
>  
> -	devfreq->trans_table = devm_kzalloc(&devfreq->dev,
> +	devfreq->stats.trans_table = devm_kzalloc(&devfreq->dev,
>  			array3_size(sizeof(unsigned int),
>  				    devfreq->profile->max_state,
>  				    devfreq->profile->max_state),
>  			GFP_KERNEL);
> -	if (!devfreq->trans_table) {
> +	if (!devfreq->stats.trans_table) {
>  		mutex_unlock(&devfreq->lock);
>  		err = -ENOMEM;
>  		goto err_devfreq;
>  	}
>  
> -	devfreq->time_in_state = devm_kcalloc(&devfreq->dev,
> +	devfreq->stats.time_in_state = devm_kcalloc(&devfreq->dev,
>  			devfreq->profile->max_state,
> -			sizeof(*devfreq->time_in_state),
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
> +	devfreq->stats.total_trans = 0;
> +	devfreq->stats.last_update = get_jiffies_64();
>  
>  	srcu_init_notifier_head(&devfreq->transition_notifier_list);
>  
> @@ -1469,13 +1470,14 @@ static ssize_t trans_stat_show(struct device *dev,
>  				devfreq->profile->freq_table[i]);
>  		for (j = 0; j < max_state; j++)
>  			len += sprintf(buf + len, "%10u",
> -				devfreq->trans_table[(i * max_state) + j]);
> +				devfreq->stats.trans_table[(i * max_state) + j]);
> +
>  		len += sprintf(buf + len, "%10llu\n", (u64)
> -			jiffies64_to_msecs(devfreq->time_in_state[i]));
> +			jiffies64_to_msecs(devfreq->stats.time_in_state[i]));
>  	}
>  
>  	len += sprintf(buf + len, "Total transition : %u\n",
> -					devfreq->total_trans);
> +					devfreq->stats.total_trans);
>  	return len;
>  }
>  
> @@ -1494,13 +1496,13 @@ static ssize_t trans_stat_store(struct device *dev,
>  		return -EINVAL;
>  
>  	mutex_lock(&df->lock);
> -	memset(df->time_in_state, 0, (df->profile->max_state *
> -					sizeof(*df->time_in_state)));
> -	memset(df->trans_table, 0, array3_size(sizeof(unsigned int),
> +	memset(df->stats.time_in_state, 0, (df->profile->max_state *
> +					sizeof(*df->stats.time_in_state)));
> +	memset(df->stats.trans_table, 0, array3_size(sizeof(unsigned int),
>  					df->profile->max_state,
>  					df->profile->max_state));
> -	df->total_trans = 0;
> -	df->last_stat_updated = get_jiffies_64();
> +	df->stats.total_trans = 0;
> +	df->stats.last_update = get_jiffies_64();
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

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
