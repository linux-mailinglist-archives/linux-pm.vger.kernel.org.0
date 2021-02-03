Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE0630D6D1
	for <lists+linux-pm@lfdr.de>; Wed,  3 Feb 2021 10:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbhBCJ4x (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Feb 2021 04:56:53 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:47722 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbhBCJ4q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Feb 2021 04:56:46 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210203095602epoutp0239ad83f3606de000553938af281f13e5~gNErcuLK30620806208epoutp026
        for <linux-pm@vger.kernel.org>; Wed,  3 Feb 2021 09:56:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210203095602epoutp0239ad83f3606de000553938af281f13e5~gNErcuLK30620806208epoutp026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1612346162;
        bh=5txFI09a+8AU1fdzCnILiMFbp7szUbOK8oquhsvC3OM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Ss7fjcnLgTMaiJyV2AiE0USOzmBYHvxW8mDxHJPhmW2MkXgEojoOibAYGZo1JfciE
         D1AIur95gjilSAcNRjuxU7WFjwQ1uPWybJ+/ffwKvlK4DTZZAldNbq8vf5biFIKN4B
         keBqSfBELcDR832q1o6iRA0VSkmxGIvRCmL4tSew=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210203095602epcas1p2102350de75915bea06e28c4728c9f506~gNEq8meEX0793507935epcas1p2k;
        Wed,  3 Feb 2021 09:56:02 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.155]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4DVxrv1srGz4x9Q8; Wed,  3 Feb
        2021 09:55:59 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        F9.EA.09582.F237A106; Wed,  3 Feb 2021 18:55:59 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210203095558epcas1p30425a4bd729286df4c4528d9b64b07f9~gNEn11WBH2914529145epcas1p3b;
        Wed,  3 Feb 2021 09:55:58 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210203095558epsmtrp1ad93217681cad635779eead8ea04d5ca~gNEn1B0MV1652916529epsmtrp1m;
        Wed,  3 Feb 2021 09:55:58 +0000 (GMT)
X-AuditID: b6c32a37-899ff7000000256e-0f-601a732f66aa
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        37.EF.08745.E237A106; Wed,  3 Feb 2021 18:55:58 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210203095558epsmtip1f9b28145a07028212dc84f1fd3748e9a~gNEnh0S2s1394313943epsmtip1U;
        Wed,  3 Feb 2021 09:55:58 +0000 (GMT)
Subject: Re: [PATCH v5 0/3] Add required-opps support to devfreq passive gov
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org
Cc:     Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org,
        "MyungJoo Ham )" <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Saravana Kannan <saravanak@google.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <880f4827-3255-c860-7d9a-36477ff02db0@samsung.com>
