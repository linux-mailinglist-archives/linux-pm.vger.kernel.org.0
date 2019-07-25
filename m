Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E81174A7E
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 11:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbfGYJzp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jul 2019 05:55:45 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:13183 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729010AbfGYJzp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2019 05:55:45 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190725095542epoutp04516100c9ea6c5370942c436d1da57489~0ndzW8-6I0893008930epoutp04O
        for <linux-pm@vger.kernel.org>; Thu, 25 Jul 2019 09:55:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190725095542epoutp04516100c9ea6c5370942c436d1da57489~0ndzW8-6I0893008930epoutp04O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1564048542;
        bh=APvyhy0eQAA2wXp8WTSoXGWXI9/At5nyAp+5gePsgVg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=h29K8wMHJjYi+fuUrkwfTfFMLgzeOV52qOxzjXWKSsnMJrADIsNojY5pZWFLpkVCh
         StoScMhnOUGugLejS72qOZp0f2ch+GHsv8oJlIs91Mbm7wLD5QgOGftC7/lA1UrkXt
         5jBkEm65QeP9piuf1D2JSzmTjGAHWXiD4U/4gDFs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190725095541epcas1p23ae99ffd69957e3dd1bbbd877aacb535~0ndytmimj0831308313epcas1p2C;
        Thu, 25 Jul 2019 09:55:41 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.157]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 45vSJW2gBtzMqYkY; Thu, 25 Jul
        2019 09:55:39 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        15.22.04075.B9C793D5; Thu, 25 Jul 2019 18:55:39 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190725095538epcas1p323a4e0d70b4a906ffb5927b2e43dc00f~0ndwDjd_B0042800428epcas1p3T;
        Thu, 25 Jul 2019 09:55:38 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190725095538epsmtrp2fc287fb53405ebd9e0d5370c0341322b~0ndv-668u1824718247epsmtrp2a;
        Thu, 25 Jul 2019 09:55:38 +0000 (GMT)
X-AuditID: b6c32a36-b49ff70000000feb-5f-5d397c9baee1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F9.7C.03706.A9C793D5; Thu, 25 Jul 2019 18:55:38 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190725095538epsmtip2f38872b5e416bf14678ccd1a705babdf~0ndvtvIEv1344113441epsmtip26;
        Thu, 25 Jul 2019 09:55:38 +0000 (GMT)
Subject: Re: [PATCH v3 1/5] devfreq: exynos-bus: correct clock enable
 sequence
