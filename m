Return-Path: <linux-pm+bounces-32566-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EF7B2AE28
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 18:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD6A27B546A
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 16:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D108341ACB;
	Mon, 18 Aug 2025 16:29:49 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045A2342C9E;
	Mon, 18 Aug 2025 16:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755534589; cv=none; b=qPfimnHNUg/RGSLXASBVo7AhIHlRZvgkvE7S/ZLVDCkx5bMj7bXG6/gitV07rINstsaaVmuFoRmyJHFkpL2lO1jm4N2ddTq+A+3yERzrOgw962dV7zYGTklks+vdJVQi2COxvKkhqTLqPknmDmoljrlzvLZ9TgVs3FxB36TFWqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755534589; c=relaxed/simple;
	bh=syrJozNxqnnFPDFMqCg7jOzWztrpq9ITizOV/kix5+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tGARqmusuDZe9Dsl/g+f9jxcF8JMdwew4+KDivcAdDFVS2uIJ63Q0jMJRVUUIA54hkHxmM+r/s7r9ccl4c0lJf/PplMM7qqAjLdDoxIE/oJeNWQOeJ34pvUN+n/GU2XxiK1P05+Cd9FjMETPsobHztaw41sbgq5L9Or5NCYvXto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: c5Z12sA3SAqo4sSCem8pHA==
X-CSE-MsgGUID: 8Rzlmlh8TwiMwWJOK25AZg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 19 Aug 2025 01:29:46 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.24.0.173])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8BFFF4016EE7;
	Tue, 19 Aug 2025 01:29:39 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	catalin.marinas@arm.com,
	will@kernel.org
Cc: john.madieu@gmail.com,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	biju.das.jz@bp.renesas.com,
	linux-arm-kernel@lists.infradead.org,
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: [PATCH v7 4/6] arm64: dts: renesas: r9a09g047: Add #address-cells property in sys node
Date: Mon, 18 Aug 2025 18:28:50 +0200
Message-ID: <20250818162859.9661-5-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818162859.9661-1-john.madieu.xa@bp.renesas.com>
References: <20250818162859.9661-1-john.madieu.xa@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A couple of registers of the system controller (sys) are shared with the TSU
device. Add #address-cells property to sys node to allow proper parsing a
access to these registers from the TSU driver.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---

Changes:
 - v7: new patch: as sys specifier has changed for TSU node, add this patch
 to specify #address-cells.

 arch/arm64/boot/dts/renesas/r9a09g047.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
index e4fac7e0d764..7cbba492edd5 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
@@ -278,6 +278,7 @@ sys: system-controller@10430000 {
 			reg = <0 0x10430000 0 0x10000>;
 			clocks = <&cpg CPG_CORE R9A09G047_SYS_0_PCLK>;
 			resets = <&cpg 0x30>;
+			#address-cells = <1>;
 		};
 
 		xspi: spi@11030000 {
-- 
2.25.1


