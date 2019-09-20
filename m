Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03A06B8917
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2019 04:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394674AbfITCKs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 22:10:48 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:63716 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391943AbfITCKr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Sep 2019 22:10:47 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190920021045epoutp03ed96e294d0272a0442bab9db57aa6a92~GA5HnxRhi3184331843epoutp033
        for <linux-pm@vger.kernel.org>; Fri, 20 Sep 2019 02:10:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190920021045epoutp03ed96e294d0272a0442bab9db57aa6a92~GA5HnxRhi3184331843epoutp033
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568945445;
        bh=k66SEUb+iu7MrIzYXta2w01qjBxjiVzLnojDwgfMr/I=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ApHqF90FwJ0ssVzMkCEAamefBjzdlEbKSdZ6/MJ8OXsOeZ0X+GfA7w9OmB229pijj
         uba3LOF1WA8H5KgeiKETCP9vUQE1rCgESh1r0kgpPs2b3gT/iEQDF0dtL70aZ28uNz
         y/LCXP68nI1wiPV+6ukqJQYLU3yOJ7/xW4nBt6XA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190920021044epcas1p456ae70086bdc748066c96bee0121b3c1~GA5GhxHXm0843308433epcas1p4X;
        Fri, 20 Sep 2019 02:10:44 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.156]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 46ZHHj38ZszMqYkn; Fri, 20 Sep
        2019 02:10:41 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        68.03.04085.125348D5; Fri, 20 Sep 2019 11:10:41 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190920021040epcas1p193b15a76e074718a86591a2b0b69a7e5~GA5DQNChY1069910699epcas1p14;
        Fri, 20 Sep 2019 02:10:40 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190920021040epsmtrp2897a8efb4075311bf995d18ecf926bbe~GA5DPVNqs1689516895epsmtrp2m;
        Fri, 20 Sep 2019 02:10:40 +0000 (GMT)
X-AuditID: b6c32a39-d03ff70000000ff5-e7-5d843521246a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        43.C6.03638.025348D5; Fri, 20 Sep 2019 11:10:40 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190920021040epsmtip2b139c5483721235e7252c36c0827e747~GA5DA_R9v3129031290epsmtip2k;
        Fri, 20 Sep 2019 02:10:40 +0000 (GMT)
