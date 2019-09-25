Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49B10BD855
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2019 08:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442303AbfIYGdB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Sep 2019 02:33:01 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:55610 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392757AbfIYGc5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Sep 2019 02:32:57 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190925063254epoutp0444f2ea700e4ed6be0539b46d0a6586e6~HmsbjW-TJ0170601706epoutp04J
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2019 06:32:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190925063254epoutp0444f2ea700e4ed6be0539b46d0a6586e6~HmsbjW-TJ0170601706epoutp04J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569393174;
        bh=3RHMQOQYtx91rCjq27d9iH+kHM/I4Tk34xpdKdRynuI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=b271LUd1LAd5aRNFzxG728pcKU252Vls2BQYWJTPokcOjO88rfglFeOSXlTzBxMLl
         r5pt6Sm4C0i1q3jR56REdXU7alTqrDl2k5Al31hvoa6M2Mklv35WSG3U+jgL98OZ1B
         6VbpMRRHeX++RDdEEMAN+996HGZGT/jT3rXHD4KM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190925063253epcas1p4a006fdbc7560ebc63f04afa5c0c809ec~HmsbHJtBE3090230902epcas1p4r;
        Wed, 25 Sep 2019 06:32:53 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.154]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 46dSsv3zpfzMqYkd; Wed, 25 Sep
        2019 06:32:51 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        31.27.04144.11A0B8D5; Wed, 25 Sep 2019 15:32:49 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190925063248epcas1p11c706bd96e80cfc9f24f930bbc4ed9e6~HmsWSXB8v1118211182epcas1p1a;
        Wed, 25 Sep 2019 06:32:48 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190925063248epsmtrp1df0f345e0b1698bd535c2568c4955eb4~HmsWO2mYr2252422524epsmtrp1P;
        Wed, 25 Sep 2019 06:32:48 +0000 (GMT)
X-AuditID: b6c32a35-2dfff70000001030-fb-5d8b0a11f9d4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C1.EC.03889.01A0B8D5; Wed, 25 Sep 2019 15:32:48 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190925063248epsmtip2d4c33388f7e82c2f45da11d4c35ada8e~HmsV0j9rG2324723247epsmtip2K;
        Wed, 25 Sep 2019 06:32:48 +0000 (GMT)
Subject: Re: [RFC PATCH v2 01/11] devfreq: exynos-bus: Extract
 exynos_bus_profile_init()
To:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     myungjoo.ham@samsung.com, inki.dae@samsung.com,
        sw0312.kim@samsung.com, georgi.djakov@linaro.org,
        leonard.crestez@nxp.com, m.szyprowski@samsung.com,
        b.zolnierkie@samsung.com, krzk@kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <9cd6267e-cc06-107e-9bdf-33d4b66f35da@samsung.com>
