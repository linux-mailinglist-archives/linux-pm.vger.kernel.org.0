Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A914151692
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2020 08:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgBDHoB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Feb 2020 02:44:01 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:23592 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbgBDHoB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Feb 2020 02:44:01 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200204074358epoutp022c436e132b0fa93c4acba080c0bdb0e0~wI0KjtCS80648406484epoutp02U
        for <linux-pm@vger.kernel.org>; Tue,  4 Feb 2020 07:43:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200204074358epoutp022c436e132b0fa93c4acba080c0bdb0e0~wI0KjtCS80648406484epoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580802238;
        bh=E6jhu6LDz2tkms5iVWGpzEUfIjTjUEMI5WxhAe8uQG8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=vYJ3vVwt/rsj4J6J8mO3O5qM3BHk2FzDcXLuY4Bcbux0+z8dwGcLRAeBCYeYHitRp
         1Dq1EmITPEcD57wMZiwt/SKilJ+mIKc7Z2B7O+Ec5lPXE6w66PFhlPnjd5T7xvSoAG
         7vFRSRu2vLPTaU7eAbq6uEEU3qbAlJBiJKEyNKIw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200204074357epcas1p3d746bc6bca16b985f783b22595a7d006~wI0KHOLR30802108021epcas1p3G;
        Tue,  4 Feb 2020 07:43:57 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.153]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 48BcBx71BbzMqYkV; Tue,  4 Feb
        2020 07:43:53 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        0A.31.57028.8B0293E5; Tue,  4 Feb 2020 16:43:52 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200204074352epcas1p19c4a45e8e4010bfa2c4c9c2335e3914d~wI0E2gsEd1248812488epcas1p11;
        Tue,  4 Feb 2020 07:43:52 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200204074352epsmtrp2859756a7a24a84fe3ace2f9841991748~wI0E1tIpC1827418274epsmtrp2Z;
        Tue,  4 Feb 2020 07:43:52 +0000 (GMT)
X-AuditID: b6c32a35-50bff7000001dec4-dc-5e3920b8eb73
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0A.EB.10238.8B0293E5; Tue,  4 Feb 2020 16:43:52 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200204074352epsmtip26bb88bc3d7ae29e30be73e82c1427ec3~wI0EqxJik0993909939epsmtip22;
        Tue,  4 Feb 2020 07:43:51 +0000 (GMT)
