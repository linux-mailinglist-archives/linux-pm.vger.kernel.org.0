Return-Path: <linux-pm+bounces-24616-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCC8A75D30
	for <lists+linux-pm@lfdr.de>; Mon, 31 Mar 2025 00:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E2E13AA3EB
	for <lists+linux-pm@lfdr.de>; Sun, 30 Mar 2025 22:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA83E7DA9C;
	Sun, 30 Mar 2025 22:12:40 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C374F1DF269;
	Sun, 30 Mar 2025 22:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743372760; cv=none; b=ZAeQbdFswMk0mjH6cwenVx4LUaEI7IP9h2JO/t8Rjyj8UX4Luw1Nx1WgAOyfoq5FxGpaAQNHCvj+qFeXDCz8TRv1ZW2Waa9OVn50i1QYj5KcPRcsrtTG995EfUUDk1d8n+bVYks+b5Saqe6Takix6it+fjOhUgh95yarBbaf64A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743372760; c=relaxed/simple;
	bh=LwjpNe0Cz1yHQxFlkpGUMdZVIVG3nNeYhta1jyE2P/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WMEQpgLttMz4SRIvicI7Da3W3hRdwB82hA9Nf4KI1tsYze99/Xb3Hf1tavl9XLapXnsRMPO+Bwrl4Mtw1eNeYFDK/3ut4ZtVhRKoa+xOdMaOrAmx3zEsubVoWkyLOPLMEe+KtReEK6FGL31wbJfhKmFHFjK/XPuscQo9KQgdfOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: oN/BA4odSDWjoadBYgxCIg==
X-CSE-MsgGUID: mUUYfYIuR5iPX/zdgItIAQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 31 Mar 2025 07:12:38 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.1])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 7D9964005479;
	Mon, 31 Mar 2025 07:12:33 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: geert+renesas@glider.be,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	rafael@kernel.org,
	daniel.lezcano@linaro.org
Cc: magnus.damm@gmail.com,
	devicetree@vger.kernel.org,
	john.madieu@gmail.com,
	rui.zhang@intel.com,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	sboyd@kernel.org,
	biju.das.jz@bp.renesas.com,
	linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	John Madieu <john.madieu.xa@bp.renesas.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 5/5] arm64: defconfig: Enable the Renesas RZ/G3E thermal driver
Date: Sun, 30 Mar 2025 23:49:41 +0200
Message-ID: <20250330214945.185725-6-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250330214945.185725-1-john.madieu.xa@bp.renesas.com>
References: <20250330214945.185725-1-john.madieu.xa@bp.renesas.com>
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
v1 -> v2: no changes
v2 -> v3: no changes
v3 -> v4: update commit message
v5: no changes

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a1cc3814b09b..91136c0196b5 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -714,6 +714,7 @@ CONFIG_ROCKCHIP_THERMAL=m
 CONFIG_RCAR_THERMAL=y
 CONFIG_RCAR_GEN3_THERMAL=y
 CONFIG_RZG2L_THERMAL=y
+CONFIG_RZG3E_THERMAL=y
 CONFIG_ARMADA_THERMAL=y
 CONFIG_MTK_THERMAL=m
 CONFIG_MTK_LVTS_THERMAL=m
-- 
2.25.1


