Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80D16240103
	for <lists+linux-pm@lfdr.de>; Mon, 10 Aug 2020 04:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgHJCqa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 9 Aug 2020 22:46:30 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:34738 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbgHJCqa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 9 Aug 2020 22:46:30 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200810024626epoutp023d46f0da627d2437b5130faac25c2146~pyCDyFnap1427414274epoutp02a
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2020 02:46:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200810024626epoutp023d46f0da627d2437b5130faac25c2146~pyCDyFnap1427414274epoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597027586;
        bh=Hm0O4+wp4rjYdiIKJCgeEeM6ngWanf6naZsiI8pn48w=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=inqBJrfmptA999manEJmdnIMPcfNa7MRHg7x+vcQsFd1m8yba6blwSvsKlK9Iap5S
         ZikJOA4p7j8prUs3rqOf2Md8rHRkvMn5Gep2yIjssY2GchhkvZaTardhFiyMTs3nwY
         yaLFVlJC1y9FmnOvB7IXceUl4XPlRbNn5t8WPSF8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200810024626epcas1p304ceed0c05a692d8cc9c7a67f1a5eaf1~pyCDbjKwO1266712667epcas1p3-;
        Mon, 10 Aug 2020 02:46:26 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.156]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4BQ0hv5xR2zMqYlh; Mon, 10 Aug
        2020 02:46:23 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        BD.46.28581.FF4B03F5; Mon, 10 Aug 2020 11:46:23 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200810024623epcas1p2888eb6e65b5b870cdd1a343498d41621~pyCAonPsQ1322213222epcas1p22;
        Mon, 10 Aug 2020 02:46:23 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200810024623epsmtrp19e2ace4bf31297cb87a8ef19faba5b78~pyCAntfji2223222232epsmtrp1c;
        Mon, 10 Aug 2020 02:46:23 +0000 (GMT)
X-AuditID: b6c32a38-2cdff70000006fa5-f7-5f30b4ff64b2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        CC.A5.08303.FF4B03F5; Mon, 10 Aug 2020 11:46:23 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200810024622epsmtip2775ae2bd691c6b00358fae458caa5262~pyCAQlQxe2988229882epsmtip2u;
        Mon, 10 Aug 2020 02:46:22 +0000 (GMT)
