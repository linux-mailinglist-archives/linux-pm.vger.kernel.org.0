Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB393BD7DB
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2019 07:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408164AbfIYFom (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Sep 2019 01:44:42 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57128 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404629AbfIYFom (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Sep 2019 01:44:42 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190925054438euoutp026f0502f711adcc06ee81216ffe2b48bd~HmCTHaK-g1314313143euoutp02F
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2019 05:44:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190925054438euoutp026f0502f711adcc06ee81216ffe2b48bd~HmCTHaK-g1314313143euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569390278;
        bh=kYIVoeIsDZViEyQtoAUGXK4fxaz0KwTD7EylbtIhnqY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HwblHVWgUg45oQOao8CkgXOzQ0d3qfnEH2faJeR9CDcI4CjKwA/dttL96cTe6Rm4A
         j1o2vCrh7CPq7ItV/XPN5BZbfLceIi6icRdzMCBKRMYIwyrsBsJlqSkC3a3XnpPHH7
         3ACNyBLlUD6I7UhJ4s5uydXnPDXtrNJdFxVm2FH0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190925054437eucas1p108c8908cb95482cff91297ba3fa5a2e2~HmCRwrvU62405424054eucas1p15;
        Wed, 25 Sep 2019 05:44:37 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id A8.80.04469.5CEFA8D5; Wed, 25
        Sep 2019 06:44:37 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190925054437eucas1p1faa58a48a75c43fd5b5c7424e3d658e7~HmCRdetQF1488914889eucas1p1b;
        Wed, 25 Sep 2019 05:44:37 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190925054437eusmtrp12dae90d5d9dd472b8fbea5f7cbab0880~HmCRcM_cn1789117891eusmtrp1F;
        Wed, 25 Sep 2019 05:44:37 +0000 (GMT)
X-AuditID: cbfec7f2-54fff70000001175-b2-5d8afec5d574
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A6.64.04117.4CEFA8D5; Wed, 25
        Sep 2019 06:44:36 +0100 (BST)
Received: from AMDC3555 (unknown [106.120.51.67]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20190925054436eusmtip11d852d14d1080b152186c05430a580ba~HmCQp4U1h2516225162eusmtip1Z;
        Wed, 25 Sep 2019 05:44:36 +0000 (GMT)
Message-ID: <f51aac4cacb7a0196ab6919b110ad9fcf4009c88.camel@samsung.com>
Subject: Re: [RFC PATCH v2 01/11] devfreq: exynos-bus: Extract
 exynos_bus_profile_init()
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
Date:   Wed, 25 Sep 2019 07:44:35 +0200
In-Reply-To: <2e49bd2c-e074-038b-f8a2-7dd8dea4a9af@samsung.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju29k5O0qzr2n4UlI4qCgqEypOVFYUcaB+SPmrqytPOtym7aip
        QS27UCuXTUubXU1KDSnnLJUuNJdLJVdpVl5QnCZaaWtqRddtZ2L/nvc5z+V74NCE7CU5k1Zq
        UjitRqGSU4Hi+/U/HIuf/dHvWvpJD0z31ROIqSi4SzJvRwdI5pqtmWRax0YoJv+RmWKM3Tli
        xuG4J2FKulwkY3a2kUxL7WWKcWfbEFPgeCxiym1dEqbjaAnFFOQOUusway47TbGdbQ8ptvuM
        XcRWFh9hK4arRazBUoZYt3l2tGR74Oo4TqVM47QRUbGBCeO9ODmfTa/vKiF1qGilHgXQgJdB
        7vBtkR4F0jJcguDh+Y+kcIwisOQ1IK9Kht0IdEWSCUejxeEX3UZQ1P9LIhwfEPS4q3wOKWah
        uFZHeHEw3g7NXS4fpvBaeNEx7usLwcMI+p58IbwHgY+LYMA0JPaqxHgumJ898PUFeBxljlZK
        6F4EnxsNHg3taZgOv6uDvTSB58CxqkJCkLgkMGJY45UA3gjHs7YKdDAM2S3+BWHQlHtWLGAe
        +mu6fWsA6xCYb9n8Oaugzv6K9OYQeAHcrY0Q6PVQ2usSCfFB8O7zdOEFQWC8n08ItBROnZQJ
        UA61l4IEI0DWnTZ/NgtO+3WUg8JNk0tM/y0xTbZeR0QZCuVSeXU8x0dquINLeIWaT9XEL9mX
        pDYjz3/W9Mf+tRqNvd5rRZhG8qnSdaR+l4xUpPEZaisCmpCHSE1hHkoap8jI5LRJe7SpKo63
        olm0WB4qPTSlZ4cMxytSuESOS+a0E19FdMBMHcoLi0qZ5mqvSp8Rt2l/zV+Ypor+2axBrbFu
        45aY7xvC3+xsWZFnHd+cdVU978pzw5VHzRfrtJ2FU849GDCmGZ72fVse3FLjJBMzY8uLx/oh
        plJ52HbAeelWUXrHgPJC4s068m92ZfQ2x5epuWtK2wcbfn8y36hIzq46+W33+4+i+flyMZ+g
        iFxIaHnFPyjBADNjAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsVy+t/xu7pH/3XFGvyWsrg/r5XRYuOM9awW
        1788Z7WYf+Qcq8WVr+/ZLKbv3cRmMen+BBaL8+c3sFusuPuR1WLT42usFpd3zWGz+Nx7hNFi
        xvl9TBZrj9xlt7jduILNYsbkl2wOAh6bVnWyedy5tofN4373cSaPzUvqPTa+28Hk0bdlFaPH
        501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJ
        ehnfHgkUTPeoOHZ3BWsD4yLLLkZODgkBE4lTW86zdjFycQgJLGWUWLblEwtEQkLi4/obrBC2
        sMSfa11sEEVPGCW2TT0AVsQr4CGxZFcDM4gtLBAlce7uRzCbTcBe4uztb0wgDSIC7xklPmx/
        xw7iMAu0MUkc6tsMNpZFQFVi09Ht7CA2J1DHqvNXoFZ8ZpTofXaDESTBLKAp0br9NzvEHToS
        b0/1Aa3mAFotKPF3hzBEibxE89bZzBMYBWch6ZiFUDULSdUCRuZVjCKppcW56bnFRnrFibnF
        pXnpesn5uZsYgfG67djPLTsYu94FH2IU4GBU4uF1YO2KFWJNLCuuzD3EKMHBrCTCO0sGKMSb
        klhZlVqUH19UmpNafIjRFOificxSosn5wFSSVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZIID2x
        JDU7NbUgtQimj4mDU6qB0bXZWSdMPKdE+vrT8wpn3jTNuWa487DI/efcW0+wWjaz3735U9x0
        76WHks9nrPv1X85rSv+SC9pVCsdPT3BfqJR4N2HGsZeTQ1eyH4u/oezQeyhjYeL9xnuTn+za
        1re8Q2+tqRmzTNAfL6ePzGGxr+IXxCSEaXu0ms4/wforbMOFTK4zOS/12JVYijMSDbWYi4oT
        ARfkJE7tAgAA
X-CMS-MailID: 20190925054437eucas1p1faa58a48a75c43fd5b5c7424e3d658e7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190919142322eucas1p24bc477ee6e1bcd65546c305d55af097d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190919142322eucas1p24bc477ee6e1bcd65546c305d55af097d
References: <20190919142236.4071-1-a.swigon@samsung.com>
        <CGME20190919142322eucas1p24bc477ee6e1bcd65546c305d55af097d@eucas1p2.samsung.com>
        <20190919142236.4071-2-a.swigon@samsung.com>
        <2e49bd2c-e074-038b-f8a2-7dd8dea4a9af@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Fri, 2019-09-20 at 11:15 +0900, Chanwoo Choi wrote:
> Hi,
> 
> As I already replied on v1, patch1/2/3 clean-up code
> for readability without any behavior changes. 
> 
> I think that you better to merge patch1/2/3 to one patch.

Yes, when writing the cover letter I think I forgot to explain why I decided not
to merge these patches. Basically, none of the diff algorithms available in git
(I've got v2.17.1) is able to produce a readable patch with these changes
combined together into a single patch (functions are intermixed together in the
output, git thinks that 'exynos_bus_probe' is a new function).

Please take a look at the diff at the bottom of this message to see how patches
01..03 look when combined. If such patch looks acceptable to you, I can merge.

> On 19. 9. 19. 오후 11:22, Artur Świgoń wrote:
> > From: Artur Świgoń <a.swigon@partner.samsung.com>
> > 
> > This patch adds a new static function, exynos_bus_profile_init(), extracted
> > from exynos_bus_probe().
> > 
> > Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
> > ---
> >  drivers/devfreq/exynos-bus.c | 92 +++++++++++++++++++++---------------
> >  1 file changed, 53 insertions(+), 39 deletions(-)
> > 
> > diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> > index 29f422469960..78f38b7fb596 100644
> > --- a/drivers/devfreq/exynos-bus.c
> > +++ b/drivers/devfreq/exynos-bus.c
> > @@ -287,12 +287,62 @@ static int exynos_bus_parse_of(struct device_node *np,
> >  	return ret;
> >  }
> >  
> > +static int exynos_bus_profile_init(struct exynos_bus *bus,
> > +				   struct devfreq_dev_profile *profile)
> > +{
> > +	struct device *dev = bus->dev;
> > +	struct devfreq_simple_ondemand_data *ondemand_data;
> > +	int ret;
> > +
> > +	/* Initialize the struct profile and governor data for parent device */
> > +	profile->polling_ms = 50;
> > +	profile->target = exynos_bus_target;
> > +	profile->get_dev_status = exynos_bus_get_dev_status;
> > +	profile->exit = exynos_bus_exit;
> > +
> > +	ondemand_data = devm_kzalloc(dev, sizeof(*ondemand_data), GFP_KERNEL);
> > +	if (!ondemand_data) {
> > +		ret = -ENOMEM;
> > +		goto err;
> > +	}
> > +	ondemand_data->upthreshold = 40;
> > +	ondemand_data->downdifferential = 5;
> > +
> > +	/* Add devfreq device to monitor and handle the exynos bus */
> > +	bus->devfreq = devm_devfreq_add_device(dev, profile,
> > +						DEVFREQ_GOV_SIMPLE_ONDEMAND,
> > +						ondemand_data);
> > +	if (IS_ERR(bus->devfreq)) {
> > +		dev_err(dev, "failed to add devfreq device\n");
> > +		ret = PTR_ERR(bus->devfreq);
> > +		goto err;
> > +	}
> > +
> > +	/*
> > +	 * Enable devfreq-event to get raw data which is used to determine
> > +	 * current bus load.
> > +	 */
> > +	ret = exynos_bus_enable_edev(bus);
> > +	if (ret < 0) {
> > +		dev_err(dev, "failed to enable devfreq-event devices\n");
> > +		goto err;
> > +	}
> > +
> > +	ret = exynos_bus_set_event(bus);
> > +	if (ret < 0) {
> > +		dev_err(dev, "failed to set event to devfreq-event devices\n");
> > +		goto err;
> > +	}
> > +
> > +err:
> > +	return ret;
> > +}
> > +
> >  static int exynos_bus_probe(struct platform_device *pdev)
> >  {
> >  	struct device *dev = &pdev->dev;
> >  	struct device_node *np = dev->of_node, *node;
> >  	struct devfreq_dev_profile *profile;
> > -	struct devfreq_simple_ondemand_data *ondemand_data;
> >  	struct devfreq_passive_data *passive_data;
> >  	struct devfreq *parent_devfreq;
> >  	struct exynos_bus *bus;
> > @@ -334,45 +384,9 @@ static int exynos_bus_probe(struct platform_device *pdev)
> >  	if (passive)
> >  		goto passive;
> >  
> > -	/* Initialize the struct profile and governor data for parent device */
> > -	profile->polling_ms = 50;
> > -	profile->target = exynos_bus_target;
> > -	profile->get_dev_status = exynos_bus_get_dev_status;
> > -	profile->exit = exynos_bus_exit;
> > -
> > -	ondemand_data = devm_kzalloc(dev, sizeof(*ondemand_data), GFP_KERNEL);
> > -	if (!ondemand_data) {
> > -		ret = -ENOMEM;
> > +	ret = exynos_bus_profile_init(bus, profile);
> > +	if (ret < 0)
> >  		goto err;
> > -	}
> > -	ondemand_data->upthreshold = 40;
> > -	ondemand_data->downdifferential = 5;
> > -
> > -	/* Add devfreq device to monitor and handle the exynos bus */
> > -	bus->devfreq = devm_devfreq_add_device(dev, profile,
> > -						DEVFREQ_GOV_SIMPLE_ONDEMAND,
> > -						ondemand_data);
> > -	if (IS_ERR(bus->devfreq)) {
> > -		dev_err(dev, "failed to add devfreq device\n");
> > -		ret = PTR_ERR(bus->devfreq);
> > -		goto err;
> > -	}
> > -
> > -	/*
> > -	 * Enable devfreq-event to get raw data which is used to determine
> > -	 * current bus load.
> > -	 */
> > -	ret = exynos_bus_enable_edev(bus);
> > -	if (ret < 0) {
> > -		dev_err(dev, "failed to enable devfreq-event devices\n");
> > -		goto err;
> > -	}
> > -
> > -	ret = exynos_bus_set_event(bus);
> > -	if (ret < 0) {
> > -		dev_err(dev, "failed to set event to devfreq-event devices\n");
> > -		goto err;
> > -	}
> >  
> >  	goto out;
> >  passive:

commit cacf8e4ea0e111908d11779977c81e29d6418801
Author: Artur Świgoń <a.swigon@partner.samsung.com>
Date:   Tue Aug 27 13:17:28 2019 +0200

    tmp: merge patches 01-03
    
    Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 29f422469960..60ad4319fd80 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -287,52 +287,12 @@ static int exynos_bus_parse_of(struct device_node *np,
 	return ret;
 }
 
-static int exynos_bus_probe(struct platform_device *pdev)
+static int exynos_bus_profile_init(struct exynos_bus *bus,
+				   struct devfreq_dev_profile *profile)
 {
-	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node, *node;
-	struct devfreq_dev_profile *profile;
+	struct device *dev = bus->dev;
 	struct devfreq_simple_ondemand_data *ondemand_data;
-	struct devfreq_passive_data *passive_data;
-	struct devfreq *parent_devfreq;
-	struct exynos_bus *bus;
-	int ret, max_state;
-	unsigned long min_freq, max_freq;
-	bool passive = false;
-
-	if (!np) {
-		dev_err(dev, "failed to find devicetree node\n");
-		return -EINVAL;
-	}
-
-	bus = devm_kzalloc(&pdev->dev, sizeof(*bus), GFP_KERNEL);
-	if (!bus)
-		return -ENOMEM;
-	mutex_init(&bus->lock);
-	bus->dev = &pdev->dev;
-	platform_set_drvdata(pdev, bus);
-
-	profile = devm_kzalloc(dev, sizeof(*profile), GFP_KERNEL);
-	if (!profile)
-		return -ENOMEM;
-
-	node = of_parse_phandle(dev->of_node, "devfreq", 0);
-	if (node) {
-		of_node_put(node);
-		passive = true;
-	} else {
-		ret = exynos_bus_parent_parse_of(np, bus);
-		if (ret < 0)
-			return ret;
-	}
-
-	/* Parse the device-tree to get the resource information */
-	ret = exynos_bus_parse_of(np, bus);
-	if (ret < 0)
-		goto err_reg;
-
-	if (passive)
-		goto passive;
+	int ret;
 
 	/* Initialize the struct profile and governor data for parent device */
 	profile->polling_ms = 50;
@@ -374,8 +334,18 @@ static int exynos_bus_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	goto out;
-passive:
+err:
+	return ret;
+}
+
+static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
+					   struct devfreq_dev_profile *profile)
+{
+	struct device *dev = bus->dev;
+	struct devfreq_passive_data *passive_data;
+	struct devfreq *parent_devfreq;
+	int ret = 0;
+
 	/* Initialize the struct profile and governor data for passive device */
 	profile->target = exynos_bus_target;
 	profile->exit = exynos_bus_passive_exit;
@@ -404,7 +374,59 @@ static int exynos_bus_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-out:
+err:
+	return ret;
+}
+
+static int exynos_bus_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node, *node;
+	struct devfreq_dev_profile *profile;
+	struct exynos_bus *bus;
+	int ret, max_state;
+	unsigned long min_freq, max_freq;
+	bool passive = false;
+
+	if (!np) {
+		dev_err(dev, "failed to find devicetree node\n");
+		return -EINVAL;
+	}
+
+	bus = devm_kzalloc(&pdev->dev, sizeof(*bus), GFP_KERNEL);
+	if (!bus)
+		return -ENOMEM;
+	mutex_init(&bus->lock);
+	bus->dev = &pdev->dev;
+	platform_set_drvdata(pdev, bus);
+
+	profile = devm_kzalloc(dev, sizeof(*profile), GFP_KERNEL);
+	if (!profile)
+		return -ENOMEM;
+
+	node = of_parse_phandle(dev->of_node, "devfreq", 0);
+	if (node) {
+		of_node_put(node);
+		passive = true;
+	} else {
+		ret = exynos_bus_parent_parse_of(np, bus);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* Parse the device-tree to get the resource information */
+	ret = exynos_bus_parse_of(np, bus);
+	if (ret < 0)
+		goto err_reg;
+
+	if (passive)
+		ret = exynos_bus_profile_init_passive(bus, profile);
+	else
+		ret = exynos_bus_profile_init(bus, profile);
+
+	if (ret < 0)
+		goto err;
+
 	max_state = bus->devfreq->profile->max_state;
 	min_freq = (bus->devfreq->profile->freq_table[0] / 1000);
 	max_freq = (bus->devfreq->profile->freq_table[max_state - 1] / 1000);


