Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 552FD1203B2
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2019 12:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfLPLUy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Dec 2019 06:20:54 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:63117 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbfLPLUu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Dec 2019 06:20:50 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191216112046epoutp04114d4f87f613c26559205cc4b0932ba6~g1hL4i1XW0214302143epoutp04r
        for <linux-pm@vger.kernel.org>; Mon, 16 Dec 2019 11:20:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191216112046epoutp04114d4f87f613c26559205cc4b0932ba6~g1hL4i1XW0214302143epoutp04r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576495246;
        bh=2jzKZlvQuqpvTbPIDfQwHkMQrnQSr+KYJE/48NwXw8w=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=sckEsUgYkqbv7FebHSPC0TVKcWs0rFPL0c6XKIp86O6s04hOyqvK8U7JAzMW/pOwd
         W1pMf7JWRota2Qsh8iX7Xj8ivFUIK8FOO5C+Ssu0/gXplevEbS3hgkpV7fcRF6KpBG
         AK32yZmGdJNrGLdl4SqBX+e9ueSOzG6rg6OWR76M=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191216112045epcas1p4616a1b029061c2da0b86ac3f234835e4~g1hLXPhxY2158121581epcas1p4X;
        Mon, 16 Dec 2019 11:20:45 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.157]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47bzNB55V0zMqYkZ; Mon, 16 Dec
        2019 11:20:42 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        33.DA.48019.A8867FD5; Mon, 16 Dec 2019 20:20:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191216112041epcas1p25320af2dbcd66bb08c95b4eb35057dde~g1hHhH4FK0602306023epcas1p28;
        Mon, 16 Dec 2019 11:20:41 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191216112041epsmtrp26bccbec2e02775a7dddf5ed4ae8635ef~g1hHgWsLD0674006740epsmtrp2g;
        Mon, 16 Dec 2019 11:20:41 +0000 (GMT)
X-AuditID: b6c32a38-23fff7000001bb93-8d-5df7688af41c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        77.3D.06569.98867FD5; Mon, 16 Dec 2019 20:20:41 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191216112041epsmtip164f9e261329028d939be8f41fe7862a5~g1hHD15i30703707037epsmtip15;
        Mon, 16 Dec 2019 11:20:41 +0000 (GMT)
Subject: Re: [PATCH v2] PM / devfreq: exynos-bus: Reduce the numer of goto
 statements and remove unused headers
To:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        kgene@kernel.org, krzk@kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, inki.dae@samsung.com,
        sw0312.kim@samsung.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <c4e9cc0e-97d7-27e0-e700-b7909a76424c@samsung.com>
