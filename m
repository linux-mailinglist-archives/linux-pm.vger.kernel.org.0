Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2CC321307F
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jul 2020 02:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgGCAgp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jul 2020 20:36:45 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:20037 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgGCAgp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jul 2020 20:36:45 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200703003642epoutp013cfa69aa0fc2ab2781210149c0fcfd10~eFv7pJ6g61791317913epoutp01a
        for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2020 00:36:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200703003642epoutp013cfa69aa0fc2ab2781210149c0fcfd10~eFv7pJ6g61791317913epoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593736602;
        bh=UWuWCf1OfZKP+vcvQ2033IsVriWDyx0bdaBJZNtx+cM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=RgtMdJuuf26N7aZInHfURi6ZiZujxNh9M28ZkA68BJjrJUpVTGDhPxWWRdSdkwBXZ
         u4DyTz4EEntF5e061HASdFORTnOSnjUalJBNNE20xC/ng1vwPGYGOAH6KjtaO+dSqZ
         3T4U4gSkzPTjLboDet0ue++fS/VVtNo4Zkespab0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200703003641epcas1p3c22a707cbedd7b2ebfe0fb9b83ec5375~eFv66bJ6h0263502635epcas1p3m;
        Fri,  3 Jul 2020 00:36:41 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.153]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 49ybcj3FG8zMqYkw; Fri,  3 Jul
        2020 00:36:37 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B8.AF.19033.19D7EFE5; Fri,  3 Jul 2020 09:36:33 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200703003633epcas1p2654ef23e56eb19c0203ff1680f1e75c8~eFvzOZX-a2749027490epcas1p2U;
        Fri,  3 Jul 2020 00:36:33 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200703003633epsmtrp29b912f24b4f495ce70d54f6281235dd8~eFvzNdi8h0657606576epsmtrp2e;
        Fri,  3 Jul 2020 00:36:33 +0000 (GMT)
X-AuditID: b6c32a36-159ff70000004a59-fe-5efe7d91899d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7A.1C.08382.19D7EFE5; Fri,  3 Jul 2020 09:36:33 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200703003632epsmtip276e73622b711bde99e3232f7d961dcc8~eFvy5BX1N2844528445epsmtip2O;
        Fri,  3 Jul 2020 00:36:32 +0000 (GMT)
