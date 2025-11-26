Return-Path: <linux-pm+bounces-38707-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 679F8C89E87
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 14:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F0834E032A
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 13:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E878521638D;
	Wed, 26 Nov 2025 13:04:55 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4BA1F9F47;
	Wed, 26 Nov 2025 13:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764162295; cv=none; b=DcHqOlEQG6qoY5oF4P6yTMF3QZVMtisTuMHRUyi5J3PydMTd972VlIr9OewULrBAXrWGACwFbdgcWLj/bPKOC3dJfWICmSZJZMTBHa/cOz15+uMk9Zm/3WE2UWouVg06I851hCZ16I6mWu4lMLkz0gJ+TRKT9xdpgqcalEHtwdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764162295; c=relaxed/simple;
	bh=M0x5/t/mwATltuD96QkP0RYumSKKZX9WxjovT1nuazE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YABNAwAHRVxqH/b0JHhME1N3pwSvaZoZHk8ClS9Q5Lez+OP0ujt7AI7b5FUipXzrKbGXDfG1iiBn5rXW3QGOaw1ipiGllv4Rt6MlzHWzyzAob5iXKl1hkarZDUhGQn9y69BGOt3lgG6Y0rOhZ58Do84wZ1TcQz4DqFIvkv/HOaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: xubRuzV/Rw6g9Qz1yzDh3A==
X-CSE-MsgGUID: vy0v+ysgSfmYd5PCcaEvUw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 26 Nov 2025 22:04:49 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.98])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9241F400EF74;
	Wed, 26 Nov 2025 22:04:44 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: John Madieu <john.madieu.xa@bp.renesas.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v3 1/9] thermal: renesas: rzg3e: make reset optional
Date: Wed, 26 Nov 2025 15:03:48 +0200
Message-ID: <20251126130356.2768625-2-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251126130356.2768625-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251126130356.2768625-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs do not have a
reset line.

Prepare for them by making it optional.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
V3:
 * no changes

V2:
 * no changes

 drivers/thermal/renesas/rzg3e_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/renesas/rzg3e_thermal.c b/drivers/thermal/renesas/rzg3e_thermal.c
index e66d73ca6752..86c10810e5bf 100644
--- a/drivers/thermal/renesas/rzg3e_thermal.c
+++ b/drivers/thermal/renesas/rzg3e_thermal.c
@@ -412,7 +412,7 @@ static int rzg3e_thermal_probe(struct platform_device *pdev)
 				     "Clock rate %lu Hz too low (min %u Hz)\n",
 				     clk_get_rate(clk), TSU_MIN_CLOCK_RATE);
 
-	priv->rstc = devm_reset_control_get_exclusive_deasserted(dev, NULL);
+	priv->rstc = devm_reset_control_get_optional_exclusive_deasserted(dev, NULL);
 	if (IS_ERR(priv->rstc))
 		return dev_err_probe(dev, PTR_ERR(priv->rstc),
 				     "Failed to get/deassert reset control\n");
-- 
2.52.0


