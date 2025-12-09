Return-Path: <linux-pm+bounces-39339-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9935ECAF694
	for <lists+linux-pm@lfdr.de>; Tue, 09 Dec 2025 10:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9C2A309A7C8
	for <lists+linux-pm@lfdr.de>; Tue,  9 Dec 2025 09:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CC82D6E58;
	Tue,  9 Dec 2025 09:11:43 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA3F26F2B8;
	Tue,  9 Dec 2025 09:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765271503; cv=none; b=pVwN9s7lRjjkGlTZoIVaeDJVUy121Z7gS25gj8w6y/0J7wiBmPkg0VRgZWXCaRfJhD9+7h35KcpNp2YdfvPT0NaDdgMAFnOJElWFcxkOY1cWuLAPTvZqEYFQMb9TaVkdltAEf/SKe8V17SRu0a5KNn3X2tk3ULM0UQSfNzKPiy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765271503; c=relaxed/simple;
	bh=b1Pzn2+PxNwyEgJQcrpu2UWu+2svMokxcbNopM/8f8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MUU72UJiGrdbZonM1d7viRpFSWJrbhR+ItbSvz3HrWLWeaTI1OlUKPFY04ZuxMDwEoZQzsdg5ErruyduuxG/HSsfF6Z6JfNBBoD/NP2RrF1kOd8w473+qoFPjK6RODxY4nAboQRa3QOBFm//g40fOc84Aw2tOw0c4WGtTeQwM+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: MxVW9n1sQZexSEN6mO5Wwg==
X-CSE-MsgGUID: VSTmk3wHQ6qDWvQiXX7gVw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 09 Dec 2025 18:11:33 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.124])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 7F02240071EC;
	Tue,  9 Dec 2025 18:11:28 +0900 (JST)
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
Subject: [PATCH 2/3] clk: renesas: r9a09g056: Add clock and reset entries for TSU
Date: Tue,  9 Dec 2025 09:11:14 +0000
Message-ID: <20251209091115.8541-3-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251209091115.8541-1-ovidiu.panait.rb@renesas.com>
References: <20251209091115.8541-1-ovidiu.panait.rb@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add module clock and reset entries for the TSU0 and TSU1 blocks on the
Renesas RZ/V2N (R9A09G056) SoC.

Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/clk/renesas/r9a09g056-cpg.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g056-cpg.c b/drivers/clk/renesas/r9a09g056-cpg.c
index f48a082e65d7..77e0154a28dd 100644
--- a/drivers/clk/renesas/r9a09g056-cpg.c
+++ b/drivers/clk/renesas/r9a09g056-cpg.c
@@ -397,6 +397,10 @@ static const struct rzv2h_mod_clk r9a09g056_mod_clks[] __initconst = {
 						BUS_MSTOP(3, BIT(4))),
 	DEF_MOD("gpu_0_ace_clk",		CLK_PLLDTY_ACPU_DIV2, 15, 2, 7, 18,
 						BUS_MSTOP(3, BIT(4))),
+	DEF_MOD("tsu_0_pclk",			CLK_QEXTAL, 16, 9, 8, 9,
+						BUS_MSTOP(5, BIT(2))),
+	DEF_MOD("tsu_1_pclk",			CLK_QEXTAL, 16, 10, 8, 10,
+						BUS_MSTOP(2, BIT(15))),
 };
 
 static const struct rzv2h_reset r9a09g056_resets[] __initconst = {
@@ -454,6 +458,8 @@ static const struct rzv2h_reset r9a09g056_resets[] __initconst = {
 	DEF_RST(13, 13, 6, 14),		/* GPU_0_RESETN */
 	DEF_RST(13, 14, 6, 15),		/* GPU_0_AXI_RESETN */
 	DEF_RST(13, 15, 6, 16),		/* GPU_0_ACE_RESETN */
+	DEF_RST(15, 7, 7, 8),		/* TSU_0_PRESETN */
+	DEF_RST(15, 8, 7, 9),		/* TSU_1_PRESETN */
 };
 
 const struct rzv2h_cpg_info r9a09g056_cpg_info __initconst = {
-- 
2.51.0


