Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30E2185DAE
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2019 11:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731737AbfHHJCw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 05:02:52 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59840 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731054AbfHHJCw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Aug 2019 05:02:52 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190808090251euoutp01623a5c76706e36cf8460d5c9ec895023~45xprbNCE1749517495euoutp01i
        for <linux-pm@vger.kernel.org>; Thu,  8 Aug 2019 09:02:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190808090251euoutp01623a5c76706e36cf8460d5c9ec895023~45xprbNCE1749517495euoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565254971;
        bh=EmslgonStTRrL/u4P7UDkmcHxhjWmImBf/o0FvYqLms=;
        h=From:To:Cc:Subject:Date:References:From;
        b=fARQgsjG2KPry9bGlgUCVs/b51lzMdFP+WCigJG6AUorSMJPcXYeX25c8G7s5mS7z
         RsTdpaccV3AssqbuSkNa0A99mHeTCyrvlsixp3A+5UmFzU4QZWSlmImpQW7F3kOWB1
         hJdEzSgXrjvq6E3ywQ0SCCuQ4m3EpHJft8ku2uHg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190808090250eucas1p12af7dc98dc457a21ba04634483380e13~45xo6A7iq1972119721eucas1p1I;
        Thu,  8 Aug 2019 09:02:50 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 64.9E.04469.935EB4D5; Thu,  8
        Aug 2019 10:02:50 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190808090249eucas1p19944820d79ec211c85d9e1285f892f9c~45xoLMR_F2988729887eucas1p1O;
        Thu,  8 Aug 2019 09:02:49 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190808090249eusmtrp2451cd8f3c41bb0cc7e9400250b87362d~45xn89HN40888908889eusmtrp28;
        Thu,  8 Aug 2019 09:02:49 +0000 (GMT)
X-AuditID: cbfec7f2-54fff70000001175-3d-5d4be539e327
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 5D.A1.04117.935EB4D5; Thu,  8
        Aug 2019 10:02:49 +0100 (BST)
