Return-Path: <linux-pm+bounces-22435-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2122BA3C163
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 15:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAE8117AF9C
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 14:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5F51F5833;
	Wed, 19 Feb 2025 14:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QtqvtnFY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A558D1F419B
	for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2025 14:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739973785; cv=none; b=SktgoeNXmr4UH6ios54N/SqQznOJbL+v+sc6+V2bJcesmSrUwAIdCu3pruRq4hY5COHaFb2fEMyF52UYjk3+sqaeL1SqWGvsp4vsjpI8YaT+uSM4T6ZF1osDPH4ApJyyNtYYTwULOlZ0CtJ3W60k5lKiFs3lp+PMi31/ZQOZMWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739973785; c=relaxed/simple;
	bh=IWGXuffalkQUnXAiLADUGfTCXoWyGC8Nua9zNIZpmIs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=IekL+65E2DyhvbQDzCmhvSrL53toeJvA24q+mFX0hB4dsPFerQqwGAA+bvvdnunKN8As+Kwet5B0768P5teYOz8F71fHP09CkTU4gqR0rbEV8rE1eFC4m/4Ct7TKW/6PpfGWu3/ro4dUe3CLrJk4nKVKI632wouiKAOx/4YZZcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=QtqvtnFY; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250219140301euoutp02670a54c59842f406a3daf8ab23896dac~loO9m9uyS0177801778euoutp02U
	for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2025 14:03:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250219140301euoutp02670a54c59842f406a3daf8ab23896dac~loO9m9uyS0177801778euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739973781;
	bh=VhIBCc+eKDxBLZw1Fq8aGXRrjbktqWvu0yroBIpoWCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QtqvtnFYwyEjWCpB/aTTEFqRukQHZ1wbAgp4qwshb81rAQeWZlRTMlgCTLuDiJwTe
	 gtJD2bqpCltpX486FBlSVPTai7Gtvj3SEqlzeEIlKLtkdjfE2hny9yec20/vK5xnDv
	 N1SC1Wh43dkRjc0grO2OwNnYj5VLZOfxZR7xjKVg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250219140300eucas1p10673706f31abf0063f75ac8bec96ceee~loO9PTq4s1048910489eucas1p1D;
	Wed, 19 Feb 2025 14:03:00 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 88.01.20409.494E5B76; Wed, 19
	Feb 2025 14:03:00 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250219140300eucas1p2d776e747555020fd868cf04e55cd70e1~loO80IMaq2656926569eucas1p2i;
	Wed, 19 Feb 2025 14:03:00 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250219140300eusmtrp215d846debea0e10fa293350e96f7d1bd~loO8zRJaS2432224322eusmtrp2s;
	Wed, 19 Feb 2025 14:03:00 +0000 (GMT)
X-AuditID: cbfec7f4-5f9ce24000004fb9-09-67b5e494de70
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id D5.52.19654.494E5B76; Wed, 19
	Feb 2025 14:03:00 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250219140258eusmtip20b7b6f2d7823b1bc2d6da0c2539abae2~loO7fks-02874228742eusmtip2U;
	Wed, 19 Feb 2025 14:02:58 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com, guoren@kernel.org,
	wefu@redhat.com, jassisinghbrar@gmail.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, frank.binns@imgtec.com,
	matt.coster@imgtec.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	ulf.hansson@linaro.org, jszhang@kernel.org, p.zabel@pengutronix.de,
	m.szyprowski@samsung.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org, Michal Wilczynski
	<m.wilczynski@samsung.com>
Subject: [PATCH v5 08/21] clk: thead: Add support for custom ops in
 CCU_GATE_CLK_OPS macro
