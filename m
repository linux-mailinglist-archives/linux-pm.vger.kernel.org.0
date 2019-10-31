Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0134EA967
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 04:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfJaDFY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 23:05:24 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:23060 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfJaDFX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2019 23:05:23 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191031030518epoutp03387d44b001f125ef74b1b39c27a81ccb~SnFdBPyHD2350723507epoutp03f
        for <linux-pm@vger.kernel.org>; Thu, 31 Oct 2019 03:05:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191031030518epoutp03387d44b001f125ef74b1b39c27a81ccb~SnFdBPyHD2350723507epoutp03f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1572491118;
        bh=4pJYfAQIOHvZ/EwGHd79+fMQuHEO2zbx2yBIhPMLpno=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=WpR7+bT4eiAVhzmKtOYkFXbV6sYxj+WmOmnMufm5Hfc6FdOECPcmWhwo9yiDbJ1q8
         zECxAZpeK58GWrx6+NLq3VT2rHtic6FCTth/lBoisMNsAzHFm+zM2+QkknECokcXzO
         B92zO0uu4cjoGNu06FusvFaH6Fffpe2EcUqwPJO4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191031030517epcas1p37352d7c9e84c543705ed98cc6da73250~SnFcWYs8s2768927689epcas1p3S;
        Thu, 31 Oct 2019 03:05:17 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.152]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 473VYl4DcDzMqYlh; Thu, 31 Oct
        2019 03:05:15 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        36.AE.04085.B6F4ABD5; Thu, 31 Oct 2019 12:05:15 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191031030515epcas1p115f0adeafdfaddbc089878e9c496906f~SnFaC86wT1568715687epcas1p17;
        Thu, 31 Oct 2019 03:05:15 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191031030515epsmtrp26a5798310c6bd67ea2a1cda13223b435~SnFaCCIx91561315613epsmtrp2D;
        Thu, 31 Oct 2019 03:05:15 +0000 (GMT)
X-AuditID: b6c32a37-e31ff70000000ff5-7c-5dba4f6b97b1
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6C.BD.25663.B6F4ABD5; Thu, 31 Oct 2019 12:05:15 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191031030514epsmtip1430ccb11724718607308c9e023b90f45~SnFZoDOcn1578615786epsmtip1y;
        Thu, 31 Oct 2019 03:05:14 +0000 (GMT)
