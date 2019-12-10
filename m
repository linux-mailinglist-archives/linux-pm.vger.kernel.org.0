Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0CB0117ECD
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 05:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfLJEOL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Dec 2019 23:14:11 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:13968 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfLJEOK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Dec 2019 23:14:10 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191210041406epoutp016765b77d8685ec4b2454e42a7ae942c2~e508oAxCY1242812428epoutp01M
        for <linux-pm@vger.kernel.org>; Tue, 10 Dec 2019 04:14:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191210041406epoutp016765b77d8685ec4b2454e42a7ae942c2~e508oAxCY1242812428epoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575951246;
        bh=8ZnAdhmubYW5U3geKUg1GbxHGDRqr4E2F3dUKd6lc18=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=JiDJQnnpEPFZtDXmG9H+DuxuoVRiKKiu6MAT3Ve+VDdW8fNKP5sWnIOFmlPi4kLJ+
         ApfT2Ys1gTlOi0X1YL57IM1QeETCho8rWRwG/rbFiRdUG+O5umgUATRUXgk9RKLoR6
         EKX+7kxnDu8Fa8UtAHPB0xCp7tSUBUzJAiEZNeow=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191210041406epcas1p2573bfb61527a7855c7b6aec8dde088af~e508MtcJb2988229882epcas1p2d;
        Tue, 10 Dec 2019 04:14:06 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.153]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47X6Bh1pCmzMqYkY; Tue, 10 Dec
        2019 04:14:04 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        DC.FC.52419.C8B1FED5; Tue, 10 Dec 2019 13:14:04 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191210041403epcas1p393e978279a9c29aa550de20c7fe20bbe~e505p7wtv2140221402epcas1p3p;
        Tue, 10 Dec 2019 04:14:03 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191210041403epsmtrp18a202e3c5061bc1510377099ea9ee898~e505o4xMi2236922369epsmtrp1S;
        Tue, 10 Dec 2019 04:14:03 +0000 (GMT)
X-AuditID: b6c32a37-59fff7000001ccc3-f1-5def1b8cbff1
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D6.36.10238.B8B1FED5; Tue, 10 Dec 2019 13:14:03 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191210041403epsmtip1d12679440965b765de3305bac30411c1~e505RZSEm3119531195epsmtip1U;
        Tue, 10 Dec 2019 04:14:03 +0000 (GMT)
Subject: Re: [PATCH v3 4/4] devfreq: exynos-bus: Clean up code
To:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        kgene@kernel.org, krzk@kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, inki.dae@samsung.com,
        sw0312.kim@samsung.com, k.konieczny@samsung.com,
        leonard.crestez@nxp.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <ab5cd151-0f9f-929e-fcbe-e7fe7b6c8645@samsung.com>
