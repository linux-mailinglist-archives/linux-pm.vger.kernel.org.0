Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA31230D6CC
	for <lists+linux-pm@lfdr.de>; Wed,  3 Feb 2021 10:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbhBCJ4C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Feb 2021 04:56:02 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:46938 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbhBCJz5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Feb 2021 04:55:57 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210203095513epoutp02706883ccc8a4ee2e3a84c1194dc53e73~gND_AkHVE0620606206epoutp02k
        for <linux-pm@vger.kernel.org>; Wed,  3 Feb 2021 09:55:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210203095513epoutp02706883ccc8a4ee2e3a84c1194dc53e73~gND_AkHVE0620606206epoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1612346113;
        bh=sHXorTSjgyFCm+4/5nErm0A5DNcZXDiUnA+ObsFDYO4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=JXZ4Y6WK6Bcp3TD320/ATs/HEdZIJQthqX4QGFSqr0z12zX+Vx5yb/+iDKUuF8hDN
         NCav30Kda5N8nOXJADDLhaXyfQiztACByeFxLe5K8oiU41Yk1UJbsDVwLrHp45T3nd
         XsFUyJ1En1wNMyF5jabKF9Ax0o7owYWEXVVpINaQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210203095513epcas1p16b04a8155f65f43a16964a6dac66795d~gND9Slv990818008180epcas1p1V;
        Wed,  3 Feb 2021 09:55:13 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.155]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4DVxqz2lLnz4x9QC; Wed,  3 Feb
        2021 09:55:11 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A2.81.63458.FF27A106; Wed,  3 Feb 2021 18:55:11 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210203095510epcas1p44e745b922adc9ed51e142b1c5f0d859a~gND6uU2Ys3151431514epcas1p4n;
        Wed,  3 Feb 2021 09:55:10 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210203095510epsmtrp1d163fe28a9652c93768113f4be02693a~gND6tSHTx1614416144epsmtrp1J;
        Wed,  3 Feb 2021 09:55:10 +0000 (GMT)
X-AuditID: b6c32a36-6dfff7000000f7e2-c2-601a72ff5ba9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E1.1F.13470.EF27A106; Wed,  3 Feb 2021 18:55:10 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210203095510epsmtip2675fc0c0a34105beda148195a6e978f7~gND6d_L8e2068420684epsmtip2B;
        Wed,  3 Feb 2021 09:55:10 +0000 (GMT)
