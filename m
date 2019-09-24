Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19261BC06E
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2019 04:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408001AbfIXCwt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Sep 2019 22:52:49 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:22049 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbfIXCws (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Sep 2019 22:52:48 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190924025245epoutp04d878bf1dba153cd2afd504b59e9880de~HQC7V0Yjd0216102161epoutp045
        for <linux-pm@vger.kernel.org>; Tue, 24 Sep 2019 02:52:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190924025245epoutp04d878bf1dba153cd2afd504b59e9880de~HQC7V0Yjd0216102161epoutp045
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569293565;
        bh=/qPMK/OTF5WGtIMOzmKQ8hIwnlEGOc40G2TkGFwzCUk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=TOKuO/3gROkRB4JBSfC7Tq2mJBnV1FtlD2/WKYKMibZCSIu/Ilg94VTDghq8Azq5e
         znRjwWRaPJo/+HMWM4V+Q3QM1wuW078NPfPB14/SXsl72hmsm+B/NEwcDQ2hYkKZgm
         qeP3uNOgBiE2CB4fVPte1P0ql5Y5XN/rgXbaYRn4=
Received: from epsnrtp6.localdomain (unknown [182.195.42.167]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190924025244epcas1p2cf220417a72b5c5e53a19ff3b35a218c~HQC6rZjkk1894518945epcas1p2w;
        Tue, 24 Sep 2019 02:52:44 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.153]) by
        epsnrtp6.localdomain (Postfix) with ESMTP id 46cm2L0Bg8zMqYkV; Tue, 24 Sep
        2019 02:52:42 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        CC.C8.04224.9F4898D5; Tue, 24 Sep 2019 11:52:41 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190924025241epcas1p4f40a8ba5431403351217147b7871b95f~HQC39F9kX2898928989epcas1p4F;
        Tue, 24 Sep 2019 02:52:41 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190924025241epsmtrp272affb67bfeb09cf5002c59eac4f040f~HQC38P54H0339103391epsmtrp2k;
        Tue, 24 Sep 2019 02:52:41 +0000 (GMT)
X-AuditID: b6c32a38-d43ff70000001080-6a-5d8984f91f6e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EE.52.03889.9F4898D5; Tue, 24 Sep 2019 11:52:41 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190924025241epsmtip27f6bb01389b914fad2940b5ad25ec4fa~HQC3skGiw2476724767epsmtip28;
        Tue, 24 Sep 2019 02:52:41 +0000 (GMT)
