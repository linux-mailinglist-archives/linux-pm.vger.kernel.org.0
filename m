Return-Path: <linux-pm+bounces-27528-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AA6AC1350
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 20:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83B897A6EAA
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 18:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E341D47B4;
	Thu, 22 May 2025 18:23:47 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97A71A9B39;
	Thu, 22 May 2025 18:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747938226; cv=none; b=b1Oy3QG3SlrOZr+vS1Hkz5W8BsVCsjG8z51mjxZopVWW9UwICuy77oBsy8lqIKSu9OSb4GXXF1xPz6/HRDy6YyefnaLcSx8mRiCMhVo7Vxa2I8Wmrtf6fqFfGx0mKL2cy7fnVylcfkCZ3pAyWjfc+Xdv4NMJPiLELwV8CF5qXow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747938226; c=relaxed/simple;
	bh=RCGkFXOgSO59wGDlF/qY1padpeWgsXUEjleBdBD1zg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DDsO1FIsGbxqKjU5PAA2njOzQzB5GKdivdF45N2Zs8EVU0jZ6TOXwRI9PZaolfDRJEqFrA0ZrQkVlC/TwmPY5C4L2FVeJaDNBdK1nEeqAz4RBhccNkAHWZSSk+AEqzp4cuc2h87odtxgf2770obIiIYOjRTyPx+TEYH5uCAECZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: RfPXBMYRT9Ou/JmRiogf8g==
X-CSE-MsgGUID: 4eKWHDTJS42TvvMugPB6eA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 23 May 2025 03:23:43 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.203])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 599EC4061FC8;
	Fri, 23 May 2025 03:23:38 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: john.madieu.xa@bp.renesas.com,
	conor+dt@kernel.org,
	daniel.lezcano@linaro.org,
	geert+renesas@glider.be,
	krzk+dt@kernel.org,
	rafael@kernel.org
Cc: biju.das.jz@bp.renesas.com,
	devicetree@vger.kernel.org,
	john.madieu@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	lukasz.luba@arm.com,
	magnus.damm@gmail.com,
	robh@kernel.org,
	rui.zhang@intel.com,
	sboyd@kernel.org,
	niklas.soderlund+renesas@ragnatech.se,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 5/5] arm64: defconfig: Enable the Renesas RZ/G3E thermal driver
Date: Thu, 22 May 2025 20:22:48 +0200
Message-ID: <20250522182252.1593159-6-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250522182252.1593159-1-john.madieu.xa@bp.renesas.com>
References: <20250522182252.1593159-1-john.madieu.xa@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the Renesas RZ/G3E thermal driver, as used on the Renesas
RZ/G3E SMARC EVK board.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---

Changes:

v1 -> v2: no changes
v2 -> v3: no changes
v3 -> v4: update commit message
v5: no changes
v6: no changes

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 368c242fe945..1b9ceab54408 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -720,6 +720,7 @@ CONFIG_ROCKCHIP_THERMAL=m
 CONFIG_RCAR_THERMAL=y
 CONFIG_RCAR_GEN3_THERMAL=y
 CONFIG_RZG2L_THERMAL=y
+CONFIG_RZG3E_THERMAL=y
 CONFIG_ARMADA_THERMAL=y
 CONFIG_MTK_THERMAL=m
 CONFIG_MTK_LVTS_THERMAL=m
-- 
2.25.1


