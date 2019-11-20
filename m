Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 273F91046DC
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2019 00:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbfKTXOY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Nov 2019 18:14:24 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:26903 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfKTXOX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Nov 2019 18:14:23 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191120231420epoutp049e62d21cabecda0ba290ddb3b2403866~ZAeyjt1zw0652406524epoutp04O
        for <linux-pm@vger.kernel.org>; Wed, 20 Nov 2019 23:14:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191120231420epoutp049e62d21cabecda0ba290ddb3b2403866~ZAeyjt1zw0652406524epoutp04O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574291660;
        bh=YBQcDbX1ksCCjt7aDcfU7ea4Z+qkjtcaHeZWNxa1b44=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=K9VFPDOUN0S2/BNd8yeLD9sUsiELljaQpZ+HVahZxdiwHW1mP+IxiFA5C/aPlu5Us
         O+QXdvcfk4aVtzJsPaYk3aTpvt5SuRgi69ZNRL/EmFn9GI5CI+V6XfSuS9tJxdkA77
         eXk3qOKMywBZtnwxGtBh0Ru9zl3lWvGiIwPaaSMs=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191120231420epcas1p31017155fd41aed4457bba9daa5dbf7f8~ZAeyEm1Ap1498414984epcas1p3B;
        Wed, 20 Nov 2019 23:14:20 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.158]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47JJRY6rhjzMqYm1; Wed, 20 Nov
        2019 23:14:17 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        80.47.04072.5C8C5DD5; Thu, 21 Nov 2019 08:14:13 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191120231413epcas1p2cc8f38e5f5e67679c7169e1bdab59738~ZAeroymiL0427904279epcas1p2g;
        Wed, 20 Nov 2019 23:14:13 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191120231413epsmtrp1ca7ed40e69bd491a025cd2d9345d689f~ZAeroKN3v2064720647epsmtrp1L;
        Wed, 20 Nov 2019 23:14:13 +0000 (GMT)
X-AuditID: b6c32a35-9a5ff70000000fe8-b5-5dd5c8c5899e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4C.4B.03814.5C8C5DD5; Thu, 21 Nov 2019 08:14:13 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191120231413epsmtip149eb4da734e12f576b60521050a7029e~ZAereSr_d0820808208epsmtip1P;
        Wed, 20 Nov 2019 23:14:13 +0000 (GMT)
