Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A021AEA973
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 04:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfJaDKO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 23:10:14 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:38710 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfJaDKO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2019 23:10:14 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191031031011epoutp023cca8df8a705f7d771b9fc8abdeb286a~SnJtszPbB2744727447epoutp02D
        for <linux-pm@vger.kernel.org>; Thu, 31 Oct 2019 03:10:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191031031011epoutp023cca8df8a705f7d771b9fc8abdeb286a~SnJtszPbB2744727447epoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1572491411;
        bh=cU4lEnGD6v011KnpaqB3KiqExjGFrdQZFXj2UOBBImA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=gtIvdyRKfXiEnvt7gCnHAFXzL6BlSNsjnK4tTXpQdeN87nvV4/vn/Asd6ok0KGxi6
         l/3PfXGIG5oTWxYyLYFIcl4pglCfeKxNJ4+k4i0GqR+tWE18lfPyc66AyJcXfw1qnp
         aWexkuTZ9IyYIly/a2dcn5db4oGOqYiH5NjhahYk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191031031010epcas1p13dc7907b32ef19b0084f03463846ae0d~SnJs1yEqX1854218542epcas1p1L;
        Thu, 31 Oct 2019 03:10:10 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.158]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 473VgM67hZzMqYkY; Thu, 31 Oct
        2019 03:10:07 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        27.97.04224.F805ABD5; Thu, 31 Oct 2019 12:10:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191031031007epcas1p483fad2844e0b69af075d845e2abb3bd3~SnJqGf3zc2956729567epcas1p4L;
        Thu, 31 Oct 2019 03:10:07 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191031031007epsmtrp22cf8ca9b88d30982f483947d412313b6~SnJqFmkmm1766317663epsmtrp2c;
        Thu, 31 Oct 2019 03:10:07 +0000 (GMT)
X-AuditID: b6c32a38-d43ff70000001080-2d-5dba508f1b48
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8F.1E.24756.F805ABD5; Thu, 31 Oct 2019 12:10:07 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191031031006epsmtip2bb935c0fc6231445a43c444640e1e91e~SnJpsylFG2939129391epsmtip2T;
        Thu, 31 Oct 2019 03:10:06 +0000 (GMT)
