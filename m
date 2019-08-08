Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02825857BB
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2019 03:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730382AbfHHBno (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Aug 2019 21:43:44 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:33848 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389583AbfHHBnn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Aug 2019 21:43:43 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190808014338epoutp014620514a448e3f919ade17b11df9713c~4zyKoSFPc0158001580epoutp01f
        for <linux-pm@vger.kernel.org>; Thu,  8 Aug 2019 01:43:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190808014338epoutp014620514a448e3f919ade17b11df9713c~4zyKoSFPc0158001580epoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565228618;
        bh=g/w4k8k8kjGX3U5NCIJA3IW3tGMmcpA8VH1KgK5s/dM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=HRtD5KtmR8+DT8Gpg6cJtsL84OqbKqKt2+JOOqZP5U2RSO/BBeR4l4wDWNDkMzwLz
         sa9iUGmTye/l7HuKTLDUvhruRWavmiCK4YKRG2wEgoHd8ThDWO0JzXhClPTDvI1x7a
         +F5UqRBDId/Ay93+XyHho2jRzPPx5kY7vgLePgr8=
Received: from epsnrtp6.localdomain (unknown [182.195.42.167]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190808014337epcas1p3fef83b5cd5c8d07f9b88e1a7776f89a2~4zyKDcmkm1702217022epcas1p39;
        Thu,  8 Aug 2019 01:43:37 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.156]) by
        epsnrtp6.localdomain (Postfix) with ESMTP id 463rkH3g2KzMqYkZ; Thu,  8 Aug
        2019 01:43:35 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        99.55.04160.74E7B4D5; Thu,  8 Aug 2019 10:43:35 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190808014335epcas1p4808da0fca0ee5e83f3e93fdb5fae0a80~4zyHuKMuV0142801428epcas1p4K;
        Thu,  8 Aug 2019 01:43:35 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190808014335epsmtrp23ceb36b32893e61da4790576e1185a9e~4zyHsPdDT0126601266epsmtrp2T;
        Thu,  8 Aug 2019 01:43:35 +0000 (GMT)
X-AuditID: b6c32a38-b4bff70000001040-67-5d4b7e475deb
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        80.B1.03638.64E7B4D5; Thu,  8 Aug 2019 10:43:35 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190808014334epsmtip179ac81fd45d6031fde926485f4927413~4zyHc4yRQ1624616246epsmtip1X;
        Thu,  8 Aug 2019 01:43:34 +0000 (GMT)
Subject: Re: [PATCH v5 0/4] add coupled regulators for Exynos5422/5800
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
Message-ID: <6888b704-1971-4832-d7b9-092368c797d0@samsung.com>
Date:   Thu, 8 Aug 2019 10:47:14 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190807133838.14678-1-k.konieczny@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPJsWRmVeSWpSXmKPExsWy7bCmrq57nXeswetTshYbZ6xntZh/5Byr
        Rd++/4wW/Y9fM1ucP7+B3eJs0xt2i02Pr7FaXN41h83ic+8RRosZ5/cxWaw9cpfdYun1i0wW
        txtXsFm8+XGWyaJ17xF2i3/XNrJYbH5wjM1B0GPNvDWMHptWdbJ5bF5S73Hw3R4mj74tqxg9
        jt/YzuTxeZNcAHtUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKL
        T4CuW2YO0AdKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnALLAr3ixNzi0rx0veT8
        XCtDAwMjU6DChOyM5pbLzAW/JCvmLF/B3sD4V6SLkYNDQsBEYuZxmS5GLg4hgR2MEr8PXWDt
        YuQEcj4xSixpdINIfGOUmL/8HjNIAqRh1uk2ZojEXkaJT78+MUE47xklOuYcZQSpEhZwk7jS
        MBGsQ0RAWWLyvelgHcwCl1kkpj2aBLaDTUBLYv+LG2wgNr+AosTVH4/BmnkF7CQen21gAbmP
        RUBFonlrAEhYVCBC4tODw6wQJYISJ2c+YQGxOQVcJb7unQDWyiwgLnHryXwmCFseqHU22F4J
        gWPsEg+n7mKFeMFF4sqCO+wQtrDEq+NboGwpic/v9rJB2NUSK08eYYNo7mCU2LL/AlSzscT+
        pZOZQI5jFtCUWL9LHyKsKLHz91yoI/gk3n3tYYWEL69ER5sQRImyxOUHd5kgbEmJxe2dbBMY
        lWYheWcWkhdmIXlhFsKyBYwsqxjFUguKc9NTiw0LTJAjexMjOHFrWexg3HPO5xCjAAejEg8v
        wwWvWCHWxLLiytxDjBIczEoivPfKPGOFeFMSK6tSi/Lji0pzUosPMZoCA3sis5Rocj4wq+SV
        xBuaGhkbG1uYGJqZGhoqifMu/GERKySQnliSmp2aWpBaBNPHxMEp1cAYGL2phpnjS/a2Kcs+
        7jq2ePMM/+1LWGTu1u4J7T/5r5v9lb8g74HXx19ejimVn7Htkc+82+3vRXy/MD24/K+eP/Rv
        x8MYdXer5eWREhvcfwsu7POZIDVR9I+JsdDlhY7nt1px7txfvsVt0XR+hjXCt7YXrPJ3zKs2
        TVUWrVi0/MK1vjKzE7rsSizFGYmGWsxFxYkAzT7GePIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsWy7bCSnK57nXeswcU9jBYbZ6xntZh/5Byr
        Rd++/4wW/Y9fM1ucP7+B3eJs0xt2i02Pr7FaXN41h83ic+8RRosZ5/cxWaw9cpfdYun1i0wW
        txtXsFm8+XGWyaJ17xF2i3/XNrJYbH5wjM1B0GPNvDWMHptWdbJ5bF5S73Hw3R4mj74tqxg9
        jt/YzuTxeZNcAHsUl01Kak5mWWqRvl0CV0Zzy2Xmgl+SFXOWr2BvYPwr0sXIySEhYCIx63Qb
        cxcjF4eQwG5Gif1bG9ghEpIS0y4eBUpwANnCEocPF0PUvGWUaNnaxAxSIyzgJnGlYSKYLSKg
        LDH53nSwQcwCV1kkzm+cwwbRMYNRouPlPVaQKjYBLYn9L26wgdj8AooSV388ZgSxeQXsJB6f
        bWAB2cYioCLRvDUAJCwqECFxeMcsqBJBiZMzn7CA2JwCrhJf904AizMLqEv8mXeJGcIWl7j1
        ZD4ThC0PNGY28wRG4VlI2mchaZmFpGUWkpYFjCyrGCVTC4pz03OLDQuM8lLL9YoTc4tL89L1
        kvNzNzGCo1hLawfjiRPxhxgFOBiVeHgZLnjFCrEmlhVX5h5ilOBgVhLhvVfmGSvEm5JYWZVa
        lB9fVJqTWnyIUZqDRUmcVz7/WKSQQHpiSWp2ampBahFMlomDU6qBccmfjf7TlTpf91jcuHXh
        EotQeEMRwz+NM34cywTuT+Ndybip/T3L+9Q6CeeESQUlP6Zv+BBwWvHYrV91N1IWHk5/zD9J
        49/Zf6tVGj49cYuO+3/7w10Pfra1eQpxDyt8vTSdj4ZZdJm1fLkRJ8Gpm3VqX3n0hX0nv6zq
        +sI3bZuPvPO6PTH5fUosxRmJhlrMRcWJANBxI2/eAgAA
