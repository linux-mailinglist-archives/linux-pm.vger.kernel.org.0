Return-Path: <linux-pm+bounces-18457-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5459E1DDE
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 14:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF087282D73
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 13:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FC31F4705;
	Tue,  3 Dec 2024 13:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="U5d1BHZK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E881F4276
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 13:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733233323; cv=none; b=WZloiQ6zQj7GjO4iXEW5x/JW5sdIMqVF4rMZ779hlDHzrVcbR/XpZrUlngVIaKYkYffSXzbAm/GoBJydt70pxwJs1jlz9kcnKm9MhtuRr7TWkMfyY1v3KRFLn+rnd1fJ6KUMm3WmRkyl9wOKbsRfsXsDDEUWbOMkj5RQLf4agX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733233323; c=relaxed/simple;
	bh=ezUoqy9EyI7rlqtGoj2nKxRNVdz0UudgIDnN7YVZeeg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=Ne0bEgvC7YAAy2ti8fQddfJHAzGRWKdG+oMHJUtpjlHlsRLH/EVlOWOqRQocaC3hxGCgkcpZd0z7WMvuA/gX8zbq14cvt1neupjp5m8fP9/m9c+7j30/njm/8PT2zodPUh+Mj53+W2+G179xzxD2KiiKpnXwgIJcRYQcsI/06cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=U5d1BHZK; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20241203134153euoutp014883803fd70d70d105804ef88d85eddf~NroQFlAL02570425704euoutp01E
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 13:41:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20241203134153euoutp014883803fd70d70d105804ef88d85eddf~NroQFlAL02570425704euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733233313;
	bh=a88yTuKc0U8ya5XZYE8bq3AQdSOHV1kDfujITRvdz+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U5d1BHZKJNrxvWKS37T6NyxZKQgiKL7c/D4nIHzWwwfTeEixx4fJhYbYQe+Yr6i7l
	 Mgys5OHwUwhA2Y2L4zDf+T243G4AV7QZhQNTjNnrX0222n6PGjB4FQSr/N7mCs8QDk
	 DtnaxxDqXklpHnERC6wtUdNxKQuWvhoDxklNvUeY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241203134153eucas1p2eb472062c8d3c2e55fd6c337a04d3931~NroPq-ZAP2017220172eucas1p24;
	Tue,  3 Dec 2024 13:41:53 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id B1.CA.20821.1AA0F476; Tue,  3
	Dec 2024 13:41:53 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241203134152eucas1p1ed480afaf4d7de3a4a706477e709b6fd~NroPMLKEF1743017430eucas1p1Z;
	Tue,  3 Dec 2024 13:41:52 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241203134152eusmtrp1e7991a53db793011b255982f7216e896~NroPLY6vw0888908889eusmtrp1-;
	Tue,  3 Dec 2024 13:41:52 +0000 (GMT)
X-AuditID: cbfec7f2-b11c470000005155-63-674f0aa166ca
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id A7.F6.19654.0AA0F476; Tue,  3
	Dec 2024 13:41:52 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241203134151eusmtip27b7ed05ed073adc14202b77624744963~NroN5kQhD2454624546eusmtip2J;
	Tue,  3 Dec 2024 13:41:51 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com, guoren@kernel.org,
	wefu@redhat.com, jassisinghbrar@gmail.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, frank.binns@imgtec.com,
	matt.coster@imgtec.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	ulf.hansson@linaro.org, jszhang@kernel.org, m.szyprowski@samsung.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org, Michal Wilczynski
	<m.wilczynski@samsung.com>
