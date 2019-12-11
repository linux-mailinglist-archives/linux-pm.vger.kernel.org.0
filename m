Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D43311ADEB
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2019 15:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730243AbfLKOkC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Dec 2019 09:40:02 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58856 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729872AbfLKOkA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Dec 2019 09:40:00 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191211143958euoutp019ac9f6aa37026bde9d695e0717538ca3~fWArXSrZ81348913489euoutp01O
        for <linux-pm@vger.kernel.org>; Wed, 11 Dec 2019 14:39:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191211143958euoutp019ac9f6aa37026bde9d695e0717538ca3~fWArXSrZ81348913489euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576075198;
        bh=3geT+16YDY/ZnT6g0unUce0W4Zs91pfr3cDL8ouXL4Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=TY+LtNkFN2MURu+zND8qISU5Huj1k8Aopzg6e86CLnuC00SKvFUunk9R+FTk07BVx
         T2PPdMdiLmJ8IXJdNT2+UBFwHI/4aOwd8OMGMIPv5qgYshmwAeBvp3IwmdbTwpSnvJ
         XsBFzkiAploIitZG/AbBcT06UNaoUgZZCcMUFhM8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191211143957eucas1p2da02f6c6663bc3c434faec5d61efca44~fWArCw7-q1898418984eucas1p24;
        Wed, 11 Dec 2019 14:39:57 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id B2.2E.61286.DBFF0FD5; Wed, 11
        Dec 2019 14:39:57 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191211143957eucas1p29477538aa5520cf0009cacea907171c3~fWAqY0SH91877418774eucas1p2E;
        Wed, 11 Dec 2019 14:39:57 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191211143957eusmtrp19a94f600792247c037d111cac1212e8d~fWAqYD_cI2547525475eusmtrp1X;
        Wed, 11 Dec 2019 14:39:57 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-6d-5df0ffbd618e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A8.18.08375.CBFF0FD5; Wed, 11
        Dec 2019 14:39:57 +0000 (GMT)
