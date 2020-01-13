Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80E1B138C47
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2020 08:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbgAMHYS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jan 2020 02:24:18 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:17267 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbgAMHYS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jan 2020 02:24:18 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200113072416epoutp0212b6f6071990c34dd216f37e194d745f~pYWrn6uxU2024920249epoutp021
        for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2020 07:24:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200113072416epoutp0212b6f6071990c34dd216f37e194d745f~pYWrn6uxU2024920249epoutp021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578900256;
        bh=mKkCNEw53noy6Xok6B1I9aGQSGiwVBHGf8BaRhxoex8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=WUmbC7NkylrtDorKFm91l42Wi470dzLu0AgxxrI8ifq15kJBSyEJYLa837t385yq7
         OdEh7ISjOfrhuH7jNtpm89qO/0nb1YsUMqmZSWkuS2GuuuZQtkFOnx+R9/9aA3lU4W
         k3HTodCwtP2ukkwK6s+XaH8d+XtCZjh0jpQAwZSs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200113072415epcas1p36d95d1150b7a95f424212c042458d0b9~pYWrL0EhH1997319973epcas1p3F;
        Mon, 13 Jan 2020 07:24:15 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.153]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47x4pP3JXJzMqYkr; Mon, 13 Jan
        2020 07:24:13 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        43.2D.57028.B1B1C1E5; Mon, 13 Jan 2020 16:24:11 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200113072410epcas1p465a60b58e4cab7a6e8c977128b743d0b~pYWmRrniX0741307413epcas1p4s;
        Mon, 13 Jan 2020 07:24:10 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200113072410epsmtrp178497ab1e6f00494ed7e89f7bb916e74~pYWmQ4OiA2006920069epsmtrp1X;
        Mon, 13 Jan 2020 07:24:10 +0000 (GMT)
X-AuditID: b6c32a35-4f3ff7000001dec4-41-5e1c1b1ade6d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DD.0C.06569.A1B1C1E5; Mon, 13 Jan 2020 16:24:10 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200113072410epsmtip132931acebb404c008a9575a233c6de1b~pYWmFSgqL1933119331epsmtip1X;
        Mon, 13 Jan 2020 07:24:10 +0000 (GMT)
Subject: Re: [PATCH 2/2] PM / devfreq: Use exclusively PM QoS to determine
 frequency limits