Date:   Tue, 10 Dec 2019 13:20:29 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20191209104902.11904-5-a.swigon@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLJsWRmVeSWpSXmKPExsWy7bCmvm6P9PtYg+UbOS3uz2tltNg4Yz2r
        xaT7E1gsFnyawWrR//g1s8X58xvYLc42vWG3WHH3I6vFpsfXWC0u75rDZvG59wijxYzz+5gs
        1h65y25xu3EFm8WMyS/ZHPg9Nq3qZPPYvKTeY+O7HUwefVtWMXp83iQXwBqVbZORmpiSWqSQ
        mpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdK2SQlliTilQKCCxuFhJ
        386mKL+0JFUhI7+4xFYptSAlp8CyQK84Mbe4NC9dLzk/18rQwMDIFKgwITtj1ouMgp+GFatn
        TmFsYFyn3sXIySEhYCIxa9dK9i5GLg4hgR2MEq/au9kgnE+MEh0HnrJAON+AnLs9TDAt11cv
        ZoVI7GWU6Fz5A6rqPaPErTnNrCBVwgJ2EssW7GACSYgIHGCUOLC+GcxhFvjCKNF84y87SBWb
        gJbE/hc32EBsfgFFias/HjOC2LxA3f1PHzOD2CwCqhKXt28FqxcVCJM4ua0FqkZQ4uTMJywg
        NqeAlcSqmefB5jALiEvcejKfCcKWl2jeOpsZ4u517BLTf5pB2C4SjbM3QcWFJV4d38IOYUtJ
        vOxvg7KrJVaePAIODQmBDkaJLfsvsEIkjCX2L50MtIADaIGmxPpd+hBhRYmdv+cyQuzlk3j3
        tYcVpERCgFeio00IokRZ4vKDu9BglJRY3N7JNoFRaRaSb2Yh+WAWkg9mISxbwMiyilEstaA4
        Nz212LDAGDm6NzGCk7KW+Q7GDed8DjEKcDAq8fAucHgXK8SaWFZcmXuIUYKDWUmE93gbUIg3
        JbGyKrUoP76oNCe1+BCjKTCwJzJLiSbnAzNGXkm8oamRsbGxhYmhmamhoZI4L8ePi7FCAumJ
        JanZqakFqUUwfUwcnFINjFnbNk0NPeQb2N9wbOnaE6k+PXdMWdxS1m7YJnJqRdHCzn3L6uoD
        s24GrwpQ3ndMMLZA+mPD3MkhT4RK/n25uet174P1GyvOOS9z0Zhs9vX0gr1/2j9F3JIweyP3
        60D88cVrd00PFDyfPvW6caG1eDITn4F55zSr/01cKZe4eXf13OXj1Ty3c6sSS3FGoqEWc1Fx
        IgCeXYH14AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsWy7bCSnG639PtYg/uz5Szuz2tltNg4Yz2r
        xaT7E1gsFnyawWrR//g1s8X58xvYLc42vWG3WHH3I6vFpsfXWC0u75rDZvG59wijxYzz+5gs
        1h65y25xu3EFm8WMyS/ZHPg9Nq3qZPPYvKTeY+O7HUwefVtWMXp83iQXwBrFZZOSmpNZllqk
        b5fAlTHrRUbBT8OK1TOnMDYwrlPvYuTkkBAwkbi+ejFrFyMXh5DAbkaJO5cusUMkJCWmXTzK
        3MXIAWQLSxw+XAwSFhJ4yyixtFcTxBYWsJNYtmAHE0iviMABRonNO2czgSSYBb4wShx9Eg4x
        dC+jxI61B1hBEmwCWhL7X9xgA7H5BRQlrv54zAhi8wJN6n/6mBnEZhFQlbi8fSvYEaICYRI7
        lzxmgqgRlDg58wkLiM0pYCWxauZ5Nohl6hJ/5l1ihrDFJW49mQ91hLxE89bZzBMYhWchaZ+F
        pGUWkpZZSFoWMLKsYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQIjk0tzR2Ml5fEH2IU
        4GBU4uFd4PAuVog1say4MvcQowQHs5II7/E2oBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHep3nH
        IoUE0hNLUrNTUwtSi2CyTBycUg2M0v4uJ+e5V0Y9bqoSuFFeO4n71iyGE6UxbP5XSkqO/Dbt
        Kw/hVwjmebW/8tPNUJ1tlSH6LM0HlrxPm6cq8M8rsVp/9TTvXxMl/XK/u4fzuv2LVCq/ckTm
        k+iN5/auE5tqOPJmrn5nu27vZD1m9eafu54dmvLq3bUvGzrOlE0UiKqdmm/2dNkKJZbijERD
        Leai4kQAKr+0eskCAAA=
X-CMS-MailID: 20191210041403epcas1p393e978279a9c29aa550de20c7fe20bbe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191209105034eucas1p277be9a40363fec76b4241d28e71e40d2
References: <20191209104902.11904-1-a.swigon@samsung.com>
        <CGME20191209105034eucas1p277be9a40363fec76b4241d28e71e40d2@eucas1p2.samsung.com>
        <20191209104902.11904-5-a.swigon@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