Received: from AMDC3555 (unknown [106.120.51.67]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20191211143956eusmtip2fd8ad4471581893f1fa014b3417c7114~fWApqHGq10290902909eusmtip2L;
        Wed, 11 Dec 2019 14:39:54 +0000 (GMT)
Message-ID: <32cd66aca8d9435bed69732771a7716db883f5a0.camel@samsung.com>
Subject: Re: [PATCH v3 4/4] devfreq: exynos-bus: Clean up code
From:   Artur =?UTF-8?Q?=C5=9Awigo=C5=84?= <a.swigon@samsung.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        kgene@kernel.org, krzk@kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, inki.dae@samsung.com,
        sw0312.kim@samsung.com, k.konieczny@samsung.com,
        leonard.crestez@nxp.com, rostedt@goodmis.org
Date:   Wed, 11 Dec 2019 15:39:53 +0100
In-Reply-To: <ab5cd151-0f9f-929e-fcbe-e7fe7b6c8645@samsung.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SWUwTURTNm6UdkClDUbmpRrHqBy5UqiaTiCiJ0f64JEaDJo1WGYFIgXRA
        UT8saBDrXiTSamIFZTMsFqmVRBIr0NiquAQVF9AQZBEB2yL1w4VhMPh33jn33HvPzaNw+RNS
        QaVlZHOGDF26UhJKONp+Plv+4M+odkXTYCx7p6SOZN8E+kjW3H2RYG2+EpK90PMVZ9vb66Xs
        0/whKVv58TvJ2ntek+yrpmsS1n+uBbEl7c0YW9PyUcq+z6uUsM2FnzC2pGhAsp7RnGx+J9XY
        q09LNA03j2vuDDsxzfm71Ujjt8/bJtkdGp/Mpacd4gyqhL2hqRdG/ERW8drcmsZ6zIjqVSYU
        QgGzCsaDDVITCqXkTCWCJw8tSBDkTABBoO2YKPgRdFU9Jk2ImnR8soSLfAWCNuflKfcXBJ1v
        HZNumtGAr7YYF3AkkwDlNicmYAmzDp6+/4EJhplMLQLT8y4kPHDmDAZ9nlqpUEUwi2Go9p1E
        GBcy4Sg2JYq7LoNvnvOEQNNMBPxyRgo0zsyHE41XcaENMGNS6A96SbF+AzzyGDERR8Kg+65U
        xHPBW3SWEDEPvfe7SdFsRGAvb8FFYQ08cr+YjIwzMVDXNHWvRLCPBgnxEjJ4+y1C3EEGZscV
        XKRpKCyQi1AJTRaZaATIv/16qrcGLGWtxEW0wDqdxfpfFuv0VBvCq1EUl8PrUzg+LoM7HMvr
        9HxORkrs/ky9HU38Me9vt8+Jxl7ucyGGQsow2nZvRCsndYf4I3oXAgpXzqTdBcNaOZ2sO3KU
        M2TuMeSkc7wLzaEIZRS9snRAK2dSdNncQY7L4gz/VIwKURhR5EYKv7X1Jhl1q/Pc0s+nIpKd
        mRG01dLg6qVbOvWyXbMOdJRFqVvNDnV/9JbLOafdm3dkje2cMdRxYyT18Yr9SRWBuO2rc93J
        BWkHPdT8ReOqUlUwT4Fc6kvWcW24Wf4sPi3G4zOGFyUqNnUk5RtnP4hWbVEf6F54Pcz7YaO3
        Sknwqbq4JbiB1/0Fmx5qZ18DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsVy+t/xe7p7/3+INfi5idFi44z1rBbXvzxn
        tZh0fwKLxYJPM1gt+h+/ZrY4f34Du8XZpjfsFivufmS12PT4GqvF5V1z2Cw+9x5htJhxfh+T
        xdojd9ktbjeuYLPY1/GAyWLG5JdsDgIeLftusXtsWtXJ5rF5Sb3Hxnc7mDz6tqxi9Pi8SS6A
        LUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEvo//9
        Z5aCqbYVa7duYGpg3KDfxcjBISFgIvFgJn8XIxeHkMBSRokvPyYydjFyAsUlJD6uv8EKYQtL
        /LnWxQZR9IRR4k/bXHaQBK+Ah8SndVOZQWxhATuJZQt2MIHYbAL2Emdvf2MCaRARWM8oMf3y
        SRYQh1mgh0li9rRVYGNZBFQl3qy7xQZyBidQx9QuR4gNXxklJhw/AraBWUBTonX7b3aIM3Qk
        3p7qYwGp5xUQlPi7QxiiRF6ieets5gmMgrOQdMxCqJqFpGoBI/MqRpHU0uLc9NxiQ73ixNzi
        0rx0veT83E2MwCjdduzn5h2MlzYGH2IU4GBU4uFdsP19rBBrYllxZe4hRgkOZiUR3uNt72KF
        eFMSK6tSi/Lji0pzUosPMZoCvTORWUo0OR+YQPJK4g1NDc0tLA3Njc2NzSyUxHk7BA7GCAmk
        J5akZqemFqQWwfQxcXBKNTAa60YXtXjFXU9mEQoNOjRFzX2u7CH3ozceM8uH167WP3Nu4+5j
        djqrRFlC92xl+3t+A3fgglXhkRLvTq4wixB8ZqDnqCZ2sNDRYKpymzarmLD7nqiSRQe3aS24
        /3+On/kq+f/z3k2WM+YQsH1x+6UcJ//1Y+f+fGWw0K2bG24172a1vc7UczVKLMUZiYZazEXF
        iQBiRwlw6AIAAA==
X-CMS-MailID: 20191211143957eucas1p29477538aa5520cf0009cacea907171c3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191209105034eucas1p277be9a40363fec76b4241d28e71e40d2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191209105034eucas1p277be9a40363fec76b4241d28e71e40d2
References: <20191209104902.11904-1-a.swigon@samsung.com>
        <CGME20191209105034eucas1p277be9a40363fec76b4241d28e71e40d2@eucas1p2.samsung.com>
        <20191209104902.11904-5-a.swigon@samsung.com>
        <ab5cd151-0f9f-929e-fcbe-e7fe7b6c8645@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Tue, 2019-12-10 at 13:20 +0900, Chanwoo Choi wrote:
> Hi,
> 
> This patch contains the clean-up code related to 'goto' style.
> Please merge the the clean-up code of 'goto' to one patch with patch3/patch4.
> - patch3 related to 'goto' clean-up code
> - patch4 related to remaining clean-up code. 
> 
> And I added the comment below. Please check them.

OK, I can merge these patches. Please also see my comments below regarding
the issues you highlighted: kzalloc vs. kcalloc, fitting in 80 columns and
changing repeated expressions to variables.

> 
> On 12/9/19 7:49 PM, Artur Świgoń wrote:
> > This patch adds minor improvements to the exynos-bus driver, including
> > cleaning up header includes, variables, and return paths.
> > 
> > Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
> > ---
> >  drivers/devfreq/exynos-bus.c | 56 +++++++++++++++---------------------
> >  1 file changed, 23 insertions(+), 33 deletions(-)
> > 
> > diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> > index 0b557df63666..3eb6a043284a 100644
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
> 
> ditto.
> It depends on personal style. Don't change it because we cannot
> modify them at the all device driver. If is not wrong,
> just keep the original code.

Of course, this is a matter of style, but I think that Coccinelle reports
such code, compare with e.g., https://lkml.org/lkml/2019/5/8/927

Anyway, I can drop it since the purpose of this patchset as a whole was to
untangle all the goto's and I agree this is kind of unrelated.

> 
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
> > @@ -314,15 +311,14 @@ static int exynos_bus_profile_init(struct exynos_bus *bus,
> >  						ondemand_data);
> >  	if (IS_ERR(bus->devfreq)) {
> >  		dev_err(dev, "failed to add devfreq device\n");
> > -		ret = PTR_ERR(bus->devfreq);
> > -		goto err;
> > +		return PTR_ERR(bus->devfreq);
> >  	}
> >  
> >  	/* Register opp_notifier to catch the change of OPP  */
> >  	ret = devm_devfreq_register_opp_notifier(dev, bus->devfreq);
> >  	if (ret < 0) {
> >  		dev_err(dev, "failed to register opp notifier\n");
> > -		goto err;
> > +		return ret;
> >  	}
> >  
> >  	/*
> > @@ -332,17 +328,16 @@ static int exynos_bus_profile_init(struct exynos_bus *bus,
> >  	ret = exynos_bus_enable_edev(bus);
> >  	if (ret < 0) {
> >  		dev_err(dev, "failed to enable devfreq-event devices\n");
> > -		goto err;
> > +		return ret;
> >  	}
> >  
> >  	ret = exynos_bus_set_event(bus);
> >  	if (ret < 0) {
> >  		dev_err(dev, "failed to set event to devfreq-event devices\n");
> > -		goto err;
> > +		return ret;
> >  	}
> >  
> > -err:
> > -	return ret;
> > +	return 0;
> >  }
> >  
> >  static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
> > @@ -351,7 +346,6 @@ static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
> >  	struct device *dev = bus->dev;
> >  	struct devfreq_passive_data *passive_data;
> >  	struct devfreq *parent_devfreq;
> > -	int ret = 0;
> >  
> >  	/* Initialize the struct profile and governor data for passive device */
> >  	profile->target = exynos_bus_target;
> > @@ -359,30 +353,26 @@ static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
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
> 
> It is not clean-up. It depends on personal style. Don't change it
> because we cannot modify them at the all device driver. If is not wrong,
> just keep the original code.

I wanted to make the code fit in 80 columns (issue reported by
scripts/checkpatch.pl). For the reasons stated in my previous comment,
I am happy to drop this change if you don't like it.

> 
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
> > @@ -400,18 +390,18 @@ static int exynos_bus_probe(struct platform_device *pdev)
> >  		return -EINVAL;
> >  	}
> >  
> > -	bus = devm_kzalloc(&pdev->dev, sizeof(*bus), GFP_KERNEL);
> > +	bus = devm_kzalloc(dev, sizeof(*bus), GFP_KERNEL);
> 
> ditto.
> It depends on personal style. Don't change it because we cannot
> modify them at the all device driver. If is not wrong,
> just keep the original code.

Please note that there exists this variable in exynos_bus_probe():

struct device *dev = &pdev->dev;

but the expression '&pdev->dev' is reused twice more ('dev' itself
is also used). Is there any reason for such inconsistency?

> 
> >  	if (!bus)
> >  		return -ENOMEM;
> >  	mutex_init(&bus->lock);
> > -	bus->dev = &pdev->dev;
> > +	bus->dev = dev;
> 
> ditto.
> It depends on personal style. Don't change it because we cannot
> modify them at the all device driver. If is not wrong,
> just keep the original code.

(See above)

> 
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
> > 
> 

Best regards,
-- 
Artur Świgoń
Samsung R&D Institute Poland
Samsung Electronics