Subject: [RFC PATCH v1 03/14] clk: thead: Enable clock gates with regmaps
Date: Tue,  3 Dec 2024 14:41:26 +0100
Message-Id: <20241203134137.2114847-4-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203134137.2114847-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUxbVRz19r2+9+goe5QBN/vItHGLm5GBQb3TukFEfcwlMBOjMyyzgWcB
	+djasaFiYHwVunbZwII8mB0LgQ7GiAMaYDAGEkqtNNIhoJYPl46vMZGxjs4hCn1M99/5nd85
	95xfcilM0khsphJSTrDKFHmSlBDhpt5HtpcqRVGK4IUKCvUNXxKg5sccia502ATI0GMTojF7
	kwANuuYJdPXOTySa7jiNoyHjBRLl9DYQaIYbI9CCdkyIbrVVEGhR1wOQaTGXQPU9oyRqcBkE
	qHKhGUdVLW0A5RdWC9HAD2+jmVtaDOVzG9E/7S0kWhn6Dkflf3SSqGnuvBCZ6z9EuZ1f42Hb
	mPmRPJKZm5nBme8LHpBMx8OLONPKjZKMtvVHwFyrLSQYx1A7wXxrOcSMnzELmMaqTCa3vlfA
	zN/4mWDONtUCxp4zTDKN1i+jfT8WyeLYpISTrHLPvk9E8ct1Y+Sxe/7pRc6zeBb41VcDvChI
	h8Kp8/OkBogoCW0EsH7iDsEPDwB0j3M4PywC2FHiAE8s5Wo9xi9qALRWmwE/zAG45C7G1lQE
	/TKcqDEI1xab6LsYHHH94nkYo6cANDkriDWVHx0Jzbc78TWM0ztg9k2Dxy2m98PrY2oBn7cd
	dnb1e3gvOgze1WuEvMYXWsqcHi+2qslpLvd0gvRlEfx7anLdHAFHr+sJHvvBWXMTyeOt0Fqs
	xXmcCiea72M8zoCtWvM6fgM6bH+teqnVgF2woW0PT4fD5RWdh4a0Dxy558tX8IFFplKMp8Ww
	IF/Cq3dCvVb3X6jNaFovxkCjaQWcA89xTx3DPXUM93/uRYDVgkA2TZWsYFUhKeypIJU8WZWW
	ogiKTU2+Blb/tXXFfL8FXJhdCOoGAgp0A0hh0k3imob3FBJxnPzzL1hl6lFlWhKr6gZbKFwa
	KN4Rt52V0Ar5CfYzlj3GKp9sBZTX5ixBesCGug3905FH9C57b3/sufqlYPt+H82WjzTp3MBl
	Q5gutrw048/qaCedod6aFyTJVhmeeStzr4WKnq5YlG2McIZO2s90Hbzttxzjiq/MrDMe97aV
	uaNlXUfKuq68EuM+8Glf1tW5x3vVrpNGf0thuk7WGnHwcEHA4abEosTTD2XZR8eHh7x/35mQ
	ePwbqrqmLJJbuETcbGgf9I8wv4qV1Bz6rff5d194c9SRosiS5nUGB/o79O+HlHi7l2ILP/Dh
	1AeyvSfzrX2hrHhK/FXmLHWjCs2p9oVXWyrxXe+YTrW8GFW72/bsYPu2kWJTTH54qvO10vFH
	lihn/ECA3+uhfUYproqXh+zGlCr5vypymldGBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsVy+t/xe7oLuPzTDY4cUbE4cX0Rk8XW37PY
	LdbsPcdkMf/IOVaLe5e2MFlc+fqezWLd0wvsFi/2NrJYXFsxl92i+dh6NouXs+6xWXzsucdq
	cXnXHDaLz71HGC22fW5hs1h75C67xfqv85ksFn7cymKxZMcuRou2zmWsFhdPuVq8vNzDbNE2
	i9/i/54d7Bb/rm1ksZj9bj+7xZY3E1ktjq8Nt2jZP4XFQdbj/Y1Wdo83L1+yeBzu+MLusffb
	AhaPnbPusnv07DzD6LFpVSebx51re9g85p0M9LjffZzJY/OSeo+WtceYPN7vu8rm0bdlFaPH
	pebr7B6bT1cHCEbp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSW
	pRbp2yXoZfxZfY+94K1oxaQnfSwNjLcEuxg5OSQETCRmt09l7mLk4hASWMoosXr3JXaIhIzE
	te6XLBC2sMSfa11sEEWvGCU+7uxnBkmwCRhJPFg+nxUkISLQySLxdvNaRhCHWeAto8T1mRvB
	2oUFPCWOP9oPZrMIqEo0HZgP1s0rYC+x+147E8QKeYn9B8+CxTkFHCReT+1iBbGFgGp2/D3M
	ClEvKHFy5hOwOcxA9c1bZzNPYBSYhSQ1C0lqASPTKkaR1NLi3PTcYiO94sTc4tK8dL3k/NxN
	jMDEsu3Yzy07GFe++qh3iJGJg/EQowQHs5II7/L13ulCvCmJlVWpRfnxRaU5qcWHGE2B7p7I
	LCWanA9MbXkl8YZmBqaGJmaWBqaWZsZK4rxsV86nCQmkJ5akZqemFqQWwfQxcXBKNTDVhLqy
	PnWujjyx5UH0qmP3/z9clHzo2d37klkPy82alIWPK+85Mp9JfY1+zZScSyxm8r5MR2VY5gmX
	zuyvX/5T5I+Zs9qrDY/cM7W8DvB5WJ3+mfRV6dSiV6Iul48V8D34JmZ48nzczBexGx74Ti/4
	vmn1ZEbm30cvb1/DUTrx1Repexml13izD06cPikuK8/+Xlql8UbJlQxrjBnTAk5snrXozjXf
	qKeRFtcbOfSuKjlpz1f+wGkX18sWL77043P+TNMU+UlNDxZPCHKI3CPBKrDLqPL27CML+FIU
	jITW/KpJN+tZXccssOG5akkFs1hJUtmfRvctay3zvH/EbpgtqpsRkcRT/tvmY1xLbIkSS3FG
	oqEWc1FxIgBpGSjwtQMAAA==
