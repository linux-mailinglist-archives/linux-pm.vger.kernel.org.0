Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74E32138C3E
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2020 08:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgAMHSI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jan 2020 02:18:08 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:36784 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgAMHSI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jan 2020 02:18:08 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200113071805epoutp0337fd118b7c305f628901dfec73fceafc~pYRSzaEcF0812108121epoutp03D
        for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2020 07:18:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200113071805epoutp0337fd118b7c305f628901dfec73fceafc~pYRSzaEcF0812108121epoutp03D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578899885;
        bh=OyPXwD//gNxYGJwrwgpCEXEZipA1ItAsHI0I6WwlA/M=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=b344l4LLqP/kDei7OPJzpZYULTtccgYb8+Pl427+bqy5X1GQmDke+I4nC4tcr3EGN
         vDphEakTXbcybOyFymRzbRG+aCkSAm4lxs9sLPzeMUNM1lYtOAan3WSEu7cVEaXIVE
         ig4AFjsGqVUJuGMk8zaWwRqUCDteJFVksCA8DESQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200113071804epcas1p43eb9a65dd0de9c8deedf823fb2fdf8c2~pYRRjHviC2466724667epcas1p4N;
        Mon, 13 Jan 2020 07:18:04 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.152]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47x4gG22xbzMqYkV; Mon, 13 Jan
        2020 07:18:02 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        7F.A0.48019.AA91C1E5; Mon, 13 Jan 2020 16:18:02 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200113071801epcas1p3d1cbe0cebee63c3457512a94850d4784~pYROv4MOL2902829028epcas1p3T;
        Mon, 13 Jan 2020 07:18:01 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200113071801epsmtrp12603314cdc809345ebaace8e4cef546f~pYROuvc0i1720517205epsmtrp1U;
        Mon, 13 Jan 2020 07:18:01 +0000 (GMT)
X-AuditID: b6c32a38-257ff7000001bb93-e7-5e1c19aa9c7a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9B.5A.10238.9A91C1E5; Mon, 13 Jan 2020 16:18:01 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200113071801epsmtip109f2a3ceff7afc3b3ae4423d958fad0b~pYROdnFmN1946319463epsmtip1t;
        Mon, 13 Jan 2020 07:18:01 +0000 (GMT)