This patch contains the clean-up code related to 'goto' style.
Please merge the the clean-up code of 'goto' to one patch with patch3/patch4.
- patch3 related to 'goto' clean-up code
- patch4 related to remaining clean-up code. 

And I added the comment below. Please check them.

On 12/9/19 7:49 PM, Artur Świgoń wrote:
> This patch adds minor improvements to the exynos-bus driver, including
> cleaning up header includes, variables, and return paths.
> 
> Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
> ---
>  drivers/devfreq/exynos-bus.c | 56 +++++++++++++++---------------------
>  1 file changed, 23 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index 0b557df63666..3eb6a043284a 100644
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
> @@ -178,7 +177,7 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
>  	struct device *dev = bus->dev;
>  	struct opp_table *opp_table;
>  	const char *vdd = "vdd";
> -	int i, ret, count, size;
> +	int i, ret, count;
>  
>  	opp_table = dev_pm_opp_set_regulators(dev, &vdd, 1);
>  	if (IS_ERR(opp_table)) {
> @@ -201,8 +200,7 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
>  	}
>  	bus->edev_count = count;
>  
> -	size = sizeof(*bus->edev) * count;
> -	bus->edev = devm_kzalloc(dev, size, GFP_KERNEL);
> +	bus->edev = devm_kcalloc(dev, count, sizeof(*bus->edev), GFP_KERNEL);

ditto.
It depends on personal style. Don't change it because we cannot
modify them at the all device driver. If is not wrong,
just keep the original code.


>  	if (!bus->edev) {
>  		ret = -ENOMEM;
>  		goto err_regulator;
> @@ -301,10 +299,9 @@ static int exynos_bus_profile_init(struct exynos_bus *bus,
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
> @@ -314,15 +311,14 @@ static int exynos_bus_profile_init(struct exynos_bus *bus,
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
> @@ -332,17 +328,16 @@ static int exynos_bus_profile_init(struct exynos_bus *bus,
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
> @@ -351,7 +346,6 @@ static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
>  	struct device *dev = bus->dev;
>  	struct devfreq_passive_data *passive_data;
>  	struct devfreq *parent_devfreq;
> -	int ret = 0;
>  
>  	/* Initialize the struct profile and governor data for passive device */
>  	profile->target = exynos_bus_target;
> @@ -359,30 +353,26 @@ static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
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
> -	bus->devfreq = devm_devfreq_add_device(dev, profile, DEVFREQ_GOV_PASSIVE,
> +	bus->devfreq = devm_devfreq_add_device(dev, profile,
> +						DEVFREQ_GOV_PASSIVE,

It is not clean-up. It depends on personal style. Don't change it
because we cannot modify them at the all device driver. If is not wrong,
just keep the original code.

>  						passive_data);
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
> @@ -400,18 +390,18 @@ static int exynos_bus_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	bus = devm_kzalloc(&pdev->dev, sizeof(*bus), GFP_KERNEL);
> +	bus = devm_kzalloc(dev, sizeof(*bus), GFP_KERNEL);

ditto.
It depends on personal style. Don't change it because we cannot
modify them at the all device driver. If is not wrong,
just keep the original code.

>  	if (!bus)
>  		return -ENOMEM;
>  	mutex_init(&bus->lock);
> -	bus->dev = &pdev->dev;
> +	bus->dev = dev;

ditto.
It depends on personal style. Don't change it because we cannot
modify them at the all device driver. If is not wrong,
just keep the original code.


>  	platform_set_drvdata(pdev, bus);
>  
>  	profile = devm_kzalloc(dev, sizeof(*profile), GFP_KERNEL);
>  	if (!profile)
>  		return -ENOMEM;
>  
> -	node = of_parse_phandle(dev->of_node, "devfreq", 0);
> +	node = of_parse_phandle(np, "devfreq", 0);
>  	if (node) {
>  		of_node_put(node);
>  		passive = true;
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
