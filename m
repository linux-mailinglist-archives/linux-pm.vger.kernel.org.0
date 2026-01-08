Return-Path: <linux-pm+bounces-40488-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E03D052FF
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 18:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B4A531FA0A7
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 16:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2BA2F1FFA;
	Thu,  8 Jan 2026 16:54:55 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311992E5B3D;
	Thu,  8 Jan 2026 16:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767891295; cv=none; b=Ztf1BRyswt+BNLOe7eY6bqP2rAKTn47OfWj0DBx0ury9oAuqthJT8rwS6Mz9HVwAv7x1kqRtOeT4E0EIf4ZOlEYwFNGLYOPj8Nc3lHF5zcHcccqT+D7BZwqcpTWS3nr0EofaxMEQ0J47TQPZWmtLnQI9w8zcU2wRdAxN1sWYBqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767891295; c=relaxed/simple;
	bh=O5aoQ6ov7cgWwpFvqnKGbB0NtkF/D8HX0xQBgawJjuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cgBORp/0BjAdZKH9QU+CV0+TUHF/8eez+p9G518ttct8TveU3l/+pj7NBX3oioHJEWBf/YWoZ8YdWNcj5obfYA5g1unDeucBvv31dyPn0HxuYF4NwziXnLNCycjCwaPvQC7OeHeT1ojV/LEcXQEjuW2uOpwSgwOgyne/m4cMUls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: 5AhPmNnvQA28NYtH1U5Djg==
X-CSE-MsgGUID: 4mqWx47+TPax5oPHHI1Z2A==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 09 Jan 2026 01:54:45 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.68])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1B09D40313E8;
	Fri,  9 Jan 2026 01:54:40 +0900 (JST)
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
Subject: [PATCH v4 1/5] thermal: renesas: rzg3e: make reset optional
Date: Thu,  8 Jan 2026 18:53:20 +0200
Message-ID: <20260108165324.11376-2-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108165324.11376-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260108165324.11376-1-cosmin-gabriel.tanislav.xa@renesas.com>
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