Subject: Re: [PATCH v2] clk: samsung: Keep top BPLL mux on Exynos542x
 enabled
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
Message-ID: <9dafbfdb-c882-1151-b164-f04e65374264@samsung.com>
Date:   Mon, 10 Aug 2020 11:58:33 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200807133143.22748-1-m.szyprowski@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPJsWRmVeSWpSXmKPExsWy7bCmvu7/LQbxBpOm6VtsnLGe1eL8+Q3s
        Fh977rFafO49wmgx4/w+JouFTS3sFmuP3GW3+HdtI4tF+9OXzA6cHmvmrWH02LSqk82jb8sq
        Ro/Pm+QCWKKybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTd
        MnOAblFSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFFgW6BUn5haX5qXrJefnWhka
        GBiZAhUmZGfsfPKdveA6d8XJngmMDYxXObsYOTkkBEwknm+bytLFyMUhJLCDUWLRnwvsEM4n
        Rokp3TcYIZzPjBIP351k7WLkAGs58UsNIr6LUeJz4wRmCOc9o8TvUwvZQeYKC/hLnNx3AmyU
        iEAno8T8KTdYQRxmgUuMEu9uvwKrYhPQktj/4gYbiM0voChx9cdjRhCbV8BOYv6VacwgNouA
        qkTnrstg9aICYRInt7VA1QhKnJz5hAXE5gSqf71hEVicWUBc4taT+UwQtrzE9rdzwM6TEFjK
        IbFoy1d2iLddJBbMnwVlC0u8Or4FypaSeNnfBmVXS6w8eYQNormDUWLL/gusEAljif1LJzOB
        AoNZQFNi/S59iLCixM7fc6GO4JN497UHGl68Eh1tQhAlyhKXH9xlgrAlJRa3d7JNYFSaheSd
        WUhemIXkhVkIyxYwsqxiFEstKM5NTy02LDBBju9NjOCUqmWxg3Hu2w96hxiZOBgPMUpwMCuJ
        8Nrd1Y8X4k1JrKxKLcqPLyrNSS0+xGgKDOCJzFKiyfnApJ5XEm9oamRsbGxhYmhmamioJM77
        8JZCvJBAemJJanZqakFqEUwfEwenVAOTZH1lSlncrPWTJ2SyHog88qrD9ITwA/cJxonHDO+F
        z1mX7XLk5onvU57lKTysjCiIvj1XNPSOf/D/Vw8OtT+9fkD18s9txs1ciVda7/ScUz1vKrFn
        o5Gq1Qlfyxjrp/GOWtWzf21j8fvM3iX17KrN6jnf1i5IPux7q6dmbtmSj2tTrnFMXHDAUiei
        m3nPNd4S3zeXvHcnn5+m987p2FUeDdmDzNtOFClY+Z65HpQumP9kmVB19Jr3TFaPL7s7cBQb
        OG954/7LKy9q2olfL1pUi89tC3I+eIqhueNj7GXmJqaqPpY/UcXMa5xKFzx8fuDlvO+t8k03
        V/3c+VX6jNvmg77MD49aH72Qk797o6mYpxJLcUaioRZzUXEiAGkKVJUyBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42LZdlhJXvf/FoN4g009/BYbZ6xntTh/fgO7
        xceee6wWn3uPMFrMOL+PyWJhUwu7xdojd9kt/l3byGLR/vQlswOnx5p5axg9Nq3qZPPo27KK
        0ePzJrkAligum5TUnMyy1CJ9uwSujJ1PvrMXXOeuONkzgbGB8SpnFyMHh4SAicSJX2pdjFwc
        QgI7GCVenTzA3sXICRSXlJh28SgzRI2wxOHDxRA1bxklbh75wAxSIyzgK9G3aRErSEJEoJNR
        Ys+jH2wgDrPAFUaJfTObmSBaJgJlTlwFa2ET0JLY/+IGG4jNL6AocfXHY0YQm1fATmL+lWlg
        NSwCqhKduy6DnSEqECaxc8ljJogaQYmTM5+wgNicQPWvNywC62UWUJf4M+8SM4QtLnHryXwm
        CFteYvvbOcwTGIVnIWmfhaRlFpKWWUhaFjCyrGKUTC0ozk3PLTYsMMpLLdcrTswtLs1L10vO
        z93ECI4tLa0djHtWfdA7xMjEwXiIUYKDWUmE1+6ufrwQb0piZVVqUX58UWlOavEhRmkOFiVx
        3q+zFsYJCaQnlqRmp6YWpBbBZJk4OKUamMJsdyhNP394H/eaR7MZc7f+S9/mE/a1e8e6a7Xm
        Z7fczl2Rx1dh0J38Xfbn0dst/qa+57P79u5/dJ+L9+ZJjmNBfG+P+fayP35u+X1faOqjQxzT
        WQuqZoaoc92IO5Rsn27p6uAauXHPUv4J+4IsK/64MCvyqpZu22xr7HWxfcX3tPczd85flbE1
        duJh7l3WMk2Fpxc+FF714FcyQ8B7nemzwjulViZa9HazTDZL9slt1fu/28e8d6t8bPRjq8Of
        Sv1bW31/MN9NMvrtuu/kzqaWNZ3BrLejPvy5pSKvt/aTUt/D2eY3HgfZ/WMO2ZviM3l+2pOr
        wT/n7cq6cPCJh5ZxzaVwhScJc/mvWIquuKvEUpyRaKjFXFScCABpcE4nHAMAAA==
X-CMS-MailID: 20200810024623epcas1p2888eb6e65b5b870cdd1a343498d41621
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200807133152eucas1p1d83611a984f5c5d875192d08e2f5711f
References: <CGME20200807133152eucas1p1d83611a984f5c5d875192d08e2f5711f@eucas1p1.samsung.com>
        <20200807133143.22748-1-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Marek,

On 8/7/20 10:31 PM, Marek Szyprowski wrote:
> BPLL clock must not be disabled because it is needed for proper DRAM
> operation. This is normally handled by respective memory devfreq driver,
> but when that driver is not yet probed or its probe has been deferred the
> clock might got disabled what causes board hang. Fix this by calling
> clk_prepare_enable() directly from the clock provider driver.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> Tested-by: Lukasz Luba <lukasz.luba@arm.com>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/clk/samsung/clk-exynos5420.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> index fea33399a632..521cbbfc0987 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -1655,6 +1655,11 @@ static void __init exynos5x_clk_init(struct device_node *np,
>  	 * main G3D clock enablement status.
>  	 */
>  	clk_prepare_enable(__clk_lookup("mout_sw_aclk_g3d"));
> +	/*
> +	 * Keep top BPLL mux enabled permanently to ensure that DRAM operates
> +	 * properly.
> +	 */
> +	clk_prepare_enable(__clk_lookup("mout_bpll"));
>  
>  	samsung_clk_of_add_provider(np, ctx);
>  }
> 

Thanks.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
