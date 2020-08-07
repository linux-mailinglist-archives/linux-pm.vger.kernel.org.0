Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E8A23EE1C
	for <lists+linux-pm@lfdr.de>; Fri,  7 Aug 2020 15:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgHGNZT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Aug 2020 09:25:19 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35460 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgHGNYd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Aug 2020 09:24:33 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200807132429euoutp02b78eb71d77f051f5c677ed783288e377~o-zS5XfBZ2969929699euoutp02d
        for <linux-pm@vger.kernel.org>; Fri,  7 Aug 2020 13:24:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200807132429euoutp02b78eb71d77f051f5c677ed783288e377~o-zS5XfBZ2969929699euoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1596806669;
        bh=B5EnSgcpapebYZeXWz/4l92sM1Av6xAfL9q+WTg/ndg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=YlX73LL4ZO20I8obTRdiT2Om/qFjsEQ4jQH3k0yYOj145qOE/WjU5wc96EohjkTNP
         2bvjV5EXRoy0sVBsIjUP+gtfaQxV7LMQWnPNiozENSmxoApQUlJHeW4UWk8mrBrGRG
         H8YxdWJ3bb9DKcT93cM1Mjo6qIbm5MxSetPK/0EY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200807132429eucas1p24abe913d58e10e18ec9998bbac7ec0b5~o-zSjB4YR2352023520eucas1p2E;
        Fri,  7 Aug 2020 13:24:29 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id D6.27.06456.D065D2F5; Fri,  7
        Aug 2020 14:24:29 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200807132428eucas1p1f81c2724e926824adf726656331a8149~o-zRy-kxw1507015070eucas1p1z;
        Fri,  7 Aug 2020 13:24:28 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200807132428eusmtrp13367e75a29a3a339eed4463c90fd4a5b~o-zRyUVU10220302203eusmtrp1S;
        Fri,  7 Aug 2020 13:24:28 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-f5-5f2d560dd393
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 10.60.06314.C065D2F5; Fri,  7
        Aug 2020 14:24:28 +0100 (BST)
