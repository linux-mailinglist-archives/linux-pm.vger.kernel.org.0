Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECB71BC09F
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2019 05:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389682AbfIXDJh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Sep 2019 23:09:37 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:49320 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389424AbfIXDJg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Sep 2019 23:09:36 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190924030934epoutp01bf5985a46d46586d4a58c5a736578d30~HQRnFFmdc1449414494epoutp01I
        for <linux-pm@vger.kernel.org>; Tue, 24 Sep 2019 03:09:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190924030934epoutp01bf5985a46d46586d4a58c5a736578d30~HQRnFFmdc1449414494epoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569294574;
        bh=mJXjiFUB/srxNukytd2vImwQP8kSBRRW/h908Xv64us=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=lSO3LRVgkccCIWCqBqMON73c95ORuwtRjfXEpgYj9xZWiOGQ3q7vAUNNOeo5A74w7
         WYJ7CcySnMQuevju0t7qcuZccroTj2h0LHhToz+xKzDzkag4ek0njKAtPmqluPfW+O
         RPnqU7m1UfGZQCrwCVq8Ea/NAJHe9ljhDFEWd21o=
Received: from epsnrtp6.localdomain (unknown [182.195.42.167]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190924030933epcas1p49702e4acf7d058d718a3fabaa27be501~HQRmSw1h80069600696epcas1p4c;
        Tue, 24 Sep 2019 03:09:33 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.157]) by
        epsnrtp6.localdomain (Postfix) with ESMTP id 46cmPl0XShzMqYkX; Tue, 24 Sep
        2019 03:09:31 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        72.E7.04068.AE8898D5; Tue, 24 Sep 2019 12:09:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190924030930epcas1p40a8ec5b455fda0bdfea49bce09003e45~HQRjT-ywD2442824428epcas1p4B;
        Tue, 24 Sep 2019 03:09:30 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190924030930epsmtrp2556ddba13d2cbbd01e1201e946b93632~HQRjTGniq1481314813epsmtrp2J;
        Tue, 24 Sep 2019 03:09:30 +0000 (GMT)
X-AuditID: b6c32a39-f47ff70000000fe4-f1-5d8988ea17a7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EB.43.03889.9E8898D5; Tue, 24 Sep 2019 12:09:29 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190924030929epsmtip24e03530731068a4464e1fb3d03f7f56e~HQRjGFgDx0266802668epsmtip2-;
        Tue, 24 Sep 2019 03:09:29 +0000 (GMT)