Subject: Re: [PATCH v9 8/8] PM / devfreq: Use PM QoS for sysfs min/max_freq
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <e96ab4af-68ad-ac0e-9671-2df62a21dbf4@samsung.com>
Date:   Thu, 31 Oct 2019 12:10:47 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <62584a1e5c08d0f9254df505883fb220ba53d57b.1570044052.git.leonard.crestez@nxp.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOJsWRmVeSWpSXmKPExsWy7bCmnm62/65Yg0vHlSwOHdvKbvH19ClG
        i2WXjjJaTN+7ic3i/PkN7BZnm96wW9xqkLFYcfcjq8Wmx9dYLbp+rWS2+Nx7hNHi84bHjBa3
        G1ewWaw+d5DNouvQXzaLjV89HAQ83t9oZfeY3XCRxWPBplKPTas62TzuXNvD5rF5Sb3Hxnc7
        mDwOvtvD5NG3ZRWjx+dNcgFcUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koK
        eYm5qbZKLj4Bum6ZOUCPKCmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKLAv0ihNz
        i0vz0vWS83OtDA0MjEyBChOyM3p62tgLHjhXfF3wiq2B8YxZFyMnh4SAicTqtWdZuxi5OIQE
        djBKHH58iR3C+cQosXf/axYI5xujxLdZTUBlHGAtOx94QcT3Mkrc3tgOVfSeUeLKrEksIHOF
        BbwlOj73MYHYIgJ1ErcWn2AGKWIWmMgi8f9XF1gRm4CWxP4XN9hAbH4BRYmrPx4zgti8AnYS
        M1/PA4uzCKhKdCx/wg6yWVQgQuL010SIEkGJkzOfgI3hFIiTaDryGsxmFhCXuPVkPhOELS/R
        vHU22F4JgUvsEkfXd7BCPO0iMa35DDuELSzx6vgWKFtK4vO7vWwQdrXEypNH2CCaOxgltuy/
        ANVsLLF/6WQmkIOYBTQl1u/ShwgrSuz8PZcRYjGfxLuvPdDQ4pXoaBOCKFGWuPzgLhOELSmx
        uL2TbQKj0iwk78xC8sIsJC/MQli2gJFlFaNYakFxbnpqsWGBMXJsb2IEJ3It8x2MG875HGIU
        4GBU4uGdULYzVog1say4MvcQowQHs5II7zcboBBvSmJlVWpRfnxRaU5q8SFGU2BgT2SWEk3O
        B2aZvJJ4Q1MjY2NjCxNDM1NDQyVxXsflS2OFBNITS1KzU1MLUotg+pg4OKUaGKv4z59YbRx9
        XMVDz7GsNrtEs0kwe7JWyuzyw3IVRmrqqqnTKy4s7DL61n6098uE71WrX/0XmCU17f5Bn00h
        TSZCK6tfChzyN18e/nhNx2QzKbvtG/rvbM9ct/U+11OZlhNbrT5csmcWV/fgtt1SKtboqnvd
        g7klds190+nxs1dYZE54eLHcQImlOCPRUIu5qDgRACJikb/6AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsWy7bCSnG62/65Yg+bn3BaHjm1lt/h6+hSj
        xbJLRxktpu/dxGZx/vwGdouzTW/YLW41yFisuPuR1WLT42usFl2/VjJbfO49wmjxecNjRovb
        jSvYLFafO8hm0XXoL5vFxq8eDgIe72+0snvMbrjI4rFgU6nHplWdbB53ru1h89i8pN5j47sd
        TB4H3+1h8ujbsorR4/MmuQCuKC6blNSczLLUIn27BK6Mnp429oIHzhVfF7xia2A8Y9bFyMEh
        IWAisfOBVxcjF4eQwG5Gib33vrF1MXICxSUlpl08ygxRIyxx+HAxRM1bRokJMyaygtQIC3hL
        dHzuYwKxRQTqJP4838cEUsQsMJlF4uDRfYwQHY8YJV61PAKrYhPQktj/4gbYBn4BRYmrPx4z
        gti8AnYSM1/PA4uzCKhKdCx/wg5iiwpESDzffgOqRlDi5MwnLCA2p0CcRNOR12A2s4C6xJ95
        l5ghbHGJW0/mM0HY8hLNW2czT2AUnoWkfRaSlllIWmYhaVnAyLKKUTK1oDg3PbfYsMAoL7Vc
        rzgxt7g0L10vOT93EyM4prW0djCeOBF/iFGAg1GJh3dC2c5YIdbEsuLK3EOMEhzMSiK832yA
        QrwpiZVVqUX58UWlOanFhxilOViUxHnl849FCgmkJ5akZqemFqQWwWSZODilGhjTZKQF/L+e
        uTZj/Za1t4p+OBWe82I5upJR50HM8brJh1yXR513O/p56nPWmr+Jpc7bpv44tGpx0b/Xv/yX
        P9o9Qc5wO3fW7QO39sm2C6npfIprdX1+V6MgXs/f52D8kgMvXHfc+rW+QqVb3L1zxcXHSpKf
        3wQJGr7f8+2KzLbXpWen6QZ9EV7frMRSnJFoqMVcVJwIACE4LRblAgAA
X-CMS-MailID: 20191031030515epcas1p115f0adeafdfaddbc089878e9c496906f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191002192528epcas3p2e546b4081abb8cadaf80bd811d5d3e8c
References: <cover.1570044052.git.leonard.crestez@nxp.com>
        <CGME20191002192528epcas3p2e546b4081abb8cadaf80bd811d5d3e8c@epcas3p2.samsung.com>
        <62584a1e5c08d0f9254df505883fb220ba53d57b.1570044052.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Leonard,

It looks good to me. Thanks for your effort.
But, I have one minor comment related to 'over 80 char'.

Please edit this line as following in order to prevent the 'over 80 char'

	dev_warn(dev->parent,
		"Failed to remove DEV_PM_QOS_MAX_FREQUENCY request: %d\n", err);

	dev_warn(dev->parent,
		"Failed to remove DEV_PM_QOS_MIN_FREQUENCY request: %d\n", err);


If you edit them, feel free to add my reviewed-by tag:

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

