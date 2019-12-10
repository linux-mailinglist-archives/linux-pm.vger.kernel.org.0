Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1A4117ED6
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 05:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfLJEOd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Dec 2019 23:14:33 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:14370 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbfLJEOd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Dec 2019 23:14:33 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191210041430epoutp012de00ef38da0b5b356b66e99d5e6965e~e51S6BMT91287312873epoutp01f
        for <linux-pm@vger.kernel.org>; Tue, 10 Dec 2019 04:14:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191210041430epoutp012de00ef38da0b5b356b66e99d5e6965e~e51S6BMT91287312873epoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575951270;
        bh=qHDmCpWE+HvyeD/hUW+yp7Qx/0mA9AfvYxWPVGikIw8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Ky1ii+Iw79D2f/TCF0OP3klNuFHzrwCVkLFcNUxmiq0dS9uYaa37uGQZUUCr+FLrt
         J8b84JlhARrHifmuRiu5AKwBITU8B/HtILyeq5kav//1A5TUsba/fP/sB0Z+LxgKQE
         O+hFLoIS67b7F/yyAGfFrXfdhiZ4by039esqVSvo=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191210041430epcas1p2fbfb7c6ead257ab53dfdb531254e3d76~e51Sb2fnA2987929879epcas1p2d;
        Tue, 10 Dec 2019 04:14:30 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.155]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47X6C45V9MzMqYkw; Tue, 10 Dec
        2019 04:14:24 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        9C.C9.48019.0AB1FED5; Tue, 10 Dec 2019 13:14:24 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191210041424epcas1p3fbfcee2a4776a151bc87c1e53cce7fef~e51MuZ8nJ1387213872epcas1p3a;
        Tue, 10 Dec 2019 04:14:24 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191210041424epsmtrp12b6ffc213687e1b2e164b6e313771553~e51MtoSpP2236922369epsmtrp1x;
        Tue, 10 Dec 2019 04:14:24 +0000 (GMT)
X-AuditID: b6c32a38-257ff7000001bb93-52-5def1ba0ed06
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        64.18.06569.F9B1FED5; Tue, 10 Dec 2019 13:14:23 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191210041423epsmtip1b8178bea4c794f1bd1e105d67282c468~e51MbK6o32854928549epsmtip1R;
        Tue, 10 Dec 2019 04:14:23 +0000 (GMT)