Subject: Re: [RFC PATCH v2 01/11] devfreq: exynos-bus: Extract
 exynos_bus_profile_init()
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
Message-ID: <2e49bd2c-e074-038b-f8a2-7dd8dea4a9af@samsung.com>
Date:   Fri, 20 Sep 2019 11:15:08 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919142236.4071-2-a.swigon@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIJsWRmVeSWpSXmKPExsWy7bCmga6iaUuswdP9ohaHjm1lt7g/r5XR
        YuOM9awW84+cY7W48vU9m8X0vZvYLCbdn8Bicf78BnaLFXc/slpsenyN1eLyrjlsFp97jzBa
        zDi/j8li7ZG77Ba3G1ewWcyY/JLNQcBj06pONo871/awedzvPs7ksXlJvcfGdzuYPA6+28Pk
        0bdlFaPH501yARxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkou
        PgG6bpk5QB8oKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgosC/SKE3OLS/PS9ZLz
        c60MDQyMTIEKE7Iz5nw4xFpwQ7Hi+LzfTA2M96S6GDk5JARMJH7dnc3WxcjFISSwg1Fi34v1
        rBDOJ0aJPa3nmSCcb4wSW6fMYYdp6Wo+DFW1l1Hi9Zw2ZgjnPaPErnlzWECqhAWiJM7d/QiW
        EBH4zyhxetlKsBZmgU4mid/Pd7CCVLEJaEnsf3GDDcTmF1CUuPrjMSOIzStgJ/Hy5mygGg4O
        FgFViQ9/9EDCogIREp8eHGaFKBGUODnzCdgyTgFLiYUr/oPZzALiEreezGeCsOUlmrfOZoY4
        +xi7xM0tChC2i8TB5w1Q7whLvDq+BcqWkvj8bi8bhF0tsfLkEXDISAh0MEps2X+BFSJhLLF/
        6WQmkNuYBTQl1u/ShwgrSuz8PZcRYi+fxLuvPWDnSwjwSnS0CUGUKEtcfnCXCcKWlFjc3sk2
        gVFpFpJvZiH5YBaSD2YhLFvAyLKKUSy1oDg3PbXYsMAUObo3MYKTt5blDsZj53wOMQpwMCrx
        8CqUN8cKsSaWFVfmHmKU4GBWEuGdY9oUK8SbklhZlVqUH19UmpNafIjRFBjWE5mlRJPzgZkl
        ryTe0NTI2NjYwsTQzNTQUEmc1yO9IVZIID2xJDU7NbUgtQimj4mDU6qBMfr0aa0Zb1imx0qq
        2wmefHw3c42V6J4eq5+/ipTTFwR8/GCtsm5C+dTVl5Xbtz+JdzymlpTEt3nZxW3vul6Hck90
        bp0r9iPXaYZ29M5DXRX9vQxH3tmkCj8VWMqzr+Lp56QNyjYdkus1pf8f/bgucdK2GceVXHtZ
        BeYUTM8P9dHemXpCwHnWdCWW4oxEQy3mouJEAFuHcu/0AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsWy7bCSvK6CaUuswc+LKhaHjm1lt7g/r5XR
        YuOM9awW84+cY7W48vU9m8X0vZvYLCbdn8Bicf78BnaLFXc/slpsenyN1eLyrjlsFp97jzBa
        zDi/j8li7ZG77Ba3G1ewWcyY/JLNQcBj06pONo871/awedzvPs7ksXlJvcfGdzuYPA6+28Pk
        0bdlFaPH501yARxRXDYpqTmZZalF+nYJXBlzPhxiLbihWHF83m+mBsZ7Ul2MnBwSAiYSXc2H
        WbsYuTiEBHYzSsxtb2CDSEhKTLt4lLmLkQPIFpY4fLgYouYto8ShngWsIDXCAlES5+5+ZAZJ
        iAj8Z5R42HaMEcRhFuhkkli85QcL3Ni1D/+BtbAJaEnsf3EDbAW/gKLE1R+PGUFsXgE7iZc3
        Z7OCrGMRUJX48EcPJCwqECFxeMcsqBJBiZMzn7CA2JwClhILV/wHs5kF1CX+zLvEDGGLS9x6
        Mp8JwpaXaN46m3kCo/AsJO2zkLTMQtIyC0nLAkaWVYySqQXFuem5xYYFRnmp5XrFibnFpXnp
        esn5uZsYwXGspbWD8cSJ+EOMAhyMSjy8CuXNsUKsiWXFlbmHGCU4mJVEeOeYNsUK8aYkVlal
        FuXHF5XmpBYfYpTmYFES55XPPxYpJJCeWJKanZpakFoEk2Xi4JRqYFzVmZqw+lDfSbdjcez/
        +f5GNTIEhTpUqVfx1ncvMlg6i2OmZLtKdr2idbhEmUF01LFZ3J7PuOJfv61+XC8buXKd9ZT2
        xgL1hhUHBZ7kN/yT7r5x41jndwtOo+DHb59OyFDo2bJyio1Ec4iW5v+KqS/ONHhsf73vyNmH
        t+NrJzAzv0q06zjQpMRSnJFoqMVcVJwIACnIrprfAgAA
X-CMS-MailID: 20190920021040epcas1p193b15a76e074718a86591a2b0b69a7e5
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
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

As I already replied on v1, patch1/2/3 clean-up code
for readability without any behavior changes. 

I think that you better to merge patch1/2/3 to one patch.

