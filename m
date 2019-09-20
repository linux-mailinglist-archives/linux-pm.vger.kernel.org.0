Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75E43B8923
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2019 04:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388953AbfITCRs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 22:17:48 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:22822 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393877AbfITCRs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Sep 2019 22:17:48 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190920021742epoutp024871fc7a1c05a250c83f35f371384989~GA-L7kZS_1339513395epoutp024
        for <linux-pm@vger.kernel.org>; Fri, 20 Sep 2019 02:17:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190920021742epoutp024871fc7a1c05a250c83f35f371384989~GA-L7kZS_1339513395epoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568945862;
        bh=YfXLiQy+8jtEZrck5hnFr299ep9mh+np3X2B2i7hquo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=XMlmUMI/KBbKM4PzW5svqfrLfXd+dYrpaj3ngtNtMnNomxtdU112gzWkWq8zV4cI8
         4YBRcfdIzw5KR5zBo4l0oll5DmZTYj+EbQDNe/sMqzXZhGTZ4H5j27e8H2XBkub9bK
         9/wsSa+04yQNY7jBtjpJV8V3inVRNoVZuK9kxmeU=
Received: from epsnrtp6.localdomain (unknown [182.195.42.167]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190920021741epcas1p364d774b46fa83d475ea533e38d29bb5b~GA-LWgqtd2381523815epcas1p3M;
        Fri, 20 Sep 2019 02:17:41 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.154]) by
        epsnrtp6.localdomain (Postfix) with ESMTP id 46ZHRl0YPbzMqYkd; Fri, 20 Sep
        2019 02:17:39 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        D5.7E.04088.2C6348D5; Fri, 20 Sep 2019 11:17:39 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190920021738epcas1p13648ef89bd3d90cd7a3b7d6c19f0cac8~GA-IMjJk62761127611epcas1p1r;
        Fri, 20 Sep 2019 02:17:38 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190920021738epsmtrp1e584db6aac356dd50bb0603c188f20c8~GA-ILeTpP0124101241epsmtrp1r;
        Fri, 20 Sep 2019 02:17:38 +0000 (GMT)
X-AuditID: b6c32a35-85dff70000000ff8-d4-5d8436c2db4f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FF.85.03706.2C6348D5; Fri, 20 Sep 2019 11:17:38 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190920021737epsmtip105f54fafa3b9ced1bce39fc896890de6~GA-H2isNV1323713237epsmtip1n;
        Fri, 20 Sep 2019 02:17:37 +0000 (GMT)
Subject: Re: [RFC PATCH v2 04/11] devfreq: exynos-bus: Clean up code
To:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        myungjoo.ham@samsung.com, inki.dae@samsung.com,
        sw0312.kim@samsung.com, georgi.djakov@linaro.org,
        leonard.crestez@nxp.com, m.szyprowski@samsung.com,
        b.zolnierkie@samsung.com, krzk@kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <39db18c5-534d-ff72-0a7f-7a838c13fa7a@samsung.com>