Date: Wed, 19 Feb 2025 15:02:26 +0100
Message-Id: <20250219140239.1378758-9-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219140239.1378758-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTZxTG9957e++lUnapbrxjbsw652YUlBnzJuLGhpobTczmxpwGNxu5
	KwQorIUx9yEySgesOGpYDAWsIJOCQwTaDojAqEjBj1ootLBINQIRGNgVcB9MZZSLm/895znP
	eX/nJC+Ni38mg+l4eSqnkEsTJaSQMHf+fWND4YhJtrHk0quoy1WOIdM/Ogr91GLDkL7DJkDu
	XiOG+u57SHR+1E6hsZZMAjkNpRTK6qwl0bjOTSKvxi1AjuYSEs3kdwBknlGRqKZjiEK19/UY
	KvOaCFTR2AyQOvesAPVc2YGG3F0EGndocKTWPY3mLzZS6JGzjkDF99ooZJzUCpC1Zh9StRUS
	kS+ynoFsip0cHyfYSzmzFNvyx2mCbdINUaym6Rpg66tzSfam8yLJnup+l731nRVjGyoyWFVN
	J8Z+/3Aj62ntJ9njxmrA9ma5qHfEB4QRsVxi/GecIuyNQ8K49mvn8BTDM5+fdZYTx0BtYB7w
	oyGzGerOd4E8IKTFjAFA71Q5xhezAPZmVuB8MQOgWa/FH49Yvh0m+EYlgO0FgyRfTAL4V9YZ
	ypcimXB4u1Iv8DVWMNkEzL6cuUjBmbsLb42UkL7UciYGthSfEPg0wayBD0o7Fxki5k2o0cwS
	PC8EtrVfX/Bp2o+JhK09wXwkEHYXjSxG8IVIlql4cVfI1Ahha0mOgJ/dDvuqbEt6OZywGile
	r4TzTXqM18nwtml66bavYJPGuqS3wpu2OdLHxZnXYG1zGG+/BfsLVZTPhkwAHJgK5FcIgCfM
	J3HeFsEctZhPvwJ/0OT/B7UZzEtQFk7bZ0ABWKV74hjdE8fo/ueeBng1COLSlEkyThku59JD
	ldIkZZpcFno4OakeLPztq4+ss42gcsIbagEYDSwA0rhkhUidYZSJRbHSI19wiuSPFWmJnNIC
	nqcJSZCovC1bJmZk0lQugeNSOMXjLkb7BR/Dtv2y8pzKP6p2T9KvyoPzr8MYuomNJprFL6e4
	PNvlBOY+Om2fWy9yumIDUmTH2+uetZ254d3vqBrw7i4WvvR72eE7e2PVu4rcssjLWMP+qGWl
	Bd096FPWo3WxE/FHlY5N69Jz66+uNtjVU2tvBSXYD/oHYWkfBT+Mjtnz9ftHDuSL74Q/8EoD
	hgfnVIaIZek7T2nT6xyOntX6LfOHtE+N3k19TzC8LxPFjXWGvdDnGYyS926I/2DrljHOFR0x
	GRI3bln1YULRbw2jxcyP5t3X+6/s3UFsu5D1tvxCf0jqTrEt916ENS/Zv7ynak2e67mRwoFP
	/lzbJUnLiF6/mSub/KbsSwmhjJNuWocrlNJ/Aa/eXvlKBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsVy+t/xe7pTnmxNN/i5jNPixPVFTBZbf89i
	t1iz9xyTxfwj51gt7l3awmRx5et7Not1Ty+wW7zY28hicW3FXHaL5mPr2SxezrrHZvGx5x6r
	xeVdc9gsPvceYbTY9rmFzWLtkbvsFuu/zmeyWPhxK4vFkh27GC3aOpexWlw85Wpx994JFouX
	l3uYLdpm8Vv837OD3eLftY0sFrPf7We32PJmIqvF8bXhFi37p7A4yHm8v9HK7vHm5UsWj8Md
	X9g99n5bwOKxc9Zddo+enWcYPTat6mTzuHNtD5vHvJOBHve7jzN5bF5S79Gy9hiTR/9fA4/3
	+66yefRtWcXocan5OnuAUJSeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6d
	TUpqTmZZapG+XYJexsEzq5kLVohWLLu2iKWBcb1gFyMnh4SAicSh9scsXYxcHEICSxklHu14
	zwSRkJG41v2SBcIWlvhzrYsNougVo8S0vxfAitgEjCQeLJ/PCmKLCCxmkdi7rxKkiFngLaPE
	9ZkbwbqFBaIkGt59YwSxWQRUJf7MPcYMYvMK2Ev09HyB2iAvsf/gWaA4BwengIPEvotSIGEh
	oJJzffdZIcoFJU7OfAJWzgxU3rx1NvMERoFZSFKzkKQWMDKtYhRJLS3OTc8tNtIrTswtLs1L
	10vOz93ECEwv24793LKDceWrj3qHGJk4GA8xSnAwK4nwttVvSRfiTUmsrEotyo8vKs1JLT7E
	aAp09kRmKdHkfGCCyyuJNzQzMDU0MbM0MLU0M1YS52W7cj5NSCA9sSQ1OzW1ILUIpo+Jg1Oq
	gWktt+52j0Nuk3RETWtzJtwTNzohnOHu8POyArMb4yl+sTdWh1oLa1dcnLK89OGKposPNvGm
	3Pu3PCB4VW+b/9zdX877b1ympXvtc9Myk+W6krG5CbOtNY30dmf2nkkuPf30AOf6gF/nn/75
	XCHQmSl8PDPaWHLn9CdOR4+dCVp2abrYejkZFcuynunu25t6V+7oW7Kq/nX3ynSrhZn1R9oi
	eAtia2yON+u/kNUKLr20r+b5oa2JC2ZJ3OTi2Jr5KMU+LbLfwepH3BnbPZf369i6/p3vtLNg
	gz4j50eFKUli3nqquq93/m3fu/i07Ot7Lf7O0uazFyY4z7xYqPDA0mf/NBPW4KysmKDonh3p
	1kosxRmJhlrMRcWJACbtxqC4AwAA