X-CMS-MailID: 20190808014335epcas1p4808da0fca0ee5e83f3e93fdb5fae0a80
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190807133855eucas1p1cab425b791262e8dee1b17cbe8b1b3da
References: <CGME20190807133855eucas1p1cab425b791262e8dee1b17cbe8b1b3da@eucas1p1.samsung.com>
        <20190807133838.14678-1-k.konieczny@partner.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Kamil,

When I applied them to testing branch, those don't have the author name
only just have the email address as following:
You have to edit the your git author information with your name.

author	k.konieczny@partner.samsung.com <k.konieczny@partner.samsung.com>	2019-08-07 15:38:36 +0200
committer	Chanwoo Choi <cw00.choi@samsung.com>	2019-08-08 10:35:16 +0900
commit	4304f4ecec93cebd255463d56b0a4f112ee9dc50 (patch)
tree	2859e566d6f68219f71a61e7c412717c1adba4f5
parent	57d85421038b458dd87ec268404ff608f90c36ae (diff)
download	linux-4304f4ecec93cebd255463d56b0a4f112ee9dc50.tar.gz

Regards,
Chanwoo Choi

On 19. 8. 7. 오후 10:38, k.konieczny@partner.samsung.com wrote:
> Hi,
> 
> The main purpose of this patch series is to add coupled regulators for
> Exynos5422/5800 to keep constrain on voltage difference between vdd_arm
> and vdd_int to be at most 300mV. In exynos-bus instead of using
> regulator_set_voltage_tol() with default voltage tolerance it should be
> used regulator_set_voltage_triplet() with volatege range, and this is
> already present in opp/core.c code, so it can be reused. While at this,
> move setting regulators into opp/core.
> 
> This patchset was tested on Odroid XU3.
> 
> The DTS coupled regulators patch depends on previous patches.
> 
> Changes:
> v5:
> - squashed last patch "remove exynos_bus_passive_target()" into second
> - added Acked-by to patch "correct clock enable sequence"
> v4:
> - removed "opp: core: add regulators enable and disable" from patchset
>   as it was applied by Viresh Kumar and changed cover letter
> - fix patch "devfreq: exynos-bus: correct clock enable sequence" to
>   correct order of enable/disable
> - removed unrelated changes in "devfreq: exynos-bus: convert to use
>   dev_pm_opp_set_rate()"
> - added new patch "devfreq: exynos-bus: remove exynos_bus_passive_target()"
>   as suggested by Chanwoo Choi
> v3:
> - added new exynos-bus patch to correct clock and regulator enabling
>   and disabling sequence as suggested by Chanwoo Choi
> - corrected error path in enable and improved commit message in opp/core
> - improve comment in devfreq/exynos-bus.c before devfreq_recommended_opp()
> - change cover letter as there is new patch
> - added note before Signed-off-by in 4th patch
> v2:
> - improve regulators enable/disable code in opp/core as suggested by
>   Viresh Kumar
> - add new patch for remove unused dt-bindings as suggested by Krzysztof
>   Kozlowski
> 
> Kamil Konieczny (3):
>   devfreq: exynos-bus: correct clock enable sequence
>   devfreq: exynos-bus: convert to use dev_pm_opp_set_rate()
>   dt-bindings: devfreq: exynos-bus: remove unused property
> 
> Marek Szyprowski (1):
>   ARM: dts: exynos: add initial data for coupled regulators for
>     Exynos5422/5800
> 
>  .../bindings/devfreq/exynos-bus.txt           |   2 -
>  arch/arm/boot/dts/exynos5420.dtsi             |  34 ++--
>  arch/arm/boot/dts/exynos5422-odroid-core.dtsi |   4 +
>  arch/arm/boot/dts/exynos5800-peach-pi.dts     |   4 +
>  arch/arm/boot/dts/exynos5800.dtsi             |  32 ++--
>  drivers/devfreq/exynos-bus.c                  | 153 +++++-------------
>  6 files changed, 78 insertions(+), 151 deletions(-)
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