On 19. 10. 3. 오전 4:25, Leonard Crestez wrote:
> Switch the handling of min_freq and max_freq from sysfs to use the
> dev_pm_qos_request interface.
> 
> Since PM QoS handles frequencies as kHz this change reduces the
> precision of min_freq and max_freq. This shouldn't introduce problems
> because frequencies which are not an integer number of kHz are likely
> not an integer number of Hz either.
> 
> Try to ensure compatibility by rounding min values down and rounding
> max values up.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/devfreq/devfreq.c | 63 ++++++++++++++++++++++++++++-----------
>  include/linux/devfreq.h   |  9 +++---
>  2 files changed, 51 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 46f699b84a22..4ff5fbc4ee85 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -139,14 +139,10 @@ static void get_freq_range(struct devfreq *devfreq,
>  	*min_freq = max(*min_freq, (unsigned long)HZ_PER_KHZ * qos_min_freq);
>  	if (qos_max_freq != PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE)
>  		*max_freq = min(*max_freq,
>  				(unsigned long)HZ_PER_KHZ * qos_max_freq);
>  
> -	/* Apply constraints from sysfs */
> -	*min_freq = max(*min_freq, devfreq->min_freq);
> -	*max_freq = min(*max_freq, devfreq->max_freq);
> -
>  	/* Apply constraints from OPP interface */
>  	*min_freq = max(*min_freq, devfreq->scaling_min_freq);
>  	/* scaling_max_freq can be zero on error */
>  	if (devfreq->scaling_max_freq)
>  		*max_freq = min(*max_freq, devfreq->scaling_max_freq);
> @@ -690,10 +686,18 @@ static void devfreq_dev_release(struct device *dev)
>  			 err);
>  
>  	if (devfreq->profile->exit)
>  		devfreq->profile->exit(devfreq->dev.parent);
>  
> +	err = dev_pm_qos_remove_request(&devfreq->user_max_freq_req);
> +	if (err)
> +		dev_warn(dev->parent, "Failed to remove DEV_PM_QOS_MAX_FREQUENCY request: %d\n",
> +			 err);

Please edit this line as following in order to prevent the 'over 80 char'

		dev_warn(dev->parent,
			"Failed to remove DEV_PM_QOS_MAX_FREQUENCY request: %d\n", err);

> +	err = dev_pm_qos_remove_request(&devfreq->user_min_freq_req);
> +	if (err)
> +		dev_warn(dev->parent, "Failed to remove DEV_PM_QOS_MIN_FREQUENCY request: %d\n",
> +			 err);

ditto. Please edit this line as following:
		dev_warn(dev->parent,
			"Failed to remove DEV_PM_QOS_MIN_FREQUENCY request: %d\n", err);

