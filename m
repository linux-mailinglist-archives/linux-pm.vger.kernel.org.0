Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBF4994B8
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2019 15:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732606AbfHVNS4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Aug 2019 09:18:56 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36946 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732467AbfHVNS4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Aug 2019 09:18:56 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190822131854euoutp02f4e291d750420c61fe7d9399c8c3477f~9QTNv9uF12905629056euoutp02W
        for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2019 13:18:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190822131854euoutp02f4e291d750420c61fe7d9399c8c3477f~9QTNv9uF12905629056euoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566479934;
        bh=F44EVnTO+GtDjxdQbJnARMCEO/Q+Yxe2hI8JoPBw2gQ=;
        h=Subject:Cc:To:From:Date:In-Reply-To:References:From;
        b=f0vLyt8w7YPH1rhBmSW+wXxcSts5ox5EmwTa6ocUbdjVPzFpKbrQE77MR+tTYQ0Ek
         +Gvw1yS3tFZ9FRDxi8nkclY9Ty41F6Pho6ZCRDQd+zlbMiAHBrAWMzQA81YTyi++qC
         wDCkzeJ9Nkbik75HcsDBCJZCDTCCBM6cawbiY8HI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190822131853eucas1p2c5af1edc93b92358245c742ecd1de77a~9QTM0H8ic0687106871eucas1p2G;
        Thu, 22 Aug 2019 13:18:53 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id B3.9E.04374.D369E5D5; Thu, 22
        Aug 2019 14:18:53 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190822131852eucas1p14653c9ddd85096bbee11447e0c68c052~9QTLxC46Y1860818608eucas1p1k;
        Thu, 22 Aug 2019 13:18:52 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190822131852eusmtrp2c34461aaa48dd5fe69e0efcb6635db70~9QTLhTY4g2865128651eusmtrp2S;
        Thu, 22 Aug 2019 13:18:52 +0000 (GMT)
X-AuditID: cbfec7f5-4f7ff70000001116-f7-5d5e963dae74
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 56.D3.04117.C369E5D5; Thu, 22
        Aug 2019 14:18:52 +0100 (BST)
