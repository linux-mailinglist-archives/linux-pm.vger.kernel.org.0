Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD1B117ED2
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 05:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfLJEOY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Dec 2019 23:14:24 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:25595 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfLJEOY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Dec 2019 23:14:24 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191210041421epoutp02e2e5d4e77fdd786fe133f8e68203214c~e51KMl9ci1235812358epoutp02M
        for <linux-pm@vger.kernel.org>; Tue, 10 Dec 2019 04:14:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191210041421epoutp02e2e5d4e77fdd786fe133f8e68203214c~e51KMl9ci1235812358epoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575951261;
        bh=OdhN49WK8rm0oTDRkqLL4LWFQFuzsTtK9rjB+lhhG9g=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=nGNFzrq01n5uE3LQRuaCzFcHWv3ueuxqhckoU6lC5plxBmrcfAvH8+Lb/x3iLTVwk
         u6dQPcAlHJIoleOnGiqcnhHh+rsYRcLPStAI7cUans0tUOlqnPNZx84WkdAXc3618h
         q3DUPh/5BvTTJIRmIrBXujI/G+VyOe5haUNmepwg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191210041420epcas1p40574525a696a3270c0f5e7858d6d1154~e51Jf2_NO2926329263epcas1p4D;
        Tue, 10 Dec 2019 04:14:20 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.154]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47X6By1kJLzMqYkn; Tue, 10 Dec
        2019 04:14:18 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        77.C9.48019.A9B1FED5; Tue, 10 Dec 2019 13:14:18 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191210041417epcas1p42c8da7d1c32b317fd9badf04d14daeda~e51G_u5y_2924429244epcas1p4Q;
        Tue, 10 Dec 2019 04:14:17 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191210041417epsmtrp1638f85d4efde68a658466942d237522c~e51G93BVD2236922369epsmtrp1r;
        Tue, 10 Dec 2019 04:14:17 +0000 (GMT)
X-AuditID: b6c32a38-257ff7000001bb93-3a-5def1b9ae913
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6B.36.10238.99B1FED5; Tue, 10 Dec 2019 13:14:17 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191210041417epsmtip23108a8a854cc8441aa421f3417ff3619~e51Grqjp_2166321663epsmtip23;
        Tue, 10 Dec 2019 04:14:17 +0000 (GMT)