Date:   Mon, 16 Dec 2019 20:27:16 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20191216104748.18877-1-a.swigon@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPJsWRmVeSWpSXmKPExsWy7bCmrm5XxvdYgzVfVSzuz2tltNg4Yz2r
        xaT7E1gs+h+/ZrY4f34Du8XZpjfsFpseX2O1uLxrDpvF594jjBYzzu9jslh75C67xe3GFWwW
        Mya/ZHPg9di0qpPNY/OSeo++LasYPT5vkgtgicq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1
        MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAE6T0mhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5Ra
        kJJTYFmgV5yYW1yal66XnJ9rZWhgYGQKVJiQnTHjylGWgsmaFU923mZqYPwj38XIySEhYCKx
        /cMq5i5GLg4hgR2MEtM2vmWDcD4xSqx8sp4FwvnGKLF1wQ8WmJataxYzQST2MkpM/fmLHcJ5
        zyix6c8SJpAqYYFCidsv5jOCJEQEDgDN6jgGtoUZxFm+4zzYLDYBLYn9L26wgdj8AooSV388
        Burg4OAVsJPYdU4fJMwioCqxZ+YjVhBbVCBM4uS2FkYQm1dAUOLkzCdgYzgFrCS+3P8OZjML
        iEvcejKfCcKWl2jeOhtsr4TAdHaJvYunsUH84CKxvu8iK4QtLPHq+BZ2CFtK4vO7vVA11RIr
        Tx5hg2juYJTYsv8CVIOxxP6lk5lADmUW0JRYv0sfIqwosfP3XEaIxXwS7772sIKUSAjwSnS0
        CUGUKEtcfnCXCcKWlFjc3sk2gVFpFpJ3ZiF5YRaSF2YhLFvAyLKKUSy1oDg3PbXYsMAEOb43
        MYITr5bFDsY953wOMQpwMCrx8L7I+BYrxJpYVlyZe4hRgoNZSYR3h8L3WCHelMTKqtSi/Pii
        0pzU4kOMpsDQnsgsJZqcD8wKeSXxhqZGxsbGFiaGZqaGhkrivBw/LsYKCaQnlqRmp6YWpBbB
        9DFxcEo1MHqpTPaxyV5l41bpvunRxusBj+Lj+z+UCq2VlpaUcevfrSjoIbl92amd23vnLZDP
        k5vE0eSiod/XvIRLgJ+JKfrwSa+KtbMuapWueWvYJDrRj81BQPrTRYuG+vB9938s2a+5dJPE
        jkYeiS+PJr0L2bJR7vbRFocDV6O+HNjCyMZurx5yXmR/vxJLcUaioRZzUXEiALRKHC7SAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsWy7bCSnG5nxvdYg8VfdC3uz2tltNg4Yz2r
        xaT7E1gs+h+/ZrY4f34Du8XZpjfsFpseX2O1uLxrDpvF594jjBYzzu9jslh75C67xe3GFWwW
        Mya/ZHPg9di0qpPNY/OSeo++LasYPT5vkgtgieKySUnNySxLLdK3S+DKmHHlKEvBZM2KJztv
        MzUw/pHvYuTkkBAwkdi6ZjFTFyMXh5DAbkaJB9c+MkIkJCWmXTzK3MXIAWQLSxw+XAxR85ZR
        YveLd2A1wgKFErdfzGcESYgIHGCUmHPrATtIghnEWXU8GKKjl1Hi0L5jYB1sAloS+1/cYAOx
        +QUUJa7+eMwIsoFXwE5i1zl9kDCLgKrEnpmPWEFsUYEwiZ1LHjOB2LwCghInZz5hAbE5Bawk
        vtz/zgKxS13iz7xLzBC2uMStJ/OZIGx5ieats5knMArPQtI+C0nLLCQts5C0LGBkWcUomVpQ
        nJueW2xYYJSXWq5XnJhbXJqXrpecn7uJERx/Wlo7GE+ciD/EKMDBqMTD65D9LVaINbGsuDL3
        EKMEB7OSCO8Ohe+xQrwpiZVVqUX58UWlOanFhxilOViUxHnl849FCgmkJ5akZqemFqQWwWSZ
        ODilGhiNo792hczW+zA9xfnD7q9GkjkXvrzaYH3hP/s2w92VB6xnGnwvC1E7sGVZ5Q0/M4Uf
        BRHs/yX3qx9nXJjTpXKH76nppDfd0y8W8n18uEml0uxTWLjXxVvbY7zW/pj56+fvGRtfLOza
        J9nYLLFkx8PEe9dP31gYJC3mYKaQ+P+MVc/TrV9i/X+mKrEUZyQaajEXFScCAOLpBEe7AgAA
X-CMS-MailID: 20191216112041epcas1p25320af2dbcd66bb08c95b4eb35057dde
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191216104816eucas1p1775a0dac98f507e10ee2fa15dccdc216
References: <CGME20191216104816eucas1p1775a0dac98f507e10ee2fa15dccdc216@eucas1p1.samsung.com>
        <20191216104748.18877-1-a.swigon@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

s/numer/number

But, remove 'the number of' from patch title
in order to make patch title under 80 char.

On 12/16/19 7:47 PM, Artur Świgoń wrote:
> This patch improves code readability by changing the following construct:
> 
>     if (cond)
>         goto passive;
>     foo();
>     goto out;
> passive:
>     bar();
> out:
> 
> into this:
> 
>     if (cond)
>         bar();
>     else
>         foo();
> 

And remove the example because it is too long and I think
that it is enough to explain what to do patch description.

I edit them by myself and applied it. Thanks.

