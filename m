Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2860A23D587
	for <lists+linux-pm@lfdr.de>; Thu,  6 Aug 2020 04:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgHFCiC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Aug 2020 22:38:02 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:33256 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgHFCiB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Aug 2020 22:38:01 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200806023759epoutp013703336b5165c27da5af0d3811433b16~ojVh6-Hru2438124381epoutp01O
        for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2020 02:37:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200806023759epoutp013703336b5165c27da5af0d3811433b16~ojVh6-Hru2438124381epoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1596681479;
        bh=xH7bL+kle9j+exssiWUT4mq/xAboUma94B+Nbk8vdRs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Rghf8sFwIoUzN38il/BZ5yAlwtgovKfqDaKMOlMK2hm+lLGvbpsKL1E0wJl/qmq3N
         45zx1VASgA36d4SbNQadsFPbmPGFGY5YlRYwD6KLd6Frb36hF2ZKHuOLh0h8ovEmw/
         mPFoQSBQKJ0aOfOjAyq4hdbxZgN2qDlvbOo+1SGk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200806023758epcas1p2ef5b75dad43e18c8534c9c9d55ae876d~ojVhmAI0g0497004970epcas1p2X;
        Thu,  6 Aug 2020 02:37:58 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.153]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4BMXj024f0zMqYkk; Thu,  6 Aug
        2020 02:37:56 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        0D.3D.28581.40D6B2F5; Thu,  6 Aug 2020 11:37:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200806023755epcas1p35e51d1b8d855456d129e4e725b769c88~ojVeQ2Tsw3001230012epcas1p3R;
        Thu,  6 Aug 2020 02:37:55 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200806023755epsmtrp2a5b7acfafbc065150137e01df6e93cfd~ojVeQFxem2129621296epsmtrp2P;
        Thu,  6 Aug 2020 02:37:55 +0000 (GMT)
X-AuditID: b6c32a38-85df1a8000006fa5-f9-5f2b6d040949
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        82.B2.08382.20D6B2F5; Thu,  6 Aug 2020 11:37:55 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200806023754epsmtip2ad3401f148b627b271c90102e341e131~ojVeC8Ojj0843708437epsmtip23;
        Thu,  6 Aug 2020 02:37:54 +0000 (GMT)