To:     k.konieczny@partner.samsung.com
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <9c29db92-2452-0ff3-3ffa-d861e4327bc9@samsung.com>
Date:   Thu, 25 Jul 2019 18:58:43 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190719150535.15501-2-k.konieczny@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIJsWRmVeSWpSXmKPExsWy7bCmge7sGstYg/0XRCw2zljPajH/yDlW
        i759/xkt+h+/ZrY4f34Du8XZpjfsFpseX2O1uLxrDpvF594jjBYzzu9jslh75C67xdLrF5ks
        bjeuYLN48+Msk0Xr3iPsFv+ubWSx2PzgGJuDoMeaeWsYPTat6mTz2Lyk3uPguz1MHn1bVjF6
        HL+xncnj8ya5APaobJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUX
        nwBdt8wcoA+UFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQWWBXrFibnFpXnpesn5
        uVaGBgZGpkCFCdkZ/S9XMxVcU6n4e/YqUwPjZZkuRg4OCQETiQ+T5bsYuTiEBHYwSix5eZYV
        wvnEKDHxyzZmCOcbo0T/1MVAGU6wjjmrVzBCJPYySrw+fxzKec8o8f7fU7AqYYEAiV8LtjKB
        2CICyhKT700HG8UscJlFYtqjSWBFbAJaEvtf3GADsfkFFCWu/njMCGLzCthJ7H61BizOIqAq
        0bLmK9ggUYEIiU8PDrNC1AhKnJz5hAXE5hRwlfi/FGIxs4C4xK0n85kgbHmJ5q2zwRZLCJxj
        l9je3Qz1g4vEvHkwtrDEq+Nb2CFsKYnP7/ayQdjVEitPHmGDaO5glNiy/wJUg7HE/qWTmUDB
        xyygKbF+lz5EWFFi5++5jBCL+STefe1hhYQwr0RHmxBEibLE5Qd3mSBsSYnF7Z1sExiVZiF5
        ZxaSF2YheWEWwrIFjCyrGMVSC4pz01OLDQuMkKN7EyM4eWuZ7WBcdM7nEKMAB6MSDy9HkkWs
        EGtiWXFl7iFGCQ5mJRHewAazWCHelMTKqtSi/Pii0pzU4kOMpsDQnsgsJZqcD8wseSXxhqZG
        xsbGFiaGZqaGhkrivAt/AM0RSE8sSc1OTS1ILYLpY+LglGpglGZ5qzav4bVdHE9+2RHfqdcs
        P/X85C35yV7r8cS9e59A0uRDG3gld9d++KvwrY3nV+uUytJczkK/v8/+rhVl27Yg7PPFPRll
        xb47uBbqPih2TgizOudXxF0ft8utrcFzwdQtsqssDx/mlTsZdNat02Kuk3bx7VC9LOkvZ6M7
        U6/809i+yyZZiaU4I9FQi7moOBEAFCo0ovQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsWy7bCSvO6sGstYgy/PNC02zljPajH/yDlW
        i759/xkt+h+/ZrY4f34Du8XZpjfsFpseX2O1uLxrDpvF594jjBYzzu9jslh75C67xdLrF5ks
        bjeuYLN48+Msk0Xr3iPsFv+ubWSx2PzgGJuDoMeaeWsYPTat6mTz2Lyk3uPguz1MHn1bVjF6
        HL+xncnj8ya5APYoLpuU1JzMstQifbsEroz+l6uZCq6pVPw9e5WpgfGyTBcjJ4eEgInEnNUr
        GLsYuTiEBHYzSrxd38oKkZCUmHbxKHMXIweQLSxx+HAxRM1bRonfy2Yxg9QIC/hJ3JryF6xe
        REBZYvK96cwgRcwCV1kkzm+cwwbRcZlRYumt+ewgVWwCWhL7X9xgA7H5BRQlrv54zAhi8wrY
        Sex+tQYsziKgKtGy5isTiC0qECFxeMcsqBpBiZMzn7CA2JwCrhL/lz4F28wsoC7xZ94lZghb
        XOLWk/lMELa8RPPW2cwTGIVnIWmfhaRlFpKWWUhaFjCyrGKUTC0ozk3PLTYsMMxLLdcrTswt
        Ls1L10vOz93ECI5jLc0djJeXxB9iFOBgVOLh3RBvESvEmlhWXJl7iFGCg1lJhDewwSxWiDcl
        sbIqtSg/vqg0J7X4EKM0B4uSOO/TvGORQgLpiSWp2ampBalFMFkmDk6pBkauuJ+VcxmmnDwX
        w/aWc1G75f1F/YzuHxVSxHK2FCmrea0/W7TwbvPB5SVPKn+ILHa7wMt77tGLwD1Gk1UrPC8U
        eu6OPeZ7f4VRqGZ98aHzzG75yzLy38ka6Hpvfu67dcd32asffl1aYhprkXdYSmm9yWnBDbe+
        /Ky3Eqo6n/hM+431tDMTbT8rsRRnJBpqMRcVJwIAF0CQiN8CAAA=
X-CMS-MailID: 20190725095538epcas1p323a4e0d70b4a906ffb5927b2e43dc00f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190719150553eucas1p1665462f3fc0e06fc9c082e258be3a851
References: <20190719150535.15501-1-k.konieczny@partner.samsung.com>
        <CGME20190719150553eucas1p1665462f3fc0e06fc9c082e258be3a851@eucas1p1.samsung.com>
        <20190719150535.15501-2-k.konieczny@partner.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Kamil,