Subject: Re: [PATCH RFC v6 1/6] dt-bindings: exynos-bus: Add documentation
 for interconnect properties
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        georgi.djakov@linaro.org, krzk@kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <8795ad20-1193-8009-bec4-5ae2c72a782a@samsung.com>
Date:   Fri, 3 Jul 2020 09:47:47 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200702163724.2218-2-s.nawrocki@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBJsWRmVeSWpSXmKPExsWy7bCmvu7E2n9xBq+ny1rcn9fKaLFxxnpW
        i/lHzrFaXPn6ns1i+t5NbBaT7k9gsTh/fgO7xabH11gtLu+aw2bxufcIo8WM8/uYLNYeuctu
        cbtxBZtF694j7BaH37SzWsyY/JLNQcBj06pONo871/awedzvPs7ksXlJvUffllWMHp83yQWw
        RWXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gDdraRQ
        lphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpsCzQK07MLS7NS9dLzs+1MjQwMDIFKkzI
        zji6eDVrwQf2iu8bvrI2MO5j62Lk4JAQMJFouhvaxcjFISSwg1Hi+tI+NgjnE6PE/alvWSCc
        b4wSL+fdB8pwgnVsnb4VKrGXUeJs5z12COc9o8SS8ytYQaqEBTIkfm7vAdshIhAjsf5dBEgN
        s8AHJon/rx4ygdSwCWhJ7H9xA2wqv4CixNUfjxlB6nkF7CSab+SDhFkEVCSOPt0ONlJUIEzi
        5LYWRhCbV0BQ4uTMJywgNqeAtUTjhQtgNcwC4hK3nsxngrDlJZq3zmYG2Ssh8IJD4seM58wQ
        H7hInPm+G8oWlnh1fAs7hC0l8fndXqgvqyVWnjzCBtHcwSixZT/EBgkBY4n9SyczgRzKLKAp
        sX6XPkRYUWLn77mMEIv5JN597WGFhC+vREebEESJssTlB3eZIGxJicXtnWwTGJVmIXlnFpIX
        ZiF5YRbCsgWMLKsYxVILinPTU4sNC4yQI3sTIzhJa5ntYJz09oPeIUYmDsZDjBIczEoivAmq
        /+KEeFMSK6tSi/Lji0pzUosPMZoCA3gis5Rocj4wT+SVxBuaGhkbG1uYGJqZGhoqifOqyVyI
        ExJITyxJzU5NLUgtgulj4uCUamAS3vI6gt/2RZfMG2YOhoPXljU597zdLcp9z1Rg2Z5zFw4/
        Sb52cvtiboXlC940sRkG39f2/MCs/lF3VbTJ1i6bribdP3lmVtvlVrqYX1f8bvqdc6aJdUDr
        5sTojxl/zWz9+n9eSjx1me1hZJN59amp836WRuXOWXh81sPV134ab2HzOPTnU1He/pe8u/b4
        n9no+qnHxrDsfEGzeCHvNssgucvP725/tnvHFg1jo6d1X+ed9X+lqZBy5KpL2+Wlzerz9FKu
        PbvSIfukk3EaS9+i+HXR+aVP/YQ073xzWXnuxqT610w9h6OfLX1ln3DgRoPd2bCH4Qm351aI
        OeaGbJlnZCX66sr9+2vED9fkPRbVU2Ipzkg01GIuKk4EANxDsXhbBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsWy7bCSvO7E2n9xBsu/MVvcn9fKaLFxxnpW
        i/lHzrFaXPn6ns1i+t5NbBaT7k9gsTh/fgO7xabH11gtLu+aw2bxufcIo8WM8/uYLNYeuctu
        cbtxBZtF694j7BaH37SzWsyY/JLNQcBj06pONo871/awedzvPs7ksXlJvUffllWMHp83yQWw
        RXHZpKTmZJalFunbJXBlHF28mrXgA3vF9w1fWRsY97F1MXJySAiYSGydvpUFxBYS2M0osWUu
        I0RcUmLaxaPMXYwcQLawxOHDxV2MXEAlbxklnj5axgxSIyyQIbFs3wuwehGBGIlTk2exgBQx
        C3xgkjg0t5MRomM/o8T0BZvANrAJaEnsf3EDbDO/gKLE1R+PGUE28ArYSTTfyAcJswioSBx9
        up0VxBYVCJPYueQxE4jNKyAocXLmE7AxnALWEo0XLoDVMAuoS/yZd4kZwhaXuPVkPhOELS/R
        vHU28wRG4VlI2mchaZmFpGUWkpYFjCyrGCVTC4pz03OLDQsM81LL9YoTc4tL89L1kvNzNzGC
        41VLcwfj9lUf9A4xMnEwHmKU4GBWEuFNUP0XJ8SbklhZlVqUH19UmpNafIhRmoNFSZz3RuHC
        OCGB9MSS1OzU1ILUIpgsEwenVANTyNp5XBz69+N2n7xp49Z8TriI2dXWZKqH2qsHRudfBm8T
        na3h7v3T9lnfo3VXz3E/TnupqRv9dvmt6Xdrc6aYfjh+d9ZxMd+772Ysmuts8L5gz8QMl6O5
        sfPNz7/uSxa0zlx672Ci1pvYNT2nH2mYbXi+UUTw3GzhiZaP0mTWWYimxMt0/q0rNyl9x1Fq
        5B2mb3t0pVOedMKDqqhLhUcN/8pMnX9w451/LqoeKrUsVw7ySlTlCF6+KuaYFeeZcPp7y3qD
        Rrn1SyV+aLx+tuW09ulLHR1uhRrWBgW3czYxXXm/eNb5mKqim7v1rQOest+uz3D3fTTrxU8+
        D5NFRyKSi2e6bF62e8aTiX+2PFlvrMRSnJFoqMVcVJwIAKDh9EFGAwAA
X-CMS-MailID: 20200703003633epcas1p2654ef23e56eb19c0203ff1680f1e75c8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200702163748eucas1p2cf7eab70bc072dea9a95183018b38ad3
References: <20200702163724.2218-1-s.nawrocki@samsung.com>
        <CGME20200702163748eucas1p2cf7eab70bc072dea9a95183018b38ad3@eucas1p2.samsung.com>
        <20200702163724.2218-2-s.nawrocki@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sylwester,


On 7/3/20 1:37 AM, Sylwester Nawrocki wrote:
> Add documentation for new optional properties in the exynos bus nodes:
> samsung,interconnect-parent, #interconnect-cells, bus-width.
> These properties allow to specify the SoC interconnect structure which
> then allows the interconnect consumer devices to request specific
> bandwidth requirements.
> 
> Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes for v6:
>  - added dts example of bus hierarchy definition and the interconnect
>    consumer,
>  - added new bus-width property.
> 
> Changes for v5:
>  - exynos,interconnect-parent-node renamed to samsung,interconnect-parent
> ---
>  .../devicetree/bindings/devfreq/exynos-bus.txt     | 68 +++++++++++++++++++++-
>  1 file changed, 66 insertions(+), 2 deletions(-)

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>


(snip)

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
