Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA85BD626
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2019 03:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439285AbfIYBm0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Sep 2019 21:42:26 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:20307 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392374AbfIYBm0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Sep 2019 21:42:26 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190925014224epoutp03746820b98b96c9fd0fcad80f77e633a6~HiuzB_6U72608626086epoutp03D
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2019 01:42:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190925014224epoutp03746820b98b96c9fd0fcad80f77e633a6~HiuzB_6U72608626086epoutp03D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569375744;
        bh=erL1BGcNr63Sq2f/GUWexJigOMFl626X7GA3JKgs0To=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=gK+xtdvtiwDEWTgiGV+PzNkDHYk4+2MzFIMpzNJGwOuYcLpAtDUgmwThuBl6nHP6D
         /tv7b2Vc2f7O1DYK3UXjymrHRv6UBLtzzpuEVAa8ROYj5k2N48kscoCOMO55OzAaTw
         2YTeiPsf78Zi/DYwQ8Gl9Mmsm31h8mX2B++VJvAs=
Received: from epsnrtp6.localdomain (unknown [182.195.42.167]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190925014223epcas1p4d410419db5b6a13b3336327013327bd4~HiuyXTAbJ1328613286epcas1p4U;
        Wed, 25 Sep 2019 01:42:23 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.152]) by
        epsnrtp6.localdomain (Postfix) with ESMTP id 46dLQj0wRfzMqYkW; Wed, 25 Sep
        2019 01:42:21 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        68.EA.04224.CF5CA8D5; Wed, 25 Sep 2019 10:42:21 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190925014220epcas1p43d531a0b2ef732069bd4e363c410cb90~Hiuvd_FDH1321513215epcas1p4W;
        Wed, 25 Sep 2019 01:42:20 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190925014220epsmtrp1b8bd5ea3c290da29dca539888135c0a5~HiuvdBxik2930829308epsmtrp1D;
        Wed, 25 Sep 2019 01:42:20 +0000 (GMT)
X-AuditID: b6c32a38-d5bff70000001080-f9-5d8ac5fc468e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2B.A6.04081.CF5CA8D5; Wed, 25 Sep 2019 10:42:20 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190925014220epsmtip24c94860ce513607175d4490f8f8dae91~Hiuu_n3752301523015epsmtip2a;
        Wed, 25 Sep 2019 01:42:20 +0000 (GMT)