Subject: Re: [PATCH] devfreq: Fix Kconfig indentation
To:     Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-pm@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <edbea51d-2d69-1e1e-9eda-d17a2a20d801@samsung.com>
Date:   Thu, 21 Nov 2019 08:20:01 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191120134216.15713-1-krzk@kernel.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjk+LIzCtJLcpLzFFi42LZdljTQPfoiauxBof2m1qcP7+B3eJs0xt2
        i8u75rBZfO49wmhxu3EFmwOrx6ZVnWwefVtWMXp83iQXwByVbZORmpiSWqSQmpecn5KZl26r
        5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDtFJJoSwxpxQoFJBYXKykb2dTlF9akqqQ
        kV9cYquUWpCSU2BZoFecmFtcmpeul5yfa2VoYGBkClSYkJ0xv2Mea8EGzopDO1pZGxjXsHcx
        cnBICJhI/H0k2sXIySEksINR4uN92y5GLiD7E6PE+YbzrBDON0aJdTNus4BUgTR8fjKXESKx
        l1Giv2syM4TznlHi07KL7CBVwgKmEp3vNrOB2CIC7hIL/q8Bs5kFiiSa+36CTWIT0JLY/+IG
        WJxfQFHi6o/HjCAn8QrYSTQtUwMJswioSjx+NhEsLCoQIXH6ayJImFdAUOLkzCdgUziBNn3b
        +g9qurjErSfzmSBseYntb+eAnSYhcJlN4uLzmVAPuEh8uL2VFcIWlnh1fAs7hC0l8bK/Dcqu
        llh58ggbRHMHo8SW/RegGowl9i+dzARyELOApsT6XfoQYUWJnb9BgQKymE/i3dceVkjo8kp0
        tAlBlChLXH5wlwnClpRY3N7JNoFRaRaSd2YheWEWkhdmISxbwMiyilEstaA4Nz212LDAEDmq
        NzGC06KW6Q7GKed8DjEKcDAq8fBmaFyNFWJNLCuuzD3EKMHBrCTCu+f6lVgh3pTEyqrUovz4
        otKc1OJDjKbAwJ7ILCWanA9M2Xkl8YamRsbGxhYmhmamhoZK4rwcPy7GCgmkJ5akZqemFqQW
        wfQxcXBKNTB6VIssEq9zKtpjlycwM/VslAuHUz3fmvC2lBneF3oY9tywfn2u92jx+qNx/AbT
        Wv8a1+6580apof1Jasyca3vst34wnKrq0nFC4/Vy/cJ72+PvnYzW2qpmeLF9jklbpPSEz78K
        5To2Fhay96592dnTNPeiV9TvxQ9+vLgmP7l32YYvNw5zlK1WYinOSDTUYi4qTgQAEJwCd6ED
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsWy7bCSnO7RE1djDd5cYLU4f34Du8XZpjfs
        Fpd3zWGz+Nx7hNHiduMKNgdWj02rOtk8+rasYvT4vEkugDmKyyYlNSezLLVI3y6BK2N+xzzW
        gg2cFYd2tLI2MK5h72Lk5JAQMJH4/GQuYxcjF4eQwG5GiWWXOxghEpIS0y4eZe5i5ACyhSUO
        Hy6GqHnLKLF19UJWkBphAVOJzneb2UBsEQF3iQX/14DZzAJFEle332eCaOhglOifM4sFJMEm
        oCWx/8UNsCJ+AUWJqz8eM4Is4BWwk2hapgYSZhFQlXj8bCLYDaICERLPt98As3kFBCVOznwC
        NoYTaO+3rf+gdqlL/Jl3iRnCFpe49WQ+E4QtL7H97RzmCYzCs5C0z0LSMgtJyywkLQsYWVYx
        SqYWFOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgRHiZbWDsYTJ+IPMQpwMCrx8GZoXI0VYk0s
        K67MPcQowcGsJMK75/qVWCHelMTKqtSi/Pii0pzU4kOM0hwsSuK88vnHIoUE0hNLUrNTUwtS
        i2CyTBycUg2MXd1P2RZN5Mj2+nBmb8m2/WnrD1psWPC1RWvdtlMLr315lf6uOuJ1y/pdoh4v
        Z++Jib1460/nb+nQuBc6/lMubRQpe9j4J19+s96pX4/Uw6fMMw51N96wl6Uunb8mc6n94uBF
        xk8uHi2TTP753iKKXcf1kJNmXU8Rs/wmx4g7LZqsCtlp1u3PlViKMxINtZiLihMBj1nLNI4C
        AAA=
X-CMS-MailID: 20191120231413epcas1p2cc8f38e5f5e67679c7169e1bdab59738
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191120134228epcas5p2b934651ced36ef9ed34a2a40f85a7704
References: <CGME20191120134228epcas5p2b934651ced36ef9ed34a2a40f85a7704@epcas5p2.samsung.com>
        <20191120134216.15713-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/20/19 10:42 PM, Krzysztof Kozlowski wrote:
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 	$ sed -e 's/^        /\t/' -i */Kconfig
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/devfreq/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index 066e6c4efaa2..59027d7ddf2a 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -119,9 +119,9 @@ config ARM_RK3399_DMC_DEVFREQ
>  	select DEVFREQ_GOV_SIMPLE_ONDEMAND
>  	select PM_DEVFREQ_EVENT
>  	help
> -          This adds the DEVFREQ driver for the RK3399 DMC(Dynamic Memory Controller).
> -          It sets the frequency for the memory controller and reads the usage counts
> -          from hardware.
> +	  This adds the DEVFREQ driver for the RK3399 DMC(Dynamic Memory Controller).
> +	  It sets the frequency for the memory controller and reads the usage counts
> +	  from hardware.
>  
>  source "drivers/devfreq/event/Kconfig"
>  
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