Subject: Re: [PATCH v3 1/4] devfreq: exynos-bus: Extract
 exynos_bus_profile_init()
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
Message-ID: <3d2c8269-cefe-0736-4fb9-729cc337db43@samsung.com>
Date:   Tue, 10 Dec 2019 13:20:43 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20191209104902.11904-2-a.swigon@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHJsWRmVeSWpSXmKPExsWy7bCmru4s6fexBo8f81jcn9fKaLFxxnpW
        i0n3J7BYLPg0g9Wi//FrZovz5zewW5xtesNuseLuR1aLTY+vsVpc3jWHzeJz7xFGixnn9zFZ
        rD1yl93iduMKNosZk1+yOfB7bFrVyeaxeUm9x8Z3O5g8+rasYvT4vEkugDUq2yYjNTEltUgh
        NS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6FolhbLEnFKgUEBicbGS
        vp1NUX5pSapCRn5xia1SakFKToFlgV5xYm5xaV66XnJ+rpWhgYGRKVBhQnbG056rbAXHlCv6
        zy9gbWCcKNPFyMEhIWAiMeETWxcjF4eQwA5Gia9vXjBBOJ8YJS5NXsIC4XxjlLj8YCljFyMn
        WMfm7SA2SGIvo8Tcg9Ohqt4zSqzYsZcNpEpYIESiadIldpCEiMABRokD65vBBjMLfGGUaL7x
        lx2kik1AS2L/ixtgHfwCihJXfzwG28ErYCfR1NHOBGKzCKhK/FixF8wWFQiTOLmtBapGUOLk
        zCcsIDangJXE7kffWUFsZgFxiVtP5jNB2PISzVtnM4MslhBYxS4x7/NKFognXCTOf13BDGEL
        S7w6voUdwpaSeNnfBmVXS6w8eYQNormDUWLL/gusEAljif1LJzOBwo9ZQFNi/S59iLCixM7f
        cxkhFvNJvPvawwoJYl6JjjYhiBJlYDjeZYKwJSUWt3eyTWBUmoXknVlIXpiF5IVZCMsWMLKs
        YhRLLSjOTU8tNiwwQY7vTYzgtKxlsYNxzzmfQ4wCHIxKPLwLHN7FCrEmlhVX5h5ilOBgVhLh
        Pd4GFOJNSaysSi3Kjy8qzUktPsRoCgzticxSosn5wJyRVxJvaGpkbGxsYWJoZmpoqCTOy/Hj
        YqyQQHpiSWp2ampBahFMHxMHp1QD42KXEj5jhZcBilceSicwFthnvWnaYfBs8txpQdxPzhxi
        tgq8xVSyNXVBT3WEZnJaul4g8y2HQOEOTxbxNCH15Fm1t6Rec5XsVRZx+pS6lE9YboLv9M3X
        IxUsAu5t15aTnHue97TYbkf+LV/Cn0oU1R70sDnfab6mwXlK/ryM+pIVbY8YvrsrsRRnJBpq
        MRcVJwIAYkkL1eEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsWy7bCSvO5M6fexBnsPG1rcn9fKaLFxxnpW
        i0n3J7BYLPg0g9Wi//FrZovz5zewW5xtesNuseLuR1aLTY+vsVpc3jWHzeJz7xFGixnn9zFZ
        rD1yl93iduMKNosZk1+yOfB7bFrVyeaxeUm9x8Z3O5g8+rasYvT4vEkugDWKyyYlNSezLLVI
        3y6BK+Npz1W2gmPKFf3nF7A2ME6U6WLk5JAQMJHYvH0pYxcjF4eQwG5GiWUHZ7FCJCQlpl08
        ytzFyAFkC0scPlwMUfOWUaLt4y4WkBphgRCJpkmX2EESIgIHGCU275zNBJJgFvjCKHH0SThE
        x15Giaa/19hBEmwCWhL7X9xgA7H5BRQlrv54zAhi8wrYSTR1tIM1swioSvxYsRfMFhUIk9i5
        5DETRI2gxMmZT8A2cwpYSex+9J0VYpm6xJ95l5ghbHGJW0/mQx0hL9G8dTbzBEbhWUjaZyFp
        mYWkZRaSlgWMLKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz0vWS83M3MYLjU0tzB+PlJfGHGAU4
        GJV4eBc4vIsVYk0sK67MPcQowcGsJMJ7vA0oxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdp3rFI
        IYH0xJLU7NTUgtQimCwTB6dUA6Pm0gZ5u6XHdPbxP9I5yDT5uAPPs7MTH5kdsBEVai+x9zfI
        CE3ilwsxTsnel3RwJf8Ur7WuStwc/wtFqk65HqtMF/t+RdTZZEPkQ/U/sndMt/sUch6bHpOT
        XpFjfc7n7eIv4pW+WWXHM3c4akgpfP2+4cv+6cfrKnesydilXHrR2s7i5L33+UosxRmJhlrM
        RcWJAP4D/xTLAgAA
X-CMS-MailID: 20191210041417epcas1p42c8da7d1c32b317fd9badf04d14daeda
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191209105031eucas1p137c3c5b0046570453e1ebed2dcd88277
References: <20191209104902.11904-1-a.swigon@samsung.com>
        <CGME20191209105031eucas1p137c3c5b0046570453e1ebed2dcd88277@eucas1p1.samsung.com>
        <20191209104902.11904-2-a.swigon@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/9/19 7:48 PM, Artur Świgoń wrote:
> This patch adds a new static function, exynos_bus_profile_init(), extracted
> from exynos_bus_probe().
> 
> Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
> ---
>  drivers/devfreq/exynos-bus.c | 106 ++++++++++++++++++++---------------
>  1 file changed, 60 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index c832673273a2..b8ca6b9f4b82 100644
> --- a/drivers/devfreq/exynos-bus.c
> +++ b/drivers/devfreq/exynos-bus.c
> @@ -287,12 +287,69 @@ static int exynos_bus_parse_of(struct device_node *np,
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
> +	/* Register opp_notifier to catch the change of OPP  */
> +	ret = devm_devfreq_register_opp_notifier(dev, bus->devfreq);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to register opp notifier\n");
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
> @@ -334,52 +391,9 @@ static int exynos_bus_probe(struct platform_device *pdev)
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
> -	/* Register opp_notifier to catch the change of OPP  */
> -	ret = devm_devfreq_register_opp_notifier(dev, bus->devfreq);
> -	if (ret < 0) {
> -		dev_err(dev, "failed to register opp notifier\n");
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

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