Subject: Re: [PATCH v3 2/4] devfreq: exynos-bus: Extract
 exynos_bus_profile_init_passive()
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
Message-ID: <cd5be580-5236-0d83-b5fb-dd5fae804c26@samsung.com>
Date:   Tue, 10 Dec 2019 13:20:49 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20191209104902.11904-3-a.swigon@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLJsWRmVeSWpSXmKPExsWy7bCmru4C6fexBm29Ohb357UyWmycsZ7V
        YtL9CSwWCz7NYLXof/ya2eL8+Q3sFmeb3rBbrLj7kdVi0+NrrBaXd81hs/jce4TRYsb5fUwW
        a4/cZbe43biCzWLG5JdsDvwem1Z1snlsXlLvsfHdDiaPvi2rGD0+b5ILYI3KtslITUxJLVJI
        zUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBulZJoSwxpxQoFJBYXKyk
        b2dTlF9akqqQkV9cYquUWpCSU2BZoFecmFtcmpeul5yfa2VoYGBkClSYkJ0x71AbY8E+6YrW
        9W3sDYztYl2MnBwSAiYSjXO3sXcxcnEICexglLi95TwjhPOJUWLCnNlsEM43RokFC16xwrS8
        WnyBGcQWEtjLKLH0txeE/Z5R4tBGMFtYIEbiy71esLEiAgcYJQ6sb2YCcZgFvjBKNN/4yw5S
        xSagJbH/xQ02EJtfQFHi6o/HjCA2r4CdxJI/G8BqWARUJf5uP8YCYosKhEmc3NYCVSMocXLm
        E7A4p4CVRM/LA2D1zALiEreezGeCsOUlmrfOZgZZLCGwil3i4O9nUC+4SFz4c4gFwhaWeHV8
        CzuELSXxsr8Nyq6WWHnyCBtEcwejxJb9F6CajSX2L50MtIEDaIOmxPpd+hBhRYmdv+cyQizm
        k3j3tYcVpERCgFeio00IokRZ4vKDu0wQtqTE4vZOtgmMSrOQvDMLyQuzkLwwC2HZAkaWVYxi
        qQXFuempxYYFJsjRvYkRnJS1LHYw7jnnc4hRgINRiYd3gcO7WCHWxLLiytxDjBIczEoivMfb
        gEK8KYmVValF+fFFpTmpxYcYTYGhPZFZSjQ5H5gx8kriDU2NjI2NLUwMzUwNDZXEeTl+XIwV
        EkhPLEnNTk0tSC2C6WPi4JRqYEzJ45vGmfzr65t9/n4FcnG7RW9ZnmjNiez7e9yubX//h6Ar
        p9pTmJb+l1pr8Jo55dK2jK5qw1V1FZYL115o12ZcPPnzi7/Po0tbPQO/Hc4tiOo5z24868je
        XfJLfHbd9ZwTs1OpszjsUbeY3ifTnnmfMmd4izyavarj7/1PW9hUHEUjO1qv9iuxFGckGmox
        FxUnAgCrroIM4AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsWy7bCSnO586fexBrN+WVvcn9fKaLFxxnpW
        i0n3J7BYLPg0g9Wi//FrZovz5zewW5xtesNuseLuR1aLTY+vsVpc3jWHzeJz7xFGixnn9zFZ
        rD1yl93iduMKNosZk1+yOfB7bFrVyeaxeUm9x8Z3O5g8+rasYvT4vEkugDWKyyYlNSezLLVI
        3y6BK2PeoTbGgn3SFa3r29gbGNvFuhg5OSQETCReLb7A3MXIxSEksJtR4urt3ewQCUmJaReP
        AiU4gGxhicOHiyFq3jJKPP70jwmkRlggRuLLvV52kISIwAFGic07Z4MlmAW+MEocfRIOYgsJ
        7AVKXPEAsdkEtCT2v7jBBmLzCyhKXP3xmBHE5hWwk1jyZwPYYhYBVYm/24+xgNiiAmESO5c8
        ZoKoEZQ4OfMJWJxTwEqi5+UBdohd6hJ/5l1ihrDFJW49mQ91g7xE89bZzBMYhWchaZ+FpGUW
        kpZZSFoWMLKsYpRMLSjOTc8tNiwwykst1ytOzC0uzUvXS87P3cQIjk4trR2MJ07EH2IU4GBU
        4uH1sHsXK8SaWFZcmXuIUYKDWUmE93gbUIg3JbGyKrUoP76oNCe1+BCjNAeLkjivfP6xSCGB
        9MSS1OzU1ILUIpgsEwenVAOj1J3KXZZ1vVnlVYWTpHn7/9VPlTlgGKG57iKfhHj7m8odLXzf
        pUS1fre/Yvqh8K6v/dvKWL6XSZoh4R/e8R3jFPLSbGHYNovr3UTe4suCqsWKc/T/nkmQTAgq
        /GycE8kUF63cP8eU73PjjweR9uqv2mYb82hWTy59Uvp4+6WNxpbGAvWfNymxFGckGmoxFxUn
        AgD2TbyqygIAAA==
X-CMS-MailID: 20191210041424epcas1p3fbfcee2a4776a151bc87c1e53cce7fef
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191209105032eucas1p13fa6c46a1e80cdda68ab4bac3e008b8f
References: <20191209104902.11904-1-a.swigon@samsung.com>
        <CGME20191209105032eucas1p13fa6c46a1e80cdda68ab4bac3e008b8f@eucas1p1.samsung.com>
        <20191209104902.11904-3-a.swigon@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/9/19 7:49 PM, Artur Świgoń wrote:
> This patch adds a new static function, exynos_bus_profile_init_passive(),
> extracted from exynos_bus_probe().
> 
> Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
> ---
>  drivers/devfreq/exynos-bus.c | 70 +++++++++++++++++++++---------------
>  1 file changed, 42 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index b8ca6b9f4b82..19d9f9f8ced2 100644
> --- a/drivers/devfreq/exynos-bus.c
> +++ b/drivers/devfreq/exynos-bus.c
> @@ -345,13 +345,51 @@ static int exynos_bus_profile_init(struct exynos_bus *bus,
>  	return ret;
>  }
>  
> +static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
> +					   struct devfreq_dev_profile *profile)
> +{
> +	struct device *dev = bus->dev;
> +	struct devfreq_passive_data *passive_data;
> +	struct devfreq *parent_devfreq;
> +	int ret = 0;
> +
> +	/* Initialize the struct profile and governor data for passive device */
> +	profile->target = exynos_bus_target;
> +	profile->exit = exynos_bus_passive_exit;
> +
> +	/* Get the instance of parent devfreq device */
> +	parent_devfreq = devfreq_get_devfreq_by_phandle(dev, 0);
> +	if (IS_ERR(parent_devfreq)) {
> +		ret = -EPROBE_DEFER;
> +		goto err;
> +	}
> +
> +	passive_data = devm_kzalloc(dev, sizeof(*passive_data), GFP_KERNEL);
> +	if (!passive_data) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +	passive_data->parent = parent_devfreq;
> +
> +	/* Add devfreq device for exynos bus with passive governor */
> +	bus->devfreq = devm_devfreq_add_device(dev, profile, DEVFREQ_GOV_PASSIVE,
> +						passive_data);
> +	if (IS_ERR(bus->devfreq)) {
> +		dev_err(dev,
> +			"failed to add devfreq dev with passive governor\n");
> +		ret = PTR_ERR(bus->devfreq);
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
> -	struct devfreq_passive_data *passive_data;
> -	struct devfreq *parent_devfreq;
>  	struct exynos_bus *bus;
>  	int ret, max_state;
>  	unsigned long min_freq, max_freq;
> @@ -397,33 +435,9 @@ static int exynos_bus_probe(struct platform_device *pdev)
>  
>  	goto out;
>  passive:
> -	/* Initialize the struct profile and governor data for passive device */
> -	profile->target = exynos_bus_target;
> -	profile->exit = exynos_bus_passive_exit;
> -
> -	/* Get the instance of parent devfreq device */
> -	parent_devfreq = devfreq_get_devfreq_by_phandle(dev, 0);
> -	if (IS_ERR(parent_devfreq)) {
> -		ret = -EPROBE_DEFER;
> +	ret = exynos_bus_profile_init_passive(bus, profile);
> +	if (ret < 0)
>  		goto err;
> -	}
> -
> -	passive_data = devm_kzalloc(dev, sizeof(*passive_data), GFP_KERNEL);
> -	if (!passive_data) {
> -		ret = -ENOMEM;
> -		goto err;
> -	}
> -	passive_data->parent = parent_devfreq;
> -
> -	/* Add devfreq device for exynos bus with passive governor */
> -	bus->devfreq = devm_devfreq_add_device(dev, profile, DEVFREQ_GOV_PASSIVE,
> -						passive_data);
> -	if (IS_ERR(bus->devfreq)) {
> -		dev_err(dev,
> -			"failed to add devfreq dev with passive governor\n");
> -		ret = PTR_ERR(bus->devfreq);
> -		goto err;
> -	}
>  
>  out:
>  	max_state = bus->devfreq->profile->max_state;
> 

Applied it. Thanks.


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
