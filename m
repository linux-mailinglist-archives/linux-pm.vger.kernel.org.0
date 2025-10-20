Return-Path: <linux-pm+bounces-36471-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D58EEBF1DCE
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 16:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABA693BB198
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 14:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928DB223707;
	Mon, 20 Oct 2025 14:31:29 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1787E1A239A;
	Mon, 20 Oct 2025 14:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760970689; cv=none; b=ZQ0c/J0ZquBGcjZ9oDI3DDJzSW/yjPWiDrnaaYkqcRoaaEK/OWzqq5bvahlCjSItlScCzAw3K4AuRhiL4FVWqViBEpaUzj7j0HqjQcbL2GapuySYBKsPdc3E6q5BA6z4g9o28P5kddzqkjNujzN6xl+C6o3ghJBKteC/7ZdQGhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760970689; c=relaxed/simple;
	bh=2ZZaMMEQ4z7meE1xLJ8lzq1PQWW3LcYSdXb3pyAIv28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DUlSgDZSEN7avjRG4ia0RKoKpOqjrsxr+vF15pHhqjS5AmSAssXU7UgO9WRkJ0W+RZ+SklFSI+O7Qp3llO4lH1gR0qCOf6Hmc4XbPHmp3DuFy0XPxgwyrjBKdMbMvRFKo0Y5lQeHImULXuhegDUZX7t4hDEUKOssLuUo513SbCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: rB6AduWXR5yuHluoyT7U+Q==
X-CSE-MsgGUID: 0bz24/jUTpuSh/VVbSTFsA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 20 Oct 2025 23:31:19 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.23])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A6E6B41CCD99;
	Mon, 20 Oct 2025 23:31:14 +0900 (JST)
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
Subject: [PATCH v2 1/3] clk: renesas: r9a09g057: Add clock and reset entries for TSU
Date: Mon, 20 Oct 2025 14:31:05 +0000
Message-ID: <20251020143107.13974-2-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251020143107.13974-1-ovidiu.panait.rb@renesas.com>
References: <20251020143107.13974-1-ovidiu.panait.rb@renesas.com>
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
v2 changes: none

 drivers/clk/renesas/r9a09g057-cpg.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g057-cpg.c b/drivers/clk/renesas/r9a09g057-cpg.c
index 100cd56c323e..dce5755d85ec 100644
--- a/drivers/clk/renesas/r9a09g057-cpg.c
+++ b/drivers/clk/renesas/r9a09g057-cpg.c
@@ -389,6 +389,10 @@ static const struct rzv2h_mod_clk r9a09g057_mod_clks[] __initconst = {
 						BUS_MSTOP(3, BIT(4))),
 	DEF_MOD("gpu_0_ace_clk",		CLK_PLLDTY_ACPU_DIV2, 15, 2, 7, 18,
 						BUS_MSTOP(3, BIT(4))),
+	DEF_MOD("tsu_0_pclk",			CLK_QEXTAL, 16, 9, 8, 9,
+						BUS_MSTOP(5, BIT(2))),
+	DEF_MOD("tsu_1_pclk",			CLK_QEXTAL, 16, 10, 8, 10,
+						BUS_MSTOP(2, BIT(15))),
 };
 
 static const struct rzv2h_reset r9a09g057_resets[] __initconst = {
@@ -463,6 +467,8 @@ static const struct rzv2h_reset r9a09g057_resets[] __initconst = {
 	DEF_RST(13, 13, 6, 14),		/* GPU_0_RESETN */
 	DEF_RST(13, 14, 6, 15),		/* GPU_0_AXI_RESETN */
 	DEF_RST(13, 15, 6, 16),		/* GPU_0_ACE_RESETN */
+	DEF_RST(15, 7, 7, 8),		/* TSU_0_PRESETN */
+	DEF_RST(15, 8, 7, 9),		/* TSU_1_PRESETN */
 };
 
 const struct rzv2h_cpg_info r9a09g057_cpg_info __initconst = {
-- 
2.51.0