Subject: Re: [PATCHv2 2/2] PM / devfreq: Change to
 DEVFREQ_GOV_UPDATE_INTERVAL event name
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     chanwoo@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, lukasz.luba@arm.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <fad8dc9b-c4bc-a644-74ce-4b293489b01e@samsung.com>
Date:   Tue, 4 Feb 2020 16:51:39 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200203011733.7639-2-cw00.choi@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmru4OBcs4g/M3FS0m3rjCYnG26Q27
        xeVdc9gsPvceYbRY2NTCbnG7cQWbA5vHmnlrGD02repk8+jbsorR4/MmuQCWqGybjNTElNQi
        hdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKDlSgpliTmlQKGAxOJi
        JX07m6L80pJUhYz84hJbpdSClJwCywK94sTc4tK8dL3k/FwrQwMDI1OgwoTsjMXr5rMUzNOs
        WLTzImsDY59SFyMnh4SAicSfQ1uYQGwhgR2MEi8+GnYxcgHZnxglbp3sYIFwvjFKdE7exgjT
        seXudWaIxF5GiZf9Z6Gc94wSiz7+YQGpEhaIlnjddBxsroiAlcTp/x3MIDazQJLE4S9XwSax
        CWhJ7H9xgw3E5hdQlLj64zFYnFfATmLe+y1g9SwCKhK3Dr4FmykqECZxclsLVI2gxMmZT8Di
        nEDz922ZwAgxX1zi1pP5TBC2vMT2t3OYIa6+zyZx6GoKhO0i8XDSChYIW1ji1fEt7BC2lMTn
        d3vZIOxqiZUnj7CBPCYh0MEosWX/BVaIhLHE/qWTgRZwAC3QlFi/Sx8irCix8/dcqBv4JN59
        7WEFKZEQ4JXoaBOCKFGWuPzgLhOELSmxuL2TbQKj0iwk38xC8sEsJB/MQli2gJFlFaNYakFx
        bnpqsWGBIXJkb2IEp0st0x2MU875HGIU4GBU4uG9YGcRJ8SaWFZcmXuIUYKDWUmEt87KNE6I
        NyWxsiq1KD++qDQntfgQoykwsCcyS4km5wNTeV5JvKGpkbGxsYWJoZmpoaGSOO/DSM04IYH0
        xJLU7NTUgtQimD4mDk6pBsbqvzlS3K6z0+oKTJgiKnrPvpv9POhYyv2ZWx5EBiceVXj+/uWC
        bsWSXceN5IQClI4KV+yUWfVGZsEJZ/WzNwJNfAt/yThsXa8cs3bqDe+z6W1mLGlva3Y/sPVa
        MqHSaOd/z3f86rXfXi8vkKsP+7Zo6rqIKTusfunOueh52dHg6W4N3el1L64osRRnJBpqMRcV
        JwIAZuKIg60DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42LZdlhJXneHgmWcwazt7BYTb1xhsTjb9Ibd
        4vKuOWwWn3uPMFosbGpht7jduILNgc1jzbw1jB6bVnWyefRtWcXo8XmTXABLFJdNSmpOZllq
        kb5dAlfG4nXzWQrmaVYs2nmRtYGxT6mLkZNDQsBEYsvd68xdjFwcQgK7GSXOLVvFApGQlJh2
        8ShQggPIFpY4fLgYouYto8SEtwfZQGqEBaIlus7OZwSxRQSsJE7/72AGsZkFkiROvrrLAtGw
        l1Hi4pFTYEPZBLQk9r+4AdbML6AocfXHY7BmXgE7iXnvt4A1swioSNw6+BasXlQgTGLnksdM
        EDWCEidnPgGLcwIt27dlAiPEMnWJP/MuQS0Wl7j1ZD4ThC0vsf3tHOYJjMKzkLTPQtIyC0nL
        LCQtCxhZVjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBMeOluYOxstL4g8xCnAwKvHw
        XrCziBNiTSwrrsw9xCjBwawkwltnZRonxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdp3rFIIYH0
        xJLU7NTUgtQimCwTB6dUA+PklB/Lvt3011saknDmSqz2hH2qs2Q5mTJDf+3fPeHs2ZrgmfvC
        555YO9v2mBPHx5khNmv1b/fIFO0La9Jb9fLEnTKRP3u3r8qyiy+ZsHLe7w2On7fJ/Oyum9TY
        WJBVrcjj/eAP1+3s5lWS/XypE5fOnh6lovLI5F3jmV/N2Y+7rdsDjAtXcDYosRRnJBpqMRcV
        JwIAvg/gi5kCAAA=
X-CMS-MailID: 20200204074352epcas1p19c4a45e8e4010bfa2c4c9c2335e3914d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200203010946epcas1p1dcf58e3d8c638341a3410e813f68e59d
References: <20200203011733.7639-1-cw00.choi@samsung.com>
        <CGME20200203010946epcas1p1dcf58e3d8c638341a3410e813f68e59d@epcas1p1.samsung.com>
        <20200203011733.7639-2-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2/3/20 10:17 AM, Chanwoo Choi wrote:
> DEVFREQ_GOV_INTERVAL event indicates that update the interval
> for polling mode of devfreq device. But, this event name doesn't
> specify exactly what to do.
> 
> Change DEVFREQ_GOV_INTERVAL event name to DEVFREQ_GOV_UPDATE_INTERVAL
> which specifies what to do by event name.
> 
> And modify the function name to DEVFREQ_GOV_UPDATE_INTERVAL
> with 'devfreq_' prefix + verb + object as following:
> - devfreq_interval_update -> devfreq_updatee_interval
> 
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
> Changes from v1:
> - Add reviewed tag of Lukasz
> - Fix typo in patch description
> 
>  drivers/devfreq/devfreq.c                 | 10 +++++-----
>  drivers/devfreq/governor.h                |  4 ++--
>  drivers/devfreq/governor_simpleondemand.c |  4 ++--
>  drivers/devfreq/tegra30-devfreq.c         |  4 ++--
>  4 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index cceee8bc3c2f..8494c5f05a73 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -550,14 +550,14 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
>  EXPORT_SYMBOL(devfreq_monitor_resume);
>  
>  /**
> - * devfreq_interval_update() - Update device devfreq monitoring interval
> + * devfreq_update_interval() - Update device devfreq monitoring interval
>   * @devfreq:    the devfreq instance.
>   * @delay:      new polling interval to be set.
>   *
>   * Helper function to set new load monitoring polling interval. Function
> - * to be called from governor in response to DEVFREQ_GOV_INTERVAL event.
> + * to be called from governor in response to DEVFREQ_GOV_UPDATE_INTERVAL event.
>   */
> -void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
> +void devfreq_update_interval(struct devfreq *devfreq, unsigned int *delay)
>  {
>  	unsigned int cur_delay = devfreq->profile->polling_ms;
>  	unsigned int new_delay = *delay;
> @@ -597,7 +597,7 @@ void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
>  out:
>  	mutex_unlock(&devfreq->lock);
>  }
> -EXPORT_SYMBOL(devfreq_interval_update);
> +EXPORT_SYMBOL(devfreq_update_interval);
>  
>  /**
>   * devfreq_notifier_call() - Notify that the device frequency requirements
> @@ -1426,7 +1426,7 @@ static ssize_t polling_interval_store(struct device *dev,
>  	if (ret != 1)
>  		return -EINVAL;
>  
> -	df->governor->event_handler(df, DEVFREQ_GOV_INTERVAL, &value);
> +	df->governor->event_handler(df, DEVFREQ_GOV_UPDATE_INTERVAL, &value);
>  	ret = count;
>  
>  	return ret;
> diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
> index 5ba3e051b1d0..c07ce77c253d 100644
> --- a/drivers/devfreq/governor.h
> +++ b/drivers/devfreq/governor.h
> @@ -18,7 +18,7 @@
>  /* Devfreq events */
>  #define DEVFREQ_GOV_START			0x1
>  #define DEVFREQ_GOV_STOP			0x2
> -#define DEVFREQ_GOV_INTERVAL			0x3
> +#define DEVFREQ_GOV_UPDATE_INTERVAL		0x3
>  #define DEVFREQ_GOV_SUSPEND			0x4
>  #define DEVFREQ_GOV_RESUME			0x5
>  
> @@ -61,7 +61,7 @@ void devfreq_monitor_start(struct devfreq *devfreq);
>  void devfreq_monitor_stop(struct devfreq *devfreq);
>  void devfreq_monitor_suspend(struct devfreq *devfreq);
>  void devfreq_monitor_resume(struct devfreq *devfreq);
> -void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay);
> +void devfreq_update_interval(struct devfreq *devfreq, unsigned int *delay);
>  
>  int devfreq_add_governor(struct devfreq_governor *governor);
>  int devfreq_remove_governor(struct devfreq_governor *governor);
> diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
> index 3d809f228619..1b314e1df028 100644
> --- a/drivers/devfreq/governor_simpleondemand.c
> +++ b/drivers/devfreq/governor_simpleondemand.c
> @@ -96,8 +96,8 @@ static int devfreq_simple_ondemand_handler(struct devfreq *devfreq,
>  		devfreq_monitor_stop(devfreq);
>  		break;
>  
> -	case DEVFREQ_GOV_INTERVAL:
> -		devfreq_interval_update(devfreq, (unsigned int *)data);
> +	case DEVFREQ_GOV_UPDATE_INTERVAL:
> +		devfreq_update_interval(devfreq, (unsigned int *)data);
>  		break;
>  
>  	case DEVFREQ_GOV_SUSPEND:
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index 0b65f89d74d5..28b2c7ca416e 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -734,7 +734,7 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
>  		devfreq_monitor_stop(devfreq);
>  		break;
>  
> -	case DEVFREQ_GOV_INTERVAL:
> +	case DEVFREQ_GOV_UPDATE_INTERVAL:
>  		/*
>  		 * ACTMON hardware supports up to 256 milliseconds for the
>  		 * sampling period.
> @@ -745,7 +745,7 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
>  		}
>  
>  		tegra_actmon_pause(tegra);
> -		devfreq_interval_update(devfreq, new_delay);
> +		devfreq_update_interval(devfreq, new_delay);
>  		ret = tegra_actmon_resume(tegra);
>  		break;
>  
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