Subject: Re: [PATCH 1/2] thermal: devfreq_cooling: Use PM QoS to set
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
Message-ID: <bae154ef-cbe6-de24-26c7-a7d4338bd55e@samsung.com>
Date:   Mon, 13 Jan 2020 16:25:17 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200110094913.1.I146403d05b9ec82f48b807efd416a57f545b447a@changeid>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUyMcRz3u+d67sk6/VzS13nLg6Gt3FMdD66bEbut/mhsbDblWT27y726
        5zInJq+9yGGYuSRmtooNKZIs6yL9IU4IvZCaFdLUSt7d3ZPpv8/v+/l8Xz7f35ciFJWkksq0
        OHi7hTPR5ETpTc+imOjyaTNSVbdzMfu1+ZuEPTc0k32075OMLe34EsS21Jwl2aEjDYgdutaN
        2La9pSTb0+UiVwbrinK8Ut3F2j6Jrv1FLam7/rlaonNVliNdXqNTN1QxK0W2yagx8FwGb4/k
        LenWjEyLPoFOWp+2Ok29RMVEM8vYpXSkhTPzCXRickr02kyTbzA6cjtnyvKFUjhBoBdrNXZr
        loOPNFgFRwLN2zJMtmW2GIEzC1kWfUy61bycUali1T7hFqOhauSWxOaau2Ow+heRg/5ML0AU
        BTgePo5oC9BESoGrEfQPvyELULDvMYggt5UQiREEl991Sf4lNJYvEDV3ETTsSxY1Awj2luQT
        fiIMbwSXp1vqJ6bgnwgODvwOEATWwwPPd5kfkzgK6npfBrqF4jnwfLQb+bEca2HwcmEAS/F8
        uHd/f0ATjjdA080DY5rJ0HSmR+ofKBivgyvelWL5CHjdUyIR8Wy41X82YADwYRlcazwVqAM4
        Ee48fBwk4jD40FgpE7ES+o4eGsPZUNbUQIrJeQgq656MJcRB3aUTgU0QeBFcrVkshufA7R/F
        SGw8CT4PFwaJy5JD3iGFKJkLLW87JCKeBhdz88ljiHaPc+MeZ8E9zoL7f7PzSFqOpvI2wazn
        BcYWP/6rK1DgYqPYalTbnFyPMIXoEDnsnp6qCOK2C05zPQKKoKfIK5qVqQp5BufcydutafYs
        Ey/UI7Vv2ccJZXi61Xf/Fkcao46Ni4tj45klaoahI+TUqHezAus5B2/keRtv/5cnoYKVOWi2
        c33q/nuKA0kP79o7tbHGYnKdxtPOJM0rzF8R7+3SPN76u7vI1fttoTG9TfbSWpYUSpYY96g9
        pa/zd2kivDdqXpWdDDkV5nCiVsWGxCrDhM5i969tLbOEC52bbbpViVVr5oeHbuv42vpee/pZ
        zLDqcHZY0wvjTPT0w6ZRE+8laKlg4Jgowi5wfwEuQuVhxwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsWy7bCSnO5KSZk4g5uvxC2+n/vJZDHvs6zF
        2aY37BYr7n5ktbi8aw6bxefeI4wWnzc8ZrS43biCzeLJwz42B06P2Q0XWTwW73nJ5HHn2h42
        j43vdjB59G1ZxejRcbzS4/MmuQD2KC6blNSczLLUIn27BK6Mrd+2MxX0KVd82vGXuYHxv3QX
        IweHhICJxPFV6l2MXBxCArsZJfp6HzN1MXICxSUlpl08ygxRIyxx+HAxRM1bRomtJ94wg9QI
        C4RLTLy4nw0kISLwj1Gi+eYWNpAEs0C6xPN1B8GKhASWMkrMvGsNYrMJaEnsf3EDrIZfQFHi
        6o/HjCA2r4CdxKfVPWA2i4CqxIGjzWA1ogJhEjuXQBzEKyAocXLmExaQgzgFgiTWXHSAWKUu
        8WfeJWYIW1zi1pP5TBC2vMT2t3OYJzAKz0LSPQtJyywkLbOQtCxgZFnFKJlaUJybnltsWGCY
        l1quV5yYW1yal66XnJ+7iREcb1qaOxgvL4k/xCjAwajEwytRKx0nxJpYVlyZe4hRgoNZSYR3
        0zmpOCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8T/OORQoJpCeWpGanphakFsFkmTg4pRoY8/4s
        SPp25MPxuRxVanq7Gn68CKu8JFwn9uO759sS7h1t6cfOTJ7hLVnx1HXxNHPGc643f5RYnL3i
        wnPIwv8KR+M1CYPmHia/+uBp3Ua+TLs2Zrh+1ZiV9a3GJOLIxGLVmpe2KWlKv8QuT+0pmNBy
        4fAH/33X1Y4wz1vlFZBZdD3qf5B2xCkjJZbijERDLeai4kQALv4pgLMCAAA=
X-CMS-MailID: 20200113071801epcas1p3d1cbe0cebee63c3457512a94850d4784
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200110174931epcas1p49c79567945e125829188174293d99850
References: <CGME20200110174931epcas1p49c79567945e125829188174293d99850@epcas1p4.samsung.com>
        <20200110094913.1.I146403d05b9ec82f48b807efd416a57f545b447a@changeid>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 1/11/20 2:49 AM, Matthias Kaehlcke wrote:
> Now that devfreq supports limiting the frequency range of a device
> through PM QoS make use of it instead of disabling OPPs that should
> not be used.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> 
>  drivers/thermal/devfreq_cooling.c | 66 ++++++++++---------------------
>  1 file changed, 20 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
> index ef59256887ff..3a63603afcf2 100644
> --- a/drivers/thermal/devfreq_cooling.c
> +++ b/drivers/thermal/devfreq_cooling.c
> @@ -24,11 +24,13 @@
>  #include <linux/idr.h>
>  #include <linux/slab.h>
>  #include <linux/pm_opp.h>
> +#include <linux/pm_qos.h>
>  #include <linux/thermal.h>
>  
>  #include <trace/events/thermal.h>
>  
> -#define SCALE_ERROR_MITIGATION 100
> +#define HZ_PER_KHZ		1000
> +#define SCALE_ERROR_MITIGATION	100
>  
>  static DEFINE_IDA(devfreq_ida);
>  
> @@ -65,49 +67,9 @@ struct devfreq_cooling_device {
>  	struct devfreq_cooling_power *power_ops;
>  	u32 res_util;
>  	int capped_state;
> +	struct dev_pm_qos_request req_max_freq;

Need to add the description of 'req_max_freq'.

>  };
>  
> -/**
> - * partition_enable_opps() - disable all opps above a given state
> - * @dfc:	Pointer to devfreq we are operating on
> - * @cdev_state:	cooling device state we're setting
> - *
> - * Go through the OPPs of the device, enabling all OPPs until
> - * @cdev_state and disabling those frequencies above it.
> - */
> -static int partition_enable_opps(struct devfreq_cooling_device *dfc,
> -				 unsigned long cdev_state)
> -{
> -	int i;
> -	struct device *dev = dfc->devfreq->dev.parent;
> -
> -	for (i = 0; i < dfc->freq_table_size; i++) {
> -		struct dev_pm_opp *opp;
> -		int ret = 0;
> -		unsigned int freq = dfc->freq_table[i];
> -		bool want_enable = i >= cdev_state ? true : false;
> -
> -		opp = dev_pm_opp_find_freq_exact(dev, freq, !want_enable);
> -
> -		if (PTR_ERR(opp) == -ERANGE)
> -			continue;
> -		else if (IS_ERR(opp))
> -			return PTR_ERR(opp);
> -
> -		dev_pm_opp_put(opp);
> -
> -		if (want_enable)
> -			ret = dev_pm_opp_enable(dev, freq);
> -		else
> -			ret = dev_pm_opp_disable(dev, freq);
> -
> -		if (ret)
> -			return ret;
> -	}
> -
> -	return 0;
> -}
> -
>  static int devfreq_cooling_get_max_state(struct thermal_cooling_device *cdev,
>  					 unsigned long *state)
>  {
> @@ -134,7 +96,7 @@ static int devfreq_cooling_set_cur_state(struct thermal_cooling_device *cdev,
>  	struct devfreq_cooling_device *dfc = cdev->devdata;
>  	struct devfreq *df = dfc->devfreq;
>  	struct device *dev = df->dev.parent;
> -	int ret;
> +	unsigned long freq;
>  
>  	if (state == dfc->cooling_state)
>  		return 0;
> @@ -144,9 +106,10 @@ static int devfreq_cooling_set_cur_state(struct thermal_cooling_device *cdev,
>  	if (state >= dfc->freq_table_size)
>  		return -EINVAL;
>  
> -	ret = partition_enable_opps(dfc, state);
> -	if (ret)
> -		return ret;
> +	freq = dfc->freq_table[state];
> +
> +	dev_pm_qos_update_request(&dfc->req_max_freq,
> +				  DIV_ROUND_UP(freq, HZ_PER_KHZ));
>  
>  	dfc->cooling_state = state;
>  
> @@ -529,6 +492,12 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
>  	if (err)
>  		goto free_dfc;
>  
> +	err = dev_pm_qos_add_request(df->dev.parent, &dfc->req_max_freq,
> +				     DEV_PM_QOS_MAX_FREQUENCY,
> +				     PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE);
> +	if (err < 0)
> +		goto remove_qos_req;

Jump 'free_table' instead of 'remove_qos_req'.

> +
>  	err = ida_simple_get(&devfreq_ida, 0, 0, GFP_KERNEL);
>  	if (err < 0)
>  		goto free_tables;

Jump remove_qos_req.

> @@ -552,6 +521,10 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
>  
>  release_ida:
>  	ida_simple_remove(&devfreq_ida, dfc->id);
> +
> +remove_qos_req:
> +	dev_pm_qos_remove_request(&dfc->req_max_freq);
> +
>  free_tables:
>  	kfree(dfc->power_table);
>  	kfree(dfc->freq_table);
> @@ -600,6 +573,7 @@ void devfreq_cooling_unregister(struct thermal_cooling_device *cdev)
>  
>  	thermal_cooling_device_unregister(dfc->cdev);
>  	ida_simple_remove(&devfreq_ida, dfc->id);
> +	dev_pm_qos_remove_request(&dfc->req_max_freq);
>  	kfree(dfc->power_table);
>  	kfree(dfc->freq_table);
>  
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