On 19. 7. 20. 오전 12:05, k.konieczny@partner.samsung.com wrote:
> Regulators should be enabled before clocks to avoid h/w hang. This
> require change in exynos_bus_probe() to move exynos_bus_parse_of()
> after exynos_bus_parent_parse_of() and change in enabling sequence
> of regulator and clock in exynos_bus_parse_of(). Similar change is
> needed in exynos_bus_exit() where clock should be disabled first.
> 
> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
> ---
> This patch is new to this series.
> 
> ---
>  drivers/devfreq/exynos-bus.c | 58 ++++++++++++++++++++----------------
>  1 file changed, 32 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index 486cc5b422f1..f391044aa39d 100644
> --- a/drivers/devfreq/exynos-bus.c
> +++ b/drivers/devfreq/exynos-bus.c
> @@ -194,11 +194,11 @@ static void exynos_bus_exit(struct device *dev)
>  	if (ret < 0)
>  		dev_warn(dev, "failed to disable the devfreq-event devices\n");
>  
> +	clk_disable_unprepare(bus->clk);
>  	if (bus->regulator)
>  		regulator_disable(bus->regulator);
>  
>  	dev_pm_opp_of_remove_table(dev);
> -	clk_disable_unprepare(bus->clk);
>  }
>  
>  /*
> @@ -326,8 +326,7 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
>  	return ret;
>  }
>  
> -static int exynos_bus_parse_of(struct device_node *np,
> -			      struct exynos_bus *bus)
> +static int exynos_bus_parse_of(struct exynos_bus *bus)
>  {
>  	struct device *dev = bus->dev;
>  	struct dev_pm_opp *opp;
> @@ -341,36 +340,35 @@ static int exynos_bus_parse_of(struct device_node *np,
>  		return PTR_ERR(bus->clk);
>  	}
>  
> -	ret = clk_prepare_enable(bus->clk);
> +	/* Get the freq and voltage from OPP table to scale the bus freq */
> +	ret = dev_pm_opp_of_add_table(dev);
>  	if (ret < 0) {
> -		dev_err(dev, "failed to get enable clock\n");
> +		dev_err(dev, "failed to get OPP table\n");
>  		return ret;
>  	}
>  
> -	/* Get the freq and voltage from OPP table to scale the bus freq */
> -	ret = dev_pm_opp_of_add_table(dev);
> +	ret = clk_prepare_enable(bus->clk);
>  	if (ret < 0) {
> -		dev_err(dev, "failed to get OPP table\n");
> +		dev_err(dev, "failed to enable clock\n");
>  		goto err_clk;
>  	}
> -
>  	rate = clk_get_rate(bus->clk);
>  
>  	opp = devfreq_recommended_opp(dev, &rate, 0);
>  	if (IS_ERR(opp)) {
>  		dev_err(dev, "failed to find dev_pm_opp\n");
>  		ret = PTR_ERR(opp);
> -		goto err_opp;
> +		goto err;
>  	}
>  	bus->curr_freq = dev_pm_opp_get_freq(opp);
>  	dev_pm_opp_put(opp);
>  
>  	return 0;
>  
> -err_opp:
> -	dev_pm_opp_of_remove_table(dev);
> -err_clk:
> +err:
>  	clk_disable_unprepare(bus->clk);
> +err_clk:
> +	dev_pm_opp_of_remove_table(dev);
>  
>  	return ret;
>  }
> @@ -386,6 +384,7 @@ static int exynos_bus_probe(struct platform_device *pdev)
>  	struct exynos_bus *bus;
>  	int ret, max_state;
>  	unsigned long min_freq, max_freq;
> +	bool passive = false;
>  
>  	if (!np) {
>  		dev_err(dev, "failed to find devicetree node\n");
> @@ -399,27 +398,31 @@ static int exynos_bus_probe(struct platform_device *pdev)
>  	bus->dev = &pdev->dev;
>  	platform_set_drvdata(pdev, bus);
>  
> -	/* Parse the device-tree to get the resource information */
> -	ret = exynos_bus_parse_of(np, bus);
> -	if (ret < 0)
> -		return ret;
> -
>  	profile = devm_kzalloc(dev, sizeof(*profile), GFP_KERNEL);
> -	if (!profile) {
> -		ret = -ENOMEM;
> -		goto err;
> -	}
> +	if (!profile)
> +		return -ENOMEM;
>  
>  	node = of_parse_phandle(dev->of_node, "devfreq", 0);
>  	if (node) {
>  		of_node_put(node);
> -		goto passive;
> +		passive = true;
>  	} else {
>  		ret = exynos_bus_parent_parse_of(np, bus);
> +		if (ret < 0)
> +			return ret;
>  	}
>  
> -	if (ret < 0)
> -		goto err;
> +	/* Parse the device-tree to get the resource information */
> +	ret = exynos_bus_parse_of(bus);
> +	if (ret < 0) {
> +		if (!passive)
> +			regulator_disable(bus->regulator);
> +
> +		return ret;
> +	}
> +
> +	if (passive)
> +		goto passive;
>  
>  	/* Initialize the struct profile and governor data for parent device */
>  	profile->polling_ms = 50;
> @@ -508,8 +511,11 @@ static int exynos_bus_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err:
> -	dev_pm_opp_of_remove_table(dev);
>  	clk_disable_unprepare(bus->clk);
> +	if (!passive)
> +		regulator_disable(bus->regulator);
> +
> +	dev_pm_opp_of_remove_table(dev);
>  
>  	return ret;
>  }
> 

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
