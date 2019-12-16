Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89B1D11FC55
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2019 01:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfLPAu5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Dec 2019 19:50:57 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:52924 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfLPAu5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Dec 2019 19:50:57 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191216005055epoutp018f0f46ae121501d9ea835f80b0dc94e1~gs7QYtABD1283012830epoutp01N
        for <linux-pm@vger.kernel.org>; Mon, 16 Dec 2019 00:50:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191216005055epoutp018f0f46ae121501d9ea835f80b0dc94e1~gs7QYtABD1283012830epoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576457455;
        bh=eOKZFtEtodywr7reb+wwKFTw2jgOl7JGDlGOvMIhTe8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=m+yzd1v+Mhbm1JOEbLKGSLxXM9pwKyqixWncRSut2ZcsPF1p9sKqTvKQ33AaFyNyT
         exUq3nOt+NWwVzuUbZjTt2mll9y/xIkYIGIy7WABi5WFdGWGkMoGBSn6eQ5282iznF
         kvV8aY76jjvQ7ZgEg0LcDgL+IBI6E2erUhVyp5Zg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191216005054epcas1p385f5e8d50bde6ebb34d87216a7443360~gs7PugLbs1055810558epcas1p3K;
        Mon, 16 Dec 2019 00:50:54 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.157]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47bjPS4VqSzMqYkj; Mon, 16 Dec
        2019 00:50:52 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        8C.4C.52419.8E4D6FD5; Mon, 16 Dec 2019 09:50:48 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191216005048epcas1p369df270aca6b7483d38f9ee4a00f6f1d~gs7J1A1bn0826508265epcas1p3j;
        Mon, 16 Dec 2019 00:50:48 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191216005048epsmtrp1cbefa5fa4dfed5ca69240a04dc95423e~gs7Jz9EsJ2363023630epsmtrp1g;
        Mon, 16 Dec 2019 00:50:48 +0000 (GMT)
X-AuditID: b6c32a37-59fff7000001ccc3-1d-5df6d4e8308c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        30.29.10238.8E4D6FD5; Mon, 16 Dec 2019 09:50:48 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191216005048epsmtip1a1fd24321ead4eaf1c257793b107d4ad~gs7JhoQ-i1012310123epsmtip1s;
        Mon, 16 Dec 2019 00:50:48 +0000 (GMT)
