Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5D862032
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 16:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731699AbfGHOMD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jul 2019 10:12:03 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50875 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731691AbfGHOMC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jul 2019 10:12:02 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190708141200euoutp02549f78ddc18d6fcf97d82891098561e6~vc-vHs-iG2937229372euoutp02p
        for <linux-pm@vger.kernel.org>; Mon,  8 Jul 2019 14:12:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190708141200euoutp02549f78ddc18d6fcf97d82891098561e6~vc-vHs-iG2937229372euoutp02p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1562595120;
        bh=os/t6E50bR1XYLSweFwdc4MuERNk7+i5wjswJXfr9q4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g6rvMLBAIG02GP0iXIZySEJ9Rna6j7fdGVt9fPIndh++TDnmZQ1e8xyZG3sgeBfn8
         KXXDYagacqMS368ZaR0/pxs0khgHWjwZfpxOw37if1Phl//Z2d+iSTWfoxDY7Q7zvX
         h/HdbhZkxjEdXdR8wW7QaIXCiFcVHOApqB9KFcAA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190708141200eucas1p25a0b91036cfceef1fd330224c2ac57cb~vc-uVUUTk1502515025eucas1p2T;
        Mon,  8 Jul 2019 14:12:00 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 92.A2.04377.F2F432D5; Mon,  8
        Jul 2019 15:11:59 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190708141159eucas1p1751506975ff96a436e14940916623722~vc-tbV9W_0589605896eucas1p1e;
        Mon,  8 Jul 2019 14:11:59 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190708141159eusmtrp2be6df2275f74fc9e54f0afa1b7e06dcb~vc-tal0f51954319543eusmtrp2Q;
        Mon,  8 Jul 2019 14:11:59 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-4d-5d234f2fea98
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E6.D4.04140.E2F432D5; Mon,  8
        Jul 2019 15:11:59 +0100 (BST)
