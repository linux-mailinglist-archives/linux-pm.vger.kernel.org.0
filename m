Return-Path: <linux-pm+bounces-18456-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3903A9E1DDC
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 14:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7C0A1664A1
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 13:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE8C1F426F;
	Tue,  3 Dec 2024 13:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HeNOLIqk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A301F1305
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 13:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733233321; cv=none; b=RWxXtCSP4zmjdwngL6xdgYzFumuJ2jiIKgPhHfBX9/F0IiGDFKtD8ZlXk18gEexfNTnAsxcN/GQC0E6MuPBFqMsPDJeY5xBudtgoUTPX1dobqXJnT+Y58TrsDzAHZ2ITjeo42uwnl3BhmFXxCFr+t+pz5wZAo5JXFQkX+MoQL7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733233321; c=relaxed/simple;
	bh=0gOfd9dZt9MGufLYogl+fZTyCnDVj3RbDJk5/Sde4zI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=e2GSUqhYcEYa0GoYZ5NNSnYuXv/aFHuleGNEHzPlpJwVivPQn2w6c6pzl4NaVCnYIN9K2sTTr0zEIz4nDJ/+C/OfPtGLF/ltnQSQ3Ck1u3aHaemtmi+OyWWtJncjh0nefe3yw5jHMq+dFtGFCL0kcq+//J1KzxRKvvn9vmOfAMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=HeNOLIqk; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20241203134151euoutp0146ffb213954fb2be5e9633e7b8d887c7~NroN9arC_2554425544euoutp01O
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 13:41:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20241203134151euoutp0146ffb213954fb2be5e9633e7b8d887c7~NroN9arC_2554425544euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733233311;
	bh=An2FnGzhZlzxYk3d0KbYBPV10vyvjEv9yIWGJmCixm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HeNOLIqkLv/QP391hSBIUly3/90IicaVVj90K3Hz3OWDPmnlQMXps1dk8HiIXfL8P
	 GHOE+B6QcMp0W1xzKzl/TzwC8U05hphL4lITFjy2dRY4KPSt5GVd2HHnXO3+FX8t+H
	 UrYKRevC6ThyYc5gMVwWqEcCQcMMj9n+/S7lojdk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241203134150eucas1p25a85460ccafd9ed5d7d22b8d8d8ae598~NroNXDkru2018620186eucas1p26;
	Tue,  3 Dec 2024 13:41:50 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 26.51.20397.E9A0F476; Tue,  3
	Dec 2024 13:41:50 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241203134150eucas1p24ba8d2fbf2af5b8f9abe503b4334127d~NroM69Jq52020120201eucas1p2T;
	Tue,  3 Dec 2024 13:41:50 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241203134150eusmtrp1889f2361b76d63d4267f624abc7c4a20~NroMzQkh_0887308873eusmtrp1E;
	Tue,  3 Dec 2024 13:41:50 +0000 (GMT)
X-AuditID: cbfec7f5-ed1d670000004fad-25-674f0a9e7821
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 04.F6.19654.D9A0F476; Tue,  3
	Dec 2024 13:41:49 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241203134148eusmtip2682121417cbbd74031114cca8880e1e2~NroLd3eh02944429444eusmtip2M;
	Tue,  3 Dec 2024 13:41:48 +0000 (GMT)
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
Subject: [RFC PATCH v1 01/14] clk: thead: Refactor TH1520 clock driver to
 share common code