Date:   Wed, 3 Feb 2021 19:12:07 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20210203092400.1791884-1-hsinyi@chromium.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIJsWRmVeSWpSXmKPExsWy7bCmvq5+sVSCwf3bXBYTWrczW5xtesNu
        cXnXHDaLz71HGC1uN65gs3jz4yyTxZnTl1gtug79ZbP4d20ji8XmB8fYHLg8ZjdcZPFYsKnU
        Y9OqTjaPLVfbWTz6tqxi9Dh+YzuTx+dNcgHsUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZm
        Boa6hpYW5koKeYm5qbZKLj4Bum6ZOUDnKSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVIL
        UnIKLAv0ihNzi0vz0vWS83OtDA0MjEyBChOyM2a8/sFaME2jorX/InsDY7N8FyMnh4SAicSa
        Ld3sXYxcHEICOxglDp7cxQThfGKU2PX8O5TzmVHi06YjrDAtzR0nWSESuxgl3jx/DuW8Z5R4
        8aOfEaRKWMBH4uq5/2C2iECqxN7fq9lAipgFepkkJixoB0uwCWhJ7H9xgw3E5hdQlLj64zFY
        nFfATuLFhr/sIDaLgIrEj46TLCC2qECYxMltLVA1ghInZz4BinNwcApYSzy+6wcSZhYQl7j1
        ZD4ThC0vsf3tHGaQvRICRzgk+g90Qr3gIrFryXk2CFtY4tXxLewQtpTEy/42KLtaYuXJI2wQ
        zR2MElv2X4BqNpbYv3QyE8hiZgFNifW79CHCihI7f89lhFjMJ/Huaw8rSImEAK9ER5sQRImy
        xOUHd5kgbEmJxe2dbBMYlWYh+WYWkhdmIXlhFsKyBYwsqxjFUguKc9NTiw0LjJGjexMjOO1q
        me9gnPb2g94hRiYOxkOMEhzMSiK8pyaJJQjxpiRWVqUW5ccXleakFh9iNAWG70RmKdHkfGDi
        zyuJNzQ1MjY2tjAxNDM1NFQS500yeBAvJJCeWJKanZpakFoE08fEwSnVwHS70jLxvdDWv90R
        S9uZjJZMlztlcSJ74p6q56xTX0ouC/+5MpNZtoXtsO1FHfutjzJn3bo7a81k3TA5vUum6W7z
        2pd8NfrDEfJn7YeV95olyxI4xPj+XRD8u9pXQC7u0Q2u1eoLz9mZOce1zowK3hi4I0D26a7E
        nVOfLTyZo2Ny4XSpOk9qzauvekd/OFrPczH4mVqaxxzXO/XIN+8vPV65vbryH9KnfrSYvvVm
        7/b7PR8qOe1+xf21dLdWPXtM788GZ68deh2HFLv0HbYHPc79cztJer3Iq3f1x0plF7BturN8
        cTib56pHHL+/P1tbVFsrcTD68f9Hj19c391xv+xeWOtNg9cBTDYr5iovErmnxFKckWioxVxU
        nAgAZbjZN0QEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsWy7bCSnK5esVSCwe9NWhYTWrczW5xtesNu
        cXnXHDaLz71HGC1uN65gs3jz4yyTxZnTl1gtug79ZbP4d20ji8XmB8fYHLg8ZjdcZPFYsKnU
        Y9OqTjaPLVfbWTz6tqxi9Dh+YzuTx+dNcgHsUVw2Kak5mWWpRfp2CVwZM17/YC2YplHR2n+R
        vYGxWb6LkZNDQsBEornjJGsXIxeHkMAORonT8xtYIRKSEtMuHmXuYuQAsoUlDh8uhqh5yyjR
        93w+M0iNsICPxNVz/xlBbBGBVImJzd1sIEXMAv1MEr/mLGOB6OhjlLjyuJEFpIpNQEti/4sb
        bCA2v4CixNUfj8G6eQXsJF5s+MsOYrMIqEj86DgJVi8qECaxc8ljJogaQYmTM5+wgFzEKWAt
        8fiuH0iYWUBd4s+8S8wQtrjErSfzmSBseYntb+cwT2AUnoWkexaSlllIWmYhaVnAyLKKUTK1
        oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM4/rS0djDuWfVB7xAjEwfjIUYJDmYlEd5Tk8QS
        hHhTEiurUovy44tKc1KLDzFKc7AoifNe6DoZLySQnliSmp2aWpBaBJNl4uCUamCyiWaK2Z7Q
        qWc35fjBLWGbL8x6u/9tlIzmFrmej1Pz9wm7X0/a+V7l3A7DQ0tF382V4Ki9Ismw/WFFfMgJ
        uYd6To/12Mz5jLpsXZze+XDEOh23fr9B+LlztfxEiQLXBStzxHYe6dz90pxNK3P6qttMKVHl
        Z163bYjxLFq0qkg6fu2SeKv/YjZrUu7fio8+XBpU/4znt5XS6Zvfd+3ce0PNperunCsTe/gt
        v2jrCYmnen3c+vrC29/PxDY9ertC7Z/PlyYp63unjzY96XiwSK9j9bzi56f8Nu74betYOKPj
        /gulBY+CdJ59mmV3OGjZ7qer3zHptD7n/67Cqf5rhoanmMHH0kzR2dfmcGUXPGAPUGIpzkg0
        1GIuKk4EAH94ye0uAwAA
X-CMS-MailID: 20210203095558epcas1p30425a4bd729286df4c4528d9b64b07f9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210203092602epcas1p1550c96a2ed1b0b6d0a0f9f750cb76e45
References: <CGME20210203092602epcas1p1550c96a2ed1b0b6d0a0f9f750cb76e45@epcas1p1.samsung.com>
        <20210203092400.1791884-1-hsinyi@chromium.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Hsin-Yi,

Thanks for the patch. I already reviewed this patch.
But, I'll check these again and test it. 