Received: from AMDC3218.DIGITAL.local (unknown [106.120.51.18]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190708141158eusmtip2f27b39034436cb773a2fd293718d5259~vc-sprwv20438404384eusmtip2d;
        Mon,  8 Jul 2019 14:11:58 +0000 (GMT)
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
Subject: [PATCH 1/3] opp: core: add regulators enable and disable
Date:   Mon,  8 Jul 2019 16:11:38 +0200
Message-Id: <20190708141140.24379-2-k.konieczny@partner.samsung.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708141140.24379-1-k.konieczny@partner.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SeyyVcRjH+72X877UsddheRa6HOsPmk5abb+tVIp1tta6/1MTb7yhnMPO
        QdQKXYiNLhROjTRGKNeQyvXEGpFsSNNOncq6GaOhyem8563Vf5/n+zzf3/N8tx9LKkbpZWyE
        NkbQaflIpcyequ+c6/VW7fEIXFfe5o2rcytpPDQ9RuMCYy+NM5stCF8xfyVxX18Vg1+c/8bg
        GvMgjQeabsvwVIYR4dy+ZgLfN44yuHion8Bvkktl+NvsCwJfempk8MJgNYVrTZ2ybQp1RX4F
        UteUpcnUtUWJ6rbxJ4Q6s64MqbuGGwj1VM3yvcxh+82hQmREnKBTbQm2D39f8oyIHlwcf2My
        W5aE3tmlIzsWuA3QkzGJ0pE9q+BKEYzOfiKkYhpBQYWBkoopBN/7J2R/LfUZI0hkBVeC4O0v
        XmKrozJFLrKMWw11uZ8ZkZ05D8h6m0OKD5HcHAVVA9W2hhPnB1lJT2mRKathNO+alVlWzvlD
        +dXt0q4VkNb4mBLZjgsAoznftlfOOcLzvA82nbTOXHh4y/Y+cD8YeD07Q0pmf2gZavxztBN8
        6apjJHYDy6MCQuJT8LEwk5HMFxGYUicpqbEJOrr6bQeRnCdUNqkk2Q/MaR2EKAPnAMPfHaUb
        HOB6vZhRlOVwOUUhTXtDvqWHltgV0i0P/rAacqzJr6JVhv/SGP5LY/i39w4iy5CLEKvXhAn6
        9Vrh1Fo9r9HHasPWhkRpapD103UvdE03oqb5Y+2IY5FyiZxdrgxU0HycPkHTjoAllc7y5p0e
        gQp5KJ9wWtBFBeliIwV9O3JlKaWL/Mwi0xEFF8bHCCcFIVrQ/e0SrN2yJBTZqCo99N5PdffV
        0nLH4pDE7KCgka1F+9PvPz5bW3LUtG/3idLEO72p5+d3z3nNlS0YfCHHrB2AgI9an9bgQneL
        b86al+EtRR2qiZ/m7uID8VX33AJGLpncAgvjSvIT2maWjvvSTis1PzRbyeTWsZ3R7qG7DiZu
        9GQbzDtuHj/HeyopfTjv40Xq9PxvirXbMnADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsVy+t/xe7r6/sqxBvv2MVpsnLGe1eL6l+es
        FvOPnGO16Nv3n9Gi//FrZovz5zewW5xtesNusenxNVaLy7vmsFl87j3CaDHj/D4mi7VH7rJb
        LL1+kcniduMKNos3P84yWbTuPcJu8e/aRhaLzQ+OsTkIeayZt4bRY9OqTjaPzUvqPQ6+28Pk
        0bdlFaPH8RvbmTw+b5ILYI/SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3
        s0lJzcksSy3St0vQy3i0/ChTwTXuiqkfp7A1MD7k7GLk5JAQMJHY1nuLsYuRi0NIYCmjRMv6
        V8wQCWmJxtOrmSBsYYk/17rYIIo+MUqc/72EBSTBJqAqsWXGS3YQW0RAWWLyvenMIEXMAp2s
        EiueHGEDSQgLOEpMbtjLCmKzADXcnTkRyObg4BVwkVg9wQligbxE547dYDM5BVwljjyexwhi
        CwGVrLs8BewIXgFBiZMzn4DVMAPVN2+dzTyBUWAWktQsJKkFjEyrGEVSS4tz03OLjfSKE3OL
        S/PS9ZLzczcxAqNy27GfW3Ywdr0LPsQowMGoxMPLIacUK8SaWFZcmXuIUYKDWUmEd5+7cqwQ
        b0piZVVqUX58UWlOavEhRlOgHyYyS4km5wMTRl5JvKGpobmFpaG5sbmxmYWSOG+HwMEYIYH0
        xJLU7NTUgtQimD4mDk6pBsaqG6o+aov5H/eGOu2PPPffwPa3hV7shh+vqiy+R/ysfeEX/Clg
        T2EBl3r0nG1HuXb//PLvcfULO/7lO/5nNjz+PDNS2GNffJytUzD79hdsJU5zP+42FNsfa+Xw
        vPTImr8H+bwfvz3Y47w84sZ8FdPyAz9d7Case79XttfC7rfsBMGdzWIba+qVWIozEg21mIuK
        EwGIHphj4AIAAA==
X-CMS-MailID: 20190708141159eucas1p1751506975ff96a436e14940916623722
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190708141159eucas1p1751506975ff96a436e14940916623722
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190708141159eucas1p1751506975ff96a436e14940916623722
References: <20190708141140.24379-1-k.konieczny@partner.samsung.com>
        <CGME20190708141159eucas1p1751506975ff96a436e14940916623722@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Kamil Konieczny <k.konieczny@partner.samsung.com>

Add enable regulators to dev_pm_opp_set_regulators() and disable
regulators to dev_pm_opp_put_regulators(). This prepares for
converting exynos-bus devfreq driver to use dev_pm_opp_set_rate().

Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
---
 drivers/opp/core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 0e7703fe733f..947cac452854 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1580,8 +1580,19 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
 	if (ret)
 		goto free_regulators;
 
+	for (i = 0; i < opp_table->regulator_count; i++) {
+		ret = regulator_enable(opp_table->regulators[i]);
+		if (ret < 0)
+			goto disable;
+	}
+
 	return opp_table;
 
+disable:
+	while (i != 0)
+		regulator_disable(opp_table->regulators[--i]);
+
+	i = opp_table->regulator_count;
 free_regulators:
 	while (i != 0)
 		regulator_put(opp_table->regulators[--i]);
@@ -1609,6 +1620,8 @@ void dev_pm_opp_put_regulators(struct opp_table *opp_table)
 
 	/* Make sure there are no concurrent readers while updating opp_table */
 	WARN_ON(!list_empty(&opp_table->opp_list));
+	for (i = opp_table->regulator_count - 1; i >= 0; i--)
+		regulator_disable(opp_table->regulators[i]);
 
 	for (i = opp_table->regulator_count - 1; i >= 0; i--)
 		regulator_put(opp_table->regulators[i]);
-- 
2.22.0