Subject: Re: [PATCH v7 2/6] PM / devfreq: Move more initialization before
 registration
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
Message-ID: <bfa991bf-7155-6294-0595-fc37e3393fdd@samsung.com>
Date:   Tue, 24 Sep 2019 11:57:05 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <bf55208ff3ef868dcee46b52e91f717a6add5606.1569272883.git.leonard.crestez@nxp.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxTZxTO23t7Wzq7XaqMY10E7mYWiQjXtuzlyyyZWW6CP0j2w2FEdm1v
        SkO/1tua4X6sTofAZFnjD7M20ybq0qJuWGErC5XYggYcOB0SRmEzwS1GZ5mWLkOzubZXM/49
        55znnOc874eS0DyktEqL3S247LyVoVTkt4nNFRUrh7tbqi49qMHxK4MKnLk2gfBXN8cQPh6L
        UPj69X4Fnvz4DwWe876CQwsP5TiyOCPHPY/DBE73jiI8E/LJcbp/EeHkwRCFz05dpnBP/B8K
        X8hwbxZyS7OfKLiA9wbJBSMeLtLXTXHzM8MUd/H0R9yFVFTGXU4Ny7jHiSLus4E+xKUjG5te
        2N1e3ybwJsFVKtiNDpPFbm5gGt9pfavVUF3FVrA1+A2m1M7bhAZmx86mirct1qwjpnQ/b/Vk
        U028KDKV2+tdDo9bKG1ziO4GRnCarM4a51aRt4keu3mr0WGrZauqthmyxPfa25ZvHiSdfRs/
        iC0cIrxoCHpQgRJoPSSX54gepFJq6CiCWOYSKQWPEEw86UdS8BeC+75/Fc9bfo/fkEmFGILh
        +QyRK2joJQRD06ocXku/C0eGjudHraPPIjh8Zj4/iqB7SYj+2kXmWBRdDiN3Z6kcfokug1t/
        L6IcVtPbYSIwnc+T9CYYe3oyny/KTn10OyGXOIUw/sWd/JwCei/cD4zm1yPoYpi7c1Im4RI4
        NBggpLV/UcCnk80S3gErwZRMwmvh3tWBZ9a0kE7FKAl/COHxUSq3NNBdCAZGfpRLBR2MnDmW
        bVZmBTbDN99XSukyGHryJZJ0X4RU5qg8RwFaDV2dGonyKvx0e+GZ7Ho4daSb+hwx/lVu/Ksc
        +Fc58P8vFkRkH3pZcIo2syCyTv3q646g/HMvx1E0PLUzjmglYtaondGuFo2c3y922OIIlASz
        Th0p72zRqE18xwHB5Wh1eayCGEeG7GH7CG2R0ZH9PHZ3K2vYptPpsJ6tNrAsU6zmzN4WDW3m
        3UK7IDgF1/M+mbJA60Vfd15MP3XdWgx3+BpMwcbxpG+sJFB8olLfMTuw6e70azqLeV62ZmU5
        fP7elKXZ+3odHCtprrsa1ieSD9L73l+urq35c+9MyH/utw1l7C71d72Zo0Fj7Ybi0JKudvKH
        3Qnn+nOje1QW+rx+8MSeXXWqwp8TB7RE4yl9Wb0xqYpvYUixjWfLCZfI/weUSnC+BAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsWy7bCSvO7Pls5Yg2c7RS0OHdvKbvH19ClG
        i2WXjjJaTN+7ic3i/PkN7BZnm96wW9xqkLFYcfcjq8Wmx9dYLbp+rWS2+Nx7hNHi2oqJrBaf
        NzxmtLjduILNYvW5g2wWXYf+slls/OrhIOjx/kYru8fshossHgs2lXpsWtXJ5nHn2h42j81L
        6j02vtvB5HHw3R4mj1+HRT36tqxi9Pi8SS6AO4rLJiU1J7MstUjfLoEr48ulRpaCVXIVe+82
        Mzcw7pToYuTkkBAwkXh26CJTFyMXh5DAbkaJNa0zWSASkhLTLh5l7mLkALKFJQ4fLoaoecso
        sf//HbAaYYEIifad08FsEYG1jBJzzjuAFDEL9LJINB1cwQ7R8YhR4n/zY0aQKjYBLYn9L26w
        gdj8AooSV39AxHkF7CROzb4CFmcRUJU4+n8+WFwUaMPhHbOgagQlTs58AraNUyBO4vXsI+wg
        NrOAusSfeZeYIWxxiVtP5jNB2PISzVtnM09gFJ6FpH0WkpZZSFpmIWlZwMiyilEytaA4Nz23
        2LDAKC+1XK84Mbe4NC9dLzk/dxMjOM61tHYwnjgRf4hRgINRiYdXYltHrBBrYllxZe4hRgkO
        ZiUR3k1abbFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeeXzj0UKCaQnlqRmp6YWpBbBZJk4OKUa
        GK33LW/4fcE7nb2072eR3vKH36X/TTY9qZN95Fh40k/HgIKl87L+T1rOu0DgnfH3Y0cU19xU
        M3k9qShddPusHZqxXI+jL2eriRkudtnJ9otjkvi9rrJvN584bCo9HFdr6stQLjvBt/j84r/v
        WvwLl3PLbwu2NunRZr3zLMRSgu/hrqm1TyKL5yixFGckGmoxFxUnAgDTjnYu7wIAAA==
X-CMS-MailID: 20190924025241epcas1p4f40a8ba5431403351217147b7871b95f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190923211044epcas1p406c9e3cbfe6dd9a74e502ab63f321e4b
References: <cover.1569272883.git.leonard.crestez@nxp.com>
        <CGME20190923211044epcas1p406c9e3cbfe6dd9a74e502ab63f321e4b@epcas1p4.samsung.com>
        <bf55208ff3ef868dcee46b52e91f717a6add5606.1569272883.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

I'm not sure that it is necessary. Because, mainline kernel
provides the resource-managed feature with 'devm_*'
in order to reduce the memory leak by user.

It's like going back to a time when 'devm_*' feature wasn't there.
I think just it depends on the coding style of author.

I leave the final decision of this patch to Myungjoo.

On 19. 9. 24. 오전 6:10, Leonard Crestez wrote:
> In general it is a better to initialize an object before making it
> accessible externally (through device_register).
> 
> This makes it possible to avoid relying on locking a partially
> initialized object.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/devfreq/devfreq.c | 43 +++++++++++++++++++++++----------------
>  1 file changed, 25 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index f5bea7350f72..8bbcd4efa09f 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -588,10 +588,12 @@ static void devfreq_dev_release(struct device *dev)
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
> @@ -671,44 +673,43 @@ struct devfreq *devfreq_add_device(struct device *dev,
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
> @@ -734,14 +735,20 @@ struct devfreq *devfreq_add_device(struct device *dev,
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