On 2/3/21 6:23 PM, Hsin-Yi Wang wrote:
> The devfreq passive governor scales the frequency of a "child" device based
> on the current frequency of a "parent" device (not parent/child in the
> sense of device hierarchy). As of today, the passive governor requires one
> of the following to work correctly:
> 1. The parent and child device have the same number of frequencies
> 2. The child device driver passes a mapping function to translate from
>    parent frequency to child frequency.
> 
> When (1) is not true, (2) is the only option right now. But often times,
> all that is required is a simple mapping from parent's frequency to child's
> frequency.
> 
> Since OPPs already support pointing to other "required-opps", add support
> for using that to map from parent device frequency to child device
> frequency. That way, every child device driver doesn't have to implement a
> separate mapping function anytime (1) isn't true.
> 
> Some common (but not comprehensive) reason for needing a devfreq passive
> governor to adjust the frequency of one device based on another are:
> 
> 1. These were the combination of frequencies that were validated/screened
>    during the manufacturing process.
> 2. These are the sensible performance combinations between two devices
>    interacting with each other. So that when one runs fast the other
>    doesn't become the bottleneck.
> 3. Hardware bugs requiring some kind of frequency ratio between devices.
> 
> For example, the following mapping can't be captured in DT as it stands
> today because the parent and child device have different number of OPPs.
> But with this patch series, this mapping can be captured cleanly.
> 
> In arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi you have something
> like this with the following changes:
> 
> 	bus_g2d_400: bus0 {
> 		compatible = "samsung,exynos-bus";
> 		clocks = <&cmu_top CLK_ACLK_G2D_400>;
> 		clock-names = "bus";
> 		operating-points-v2 = <&bus_g2d_400_opp_table>;
> 		status = "disabled";
> 	};
> 
> 	bus_noc2: bus9 {
> 		compatible = "samsung,exynos-bus";
> 		clocks = <&cmu_mif CLK_ACLK_BUS2_400>;
> 		clock-names = "bus";
> 		operating-points-v2 = <&bus_noc2_opp_table>;
> 		status = "disabled";
> 	};
> 
> 	bus_g2d_400_opp_table: opp_table2 {
> 		compatible = "operating-points-v2";
> 		opp-shared;
> 
> 		opp-400000000 {
> 			opp-hz = /bits/ 64 <400000000>;
> 			opp-microvolt = <1075000>;
> 			required-opps = <&noc2_400>;
> 		};
> 		opp-267000000 {
> 			opp-hz = /bits/ 64 <267000000>;
> 			opp-microvolt = <1000000>;
> 			required-opps = <&noc2_200>;
> 		};
> 		opp-200000000 {
> 			opp-hz = /bits/ 64 <200000000>;
> 			opp-microvolt = <975000>;
> 			required-opps = <&noc2_200>;
> 		};
> 		opp-160000000 {
> 			opp-hz = /bits/ 64 <160000000>;
> 			opp-microvolt = <962500>;
> 			required-opps = <&noc2_134>;
> 		};
> 		opp-134000000 {
> 			opp-hz = /bits/ 64 <134000000>;
> 			opp-microvolt = <950000>;
> 			required-opps = <&noc2_134>;
> 		};
> 		opp-100000000 {
> 			opp-hz = /bits/ 64 <100000000>;
> 			opp-microvolt = <937500>;
> 			required-opps = <&noc2_100>;
> 		};
> 	};
> 
> 	bus_noc2_opp_table: opp_table6 {
> 		compatible = "operating-points-v2";
> 
> 		noc2_400: opp-400000000 {
> 			opp-hz = /bits/ 64 <400000000>;
> 		};
> 		noc2_200: opp-200000000 {
> 			opp-hz = /bits/ 64 <200000000>;
> 		};
> 		noc2_134: opp-134000000 {
> 			opp-hz = /bits/ 64 <134000000>;
> 		};
> 		noc2_100: opp-100000000 {
> 			opp-hz = /bits/ 64 <100000000>;
> 		};
> 	};
> 
> -Saravana
> 
> v4 -> v5:
> - drop patch "OPP: Improve required-opps linking" and rebase to 
>   https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/log/?h=opp/linux-next
> - Compare pointers in dev_pm_opp_xlate_required_opp().
> 
> v3 -> v4:
> - Fixed documentation comments
> - Fixed order of functions in .h file
> - Renamed the new xlate API
> - Caused _set_required_opps() to fail if all required opps tables aren't
>   linked.
> v2 -> v3:
> - Rebased onto linux-next.
> - Added documentation comment for new fields.
> - Added support for lazy required-opps linking.
> - Updated Ack/Reviewed-bys.
> v1 -> v2:
> - Cached OPP table reference in devfreq to avoid looking up every time.
> - Renamed variable in passive governor to be more intuitive.
> - Updated cover letter with examples.
> 
> Saravana Kannan (3):
>   OPP: Add function to look up required OPP's for a given OPP
>   PM / devfreq: Cache OPP table reference in devfreq
>   PM / devfreq: Add required OPPs support to passive governor
> 
>  drivers/devfreq/devfreq.c          |  6 ++++
>  drivers/devfreq/governor_passive.c | 20 ++++++++---
>  drivers/opp/core.c                 | 58 ++++++++++++++++++++++++++++++
>  include/linux/devfreq.h            |  2 ++
>  include/linux/pm_opp.h             | 11 ++++++
>  5 files changed, 92 insertions(+), 5 deletions(-)
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
