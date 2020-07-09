Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2958A2196F1
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jul 2020 05:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgGID4v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jul 2020 23:56:51 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:19308 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgGID4u (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jul 2020 23:56:50 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200709035647epoutp04bd6d574b6a49befcaa60fb458a7ee6a1~f_WWdjqAw2220422204epoutp04T
        for <linux-pm@vger.kernel.org>; Thu,  9 Jul 2020 03:56:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200709035647epoutp04bd6d574b6a49befcaa60fb458a7ee6a1~f_WWdjqAw2220422204epoutp04T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594267007;
        bh=p/SFYzbsPHltH/8FwWWSzx9XA/itHl9p3f2bkVFrBuw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=qZMRcaF5ClIEb8THOQLa9Odiau3YHDAWg33tVYcwURUJO7ceExXsBVFPKDzdv0pI+
         KyG7JVlJE7DryzQt5r3bsSesT1Zoo1pvfM7Jesr+1jmmlYultyp8bV7goI6AW9fkxt
         ZNWPoGuO3GPEMrtahIgkTUZiIaDAzzYV6jPQb3HQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200709035647epcas1p226f752719a90eaf749561c4c9cd79579~f_WWC7wnd1895318953epcas1p2P;
        Thu,  9 Jul 2020 03:56:47 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.152]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4B2Mms1LQKzMqYly; Thu,  9 Jul
        2020 03:56:45 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        95.F1.18978.D75960F5; Thu,  9 Jul 2020 12:56:45 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200709035644epcas1p33f1cb4e5797fcdca3f038c76b08b910f~f_WTYAtvs0146701467epcas1p3z;
        Thu,  9 Jul 2020 03:56:44 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200709035644epsmtrp1ad6314501fb2ea7f17d1de275a534ad8~f_WTXOxFf0699306993epsmtrp1s;
        Thu,  9 Jul 2020 03:56:44 +0000 (GMT)
X-AuditID: b6c32a35-5edff70000004a22-7a-5f06957d6074
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        64.26.08382.C75960F5; Thu,  9 Jul 2020 12:56:44 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200709035644epsmtip295da1225b8f6210d69568765d9b1c019~f_WTC22E-1353413534epsmtip2j;
        Thu,  9 Jul 2020 03:56:44 +0000 (GMT)
Subject: Re: [PATCH 1/2] memory: samsung: exynos5422-dmc: Adjust polling
 interval and uptreshold
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     willy.mh.wolff.ml@gmail.com, k.konieczny@samsung.com,
        b.zolnierkie@samsung.com, krzk@kernel.org, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        s.nawrocki@samsung.com, kgene@kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <fa3f651a-3c2b-188b-e2dc-4fd05ce4a1b7@samsung.com>