Date: Tue,  3 Dec 2024 14:41:24 +0100
Message-Id: <20241203134137.2114847-2-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203134137.2114847-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTZxjG951zes6hWdmh4PhWtjExlU1cccM/PoJuzEByEsy8bdmFyVbk
	rLIVMC0oDsIwYMOl6txgarmUzU46tCPKJUC4OEDKZZZLHdaARRgi5WqFOkXCRmnd/O/3vO/z
	fu/zJh+NC6tIER2fmMwpEqXyAJJP1HY87n2zlL9LtsUwtRF13vwZQzVPNBS61GTCkLbdxEPW
	gWoM3XDMk+i3u30Ummw6RqBBfQmFsjoqSWTTWElkV1t5yNxQTKKFE+0A1S5kk8jQfptClQ4t
	hn6y1xBIV9cAkCr3Ag/1d0cim1mNI5XmBfRPYx2FVgYvE6horoVC1TOnecho+AhltxQQ4a+w
	85bjFDtjsxFsW84ixTY9LCPYes1tilXX/wHYKxW5JDs82EiypV172JF8I8ZW6b5lsw0dGDvf
	/CfJnqyuAOxA1k2KrepJ2+31KX9bHCePP8wpgt/5gn8wq8uCHzKfAqlFTbO8TPAwOQ940JDZ
	Ch9M1xF5gE8LGT2AS6YyzCUWAey++MQtFgDs09qopyOLjlO4q1EO4NhFO+USMwA+ul9IOl0k
	8za8U67lORs+zDQOLY5bpFPgzD0Aa8eL11zezH44W5FLOJlgxNCsbVt9iqYFzLvwWuc+1zp/
	2PL7ddzJHkw4nC7M4zlZwHjBrnPja6P4qierpmgtEmQMfDhwxo65hiPgsGrMzd5wyljtvuFl
	2PODmnBxErxT8wB3cTqsVxvdHAaHTUukMw/OvAErG4Jd5fegbrEXd5Yh4wkts16uCJ7w+9oz
	7rIA5qiELvdGWKg+8d9Sk77WHYaFjZdmiO/Aes0zx2ieOUbz/94ygFcAXy5FmSDjlCGJ3BGJ
	UpqgTEmUSQ4kJVwBq/+6Z8XoqAP6KbukFWA0aAWQxgN8BOWVUTKhIE569BtOkfS5IkXOKVuB
	H00E+ArEcf6ckJFJk7mvOe4Qp3jaxWgPUSaWF0Z6h4onr2X2X88/uaOezQlRJMRGhnslydal
	PyfP2DcRFLHSHSl8XOIf1duXKc7omchI9PbTtVyO3wtbz55vl7wafWD8qujq2baJ044dnRWG
	zft1oaYvR9OOf9X9t37bsBz7MfbFkZi5NPX2vSrVh7vSZ45a55TPlw7q9lhSrK+9dKN43V+e
	r/M+yJfGYH13d0Y13zc0TVZuTv1kZ1C+b2DI+qKs0ch7BSnBbOCGKfmy4H3xcqqw/5F5SM2Z
	o+mtPkMlksmI6GNBMaN9m27xw0b0hL/fhV9Cx46Ycj5On1vkfRYnFc1uKIhrHtLEWssCC7Z3
	FC0vNfdqDvfozm9ZNv4qCiCUB6VvbcIVSum/1LjqekYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsVy+t/xe7pzufzTDf48tbY4cX0Rk8XW37PY
	LdbsPcdkMf/IOVaLe5e2MFlc+fqezWLd0wvsFi/2NrJYXFsxl92i+dh6NouXs+6xWXzsucdq
	cXnXHDaLz71HGC22fW5hs1h75C67xfqv85ksFn7cymKxZMcuRou2zmWsFhdPuVq8vNzDbNE2
	i9/i/54d7Bb/rm1ksZj9bj+7xZY3E1ktjq8Nt2jZP4XFQdbj/Y1Wdo83L1+yeBzu+MLusffb
	AhaPnbPusnv07DzD6LFpVSebx51re9g85p0M9LjffZzJY/OSeo+WtceYPN7vu8rm0bdlFaPH
	pebr7B6bT1cHCEbp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSW
	pRbp2yXoZTSfvMFccLmfsWL23resDYzfSroYOTkkBEwkvnztZ+5i5OIQEljKKLFt1QoWiISM
	xLXul1C2sMSfa11sEEWvGCVO7H7CDJJgEzCSeLB8PitIQkSgk0Xi7ea1jCAOs8BbRonrMzeC
	tQsLREtMaVjLBmKzCKhKXJ5/mL2LkYODV8Be4uiJYIgN8hL7D54FG8op4CDxemoXK4gtBFSy
	4+9hMJtXQFDi5MwnYCOZgeqbt85mnsAoMAtJahaS1AJGplWMIqmlxbnpucVGesWJucWleel6
	yfm5mxiBiWXbsZ9bdjCufPVR7xAjEwfjIUYJDmYlEd7l673ThXhTEiurUovy44tKc1KLDzGa
	Ap09kVlKNDkfmNrySuINzQxMDU3MLA1MLc2MlcR52a6cTxMSSE8sSc1OTS1ILYLpY+LglGpg
	2tQ9od1WsPyQb2TF1y67re0vdv+ZLXyWY0nRavEr2UeDP1t/keAz+7NucUr8pYequfL/J8e2
	uGzWtQkJq9915mOb7GKf2vWPdBqlMicwlm1gPDCjT79S/OiPNdwhfDY/Hrn5n0uezZJu8yxE
	fSLXXdsP9YrZmeyXvaZZzFJ203gZv2CR0fTyKRN3p9duuqwr4210xHjqscfVJxdo/66/+jXh
	knCNeKKIs4i5HseFwkAXhuxz854wHOERkf7AMvv5v80mgo/XB/Lft+hPepngKvq2NFpyxd9i
	s0z7ZJWD23Y2f6t9G9OYuCNINSX/zhzVe1u69WNzdR14A3g9leMlPuwPazVXWp1VKP72hJwS
	S3FGoqEWc1FxIgAVcv9xtQMAAA==
