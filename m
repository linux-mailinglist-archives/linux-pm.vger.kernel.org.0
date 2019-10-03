Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5A1FC998C
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2019 10:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbfJCIK3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Oct 2019 04:10:29 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40714 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbfJCIK3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Oct 2019 04:10:29 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191003081026euoutp018f82dfe38f96d46834614f9d343f6cee~KFL4MW4QM3067830678euoutp01-
        for <linux-pm@vger.kernel.org>; Thu,  3 Oct 2019 08:10:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191003081026euoutp018f82dfe38f96d46834614f9d343f6cee~KFL4MW4QM3067830678euoutp01-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1570090226;
        bh=6hRjC0tNiyDSi8+Av6FNgAeKhG2AUbLonkv4VI4SaTQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FZym4s8AOWj0Lm4i3MrOJOO6ka/1WVrLgRXopDQrBCR5KCkAKWWYinWLGwrHy96ND
         gc+/qqdSDZZHHmwKeH+p+EFPrt0rpD3YUQxw4tNMtKeCnAvMNRJJmMzXARk+jngHOs
         lhNyyF5wNCso8qIqcqsbjcKfqSxTV3DFh4npU9kI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191003081026eucas1p198b7a6a4755450e6e60e233d25318b9a~KFL31rgf82110221102eucas1p1W;
        Thu,  3 Oct 2019 08:10:26 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id D9.54.04309.2FCA59D5; Thu,  3
        Oct 2019 09:10:26 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191003081025eucas1p1f702dfa34d28e0ff82cf5e4d9780955b~KFL3frBuQ2398123981eucas1p1C;
        Thu,  3 Oct 2019 08:10:25 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191003081025eusmtrp11f6c646f18ccac9f96d7fdbc9c43ada8~KFL3e5DMo1139911399eusmtrp1a;
        Thu,  3 Oct 2019 08:10:25 +0000 (GMT)
X-AuditID: cbfec7f4-afbff700000010d5-cb-5d95acf26379
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 6E.1A.04117.1FCA59D5; Thu,  3
        Oct 2019 09:10:25 +0100 (BST)
