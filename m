Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3D6F62025
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 16:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731693AbfGHOMC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jul 2019 10:12:02 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50863 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729526AbfGHOMC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jul 2019 10:12:02 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190708141200euoutp028e21a07f13ac894495252b3103dae722~vc-ukG7no2957129571euoutp02B
        for <linux-pm@vger.kernel.org>; Mon,  8 Jul 2019 14:12:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190708141200euoutp028e21a07f13ac894495252b3103dae722~vc-ukG7no2957129571euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1562595120;
        bh=0TbVjzJdC4haysmGHRjI6XW+S2vD6KrCfbrhFyLR0Qg=;
        h=From:To:Cc:Subject:Date:References:From;
        b=DV17y2aMFo5Vi+SoQ3CH3ssUsMm8X3Aoq5hFZWUPnq6EdWrlQTDRlvm5zaH9SjyNQ
         GgGjpy4KGOJagrld8bMml4W871nWwzoTMFCl8JCp5RCjfh5k9wQK8I1H4XuSZSd1ap
         +ZjxyVc++CIK4tO5AGJ1VP/pACZc8Fb/HW6/C490=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190708141159eucas1p24c1e9f39d423425a61b70365df27c55a~vc-tuJyrL1493814938eucas1p2J;
        Mon,  8 Jul 2019 14:11:59 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 5A.19.04298.F2F432D5; Mon,  8
        Jul 2019 15:11:59 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190708141158eucas1p17d4b50978dbe1e5c876ce6d8f433cc95~vc-s5BE2X1373613736eucas1p1s;
        Mon,  8 Jul 2019 14:11:58 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190708141158eusmtrp17e287234cc335b82d35ae4497d429294~vc-sqx0ae0147201472eusmtrp1k;
        Mon,  8 Jul 2019 14:11:58 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-61-5d234f2f623a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E5.8B.04146.E2F432D5; Mon,  8
        Jul 2019 15:11:58 +0100 (BST)
