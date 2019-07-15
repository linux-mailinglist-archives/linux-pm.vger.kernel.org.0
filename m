Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 654E968878
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2019 14:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbfGOMEe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jul 2019 08:04:34 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46079 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729944AbfGOMEe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jul 2019 08:04:34 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190715120431euoutp017224f3d03c2c80797c2cf5feb546b420~xkxbU9Jqp2169221692euoutp010
        for <linux-pm@vger.kernel.org>; Mon, 15 Jul 2019 12:04:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190715120431euoutp017224f3d03c2c80797c2cf5feb546b420~xkxbU9Jqp2169221692euoutp010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563192271;
        bh=i3auGkJgw9SKm0S7pYs8dDdYpDEpYz2cgpDsLc2zkj4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=CqFPTPXcAZ2vTTbELUe1bWzUwtkNa0FdfG2OUQShdziCO2Ze/PM4hvvU4y1Q8PlMC
         uZ+4bK8xqAj8kTFGb3UsjgpSLkw7+1HELxdLaAqXVJqXaCoJaoslNhomXsY8hOSk1e
         KGa6vfy25Br/UqZ4pGUBaqvz62LECMJ+a5DlvnrA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190715120431eucas1p16622abacb55aff8972b4e96fdcbdd01f~xkxaio9qa3262432624eucas1p1O;
        Mon, 15 Jul 2019 12:04:31 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 39.FF.04298.ECB6C2D5; Mon, 15
        Jul 2019 13:04:30 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190715120430eucas1p1dd216e552403899e614845295373e467~xkxZomOa72398923989eucas1p1y;
        Mon, 15 Jul 2019 12:04:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190715120429eusmtrp1688595b10dd7962aedaeec21a96fc766~xkxZaTJ_R1141311413eusmtrp1S;
        Mon, 15 Jul 2019 12:04:29 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-c9-5d2c6bcee598
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C9.12.04140.DCB6C2D5; Mon, 15
        Jul 2019 13:04:29 +0100 (BST)
