Return-Path: <linux-pm+bounces-36254-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 905F9BE3A6C
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 15:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E7B85023E3
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 13:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0C6202F7B;
	Thu, 16 Oct 2025 13:18:52 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB131D63E6;
	Thu, 16 Oct 2025 13:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760620732; cv=none; b=fn5QEGXH0eYFNTSwlbl2qB4qrswIgyz3zt6LhgLoHorn710ueKN/GDQD5MeSv2Gy2ImV514J75C/1qNo5SOA/hz23s4n/tiW3r5GyQWvfLsKE9q7fKhr3kE2+KbuKQswOvVcsdMwPPFGXVrwCqlsbsjosah47sY1YN/AfKUvwLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760620732; c=relaxed/simple;
	bh=2qcnQgEDhTUPdfhZAY1SrAh7NDGxOjwEzb5n6TAHyaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JtW+FVaT8N8vzwk8RSESB7oAG797pJH4O4DsO5BIAFn00I9TlET6OpIQa6+7T0uOlqLFPrO+fOT4y2o6EwBmq+wnWfgMjWwC9RmKhKqra7a6ga4/oJvjSyQZzEjy/v7T2wkfKpZaEAclKcbDAcp06xRXKUxYxinqoZBvnHAYcXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: kYS7lpWDTNepoh9RVyXG3A==
X-CSE-MsgGUID: gk5yvKMlQguYknpZtxDCiA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 16 Oct 2025 22:13:39 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.8])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 97BB941CB11F;
	Thu, 16 Oct 2025 22:13:34 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: john.madieu.xa@bp.renesas.com,
	rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: [PATCH 1/3] clk: renesas: r9a09g057: Add clock and reset entries for TSU
Date: Thu, 16 Oct 2025 13:13:25 +0000
Message-ID: <20251016131327.19141-2-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016131327.19141-1-ovidiu.panait.rb@renesas.com>
References: <20251016131327.19141-1-ovidiu.panait.rb@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add module clock and reset entries for the TSU0 and TSU1 blocks on the
Renesas RZ/V2H (R9A09G057) SoC.

Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/clk/renesas/r9a09g057-cpg.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g057-cpg.c b/drivers/clk/renesas/r9a09g057-cpg.c
index 4e47fea3f894..e865a70a7f25 100644
--- a/drivers/clk/renesas/r9a09g057-cpg.c
+++ b/drivers/clk/renesas/r9a09g057-cpg.c
@@ -379,6 +379,10 @@ static const struct rzv2h_mod_clk r9a09g057_mod_clks[] __initconst = {
 						BUS_MSTOP(3, BIT(4))),
 	DEF_MOD("gpu_0_ace_clk",		CLK_PLLDTY_ACPU_DIV2, 15, 2, 7, 18,
 						BUS_MSTOP(3, BIT(4))),
+	DEF_MOD("tsu_0_pclk",			CLK_QEXTAL, 16, 9, 8, 9,
+						BUS_MSTOP(5, BIT(2))),
+	DEF_MOD("tsu_1_pclk",			CLK_QEXTAL, 16, 10, 8, 10,
+						BUS_MSTOP(2, BIT(15))),
 };
 
 static const struct rzv2h_reset r9a09g057_resets[] __initconst = {
@@ -449,6 +453,8 @@ static const struct rzv2h_reset r9a09g057_resets[] __initconst = {
 	DEF_RST(13, 13, 6, 14),		/* GPU_0_RESETN */
 	DEF_RST(13, 14, 6, 15),		/* GPU_0_AXI_RESETN */
 	DEF_RST(13, 15, 6, 16),		/* GPU_0_ACE_RESETN */
+	DEF_RST(15, 7, 7, 8),		/* TSU_0_PRESETN */
+	DEF_RST(15, 8, 7, 9),		/* TSU_1_PRESETN */
 };
 
 const struct rzv2h_cpg_info r9a09g057_cpg_info __initconst = {
-- 
2.51.0


