Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34BF1389B6C
	for <lists+linux-pm@lfdr.de>; Thu, 20 May 2021 04:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhETCec (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 May 2021 22:34:32 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:22674 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbhETCe1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 May 2021 22:34:27 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210520023121epoutp013e454159a827a1a4084081ad708db975~ApYq9dmVu3058330583epoutp01_
        for <linux-pm@vger.kernel.org>; Thu, 20 May 2021 02:31:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210520023121epoutp013e454159a827a1a4084081ad708db975~ApYq9dmVu3058330583epoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1621477881;
        bh=MWWWd3rHx9oezvHvsD2UL1Okt3P32180D99blxhLM74=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=lQJeoGZdyH/ObTzsEk8x1udZwGCuQfpH4+DkEevgYybzMGZhvMYmskyAVBwQ37uxl
         4/PNaCEJw0uHtGtifXjUSwIgCiNFjecppS9vXsJ86Ep3dEF/XReYhNG8n+oSCHEJ0U
         ikYa4IhZFblcPIWiQ/wuBKMHWeHy+ic1TX3r+CCQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210520023116epcas1p3588f100133f3aed9bdebd6462dc87b60~ApYm1uryI2253322533epcas1p3b;
        Thu, 20 May 2021 02:31:16 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.156]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Fltyn4S25z4x9QH; Thu, 20 May
        2021 02:31:13 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        6D.D6.09824.0F9C5A06; Thu, 20 May 2021 11:31:12 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210520023100epcas1p4528846a7b21d98f1b107e103662d5eb7~ApYXj1VgD2925329253epcas1p4H;
        Thu, 20 May 2021 02:31:00 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210520023100epsmtrp1ccff1ba6b7f934758eac6d190eff46cc~ApYXi9ktu0437504375epsmtrp1O;
        Thu, 20 May 2021 02:31:00 +0000 (GMT)
X-AuditID: b6c32a37-061ff70000002660-98-60a5c9f0b7b4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6A.A5.08637.4E9C5A06; Thu, 20 May 2021 11:31:00 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210520023100epsmtip2e8eeb589aba09ce267825e7e1c5d8d26~ApYXU2IJI2547525475epsmtip2g;
        Thu, 20 May 2021 02:31:00 +0000 (GMT)
