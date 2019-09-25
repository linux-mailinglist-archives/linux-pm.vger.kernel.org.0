Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB3CBD86C
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2019 08:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393007AbfIYGlT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Sep 2019 02:41:19 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:36249 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392973AbfIYGlS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Sep 2019 02:41:18 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190925064116euoutp01c67c33f6a0314fe19e37f8c74b9d7926~HmzvNJjsa1454614546euoutp01m
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2019 06:41:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190925064116euoutp01c67c33f6a0314fe19e37f8c74b9d7926~HmzvNJjsa1454614546euoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569393676;
        bh=Bj68NB/N+ikzlxVslLYWW0J21T3LehZOHkdVo7fC2VI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FnXEY8CvaftrReZKgaEaW2U7BsNIMWST/TMI4Hd+F0NtsgxTBhzNARP5roZeiHcOQ
         BP5GgJfe0FBrPdXZ89/yOnav4F2TBaY8pakFfksyCxwWkfE/MO3/9Kw6YXPhc2ncgO
         /hPlSA7DcwvJg4dE7MxGHe2R37DDVYvs/O26RHJk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190925064115eucas1p1ddf454971f9368cf1474031ba9ed4d9c~Hmzuscy6X2102721027eucas1p15;
        Wed, 25 Sep 2019 06:41:15 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 47.C6.04309.B0C0B8D5; Wed, 25
        Sep 2019 07:41:15 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190925064115eucas1p14b4c7e814eb15e8f6d12844bf96bd88b~HmzuODdfg2103221032eucas1p15;
        Wed, 25 Sep 2019 06:41:15 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190925064115eusmtrp1e1b363fcc9490be13382767e7ec79a51~HmzuMvBPC1533415334eusmtrp13;
        Wed, 25 Sep 2019 06:41:15 +0000 (GMT)
X-AuditID: cbfec7f4-afbff700000010d5-56-5d8b0c0bbd2d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 0F.19.04117.B0C0B8D5; Wed, 25
        Sep 2019 07:41:15 +0100 (BST)