To:     Matthias Kaehlcke <mka@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>
Cc:     Leonard Crestez <leonard.crestez@nxp.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <c793c2e5-dd0e-bff4-9769-26344afe914e@samsung.com>
Date:   Mon, 13 Jan 2020 16:31:26 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200110094913.2.Ie8eacf976ce7a13e421592f5c1ab8dbdc537da5c@changeid>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te2xLcRTOr4/bW1GuGju6se4uJBabXlu5ExOxoTF/zCMI0brpbrpaX+nt
        MIISZltQMhK6eWxjbIRZtplltLYiJYZgkXmErOIRI7aMeQS3vRX77zvnfOd85/s9cLGyFVPh
        ZpuLddoYC4mNkLR0TtWkxMXF6zXBGzj9reu7iD4xMJG+t+ujjD734ouUftRWidED+wOIHmjo
        RfSznecwOvT6ADZPrqtwP5Toatrfi3TPu9sx3eVPrSLdgaZ6pCu5XaQbaJyUK1tTMCefZfJY
        p5q1Ge15Zpspk8xZbsgyaGdqqBQqg55Fqm2Mlc0ks5fkpiw0W/jFSPVGxlLIp3IZjiOnz53j
        tBe6WHW+nXNlkqwjz+LIcKRyjJUrtJlSjXbrbEqjmaHliesL8h//7hY7yqdtDt3rk7rRk6Qy
        JMeBSIf7nmZJGCuJVgR73GvL0Age9yO47m+QCMFXBEHfbtm/jjdVgzKhcA1BcV8ACcFnBKVt
        XnGYNZZYB57a3ggrhvjFz/38O1IQEya41fkjMgojksH37ikWxqOJRHgy1IvCWEHMhYuBzghH
        QkyG/uZAJD+OWAnBlt1RzhgIHgtFFpcTy6DXWy0R5sdCT+ikSMAJcKWvUhxeAoi9MujvqRUJ
        HrKhr+VOFI+FD7ebot5U8N5THMVboS4YwITmEgRNvgdSoZAGvjPlfDPOK0yFS23ThXQiXP15
        HAnCo+DT4D5pmAKEAkqKlQIlCR69ehGVnQA1e0uxg4j0DrPjHWbBO8yC97/YKSSpR+NZB2c1
        sRzloIZfdyOKvNpkbSs63LWkAxE4Ikcq/Fvi9Eops5ErsnYgwMVkjKKxS6VXKvKYoi2s025w
        FlpYrgNp+dM+JFaNM9r5P2BzGSjtjLS0NDqdmqmlKDJWgQ89XKckTIyLLWBZB+v81yfC5So3
        8nSnxkxcEJ+7zbqq33aq/emz6qxpzffv1HfZE5r0fn/t6pEJyxe9zTl5oezuHzhhlJf3uH1V
        DQxz4bJ+MKvyTCxz8/zpbE1MxssWQ6L5JbNjQ3eVJT1EViOzNedsxZHSTc4VRfN/LF46aafH
        G6/ebjxagobqlk2pO7zKE0zZ7LeSEi6foZLFTo75C2yT6dTLAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsWy7bCSnK6UtEycwYMjwhbfz/1kspj3Wdbi
        bNMbdosVdz+yWlzeNYfN4nPvEUaLzxseM1rcblzBZvHkYR+bA6fH7IaLLB6L97xk8rhzbQ+b
        x8Z3O5g8+rasYvToOF7p8XmTXAB7FJdNSmpOZllqkb5dAlfGlX/XmAsm61Q8OfuWtYHxqnIX
        IyeHhICJxNOFX9m7GLk4hAR2M0os773HCJGQlJh28ShzFyMHkC0scfhwMUTNW0aJlQv3M4PU
        CAvESvQvewzWLCLwj1Gi+eYWNpAEs0C6xPN1B5nhOlrndzOBJNgEtCT2v7gBVsQvoChx9cdj
        sG28AnYS644cZgexWQRUJT5tPQIWFxUIk9i55DETRI2gxMmZT1hAbE6BIInHsxaxQCxTl/gz
        7xIzhC0ucevJfCYIW15i+9s5zBMYhWchaZ+FpGUWkpZZSFoWMLKsYpRMLSjOTc8tNiwwykst
        1ytOzC0uzUvXS87P3cQIjjotrR2MJ07EH2IU4GBU4uE9UCUdJ8SaWFZcmXuIUYKDWUmEd9M5
        qTgh3pTEyqrUovz4otKc1OJDjNIcLErivPL5xyKFBNITS1KzU1MLUotgskwcnFINjFOcuL4K
        PRG+/GZ7BL8F419H2ej1166UBkmsytzmcKJr4ZWHJssmzrSscJi+/oTMwkZ57o+FWiZzJnwT
        VKjSuPmxqP1R2F6ufR8EKuLZ9VyO7maRFn/SFfttNc+CJJcdPWEVoX+dtxdcnPvIXfv8K1FV
        jn0/jkRUJ24revtadndAApfKpZLgKCWW4oxEQy3mouJEAA9fP7e2AgAA
X-CMS-MailID: 20200113072410epcas1p465a60b58e4cab7a6e8c977128b743d0b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200110174932epcas1p345b0e750b48cc9e351dca14e0dd4de86
References: <20200110094913.1.I146403d05b9ec82f48b807efd416a57f545b447a@changeid>
        <CGME20200110174932epcas1p345b0e750b48cc9e351dca14e0dd4de86@epcas1p3.samsung.com>
        <20200110094913.2.Ie8eacf976ce7a13e421592f5c1ab8dbdc537da5c@changeid>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,


Any device driver except for devfreq_cooling.c might
use dev_pm_opp_enable/disable interface. 
So, don't need to remove the devfreq->scaling_max_freq
and devfreq->scaling_min_freq for supporting OPP interface.

Regards,
Chanwoo Choi