Received: from AMDC3218.DIGITAL.local (unknown [106.120.51.18]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190808090248eusmtip2518377b8b3e93d5d0b1add5351f55912~45xnPEzTZ3181431814eusmtip2i;
        Thu,  8 Aug 2019 09:02:48 +0000 (GMT)
From:   Kamil Konieczny <k.konieczny@partner.samsung.com>
To:     k.konieczny@partner.samsung.com
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
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
Subject: [RESEND PATCH v5 0/4] add coupled regulators for Exynos5422/5800
Date:   Thu,  8 Aug 2019 11:02:30 +0200
Message-Id: <20190808090234.12577-1-k.konieczny@partner.samsung.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjuO5ed42h2nGEfGiaroCSvBH5dTZA45o/qR1CG2dKDWjpl85JG
        mWWZZssUSqdpWdJaltNSl5WVDmelLlOXmNrULEwTvEQZ4XI7i/r3vO/zPN/7Pi8fjYsHSVc6
        VpbEyWXSOIlASNS3znd6bR4LDfeduouhmqJqEr2f+0Kicn0niZRNFoAuj07gyGjUUqjjzCSF
        akdNJOpuLBWg2Ut6gIqMTRi6rx+kUOX7Lgx9yFQL0OTPDgyde6an0IKphkAPza2CHWK2qqwK
        sLWaHAH78HYG+3LqKcYqH2kAa+hrwNjZWvc9VJhwaxQXF5vCyX22HxbGmM0mIrHS+XhvloY8
        DfTLcgFNQ2YjLP10MhcIaTGjBjDv4mcsFzgsFnMAftNRPDELoLpxwEZYDQW9LzCeuAPgiDET
        54tFx3jhvMCqEjABcKSh3eZYzqyGhUPXbCKcmSegtruGss52ZkKgTutv1RDMWtjw8TOwYhET
        DHWaUpKftgrm6J4QfN8Jvir+ZMP4Yv9sXYntTciYKNi7kA14QzDsevnabnaGXw2PKB6vhJbH
        5fYIqXDsppLizVkAmrOnCZ7YAlsMXaR1OZxZD6sbffh2ECzRqQn+Xo6w75sTv4MjLKi35rK2
        RfDCeTGv9oJllnb7Bm4w1/LAjllY9PSKgL9uOBz/1YTlAw/Vf8lU/yVT/dvhBsA1YAWXrIiP
        5hR+Mi7VWyGNVyTLor0jE+JrweKne7NgmNGB7++ONAOGBpKlosS20HAxKU1RpMU3A0jjkuWi
        oZSQcLEoSpqWzskTIuTJcZyiGbjRhGSF6MQS80ExEy1N4o5xXCIn/8titIPrabBPqftx2Ldr
        Z8C2dT/cg3rfFm9QeWb3p1evubd7sp4oC/ToPxrZPOuboE5o3R6bk7EpMMRjqs7sGOnU023U
        ss4tgwOasOczFfP5fT1joXrKVxgslJp+R9yqLIu4ruzuVPkN7R++emhiw94ClyeZu4any08d
        SGrjotoZ7zyti7t/hYRQxEj9PHG5QvoHdCGYN3ADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsVy+t/xe7qWT71jDWa/E7TYOGM9q8X1L89Z
        LeYfOcdq0bfvP6NF/+PXzBbnz29gtzjb9IbdYtPja6wWl3fNYbP43HuE0WLG+X1MFmuP3GW3
        WHr9IpPF7cYVbBZvfpxlsmjde4Td4t+1jSwWmx8cY3MQ8lgzbw2jx6ZVnWwem5fUexx8t4fJ
        o2/LKkaP4ze2M3l83iQXwB6lZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRv
        Z5OSmpNZllqkb5egl/HgwTWWgqXCFVdbVrE2MB7h72Lk5JAQMJGYdPUAUxcjF4eQwFJGiWu3
        jzBCJKQlGk+vZoKwhSX+XOtigyj6xCix6eVaFpAEm4C5xKPtZ8CKRASUJSbfm84MUsQs0Mkq
        seLJEaAODg5hAU+JHRuMQGpYBFQltt9/BraAV8BFYseqOawQC+QlOnfsZoGIC0qcnPkEzGYG
        ijdvnc08gZFvFpLULCSpBYxMqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQKjbNuxn1t2MHa9
        Cz7EKMDBqMTDW3DCO1aINbGsuDL3EKMEB7OSCO+9Ms9YId6UxMqq1KL8+KLSnNTiQ4ymQMdO
        ZJYSTc4HJoC8knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC6YklqdmpqQWpRTB9TBycUg2M86/c
        q/kZuLTqda/WJaXvL/6nVgpbet0oc6vzCk0J2LZ8ZeOtF4yN63f9eXl0ScjSjfHH0w5u+B9s
        KvRCjnle8OzzeQcjX7zM2LfFY9VNpbquHiGB7WrmFV7uC6LnTq84m7LyrfxpvWV9YVffZO+y
        Y9Y8WBN9/qxNnfQqkdN/z6vV/W0yncfYocRSnJFoqMVcVJwIAAVgHcbIAgAA
X-CMS-MailID: 20190808090249eucas1p19944820d79ec211c85d9e1285f892f9c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190808090249eucas1p19944820d79ec211c85d9e1285f892f9c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190808090249eucas1p19944820d79ec211c85d9e1285f892f9c
References: <CGME20190808090249eucas1p19944820d79ec211c85d9e1285f892f9c@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

The main purpose of this patch series is to add coupled regulators for
Exynos5422/5800 to keep constrain on voltage difference between vdd_arm
and vdd_int to be at most 300mV. In exynos-bus instead of using
regulator_set_voltage_tol() with default voltage tolerance it should be
used regulator_set_voltage_triplet() with volatege range, and this is
already present in opp/core.c code, so it can be reused. While at this,
move setting regulators into opp/core.

This patchset was tested on Odroid XU3.

The DTS coupled regulators patch depends on previous patches.

Changes:
v5:
- squashed last patch "remove exynos_bus_passive_target()" into second
- added Acked-by to patch "correct clock enable sequence"
v4:
- removed "opp: core: add regulators enable and disable" from patchset
  as it was applied by Viresh Kumar and changed cover letter
- fix patch "devfreq: exynos-bus: correct clock enable sequence" to
  correct order of enable/disable
- removed unrelated changes in "devfreq: exynos-bus: convert to use
  dev_pm_opp_set_rate()"
- added new patch "devfreq: exynos-bus: remove exynos_bus_passive_target()"
  as suggested by Chanwoo Choi
v3:
- added new exynos-bus patch to correct clock and regulator enabling
  and disabling sequence as suggested by Chanwoo Choi
- corrected error path in enable and improved commit message in opp/core
- improve comment in devfreq/exynos-bus.c before devfreq_recommended_opp()
- change cover letter as there is new patch
- added note before Signed-off-by in 4th patch
v2:
- improve regulators enable/disable code in opp/core as suggested by
  Viresh Kumar
- add new patch for remove unused dt-bindings as suggested by Krzysztof
  Kozlowski

Kamil Konieczny (3):
  devfreq: exynos-bus: correct clock enable sequence
  devfreq: exynos-bus: convert to use dev_pm_opp_set_rate()
  dt-bindings: devfreq: exynos-bus: remove unused property

Marek Szyprowski (1):
  ARM: dts: exynos: add initial data for coupled regulators for
    Exynos5422/5800

 .../bindings/devfreq/exynos-bus.txt           |   2 -
 arch/arm/boot/dts/exynos5420.dtsi             |  34 ++--
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi |   4 +
 arch/arm/boot/dts/exynos5800-peach-pi.dts     |   4 +
 arch/arm/boot/dts/exynos5800.dtsi             |  32 ++--
 drivers/devfreq/exynos-bus.c                  | 153 +++++-------------
 6 files changed, 78 insertions(+), 151 deletions(-)

-- 
2.22.0

