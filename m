Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A193322BB89
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jul 2020 03:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgGXBa1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Jul 2020 21:30:27 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:34609 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgGXBa1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jul 2020 21:30:27 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200724013020epoutp049368442891b90f50e97ac83776102748~kjBw7KFLc0121901219epoutp04P
        for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2020 01:30:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200724013020epoutp049368442891b90f50e97ac83776102748~kjBw7KFLc0121901219epoutp04P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1595554220;
        bh=sDkywlC37Mfc4GeqS/QBxJW96NYDvgyhZByXX5UIuZQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=cfMpaDwYT4xjXiGq4Myu2mS6IazCE+vEtgK6n7jO+gpaWFc4E7UhaqCSoqnDId66V
         eDI0/fWzm+dDCVXseMqZ1dS39zmqeoSNvcpUwQk4AK6J90dVw+TzuGnEBdxQH6lAGp
         qOXNK5HsvnYvIPXmGjD5d5PrjpZSPlEmhnxdeQ7E=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200724013020epcas1p1feca0d6f5c13ad4dc408da54d19f427a~kjBwRNidP1509415094epcas1p1v;
        Fri, 24 Jul 2020 01:30:20 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.157]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4BCWpy1VhJzMqYkn; Fri, 24 Jul
        2020 01:30:18 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        41.A2.28578.8A93A1F5; Fri, 24 Jul 2020 10:30:16 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200724013015epcas1p37acad7db6732252f3800474b44a4ce30~kjBrpgbkh2618926189epcas1p3d;
        Fri, 24 Jul 2020 01:30:15 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200724013015epsmtrp2ef54417fee74fa5deffc50440d3ea927~kjBrou0PC3073530735epsmtrp2a;
        Fri, 24 Jul 2020 01:30:15 +0000 (GMT)
X-AuditID: b6c32a39-e6f5da8000006fa2-d1-5f1a39a8a1dc
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        16.88.08303.7A93A1F5; Fri, 24 Jul 2020 10:30:15 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200724013014epsmtip2219e1602465b4d7962aa530d4110a820~kjBrZjycm0479904799epsmtip2U;
        Fri, 24 Jul 2020 01:30:14 +0000 (GMT)
Subject: Re: [PATCH v2 1/2] PM / devfreq: Clean up the devfreq instance name
 in sysfs attr
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     leonard.crestez@nxp.com, lukasz.luba@arm.com,
        enric.balletbo@collabora.com, hl@rock-chips.com, digetx@gmail.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, abel.vesa@nxp.com,
        chanwoo@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <b1bfdf95-7990-17e3-07df-51e1fe66adb1@samsung.com>