On 1/11/20 2:49 AM, Matthias Kaehlcke wrote:
> Traditionally devfreq cooling devices dynamically disabled OPPs
> that shouldn't be used because of thermal pressure. Devfreq cooling
> devices now use PM QoS to set frequency limits, hence the devfreq
> code dealing that deals with disabled OPPs can be removed.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> 
>  drivers/devfreq/devfreq.c | 75 +++++----------------------------------
>  include/linux/devfreq.h   |  4 ---
>  2 files changed, 8 insertions(+), 71 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 57f6944d65a6..ec66e2c27cc4 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -73,34 +73,6 @@ static struct devfreq *find_device_devfreq(struct device *dev)
>  	return ERR_PTR(-ENODEV);
>  }
>  
> -static unsigned long find_available_min_freq(struct devfreq *devfreq)
> -{
> -	struct dev_pm_opp *opp;
> -	unsigned long min_freq = 0;
> -
> -	opp = dev_pm_opp_find_freq_ceil(devfreq->dev.parent, &min_freq);
> -	if (IS_ERR(opp))
> -		min_freq = 0;
> -	else
> -		dev_pm_opp_put(opp);
> -
> -	return min_freq;
> -}
> -
> -static unsigned long find_available_max_freq(struct devfreq *devfreq)
> -{
> -	struct dev_pm_opp *opp;
> -	unsigned long max_freq = ULONG_MAX;
> -
> -	opp = dev_pm_opp_find_freq_floor(devfreq->dev.parent, &max_freq);
> -	if (IS_ERR(opp))
> -		max_freq = 0;
> -	else
> -		dev_pm_opp_put(opp);
> -
> -	return max_freq;
> -}
> -
>  /**
>   * get_freq_range() - Get the current freq range
>   * @devfreq:	the devfreq instance
> @@ -141,10 +113,6 @@ static void get_freq_range(struct devfreq *devfreq,
>  		*max_freq = min(*max_freq,
>  				(unsigned long)HZ_PER_KHZ * qos_max_freq);
>  
> -	/* Apply constraints from OPP interface */
> -	*min_freq = max(*min_freq, devfreq->scaling_min_freq);
> -	*max_freq = min(*max_freq, devfreq->scaling_max_freq);
> -
>  	if (*min_freq > *max_freq)
>  		*min_freq = *max_freq;
>  }
> @@ -610,23 +578,10 @@ static int devfreq_notifier_call(struct notifier_block *nb, unsigned long type,
>  				 void *devp)
>  {
>  	struct devfreq *devfreq = container_of(nb, struct devfreq, nb);
> -	int err = -EINVAL;
> +	int err;
>  
>  	mutex_lock(&devfreq->lock);
> -
> -	devfreq->scaling_min_freq = find_available_min_freq(devfreq);
> -	if (!devfreq->scaling_min_freq)
> -		goto out;
> -
> -	devfreq->scaling_max_freq = find_available_max_freq(devfreq);
> -	if (!devfreq->scaling_max_freq) {
> -		devfreq->scaling_max_freq = ULONG_MAX;
> -		goto out;
> -	}
> -
>  	err = update_devfreq(devfreq);
> -
> -out:
>  	mutex_unlock(&devfreq->lock);
>  	if (err)
>  		dev_err(devfreq->dev.parent,
> @@ -781,19 +736,15 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  		mutex_lock(&devfreq->lock);
>  	}
>  
> -	devfreq->scaling_min_freq = find_available_min_freq(devfreq);
> -	if (!devfreq->scaling_min_freq) {
> -		mutex_unlock(&devfreq->lock);
> -		err = -EINVAL;
> +	err = dev_pm_qos_add_request(dev, &devfreq->user_min_freq_req,
> +				     DEV_PM_QOS_MIN_FREQUENCY, 0);
> +	if (err < 0)
>  		goto err_dev;
> -	}
> -
> -	devfreq->scaling_max_freq = find_available_max_freq(devfreq);
> -	if (!devfreq->scaling_max_freq) {
> -		mutex_unlock(&devfreq->lock);
> -		err = -EINVAL;
> +	err = dev_pm_qos_add_request(dev, &devfreq->user_max_freq_req,
> +				     DEV_PM_QOS_MAX_FREQUENCY,
> +				     PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE);
> +	if (err < 0)
>  		goto err_dev;
> -	}
>  
>  	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
>  	atomic_set(&devfreq->suspend_count, 0);
> @@ -834,16 +785,6 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  
>  	mutex_unlock(&devfreq->lock);
>  
> -	err = dev_pm_qos_add_request(dev, &devfreq->user_min_freq_req,
> -				     DEV_PM_QOS_MIN_FREQUENCY, 0);
> -	if (err < 0)
> -		goto err_devfreq;
> -	err = dev_pm_qos_add_request(dev, &devfreq->user_max_freq_req,
> -				     DEV_PM_QOS_MAX_FREQUENCY,
> -				     PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE);
> -	if (err < 0)
> -		goto err_devfreq;
> -
>  	devfreq->nb_min.notifier_call = qos_min_notifier_call;
>  	err = dev_pm_qos_add_notifier(devfreq->dev.parent, &devfreq->nb_min,
>  				      DEV_PM_QOS_MIN_FREQUENCY);
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index fb376b5b7281..cb75f23ad2f4 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -126,8 +126,6 @@ struct devfreq_dev_profile {
>   *		touch this.
>   * @user_min_freq_req:	PM QoS minimum frequency request from user (via sysfs)
>   * @user_max_freq_req:	PM QoS maximum frequency request from user (via sysfs)
> - * @scaling_min_freq:	Limit minimum frequency requested by OPP interface
> - * @scaling_max_freq:	Limit maximum frequency requested by OPP interface
>   * @stop_polling:	 devfreq polling status of a device.
>   * @suspend_freq:	 frequency of a device set during suspend phase.
>   * @resume_freq:	 frequency of a device set in resume phase.
> @@ -166,8 +164,6 @@ struct devfreq {
>  
>  	struct dev_pm_qos_request user_min_freq_req;
>  	struct dev_pm_qos_request user_max_freq_req;
> -	unsigned long scaling_min_freq;
> -	unsigned long scaling_max_freq;
>  	bool stop_polling;
>  
>  	unsigned long suspend_freq;
> 