Subject: Re: [PATCH v8 2/6] PM / devfreq: Move more initialization before
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
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <2b003542-25b1-8e39-f5c9-4266630dee0c@samsung.com>
Date:   Wed, 25 Sep 2019 10:46:44 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <398895f3b4f9ca4b03b47b56dfa25fbd58fd2311.1569319738.git.leonard.crestez@nxp.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOJsWRmVeSWpSXmKPExsWy7bCmge7fo12xBl+PM1ocOraV3eLr6VOM
        FssuHWW0mL53E5vF+fMb2C3ONr1ht7jVIGOx4u5HVotNj6+xWnT9Wsls8bn3CKPF5w2PGS1u
        N65gs1h97iCbRdehv2wWG796OAh4vL/Ryu4xu+Eii8eCTaUem1Z1snncubaHzWPzknqPje92
        MHkcfLeHyaNvyypGj8+b5AK4orJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU
        8hJzU22VXHwCdN0yc4AeUVIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUWBboFSfm
        Fpfmpesl5+daGRoYGJkCFSZkZ8x8t4Ol4Kl8xdP5b9kaGM9LdjFyckgImEj09rSxdTFycQgJ
        7GCU2HzjKRNIQkjgE6PEihVBEIlvjBJ/Ji5hhul4PO85I0RiL6PE1ZndTBDOe0aJjh3fwaqE
        BSIkPrYuBasSEVjNKNGy9A4jSIJZ4AmzxJ718iA2m4CWxP4XN9hAbH4BRYmrPx6D1fAK2ElM
        3LmBBcRmEVCVuHdrP1hcFGjopweHWSFqBCVOznwCVsMpECfR8HUdO8R8cYlbT+YzQdjyEs1b
        Z0OdfY5d4st9OQjbReLF3COsELawxKvjW9ghbCmJl/1tUHa1xMqTR8ABIyHQwSixZf8FqAZj
        if1LJwMt4ABaoCmxfpc+RFhRYufvuVA/8km8+9rDClIiIcAr0dEmBFGiLHH5wV0mCFtSYnF7
        J9sERqVZSL6ZheSDWUg+mIWwbAEjyypGsdSC4tz01GLDAhPk2N7ECE7kWhY7GPec8znEKMDB
        qMTD68DaFSvEmlhWXJl7iFGCg1lJhHeWDFCINyWxsiq1KD++qDQntfgQoykwsCcyS4km5wOz
        TF5JvKGpkbGxsYWJoZmpoaGSOK9HekOskEB6YklqdmpqQWoRTB8TB6dUA2NC9dVSO4V7rK8s
        YhZ+PpBrfmjpEpbqE9FbNWzZT1ye1K/PcrJWe9OxiopNV5Tink2RXSI084Xd5WW3+t0mWH51
        Nftw8atMWFuS44t3bCfvXyubWTVnx0vPGb+i1l2Z/d2Cb9mnk2wn1nx6cfVyqnKr14X77F1z
        jnMbbe+VndHLzT8vYeVJk4d2SizFGYmGWsxFxYkATvJ6a/oDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsWy7bCSvO6fo12xBuumaVkcOraV3eLr6VOM
        FssuHWW0mL53E5vF+fMb2C3ONr1ht7jVIGOx4u5HVotNj6+xWnT9Wsls8bn3CKPF5w2PGS1u
        N65gs1h97iCbRdehv2wWG796OAh4vL/Ryu4xu+Eii8eCTaUem1Z1snncubaHzWPzknqPje92
        MHkcfLeHyaNvyypGj8+b5AK4orhsUlJzMstSi/TtErgyZr7bwVLwVL7i6fy3bA2M5yW7GDk5
        JARMJB7Pe84IYgsJ7GaUOLbdECIuKTHt4lHmLkYOIFtY4vDh4i5GLqCSt4wSW660sILUCAtE
        SHxsXQrWKyKwllFiznkHEJtZ4BmzxIldaRANjxglNr2czQKSYBPQktj/4gYbiM0voChx9cdj
        sGZeATuJiTs3gNWwCKhK3Lu1HywuCrTg8I5ZUDWCEidnPgGr4RSIk2j4uo4dYpm6xJ95l5gh
        bHGJW0/mM0HY8hLNW2czT2AUnoWkfRaSlllIWmYhaVnAyLKKUTK1oDg3PbfYsMAwL7Vcrzgx
        t7g0L10vOT93EyM4orU0dzBeXhJ/iFGAg1GJh9eBtStWiDWxrLgy9xCjBAezkgjvLBmgEG9K
        YmVValF+fFFpTmrxIUZpDhYlcd6neccihQTSE0tSs1NTC1KLYLJMHJxSDYzsjLZyS/lOMtcV
        B3enblj6f2ty4K0PLc439ovsa3ysFNr6Ivfl/Yy/u4/dzXihqvHPrPOWZ+bqmzPUdR7+cHaN
        5LJKa2QsSvis+Oy3uebBu++nTZUU6nqz59cytSWqrGy+DFU73LrNToSt2jHpt+LVQ49Xazzu
        7zi4YfGfueVXrujpcfLYqxgrsRRnJBpqMRcVJwIADFbw/OQCAAA=
X-CMS-MailID: 20190925014220epcas1p43d531a0b2ef732069bd4e363c410cb90
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190924101140epcas1p40cffd655a8d1088a42e1ccf20ef33eaa
References: <cover.1569319738.git.leonard.crestez@nxp.com>
        <CGME20190924101140epcas1p40cffd655a8d1088a42e1ccf20ef33eaa@epcas1p4.samsung.com>
        <398895f3b4f9ca4b03b47b56dfa25fbd58fd2311.1569319738.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Leonard,

I copied and pasted my comments as following:
because you send new v8 version without waiting any reply.
In my case, I don't prefer to remove 'devm_' feature.

v7's comment.
I'm not sure that it is necessary. Because, mainline kernel
provides the resource-managed feature with 'devm_*'
in order to reduce the memory leak by user.

It's like going back to a time when 'devm_*' feature wasn't there.
I think just it depends on the coding style of author.

I leave the final decision of this patch to Myungjoo.

On 19. 9. 24. 오후 7:11, Leonard Crestez wrote:
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
> index 12c4bcdc1f17..dbc6dc882aba 100644
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