>  	kfree(devfreq->time_in_state);
>  	kfree(devfreq->trans_table);
>  	mutex_destroy(&devfreq->lock);
>  	kfree(devfreq);
>  }
> @@ -758,18 +762,26 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	devfreq->scaling_min_freq = find_available_min_freq(devfreq);
>  	if (!devfreq->scaling_min_freq) {
>  		err = -EINVAL;
>  		goto err_dev;
>  	}
> -	devfreq->min_freq = devfreq->scaling_min_freq;
>  
>  	devfreq->scaling_max_freq = find_available_max_freq(devfreq);
>  	if (!devfreq->scaling_max_freq) {
>  		err = -EINVAL;
>  		goto err_dev;
>  	}
> -	devfreq->max_freq = devfreq->scaling_max_freq;
> +
> +	err = dev_pm_qos_add_request(dev, &devfreq->user_min_freq_req,
> +				     DEV_PM_QOS_MIN_FREQUENCY, 0);
> +	if (err < 0)
> +		goto err_dev;
> +	err = dev_pm_qos_add_request(dev, &devfreq->user_max_freq_req,
> +				     DEV_PM_QOS_MAX_FREQUENCY,
> +				     PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE);
> +	if (err < 0)
> +		goto err_dev;
>  
>  	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
>  	atomic_set(&devfreq->suspend_count, 0);
>  
>  	devfreq->trans_table = kzalloc(
> @@ -848,10 +860,16 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  err_dev:
>  	/*
>  	 * Cleanup path for errors that happen before registration.
>  	 * Otherwise we rely on devfreq_dev_release.
>  	 */
> +	if (dev_pm_qos_request_active(&devfreq->user_max_freq_req))
> +		if (dev_pm_qos_remove_request(&devfreq->user_max_freq_req))
> +			dev_warn(dev, "Failed to remove DEV_PM_QOS_MAX_FREQUENCY request\n");
> +	if (dev_pm_qos_request_active(&devfreq->user_min_freq_req))
> +		if (dev_pm_qos_remove_request(&devfreq->user_min_freq_req))
> +			dev_warn(dev, "Failed to remove DEV_PM_QOS_MIN_FREQUENCY request\n");
>  	kfree(devfreq->time_in_state);
>  	kfree(devfreq->trans_table);
>  	kfree(devfreq);
>  err_out:
>  	return ERR_PTR(err);
> @@ -1392,14 +1410,15 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
>  
>  	ret = sscanf(buf, "%lu", &value);
>  	if (ret != 1)
>  		return -EINVAL;
>  
> -	mutex_lock(&df->lock);
> -	df->min_freq = value;
> -	update_devfreq(df);
> -	mutex_unlock(&df->lock);
> +	/* Round down to kHz for PM QoS */
> +	ret = dev_pm_qos_update_request(&df->user_min_freq_req,
> +					value / HZ_PER_KHZ);
> +	if (ret < 0)
> +		return ret;
>  
>  	return count;
>  }
>  
>  static ssize_t min_freq_show(struct device *dev, struct device_attribute *attr,
> @@ -1424,18 +1443,28 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
>  
>  	ret = sscanf(buf, "%lu", &value);
>  	if (ret != 1)
>  		return -EINVAL;
>  
> -	mutex_lock(&df->lock);
> -
> -	if (!value)
> -		value = ULONG_MAX;
> +	/*
> +	 * PM QoS frequencies are in kHz so we need to convert. Convert by
> +	 * rounding upwards so that the acceptable interval never shrinks.
> +	 *
> +	 * For example if the user writes "666666666" to sysfs this value will
> +	 * be converted to 666667 kHz and back to 666667000 Hz before an OPP
> +	 * lookup, this ensures that an OPP of 666666666Hz is still accepted.
> +	 *
> +	 * A value of zero means "no limit".
> +	 */
> +	if (value)
> +		value = DIV_ROUND_UP(value, HZ_PER_KHZ);
> +	else
> +		value = PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE;
>  
> -	df->max_freq = value;
> -	update_devfreq(df);
> -	mutex_unlock(&df->lock);
> +	ret = dev_pm_qos_update_request(&df->user_max_freq_req, value);
> +	if (ret < 0)
> +		return ret;
>  
>  	return count;
>  }
>  static DEVICE_ATTR_RW(min_freq);
>  
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index 8b92ccbd1962..fb376b5b7281 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -11,10 +11,11 @@
>  #define __LINUX_DEVFREQ_H__
>  
>  #include <linux/device.h>
>  #include <linux/notifier.h>
>  #include <linux/pm_opp.h>
> +#include <linux/pm_qos.h>
>  
>  #define DEVFREQ_NAME_LEN 16
>  
>  /* DEVFREQ governor name */
>  #define DEVFREQ_GOV_SIMPLE_ONDEMAND	"simple_ondemand"
> @@ -121,12 +122,12 @@ struct devfreq_dev_profile {
>   *		devfreq.nb to the corresponding register notifier call chain.
>   * @work:	delayed work for load monitoring.
>   * @previous_freq:	previously configured frequency value.
>   * @data:	Private data of the governor. The devfreq framework does not
>   *		touch this.
> - * @min_freq:	Limit minimum frequency requested by user (0: none)
> - * @max_freq:	Limit maximum frequency requested by user (0: none)
> + * @user_min_freq_req:	PM QoS minimum frequency request from user (via sysfs)
> + * @user_max_freq_req:	PM QoS maximum frequency request from user (via sysfs)
>   * @scaling_min_freq:	Limit minimum frequency requested by OPP interface
>   * @scaling_max_freq:	Limit maximum frequency requested by OPP interface
>   * @stop_polling:	 devfreq polling status of a device.
>   * @suspend_freq:	 frequency of a device set during suspend phase.
>   * @resume_freq:	 frequency of a device set in resume phase.
> @@ -161,12 +162,12 @@ struct devfreq {
>  	unsigned long previous_freq;
>  	struct devfreq_dev_status last_status;
>  
>  	void *data; /* private data for governors */
>  
> -	unsigned long min_freq;
> -	unsigned long max_freq;
> +	struct dev_pm_qos_request user_min_freq_req;
> +	struct dev_pm_qos_request user_max_freq_req;
>  	unsigned long scaling_min_freq;
>  	unsigned long scaling_max_freq;
>  	bool stop_polling;
>  
>  	unsigned long suspend_freq;
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
