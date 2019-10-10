Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB63D1EA9
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2019 04:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732699AbfJJCpT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Oct 2019 22:45:19 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:34516 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732755AbfJJCpT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Oct 2019 22:45:19 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191010024515epoutp032186088e42ef746c82c2fa248b52c13c~MKQ8jg4n-2319523195epoutp03p
        for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2019 02:45:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191010024515epoutp032186088e42ef746c82c2fa248b52c13c~MKQ8jg4n-2319523195epoutp03p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1570675515;
        bh=y+8N/oTMLH273gtMScb/TXmzbFwYfa48oNukTHhysEQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Oh96qE4opZMXsu/UOb8W//Pn0wmsZEWWX/pmbXWcZo8rmXwWpa0XVqVpjS3TX8X5i
         64WkaUfJmlzIudDFHP63MKDP4WLKIsOI46YSXGxVOTrtNikkdp0zJbfiuywYOBJ3uL
         Nv67gsOmDuOSLWg6qOyjVB7PwTtVyykQ3QGYQQNA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191010024514epcas1p4e8b6063991cdaec6bde9584f60de9857~MKQ8CNrez2591425914epcas1p4h;
        Thu, 10 Oct 2019 02:45:14 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.158]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 46pb6H6NdPzMqYlm; Thu, 10 Oct
        2019 02:45:11 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        27.56.04144.73B9E9D5; Thu, 10 Oct 2019 11:45:11 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191010024511epcas1p1d4aa4f9543646b63ee333fe4d95140d6~MKQ5AZMcv0984309843epcas1p16;
        Thu, 10 Oct 2019 02:45:11 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191010024511epsmtrp16a82d2c4e19036109d944336523539dc~MKQ4-gFDx2082620826epsmtrp1I;
        Thu, 10 Oct 2019 02:45:11 +0000 (GMT)
X-AuditID: b6c32a35-2c7ff70000001030-6f-5d9e9b373390
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E4.6C.04081.63B9E9D5; Thu, 10 Oct 2019 11:45:11 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191010024510epsmtip2dc0c7be1f61bf1a75a2054793f112335~MKQ4sZUTr1945119451epsmtip2X;
        Thu, 10 Oct 2019 02:45:10 +0000 (GMT)
Subject: Re: [PATCH] devfreq: exynos-bus: workaround dev_pm_opp_set_rate()
 errors on Exynos5422/5800 SoCs
To:     k.konieczny@partner.samsung.com
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <4f14d3af-e455-d05b-fc03-cba58e001f41@samsung.com>
Date:   Thu, 10 Oct 2019 11:50:13 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191008134923.30123-1-k.konieczny@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFJsWRmVeSWpSXmKPExsWy7bCmvq757HmxBjeemVhsnLGe1aJv339G
        i/7Hr5ktzp/fwG5xtukNu8Wmx9dYLS7vmsNm8bn3CKPFjPP7mCzWHrnLbnG7cQWbA7fHplWd
        bB6bl9R7HHy3h8mjb8sqRo/Pm+QCWKOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0t
        LcyVFPISc1NtlVx8AnTdMnOALlNSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFFgW
        6BUn5haX5qXrJefnWhkaGBiZAhUmZGc82LyLueClWMXe6Q+ZGxgPCHUxcnJICJhILH57hrmL
        kYtDSGAHo8TjDaehnE+MEmcv9kI53xglJn5oZYZrad7CBpHYyyix/udHJgjnPaPEngl7WUCq
        hAWyJb6dXgbWISKgLDH53nSwUcwCXcwS+59eBkuwCWhJ7H9xgw3E5hdQlLj64zEjiM0rYCex
        c8JJdhCbRUBVouvJIbChogIREkceLISqEZQ4OfMJWJxTwFXi/NeXYPXMAuISt57MZ4Kw5SWa
        t84GWywhMJld4u2mVkaIH1wkLjxqYoewhSVeHd8CZUtJvOxvg7KrJVaePMIG0dzBKLFl/wVW
        iISxxP6lk4E2cABt0JRYv0sfIqwosfP3XEaIxXwS7772sIKUSAjwSnS0QUNbWeLyg7tMELak
        xOL2TrYJjEqzkLwzC8kLs5C8MAth2QJGllWMYqkFxbnpqcWGBYbI8b2JEZxutUx3ME4553OI
        UYCDUYmHN+Pk3Fgh1sSy4srcQ4wSHMxKIryLZs2JFeJNSaysSi3Kjy8qzUktPsRoCgzticxS
        osn5wFyQVxJvaGpkbGxsYWJoZmpoqCTO65HeECskkJ5YkpqdmlqQWgTTx8TBKdXAuKYv5Ljt
        6unZHEYvVKqXmbavMjLXfLn8ZXi0d7eh3YPYONvr3///lo/l+x+5nOHvOXWPsFscQbH7QsMl
        ouJlijf+sQ9YHW4uKtdSyWMZmS92Y8nEeSvn+CfJ8/LWRr1Pv3fgpYhxC7/euSns9Xt+LH96
        ZlG88KH7bJ/Ejm07lln5turjXX1rJZbijERDLeai4kQAtbSrH80DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsWy7bCSvK757HmxBuevslhsnLGe1aJv339G
        i/7Hr5ktzp/fwG5xtukNu8Wmx9dYLS7vmsNm8bn3CKPFjPP7mCzWHrnLbnG7cQWbA7fHplWd
        bB6bl9R7HHy3h8mjb8sqRo/Pm+QCWKO4bFJSczLLUov07RK4Mh5s3sVc8FKsYu/0h8wNjAeE
        uhg5OSQETCQWN29h62Lk4hAS2M0o0XWhgxEiISkx7eJR5i5GDiBbWOLw4WKQsJDAW0aJnms8
        ILawQLbEt9PLmEFsEQFlicn3pjODzGEW6GGWaN/fzAQxdAajxK/VDawgVWwCWhL7X9xgA7H5
        BRQlrv54DLaMV8BOYueEk+wgNouAqkTXk0MsILaoQITE6uUvWCFqBCVOznwCFucUcJU4//Ul
        WD2zgLrEn3mXmCFscYlbT+YzQdjyEs1bZzNPYBSehaR9FpKWWUhaZiFpWcDIsopRMrWgODc9
        t9iwwDAvtVyvODG3uDQvXS85P3cTIzjqtDR3MF5eEn+IUYCDUYmHN+Pk3Fgh1sSy4srcQ4wS
        HMxKIryLZs2JFeJNSaysSi3Kjy8qzUktPsQozcGiJM77NO9YpJBAemJJanZqakFqEUyWiYNT
        qoGxc0ZKx4LWxIxinZXSm6YllnO8zojkPs/wTveah2kOH2/hBf8Vhq819X0/X4tTcA0OvOL2
        teep0Tpzq/Q901QCshfctmh9otFql/2rbtGv+1zN1oYTV29+d3jHv0sGW4qY1iifmyk4R18y
        cL6vmfO3xwtuMUpzblmxdy/vNmmZptdaDnqevVxKLMUZiYZazEXFiQB51qFitgIAAA==