Date:   Wed, 25 Sep 2019 15:37:11 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f51aac4cacb7a0196ab6919b110ad9fcf4009c88.camel@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBJsWRmVeSWpSXmKPExsWy7bCmvq4gV3eswZx1LBb357UyWmycsZ7V
        Yv6Rc6wWV76+Z7OYvncTm8Wk+xNYLM6f38BuseLuR1aLTY+vsVpc3jWHzeJz7xFGixnn9zFZ
        rD1yl93iduMKNosZk1+yOfB7bFrVyeZx59oeNo/73ceZPDYvqffY+G4Hk0ffllWMHp83yQWw
        R2XbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gDdraRQ
        lphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpsCzQK07MLS7NS9dLzs+1MjQwMDIFKkzI
        zpjddY+tYKNvxZKlb1gbGC/YdjFyckgImEhMu7CYpYuRi0NIYAejROPjHVDOJ0aJRwcvsYJU
        CQl8Y5R4fMQGpqOp8TojRNFeRom1t9dCdbxnlFjx6zELSJWwQJTEubsfmUESIgL/GSVOL1vJ
        CuIwCxxjlNh75ydYFZuAlsT+FzfYQGx+AUWJqz8eM4LYvAJ2ElPufAbbzSKgKtFz9iuYLSoQ
        IfHpwWFWiBpBiZMzn4DN4RTwlFjacpsJxGYWEJe49WQ+lC0v0bx1NtgVEgK72CXOX/vFDPGE
        i8S8WYeYIGxhiVfHt7BD2FISL/vboOxqiZUnj7BBNHcwSmzZf4EVImEssX/pZKBmDqANmhLr
        d+lDhBUldv6eywixmE/i3dceVpASCQFeiY42IYgSZYnLD+5CrZWUWNzeyTaBUWkWkndmIXlh
        FpIXZiEsW8DIsopRLLWgODc9tdiwwBA5vjcxglO1lukOxinnfA4xCnAwKvHwOrB2xQqxJpYV
        V+YeYpTgYFYS4Z0lAxTiTUmsrEotyo8vKs1JLT7EaAoM7YnMUqLJ+cA8klcSb2hqZGxsbGFi
        aGZqaKgkzuuR3hArJJCeWJKanZpakFoE08fEwSnVwCigGKyu/DeY7cG/qMx+AfXfPHIZTqd/
        dJ9L2C8hsHiRwrtTWnqzdpxrX346YENW4CwLpvV1C65+fXx0pWfEd2GtJ3sSlZle7az/tMhz
        ZtM/3h/3v9idPBCzqY2TZ1/0ixUMF9buzJwS8mHT2iviVyV6tKZEtQXHSKafvysmq+EnV6PY
        qfnV77ASS3FGoqEWc1FxIgCC08Ag6wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsWy7bCSvK4AV3esweF3Ehb357UyWmycsZ7V
        Yv6Rc6wWV76+Z7OYvncTm8Wk+xNYLM6f38BuseLuR1aLTY+vsVpc3jWHzeJz7xFGixnn9zFZ
        rD1yl93iduMKNosZk1+yOfB7bFrVyeZx59oeNo/73ceZPDYvqffY+G4Hk0ffllWMHp83yQWw
        R3HZpKTmZJalFunbJXBlzO66x1aw0bdiydI3rA2MF2y7GDk5JARMJJoarzN2MXJxCAnsZpT4
        fmwJC0RCUmLaxaPMXYwcQLawxOHDxRA1bxkl+m6/ZgOpERaIkjh39yMzSEJE4D+jxMO2Y2CT
        mAWOMUp8XLGeFaJlPZPEkg8NYGPZBLQk9r+4AdbOL6AocfXHY0YQm1fATmLKnc+sIDaLgKpE
        z9mvYLaoQITE4R2zoGoEJU7OfAI2h1PAU2Jpy20mEJtZQF3iz7xLzBC2uMStJ/Oh4vISzVtn
        M09gFJ6FpH0WkpZZSFpmIWlZwMiyilEytaA4Nz232LDAKC+1XK84Mbe4NC9dLzk/dxMjOGq1
        tHYwnjgRf4hRgINRiYfXgbUrVog1say4MvcQowQHs5II7ywZoBBvSmJlVWpRfnxRaU5q8SFG
        aQ4WJXFe+fxjkUIC6YklqdmpqQWpRTBZJg5OqQbGmYn6sXr3atpElGXaG54vEjfNk0pkzb7c
        dae4YvIt1lqjzV0ZslM3NDw5H3V2b9LBV4Fx2n2nZz445ztv6rFtUteMF34Sv34l7q9WRYWk
        dHzt1KVK59X0mJwC3nobPQs1j9+T98wqPj/dgvlaXkpvlYrFiusLki++0ZwS+GvFJIN1d89k
        HzylxFKckWioxVxUnAgAkQH59dYCAAA=
X-CMS-MailID: 20190925063248epcas1p11c706bd96e80cfc9f24f930bbc4ed9e6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190919142322eucas1p24bc477ee6e1bcd65546c305d55af097d
References: <20190919142236.4071-1-a.swigon@samsung.com>
        <CGME20190919142322eucas1p24bc477ee6e1bcd65546c305d55af097d@eucas1p2.samsung.com>
        <20190919142236.4071-2-a.swigon@samsung.com>
        <2e49bd2c-e074-038b-f8a2-7dd8dea4a9af@samsung.com>
        <f51aac4cacb7a0196ab6919b110ad9fcf4009c88.camel@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 19. 9. 25. 오후 2:44, Artur Świgoń wrote:
> Hi,
> 
> On Fri, 2019-09-20 at 11:15 +0900, Chanwoo Choi wrote:
>> Hi,
>>
>> As I already replied on v1, patch1/2/3 clean-up code
>> for readability without any behavior changes. 
>>
>> I think that you better to merge patch1/2/3 to one patch.
> 
> Yes, when writing the cover letter I think I forgot to explain why I decided not
> to merge these patches. Basically, none of the diff algorithms available in git
> (I've got v2.17.1) is able to produce a readable patch with these changes
> combined together into a single patch (functions are intermixed together in the
> output, git thinks that 'exynos_bus_probe' is a new function).

After merged three patches, as you commented, looks like that 'exynos_bus_probe'
is new function. Your patch style(three patches) is better than one merged patch.
Keep your original patches. Thanks.

> 
> Please take a look at the diff at the bottom of this message to see how patches
> 01..03 look when combined. If such patch looks acceptable to you, I can merge.
> 
>> On 19. 9. 19. 오후 11:22, Artur Świgoń wrote:
>>> From: Artur Świgoń <a.swigon@partner.samsung.com>
>>>
>>> This patch adds a new static function, exynos_bus_profile_init(), extracted
>>> from exynos_bus_probe().
>>>
>>> Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
>>> ---
>>>  drivers/devfreq/exynos-bus.c | 92 +++++++++++++++++++++---------------
>>>  1 file changed, 53 insertions(+), 39 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
>>> index 29f422469960..78f38b7fb596 100644
>>> --- a/drivers/devfreq/exynos-bus.c
>>> +++ b/drivers/devfreq/exynos-bus.c
>>> @@ -287,12 +287,62 @@ static int exynos_bus_parse_of(struct device_node *np,
>>>  	return ret;
>>>  }
>>>  
>>> +static int exynos_bus_profile_init(struct exynos_bus *bus,
>>> +				   struct devfreq_dev_profile *profile)
>>> +{
>>> +	struct device *dev = bus->dev;
>>> +	struct devfreq_simple_ondemand_data *ondemand_data;
>>> +	int ret;
>>> +
>>> +	/* Initialize the struct profile and governor data for parent device */
>>> +	profile->polling_ms = 50;
>>> +	profile->target = exynos_bus_target;
>>> +	profile->get_dev_status = exynos_bus_get_dev_status;
>>> +	profile->exit = exynos_bus_exit;
>>> +
>>> +	ondemand_data = devm_kzalloc(dev, sizeof(*ondemand_data), GFP_KERNEL);
>>> +	if (!ondemand_data) {
>>> +		ret = -ENOMEM;
>>> +		goto err;
>>> +	}
>>> +	ondemand_data->upthreshold = 40;
>>> +	ondemand_data->downdifferential = 5;
>>> +
>>> +	/* Add devfreq device to monitor and handle the exynos bus */
>>> +	bus->devfreq = devm_devfreq_add_device(dev, profile,
>>> +						DEVFREQ_GOV_SIMPLE_ONDEMAND,
>>> +						ondemand_data);
>>> +	if (IS_ERR(bus->devfreq)) {
>>> +		dev_err(dev, "failed to add devfreq device\n");
>>> +		ret = PTR_ERR(bus->devfreq);
>>> +		goto err;
>>> +	}
>>> +
>>> +	/*
>>> +	 * Enable devfreq-event to get raw data which is used to determine
>>> +	 * current bus load.
>>> +	 */
>>> +	ret = exynos_bus_enable_edev(bus);
>>> +	if (ret < 0) {
>>> +		dev_err(dev, "failed to enable devfreq-event devices\n");
>>> +		goto err;
>>> +	}
>>> +
>>> +	ret = exynos_bus_set_event(bus);
>>> +	if (ret < 0) {
>>> +		dev_err(dev, "failed to set event to devfreq-event devices\n");
>>> +		goto err;
>>> +	}
>>> +
>>> +err:
>>> +	return ret;
>>> +}
>>> +
>>>  static int exynos_bus_probe(struct platform_device *pdev)
>>>  {
>>>  	struct device *dev = &pdev->dev;
>>>  	struct device_node *np = dev->of_node, *node;
>>>  	struct devfreq_dev_profile *profile;
>>> -	struct devfreq_simple_ondemand_data *ondemand_data;
>>>  	struct devfreq_passive_data *passive_data;
>>>  	struct devfreq *parent_devfreq;
>>>  	struct exynos_bus *bus;
>>> @@ -334,45 +384,9 @@ static int exynos_bus_probe(struct platform_device *pdev)
>>>  	if (passive)
>>>  		goto passive;
>>>  
>>> -	/* Initialize the struct profile and governor data for parent device */
>>> -	profile->polling_ms = 50;
>>> -	profile->target = exynos_bus_target;
>>> -	profile->get_dev_status = exynos_bus_get_dev_status;
>>> -	profile->exit = exynos_bus_exit;
>>> -
>>> -	ondemand_data = devm_kzalloc(dev, sizeof(*ondemand_data), GFP_KERNEL);
>>> -	if (!ondemand_data) {
>>> -		ret = -ENOMEM;
>>> +	ret = exynos_bus_profile_init(bus, profile);
>>> +	if (ret < 0)
>>>  		goto err;
>>> -	}
>>> -	ondemand_data->upthreshold = 40;
>>> -	ondemand_data->downdifferential = 5;
>>> -
>>> -	/* Add devfreq device to monitor and handle the exynos bus */
>>> -	bus->devfreq = devm_devfreq_add_device(dev, profile,
>>> -						DEVFREQ_GOV_SIMPLE_ONDEMAND,
>>> -						ondemand_data);
>>> -	if (IS_ERR(bus->devfreq)) {
>>> -		dev_err(dev, "failed to add devfreq device\n");
>>> -		ret = PTR_ERR(bus->devfreq);
>>> -		goto err;
>>> -	}
>>> -
>>> -	/*
>>> -	 * Enable devfreq-event to get raw data which is used to determine
>>> -	 * current bus load.
>>> -	 */
>>> -	ret = exynos_bus_enable_edev(bus);
>>> -	if (ret < 0) {
>>> -		dev_err(dev, "failed to enable devfreq-event devices\n");
>>> -		goto err;
>>> -	}
>>> -
>>> -	ret = exynos_bus_set_event(bus);
>>> -	if (ret < 0) {
>>> -		dev_err(dev, "failed to set event to devfreq-event devices\n");
>>> -		goto err;
>>> -	}
>>>  
>>>  	goto out;
>>>  passive:
> 
> commit cacf8e4ea0e111908d11779977c81e29d6418801
> Author: Artur Świgoń <a.swigon@partner.samsung.com>
> Date:   Tue Aug 27 13:17:28 2019 +0200
> 
>     tmp: merge patches 01-03
>     
>     Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
> 
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index 29f422469960..60ad4319fd80 100644
> --- a/drivers/devfreq/exynos-bus.c
> +++ b/drivers/devfreq/exynos-bus.c
> @@ -287,52 +287,12 @@ static int exynos_bus_parse_of(struct device_node *np,
>  	return ret;
>  }
>  
> -static int exynos_bus_probe(struct platform_device *pdev)
> +static int exynos_bus_profile_init(struct exynos_bus *bus,
> +				   struct devfreq_dev_profile *profile)
>  {
> -	struct device *dev = &pdev->dev;
> -	struct device_node *np = dev->of_node, *node;
> -	struct devfreq_dev_profile *profile;
> +	struct device *dev = bus->dev;
>  	struct devfreq_simple_ondemand_data *ondemand_data;
> -	struct devfreq_passive_data *passive_data;
> -	struct devfreq *parent_devfreq;
> -	struct exynos_bus *bus;
> -	int ret, max_state;
> -	unsigned long min_freq, max_freq;
> -	bool passive = false;
> -
> -	if (!np) {
> -		dev_err(dev, "failed to find devicetree node\n");
> -		return -EINVAL;
> -	}
> -
> -	bus = devm_kzalloc(&pdev->dev, sizeof(*bus), GFP_KERNEL);
> -	if (!bus)
> -		return -ENOMEM;
> -	mutex_init(&bus->lock);
> -	bus->dev = &pdev->dev;
> -	platform_set_drvdata(pdev, bus);
> -
> -	profile = devm_kzalloc(dev, sizeof(*profile), GFP_KERNEL);
> -	if (!profile)
> -		return -ENOMEM;
> -
> -	node = of_parse_phandle(dev->of_node, "devfreq", 0);
> -	if (node) {
> -		of_node_put(node);
> -		passive = true;
> -	} else {
> -		ret = exynos_bus_parent_parse_of(np, bus);
> -		if (ret < 0)
> -			return ret;
> -	}
> -
> -	/* Parse the device-tree to get the resource information */
> -	ret = exynos_bus_parse_of(np, bus);
> -	if (ret < 0)
> -		goto err_reg;
> -
> -	if (passive)
> -		goto passive;
> +	int ret;
>  
>  	/* Initialize the struct profile and governor data for parent device */
>  	profile->polling_ms = 50;
> @@ -374,8 +334,18 @@ static int exynos_bus_probe(struct platform_device *pdev)
>  		goto err;
>  	}
>  
> -	goto out;
> -passive:
> +err:
> +	return ret;
> +}
> +
> +static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
> +					   struct devfreq_dev_profile *profile)
> +{
> +	struct device *dev = bus->dev;
> +	struct devfreq_passive_data *passive_data;
> +	struct devfreq *parent_devfreq;
> +	int ret = 0;
> +
>  	/* Initialize the struct profile and governor data for passive device */
>  	profile->target = exynos_bus_target;
>  	profile->exit = exynos_bus_passive_exit;
> @@ -404,7 +374,59 @@ static int exynos_bus_probe(struct platform_device *pdev)
>  		goto err;
>  	}
>  
> -out:
> +err:
> +	return ret;
> +}
> +
> +static int exynos_bus_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node, *node;
> +	struct devfreq_dev_profile *profile;
> +	struct exynos_bus *bus;
> +	int ret, max_state;
> +	unsigned long min_freq, max_freq;
> +	bool passive = false;
> +
> +	if (!np) {
> +		dev_err(dev, "failed to find devicetree node\n");
> +		return -EINVAL;
> +	}
> +
> +	bus = devm_kzalloc(&pdev->dev, sizeof(*bus), GFP_KERNEL);
> +	if (!bus)
> +		return -ENOMEM;
> +	mutex_init(&bus->lock);
> +	bus->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, bus);
> +
> +	profile = devm_kzalloc(dev, sizeof(*profile), GFP_KERNEL);
> +	if (!profile)
> +		return -ENOMEM;
> +
> +	node = of_parse_phandle(dev->of_node, "devfreq", 0);
> +	if (node) {
> +		of_node_put(node);
> +		passive = true;
> +	} else {
> +		ret = exynos_bus_parent_parse_of(np, bus);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	/* Parse the device-tree to get the resource information */
> +	ret = exynos_bus_parse_of(np, bus);
> +	if (ret < 0)
> +		goto err_reg;
> +
> +	if (passive)
> +		ret = exynos_bus_profile_init_passive(bus, profile);
> +	else
> +		ret = exynos_bus_profile_init(bus, profile);
> +
> +	if (ret < 0)
> +		goto err;
> +
>  	max_state = bus->devfreq->profile->max_state;
>  	min_freq = (bus->devfreq->profile->freq_table[0] / 1000);
>  	max_freq = (bus->devfreq->profile->freq_table[max_state - 1] / 1000);
> 
> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
