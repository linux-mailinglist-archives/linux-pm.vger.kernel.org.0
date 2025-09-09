Return-Path: <linux-pm+bounces-34241-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D60B4AC54
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 13:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5336D4E677A
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 11:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EB032255A;
	Tue,  9 Sep 2025 11:39:30 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034D1321F30;
	Tue,  9 Sep 2025 11:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757417970; cv=none; b=unR4unYP13Y+ZFoTUR6Lrs/ZI0EldmD0Y39fr4JaoHSsR3VR5pn0t55U/ekk+TIERci4a964V6a6jZcNRqSw7/1/XUTuX6oYqsHsYfmd3IQeSpzqZWigJZXZvA1f5xvM+aKKHEvKD16I7XzrBjCo7qFD7EkqI+K0b3VYi6yRN30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757417970; c=relaxed/simple;
	bh=lRskdyx/ldMzFy43RfhautzRN8AuxYl0mLasWJggHGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ouCoQGKE32ydvmDr/YGNer338nHO6NcwhV+tvNZL9/WGZKpq259DjJtay2YGB78odDftzXlgErP55guhZ4lPi9pjK0CaTrmaCq4Ha5KdmVyb/PZrruQ1rWPjV+zQHWguE9Oap7CkvpoT6gZ57HZP9Ohp/OuiCaxyrRkKCDtfvAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: 507sXnTvQliEhFBs3Q4Mdg==
X-CSE-MsgGUID: Qc/LLW2OR6SwhPfPrNNvTA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 09 Sep 2025 20:39:26 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.24.0.1])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4AF0E401E4F5;
	Tue,  9 Sep 2025 20:39:17 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: catalin.marinas@arm.com,
	conor+dt@kernel.org,
	daniel.lezcano@linaro.org,
	geert+renesas@glider.be,
	krzk+dt@kernel.org,
	lukasz.luba@arm.com,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	p.zabel@pengutronix.de,
	robh@kernel.org,
	rui.zhang@intel.com,
	sboyd@kernel.org,
	will@kernel.org
Cc: biju.das.jz@bp.renesas.com,
	devicetree@vger.kernel.org,
	john.madieu@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	rafael@kernel.org,
	John Madieu <john.madieu.xa@bp.renesas.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v8 4/4] arm64: defconfig: Enable the Renesas RZ/G3E thermal driver
Date: Tue,  9 Sep 2025 13:38:39 +0200
Message-ID: <20250909113840.122785-5-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909113840.122785-1-john.madieu.xa@bp.renesas.com>
References: <20250909113840.122785-1-john.madieu.xa@bp.renesas.com>
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
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 58f87d09366c..8def47e094d0 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -728,6 +728,7 @@ CONFIG_ROCKCHIP_THERMAL=m
 CONFIG_RCAR_THERMAL=y
 CONFIG_RCAR_GEN3_THERMAL=y
 CONFIG_RZG2L_THERMAL=y
+CONFIG_RZG3E_THERMAL=y
 CONFIG_ARMADA_THERMAL=y
 CONFIG_MTK_THERMAL=m
 CONFIG_MTK_LVTS_THERMAL=m
-- 
2.25.1