Subject: Re: [PATCH v1 4/7] dt-bindings: devfreq: tegra30-actmon: Add
 cooling-cells
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <8dbb9a97-8358-0a2c-bbfc-738f7efa931f@samsung.com>
Date:   Thu, 20 May 2021 11:49:29 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20210510211008.30300-5-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKJsWRmVeSWpSXmKPExsWy7bCmru6Hk0sTDO4sEbCYf+Qcq8Xqj48Z
        LVpmLWKxONv0ht3i8q45bBafe48wWnR+mcVmca9lL6vF7cYVbBZnn3lbtO49wm7xc9c8Fgce
        j52z7rJ7bFrVyebR2/yOzaOnbROTR9+WVYwenzfJBbBFZdtkpCampBYppOYl56dk5qXbKnkH
        xzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAN2opFCWmFMKFApILC5W0rezKcovLUlVyMgv
        LrFVSi1IySmwLNArTswtLs1L10vOz7UyNDAwMgUqTMjOmN7UxlLQwFtx4MUHxgbGjVxdjJwc
        EgImEp2fD7J0MXJxCAnsYJR4tf4MO4TziVHiyvRGqMw3RolV09YxwrTcmbyJFSKxl1Hi3+xf
        UFXvGSW+3bzNDlIlLBAq0bNxElhCROAQk8T8CU1A7RwczAKlErs32IDUsAloSex/cYMNxOYX
        UJS4+uMxWAmvgJ1E79V4kDCLgKrE4kOTmUBsUYEwiZPbWsCO4BUQlDg58wkLiM0pYCYxb8t7
        sLXMAuISt57MZ4Kw5SW2v53DDHKChMAJDok7W2YwQ3zgIvH70FJ2CFtY4tXxLVC2lMTL/jYo
        u1pi5ckjbBDNHYwSW/ZfYIVIGEvsXwpyEcgvmhLrd+lDhBUldv6eywixmE/i3dceVpASCQFe
        iY42IYgSZYnLD+4yQdiSEovbO9kmMCrNQvLOLCQvzELywiyEZQsYWVYxiqUWFOempxYbFhgj
        x/YmRnD61TLfwTjt7Qe9Q4xMHIyHGCU4mJVEeLd7L04Q4k1JrKxKLcqPLyrNSS0+xGgKDOCJ
        zFKiyfnADJBXEm9oamRsbGxhYmhmamioJM6b7lydICSQnliSmp2aWpBaBNPHxMEp1cDEd1m2
        UEz54y1294/X69K4KiX513ybsXbTpapX1i2TI93mrrnmpl2qxfRYnu9OO5cuz9myA4eX9Uum
        SIjfMo5s4Dj/QsNHqzmM98ztXZujo7/bX66JWaIc4PbwkYe768cTi7cx5YjoWS7jPeD1zGPf
        t/rjom4pb17N6db5LM2vsltIYH47a+LnU3oRmY+M2n/kbPff+cNL+Kx005xjr+qTvrSXN1x5
        GXa6/ZSE2qF9S1e/vPa1dd36mtV6/8Kcl93VdRRtmZxqcUw50SXL+9skscV7Lz98sdbCdM6O
        lnvTGp98CPDusPZOUpPX2OGfKXH0qQHjf+3vz0uCGK/PFY2bEpRiYnfo+fe7hw6e3bBCiaU4
        I9FQi7moOBEAUKLhOUgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsWy7bCSvO6Tk0sTDC7e5rWYf+Qcq8Xqj48Z
        LVpmLWKxONv0ht3i8q45bBafe48wWnR+mcVmca9lL6vF7cYVbBZnn3lbtO49wm7xc9c8Fgce
        j52z7rJ7bFrVyebR2/yOzaOnbROTR9+WVYwenzfJBbBFcdmkpOZklqUW6dslcGVMb2pjKWjg
        rTjw4gNjA+NGri5GTg4JAROJO5M3sXYxcnEICexmlLjf/44ZIiEpMe3iUSCbA8gWljh8uBii
        5i2jxMvHfxlBaoQFQiV6Nk5iAbFFBI4wSXzr8QOxmQVKJZ5tbGeEaNjKKPH59HomkASbgJbE
        /hc32EBsfgFFias/HjOCLOAVsJPovRoPEmYRUJVYfGgyWLmoQJjEziWPwWxeAUGJkzOfgO3i
        FDCTmLflPTvELnWJP/MuMUPY4hK3nsxngrDlJba/ncM8gVF4FpL2WUhaZiFpmYWkZQEjyypG
        ydSC4tz03GLDAsO81HK94sTc4tK8dL3k/NxNjOA41NLcwbh91Qe9Q4xMHIyHGCU4mJVEeLd7
        L04Q4k1JrKxKLcqPLyrNSS0+xCjNwaIkznuh62S8kEB6YklqdmpqQWoRTJaJg1OqgalcyVhW
        eHHUySyP1ErLC2/Cji6wXxu1TttGSTf1e8wG1Za8kxIdWR+2HNrj/v/F1Q95rrulxJz+Juz9
        1rujcEJR5aEt4ntirBet2OYobi3+KfOaBlPIDr6F0b4TOcQaKl+8j1FI+BjTEJI2W3z9a8W9
        5iU+6eeNVA0DA2+Gb7hwQ0Co5b/bv6eOav8KY6t8JyfWF+VN8csNFc/bsPfmi/vBJbI3Dn9e
        yuZ5aGb82mlroradXbbVzKurJuBhT/+P8rTPfreFHWsuHhU+NV/wMsc19d2/OiMdU0Rn7517
        TNp6wfRZf3Nb+Wbccvz3/W337x51uQa+iazLN5Vmpi5sn2ppwGu+ylPkzE3/0ye2aSmxFGck
        GmoxFxUnAgAJ9a2TMgMAAA==
X-CMS-MailID: 20210520023100epcas1p4528846a7b21d98f1b107e103662d5eb7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210510211159epcas1p119ee938888c0cb5fe966bfe5f4df823a
References: <20210510211008.30300-1-digetx@gmail.com>
        <CGME20210510211159epcas1p119ee938888c0cb5fe966bfe5f4df823a@epcas1p1.samsung.com>
        <20210510211008.30300-5-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 5/11/21 6:10 AM, Dmitry Osipenko wrote:
> The ACTMON watches activity of memory clients. Decisions about a minimum
> required frequency are made based on the info from ACTMON. We can use
> ACTMON as a thermal cooling device by limiting the required frequency.
> Document new cooling-cells property of NVIDIA Tegra ACTMON hardware unit.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../devicetree/bindings/devfreq/nvidia,tegra30-actmon.yaml   | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/nvidia,tegra30-actmon.yaml b/Documentation/devicetree/bindings/devfreq/nvidia,tegra30-actmon.yaml
> index 2a940d5d7ab4..0aa9459b7751 100644
> --- a/Documentation/devicetree/bindings/devfreq/nvidia,tegra30-actmon.yaml
> +++ b/Documentation/devicetree/bindings/devfreq/nvidia,tegra30-actmon.yaml
> @@ -63,6 +63,9 @@ properties:
>        Should contain freqs and voltages and opp-supported-hw property, which
>        is a bitfield indicating SoC speedo ID mask.
>  
> +  "#cooling-cells":
> +    const: 2
> +
>  required:
>    - compatible
>    - reg
> @@ -74,6 +77,7 @@ required:
>    - interconnects
>    - interconnect-names
>    - operating-points-v2
> +  - "#cooling-cells"
>  
>  additionalProperties: false
>  
> @@ -118,4 +122,5 @@ examples:
>          operating-points-v2 = <&dvfs_opp_table>;
>          interconnects = <&mc TEGRA30_MC_MPCORER &emc>;
>          interconnect-names = "cpu-read";
> +        #cooling-cells = <2>;
>      };
> 

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