Subject: Re: [PATCH v7 3/6] PM / devfreq: Don't take lock in
 devfreq_add_device
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        Martin Kepplinger <martink@posteo.de>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <03c0f372-930c-bb4e-6bc4-27366e20bc52@samsung.com>
Date:   Tue, 24 Sep 2019 12:13:54 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a88e8c73679fa01264732fe163704a0e748b5235.1569272883.git.leonard.crestez@nxp.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xbZRz16320HdZdOnC/NUbhOv+gCayX0vlhBjFK3E3EBTUmatLhDb0p
        hL7S2y5jmlCn1NIMVzSKK2M2YVsYLNlaOtMhhKwwdDODbUqD7OEGU4ePEtugZj5iy2WR/875
        fed8J+d7qAhthtapWhwe0e0QbCy9gfxsoqyi/OdAp9mwfFuBk1NnlHjlq4sIH796HuGesRiN
        Z2ZOK/Gl/b8o8bzvETxw4zcKxxZTFA7eO0HgbNckwqmBbgpnTy8ifO3tARoPTZ+jcTD5D42j
        K/zThfzyXIeS7/VdIflIzMvHBjtp/npqlOaHj7bz0XRCwZ9Ljyr4exPF/PvxQcRnY482FLze
        uqNZFCyiu0R0NDktLQ5rDfv8y43PNpq2G7hyrho/yZY4BLtYw9bVN5Q/12LLNWJL9gg2b27U
        IEgSu612h9vp9YglzU7JU8OKLovNVe2qkAS75HVYK5qc9qc4g6HSlBO+0dqc8h1Wujp0e6Pz
        V5APLRUFkVoFTBV82z1KB9EGlZZJIBjbn1gjGQT+2Qglk98RfB6PoPuWuZUvkbwwhmD6m+tr
        ZBnBoXSIDCKVahPzIgRG6vLzImYIwbvHZBHBdJGQ+C5A5reiGT2M352j83gjUwqzfy6uRmiY
        Wri57F/VkMwTMB4fVuRxMfMqZG5NULKmEC4curOqUTO7Yenjg8o8JpjNMH/nU4WMH4N3zvQS
        +WBgFpTQH/qRkjvUwR/DUwoZb4KfvogrZayDbHqMlvGbcOLCJC2bAwji45fXzEYYP/ahIl+T
        YMrg1Mg2eVwKZ//qQ3LwQ5BeOUDlJcBoIODXypLH4etbN9Zit0D/e510CLHhdXXC6yqE11UI
        /x8WQeQgelh0SXarKHEu0/r7jqHV966vTqCp6fokYlSIfVDjSgTMWkrYI7XZkwhUBFukien9
        Zq3GIrTtE93ORrfXJkpJZMqddjehK25y5n6Pw9PImSqNRiOu4rabOI7drOGtPrOWsQoesVUU
        XaL7vk+hUut8iIrvu/RMF3HkeObfcCZ0+5ONs6cuniS3GrU7nTfrU1toyysZfXu0l+qonTq8
        Wx3exfW8NNnT7o/2F1y2B6TKpRcO+NXnC/Y6UgtbUf1sn/0at6vU0DfSOnHX5Ow/+Npb36c/
        Cj2wdPXXv6uyc2VDP5iPniyPcDM9nQvDhUfazn6wkyWlZoHTE25J+A8DvL/uBQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsWy7bCSvO7Ljs5YgwXTbCwOHdvKbvH19ClG
        i2WXjjJaTN+7ic3i/PkN7BZnm96wW9xqkLFYcfcjq8Wmx9dYLbp+rWS2+Nx7hNHi2oqJrBaf
        NzxmtLjduILNYvW5g2wWXYf+slls/OrhIOjx/kYru8fshossHgs2lXpsWtXJ5nHn2h42j81L
        6j02vtvB5HHw3R4mj1+HRT36tqxi9Pi8SS6AO4rLJiU1J7MstUjfLoEr41rDHPaCVqmKjbcu
        MjYwvhTpYuTkkBAwkbjx9QQjiC0ksJtRYtFie4i4pMS0i0eZuxg5gGxhicOHi7sYuYBK3jJK
        TO26ywoSFxYIlOjY5QJSLiKwllFiznkHkBpmgV4WiaaDK9ghGh4xSnStvwy2gE1AS2L/ixts
        IDa/gKLE1R+PweK8AnYS9963sYDYLAKqEvu3bGYCsUUFIiQO75gFVSMocXLmE7AaToE4iZfT
        +tlBbGYBdYk/8y4xQ9jiEreezGeCsOUlmrfOZp7AKDwLSfssJC2zkLTMQtKygJFlFaNkakFx
        bnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcIxrae1gPHEi/hCjAAejEg+vxLaOWCHWxLLiytxD
        jBIczEoivJu02mKFeFMSK6tSi/Lji0pzUosPMUpzsCiJ88rnH4sUEkhPLEnNTk0tSC2CyTJx
        cEo1MC7MOvmkWGEF0wSXf4w73rBb7dvNvK0z5k5SYNPk6nm+SzSDM5aGeotWMkT8VPPUufVD
        5+M7VjFLvjiDsxUbGQ/8WrHjouvMdXXSwuVH4pgfvZ5U+0pzQWacxw+lv5lLGI9WX/ps5rg/
        4tKcKxcfmM6qnxLbHucUdCG3je1Z9t+MrBVb5pjP36rEUpyRaKjFXFScCACeGl1E7QIAAA==