On 19. 9. 19. 오후 11:22, Artur Świgoń wrote:
> From: Artur Świgoń <a.swigon@partner.samsung.com>
> 
> This patch adds a new static function, exynos_bus_profile_init(), extracted
> from exynos_bus_probe().
> 
> Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
> ---
>  drivers/devfreq/exynos-bus.c | 92 +++++++++++++++++++++---------------
>  1 file changed, 53 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index 29f422469960..78f38b7fb596 100644
> --- a/drivers/devfreq/exynos-bus.c
> +++ b/drivers/devfreq/exynos-bus.c
> @@ -287,12 +287,62 @@ static int exynos_bus_parse_of(struct device_node *np,
>  	return ret;
>  }
>  
> +static int exynos_bus_profile_init(struct exynos_bus *bus,
> +				   struct devfreq_dev_profile *profile)
> +{
> +	struct device *dev = bus->dev;
> +	struct devfreq_simple_ondemand_data *ondemand_data;
> +	int ret;
> +
> +	/* Initialize the struct profile and governor data for parent device */
> +	profile->polling_ms = 50;
> +	profile->target = exynos_bus_target;
> +	profile->get_dev_status = exynos_bus_get_dev_status;
> +	profile->exit = exynos_bus_exit;
> +
> +	ondemand_data = devm_kzalloc(dev, sizeof(*ondemand_data), GFP_KERNEL);
> +	if (!ondemand_data) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +	ondemand_data->upthreshold = 40;
> +	ondemand_data->downdifferential = 5;
> +
> +	/* Add devfreq device to monitor and handle the exynos bus */
> +	bus->devfreq = devm_devfreq_add_device(dev, profile,
> +						DEVFREQ_GOV_SIMPLE_ONDEMAND,
> +						ondemand_data);
> +	if (IS_ERR(bus->devfreq)) {
> +		dev_err(dev, "failed to add devfreq device\n");
> +		ret = PTR_ERR(bus->devfreq);
> +		goto err;
> +	}
> +
> +	/*
> +	 * Enable devfreq-event to get raw data which is used to determine
> +	 * current bus load.
> +	 */
> +	ret = exynos_bus_enable_edev(bus);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to enable devfreq-event devices\n");
> +		goto err;
> +	}
> +
> +	ret = exynos_bus_set_event(bus);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to set event to devfreq-event devices\n");
> +		goto err;
> +	}
> +
> +err:
> +	return ret;
> +}
> +
>  static int exynos_bus_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct device_node *np = dev->of_node, *node;
>  	struct devfreq_dev_profile *profile;
> -	struct devfreq_simple_ondemand_data *ondemand_data;
>  	struct devfreq_passive_data *passive_data;
>  	struct devfreq *parent_devfreq;
>  	struct exynos_bus *bus;
> @@ -334,45 +384,9 @@ static int exynos_bus_probe(struct platform_device *pdev)
>  	if (passive)
>  		goto passive;
>  
> -	/* Initialize the struct profile and governor data for parent device */
> -	profile->polling_ms = 50;
> -	profile->target = exynos_bus_target;
> -	profile->get_dev_status = exynos_bus_get_dev_status;
> -	profile->exit = exynos_bus_exit;
> -
> -	ondemand_data = devm_kzalloc(dev, sizeof(*ondemand_data), GFP_KERNEL);
> -	if (!ondemand_data) {
> -		ret = -ENOMEM;
> +	ret = exynos_bus_profile_init(bus, profile);
> +	if (ret < 0)
>  		goto err;
> -	}
> -	ondemand_data->upthreshold = 40;
> -	ondemand_data->downdifferential = 5;
> -
> -	/* Add devfreq device to monitor and handle the exynos bus */
> -	bus->devfreq = devm_devfreq_add_device(dev, profile,
> -						DEVFREQ_GOV_SIMPLE_ONDEMAND,
> -						ondemand_data);
> -	if (IS_ERR(bus->devfreq)) {
> -		dev_err(dev, "failed to add devfreq device\n");
> -		ret = PTR_ERR(bus->devfreq);
> -		goto err;
> -	}
> -
> -	/*
> -	 * Enable devfreq-event to get raw data which is used to determine
> -	 * current bus load.
> -	 */
> -	ret = exynos_bus_enable_edev(bus);
> -	if (ret < 0) {
> -		dev_err(dev, "failed to enable devfreq-event devices\n");
> -		goto err;
> -	}
> -
> -	ret = exynos_bus_set_event(bus);
> -	if (ret < 0) {
> -		dev_err(dev, "failed to set event to devfreq-event devices\n");
> -		goto err;
> -	}
>  
>  	goto out;
>  passive:
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