Subject: Re: [PATCH] clk: samsung: Mark top BPLL mux on Exynos542x as
 critical
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Sylwester Nawrocki <snawrocki@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Stephen Boyd <sboyd@kernel.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <f9139970-564a-16fc-57aa-4ec11c509c8b@samsung.com>
Date:   Thu, 6 Aug 2020 11:49:54 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200805091601.11983-1-m.szyprowski@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmri5Lrna8wY7v/BYbZ6xntTh/fgO7
        xceee6wWn3uPMFrMOL+PyWJhUwu7xdojd9kt/l3byGLR/vQlswOnx5p5axg9Nq3qZPPo27KK
        0ePzJrkAlqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23
        zBygW5QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BZYFesWJucWleel6yfm5VoYG
        BkamQIUJ2Rkf3zgXvOSpuNTazNbAeIKri5GTQ0LAROJb7xemLkYuDiGBHYwS25t2s0I4nxgl
        pl56ywRSJSTwjVGi/W0WTMfD6T+YIYr2Mko07v4P1fGeUeLxm7tADgeHsECAxME+U5C4iEAn
        o8T8KTfAipgFLjFKvLv9ih1kFJuAlsT+FzfYQGx+AUWJqz8eM4LYvAJ2Ete+TmUFsVkEVCTu
        H5wDZosKhEmc3NYCVSMocXLmExYQmxOo/suJtWBzmAXEJW49mc8EYctLbH87B+xUCYGFHBKL
        Ts9nhfjBReJC70t2CFtY4tXxLVC2lMTnd3vZIOxqiZUnj7BBNHcwSmzZfwGq2Vhi/9LJTCBv
        MgtoSqzfpQ8RVpTY+XsuI8RiPol3X3vAISEhwCvR0SYEUaIscfnBXSYIW1JicXsn2wRGpVlI
        3pmF5IVZSF6YhbBsASPLKkax1ILi3PTUYsMCE+TY3sQITqdaFjsY5779oHeIkYmD8RCjBAez
        kgjvx8/q8UK8KYmVValF+fFFpTmpxYcYTYEBPJFZSjQ5H5jQ80riDU2NjI2NLUwMzUwNDZXE
        eR/eUogXEkhPLEnNTk0tSC2C6WPi4JRqYJr3OsM69KK6bct38Qj7WXqVq8x3nM3w55d8w8/6
        aLn7PHYdh2UfdzK8rv3ooWro3e918fG9/6qdPmVlGzcI3RfI0vt8eXrvs5NLWN8f7L5Q1ixn
        8uPOsnn/Knqn9cmcmx89lSv4j7ikwvK/ydslEnUMWoK2arYoequlpi64vumwUsId8+bmo1W7
        W6c+chZwjFrcqXtn0z3jl1e3fyvLLWazjwlRebhj6RHHGWU2CRLftCfwif0L+jFN6/Pu+d+f
        693SuHH36VafWdv32mnlebYxadxc9CNap/4oa3Jt0Sf1Lb0za9yidVdc0LnySTSqhdnv5zaf
        40IMzrPPbsi/wVTw+q15MNOiuxX6K+fcElRiKc5INNRiLipOBABEUcr/MAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42LZdlhJXpc5VzveYNETRouNM9azWpw/v4Hd
        4mPPPVaLz71HGC1mnN/HZLGwqYXdYu2Ru+wW/65tZLFof/qS2YHTY828NYwem1Z1snn0bVnF
        6PF5k1wASxSXTUpqTmZZapG+XQJXxsc3zgUveSoutTazNTCe4Opi5OSQEDCReDj9B3MXIxeH
        kMBuRonbu/YyQiQkJaZdPAqU4ACyhSUOHy6GqHnLKLFz9mkmkBphAT+JHZPaGEESIgKdjBJ7
        Hv1gA3GYBa4wSuyb2cwE0TKRUeLEskdgY9kEtCT2v7jBBmLzCyhKXP3xGCzOK2Ance3rVFYQ
        m0VAReL+wTlgtqhAmMTOJY+ZIGoEJU7OfMICYnMC1X85sRZsDrOAusSfeZeYIWxxiVtP5jNB
        2PIS29/OYZ7AKDwLSfssJC2zkLTMQtKygJFlFaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+
        7iZGcGxpae5g3L7qg94hRiYOxkOMEhzMSiK8Hz+rxwvxpiRWVqUW5ccXleakFh9ilOZgURLn
        vVG4ME5IID2xJDU7NbUgtQgmy8TBKdXAFKie8bB68Uwl/jrDy4KTalsedDPEfW7vv/ii6oGo
        hJBKE0Ps1G3NIbJ7ImvqtgVa/pQXMd1hui14w10rrUPNTt0HxAMeGTpeDdndvEomwUbq7Mly
        xpR0r2fFSZ9KGuKLwr3nn2W+KDn5Xne6IHNpoLRbzcm9oQdlPu28/min46wT7qVKeic3/cle
        9y3JYnf4l5uOGy+Lbnh9o6fycNPr8+prBfcpvD+0MSBpfVpptZsD27bVC9yEv+iaXyz5/WqL
        2qH4A8zXJuydLTd7t2B68y7RrFVXFS93+B0OFd6etCyp+uKE+zofDkToqM7Yc2bT5a7g5TeW
        79q27J/YuUl+n17/+T551c1Zqmnf2rx8epVYijMSDbWYi4oTAaRcO1scAwAA
X-CMS-MailID: 20200806023755epcas1p35e51d1b8d855456d129e4e725b769c88
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200805091612eucas1p28c955b21e57898de60d3ed50c95b9d18
References: <CGME20200805091612eucas1p28c955b21e57898de60d3ed50c95b9d18@eucas1p2.samsung.com>
        <20200805091601.11983-1-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Marek,

On 8/5/20 6:16 PM, Marek Szyprowski wrote:
> BPLL clock must not be disabled because it is needed for proper DRAM
> operation. This is normally handled by respective memory devfreq driver,
> but when that driver is not yet probed or its probe has been deferred the
> clock might got disabled what causes board hang. Fix this by marking it
> as critical.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5420.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> index fea33399a632..5ef78928938a 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -734,7 +734,7 @@ static const struct samsung_mux_clock exynos5x_mux_clks[] __initconst = {
>  	MUX_F(CLK_MOUT_MCLK_CDREX, "mout_mclk_cdrex", mout_mclk_cdrex_p,
>  			SRC_CDREX, 4, 1, CLK_SET_RATE_PARENT, 0),
>  	MUX_F(CLK_MOUT_BPLL, "mout_bpll", mout_bpll_p, SRC_CDREX, 0, 1,
> -			CLK_SET_RATE_PARENT, 0),
> +			CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, 0),
>  
>  	/* MAU Block */
>  	MUX(CLK_MOUT_MAUDIO0, "mout_maudio0", mout_maudio0_p, SRC_MAU, 28, 3),
> 

Thanks for your fix. Looks good to me.
Just I have one comment. I looks like the similar case of patch[1] related to G3D clock.
[1] commit 67f96ff7c8f0 ("clk: samsung: exynos5420: Keep top G3D clocks enabled")

How about fixing this issue with same style[1]?
Or are there any reason about should you do it with CLK_IS_CRITICAL?

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
