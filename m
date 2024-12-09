Return-Path: <linux-pm+bounces-18840-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5378C9E9C67
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 18:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E1AB281E83
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 17:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2621E9B19;
	Mon,  9 Dec 2024 17:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dSUBFInE"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774AB1E9B38;
	Mon,  9 Dec 2024 17:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733763642; cv=none; b=t71dXwKh6XGFktZ4CxXc2NzjM2DVefZ0baT0I4Otf5vpzaeqaHMDTWPFg+zRT9H9HYkQQ3rsmym2gHAPcviQvhJlVjK8f8c+Q+BoSlwwWFAZ1hUct5j75PWbTA/+QIkQex9MsGSzerageYzsM+s+njQFcoGWKAgQO+G1cDbMReY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733763642; c=relaxed/simple;
	bh=su0uD7O//6S9JY8N7rS1xY/Z0tIHFw7tTkD85XiSF2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eQW7C5WwHd74lHsbJa8aldjAdNvpYvBL3fmhhoJQ+qaJowA5gAvm1XrOv8RUBY99v0K1sVTbAsXNVKjt2404U+nx2pEfnUwJzAKiX0UjdHD/cSRMaTIoaEcGt+QMTeqFiI6RKT+de0EQh+jcNVJJcnHQ2fZQneeAp8eE+3YNTnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dSUBFInE; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733763637;
	bh=su0uD7O//6S9JY8N7rS1xY/Z0tIHFw7tTkD85XiSF2Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dSUBFInELVQJYkDq4qybrKZECoTcE+L00x7lE8a/Bvg08Oa7whJIjz0UHrJw0hm5r
	 ANbLii8cs8WAI5aZkmEChvjNI1wWPSjppeN20R2GeVCCFF2JuNOlSGi+dcfNVyEWbg
	 9ISSUc4HzjpytMyb78rEIF8W2wphRdH8upSUKtduYZfsURON9wcjII5GMOhQVAjFHZ
	 joMMSDtM+zrrB+mnBHrKaP5LnjPZIq2ximrKnaVSaZ0Q5XionxSdIYtGyB9neSuvNR
	 F+XiM04eSQVKEQgHjY0xofkk2WjzbGiMDvzCZMh8AZ+JxW/r/SV3gYFQ+yON7xDnlP
	 8N00/JXoeH4SA==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C1DE917E37C1;
	Mon,  9 Dec 2024 18:00:33 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Mon, 09 Dec 2024 14:00:04 -0300
Subject: [PATCH v2 3/5] thermal/drivers/mediatek/lvts: Disable low offset
 IRQ for minimum threshold
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241209-mt8192-lvts-filtered-suspend-fix-v2-3-5b046a99baa9@collabora.com>
References: <20241209-mt8192-lvts-filtered-suspend-fix-v2-0-5b046a99baa9@collabora.com>
In-Reply-To: <20241209-mt8192-lvts-filtered-suspend-fix-v2-0-5b046a99baa9@collabora.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Alexandre Mergnat <amergnat@baylibre.com>, 
 Balsam CHIHI <bchihi@baylibre.com>
Cc: kernel@collabora.com, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Hsin-Te Yuan <yuanhsinte@chromium.org>, 
 Chen-Yu Tsai <wenst@chromium.org>, 
 =?utf-8?q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2

In order to get working interrupts, a low offset value needs to be
configured. The minimum value for it is 20 Celsius, which is what is
configured when there's no lower thermal trip (ie the thermal core
passes -INT_MAX as low trip temperature). However, when the temperature
gets that low and fluctuates around that value it causes an interrupt
storm.

Prevent that interrupt storm by not enabling the low offset interrupt if
the low threshold is the minimum one.

Cc: stable@vger.kernel.org
Fixes: 77354eaef821 ("thermal/drivers/mediatek/lvts_thermal: Don't leave threshold zeroed")
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 48 ++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 0aaa44b734ca43e6abfd97b2ca4ce34dc6f15826..04bfbfe93a71ee9e3428bfd7f8bd359fe9446e88 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -67,10 +67,14 @@
 #define LVTS_CALSCALE_CONF			0x300
 #define LVTS_MONINT_CONF			0x0300318C
 