X-CMS-MailID: 20190924030930epcas1p40a8ec5b455fda0bdfea49bce09003e45
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190923211044epcas5p38cc23699dc8bbb3effee58229d4a19ec
References: <cover.1569272883.git.leonard.crestez@nxp.com>
        <CGME20190923211044epcas5p38cc23699dc8bbb3effee58229d4a19ec@epcas5p3.samsung.com>
        <a88e8c73679fa01264732fe163704a0e748b5235.1569272883.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 19. 9. 24. 오전 6:10, Leonard Crestez wrote:
> A device usually doesn't need to lock itself during initialization
> because it is not yet reachable from other threads.
> 
> This simplifies the code and helps avoid recursive lock warnings.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/devfreq/devfreq.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 8bbcd4efa09f..1cec816d3d00 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -634,11 +634,10 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  		err = -ENOMEM;
>  		goto err_out;
>  	}
>  
>  	mutex_init(&devfreq->lock);
> -	mutex_lock(&devfreq->lock);
>  	devfreq->dev.parent = dev;
>  	devfreq->dev.class = devfreq_class;
>  	devfreq->dev.release = devfreq_dev_release;
>  	INIT_LIST_HEAD(&devfreq->node);
>  	devfreq->profile = profile;
> @@ -647,28 +646,24 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	devfreq->last_status.current_frequency = profile->initial_freq;
>  	devfreq->data = data;
>  	devfreq->nb.notifier_call = devfreq_notifier_call;
>  
>  	if (!devfreq->profile->max_state && !devfreq->profile->freq_table) {
> -		mutex_unlock(&devfreq->lock);
>  		err = set_freq_table(devfreq);
>  		if (err < 0)
>  			goto err_dev;
> -		mutex_lock(&devfreq->lock);
>  	}
>  
>  	devfreq->scaling_min_freq = find_available_min_freq(devfreq);
>  	if (!devfreq->scaling_min_freq) {
> -		mutex_unlock(&devfreq->lock);
>  		err = -EINVAL;
>  		goto err_dev;
>  	}
>  	devfreq->min_freq = devfreq->scaling_min_freq;
>  
>  	devfreq->scaling_max_freq = find_available_max_freq(devfreq);
>  	if (!devfreq->scaling_max_freq) {
> -		mutex_unlock(&devfreq->lock);
>  		err = -EINVAL;
>  		goto err_dev;
>  	}
>  	devfreq->max_freq = devfreq->scaling_max_freq;
>  
> @@ -679,20 +674,18 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  			array3_size(sizeof(unsigned int),
>  				    devfreq->profile->max_state,
>  				    devfreq->profile->max_state),
>  			GFP_KERNEL);
>  	if (!devfreq->trans_table) {
> -		mutex_unlock(&devfreq->lock);
>  		err = -ENOMEM;
>  		goto err_dev;
>  	}
>  
>  	devfreq->time_in_state = kcalloc(devfreq->profile->max_state,
>  					 sizeof(unsigned long),
>  					 GFP_KERNEL);
>  	if (!devfreq->time_in_state) {
> -		mutex_unlock(&devfreq->lock);
>  		err = -ENOMEM;
>  		goto err_dev;
>  	}
>  
>  	devfreq->last_stat_updated = jiffies;
> @@ -701,17 +694,14 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  
>  	dev_set_name(&devfreq->dev, "devfreq%d",
>  				atomic_inc_return(&devfreq_no));
>  	err = device_register(&devfreq->dev);
>  	if (err) {
> -		mutex_unlock(&devfreq->lock);
>  		put_device(&devfreq->dev);
>  		goto err_out;
>  	}
>  
> -	mutex_unlock(&devfreq->lock);
> -
>  	mutex_lock(&devfreq_list_lock);
>  
>  	governor = try_then_request_governor(devfreq->governor_name);
>  	if (IS_ERR(governor)) {
>  		dev_err(dev, "%s: Unable to find governor for the device\n",
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