Received: from AMDC3218.DIGITAL.local (unknown [106.120.51.18]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190715120429eusmtip16591f99b4d6c151d00956fc96a3415d5~xkxYsKTBJ1539615396eusmtip1Z;
        Mon, 15 Jul 2019 12:04:29 +0000 (GMT)
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
Subject: [PATCH v2 0/4] add coupled regulators for Exynos5422/5800
Date:   Mon, 15 Jul 2019 14:04:12 +0200
Message-Id: <20190715120416.3561-1-k.konieczny@partner.samsung.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0iTURjGPftuU1p9TsvXDItF2E1NEDqQhV0ZQRD0T1RiK7/UdJvty8qK
        spumlFpSmdm9SKamm+nEWzbFNW9zSpqZJpUa3cQbZYlr22flf7/zvM9z3vc9HDEhfUfNF0er
        DnMalSJWRruRpfUTLf4tMSvDVrX+DsK6rEIKd44NUvhuXQuF06ptCKd/+EJgi6WIwc1nvzJY
        /6GDwu3lOTQevVyHcJalWoQL6noY/LjTKsLdZ3Jp/PVnswhfqKpj8FSHjsTFffV0qFSefycf
        yfXaFFpe/Oi0/MX3SpE87ZkWyU2vDSL5qN53O7PLLSSCi40+wmkC1+11i6oauMHE3Z51bOhW
        Bp2IDK6pyFUMbDAY8n6QDpayuQgaTPtTkZudxxAUXC9HwmEUwW9tI/qbqHz1lhYKTxDUjpuJ
        f5F2awHjcNHsanhvaBI52JNdDJm9N5wmgp0goahd5zR5sBtg4LvZySS7BNJyxygHS9iNMPbj
        GiG0WwgpZRWkoLuD+eZHJxN2/VzJLeelwLYx0HN5RCQENkFPw09KYA/4bHrGCLwAGjMvkQIf
        hf77aYwQPo+gL3l4urAGak1We1hs77AMCssDBXk9NNboaIcM7Gx4/c1dmGE2XC11LOaQJXAx
        SSq4/eGOrWl6Ah9ItT2dZjkkD+ZRwluHQX3uXSoDLcqesVn2jM2y/89wDxFa5MXF88pIjg9S
        cUcDeIWSj1dFBuxXK/XI/u0ap0wjZWi8bZ8RsWIkmyUJjVgRJqUUR/gEpRGBmJB5StaO2yVJ
        hCLhOKdRh2viYzneiHzEpMxLcsKlb7eUjVQc5mI4Lo7T/K2KxK7zE1FMUn3AqW3GSd68derm
        5gFdSi9bMlk7utQy9GDNVIhL95BtuKSstatrRE/vMTf3+1f1tZx6ma7/5e7R83DOQe3iNzpv
        b73x08IYqSzR1+dk74F+P6/VRMUV4w7vwhpr3OemLcEvNCQRdWju4/DhnZAyTx3s5xk8UHvu
        oClEnWN7LiP5KEXQckLDK/4ABW4T33IDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsVy+t/xu7pns3ViDVbdNLHYOGM9q8X1L89Z
        LeYfOcdq0bfvP6NF/+PXzBbnz29gtzjb9IbdYtPja6wWl3fNYbP43HuE0WLG+X1MFmuP3GW3
        WHr9IpPF7cYVbBZvfpxlsmjde4Td4t+1jSwWmx8cY3MQ8lgzbw2jx6ZVnWwem5fUexx8t4fJ
        o2/LKkaP4ze2M3l83iQXwB6lZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRv
        Z5OSmpNZllqkb5egl7H32XT2grk8Fe9nT2BrYNzO2cXIySEhYCKx5+odti5GLg4hgaWMEh3H
        57JBJKQlGk+vZoKwhSX+XOuCKvrEKNH8/x4zSIJNwFzi0fYzYEUiAsoSk+9NZwYpYhboZJVY
        8eQI2CRhASeJZ+9OsoPYLAKqEn0rvrCC2LwCzhJfvk9lhtggL9G5YzcLRFxQ4uTMJ2A2M1C8
        eets5gmMfLOQpGYhSS1gZFrFKJJaWpybnltspFecmFtcmpeul5yfu4kRGGfbjv3csoOx613w
        IUYBDkYlHl6HFO1YIdbEsuLK3EOMEhzMSiK8tl+BQrwpiZVVqUX58UWlOanFhxhNgY6dyCwl
        mpwPTAF5JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE0hNLUrNTUwtSi2D6mDg4pRoY5xSkh//Q
        Zv/bVBwmmFD1wTHl59Tvdsm7E9TvGmqe/752sUJSBZtVe35lgcF8KckTNREaV46+Pr7unP9O
        hTm7mqq8wjjy25OV3i7le1iz8/U78aKXa5c6Z/8T37Gdqf2N6oG5/0MSfxau3HXv9LGbWcXt
        W1S/XZpQF29UOafgknhB0fXSjd92KLEUZyQaajEXFScCAOtXNgrJAgAA
X-CMS-MailID: 20190715120430eucas1p1dd216e552403899e614845295373e467
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715120430eucas1p1dd216e552403899e614845295373e467
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715120430eucas1p1dd216e552403899e614845295373e467
References: <CGME20190715120430eucas1p1dd216e552403899e614845295373e467@eucas1p1.samsung.com>
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

The last patch depends on two previous.

Changes in v2:

- improve regulators enable/disable code in opp/core as suggested by
  Viresh Kumar
- add new patch for remove unused dt-bindings as suggested by Krzysztof
  Kozlowski

Regards,
Kamil

Kamil Konieczny (3):
  opp: core: add regulators enable and disable
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
 drivers/devfreq/exynos-bus.c                  | 172 +++++++-----------
 drivers/opp/core.c                            |  18 +-
 7 files changed, 122 insertions(+), 144 deletions(-)

-- 
2.22.0