Received: from [106.120.51.75] (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200807132428eusmtip2ade9f60db23b2a2da8d76b233a12c0c9~o-zRXWXlp3076230762eusmtip2_;
        Fri,  7 Aug 2020 13:24:28 +0000 (GMT)
Subject: Re: [PATCH] clk: samsung: Mark top BPLL mux on Exynos542x as
 critical
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Stephen Boyd <sboyd@kernel.org>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <75d19548-0bb0-89a9-9e3b-f57cfe865694@samsung.com>
Date:   Fri, 7 Aug 2020 15:24:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
        Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f9139970-564a-16fc-57aa-4ec11c509c8b@samsung.com>
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm2znbOS6PHqeyF5OCKV0EL6OEA4ZZ9kMCwQiyCzpPeryUm7bp
        yn6Et8q7YoI67WbaZXhJmXcIJubQpesC3axUmMoC07yEaWnOo+S/53nf53m+94GPxCQGoQeZ
        pErj1Co2WSYS4x0Dv0d8qTO+ioD+SnemtapFyHxYnBYyFstzgvlZ9E3ILBT3I6bK8kLAPMzO
        JZim/q8Es/a+FWduT9qwEHFY471GFNamzxeFlRj0KGyhbU8Efl58JI5LTtJyav/gGHFiTalJ
        mNpAXRu865mJlsQFyIEE+jBYx9+gAiQmJfRTBKuPCgQ8WUSw3GvAeLKAwJiTJdy22EyrW4sn
        CP50vtvyzyBoMXza8JOkKx0BxpJAu8GNjoSxuR+EXYPRzQJonK8X2RciWg7FL0uQHVN0MIx3
        jgnsGKe9YXXoF27H7vQ56J60EbzGBQarrZtzB/oo6HJvbuZgtBSyF58JebwXOmdqN68DeoCA
        oddWZD8I6BNgmmX5Bq7w3WQgeOwJ5jtFOK/PQVDUO0rwpAzBmOkB4lVB8GVkRWQPwuiD0NLj
        z4+PQW5DFsbnO8HHGRf+Bico76jcGlOQd0vCqzdq6SsFPPaAQus6XoZkuh3NdDva6Ha00f1/
        9wHC9UjKpWuUCZxGruKu+mlYpSZdleAXm6JsQxt/ybxmmu9CS28v9iGaRDJHajncVyERslpN
        hrIPAYnJ3Kjjw+ZoCRXHZlzn1CkKdXoyp+lDu0lcJqUO1dmiJHQCm8Zd5rhUTr29FZAOHplI
        HRrqFR3q61w4ZdRO/9W11OyvHiwPaArXluI+KFrNeMsydklnPU9eCOnu8DpLnbZMOEtzXlVQ
        MZIDtXmX1jqcayPjqwaN93uUrsMZ2e2K8sXUuXxVekMs1ew4Xjh6agLXx18J7JLHB1WIPz+e
        YvKXJ1urzVHrN9rn6/bVr6hkuCaRlftgag37D3LrUqtHAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsVy+t/xe7o8YbrxBp9vqlhsnLGe1eL6l+es
        FufPb2C3+Nhzj9Xic+8RRosZ5/cxWSxsamG3WHvkLrvFv2sbWSzan75kduDyWDNvDaPHplWd
        bB59W1YxenzeJBfAEqVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Ka
        k1mWWqRvl6CXMbv/OGvBUt6Kk3NlGhi/cnUxcnJICJhIvDz+m7mLkYtDSGApo8TGSUdZuxg5
        gBJSEvNblCBqhCX+XOtig6h5zSjx+O5mFpCEsICfxI5JbYwgtohAuMTd/gWsIEXMAuuYJK42
        P2aC6DjGKPH93WmwDjYBQ4neo31gHbwCdhIPtt9nArFZBFQkfp/6xgKyWVQgUmLnDkuIEkGJ
        kzOfgLVyCthLzGppZQOxmQXUJf7Mu8QMYYtLNH1ZyQphy0tsfzuHeQKj0Cwk7bOQtMxC0jIL
        ScsCRpZVjCKppcW56bnFhnrFibnFpXnpesn5uZsYgXG47djPzTsYL20MPsQowMGoxMO7wFs3
        Xog1say4MvcQowQHs5IIr9PZ03FCvCmJlVWpRfnxRaU5qcWHGE2BfpvILCWanA9MEXkl8Yam
        huYWlobmxubGZhZK4rwdAgdjhATSE0tSs1NTC1KLYPqYODilGhjnyjwxaFPdKpEwK1mpdM+5
        henCb2pmLuw6l11Rrq2zu0xPN1JQ6PGHC40fc9XnVmln5DlEm7F8/HFugSzTH4GUw2f6Py5a
        cO7NC76fa/Qnhv/vFL5iJ3Xjxae9TraTVRYuK22Zrma5+rGDQodGT5PZxDtnMyPjzd9KmR0L
        /nlqQtyPBwddvlcosRRnJBpqMRcVJwIAxIBrL9kCAAA=
X-CMS-MailID: 20200807132428eucas1p1f81c2724e926824adf726656331a8149
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200805091612eucas1p28c955b21e57898de60d3ed50c95b9d18
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200805091612eucas1p28c955b21e57898de60d3ed50c95b9d18
References: <CGME20200805091612eucas1p28c955b21e57898de60d3ed50c95b9d18@eucas1p2.samsung.com>
        <20200805091601.11983-1-m.szyprowski@samsung.com>
        <f9139970-564a-16fc-57aa-4ec11c509c8b@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 8/6/20 04:49, Chanwoo Choi wrote:
> On 8/5/20 6:16 PM, Marek Szyprowski wrote:
>> BPLL clock must not be disabled because it is needed for proper DRAM
>> operation. This is normally handled by respective memory devfreq driver,
>> but when that driver is not yet probed or its probe has been deferred the
>> clock might got disabled what causes board hang. Fix this by marking it
>> as critical.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>  drivers/clk/samsung/clk-exynos5420.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
>> index fea33399a632..5ef78928938a 100644
>> --- a/drivers/clk/samsung/clk-exynos5420.c
>> +++ b/drivers/clk/samsung/clk-exynos5420.c
>> @@ -734,7 +734,7 @@ static const struct samsung_mux_clock exynos5x_mux_clks[] __initconst = {
>>  	MUX_F(CLK_MOUT_MCLK_CDREX, "mout_mclk_cdrex", mout_mclk_cdrex_p,
>>  			SRC_CDREX, 4, 1, CLK_SET_RATE_PARENT, 0),
>>  	MUX_F(CLK_MOUT_BPLL, "mout_bpll", mout_bpll_p, SRC_CDREX, 0, 1,
>> -			CLK_SET_RATE_PARENT, 0),
>> +			CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, 0),
>>  
>>  	/* MAU Block */
>>  	MUX(CLK_MOUT_MAUDIO0, "mout_maudio0", mout_maudio0_p, SRC_MAU, 28, 3),
>>
> Thanks for your fix. Looks good to me.
> Just I have one comment. I looks like the similar case of patch[1] related to G3D clock.
> [1] commit 67f96ff7c8f0 ("clk: samsung: exynos5420: Keep top G3D clocks enabled")
> 
> How about fixing this issue with same style[1]?

Yes, I think it would be better to make it the same way as it was done with 
the G3D clock.

-- 
Thanks,
Sylwester