Received: from AMDC3555 (unknown [106.120.51.67]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20191003081025eusmtip2fad72b79e16b275538bd8c580e57356f~KFL2z2G__0472104721eusmtip2X;
        Thu,  3 Oct 2019 08:10:25 +0000 (GMT)
Message-ID: <400cff22991252ddff7777e51f17dec2ce6e06f5.camel@samsung.com>
Subject: Re: [RFC PATCH v2 04/11] devfreq: exynos-bus: Clean up code
From:   Artur =?UTF-8?Q?=C5=9Awigo=C5=84?= <a.swigon@samsung.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Artur =?UTF-8?Q?=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        myungjoo.ham@samsung.com, inki.dae@samsung.com,
        sw0312.kim@samsung.com, georgi.djakov@linaro.org,
        leonard.crestez@nxp.com, m.szyprowski@samsung.com,
        b.zolnierkie@samsung.com, krzk@kernel.org
Date:   Thu, 03 Oct 2019 10:10:24 +0200
In-Reply-To: <39db18c5-534d-ff72-0a7f-7a838c13fa7a@samsung.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe3d2zo7m7DgVH8ySFn7ITLOyjihdwA+HLhD0JSqpmSe1vLHj
        JZVSS6WmeS3UJS1B0kxbmxfmKCWzRoqKJUu8Vuos85JXDGa1eZT69nv+z/N//u8DL4lJenFX
        MiI6jpVHyyKlhK2w8d2v7j3zNQ+C944aCXrkUSaiNSVqnP60OIHTqrYunO5dmiXo4ldagi4c
        yRfS3d0vRHTV0BxOa0eNOP1RX0bQC/faEF3S3Syga9uGRPRAehVBlxR9J45SjLb6LsEMGl8S
        zEi2QcDUVaQymhmdgMmtr0bMgnb7adE528BQNjIigZX7HL5kG75apxLFPvC/XrFswtOQabcC
        2ZBAHYC8H5lCBbIlJVQVgscFPQK+WESgU2RjfLGAQFEzhm1Y5jNNON+oRPBFoRHxhQnB6w9f
        CeuUmGKgerARt7IjFQRl7eVrTFBHoHNgeS3DiZpBMNbycy0DozIEMKGcFFqnhJQHzHVqkJVt
        LI6Bhwohn+0F0+25FiYtCQ6wqnO0yhjlDrcbHq7tAWpJBHdnmxA/HwRT4/U4z44waagX8ewG
        HUU56zs5GG8awXlzGgLtk7b1QwPgjaEHt4Zh1C5Q6314+Rj09ikJqwyUPfRNO/BvsIfCxmKM
        l8VwJ0vCoxT0pfa8EeDWM+P6bgbyPnaJ8tEO5b9blP/dovyX+hhh1ciFjeeiwlhuXzSb6M3J
        orj46DDvyzFRWmT5ax2/DYs6pDeHtCKKRFI7ccnw/WAJLkvgkqJaEZCY1En8QW2RxKGypGRW
        HnNRHh/Jcq1oKymUuohTNn0+L6HCZHHsNZaNZeUbXQFp45qGfA+l6J4/Bb1JRTXXvlfbdLrl
        mk+aVQWjYtI9q+Vthsyj/JGio4obTJ4o2qYZc5Ym29XuSAtf+oacvQLUgsYrWxzOxOfmlF5g
        g6+eVfr5uK4kTtw05/SfSA8sPm42ZHYah7OcQpoa+lv2pwZudjk1tbOu0hdnVzzt/xy8Ee7n
        LxVy4TJfT0zOyf4C22Y4aWcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsVy+t/xe7of10yNNWg5qW9xf14ro8XGGetZ
        La5/ec5qMf/IOVaLK1/fs1lM37uJzWLS/QksFufPb2C3WHH3I6vFpsfXWC0u75rDZvG59wij
        xYzz+5gs1h65y25xu3EFm8WMyS/ZHAQ8Nq3qZPO4c20Pm8f97uNMHpuX1HtsfLeDyaNvyypG
        j8+b5ALYo/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/Tt
        EvQy/m6ez14w1bJiybdnrA2Mz7S7GDk5JARMJD61PmPtYuTiEBJYyijR/Oo6O0RCQuLj+hus
        ELawxJ9rXWwQRU8YJU4cX88GkuAV8JBYdWcbWJGwgIvEnFMLwWw2AXuJs7e/MYE0iAi8Z5T4
        sP0dO4jDLNDGJHGobzNYFYuAqsTHsxsZQWxOoI7bs7tYIFZ8ZpQ4eWM+2B3MApoSrdt/Q92k
        I/H2VB9QEQfQakGJvzuEIUrkJZq3zmaewCg4C0nHLISqWUiqFjAyr2IUSS0tzk3PLTbSK07M
        LS7NS9dLzs/dxAiM2W3Hfm7Zwdj1LvgQowAHoxIP74x7U2KFWBPLiitzDzFKcDArifBeWg8U
        4k1JrKxKLcqPLyrNSS0+xGgK9M9EZinR5HxgOskriTc0NTS3sDQ0NzY3NrNQEuftEDgYIySQ
        nliSmp2aWpBaBNPHxMEp1cAozFYlqZ2plr7us5JEU/qqs+nXF6yR3XZSYfW9y69s7m1NZYmt
        j9FnmvGk+07WoXnZ3eZKhsor7lmKVIgIrj3k92Gi9LWlq/5fmc9yY07ZxaSgFXvy/LdLJ8ws
        jf3sxnhxm5rNcdGUtsojjh84Whcve2Ycazyp4adyhuOcNV/c3iXrNN178lxLiaU4I9FQi7mo
        OBEA6B+cBe8CAAA=
X-CMS-MailID: 20191003081025eucas1p1f702dfa34d28e0ff82cf5e4d9780955b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190919142324eucas1p1638cec2aafbfcaf03cfdfa7d0189143a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190919142324eucas1p1638cec2aafbfcaf03cfdfa7d0189143a
References: <20190919142236.4071-1-a.swigon@samsung.com>
        <CGME20190919142324eucas1p1638cec2aafbfcaf03cfdfa7d0189143a@eucas1p1.samsung.com>
        <20190919142236.4071-5-a.swigon@samsung.com>
        <39db18c5-534d-ff72-0a7f-7a838c13fa7a@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Fri, 2019-09-20 at 11:22 +0900, Chanwoo Choi wrote:
> Hi Artur,
> 
> On 19. 9. 19. 오후 11:22, Artur Świgoń wrote:
> > From: Artur Świgoń <a.swigon@partner.samsung.com>
> > 
> > This patch adds minor improvements to the exynos-bus driver.
> > 
> > Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
> > Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  drivers/devfreq/exynos-bus.c | 66 ++++++++++++++----------------------
> >  1 file changed, 25 insertions(+), 41 deletions(-)
> > 
> > diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> > index 60ad4319fd80..8d44810cac69 100644
> > --- a/drivers/devfreq/exynos-bus.c
> > +++ b/drivers/devfreq/exynos-bus.c
> > @@ -15,11 +15,10 @@
> >  #include <linux/device.h>
> >  #include <linux/export.h>
> >  #include <linux/module.h>
> > -#include <linux/of_device.h>
> > +#include <linux/of.h>
> >  #include <linux/pm_opp.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/regulator/consumer.h>
> > -#include <linux/slab.h>
> >  
> >  #define DEFAULT_SATURATION_RATIO	40
> >  
> > @@ -178,7 +177,7 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
> >  	struct device *dev = bus->dev;
> >  	struct opp_table *opp_table;
> >  	const char *vdd = "vdd";
> > -	int i, ret, count, size;
> > +	int i, ret, count;
> >  
> >  	opp_table = dev_pm_opp_set_regulators(dev, &vdd, 1);
> >  	if (IS_ERR(opp_table)) {
> > @@ -201,8 +200,7 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
> >  	}
> >  	bus->edev_count = count;
> >  
> > -	size = sizeof(*bus->edev) * count;
> > -	bus->edev = devm_kzalloc(dev, size, GFP_KERNEL);
> > +	bus->edev = devm_kcalloc(dev, count, sizeof(*bus->edev), GFP_KERNEL);
> >  	if (!bus->edev) {
> >  		ret = -ENOMEM;
> >  		goto err_regulator;
> > @@ -301,10 +299,9 @@ static int exynos_bus_profile_init(struct exynos_bus *bus,
> >  	profile->exit = exynos_bus_exit;
> >  
> >  	ondemand_data = devm_kzalloc(dev, sizeof(*ondemand_data), GFP_KERNEL);
> > -	if (!ondemand_data) {
> > -		ret = -ENOMEM;
> > -		goto err;
> > -	}
> > +	if (!ondemand_data)
> > +		return -ENOMEM;
> > +
> >  	ondemand_data->upthreshold = 40;
> >  	ondemand_data->downdifferential = 5;
> >  
> > @@ -314,8 +311,7 @@ static int exynos_bus_profile_init(struct exynos_bus *bus,
> >  						ondemand_data);
> >  	if (IS_ERR(bus->devfreq)) {
> >  		dev_err(dev, "failed to add devfreq device\n");
> > -		ret = PTR_ERR(bus->devfreq);
> > -		goto err;
> > +		return PTR_ERR(bus->devfreq);
> >  	}
> >  
> >  	/*
> > @@ -325,16 +321,13 @@ static int exynos_bus_profile_init(struct exynos_bus *bus,
> >  	ret = exynos_bus_enable_edev(bus);
> >  	if (ret < 0) {
> >  		dev_err(dev, "failed to enable devfreq-event devices\n");
> > -		goto err;
> > +		return ret;
> >  	}
> >  
> >  	ret = exynos_bus_set_event(bus);
> > -	if (ret < 0) {
> > +	if (ret < 0)
> >  		dev_err(dev, "failed to set event to devfreq-event devices\n");
> > -		goto err;
> 
> Instead of removing 'goto err', just return err as I commented[1] on v1.
> [1] https://lkml.org/lkml/2019/7/26/331
> 
> > -	}
> >  
> > -err:
> >  	return ret;
> 
> And you just keep 'return ret' or you can change it as 'return 0'.

OK, I went for:

ret = exynos_bus_set_event(bus);
if (ret < 0) {
	dev_err(dev, "failed to set event to devfreq-event devices\n");
	return ret;
}

return 0;

> >  }
> >  
> > @@ -344,7 +337,6 @@ static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
> >  	struct device *dev = bus->dev;
> >  	struct devfreq_passive_data *passive_data;
> >  	struct devfreq *parent_devfreq;
> > -	int ret = 0;
> >  
> >  	/* Initialize the struct profile and governor data for passive device */
> >  	profile->target = exynos_bus_target;
> > @@ -352,30 +344,26 @@ static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
> >  
> >  	/* Get the instance of parent devfreq device */
> >  	parent_devfreq = devfreq_get_devfreq_by_phandle(dev, 0);
> > -	if (IS_ERR(parent_devfreq)) {
> > -		ret = -EPROBE_DEFER;
> > -		goto err;
> > -	}
> > +	if (IS_ERR(parent_devfreq))
> > +		return -EPROBE_DEFER;
> >  
> >  	passive_data = devm_kzalloc(dev, sizeof(*passive_data), GFP_KERNEL);
> > -	if (!passive_data) {
> > -		ret = -ENOMEM;
> > -		goto err;
> > -	}
> > +	if (!passive_data)
> > +		return -ENOMEM;
> > +
> >  	passive_data->parent = parent_devfreq;
> >  
> >  	/* Add devfreq device for exynos bus with passive governor */
> > -	bus->devfreq = devm_devfreq_add_device(dev, profile, DEVFREQ_GOV_PASSIVE,
> > +	bus->devfreq = devm_devfreq_add_device(dev, profile,
> > +						DEVFREQ_GOV_PASSIVE,
> >  						passive_data);
> >  	if (IS_ERR(bus->devfreq)) {
> >  		dev_err(dev,
> >  			"failed to add devfreq dev with passive governor\n");
> > -		ret = PTR_ERR(bus->devfreq);
> > -		goto err;
> > +		return PTR_ERR(bus->devfreq);
> >  	}
> >  
> > -err:
> > -	return ret;
> > +	return 0;
> >  }
> >  
> >  static int exynos_bus_probe(struct platform_device *pdev)
> > @@ -393,18 +381,18 @@ static int exynos_bus_probe(struct platform_device *pdev)
> >  		return -EINVAL;
> >  	}
> >  
> > -	bus = devm_kzalloc(&pdev->dev, sizeof(*bus), GFP_KERNEL);
> > +	bus = devm_kzalloc(dev, sizeof(*bus), GFP_KERNEL);
> >  	if (!bus)
> >  		return -ENOMEM;
> >  	mutex_init(&bus->lock);
> > -	bus->dev = &pdev->dev;
> > +	bus->dev = dev;
> >  	platform_set_drvdata(pdev, bus);
> >  
> >  	profile = devm_kzalloc(dev, sizeof(*profile), GFP_KERNEL);
> >  	if (!profile)
> >  		return -ENOMEM;
> >  
> > -	node = of_parse_phandle(dev->of_node, "devfreq", 0);
> > +	node = of_parse_phandle(np, "devfreq", 0);
> >  	if (node) {
> >  		of_node_put(node);
> >  		passive = true;
> > @@ -461,12 +449,10 @@ static int exynos_bus_resume(struct device *dev)
> >  	int ret;
> >  
> >  	ret = exynos_bus_enable_edev(bus);
> > -	if (ret < 0) {
> > +	if (ret < 0)
> >  		dev_err(dev, "failed to enable the devfreq-event devices\n");
> > -		return ret;
> 
> Keep the 'return ret' if error happen as I commented[1] on v1.
> [1] https://lkml.org/lkml/2019/7/26/331
> 
> > -	}
> >  
> > -	return 0;
> > +	return ret;
> 
> And you just keep 'return 0' or you can change it as 'return ret'.

OK, I kept the original code:

ret = exynos_bus_enable_edev(bus);
if (ret < 0) {
	dev_err(dev, "failed to enable the devfreq-event devices\n");
	return ret;
}

return 0;

> >  }
> >  
> >  static int exynos_bus_suspend(struct device *dev)
> > @@ -475,12 +461,10 @@ static int exynos_bus_suspend(struct device *dev)
> >  	int ret;
> >  
> >  	ret = exynos_bus_disable_edev(bus);
> > -	if (ret < 0) {
> > +	if (ret < 0)
> >  		dev_err(dev, "failed to disable the devfreq-event devices\n");
> > -		return ret;
> 
> Keep the 'return ret' if error happen as I commented[1] on v1.
> [1] https://lkml.org/lkml/2019/7/26/331

OK, I kept the original code.

> > -	}
> >  
> > -	return 0;
> > +	return ret;
> 
> And you just keep 'return 0' or you can change it as 'return ret'.
> 
> >  }
> >  #endif
> >  
> > 
> 
> 

Best regards,
-- 
Artur Świgoń
Samsung R&D Institute Poland
Samsung Electronics