Subject: Re: [RFC PATCH v2 05/11] interconnect: Export
 of_icc_get_from_provider()
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
Message-ID: <42a50e8a-c201-ac88-5353-873c981359f0@samsung.com>
Date:   Mon, 16 Dec 2019 09:57:24 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20190919142236.4071-6-a.swigon@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOJsWRmVeSWpSXmKPExsWy7bCmvu6LK99iDWZdtbK4P6+V0WLjjPWs
        FvOPnGO1uPL1PZvF9L2b2Cwm3Z/AYnH+/AZ2ixV3P7JabHp8jdXi8q45bBafe48wWsw4v4/J
        Yu2Ru+wWtxtXsFnMmPySzYHfY9OqTjaPO9f2sHnc7z7O5LF5Sb3Hxnc7mDz6tqxi9Pi8SS6A
        PSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfobiWF
        ssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgWWBXnFibnFpXrpecn6ulaGBgZEpUGFC
        dsacTU9YCq4JVRycMoetgfEMfxcjJ4eEgInEnwPLGbsYuTiEBHYwSjx/dp8NwvnEKPH67H5W
        COcbo8SE7UdZYVquTrrLBJHYyyhxak4PM4TznlGiqX8GWJWwQLBE1/Ir7CAJEYH/jBKnl60E
        m8UscIxRYu+dnywgVWwCWhL7X9xgA7H5BRQlrv54zAhi8wrYSbxbPB9oLAcHi4CqRMOFAJCw
        qECYxMltLVAlghInZz4BG8MpYCnx/egOJhCbWUBc4taT+VC2vETz1tnMEGfvY5d48qkawnaR
        6HyyignCFpZ4dXwLO4QtJfGyvw3KrpZYefIIODAkBDoYJbbsvwD1v7HE/qWTmUBuYxbQlFi/
        Sx8irCix8/dcRoi9fBLvvvawgpRICPBKdLQJQZQoS1x+cBdqraTE4vZOtgmMSrOQfDMLyQez
        kHwwC2HZAkaWVYxiqQXFuempxYYFxsjRvYkRnKi1zHcwbjjnc4hRgINRiYfXIftbrBBrYllx
        Ze4hRgkOZiUR3lTtz7FCvCmJlVWpRfnxRaU5qcWHGE2BYT2RWUo0OR+YRfJK4g1NjYyNjS1M
        DM1MDQ2VxHk5flyMFRJITyxJzU5NLUgtgulj4uCUamDUnmDk8/fA4psnV+xukhINEpJOe6q3
        msf+bMjrzqDb0tzfXszlSKiOjljycdPWhhmWqY/iYgNWtr62dZ5wMuCB+Uz71YpCzz9c3H7A
        s7mzad3B6dsUH3zlOLP7fvXdh3seMOQV5NoY7vl67RxX6u+koqUqt4oDj1/MT/7r+dxINuJT
        Zr7ZjiW/lFiKMxINtZiLihMBeBP9G+oDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsWy7bCSnO6LK99iDfquyVncn9fKaLFxxnpW
        i/lHzrFaXPn6ns1i+t5NbBaT7k9gsTh/fgO7xYq7H1ktNj2+xmpxedccNovPvUcYLWac38dk
        sfbIXXaL240r2CxmTH7J5sDvsWlVJ5vHnWt72Dzudx9n8ti8pN5j47sdTB59W1YxenzeJBfA
        HsVlk5Kak1mWWqRvl8CVMWfTE5aCa0IVB6fMYWtgPMPfxcjJISFgInF10l0mEFtIYDejxPv5
        LBBxSYlpF48ydzFyANnCEocPF3cxcgGVvGWUePZwPVi9sECwRNfyK+wgCRGB/4wSD9uOMYI4
        zALHGCU+rljPCtECNPX79S9gLWwCWhL7X9xgA7H5BRQlrv54zAhi8wrYSbxbPB9sHYuAqkTD
        hQCQsKhAmMTOJY+ZIEoEJU7OfAJ2HaeApcT3ozvA4swC6hJ/5l1ihrDFJW49mQ8Vl5do3jqb
        eQKj8Cwk7bOQtMxC0jILScsCRpZVjJKpBcW56bnFhgWGeanlesWJucWleel6yfm5mxjBEaul
        uYPx8pL4Q4wCHIxKPLwO2d9ihVgTy4orcw8xSnAwK4nwpmp/jhXiTUmsrEotyo8vKs1JLT7E
        KM3BoiTO+zTvWKSQQHpiSWp2ampBahFMlomDU6qBkf9XMV/Mt4qVRitWcup86bhk+uHVL7V9
        P9e8n+afb2E7vU/v+419WzweGp9/25DiPP+45jsNzw2GK9X/i7Av27Vye2ObR9mvg1x5Z9fd
        sr1ufaJp/uNdtxf8fS3IVC4XkvrwU0dZ+O8JpROv3lm6LGGdlde6iKnTZ56IKJzR4ZMpd+su
        g62gx2UlluKMREMt5qLiRACrEIzl1AIAAA==
X-CMS-MailID: 20191216005048epcas1p369df270aca6b7483d38f9ee4a00f6f1d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190919142325eucas1p28102446c22b1e1c61aae0bad46d079b0
References: <20190919142236.4071-1-a.swigon@samsung.com>
        <CGME20190919142325eucas1p28102446c22b1e1c61aae0bad46d079b0@eucas1p2.samsung.com>
        <20190919142236.4071-6-a.swigon@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/19/19 11:22 PM, Artur Świgoń wrote:
> From: Artur Świgoń <a.swigon@partner.samsung.com>
> 
> This patch makes the above function public (for use in exynos-bus devfreq
> driver).
> 
> Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/interconnect/core.c           | 3 ++-
>  include/linux/interconnect-provider.h | 6 ++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 7b971228df38..95850700e367 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -279,7 +279,7 @@ EXPORT_SYMBOL_GPL(of_icc_xlate_onecell);
>   * Returns a valid pointer to struct icc_node on success or ERR_PTR()
>   * on failure.
>   */
> -static struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
> +struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
>  {
>  	struct icc_node *node = ERR_PTR(-EPROBE_DEFER);
>  	struct icc_provider *provider;
> @@ -298,6 +298,7 @@ static struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
>  
>  	return node;
>  }
> +EXPORT_SYMBOL_GPL(of_icc_get_from_provider);
>  
>  /**
>   * of_icc_get() - get a path handle from a DT node based on name
> diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
> index b16f9effa555..070e411564e1 100644
> --- a/include/linux/interconnect-provider.h
> +++ b/include/linux/interconnect-provider.h
> @@ -100,6 +100,7 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider);
>  void icc_node_del(struct icc_node *node);
>  int icc_provider_add(struct icc_provider *provider);
>  int icc_provider_del(struct icc_provider *provider);
> +struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec);
>  
>  #else
>  
> @@ -140,6 +141,11 @@ static inline int icc_provider_del(struct icc_provider *provider)
>  	return -ENOTSUPP;
>  }
>  
> +struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
> +{
> +	return ERR_PTR(-ENOTSUPP);
> +}
> +
>  #endif /* CONFIG_INTERCONNECT */
>  
>  #endif /* __LINUX_INTERCONNECT_PROVIDER_H */
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
