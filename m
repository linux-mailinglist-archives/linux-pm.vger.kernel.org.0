Return-Path: <linux-pm+bounces-34903-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CD0B811C2
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 19:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D1A21C24C95
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 17:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC6D2FC88A;
	Wed, 17 Sep 2025 17:03:05 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4B72FBDE4;
	Wed, 17 Sep 2025 17:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758128585; cv=none; b=Hbn1NclnOc0p2Mq2F59XNcjKk6HJ3wsagKFkInrvJ3xA+em1ZWAwp4LsDmMoAmjsgiGbpFjWOAsoQF/svRm+uocgnIvgx7WG+iIcesMyM04ZYjjGm9OY0VJHno3Cayp8pGJ8gkA4KQSkYmAOrzX5kf8VuBTWDmFTsnMFcStJ+II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758128585; c=relaxed/simple;
	bh=lRskdyx/ldMzFy43RfhautzRN8AuxYl0mLasWJggHGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iNCThBHbLPslLChCy7/psyRp77R+hm5KJ1ajfY77vWzGeVaxbI4AtrC63ft/8tRydAu9pTeL0WsmKiyVm2hGuEj5M8qVZJxt1IGuAoE5EV3e0HZUU+nS3AYpf0kl1yGZR0KiW/FflMN/GG8nTMAJrB4qos21IYDpvqKiLApx3v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: yp0IRuv+Qt+odVJunPWf9A==
X-CSE-MsgGUID: ktdBamuWTreFZ/7mC9120g==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 18 Sep 2025 02:03:02 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.24.0.45])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id CF10E4009A35;
	Thu, 18 Sep 2025 02:02:55 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: conor+dt@kernel.org,
	daniel.lezcano@linaro.org,
	geert+renesas@glider.be,
	krzk+dt@kernel.org,
	lukasz.luba@arm.com,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	robh@kernel.org,
	rui.zhang@intel.com,
	sboyd@kernel.org,
	will@kernel.org
Cc: biju.das.jz@bp.renesas.com,
	catalin.marinas@arm.com,
	devicetree@vger.kernel.org,
	john.madieu@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	p.zabel@pengutronix.de,
	rafael@kernel.org,
	John Madieu <john.madieu.xa@bp.renesas.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v9 4/4] arm64: defconfig: Enable the Renesas RZ/G3E thermal driver
Date: Wed, 17 Sep 2025 19:01:58 +0200
Message-ID: <20250917170202.197929-5-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250917170202.197929-1-john.madieu.xa@bp.renesas.com>
References: <20250917170202.197929-1-john.madieu.xa@bp.renesas.com>
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