X-CMS-MailID: 20250219140300eucas1p2d776e747555020fd868cf04e55cd70e1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250219140300eucas1p2d776e747555020fd868cf04e55cd70e1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250219140300eucas1p2d776e747555020fd868cf04e55cd70e1
References: <20250219140239.1378758-1-m.wilczynski@samsung.com>
	<CGME20250219140300eucas1p2d776e747555020fd868cf04e55cd70e1@eucas1p2.samsung.com>

The IMG Rogue GPU requires three clocks: core, sys, and mem [1]. On the
T-HEAD TH1520 SoC, the mem clock gate is marked as "Reserved" in the
hardware manual (section 4.4.2.6.1) [2] and cannot be configured.

Add a new CCU_GATE_CLK_OPS macro that allows specifying custom clock
operations. This enables us to use nop operations for the mem clock,
preventing the driver from attempting to enable/disable this reserved
clock gate.

Link: https://lore.kernel.org/all/2fe3d93f-62ac-4439-ac17-d81137f6410a@imgtec.com [1]
Link: https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH1520%20System%20User%20Manual.pdf [2]

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/clk/thead/clk-th1520-ap.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
index 57972589f120..ea96d007aecd 100644
--- a/drivers/clk/thead/clk-th1520-ap.c
+++ b/drivers/clk/thead/clk-th1520-ap.c
@@ -89,6 +89,21 @@ struct ccu_pll {
 		}							\
 	}
 
+#define CCU_GATE_CLK_OPS(_clkid, _struct, _name, _parent, _reg, _gate, _flags,	\
+			 _clk_ops)						\
+	struct ccu_gate _struct = {						\
+		.enable	= _gate,						\
+		.common	= {							\
+			.clkid		= _clkid,				\
+			.cfg0		= _reg,					\
+			.hw.init	= CLK_HW_INIT_PARENTS_DATA(		\
+						_name,				\
+						_parent,			\
+						&_clk_ops,			\
+						_flags),			\
+		}								\
+	}
+
 static inline struct ccu_common *hw_to_ccu_common(struct clk_hw *hw)
 {
 	return container_of(hw, struct ccu_common, hw);
@@ -847,6 +862,11 @@ static CCU_GATE(CLK_SRAM1, sram1_clk, "sram1", axi_aclk_pd, 0x20c, BIT(3), 0);
 static CCU_GATE(CLK_SRAM2, sram2_clk, "sram2", axi_aclk_pd, 0x20c, BIT(2), 0);
 static CCU_GATE(CLK_SRAM3, sram3_clk, "sram3", axi_aclk_pd, 0x20c, BIT(1), 0);
 
+static const struct clk_ops clk_nop_ops = {};
+
+static CCU_GATE_CLK_OPS(CLK_GPU_MEM, gpu_mem_clk, "gpu-mem-clk",
+			video_pll_clk_pd, 0x0, BIT(2), 0, clk_nop_ops);
+
 static CCU_GATE(CLK_AXI4_VO_ACLK, axi4_vo_aclk, "axi4-vo-aclk",
 		video_pll_clk_pd, 0x0, BIT(0), 0);
 static CCU_GATE(CLK_GPU_CORE, gpu_core_clk, "gpu-core-clk", video_pll_clk_pd,
@@ -1205,6 +1225,12 @@ static int th1520_clk_probe(struct platform_device *pdev)
 		ret = devm_clk_hw_register(dev, &emmc_sdio_ref_clk.hw);
 		if (ret)
 			return ret;
+	} else if (plat_data == &th1520_vo_platdata) {
+		ret = devm_clk_hw_register(dev, &gpu_mem_clk.common.hw);
+		if (ret)
+			return ret;
+		gpu_mem_clk.common.map = map;
+		priv->hws[CLK_GPU_MEM] = &gpu_mem_clk.common.hw;
 	}
 
 	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, priv);
-- 
2.34.1