Received: from AMDC3555 (unknown [106.120.51.67]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20190925064114eusmtip15b55d84a1628fee39ca77b7f7f5cf876~HmztYG7Al2870328703eusmtip1J;
        Wed, 25 Sep 2019 06:41:14 +0000 (GMT)
Message-ID: <553c5b7ad82f94272e5ef414435d3509f7b7d054.camel@samsung.com>
Subject: Re: [RFC PATCH v2 01/11] devfreq: exynos-bus: Extract
 exynos_bus_profile_init()
From:   Artur =?UTF-8?Q?=C5=9Awigo=C5=84?= <a.swigon@samsung.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        georgi.djakov@linaro.org, leonard.crestez@nxp.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com, krzk@kernel.org
Date:   Wed, 25 Sep 2019 08:41:14 +0200
In-Reply-To: <9cd6267e-cc06-107e-9bdf-33d4b66f35da@samsung.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRTut7t7d13ObjPcISVrVFKUVgy89A4q7h9SIqGwkFx6m9K2atf1
        hFppUdNM1HBppKWkW4Q6tUzKYC1XSluPoYGN2cwekpqpvVBp8yr133e+73znOwcOiUlf4wvJ
        LF02q9epNHJCLLzX/tu9em5oXuoajz+G9t04j+gGcx1Od499wukKhwunPePDBF36yEbQRb5C
        Ie1214voWu8ITtv6unD6Tet1gh697EC02d0moO86vCK652wtQZuLvxBbKcZmvUQw77oeEowv
        zylgGqvPMA1DLQKmoMmKmFHbokSRUrwxg9VkHWX1cZvTxJk/XVPocHXycX+P2IhebjOhEBIo
        BViMj4UmJCalVC2CN90dBF+MIbjVWC/ii1EE+Q9yhbOWP76vM0INgquOepwvPiK4X+wngl0S
        ioHnlgksiMMpJbi8I9OYoLbAi54fgqBhATWE4MPjb9MCRnkRdLxdHMRCahlUlZun+ZCAofem
        R8BHr4LBjoLAGmQgYD5MtoTz1mjIaS7HgjOBGhfBhM0p4vu3Q+51C8HjcBhwNs3wUdBZnD9z
        Dgf9D3w4bzYisN12YLywAZ44X+HBMIxaAXWtcTy9DSz+EUGQBioM3g7O53cIg6J7pRhPS+Di
        BSkP5dB6LYw3Apy70zUzm4E+ZyUqREvK/t1S9t8tZf9SKxFmRTLWwGnVLLdOxx6L5VRazqBT
        x6Yf0tpQ4NM6p5xjLah1Yr8dUSSSh0q24qZUKa46yp3Q2hGQmHyBpCwqQEkyVCdOsvpD+/QG
        DcvZUSQplMskp+b07pVSalU2e5BlD7P6WVVAhiw0onlR23N0n5dWRe9I+uS8XLCobRh/n9gj
        ikpvbLYaJ0sVv5NkqaLdkSlpisLjv7p2flf0l9dYho901vkijnj0uc2D8Sb44jvgR8pdakGy
        oWKqJGHymStDfNqbfQUeDVQ87be3m1JkJVZuU1tCYYTTzC6PX69Rxrc3xGT17ilJlwu5TNXa
        lZieU/0FG9uoc2UDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsVy+t/xu7rcPN2xBsuXc1rcn9fKaLFxxnpW
        i+tfnrNazD9yjtXiytf3bBbT925is5h0fwKLxfnzG9gtVtz9yGqx6fE1VovLu+awWXzuPcJo
        MeP8PiaLtUfuslvcblzBZjFj8ks2BwGPTas62TzuXNvD5nG/+ziTx+Yl9R4b3+1g8ujbsorR
        4/MmuQD2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27
        BL2M7+f+MRYsCat4dJurgfGCYxcjJ4eEgInEr/tv2LsYuTiEBJYySrR1fWOBSEhIfFx/gxXC
        Fpb4c62LDaLoCaPE/cUr2EASvAIeEidX/mEGsYUFoiTO3f0IZrMJ2Eucvf2NCaRBROA9o8SH
        7e/AVjAL3GOUeLHxJNhYFgFVicWzZ4B1cAJ1PFh4hQlixUsmiaMvJoAVMQtoSrRu/80OcYeO
        xNtTfUD3cQCtFpT4u0MYokReonnrbOYJjIKzkHTMQqiahaRqASPzKkaR1NLi3PTcYiO94sTc
        4tK8dL3k/NxNjMCI3Xbs55YdjF3vgg8xCnAwKvHwOrB2xQqxJpYVV+YeYpTgYFYS4Z0lAxTi
        TUmsrEotyo8vKs1JLT7EaAr0z0RmKdHkfGAyySuJNzQ1NLewNDQ3Njc2s1AS5+0QOBgjJJCe
        WJKanZpakFoE08fEwSnVwBj68OjNOfFbkngVNt62YbA0+XRccv1fPRUjJpk67zs5W0/rmSW5
        3XrivDZk5dq2xUyXn03lsWLOYGMvnLxAOH/urYnPJRweFme9bQs8tjF7SUjv9/vrZ/1xv/Jj
        KRejyF4GS43uLhdRhm1eK1eutmWW2nZjt4xj593NR4+H9OaeCKsRS732+YMSS3FGoqEWc1Fx
        IgCv7v2j7gIAAA==
X-CMS-MailID: 20190925064115eucas1p14b4c7e814eb15e8f6d12844bf96bd88b
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
        <f51aac4cacb7a0196ab6919b110ad9fcf4009c88.camel@samsung.com>
        <9cd6267e-cc06-107e-9bdf-33d4b66f35da@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2019-09-25 at 15:37 +0900, Chanwoo Choi wrote:
> Hi,
> 
> On 19. 9. 25. 오후 2:44, Artur Świgoń wrote:
> > Hi,
> > 
> > On Fri, 2019-09-20 at 11:15 +0900, Chanwoo Choi wrote:
> > > Hi,
> > > 
> > > As I already replied on v1, patch1/2/3 clean-up code
> > > for readability without any behavior changes. 
> > > 
> > > I think that you better to merge patch1/2/3 to one patch.
> > 
> > Yes, when writing the cover letter I think I forgot to explain why I decided not
> > to merge these patches. Basically, none of the diff algorithms available in git
> > (I've got v2.17.1) is able to produce a readable patch with these changes
> > combined together into a single patch (functions are intermixed together in the
> > output, git thinks that 'exynos_bus_probe' is a new function).
> 
> After merged three patches, as you commented, looks like that 'exynos_bus_probe'
> is new function. Your patch style(three patches) is better than one merged patch.
> Keep your original patches. Thanks.

I know that having three separate patches is suboptimal, but they are more readable
this way. I am glad you agree. I will keep them separate. Thank you for your
comments.

> > 
> > Please take a look at the diff at the bottom of this message to see how patches
> > 01..03 look when combined. If such patch looks acceptable to you, I can merge.
> > 
> > > On 19. 9. 19. 오후 11:22, Artur Świgoń wrote:
> > > > From: Artur Świgoń <a.swigon@partner.samsung.com>
> > > > 
> > > > This patch adds a new static function, exynos_bus_profile_init(), extracted
> > > > from exynos_bus_probe().
> > > > 
> > > > Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
> > > > ---
> > > >  drivers/devfreq/exynos-bus.c | 92 +++++++++++++++++++++---------------
> > > >  1 file changed, 53 insertions(+), 39 deletions(-)
> > > > 
> > > > diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> > > > index 29f422469960..78f38b7fb596 100644
> > > > --- a/drivers/devfreq/exynos-bus.c
> > > > +++ b/drivers/devfreq/exynos-bus.c
> > > > @@ -287,12 +287,62 @@ static int exynos_bus_parse_of(struct device_node *np,
> > > >  	return ret;
> > > >  }
> > > >  
> > > > +static int exynos_bus_profile_init(struct exynos_bus *bus,
> > > > +				   struct devfreq_dev_profile *profile)
> > > > +{
> > > > +	struct device *dev = bus->dev;
> > > > +	struct devfreq_simple_ondemand_data *ondemand_data;
> > > > +	int ret;
> > > > +
> > > > +	/* Initialize the struct profile and governor data for parent device */
> > > > +	profile->polling_ms = 50;
> > > > +	profile->target = exynos_bus_target;
> > > > +	profile->get_dev_status = exynos_bus_get_dev_status;
> > > > +	profile->exit = exynos_bus_exit;
> > > > +
> > > > +	ondemand_data = devm_kzalloc(dev, sizeof(*ondemand_data), GFP_KERNEL);
> > > > +	if (!ondemand_data) {
> > > > +		ret = -ENOMEM;
> > > > +		goto err;
> > > > +	}
> > > > +	ondemand_data->upthreshold = 40;
> > > > +	ondemand_data->downdifferential = 5;
> > > > +
> > > > +	/* Add devfreq device to monitor and handle the exynos bus */
> > > > +	bus->devfreq = devm_devfreq_add_device(dev, profile,
> > > > +						DEVFREQ_GOV_SIMPLE_ONDEMAND,
> > > > +						ondemand_data);
> > > > +	if (IS_ERR(bus->devfreq)) {
> > > > +		dev_err(dev, "failed to add devfreq device\n");
> > > > +		ret = PTR_ERR(bus->devfreq);
> > > > +		goto err;
> > > > +	}
> > > > +
> > > > +	/*
> > > > +	 * Enable devfreq-event to get raw data which is used to determine
> > > > +	 * current bus load.
> > > > +	 */
> > > > +	ret = exynos_bus_enable_edev(bus);
> > > > +	if (ret < 0) {
> > > > +		dev_err(dev, "failed to enable devfreq-event devices\n");
> > > > +		goto err;
> > > > +	}
> > > > +
> > > > +	ret = exynos_bus_set_event(bus);
> > > > +	if (ret < 0) {
> > > > +		dev_err(dev, "failed to set event to devfreq-event devices\n");
> > > > +		goto err;
> > > > +	}
> > > > +
> > > > +err:
> > > > +	return ret;
> > > > +}
> > > > +
> > > >  static int exynos_bus_probe(struct platform_device *pdev)
> > > >  {
> > > >  	struct device *dev = &pdev->dev;
> > > >  	struct device_node *np = dev->of_node, *node;
> > > >  	struct devfreq_dev_profile *profile;
> > > > -	struct devfreq_simple_ondemand_data *ondemand_data;
> > > >  	struct devfreq_passive_data *passive_data;
> > > >  	struct devfreq *parent_devfreq;
> > > >  	struct exynos_bus *bus;
> > > > @@ -334,45 +384,9 @@ static int exynos_bus_probe(struct platform_device *pdev)
> > > >  	if (passive)
> > > >  		goto passive;
> > > >  
> > > > -	/* Initialize the struct profile and governor data for parent device */
> > > > -	profile->polling_ms = 50;
> > > > -	profile->target = exynos_bus_target;
> > > > -	profile->get_dev_status = exynos_bus_get_dev_status;
> > > > -	profile->exit = exynos_bus_exit;
> > > > -
> > > > -	ondemand_data = devm_kzalloc(dev, sizeof(*ondemand_data), GFP_KERNEL);
> > > > -	if (!ondemand_data) {
> > > > -		ret = -ENOMEM;
> > > > +	ret = exynos_bus_profile_init(bus, profile);
> > > > +	if (ret < 0)
> > > >  		goto err;
> > > > -	}
> > > > -	ondemand_data->upthreshold = 40;
> > > > -	ondemand_data->downdifferential = 5;
> > > > -
> > > > -	/* Add devfreq device to monitor and handle the exynos bus */
> > > > -	bus->devfreq = devm_devfreq_add_device(dev, profile,
> > > > -						DEVFREQ_GOV_SIMPLE_ONDEMAND,
> > > > -						ondemand_data);
> > > > -	if (IS_ERR(bus->devfreq)) {
> > > > -		dev_err(dev, "failed to add devfreq device\n");
> > > > -		ret = PTR_ERR(bus->devfreq);
> > > > -		goto err;
> > > > -	}
> > > > -
> > > > -	/*
> > > > -	 * Enable devfreq-event to get raw data which is used to determine
> > > > -	 * current bus load.
> > > > -	 */
> > > > -	ret = exynos_bus_enable_edev(bus);
> > > > -	if (ret < 0) {
> > > > -		dev_err(dev, "failed to enable devfreq-event devices\n");
> > > > -		goto err;
> > > > -	}
> > > > -
> > > > -	ret = exynos_bus_set_event(bus);
> > > > -	if (ret < 0) {
> > > > -		dev_err(dev, "failed to set event to devfreq-event devices\n");
> > > > -		goto err;
> > > > -	}
> > > >  
> > > >  	goto out;
> > > >  passive:
> > 
> > commit cacf8e4ea0e111908d11779977c81e29d6418801
> > Author: Artur Świgoń <a.swigon@partner.samsung.com>
> > Date:   Tue Aug 27 13:17:28 2019 +0200
> > 
> >     tmp: merge patches 01-03
> >     
> >     Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
> > 
> > diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> > index 29f422469960..60ad4319fd80 100644
> > --- a/drivers/devfreq/exynos-bus.c
> > +++ b/drivers/devfreq/exynos-bus.c
> > @@ -287,52 +287,12 @@ static int exynos_bus_parse_of(struct device_node *np,
> >  	return ret;
> >  }
> >  
> > -static int exynos_bus_probe(struct platform_device *pdev)
> > +static int exynos_bus_profile_init(struct exynos_bus *bus,
> > +				   struct devfreq_dev_profile *profile)
> >  {
> > -	struct device *dev = &pdev->dev;
> > -	struct device_node *np = dev->of_node, *node;
> > -	struct devfreq_dev_profile *profile;
> > +	struct device *dev = bus->dev;
> >  	struct devfreq_simple_ondemand_data *ondemand_data;
> > -	struct devfreq_passive_data *passive_data;
> > -	struct devfreq *parent_devfreq;
> > -	struct exynos_bus *bus;
> > -	int ret, max_state;
> > -	unsigned long min_freq, max_freq;
> > -	bool passive = false;
> > -
> > -	if (!np) {
> > -		dev_err(dev, "failed to find devicetree node\n");
> > -		return -EINVAL;
> > -	}
> > -
> > -	bus = devm_kzalloc(&pdev->dev, sizeof(*bus), GFP_KERNEL);
> > -	if (!bus)
> > -		return -ENOMEM;
> > -	mutex_init(&bus->lock);
> > -	bus->dev = &pdev->dev;
> > -	platform_set_drvdata(pdev, bus);
> > -
> > -	profile = devm_kzalloc(dev, sizeof(*profile), GFP_KERNEL);
> > -	if (!profile)
> > -		return -ENOMEM;
> > -
> > -	node = of_parse_phandle(dev->of_node, "devfreq", 0);
> > -	if (node) {
> > -		of_node_put(node);
> > -		passive = true;
> > -	} else {
> > -		ret = exynos_bus_parent_parse_of(np, bus);
> > -		if (ret < 0)
> > -			return ret;
> > -	}
> > -
> > -	/* Parse the device-tree to get the resource information */
> > -	ret = exynos_bus_parse_of(np, bus);
> > -	if (ret < 0)
> > -		goto err_reg;
> > -
> > -	if (passive)
> > -		goto passive;
> > +	int ret;
> >  
> >  	/* Initialize the struct profile and governor data for parent device */
> >  	profile->polling_ms = 50;
> > @@ -374,8 +334,18 @@ static int exynos_bus_probe(struct platform_device *pdev)
> >  		goto err;
> >  	}
> >  
> > -	goto out;
> > -passive:
> > +err:
> > +	return ret;
> > +}
> > +
> > +static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
> > +					   struct devfreq_dev_profile *profile)
> > +{
> > +	struct device *dev = bus->dev;
> > +	struct devfreq_passive_data *passive_data;
> > +	struct devfreq *parent_devfreq;
> > +	int ret = 0;
> > +
> >  	/* Initialize the struct profile and governor data for passive device */
> >  	profile->target = exynos_bus_target;
> >  	profile->exit = exynos_bus_passive_exit;
> > @@ -404,7 +374,59 @@ static int exynos_bus_probe(struct platform_device *pdev)
> >  		goto err;
> >  	}
> >  
> > -out:
> > +err:
> > +	return ret;
> > +}
> > +
> > +static int exynos_bus_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct device_node *np = dev->of_node, *node;
> > +	struct devfreq_dev_profile *profile;
> > +	struct exynos_bus *bus;
> > +	int ret, max_state;
> > +	unsigned long min_freq, max_freq;
> > +	bool passive = false;
> > +
> > +	if (!np) {
> > +		dev_err(dev, "failed to find devicetree node\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	bus = devm_kzalloc(&pdev->dev, sizeof(*bus), GFP_KERNEL);
> > +	if (!bus)
> > +		return -ENOMEM;
> > +	mutex_init(&bus->lock);
> > +	bus->dev = &pdev->dev;
> > +	platform_set_drvdata(pdev, bus);
> > +
> > +	profile = devm_kzalloc(dev, sizeof(*profile), GFP_KERNEL);
> > +	if (!profile)
> > +		return -ENOMEM;
> > +
> > +	node = of_parse_phandle(dev->of_node, "devfreq", 0);
> > +	if (node) {
> > +		of_node_put(node);
> > +		passive = true;
> > +	} else {
> > +		ret = exynos_bus_parent_parse_of(np, bus);
> > +		if (ret < 0)
> > +			return ret;
> > +	}
> > +
> > +	/* Parse the device-tree to get the resource information */
> > +	ret = exynos_bus_parse_of(np, bus);
> > +	if (ret < 0)
> > +		goto err_reg;
> > +
> > +	if (passive)
> > +		ret = exynos_bus_profile_init_passive(bus, profile);
> > +	else
> > +		ret = exynos_bus_profile_init(bus, profile);
> > +
> > +	if (ret < 0)
> > +		goto err;
> > +
> >  	max_state = bus->devfreq->profile->max_state;
> >  	min_freq = (bus->devfreq->profile->freq_table[0] / 1000);
> >  	max_freq = (bus->devfreq->profile->freq_table[max_state - 1] / 1000);
> > 
> > 
> > 
> > 
> 
> 
-- 
Artur Świgoń
Samsung R&D Institute Poland
Samsung Electronics