Subject: Re: [PATCH v9 4/8] PM / devfreq: Move more initialization before
 registration
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
Message-ID: <0cadb00d-d34e-4028-93c4-b4902a50f5e2@samsung.com>
Date:   Thu, 31 Oct 2019 12:15:39 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <25f46d76dc95d5509edd7bf9d1a2e0532faef4cc.1570044052.git.leonard.crestez@nxp.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfUwTZxjP27teD+Jt74ofLw0OvMVE2YAeUPdqgLBpzJmRSGJiDAviDS6U
        0F6bXkvUZVvxa9A4xWhiVubHrEWEbUiHEwmEUWEMdbBpZFolikBmGq1jTYm6Ge31NOO/3/N7
        nt/zPL/3gyb0M5SBrpGcokMSLCyVTP50aWV21sHSnnLjwYe5OPjLeR2OXbkMcMu1IYCP9gUo
        PDZ2Tod/2/VQh0PuNNw6MavFgalxLfY8O0vg6FeDAEfPTQF8u76Vwu2jAxT2BJ9TuDPGF0P+
        8c29Or7Z/QfJnwy4+EBbI8XfGe+l+B9Pf8F3Rro1/ECkV8Mf6GoDfDTwdmlyWW2BWRSqREeG
        KFXaqmqk6kL2o00VaytMq4xcFrcav89mSIJVLGTXlZRmra+xxI2wGXWCxRWnSgVZZnOKChw2
        l1PMMNtkZyEr2qss9tX2bFmwyi6pOrvSZl3DGY25pnjhtlrz5J1Rwh5O3358spF0gxupHpBE
        I5iPBjubtQrWw26AvPu3e0ByHP8D0HczHq0azAG0Z+Y/4rXC3XqfVBN9AM0+vapRg8cAHeno
        pDyAplPgFuSJ1SiChfBzFPL9Sig1BDxEohfPPKSSoGAm6n9wk1Lwm3AZuvFkCihaBhahyQuZ
        Ck3C5ej489NahV4Ub3klJig0A99CI19PJ7okwa2o5dZEYjcCLkGh6RMaFaej3eebE2MRvKZD
        w3f9pGpgHXoU/VOn4hQUHu56hQ0oGumjVPwpOjsySKniBoC6+n/Xqok81O8/rFEWIuBK1NGT
        o9LL0MV/jwF18BsoEtuf2BlBBjXs06sl76Dr9yY0Kk5Fvi8bqSbAeufZ8c6z4J1nwfv/sJOA
        bAOLRbtsrRZlzp4//64DIPHEM3E36B0tCQJIA3YB01R3sVyvFerkHdYgQDTBLmTmCuIUUyXs
        2Ck6bBUOl0WUg8AUP+xDhGFRpS3+YSRnBWfKzcvLw/ncKhPHsUuYD874y/WwWnCKtaJoFx2v
        dRo6yeAGHzbvk5zDf38ipZ3y3ToS9ofPjBgvlf01t/i9opTlOROToc82SoHYFp+8cUXf+My3
        5l3F7/qny33fF7Y0Dfn603+OHKCGbLDBvDN9Q0p7ycdL6384vOaqm3aAsRVpVm391lMGpmMq
        XFdclvZg/fXagROzd0POpcw3/OXURz3Gzbp2lpTNApdJOGThJeD8sRD4AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsWy7bCSvG5/wK5Yg88tQhaHjm1lt/h6+hSj
        xbJLRxktpu/dxGZx/vwGdouzTW/YLW41yFisuPuR1WLT42usFl2/VjJbfO49wmjxecNjRovb
        jSvYLFafO8hm0XXoL5vFxq8eDgIe72+0snvMbrjI4rFgU6nHplWdbB53ru1h89i8pN5j47sd
        TB4H3+1h8ujbsorR4/MmuQCuKC6blNSczLLUIn27BK6Mh3fOMRe8kq+Y97CTpYHxqmQXIyeH
        hICJRMOKRyxdjFwcQgK7GSXefj7ACpGQlJh28ShzFyMHkC0scfhwMUTNW0aJ48+WMYLEhQUi
        JLq+ZoKUiwjUSfx5vo8JpIZZYDKLxMGj+xghGh4xSsyeswhsKJuAlsT+FzfYQGx+AUWJqz8e
        gw3iFbCTeLhdCyTMIqAqMe/vErByUaD5z7ffYASxeQUEJU7OfMICYnMKxEksu3mXGcRmFlCX
        +DPvEpQtLnHryXwmCFteonnrbOYJjMKzkLTPQtIyC0nLLCQtCxhZVjFKphYU56bnFhsWGOal
        lusVJ+YWl+al6yXn525iBEe0luYOxstL4g8xCnAwKvHwTijbGSvEmlhWXJl7iFGCg1lJhPeb
        DVCINyWxsiq1KD++qDQntfgQozQHi5I479O8Y5FCAumJJanZqakFqUUwWSYOTqkGRrtb2yYw
        TXvYy7bo9c5nM7ilzbn796SY8utOvrzYYE+ps8ODLo1X00WVcy94Hn4kGchlk328zeD2SltJ
        85sV//69bCm9f3id9skjzDeO/V7bIJR9qWONyOn6uTtilnn1OSUEPk1k2LpZhsFKJsJWg/9U
        ZdPX/Z88X+8pPtVmV2jYnJb51e9HrBJLcUaioRZzUXEiAFrczjfkAgAA
X-CMS-MailID: 20191031031007epcas1p483fad2844e0b69af075d845e2abb3bd3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191002192527epcas3p3ba24247bd1b8ce8ac33f7e4431c25241
References: <cover.1570044052.git.leonard.crestez@nxp.com>
        <CGME20191002192527epcas3p3ba24247bd1b8ce8ac33f7e4431c25241@epcas3p3.samsung.com>
        <25f46d76dc95d5509edd7bf9d1a2e0532faef4cc.1570044052.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Leonard,

This patch didn't get the acked-by from devfreq maintainer.
I think that we need to discuss this patch with more time.
Also, it is possible to make it as the separate patch
from this series. 