X-CMS-MailID: 20241203134150eucas1p24ba8d2fbf2af5b8f9abe503b4334127d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241203134150eucas1p24ba8d2fbf2af5b8f9abe503b4334127d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241203134150eucas1p24ba8d2fbf2af5b8f9abe503b4334127d
References: <20241203134137.2114847-1-m.wilczynski@samsung.com>
	<CGME20241203134150eucas1p24ba8d2fbf2af5b8f9abe503b4334127d@eucas1p2.samsung.com>

The T-Head TH1520 SoC includes various clocks for different subsystems
like Application Processor (AP) and Video Output (VO) [1]. Currently, the
clock driver only implements AP clocks.

Since the programming interface for these clocks is identical across
subsystems, refactor the code to move common functions into
clk-th1520.c. This prepares the driver to support VO clocks by reducing
code duplication and improving maintainability.

No functional changes are introduced with this refactoring.

Link: https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH1520%20System%20User%20Manual.pdf [1]

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 MAINTAINERS                       |   2 +-
 drivers/clk/thead/Makefile        |   2 +-
 drivers/clk/thead/clk-th1520-ap.c | 301 +-----------------------------
 drivers/clk/thead/clk-th1520.c    | 188 +++++++++++++++++++
 drivers/clk/thead/clk-th1520.h    | 134 +++++++++++++
 5 files changed, 326 insertions(+), 301 deletions(-)
 create mode 100644 drivers/clk/thead/clk-th1520.c
 create mode 100644 drivers/clk/thead/clk-th1520.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 1e930c7a58b1..7c85abf1dd1e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20188,7 +20188,7 @@ F:	Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml
 F:	Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
 F:	Documentation/devicetree/bindings/pinctrl/thead,th1520-pinctrl.yaml
 F:	arch/riscv/boot/dts/thead/
-F:	drivers/clk/thead/clk-th1520-ap.c
+F:	drivers/clk/thead/
 F:	drivers/mailbox/mailbox-th1520.c
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
 F:	drivers/pinctrl/pinctrl-th1520.c
diff --git a/drivers/clk/thead/Makefile b/drivers/clk/thead/Makefile
index 7ee0bec1f251..d7cf88390b69 100644
--- a/drivers/clk/thead/Makefile
+++ b/drivers/clk/thead/Makefile
@@ -1,2 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_CLK_THEAD_TH1520_AP) += clk-th1520-ap.o
+obj-$(CONFIG_CLK_THEAD_TH1520_AP) += clk-th1520.o clk-th1520-ap.o
diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
index 17e32ae08720..a6015805b859 100644
--- a/drivers/clk/thead/clk-th1520-ap.c
+++ b/drivers/clk/thead/clk-th1520-ap.c
@@ -5,297 +5,9 @@
  *  Authors: Yangtao Li <frank.li@vivo.com>
  */
 