X-CMS-MailID: 20241203134152eucas1p1ed480afaf4d7de3a4a706477e709b6fd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241203134152eucas1p1ed480afaf4d7de3a4a706477e709b6fd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241203134152eucas1p1ed480afaf4d7de3a4a706477e709b6fd
References: <20241203134137.2114847-1-m.wilczynski@samsung.com>
	<CGME20241203134152eucas1p1ed480afaf4d7de3a4a706477e709b6fd@eucas1p1.samsung.com>

The current implementation of the CCU_GATE macro assumes direct access
to memory-mapped registers, which isn't suitable when using regmaps for
register access. In the TH1520 SoC, the address space for the VO (Video
Output) subsystem clocks is shared with other control registers, such as
those used for resetting the GPU. To prevent conflicts and ensure
synchronized access, it's important to access these registers via a
regmap.

This patch updates the CCU_GATE macro to support regmap-based access by
reusing the clk_ops from the divider clocks (ccu_div_ops). This change
allows the clock gates to be controlled through regmap, enabling proper
synchronization when multiple components interact with the shared
address space.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/clk/thead/clk-th1520.c | 10 ++++++++--
 drivers/clk/thead/clk-th1520.h | 15 +++++++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/thead/clk-th1520.c b/drivers/clk/thead/clk-th1520.c
index e2bfe56de9af..3ada8b98bd8e 100644
--- a/drivers/clk/thead/clk-th1520.c
+++ b/drivers/clk/thead/clk-th1520.c
@@ -120,8 +120,14 @@ const struct clk_ops ccu_div_ops = {
 	.determine_rate = clk_hw_determine_rate_no_reparent,
 };
 
-static unsigned long th1520_pll_vco_recalc_rate(struct clk_hw *hw,
-						unsigned long parent_rate)
+const struct clk_ops ccu_gate_ops = {
+	.disable = ccu_div_disable,
+	.enable = ccu_div_enable,
+	.is_enabled = ccu_div_is_enabled,
+};
+
+unsigned long th1520_pll_vco_recalc_rate(struct clk_hw *hw,
+					 unsigned long parent_rate)
 {
 	struct ccu_pll *pll = hw_to_ccu_pll(hw);
 	unsigned long div, mul, frac;
diff --git a/drivers/clk/thead/clk-th1520.h b/drivers/clk/thead/clk-th1520.h
index 5d30f55e88a1..532afbbfea01 100644
--- a/drivers/clk/thead/clk-th1520.h
+++ b/drivers/clk/thead/clk-th1520.h
@@ -94,6 +94,20 @@ struct ccu_pll {
 		}							\
 	}
 
+#define CCU_GATE_REGMAP(_clkid, _struct, _name, _parent, _reg, _gate, _flags)	\
+	struct ccu_gate _struct = {						\
+		.enable	= _gate,						\
+		.common	= {							\
+			.clkid		= _clkid,				\
+			.cfg0		= _reg,					\
+			.hw.init	= CLK_HW_INIT_PARENTS_DATA(		\
+						_name,				\
+						_parent,			\
+						&ccu_gate_ops,			\
+						_flags),			\
+		}								\
+	}
+
 static inline struct ccu_common *hw_to_ccu_common(struct clk_hw *hw)
 {
 	return container_of(hw, struct ccu_common, hw);
@@ -130,5 +144,6 @@ static inline struct ccu_gate *hw_to_ccu_gate(struct clk_hw *hw)
 extern const struct clk_ops ccu_div_ops;
 extern const struct clk_ops clk_pll_ops;
 extern const struct regmap_config th1520_clk_regmap_config;
+extern const struct clk_ops ccu_gate_ops;
 
 #endif /* CLK_TH1520_H */
-- 
2.34.1