Subject: Re: [RFC][PATCH 1/3] PM /devfreq: add user frequency limits into
 devfreq struct
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     vireshk@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        Dietmar.Eggemann@arm.com, amitk@kernel.org, rui.zhang@intel.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <ea409e2f-f3ca-437f-d787-7ba793a2c226@samsung.com>
Date:   Wed, 3 Feb 2021 19:11:19 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20210126104001.20361-2-lukasz.luba@arm.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHJsWRmVeSWpSXmKPExsWy7bCmnu7/IqkEg90HBC0Oz6+wmPdZ1uLp
        hK3MFmeb3rBbXN41h83ic+8RRouFTS3sFrcbV7BZzP0yldniycM+NovND46xOXB7rJm3htFj
        8Z6XTB6bVnWyedy5tofNo2/LKkaPz5vkAtiism0yUhNTUosUUvOS81My89JtlbyD453jTc0M
        DHUNLS3MlRTyEnNTbZVcfAJ03TJzgK5TUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak
        5BRYFugVJ+YWl+al6yXn51oZGhgYmQIVJmRnnOw4wlhwQrdi3cdZrA2MbapdjJwcEgImEo1f
        /7N3MXJxCAnsYJRYPa2JEcL5xCjRMvUqlPONUeLF0X0sMC1nZ8+HatnLKHG0GablPaNE85dZ
        zCBVwgJREvsP7WUEsUUE4iUWHvoA1sEssA+oo202K0iCTUBLYv+LG2wgNr+AosTVH4+BGjg4
        eAXsJHoX2IKEWQRUJGbN+ANWLioQJnFyWwvYTF4BQYmTM5+wgJRzClhKHFkKFmYWEJe49WQ+
        E4QtL7H97RxmiKP3cEgsvSoGYbtIzP9xnx3CFpZ4dXwLlC0l8bK/Dcqullh58ggbyMkSAh2M
        Elv2X2CFSBhL7F86mQlkL7OApsT6XfoQYUWJnb/nQt3AJ/Huaw8rSImEAK9ER5sQRImyxOUH
        d5kgbEmJxe2dbBMYlWYheWYWkg9mIflgFsKyBYwsqxjFUguKc9NTiw0LjJAjexMjOOFqme1g
        nPT2g94hRiYOxkOMEhzMSiK8pyaJJQjxpiRWVqUW5ccXleakFh9iNAUG70RmKdHkfGDKzyuJ
        NzQ1MjY2tjAxNDM1NFQS5000eBAvJJCeWJKanZpakFoE08fEwSnVwGSs0+TN9HeCadP+uK3X
        v82++vTY99apvF/n+71K8r67aN1jnv7NhVsjmefPPnDsftu0e1dqJC49lRK7Z+5c/7Dh1bNn
        TcKZt9e3fNDpXFi9Irco5Xdd2q6L8oaHHHb/TZ5zX3cu8/+lCbddl3ZsXjfv1ZWoqPeX54ub
        77xf4v477Xm9dmJCLWvujVj5xGemHYczg6+p7i3U7Y+pCvG0LLK+uePTi4evOWe8npvzrVDI
        7bjQRoUyhckHBBaI3jjI0yUfYn5us+nDkLUJXy5sn93a4ak9f64Xb73P1ZT1BTUrDZtNIp8G
        31y8YcJehUmKaVFzg+bM4FvlPlnejUF5W4eL1kmJ7Qv6Pxf8lXXTstuixFKckWioxVxUnAgA
        MpERgEEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsWy7bCSvO6/IqkEg717hCwOz6+wmPdZ1uLp
        hK3MFmeb3rBbXN41h83ic+8RRouFTS3sFrcbV7BZzP0yldniycM+NovND46xOXB7rJm3htFj
        8Z6XTB6bVnWyedy5tofNo2/LKkaPz5vkAtiiuGxSUnMyy1KL9O0SuDJOdhxhLDihW7Hu4yzW
        BsY21S5GTg4JAROJs7Pns3cxcnEICexmlPh4eB4rREJSYtrFo8xdjBxAtrDE4cPFEDVvGSVW
        LGxgBqkRFoiS2H9oLyOILSIQLzHhwXV2EJtZYB+jxMLFFnBDz7xczwSSYBPQktj/4gYbiM0v
        oChx9cdjRpAFvAJ2Er0LbEHCLAIqErNm/AG7QVQgTGLnksdgrbwCghInZz5hASnnFLCUOLKU
        EWKVusSfeZeYIWxxiVtP5jNB2PIS29/OYZ7AKDwLSfcsJC2zkLTMQtKygJFlFaNkakFxbnpu
        sWGBYV5quV5xYm5xaV66XnJ+7iZGcORpae5g3L7qg94hRiYOxkOMEhzMSiK8pyaJJQjxpiRW
        VqUW5ccXleakFh9ilOZgURLnvdB1Ml5IID2xJDU7NbUgtQgmy8TBKdXAJHmU3c3u3/eHrJ9e
        xd8JfP3zgR//Za7jkUoF6ou0NKb+WmcZHultaTR9k+6VjX/fC8dryaWuaWW32raiZunKp7XH
        f62bPL9+peLT+KznDQcM7LVCgluNRDe7fmZ/bzQl47Av38J5ooszxDrOHG258pS7LPNmcE+D
        /jTNIwnqb90qLeayqS+s3BqmaVB175XFNO+kjJA9nnpnst6Y7XrSWRXXrPXSSntVufzdfayz
        dIT2ThG9e1N2SYKaz5MPk9dWMl+qOr9039ZFvYwuj5aEhoQcErxSOUNRzsY063iR4oUPVw9d
        bA419MqOLdGYr5M+kePm9apfHhPfc4h0WF5Jr7grMPkN35oXPsvnz+ucrcRSnJFoqMVcVJwI
        ADZKZ/ErAwAA
X-CMS-MailID: 20210203095510epcas1p44e745b922adc9ed51e142b1c5f0d859a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210126104217epcas1p349c717ccf0ea4f964153040b48c72352
References: <20210126104001.20361-1-lukasz.luba@arm.com>
        <CGME20210126104217epcas1p349c717ccf0ea4f964153040b48c72352@epcas1p3.samsung.com>
        <20210126104001.20361-2-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lukasz,

When accessing the max_freq and min_freq at devfreq-cooling.c,
even if can access 'user_max_freq' and 'lock' by using the 'devfreq' instance,
I think that the direct access of variables (lock/user_max_freq/user_min_freq)
of struct devfreq are not good.

Instead, how about using the 'DEVFREQ_TRANSITION_NOTIFIER'
notification with following changes of 'struct devfreq_freq'?
Also, need to add codes into devfreq_set_target() for initializing
'new_max_freq' and 'new_min_freq' before sending the DEVFREQ_POSTCHANGE
notification.

diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 147a229056d2..d5726592d362 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -207,6 +207,8 @@ struct devfreq {
 struct devfreq_freqs {
        unsigned long old;
        unsigned long new;
+       unsigned long new_max_freq;
+       unsigned long new_min_freq;
 };


And I think that new 'user_min_freq'/'user_max_freq' are not necessary.
You can get the current max_freq/min_freq by using the following steps:

	get_freq_range(devfreq, &min_freq, &max_freq);
	dev_pm_opp_find_freq_floor(pdev, &min_freq);
	dev_pm_opp_find_freq_floor(pdev, &max_freq);

So that you can get the 'max_freq/min_freq' and then
initialize the 'freqs.new_max_freq and freqs.new_min_freq'
with them as following:

in devfreq_set_target()
	get_freq_range(devfreq, &min_freq, &max_freq);
	dev_pm_opp_find_freq_floor(pdev, &min_freq);
	dev_pm_opp_find_freq_floor(pdev, &max_freq);
	freqs.new_max_freq = min_freq;
	freqs.new_max_freq = max_freq;
	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);


On 1/26/21 7:39 PM, Lukasz Luba wrote:
> The new fields inside devfreq struct allow to check the frequency limits
> set by the user via sysfs. These limits are important for thermal governor
> Intelligent Power Allocation (IPA) which needs to know the maximum allowed
> power consumption of the device.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/devfreq/devfreq.c | 41 +++++++++++++++++++++++++++++++++++----
>  include/linux/devfreq.h   |  4 ++++
>  2 files changed, 41 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 94cc25fd68da..e985a76e5ff3 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -843,6 +843,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  		goto err_dev;
>  	}
>  
> +	devfreq->user_min_freq = devfreq->scaling_min_freq;
> +	devfreq->user_max_freq = devfreq->scaling_max_freq;
> +
>  	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
>  	atomic_set(&devfreq->suspend_count, 0);
>  
> @@ -1513,6 +1516,8 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
>  			      const char *buf, size_t count)
>  {
>  	struct devfreq *df = to_devfreq(dev);
> +	struct device *pdev = df->dev.parent;
> +	struct dev_pm_opp *opp;
>  	unsigned long value;
>  	int ret;
>  
> @@ -1533,6 +1538,19 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
>  	if (ret < 0)
>  		return ret;
>  
> +	if (!value)
> +		value = df->scaling_min_freq;
> +
> +	opp = dev_pm_opp_find_freq_ceil(pdev, &value);
> +	if (IS_ERR(opp))
> +		return count;
> +
> +	dev_pm_opp_put(opp);
> +
> +	mutex_lock(&df->lock);
> +	df->user_min_freq = value;
> +	mutex_unlock(&df->lock);
> +
>  	return count;
>  }
>  
> @@ -1554,7 +1572,9 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
>  			      const char *buf, size_t count)
>  {
>  	struct devfreq *df = to_devfreq(dev);
> -	unsigned long value;
> +	struct device *pdev = df->dev.parent;
> +	unsigned long value, value_khz;
> +	struct dev_pm_opp *opp;
>  	int ret;
>  
>  	/*
> @@ -1579,14 +1599,27 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
>  	 * A value of zero means "no limit".
>  	 */
>  	if (value)
> -		value = DIV_ROUND_UP(value, HZ_PER_KHZ);
> +		value_khz = DIV_ROUND_UP(value, HZ_PER_KHZ);
>  	else
> -		value = PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE;
> +		value_khz = PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE;
>  
> -	ret = dev_pm_qos_update_request(&df->user_max_freq_req, value);
> +	ret = dev_pm_qos_update_request(&df->user_max_freq_req, value_khz);
>  	if (ret < 0)
>  		return ret;
>  
> +	if (!value)
> +		value = df->scaling_max_freq;
> +
> +	opp = dev_pm_opp_find_freq_floor(pdev, &value);
> +	if (IS_ERR(opp))
> +		return count;
> +
> +	dev_pm_opp_put(opp);
> +
> +	mutex_lock(&df->lock);
> +	df->user_max_freq = value;
> +	mutex_unlock(&df->lock);
> +
>  	return count;
>  }
>  
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index b6d3bae1c74d..147a229056d2 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -147,6 +147,8 @@ struct devfreq_stats {
>   *		touch this.
>   * @user_min_freq_req:	PM QoS minimum frequency request from user (via sysfs)
>   * @user_max_freq_req:	PM QoS maximum frequency request from user (via sysfs)
> + * @user_min_freq:	User's minimum frequency
> + * @user_max_freq:	User's maximum frequency
>   * @scaling_min_freq:	Limit minimum frequency requested by OPP interface
>   * @scaling_max_freq:	Limit maximum frequency requested by OPP interface
>   * @stop_polling:	 devfreq polling status of a device.
> @@ -185,6 +187,8 @@ struct devfreq {
>  	struct dev_pm_qos_request user_max_freq_req;
>  	unsigned long scaling_min_freq;
>  	unsigned long scaling_max_freq;
> +	unsigned long user_min_freq;
> +	unsigned long user_max_freq;
>  	bool stop_polling;
>  
>  	unsigned long suspend_freq;
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