-#include <dt-bindings/clock/thead,th1520-clk-ap.h>
-#include <linux/bitfield.h>
-#include <linux/clk-provider.h>
-#include <linux/device.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/regmap.h>
-
-#define TH1520_PLL_POSTDIV2	GENMASK(26, 24)
-#define TH1520_PLL_POSTDIV1	GENMASK(22, 20)
-#define TH1520_PLL_FBDIV	GENMASK(19, 8)
-#define TH1520_PLL_REFDIV	GENMASK(5, 0)
-#define TH1520_PLL_BYPASS	BIT(30)
-#define TH1520_PLL_DSMPD	BIT(24)
-#define TH1520_PLL_FRAC		GENMASK(23, 0)
-#define TH1520_PLL_FRAC_BITS    24
-
-struct ccu_internal {
-	u8	shift;
-	u8	width;
-};
-
-struct ccu_div_internal {
-	u8	shift;
-	u8	width;
-	u32	flags;
-};
-
-struct ccu_common {
-	int		clkid;
-	struct regmap	*map;
-	u16		cfg0;
-	u16		cfg1;
-	struct clk_hw	hw;
-};
-
-struct ccu_mux {
-	struct ccu_internal	mux;
-	struct ccu_common	common;
-};
-
-struct ccu_gate {
-	u32			enable;
-	struct ccu_common	common;
-};
-
-struct ccu_div {
-	u32			enable;
-	struct ccu_div_internal	div;
-	struct ccu_internal	mux;
-	struct ccu_common	common;
-};
-
-struct ccu_pll {
-	struct ccu_common	common;
-};
-
-#define TH_CCU_ARG(_shift, _width)					\
-	{								\
-		.shift	= _shift,					\
-		.width	= _width,					\
-	}
-
-#define TH_CCU_DIV_FLAGS(_shift, _width, _flags)			\
-	{								\
-		.shift	= _shift,					\
-		.width	= _width,					\
-		.flags	= _flags,					\
-	}
-
-#define CCU_GATE(_clkid, _struct, _name, _parent, _reg, _gate, _flags)	\
-	struct ccu_gate _struct = {					\
-		.enable	= _gate,					\
-		.common	= {						\
-			.clkid		= _clkid,			\
-			.cfg0		= _reg,				\
-			.hw.init	= CLK_HW_INIT_PARENTS_DATA(	\
-						_name,			\
-						_parent,		\
-						&clk_gate_ops,		\
-						_flags),		\
-		}							\
-	}
-
-static inline struct ccu_common *hw_to_ccu_common(struct clk_hw *hw)
-{
-	return container_of(hw, struct ccu_common, hw);
-}
-
-static inline struct ccu_mux *hw_to_ccu_mux(struct clk_hw *hw)
-{
-	struct ccu_common *common = hw_to_ccu_common(hw);
-
-	return container_of(common, struct ccu_mux, common);
-}
-
-static inline struct ccu_pll *hw_to_ccu_pll(struct clk_hw *hw)
-{
-	struct ccu_common *common = hw_to_ccu_common(hw);
+#include "clk-th1520.h"
 
-	return container_of(common, struct ccu_pll, common);
-}
-
-static inline struct ccu_div *hw_to_ccu_div(struct clk_hw *hw)
-{
-	struct ccu_common *common = hw_to_ccu_common(hw);
-
-	return container_of(common, struct ccu_div, common);
-}
-
-static inline struct ccu_gate *hw_to_ccu_gate(struct clk_hw *hw)
-{
-	struct ccu_common *common = hw_to_ccu_common(hw);
-
-	return container_of(common, struct ccu_gate, common);
-}
-
-static u8 ccu_get_parent_helper(struct ccu_common *common,
-				struct ccu_internal *mux)
-{
-	unsigned int val;
-	u8 parent;
-
-	regmap_read(common->map, common->cfg0, &val);
-	parent = val >> mux->shift;
-	parent &= GENMASK(mux->width - 1, 0);
-
-	return parent;
-}
-
-static int ccu_set_parent_helper(struct ccu_common *common,
-				 struct ccu_internal *mux,
-				 u8 index)
-{
-	return regmap_update_bits(common->map, common->cfg0,
-			GENMASK(mux->width - 1, 0) << mux->shift,
-			index << mux->shift);
-}
-
-static void ccu_disable_helper(struct ccu_common *common, u32 gate)
-{
-	if (!gate)
-		return;
-	regmap_update_bits(common->map, common->cfg0,
-			   gate, ~gate);
-}
-
-static int ccu_enable_helper(struct ccu_common *common, u32 gate)
-{
-	unsigned int val;
-	int ret;
-
-	if (!gate)
-		return 0;
-
-	ret = regmap_update_bits(common->map, common->cfg0, gate, gate);
-	regmap_read(common->map, common->cfg0, &val);
-	return ret;
-}
-
-static int ccu_is_enabled_helper(struct ccu_common *common, u32 gate)
-{
-	unsigned int val;
-
-	if (!gate)
-		return true;
-
-	regmap_read(common->map, common->cfg0, &val);
-	return val & gate;
-}
-
-static unsigned long ccu_div_recalc_rate(struct clk_hw *hw,
-					 unsigned long parent_rate)
-{
-	struct ccu_div *cd = hw_to_ccu_div(hw);
-	unsigned long rate;
-	unsigned int val;
-
-	regmap_read(cd->common.map, cd->common.cfg0, &val);
-	val = val >> cd->div.shift;
-	val &= GENMASK(cd->div.width - 1, 0);
-	rate = divider_recalc_rate(hw, parent_rate, val, NULL,
-				   cd->div.flags, cd->div.width);
-
-	return rate;
-}
-
-static u8 ccu_div_get_parent(struct clk_hw *hw)
-{
-	struct ccu_div *cd = hw_to_ccu_div(hw);
-
-	return ccu_get_parent_helper(&cd->common, &cd->mux);
-}
-
-static int ccu_div_set_parent(struct clk_hw *hw, u8 index)
-{
-	struct ccu_div *cd = hw_to_ccu_div(hw);
-
-	return ccu_set_parent_helper(&cd->common, &cd->mux, index);
-}
-
-static void ccu_div_disable(struct clk_hw *hw)
-{
-	struct ccu_div *cd = hw_to_ccu_div(hw);
-
-	ccu_disable_helper(&cd->common, cd->enable);
-}
-
-static int ccu_div_enable(struct clk_hw *hw)
-{
-	struct ccu_div *cd = hw_to_ccu_div(hw);
-
-	return ccu_enable_helper(&cd->common, cd->enable);
-}
-
-static int ccu_div_is_enabled(struct clk_hw *hw)
-{
-	struct ccu_div *cd = hw_to_ccu_div(hw);
-
-	return ccu_is_enabled_helper(&cd->common, cd->enable);
-}
-
-static const struct clk_ops ccu_div_ops = {
-	.disable	= ccu_div_disable,
-	.enable		= ccu_div_enable,
-	.is_enabled	= ccu_div_is_enabled,
-	.get_parent	= ccu_div_get_parent,
-	.set_parent	= ccu_div_set_parent,
-	.recalc_rate	= ccu_div_recalc_rate,
-	.determine_rate	= clk_hw_determine_rate_no_reparent,
-};
-
-static unsigned long th1520_pll_vco_recalc_rate(struct clk_hw *hw,
-						unsigned long parent_rate)
-{
-	struct ccu_pll *pll = hw_to_ccu_pll(hw);
-	unsigned long div, mul, frac;
-	unsigned int cfg0, cfg1;
-	u64 rate = parent_rate;
-
-	regmap_read(pll->common.map, pll->common.cfg0, &cfg0);
-	regmap_read(pll->common.map, pll->common.cfg1, &cfg1);
-
-	mul = FIELD_GET(TH1520_PLL_FBDIV, cfg0);
-	div = FIELD_GET(TH1520_PLL_REFDIV, cfg0);
-	if (!(cfg1 & TH1520_PLL_DSMPD)) {
-		mul <<= TH1520_PLL_FRAC_BITS;
-		frac = FIELD_GET(TH1520_PLL_FRAC, cfg1);
-		mul += frac;
-		div <<= TH1520_PLL_FRAC_BITS;
-	}
-	rate = parent_rate * mul;
-	rate = rate / div;
-	return rate;
-}
-
-static unsigned long th1520_pll_postdiv_recalc_rate(struct clk_hw *hw,
-						    unsigned long parent_rate)
-{
-	struct ccu_pll *pll = hw_to_ccu_pll(hw);
-	unsigned long div, rate = parent_rate;
-	unsigned int cfg0, cfg1;
-
-	regmap_read(pll->common.map, pll->common.cfg0, &cfg0);
-	regmap_read(pll->common.map, pll->common.cfg1, &cfg1);
-
-	if (cfg1 & TH1520_PLL_BYPASS)
-		return rate;
-
-	div = FIELD_GET(TH1520_PLL_POSTDIV1, cfg0) *
-	      FIELD_GET(TH1520_PLL_POSTDIV2, cfg0);
-
-	rate = rate / div;
-
-	return rate;
-}
-
-static unsigned long ccu_pll_recalc_rate(struct clk_hw *hw,
-					 unsigned long parent_rate)
-{
-	unsigned long rate = parent_rate;
-
-	rate = th1520_pll_vco_recalc_rate(hw, rate);
-	rate = th1520_pll_postdiv_recalc_rate(hw, rate);
-
-	return rate;
-}
-
-static const struct clk_ops clk_pll_ops = {
-	.recalc_rate	= ccu_pll_recalc_rate,
-};
+#define NR_CLKS	(CLK_UART_SCLK + 1)
 
 static const struct clk_parent_data osc_24m_clk[] = {
 	{ .index = 0 }
@@ -956,15 +668,6 @@ static struct ccu_common *th1520_gate_clks[] = {
 	&sram3_clk.common,
 };
 
-#define NR_CLKS	(CLK_UART_SCLK + 1)
-
-static const struct regmap_config th1520_clk_regmap_config = {
-	.reg_bits = 32,
-	.val_bits = 32,
-	.reg_stride = 4,
-	.fast_io = true,
-};
-
 static int th1520_clk_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
diff --git a/drivers/clk/thead/clk-th1520.c b/drivers/clk/thead/clk-th1520.c
new file mode 100644
index 000000000000..e2bfe56de9af
--- /dev/null
+++ b/drivers/clk/thead/clk-th1520.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
+ * Copyright (C) 2023 Vivo Communication Technology Co. Ltd.
+ *  Authors: Yangtao Li <frank.li@vivo.com>
+ */
+
+#include "clk-th1520.h"
+
+static u8 ccu_get_parent_helper(struct ccu_common *common,
+				struct ccu_internal *mux)
+{
+	unsigned int val;
+	u8 parent;
+
+	regmap_read(common->map, common->cfg0, &val);
+	parent = val >> mux->shift;
+	parent &= GENMASK(mux->width - 1, 0);
+
+	return parent;
+}
+
+static int ccu_set_parent_helper(struct ccu_common *common,
+				 struct ccu_internal *mux, u8 index)
+{
+	return regmap_update_bits(common->map, common->cfg0,
+				  GENMASK(mux->width - 1, 0) << mux->shift,
+				  index << mux->shift);
+}
+
+static void ccu_disable_helper(struct ccu_common *common, u32 gate)
+{
+	if (!gate)
+		return;
+	regmap_update_bits(common->map, common->cfg0, gate, ~gate);
+}
+
+static int ccu_enable_helper(struct ccu_common *common, u32 gate)
+{
+	unsigned int val;
+	int ret;
+
+	if (!gate)
+		return 0;
+
+	ret = regmap_update_bits(common->map, common->cfg0, gate, gate);
+	regmap_read(common->map, common->cfg0, &val);
+	return ret;
+}
+
+static int ccu_is_enabled_helper(struct ccu_common *common, u32 gate)
+{
+	unsigned int val;
+
+	if (!gate)
+		return true;
+
+	regmap_read(common->map, common->cfg0, &val);
+	return val & gate;
+}
+
+static unsigned long ccu_div_recalc_rate(struct clk_hw *hw,
+					 unsigned long parent_rate)
+{
+	struct ccu_div *cd = hw_to_ccu_div(hw);
+	unsigned long rate;
+	unsigned int val;
+
+	regmap_read(cd->common.map, cd->common.cfg0, &val);
+	val = val >> cd->div.shift;
+	val &= GENMASK(cd->div.width - 1, 0);
+	rate = divider_recalc_rate(hw, parent_rate, val, NULL, cd->div.flags,
+				   cd->div.width);
+
+	return rate;
+}
+
+static u8 ccu_div_get_parent(struct clk_hw *hw)
+{
+	struct ccu_div *cd = hw_to_ccu_div(hw);
+
+	return ccu_get_parent_helper(&cd->common, &cd->mux);
+}
+
+static int ccu_div_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct ccu_div *cd = hw_to_ccu_div(hw);
+
+	return ccu_set_parent_helper(&cd->common, &cd->mux, index);
+}
+
+static void ccu_div_disable(struct clk_hw *hw)
+{
+	struct ccu_div *cd = hw_to_ccu_div(hw);
+
+	ccu_disable_helper(&cd->common, cd->enable);
+}
+
+static int ccu_div_enable(struct clk_hw *hw)
+{
+	struct ccu_div *cd = hw_to_ccu_div(hw);
+
+	return ccu_enable_helper(&cd->common, cd->enable);
+}
+
+static int ccu_div_is_enabled(struct clk_hw *hw)
+{
+	struct ccu_div *cd = hw_to_ccu_div(hw);
+
+	return ccu_is_enabled_helper(&cd->common, cd->enable);
+}
+
+const struct clk_ops ccu_div_ops = {
+	.disable = ccu_div_disable,
+	.enable = ccu_div_enable,
+	.is_enabled = ccu_div_is_enabled,
+	.get_parent = ccu_div_get_parent,
+	.set_parent = ccu_div_set_parent,
+	.recalc_rate = ccu_div_recalc_rate,
+	.determine_rate = clk_hw_determine_rate_no_reparent,
+};
+
+static unsigned long th1520_pll_vco_recalc_rate(struct clk_hw *hw,
+						unsigned long parent_rate)
+{
+	struct ccu_pll *pll = hw_to_ccu_pll(hw);
+	unsigned long div, mul, frac;
+	unsigned int cfg0, cfg1;
+	u64 rate = parent_rate;
+
+	regmap_read(pll->common.map, pll->common.cfg0, &cfg0);
+	regmap_read(pll->common.map, pll->common.cfg1, &cfg1);
+
+	mul = FIELD_GET(TH1520_PLL_FBDIV, cfg0);
+	div = FIELD_GET(TH1520_PLL_REFDIV, cfg0);
+	if (!(cfg1 & TH1520_PLL_DSMPD)) {
+		mul <<= TH1520_PLL_FRAC_BITS;
+		frac = FIELD_GET(TH1520_PLL_FRAC, cfg1);
+		mul += frac;
+		div <<= TH1520_PLL_FRAC_BITS;
+	}
+	rate = parent_rate * mul;
+	rate = rate / div;
+	return rate;
+}
+
+static unsigned long th1520_pll_postdiv_recalc_rate(struct clk_hw *hw,
+						    unsigned long parent_rate)
+{
+	struct ccu_pll *pll = hw_to_ccu_pll(hw);
+	unsigned long div, rate = parent_rate;
+	unsigned int cfg0, cfg1;
+
+	regmap_read(pll->common.map, pll->common.cfg0, &cfg0);
+	regmap_read(pll->common.map, pll->common.cfg1, &cfg1);
+
+	if (cfg1 & TH1520_PLL_BYPASS)
+		return rate;
+
+	div = FIELD_GET(TH1520_PLL_POSTDIV1, cfg0) *
+	      FIELD_GET(TH1520_PLL_POSTDIV2, cfg0);
+
+	rate = rate / div;
+
+	return rate;
+}
+
+static unsigned long ccu_pll_recalc_rate(struct clk_hw *hw,
+					 unsigned long parent_rate)
+{
+	unsigned long rate = parent_rate;
+
+	rate = th1520_pll_vco_recalc_rate(hw, rate);
+	rate = th1520_pll_postdiv_recalc_rate(hw, rate);
+
+	return rate;
+}
+
+const struct clk_ops clk_pll_ops = {
+	.recalc_rate = ccu_pll_recalc_rate,
+};
+
+const struct regmap_config th1520_clk_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.fast_io = true,
+};
diff --git a/drivers/clk/thead/clk-th1520.h b/drivers/clk/thead/clk-th1520.h
new file mode 100644
index 000000000000..285d41e65008
--- /dev/null
+++ b/drivers/clk/thead/clk-th1520.h
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
+ * Copyright (C) 2023 Vivo Communication Technology Co. Ltd.
+ *  Authors: Yangtao Li <frank.li@vivo.com>
+ *
+ * clk-th1520.h - Common definitions for T-HEAD TH1520 Clock Drivers
+ */
+
+#ifndef CLK_TH1520_H
+#define CLK_TH1520_H
+
+#include <dt-bindings/clock/thead,th1520-clk-ap.h>
+#include <linux/bitfield.h>
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define TH1520_PLL_POSTDIV2	GENMASK(26, 24)
+#define TH1520_PLL_POSTDIV1	GENMASK(22, 20)
+#define TH1520_PLL_FBDIV	GENMASK(19, 8)
+#define TH1520_PLL_REFDIV	GENMASK(5, 0)
+#define TH1520_PLL_BYPASS	BIT(30)
+#define TH1520_PLL_DSMPD	BIT(24)
+#define TH1520_PLL_FRAC		GENMASK(23, 0)
+#define TH1520_PLL_FRAC_BITS    24
+
+struct ccu_internal {
+	u8	shift;
+	u8	width;
+};
+
+struct ccu_div_internal {
+	u8	shift;
+	u8	width;
+	u32	flags;
+};
+
+struct ccu_common {
+	int		clkid;
+	struct regmap	*map;
+	u16		cfg0;
+	u16		cfg1;
+	struct clk_hw	hw;
+};
+
+struct ccu_mux {
+	struct ccu_internal	mux;
+	struct ccu_common	common;
+};
+
+struct ccu_gate {
+	u32			enable;
+	struct ccu_common	common;
+};
+
+struct ccu_div {
+	u32			enable;
+	struct ccu_div_internal	div;
+	struct ccu_internal	mux;
+	struct ccu_common	common;
+};
+
+struct ccu_pll {
+	struct ccu_common	common;
+};
+
+#define TH_CCU_ARG(_shift, _width)					\
+	{								\
+		.shift	= _shift,					\
+		.width	= _width,					\
+	}
+
+#define TH_CCU_DIV_FLAGS(_shift, _width, _flags)			\
+	{								\
+		.shift	= _shift,					\
+		.width	= _width,					\
+		.flags	= _flags,					\
+	}
+
+#define CCU_GATE(_clkid, _struct, _name, _parent, _reg, _gate, _flags)	\
+	struct ccu_gate _struct = {					\
+		.enable	= _gate,					\
+		.common	= {						\
+			.clkid		= _clkid,			\
+			.cfg0		= _reg,				\
+			.hw.init	= CLK_HW_INIT_PARENTS_DATA(	\
+						_name,			\
+						_parent,		\
+						&clk_gate_ops,		\
+						_flags),		\
+		}							\
+	}
+
+static inline struct ccu_common *hw_to_ccu_common(struct clk_hw *hw)
+{
+	return container_of(hw, struct ccu_common, hw);
+}
+
+static inline struct ccu_mux *hw_to_ccu_mux(struct clk_hw *hw)
+{
+	struct ccu_common *common = hw_to_ccu_common(hw);
+
+	return container_of(common, struct ccu_mux, common);
+}
+
+static inline struct ccu_pll *hw_to_ccu_pll(struct clk_hw *hw)
+{
+	struct ccu_common *common = hw_to_ccu_common(hw);
+
+	return container_of(common, struct ccu_pll, common);
+}
+
+static inline struct ccu_div *hw_to_ccu_div(struct clk_hw *hw)
+{
+	struct ccu_common *common = hw_to_ccu_common(hw);
+
+	return container_of(common, struct ccu_div, common);
+}
+
+static inline struct ccu_gate *hw_to_ccu_gate(struct clk_hw *hw)
+{
+	struct ccu_common *common = hw_to_ccu_common(hw);
+
+	return container_of(common, struct ccu_gate, common);
+}
+
+extern const struct clk_ops ccu_div_ops;
+extern const struct clk_ops clk_pll_ops;
+extern const struct regmap_config th1520_clk_regmap_config;
+
+#endif /* CLK_TH1520_H */
-- 
2.34.1