X-CMS-MailID: 20191010024511epcas1p1d4aa4f9543646b63ee333fe4d95140d6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191008134950eucas1p15cfef5800efc10d5b18ec5eb37dde60b
References: <CGME20191008134950eucas1p15cfef5800efc10d5b18ec5eb37dde60b@eucas1p1.samsung.com>
        <20191008134923.30123-1-k.konieczny@partner.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2019년 10월 08일 22:49, k.konieczny@partner.samsung.com wrote:
> Commit 4294a779bd8d ("PM / devfreq: exynos-bus: Convert to use
> dev_pm_opp_set_rate()") introduced errors:
> exynos-bus: new bus device registered: soc:bus_wcore ( 84000 KHz ~ 400000 KHz)
> exynos-bus: new bus device registered: soc:bus_noc ( 67000 KHz ~ 100000 KHz)
> exynos-bus: new bus device registered: soc:bus_fsys_apb (100000 KHz ~ 200000 KHz)
> ...
> exynos-bus soc:bus_wcore: dev_pm_opp_set_rate: failed to find current OPP for freq 532000000 (-34)
> exynos-bus soc:bus_noc: dev_pm_opp_set_rate: failed to find current OPP for freq 111000000 (-34)
> exynos-bus soc:bus_fsys_apb: dev_pm_opp_set_rate: failed to find current OPP for freq 222000000 (-34)
> 
> They are caused by incorrect PLL assigned to clock source, which results
> in clock rate outside of OPP range. Add workaround for this in
> exynos_bus_parse_of() by adjusting clock rate to those present in OPP.

If the clock caused this issue, you can set the initial clock on DeviceTree
with assigned-clock-* properties. Because the probe time of clock driver
is early than the any device drivers.

It is not proper to fix the clock issue on other device driver.
I think you can fix it by using the supported clock properties.


> 
> Fixes: 4294a779bd8d ("PM / devfreq: exynos-bus: Convert to use dev_pm_opp_set_rate()")
> Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
> ---
>  drivers/devfreq/exynos-bus.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index c832673273a2..37bd34d5625b 100644
> --- a/drivers/devfreq/exynos-bus.c
> +++ b/drivers/devfreq/exynos-bus.c
> @@ -243,7 +243,7 @@ static int exynos_bus_parse_of(struct device_node *np,
>  {
>  	struct device *dev = bus->dev;
>  	struct dev_pm_opp *opp;
> -	unsigned long rate;
> +	unsigned long rate, opp_rate;
>  	int ret;
>  
>  	/* Get the clock to provide each bus with source clock */
> @@ -267,13 +267,21 @@ static int exynos_bus_parse_of(struct device_node *np,
>  	}
>  
>  	rate = clk_get_rate(bus->clk);
> -
> -	opp = devfreq_recommended_opp(dev, &rate, 0);
> +	opp_rate = rate;
> +	opp = devfreq_recommended_opp(dev, &opp_rate, 0);
>  	if (IS_ERR(opp)) {
>  		dev_err(dev, "failed to find dev_pm_opp\n");
>  		ret = PTR_ERR(opp);
>  		goto err_opp;
>  	}
> +	/*
> +	 * FIXME: U-boot leaves clock source at incorrect PLL, this results
> +	 * in clock rate outside defined OPP rate. Work around this bug by
> +	 * setting clock rate to recommended one.
> +	 */
> +	if (rate > opp_rate)
> +		clk_set_rate(bus->clk, opp_rate);
> +
>  	bus->curr_freq = dev_pm_opp_get_freq(opp);
>  	dev_pm_opp_put(opp);
>  
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