-#define LVTS_MONINT_OFFSET_SENSOR0		0xC
-#define LVTS_MONINT_OFFSET_SENSOR1		0x180
-#define LVTS_MONINT_OFFSET_SENSOR2		0x3000
-#define LVTS_MONINT_OFFSET_SENSOR3		0x3000000
+#define LVTS_MONINT_OFFSET_HIGH_INTEN_SENSOR0		BIT(3)
+#define LVTS_MONINT_OFFSET_HIGH_INTEN_SENSOR1		BIT(8)
+#define LVTS_MONINT_OFFSET_HIGH_INTEN_SENSOR2		BIT(13)
+#define LVTS_MONINT_OFFSET_HIGH_INTEN_SENSOR3		BIT(25)
+#define LVTS_MONINT_OFFSET_LOW_INTEN_SENSOR0		BIT(2)
+#define LVTS_MONINT_OFFSET_LOW_INTEN_SENSOR1		BIT(7)
+#define LVTS_MONINT_OFFSET_LOW_INTEN_SENSOR2		BIT(12)
+#define LVTS_MONINT_OFFSET_LOW_INTEN_SENSOR3		BIT(24)
 
 #define LVTS_INT_SENSOR0			0x0009001F
 #define LVTS_INT_SENSOR1			0x001203E0
@@ -326,11 +330,17 @@ static int lvts_get_temp(struct thermal_zone_device *tz, int *temp)
 
 static void lvts_update_irq_mask(struct lvts_ctrl *lvts_ctrl)
 {
-	static const u32 masks[] = {
-		LVTS_MONINT_OFFSET_SENSOR0,
-		LVTS_MONINT_OFFSET_SENSOR1,
-		LVTS_MONINT_OFFSET_SENSOR2,
-		LVTS_MONINT_OFFSET_SENSOR3,
+	static const u32 high_offset_inten_masks[] = {
+		LVTS_MONINT_OFFSET_HIGH_INTEN_SENSOR0,
+		LVTS_MONINT_OFFSET_HIGH_INTEN_SENSOR1,
+		LVTS_MONINT_OFFSET_HIGH_INTEN_SENSOR2,
+		LVTS_MONINT_OFFSET_HIGH_INTEN_SENSOR3,
+	};
+	static const u32 low_offset_inten_masks[] = {
+		LVTS_MONINT_OFFSET_LOW_INTEN_SENSOR0,
+		LVTS_MONINT_OFFSET_LOW_INTEN_SENSOR1,
+		LVTS_MONINT_OFFSET_LOW_INTEN_SENSOR2,
+		LVTS_MONINT_OFFSET_LOW_INTEN_SENSOR3,
 	};
 	u32 value = 0;
 	int i;
@@ -339,10 +349,22 @@ static void lvts_update_irq_mask(struct lvts_ctrl *lvts_ctrl)
 
 	for (i = 0; i < ARRAY_SIZE(masks); i++) {
 		if (lvts_ctrl->sensors[i].high_thresh == lvts_ctrl->high_thresh
-		    && lvts_ctrl->sensors[i].low_thresh == lvts_ctrl->low_thresh)
-			value |= masks[i];
-		else
-			value &= ~masks[i];
+		    && lvts_ctrl->sensors[i].low_thresh == lvts_ctrl->low_thresh) {
+			/*
+			 * The minimum threshold needs to be configured in the
+			 * OFFSETL register to get working interrupts, but we
+			 * don't actually want to generate interrupts when
+			 * crossing it.
+			 */
+			if (lvts_ctrl->low_thresh == -INT_MAX) {
+				value &= ~low_offset_inten_masks[i];
+				value |= high_offset_inten_masks[i];
+			} else {
+				value |= low_offset_inten_masks[i] | high_offset_inten_masks[i];
+			}
+		} else {
+			value &= ~(low_offset_inten_masks[i] | high_offset_inten_masks[i]);
+		}
 	}
 
 	writel(value, LVTS_MONINT(lvts_ctrl->base));

-- 
2.47.0