> as well as eliminating a few more goto statements (related to return
> paths).
> 
> Moreover, this patch removes unused header file includes and adds a missing
> include <linux/of.h>.
> 
> Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
> ---
>  drivers/devfreq/exynos-bus.c | 54 +++++++++++++-----------------------
>  1 file changed, 19 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index 19d9f9f8ced2..7f5917d59072 100644
> --- a/drivers/devfreq/exynos-bus.c
> +++ b/drivers/devfreq/exynos-bus.c
> @@ -15,11 +15,10 @@
>  #include <linux/device.h>
>  #include <linux/export.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/pm_opp.h>
>  #include <linux/platform_device.h>
>  #include <linux/regulator/consumer.h>
> -#include <linux/slab.h>
>  
>  #define DEFAULT_SATURATION_RATIO	40
>  
> @@ -301,10 +300,9 @@ static int exynos_bus_profile_init(struct exynos_bus *bus,
>  	profile->exit = exynos_bus_exit;
>  
>  	ondemand_data = devm_kzalloc(dev, sizeof(*ondemand_data), GFP_KERNEL);
> -	if (!ondemand_data) {
> -		ret = -ENOMEM;
> -		goto err;
> -	}
> +	if (!ondemand_data)
> +		return -ENOMEM;
> +
>  	ondemand_data->upthreshold = 40;
>  	ondemand_data->downdifferential = 5;
>  
> @@ -314,15 +312,14 @@ static int exynos_bus_profile_init(struct exynos_bus *bus,
>  						ondemand_data);
>  	if (IS_ERR(bus->devfreq)) {
>  		dev_err(dev, "failed to add devfreq device\n");
> -		ret = PTR_ERR(bus->devfreq);
> -		goto err;
> +		return PTR_ERR(bus->devfreq);
>  	}
>  
>  	/* Register opp_notifier to catch the change of OPP  */
>  	ret = devm_devfreq_register_opp_notifier(dev, bus->devfreq);
>  	if (ret < 0) {
>  		dev_err(dev, "failed to register opp notifier\n");
> -		goto err;
> +		return ret;
>  	}
>  
>  	/*
> @@ -332,17 +329,16 @@ static int exynos_bus_profile_init(struct exynos_bus *bus,
>  	ret = exynos_bus_enable_edev(bus);
>  	if (ret < 0) {
>  		dev_err(dev, "failed to enable devfreq-event devices\n");
> -		goto err;
> +		return ret;
>  	}
>  
>  	ret = exynos_bus_set_event(bus);
>  	if (ret < 0) {
>  		dev_err(dev, "failed to set event to devfreq-event devices\n");
> -		goto err;
> +		return ret;
>  	}
>  
> -err:
> -	return ret;
> +	return 0;
>  }
>  
>  static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
> @@ -351,7 +347,6 @@ static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
>  	struct device *dev = bus->dev;
>  	struct devfreq_passive_data *passive_data;
>  	struct devfreq *parent_devfreq;
> -	int ret = 0;
>  
>  	/* Initialize the struct profile and governor data for passive device */
>  	profile->target = exynos_bus_target;
> @@ -359,16 +354,13 @@ static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
>  
>  	/* Get the instance of parent devfreq device */
>  	parent_devfreq = devfreq_get_devfreq_by_phandle(dev, 0);
> -	if (IS_ERR(parent_devfreq)) {
> -		ret = -EPROBE_DEFER;
> -		goto err;
> -	}
> +	if (IS_ERR(parent_devfreq))
> +		return -EPROBE_DEFER;
>  
>  	passive_data = devm_kzalloc(dev, sizeof(*passive_data), GFP_KERNEL);
> -	if (!passive_data) {
> -		ret = -ENOMEM;
> -		goto err;
> -	}
> +	if (!passive_data)
> +		return -ENOMEM;
> +
>  	passive_data->parent = parent_devfreq;
>  
>  	/* Add devfreq device for exynos bus with passive governor */
> @@ -377,12 +369,10 @@ static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
>  	if (IS_ERR(bus->devfreq)) {
>  		dev_err(dev,
>  			"failed to add devfreq dev with passive governor\n");
> -		ret = PTR_ERR(bus->devfreq);
> -		goto err;
> +		return PTR_ERR(bus->devfreq);
>  	}
>  
> -err:
> -	return ret;
> +	return 0;
>  }
>  
>  static int exynos_bus_probe(struct platform_device *pdev)
> @@ -427,19 +417,13 @@ static int exynos_bus_probe(struct platform_device *pdev)
>  		goto err_reg;
>  
>  	if (passive)
> -		goto passive;
> -
> -	ret = exynos_bus_profile_init(bus, profile);
> -	if (ret < 0)
> -		goto err;
> +		ret = exynos_bus_profile_init_passive(bus, profile);
> +	else
> +		ret = exynos_bus_profile_init(bus, profile);
>  
> -	goto out;
> -passive:
> -	ret = exynos_bus_profile_init_passive(bus, profile);
>  	if (ret < 0)
>  		goto err;
>  
> -out:
>  	max_state = bus->devfreq->profile->max_state;
>  	min_freq = (bus->devfreq->profile->freq_table[0] / 1000);
>  	max_freq = (bus->devfreq->profile->freq_table[max_state - 1] / 1000);
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