Received: from AMDC3218.DIGITAL.local (unknown [106.120.51.18]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190708141157eusmtip208a55aea9b9cc01cc9b7dfcc74d8c6ab~vc-r724370490104901eusmtip2L;
        Mon,  8 Jul 2019 14:11:57 +0000 (GMT)
From:   k.konieczny@partner.samsung.com
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
Subject: [PATCH 0/3] add coupled regulators for Exynos5422/5800
Date:   Mon,  8 Jul 2019 16:11:37 +0200
Message-Id: <20190708141140.24379-1-k.konieczny@partner.samsung.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAKsWRmVeSWpSXmKPExsWy7djP87r6/sqxBhPvcFhsnLGe1eL6l+es
        FvOPnGO16Nv3n9Gi//FrZovz5zewW5xtesNusenxNVaLy7vmsFl87j3CaDHj/D4mi7VH7rJb
        LL1+kcniduMKNos3P84yWbTuPcJu8e/aRhaLzQ+OsTkIeayZt4bRY9OqTjaPzUvqPQ6+28Pk
        0bdlFaPH8RvbmTw+b5ILYI/isklJzcksSy3St0vgyliz7SFbwRKuii0/nrA0MP5m72Lk5JAQ
        MJF4teU2kM3FISSwglHi2MGJLBDOF0aJO70nmCCcz4wSU3suscK0HG84wwyRWM4ocfdsOzNc
        y66dO5hAqtgEVCW2zHgJtkREQFli8r3pYEXMAj9ZJDZc3giWEBawl3jzdj+YzQLUsPRZLwuI
        zSvgInHn9E2oC+UlOnfshooLSpyc+QTMZgaKN2+dDTZUQuAcu8T0NQ9YIBpcJBa1zmKGsIUl
        Xh3fAjVIRuL05B6omnKJpwv72CGaWxglHrR/hEpYSxw+fhHoUQ6gDZoS63fpQ4QdJZ78+8sI
        EpYQ4JO48VYQ4gY+iUnbQB4DCfNKdLQJQVTrSsz7fwYaWtISXf/XQdkeErv3rwSHj5BArMSt
        o2dZJjAqzELy2Swkn81CuGEBI/MqRvHU0uLc9NRiw7zUcr3ixNzi0rx0veT83E2MwHR3+t/x
        TzsYv15KOsQowMGoxMO7QVopVog1say4MvcQowQHs5II7z535Vgh3pTEyqrUovz4otKc1OJD
        jNIcLErivNUMD6KFBNITS1KzU1MLUotgskwcnFINjHZq3LUv2GelNyw55XHnV1/L7qnXJzsd
        /txQGRqcJlM3W+yVrvQZZRYjrRc8ifXe/rFaOSvSFLal72Rq1e54ap/qLR9Ycibae9PpDe/O
        XMhyspHbpWJbcOCxcqX58U1XLbZFPv0sPF9IZ6HNrd4sh1MsvEI5sZHifFEc85TnrTvz5OZV
        nrPFSizFGYmGWsxFxYkAqLzEEXMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsVy+t/xe7p6/sqxBucaBSw2zljPanH9y3NW
        i/lHzrFa9O37z2jR//g1s8X58xvYLc42vWG32PT4GqvF5V1z2Cw+9x5htJhxfh+Txdojd9kt
        ll6/yGRxu3EFm8WbH2eZLFr3HmG3+HdtI4vF5gfH2ByEPNbMW8PosWlVJ5vH5iX1Hgff7WHy
        6NuyitHj+I3tTB6fN8kFsEfp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb
        2aSk5mSWpRbp2yXoZazZ9pCtYAlXxZYfT1gaGH+zdzFyckgImEgcbzjD3MXIxSEksJRR4mzf
        dFaIhLRE4+nVTBC2sMSfa11sEEWfGCW+rX/PDJJgE1CV2DLjJdgkEQFlicn3poNNYhboZJVY
        8eQIG0hCWMBe4s3b/WBFLEANS5/1soDYvAIuEndO34Q6Q16ic8duqLigxMmZT8BsZqB489bZ
        zBMY+WYhSc1CklrAyLSKUSS1tDg3PbfYUK84Mbe4NC9dLzk/dxMjMM62Hfu5eQfjpY3BhxgF
        OBiVeHg55JRihVgTy4orcw8xSnAwK4nw7nNXjhXiTUmsrEotyo8vKs1JLT7EaAp07ERmKdHk
        fGAKyCuJNzQ1NLewNDQ3Njc2s1AS5+0QOBgjJJCeWJKanZpakFoE08fEwSnVwJhyw7mZ5frp
        wC/FP//eb7izd/V5vpjvEi1Fl/miL3z/mvWjWG2Pv03DfpHzJepMjeGcZ2WLvlxUWDz9cOwp
        Fg93k+/1XP967r9cuENui2FGbGFF4+dQBqX7TJaPuhO6zuVuZrlRxL9Z9/iP7Qs/2vDdXSyl
        WDApqcA56FttmEyCf2LGip7ZqUosxRmJhlrMRcWJAA3WOfvJAgAA
X-CMS-MailID: 20190708141158eucas1p17d4b50978dbe1e5c876ce6d8f433cc95
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190708141158eucas1p17d4b50978dbe1e5c876ce6d8f433cc95
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190708141158eucas1p17d4b50978dbe1e5c876ce6d8f433cc95
References: <CGME20190708141158eucas1p17d4b50978dbe1e5c876ce6d8f433cc95@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Kamil Konieczny <k.konieczny@partner.samsung.com>

Hi,

The main purpose of this patch series is to add coupled regulators for
Exynos5422/5800 to keep constrain on voltage difference between vdd_arm
and vdd_int to be at most 300mV. In exynos-bus instead of using
regulator_set_voltage_tol() with default voltage tolerance it should be
used regulator_set_voltage_triplet() with volatege range, and this is
already present in opp/core.c code, so it can be reused. While at this,
move setting regulators into opp/core.

This patchset was tested on Odroid XU3.

The last patch depends on two previous.

Regards,
Kamil

Kamil Konieczny (2):
  opp: core: add regulators enable and disable
  devfreq: exynos-bus: convert to use dev_pm_opp_set_rate()

Marek Szyprowski (1):
  ARM: dts: exynos: add initial data for coupled regulators for
    Exynos5422/5800

 arch/arm/boot/dts/exynos5420.dtsi             |  34 ++--
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi |   4 +
 arch/arm/boot/dts/exynos5800-peach-pi.dts     |   4 +
 arch/arm/boot/dts/exynos5800.dtsi             |  32 ++--
 drivers/devfreq/exynos-bus.c                  | 172 +++++++-----------
 drivers/opp/core.c                            |  13 ++
 6 files changed, 120 insertions(+), 139 deletions(-)

-- 
2.22.0