Date:   Fri, 24 Jul 2020 10:42:02 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200713083113.5595-2-cw00.choi@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJJsWRmVeSWpSXmKPExsWy7bCmge4KS6l4gwn/zS2WXTrKaDHxxhUW
        i9UfHzNarLl9iNHix4ZTzBYtsxaxWJxtesNuseLuR1aLy7vmsFl87j3CaLGwqYXd4nbjCjaL
        n7vmsTjweqyZt4bRY8fdJYweO2fdZffYtKqTzaO3+R2bx8Z3O5g8/s7az+LRt2UVo8fnTXIB
        nFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAhysp
        lCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCiwL9IoTc4tL89L1kvNzrQwNDIxMgQoT
        sjPub9vDWnDYtqLvhkgD436DLkZODgkBE4nFb88wdTFycQgJ7GCUWPz1GZTziVHi/fGDLBDO
        Z0aJD28XM8O0HFrXAVW1i1Hi5MdjjBDOe0aJjc+ms3YxcnAIC8RI3DlhCdIgImAlcfp/B1gz
        s0Ark8SX8zEgNpuAlsT+FzfYQGx+AUWJqz8eM4LYvAJ2EpdWXWYFsVkEVCU2TFgBViMqECZx
        clsLVI2gxMmZT1hAbE6g+dNbj7NBzBeXuPVkPhOELS+x/e0cZpDbJAQecEhMW9QP9YGLxMuj
        XWwQtrDEq+Nb2CFsKYnP7/ZCxaslVp48wgbR3MEosWX/BVaIhLHE/qWTmUCeZBbQlFi/Sx8i
        rCix8/dcRojFfBLvvvaAw0FCgFeio00IokRZ4vKDu0wQtqTE4vZOtgmMSrOQvDMLyQuzkLww
        C2HZAkaWVYxiqQXFuempxYYFpsiRvYkRnKa1LHcwTn/7Qe8QIxMH4yFGCQ5mJRFeHUbxeCHe
        lMTKqtSi/Pii0pzU4kOMpsAAnsgsJZqcD8wUeSXxhqZGxsbGFiaGZqaGhkrivP/OsscLCaQn
        lqRmp6YWpBbB9DFxcEo1MMWqdSzdclEwwNzmZ43tFF3BVf/YN/9pznHNjOhJDNRN0F5lzcLe
        bVi1y4HdW/atY/82wcfFBw541cq2hHaz+tfsqNbiYnpzr/61xTqRnUq3om58WnxN8MdOp783
        n5Yy3ni7elfczu8tC/Y0um7YbFqaxVogW/vN4WeHjIkvR4LvXPe5Ml6vpvjudHndeyXgF1et
        QfQCrgvfbS1cnbTygpeK/djPPO//NKFvDF/5n9rWLXIM5kycPcnpxZWTSdm6HNwdniU7jqq0
        eR3kLDXOrd5q6fyo50KaX2PWGXa38JNly6R3iFx9eM5J8/Qf4wkS9ZlbJvl9Yc1I1v+cpLvv
        bMfBtceel1znTzd5eltXiaU4I9FQi7moOBEAsCdjDFwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsWy7bCSvO5yS6l4g6WzOC2WXTrKaDHxxhUW
        i9UfHzNarLl9iNHix4ZTzBYtsxaxWJxtesNuseLuR1aLy7vmsFl87j3CaLGwqYXd4nbjCjaL
        n7vmsTjweqyZt4bRY8fdJYweO2fdZffYtKqTzaO3+R2bx8Z3O5g8/s7az+LRt2UVo8fnTXIB
        nFFcNimpOZllqUX6dglcGfe37WEtOGxb0XdDpIFxv0EXIyeHhICJxKF1HUxdjFwcQgI7GCXu
        7J/FCJGQlJh28ShzFyMHkC0scfhwMUTNW0aJ3av7WEHiwgIxEndOWIKUiwhYSZz+38EMYjML
        tDJJfDonDFG/l1Fi3dcF7CAJNgEtif0vbrCB2PwCihJXfzwG28UrYCdxadVlVhCbRUBVYsOE
        FWA1ogJhEjuXPGaCqBGUODnzCQuIzQm0bHrrcTaIZeoSf+ZdglosLnHryXwmCFteYvvbOcwT
        GIVnIWmfhaRlFpKWWUhaFjCyrGKUTC0ozk3PLTYsMMpLLdcrTswtLs1L10vOz93ECI5XLa0d
        jHtWfdA7xMjEwXiIUYKDWUmEV4dRPF6INyWxsiq1KD++qDQntfgQozQHi5I479dZC+OEBNIT
        S1KzU1MLUotgskwcnFINTPM2ng/cH9J63eaw7/sglrtC9e38GT+u1OT3mKpNZg6cdCTEwfBz
        4YsqhYJfDMy1Njyfzzgcr3UuK3+2UrTqwBSlPOG9Hw9qeOyRsD0h7fvDw1P4y+GsGZqHej7I
        sTXw/koTvuH++/k2Y66OmY91by29JdfGIj3d+UfPwas+7PJhyXn3Go+s7V21SOn65aKdd5ft
        YtR3XCKcLC9eLmV9WltGVmqmduy5CQv5J8Y1NPpIKfFesn1y8zHXh52zyifnHy+/Fvb4+tP4
        7vDu+KJ/r/8Yr9qksZLJoHDLvzM3+I268tRtozRU8rJWHFoVwKi7lV9/w+wz62R5tlSlr9yr
        tcfB9F3ZkZPTOn9dvHBNSYmlOCPRUIu5qDgRAGrtGPxGAwAA
X-CMS-MailID: 20200724013015epcas1p37acad7db6732252f3800474b44a4ce30
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200713081943epcas1p2a618d5a2e87610be7442e1fa584076cf
References: <20200713083113.5595-1-cw00.choi@samsung.com>
        <CGME20200713081943epcas1p2a618d5a2e87610be7442e1fa584076cf@epcas1p2.samsung.com>
        <20200713083113.5595-2-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/13/20 5:31 PM, Chanwoo Choi wrote:
> The sysfs attr interface used eithere 'df' or 'devfreq' for devfreq instance
> name. In order to keep the consistency and to improve the readabilty,
> unify the instance name as 'df'. Add add the missing conditional statement
> to prevent the fault.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 94 +++++++++++++++++++++++++--------------
>  1 file changed, 60 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 5320c3b37f35..286957f760f1 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -1280,18 +1280,20 @@ EXPORT_SYMBOL(devfreq_remove_governor);
>  static ssize_t name_show(struct device *dev,
>  			struct device_attribute *attr, char *buf)
>  {
> -	struct devfreq *devfreq = to_devfreq(dev);
> -	return sprintf(buf, "%s\n", dev_name(devfreq->dev.parent));
> +	struct devfreq *df = to_devfreq(dev);
> +	return sprintf(buf, "%s\n", dev_name(df->dev.parent));
>  }
>  static DEVICE_ATTR_RO(name);
>  
>  static ssize_t governor_show(struct device *dev,
>  			     struct device_attribute *attr, char *buf)
>  {
> -	if (!to_devfreq(dev)->governor)
> +	struct devfreq *df = to_devfreq(dev);
> +
> +	if (!df->governor)
>  		return -EINVAL;
>  
> -	return sprintf(buf, "%s\n", to_devfreq(dev)->governor->name);
> +	return sprintf(buf, "%s\n", df->governor->name);
>  }
>  
>  static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
> @@ -1302,6 +1304,9 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>  	char str_governor[DEVFREQ_NAME_LEN + 1];
>  	const struct devfreq_governor *governor, *prev_governor;
>  
> +	if (!df->governor)
> +		return -EINVAL;
> +
>  	ret = sscanf(buf, "%" __stringify(DEVFREQ_NAME_LEN) "s", str_governor);
>  	if (ret != 1)
>  		return -EINVAL;
> @@ -1315,20 +1320,18 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>  	if (df->governor == governor) {
>  		ret = 0;
>  		goto out;
> -	} else if ((df->governor && df->governor->immutable) ||
> -					governor->immutable) {
> +	} else if (df->governor->immutable || governor->immutable) {
>  		ret = -EINVAL;
>  		goto out;
>  	}
>  
> -	if (df->governor) {
> -		ret = df->governor->event_handler(df, DEVFREQ_GOV_STOP, NULL);
> -		if (ret) {
> -			dev_warn(dev, "%s: Governor %s not stopped(%d)\n",
> -				 __func__, df->governor->name, ret);
> -			goto out;
> -		}
> +	ret = df->governor->event_handler(df, DEVFREQ_GOV_STOP, NULL);
> +	if (ret) {
> +		dev_warn(dev, "%s: Governor %s not stopped(%d)\n",
> +			 __func__, df->governor->name, ret);
> +		goto out;
>  	}
> +
>  	prev_governor = df->governor;
>  	df->governor = governor;
>  	strncpy(df->governor_name, governor->name, DEVFREQ_NAME_LEN);
> @@ -1363,13 +1366,16 @@ static ssize_t available_governors_show(struct device *d,
>  	struct devfreq *df = to_devfreq(d);
>  	ssize_t count = 0;
>  
> +	if (!df->governor)
> +		return -EINVAL;
> +
>  	mutex_lock(&devfreq_list_lock);
>  
>  	/*
>  	 * The devfreq with immutable governor (e.g., passive) shows
>  	 * only own governor.
>  	 */
> -	if (df->governor && df->governor->immutable) {
> +	if (df->governor->immutable) {
>  		count = scnprintf(&buf[count], DEVFREQ_NAME_LEN,
>  				  "%s ", df->governor_name);
>  	/*
> @@ -1403,27 +1409,37 @@ static ssize_t cur_freq_show(struct device *dev, struct device_attribute *attr,
>  			     char *buf)
>  {
>  	unsigned long freq;
> -	struct devfreq *devfreq = to_devfreq(dev);
> +	struct devfreq *df = to_devfreq(dev);
>  
> -	if (devfreq->profile->get_cur_freq &&
> -		!devfreq->profile->get_cur_freq(devfreq->dev.parent, &freq))
> +	if (!df->profile)
> +		return -EINVAL;
> +
> +	if (df->profile->get_cur_freq &&
> +		!df->profile->get_cur_freq(df->dev.parent, &freq))
>  		return sprintf(buf, "%lu\n", freq);
>  
> -	return sprintf(buf, "%lu\n", devfreq->previous_freq);
> +	return sprintf(buf, "%lu\n", df->previous_freq);
>  }
>  static DEVICE_ATTR_RO(cur_freq);
>  
>  static ssize_t target_freq_show(struct device *dev,
>  				struct device_attribute *attr, char *buf)
>  {
> -	return sprintf(buf, "%lu\n", to_devfreq(dev)->previous_freq);
> +	struct devfreq *df = to_devfreq(dev);
> +
> +	return sprintf(buf, "%lu\n", df->previous_freq);
>  }
>  static DEVICE_ATTR_RO(target_freq);
>  
>  static ssize_t polling_interval_show(struct device *dev,
>  				     struct device_attribute *attr, char *buf)
>  {
> -	return sprintf(buf, "%d\n", to_devfreq(dev)->profile->polling_ms);
> +	struct devfreq *df = to_devfreq(dev);
> +
> +	if (!df->profile)
> +		return -EINVAL;
> +
> +	return sprintf(buf, "%d\n", df->profile->polling_ms);
>  }
>  
>  static ssize_t polling_interval_store(struct device *dev,
> @@ -1551,6 +1567,9 @@ static ssize_t available_frequencies_show(struct device *d,
>  	ssize_t count = 0;
>  	int i;
>  
> +	if (!df->profile)
> +		return -EINVAL;
> +
>  	mutex_lock(&df->lock);
>  
>  	for (i = 0; i < df->profile->max_state; i++)
> @@ -1571,49 +1590,53 @@ static DEVICE_ATTR_RO(available_frequencies);
>  static ssize_t trans_stat_show(struct device *dev,
>  			       struct device_attribute *attr, char *buf)
>  {
> -	struct devfreq *devfreq = to_devfreq(dev);
> +	struct devfreq *df = to_devfreq(dev);
>  	ssize_t len;
>  	int i, j;
> -	unsigned int max_state = devfreq->profile->max_state;
> +	unsigned int max_state;
> +
> +	if (!df->profile)
> +		return -EINVAL;
> +	max_state = df->profile->max_state;
>  
>  	if (max_state == 0)
>  		return sprintf(buf, "Not Supported.\n");
>  
> -	mutex_lock(&devfreq->lock);
> -	if (!devfreq->stop_polling &&
> -			devfreq_update_status(devfreq, devfreq->previous_freq)) {
> -		mutex_unlock(&devfreq->lock);
> +	mutex_lock(&df->lock);
> +	if (!df->stop_polling &&
> +			devfreq_update_status(df, df->previous_freq)) {
> +		mutex_unlock(&df->lock);
>  		return 0;
>  	}
> -	mutex_unlock(&devfreq->lock);
> +	mutex_unlock(&df->lock);
>  
>  	len = sprintf(buf, "     From  :   To\n");
>  	len += sprintf(buf + len, "           :");
>  	for (i = 0; i < max_state; i++)
>  		len += sprintf(buf + len, "%10lu",
> -				devfreq->profile->freq_table[i]);
> +				df->profile->freq_table[i]);
>  
>  	len += sprintf(buf + len, "   time(ms)\n");
>  
>  	for (i = 0; i < max_state; i++) {
> -		if (devfreq->profile->freq_table[i]
> -					== devfreq->previous_freq) {
> +		if (df->profile->freq_table[i]
> +					== df->previous_freq) {
>  			len += sprintf(buf + len, "*");
>  		} else {
>  			len += sprintf(buf + len, " ");
>  		}
>  		len += sprintf(buf + len, "%10lu:",
> -				devfreq->profile->freq_table[i]);
> +				df->profile->freq_table[i]);
>  		for (j = 0; j < max_state; j++)
>  			len += sprintf(buf + len, "%10u",
> -				devfreq->stats.trans_table[(i * max_state) + j]);
> +				df->stats.trans_table[(i * max_state) + j]);
>  
>  		len += sprintf(buf + len, "%10llu\n", (u64)
> -			jiffies64_to_msecs(devfreq->stats.time_in_state[i]));
> +			jiffies64_to_msecs(df->stats.time_in_state[i]));
>  	}
>  
>  	len += sprintf(buf + len, "Total transition : %u\n",
> -					devfreq->stats.total_trans);
> +					df->stats.total_trans);
>  	return len;
>  }
>  
> @@ -1624,6 +1647,9 @@ static ssize_t trans_stat_store(struct device *dev,
>  	struct devfreq *df = to_devfreq(dev);
>  	int err, value;
>  
> +	if (!df->profile)
> +		return -EINVAL;
> +
>  	if (df->profile->max_state == 0)
>  		return count;
>  
> 

Applied it. It is just clean-up patch for patch2.
patch2 needs more discussion. So, only apply patch1.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