Date:   Thu, 9 Jul 2020 13:08:09 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200708153420.29484-2-lukasz.luba@arm.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIJsWRmVeSWpSXmKPExsWy7bCmnm7tVLZ4g4Mr2Sw2zljPajHxxhUW
        iwWfZrBa9D9+zWxx/vwGdouzTW/YLTY9vsZqcXnXHDaLz71HGC1mnN/HZLGwqYXd4nbjCjaL
        w2/aWS2+nXjE6MDnsWbeGkaPnbPusntsWtXJ5rF5Sb1H35ZVjB6fN8kFsEVl22SkJqakFimk
        5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAXaukUJaYUwoUCkgsLlbS
        t7Mpyi8tSVXIyC8usVVKLUjJKbAs0CtOzC0uzUvXS87PtTI0MDAyBSpMyM5offGFuaCPq2JP
        90KmBsZVHF2MnBwSAiYS587PY+5i5OIQEtjBKLHj5lEmCOcTo8Tl2ydYIJxvjBJf/zYClXGA
        tcx/JQ4R38so0bnjFCOE855RYtWl96wgc4UFkiSWvZ4MNkpEYBWjxPf3R1hBHGaBO0CjGucy
        glSxCWhJ7H9xgw3E5hdQlLj64zFYnFfATmL+931gNouAisSM7fvZQWxRgTCJk9taoGoEJU7O
        fMICYnMKWEr8nD4TbA6zgLjErSfzmSBseYntb+eAfSchcIFD4uOdi2wQb7tITHr5lBHCFpZ4
        dXwLO4QtJfGyvw3KrpZYefIIG0RzB6PElv0XWCESxhL7l4L8xgG0QVNi/S59iLCixM7fEI8x
        C/BJvPvawwoJL16JjjYhiBJlicsP7jJB2JISi9s72SYwKs1C8s4sJC/MQvLCLIRlCxhZVjGK
        pRYU56anFhsWGCLH9yZGcFrWMt3BOPHtB71DjEwcjIcYJTiYlUR4DRRZ44V4UxIrq1KL8uOL
        SnNSiw8xmgIDeCKzlGhyPjAz5JXEG5oaGRsbW5gYmpkaGiqJ8+aoAzUJpCeWpGanphakFsH0
        MXFwSjUwiW/lly91uyA5W95he37kxchlWRb+ApdsDstudOC9YWzfLGv8oXHalzzRpkijq45X
        PgrFzrFfzpaf/c52xsGTNXfvLr/cb1i0Kn5fhnn4VUnpnYYN237/1jx6Lc/IUfjuh8Bl0keP
        qQR65azsmZ2z5eyRmg91j5VEzzeLWRTMKVNvDWwNC/C8k9b48Yeg79fa7rONzIGVM5/OvL3A
        8ic7L3ta4Kp/NcH2DFc2rZ127GvqygQt2yvc4spJtT7r79UWZfvs5dh3frqcoejn2vUvVZz2
        hHgduKdfs+7/pObt+xuO35qs+7bNQDLp1I3JDhNDhP7kn96v5isXsEL3i5bKB8XcLgbnlMmx
        x44rnfqgxFKckWioxVxUnAgAK7LIe1QEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsWy7bCSvG7NVLZ4g6P/pC02zljPajHxxhUW
        iwWfZrBa9D9+zWxx/vwGdouzTW/YLTY9vsZqcXnXHDaLz71HGC1mnN/HZLGwqYXd4nbjCjaL
        w2/aWS2+nXjE6MDnsWbeGkaPnbPusntsWtXJ5rF5Sb1H35ZVjB6fN8kFsEVx2aSk5mSWpRbp
        2yVwZbS++MJc0MdVsad7IVMD4yqOLkYODgkBE4n5r8S7GLk4hAR2M0rsm3+JvYuREyguKTHt
        4lFmiBphicOHiyFq3jJKzHm8lRWkRlggSWLZ68lMIAkRgVWMEvfu3wBrZha4wyhxsCUSburq
        a6sZQRJsAloS+1/cYAOx+QUUJa7+eAwW5xWwk5j/fR+YzSKgIjFj+36wQaICYRI7lzxmgqgR
        lDg58wkLiM0pYCnxc/pMNohl6hJ/5l1ihrDFJW49mc8EYctLbH87h3kCo/AsJO2zkLTMQtIy
        C0nLAkaWVYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5uZsYwdGppbmDcfuqD3qHGJk4GA8x
        SnAwK4nwGiiyxgvxpiRWVqUW5ccXleakFh9ilOZgURLnvVG4ME5IID2xJDU7NbUgtQgmy8TB
        KdXA1PbI7fHknPbGp45HlvCvVf6m3y57/q/ZKf8Z+Xsf2iYePV09/dCGaJ+AY2K2zy7uvnTO
        7Cd7RXXsWf2ZdysOVolfmlXI+XjpFM/c3N1PfNmmRG+yCIzLn509tXJ234UuvflX5pcynC+N
        C/83XfDhvAmic7bVLm47VXBSwz/9eaXYi4MSIpee1rJo/faXPteQsPH1/UMGYbvvvC8+vu2+
        xefKovD3B3i6GhoEyrmdC+0LfsXYXPKL1NLTWrR1rc0PfdVzNWLR/4M1bZOOhlwLu+8363iL
        SdqTr5zTPAoqezduP1lZ67qjV3GzWy+jOXvTswlnp8VZWEsl1m2ecqd5gcDyUuXqZ5xGS6f5
        uPalK7EUZyQaajEXFScCAPZMCWM9AwAA
X-CMS-MailID: 20200709035644epcas1p33f1cb4e5797fcdca3f038c76b08b910f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200708153448epcas1p438fae2327ac69fcc1a78d9c73cfda501
References: <20200708153420.29484-1-lukasz.luba@arm.com>
        <CGME20200708153448epcas1p438fae2327ac69fcc1a78d9c73cfda501@epcas1p4.samsung.com>
        <20200708153420.29484-2-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lukasz,

On 7/9/20 12:34 AM, Lukasz Luba wrote:
> In order to react faster and make better decisions under some workloads,
> benchmarking the memory subsystem behavior, adjust the polling interval
> and upthreshold value used by the simple_ondemand governor.
> 
> Reported-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/memory/samsung/exynos5422-dmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
> index 93e9c2429c0d..e03ee35f0ab5 100644
> --- a/drivers/memory/samsung/exynos5422-dmc.c
> +++ b/drivers/memory/samsung/exynos5422-dmc.c
> @@ -1466,10 +1466,10 @@ static int exynos5_dmc_probe(struct platform_device *pdev)
>  		 * Setup default thresholds for the devfreq governor.
>  		 * The values are chosen based on experiments.
>  		 */
> -		dmc->gov_data.upthreshold = 30;
> +		dmc->gov_data.upthreshold = 10;
>  		dmc->gov_data.downdifferential = 5;
>  
> -		exynos5_dmc_df_profile.polling_ms = 500;
> +		exynos5_dmc_df_profile.polling_ms = 100;
>  	}
>  
>  
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