Date:   Fri, 20 Sep 2019 11:22:06 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919142236.4071-5-a.swigon@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEJsWRmVeSWpSXmKPExsWy7bCmnu5hs5ZYg9cvmSwOHdvKbnF/Xiuj
        xcYZ61kt5h85x2px5et7NovpezexWUy6P4HF4vz5DewWK+5+ZLXY9Pgaq8XlXXPYLD73HmG0
        mHF+H5PF2iN32S1uN65gs5gx+SWbg4DHplWdbB53ru1h87jffZzJY/OSeo+N73YweRx8t4fJ
        o2/LKkaPz5vkAjiism0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVc
        fAJ03TJzgD5QUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BRYFugVJ+YWl+al6yXn
        51oZGhgYmQIVJmRnrGmdzl7QbVRxa90RlgbGRepdjJwcEgImEtvn3mbrYuTiEBLYwSix9MIK
        RgjnE6PE3O/bmUGqhAS+MUqc/VoO0zFv+zMmiKK9jBJ9z5qh2t8zSrxs+cYIUiUs4CIx59RC
        VpCEiMB/RonTy1aCOcwCnUwSv5/vYAWpYhPQktj/4gYbiM0voChx9cdjsG5eATuJW6u/gdWw
        CKhKvN3xlB3EFhWIkPj04DArRI2gxMmZT1hAbE4BS4m1886CzWEWEJe49WQ+E4QtL9G8dTYz
        yGIJgWPsErcWbGKGeMJFYsanf0wQtrDEq+Nb2CFsKYmX/W1QdrXEypNH2CCaOxgltuy/wAqR
        MJbYv3QyUDMH0AZNifW79CHCihI7f89lhFjMJ/Huaw8rSImEAK9ER5sQRImyxOUHd6HWSkos
        bu9km8CoNAvJO7OQvDALyQuzEJYtYGRZxSiWWlCcm55abFhgiBzfmxjB6VvLdAfjlHM+hxgF
        OBiVeHgVyptjhVgTy4orcw8xSnAwK4nwzjFtihXiTUmsrEotyo8vKs1JLT7EaAoM7YnMUqLJ
        +cDcklcSb2hqZGxsbGFiaGZqaKgkzuuR3hArJJCeWJKanZpakFoE08fEwSnVwNh7Srbgf+uu
        97dLNEXfZ3S+Fnr7L9m/pMIqU+Wl1pbNZSteBP+vr3vE0bSXZXJBQdr+G5OsfhdeWXN9Vfyu
        2vIF/zwW86yMypTp23yqn2XDw9qtLnq2Lzfv9PyovlHWa/J3HoGlBc5c7CZnFti53pCo0nL/
        K/7EkHUDx02LeBedSsvQC/JKHUosxRmJhlrMRcWJAC6coAH1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsWy7bCSnO4hs5ZYg/ddHBaHjm1lt7g/r5XR
        YuOM9awW84+cY7W48vU9m8X0vZvYLCbdn8Bicf78BnaLFXc/slpsenyN1eLyrjlsFp97jzBa
        zDi/j8li7ZG77Ba3G1ewWcyY/JLNQcBj06pONo871/awedzvPs7ksXlJvcfGdzuYPA6+28Pk
        0bdlFaPH501yARxRXDYpqTmZZalF+nYJXBlrWqezF3QbVdxad4SlgXGRehcjJ4eEgInEvO3P
        mLoYuTiEBHYzSmw8vJEZIiEpMe3iUSCbA8gWljh8uBii5i2jxNsZnYwgNcICLhJzTi1kBUmI
        CPxnlHjYdowRxGEW6GSSWLzlBwvc2M2LH4ONZRPQktj/4gYbiM0voChx9cdjsFG8AnYSt1Z/
        YwWxWQRUJd7ueMoOYosKREgc3jELqkZQ4uTMJywgNqeApcTaeWfB5jALqEv8mXeJGcIWl7j1
        ZD4ThC0v0bx1NvMERuFZSNpnIWmZhaRlFpKWBYwsqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS
        9ZLzczcxgiNZS3MH4+Ul8YcYBTgYlXh4FcqbY4VYE8uKK3MPMUpwMCuJ8M4xbYoV4k1JrKxK
        LcqPLyrNSS0+xCjNwaIkzvs071ikkEB6YklqdmpqQWoRTJaJg1OqgTGTe9nGF2+LdDouncjL
        OXNvkcn9x7KT+B4VmftX3JtSEdzE7llcsPaEw1xOkYeSaaLHEs2EsssfzWZRNbtVLzzdeses
        69M77utHzgjOKYuYNKt/Hs/NsH+eiZHbhRfvLJVLerdwTvIsqdmP7K+Ihj0REz8YN4GvWrll
        2Zo2CcW6OQ4abb2nkpVYijMSDbWYi4oTAYJDL03gAgAA