Received: from [106.120.51.18] (unknown [106.120.51.18]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190822131851eusmtip22c23884609353eaf52f43abc24fd7fcb~9QTK1iFoa2631926319eusmtip2L;
        Thu, 22 Aug 2019 13:18:51 +0000 (GMT)
Subject: Re: [RESEND PATCH v5 0/4] add coupled regulators for
 Exynos5422/5800
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
To:     MyungJoo Ham <myungjoo.ham@samsung.com>
From:   Kamil Konieczny <k.konieczny@partner.samsung.com>
Message-ID: <fd9897b6-edc9-f88f-4393-62050bd66710@partner.samsung.com>
Date:   Thu, 22 Aug 2019 15:18:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808090234.12577-1-k.konieczny@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0iTURj27Lvs05odp7UX7WITIY0ySeiA3YSSVT8S/KFkmiu/VFKzTafW
        D83ssnW/UDYlu1gumbcpTqOsdDg10yywYQXLS0FqZSophtb2FfnvOc/lvO9zOBwltTPeXHJa
        Bq9KU6bIWTe6vnW6a82m63Gx65reu5OawiqGvJ34zJASSxdDLg4MU6S7u1pMXuaPiIlpoJch
        bx4Vs2T8vAWRwu4mEamwfBCT+297ROTdcQNLRqZeisjJJxYxme2toUmtvZXd6qEw3jIihalc
        yypqS3MVF+rKkcJqM4sU46blEewet40JfEqyhlcFbY53SyrNr2TSJxZnX6vOp/OQ0UOHXDnA
        IVAwNE3pkBsnxQYE/VfrxcJhAkH1gI12uKR4HIFhZq8Occ7ECaOr4ClDUNRz9W96FEHh00rW
        EfDEu+H5zwbaIVD4FQ1fXt2mHIIXXg0zto/OW1m8AfrNnSIHluBwMJ+4yzgwjf2h6Os7p38x
        joYf9hZG8HhA+81BZ9YVb4eK8nYnprAM+gZLRAJeAebRYudGgLUcTPaVMULRbaDrbGEF7Alf
        rHViAS+FuUYhDDgLhu5cEAvhAgT202O0IIRCi7WHcfSncABUPQoS6DAoajDQwrO4g23UQ9jB
        Ha7U36AEWgJnTkkFtz987jj3d5IP6OYqmUtIrp/XTD+vjX5eG/3/ubcRXY5kfKY6NZFXr0/j
        s9aqlanqzLTEtQcOp5rQn3/3YtY62YCafu1vRphD8oWSNl1crJRRatQ5qc0IOEruJdFc/kNJ
        EpQ5R3nV4X2qzBRe3Yx8OFoukxxzscdIcaIygz/E8+m86p8q4ly98xDqtQZw1Xm76BjwKd0S
        ft9v1fu2D0vuTu18ol12ve/1YIJs+uRjSX/rjq23cmsiQjeVdN2I8naJfhYZPKPNkbmkH9Ev
        eZCsPeS1cruvxHZcFxhiojQRGsv3yhHfeL8FZR8bxx5GRVZEJ5DBrivxZxOHp6hFSZ+Cv91r
        CQtHHdmBB+W0OkkZHEip1MrfD68QFXMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsVy+t/xe7o20+JiDSZuZLfYOGM9q8X1L89Z
        LeYfOcdq0f/4NbPF+fMb2C3ONr1ht9j0+BqrxeVdc9gsPvceYbSYcX4fk8XaI3fZLZZev8hk
        cbtxBZvFmx9nmSxa9x5ht/h3bSOLxeYHx9gcBD3WzFvD6LFpVSebx+Yl9R59W1Yxehy/sZ3J
        4/MmuQC2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27
        BL2MJU3rWAu+iFZM2dDE0sC4RrCLkYNDQsBEonkNZxcjJ4eQwFJGiUOzbEFsCQFpicbTq5kg
        bGGJP9e62LoYuYBqXjNK3N5ykxUkISzgK3Hxwh0WkASzwAUWiee/DrJCVM1glLgzp5EdpEpE
        QFvi942HLCA2m4C5xKPtZ8DG8gq4SWxvXgQ2iUVAVWL2u9vMILaoQITE4R2zGCFqBCVOznwC
        1ssp4CqxdtVJMJtZQF3iz7xLzBC2uMStJ/OZIGx5ie1v5zBPYBSahaR9FpKWWUhaZiFpWcDI
        sopRJLW0ODc9t9hIrzgxt7g0L10vOT93EyMwwrcd+7llB2PXu+BDjAIcjEo8vCe64mKFWBPL
        iitzDzFKcDArifCWTQQK8aYkVlalFuXHF5XmpBYfYjQFem4is5Rocj4w+eSVxBuaGppbWBqa
        G5sbm1koifN2CByMERJITyxJzU5NLUgtgulj4uCUamDMEZVaci5V68Ttc+WcT5cd2Z23Tirt
        1Y336hvXF2TfOdP6ab10Dv+PW+eebFw+zfZCysrm6pkRjya1qFu6Suz2PXf83I8lzFfjp860
        9ImeUfH2sGJ6utqlaw9t6jOYZp2KiZvDwR+1rsj4u2pLe7DLmZD1tQz37nxR3bBxzhajGUIy
        6Xma5o4PlViKMxINtZiLihMB6AXRsgYDAAA=
X-CMS-MailID: 20190822131852eucas1p14653c9ddd85096bbee11447e0c68c052
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190808090249eucas1p19944820d79ec211c85d9e1285f892f9c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190808090249eucas1p19944820d79ec211c85d9e1285f892f9c
References: <CGME20190808090249eucas1p19944820d79ec211c85d9e1285f892f9c@eucas1p1.samsung.com>
        <20190808090234.12577-1-k.konieczny@partner.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Dear MyungJoo,

On 08.08.2019 11:02, Kamil Konieczny wrote:
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

Could you please merge patches 1/4 and 2/4 for v5.4
(they were already Ack-ed by Chanwoo Choi)?

-- 
Best regards,
Kamil Konieczny
Samsung R&D Institute Poland

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

