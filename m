Return-Path: <linux-pm+bounces-40499-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5280D05EBF
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 20:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 065413033736
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 19:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7712632B9B1;
	Thu,  8 Jan 2026 19:53:32 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB740328B45;
	Thu,  8 Jan 2026 19:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767902012; cv=none; b=jhZXAR2AWzRQAsIP5HqHP4YkK93C3TK4X+9h8IC60BIwycJ4JAEUmdN3buP6Y4LTUxI0YScJE+dex+CxSkujXi5diypmKR3ZdSAjVrtFijZTP/1o2uYClZzE+MkY75TbzJp8XRnNqEZwhstT8VNOUlgDfGKvow7GvdXPOilovWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767902012; c=relaxed/simple;
	bh=r3SCEnwL1PGKy7MG5+Mt3LUNKG7vTtvBm8aR+r4SlmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TzuJYHDQLJ1S/+pvf7gs1EW5vOGpcvwXQRPOxmy3FEUAVK4i9WcRMF+7D7eYUdmrt/YwsjLQEW8DLrS1lYdb77jdWPjV+GxmZKxp7/54Bd9PFb8z9HUhZcuX20pnDqVHuqb2/x8r+Yie99sa0gnGRTr9TcoCz4vqkrOk1m+11qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: uYt6vzGeQFWzMfsMjEdxHA==
X-CSE-MsgGUID: fvNXeq4WRbiEsRqS5DVb1g==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 09 Jan 2026 04:53:28 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.68])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id C3AE94008A2E;
	Fri,  9 Jan 2026 04:53:23 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: John Madieu <john.madieu.xa@bp.renesas.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v5 1/5] thermal: renesas: rzg3e: make reset optional
Date: Thu,  8 Jan 2026 21:52:19 +0200
Message-ID: <20260108195223.193531-2-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108195223.193531-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260108195223.193531-1-cosmin-gabriel.tanislav.xa@renesas.com>
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

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: John Madieu <john.madieu.xa@bp.renesas.com>
Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V5:
 * no changes

V4:
 * pick up Geert's Reviewed-by
 * pick up John's Reviewed-by and Tested-by

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