X-CMS-MailID: 20190920021738epcas1p13648ef89bd3d90cd7a3b7d6c19f0cac8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190919142324eucas1p1638cec2aafbfcaf03cfdfa7d0189143a
References: <20190919142236.4071-1-a.swigon@samsung.com>
        <CGME20190919142324eucas1p1638cec2aafbfcaf03cfdfa7d0189143a@eucas1p1.samsung.com>
        <20190919142236.4071-5-a.swigon@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Artur,

On 19. 9. 19. 오후 11:22, Artur Świgoń wrote:
> From: Artur Świgoń <a.swigon@partner.samsung.com>
> 
> This patch adds minor improvements to the exynos-bus driver.
> 
> Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/devfreq/exynos-bus.c | 66 ++++++++++++++----------------------
>  1 file changed, 25 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index 60ad4319fd80..8d44810cac69 100644
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
> @@ -314,8 +311,7 @@ static int exynos_bus_profile_init(struct exynos_bus *bus,
>  						ondemand_data);
>  	if (IS_ERR(bus->devfreq)) {
>  		dev_err(dev, "failed to add devfreq device\n");
> -		ret = PTR_ERR(bus->devfreq);
> -		goto err;
> +		return PTR_ERR(bus->devfreq);
>  	}
>  
>  	/*
> @@ -325,16 +321,13 @@ static int exynos_bus_profile_init(struct exynos_bus *bus,
>  	ret = exynos_bus_enable_edev(bus);
>  	if (ret < 0) {
>  		dev_err(dev, "failed to enable devfreq-event devices\n");
> -		goto err;
> +		return ret;
>  	}
>  
>  	ret = exynos_bus_set_event(bus);
> -	if (ret < 0) {
> +	if (ret < 0)
>  		dev_err(dev, "failed to set event to devfreq-event devices\n");
> -		goto err;

Instead of removing 'goto err', just return err as I commented[1] on v1.
[1] https://lkml.org/lkml/2019/7/26/331

> -	}
>  
> -err:
>  	return ret;

And you just keep 'return ret' or you can change it as 'return 0'.


>  }
>  
> @@ -344,7 +337,6 @@ static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
>  	struct device *dev = bus->dev;
>  	struct devfreq_passive_data *passive_data;
>  	struct devfreq *parent_devfreq;
> -	int ret = 0;
>  
>  	/* Initialize the struct profile and governor data for passive device */
>  	profile->target = exynos_bus_target;
> @@ -352,30 +344,26 @@ static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
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
> @@ -393,18 +381,18 @@ static int exynos_bus_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	bus = devm_kzalloc(&pdev->dev, sizeof(*bus), GFP_KERNEL);
> +	bus = devm_kzalloc(dev, sizeof(*bus), GFP_KERNEL);
>  	if (!bus)
>  		return -ENOMEM;
>  	mutex_init(&bus->lock);
> -	bus->dev = &pdev->dev;
> +	bus->dev = dev;
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
> @@ -461,12 +449,10 @@ static int exynos_bus_resume(struct device *dev)
>  	int ret;
>  
>  	ret = exynos_bus_enable_edev(bus);
> -	if (ret < 0) {
> +	if (ret < 0)
>  		dev_err(dev, "failed to enable the devfreq-event devices\n");
> -		return ret;

Keep the 'return ret' if error happen as I commented[1] on v1.
[1] https://lkml.org/lkml/2019/7/26/331

> -	}
>  
> -	return 0;
> +	return ret;

And you just keep 'return 0' or you can change it as 'return ret'.

>  }
>  
>  static int exynos_bus_suspend(struct device *dev)
> @@ -475,12 +461,10 @@ static int exynos_bus_suspend(struct device *dev)
>  	int ret;
>  
>  	ret = exynos_bus_disable_edev(bus);
> -	if (ret < 0) {
> +	if (ret < 0)
>  		dev_err(dev, "failed to disable the devfreq-event devices\n");
> -		return ret;

Keep the 'return ret' if error happen as I commented[1] on v1.
[1] https://lkml.org/lkml/2019/7/26/331

> -	}
>  
> -	return 0;
> +	return ret;

And you just keep 'return 0' or you can change it as 'return ret'.

>  }
>  #endif
>  
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