IMHO, if you make the separate patch for this and
resend the separate patch on later, I think that
we can merge the remained patch related to PM_QOS.


On 19. 10. 3. 오전 4:25, Leonard Crestez wrote:
> In general it is a better to initialize an object before making it
> accessible externally (through device_register).
> 
> This makes it possible to avoid remove locking the partially initialized
> object and simplifies the code. However devm is not available before
> device_register (only after the device_initialize step) so the two
> allocations need to be managed manually.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/devfreq/devfreq.c | 43 +++++++++++++++++++++++----------------
>  1 file changed, 25 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 3e0e936185a3..0b40f40ee7aa 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -591,10 +591,12 @@ static void devfreq_dev_release(struct device *dev)
>  	mutex_unlock(&devfreq_list_lock);
>  
>  	if (devfreq->profile->exit)
>  		devfreq->profile->exit(devfreq->dev.parent);
>  
> +	kfree(devfreq->time_in_state);
> +	kfree(devfreq->trans_table);
>  	mutex_destroy(&devfreq->lock);
>  	kfree(devfreq);
>  }
>  
>  /**
> @@ -674,44 +676,43 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	devfreq->max_freq = devfreq->scaling_max_freq;
>  
>  	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
>  	atomic_set(&devfreq->suspend_count, 0);
>  
> -	dev_set_name(&devfreq->dev, "devfreq%d",
> -				atomic_inc_return(&devfreq_no));
> -	err = device_register(&devfreq->dev);
> -	if (err) {
> -		mutex_unlock(&devfreq->lock);
> -		put_device(&devfreq->dev);
> -		goto err_out;
> -	}
> -
> -	devfreq->trans_table = devm_kzalloc(&devfreq->dev,
> +	devfreq->trans_table = kzalloc(
>  			array3_size(sizeof(unsigned int),
>  				    devfreq->profile->max_state,
>  				    devfreq->profile->max_state),
>  			GFP_KERNEL);
>  	if (!devfreq->trans_table) {
>  		mutex_unlock(&devfreq->lock);
>  		err = -ENOMEM;
> -		goto err_devfreq;
> +		goto err_dev;
>  	}
>  
> -	devfreq->time_in_state = devm_kcalloc(&devfreq->dev,
> -			devfreq->profile->max_state,
> -			sizeof(unsigned long),
> -			GFP_KERNEL);
> +	devfreq->time_in_state = kcalloc(devfreq->profile->max_state,
> +					 sizeof(unsigned long),
> +					 GFP_KERNEL);
>  	if (!devfreq->time_in_state) {
>  		mutex_unlock(&devfreq->lock);
>  		err = -ENOMEM;
> -		goto err_devfreq;
> +		goto err_dev;
>  	}
>  
>  	devfreq->last_stat_updated = jiffies;
>  
>  	srcu_init_notifier_head(&devfreq->transition_notifier_list);
>  
> +	dev_set_name(&devfreq->dev, "devfreq%d",
> +				atomic_inc_return(&devfreq_no));
> +	err = device_register(&devfreq->dev);
> +	if (err) {
> +		mutex_unlock(&devfreq->lock);
> +		put_device(&devfreq->dev);
> +		goto err_out;
> +	}
> +
>  	mutex_unlock(&devfreq->lock);
>  
>  	mutex_lock(&devfreq_list_lock);
>  
>  	governor = try_then_request_governor(devfreq->governor_name);
> @@ -737,14 +738,20 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  
>  	return devfreq;
>  
>  err_init:
>  	mutex_unlock(&devfreq_list_lock);
> -err_devfreq:
>  	devfreq_remove_device(devfreq);
> -	devfreq = NULL;
> +	return ERR_PTR(err);
> +
>  err_dev:
> +	/*
> +	 * Cleanup path for errors that happen before registration.
> +	 * Otherwise we rely on devfreq_dev_release.
> +	 */
> +	kfree(devfreq->time_in_state);
> +	kfree(devfreq->trans_table);
>  	kfree(devfreq);
>  err_out:
>  	return ERR_PTR(err);
>  }
>  EXPORT_SYMBOL(devfreq_add_device);
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
