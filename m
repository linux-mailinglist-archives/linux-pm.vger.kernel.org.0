Return-Path: <linux-pm+bounces-20330-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8228AA0B818
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 14:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46C1A3A8AF2
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 13:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FF422F169;
	Mon, 13 Jan 2025 13:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="V2vaCFlI"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C3522F152;
	Mon, 13 Jan 2025 13:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736774883; cv=none; b=NErzscTHGPnGCy+gDKYzDlEpkQA92aKFJOm3fAIOhgzoWKGEc0nQvf1E1zecgz7RkDV1mPQP6qbAFUDbCNxh8XIwH1k1RNvyJojh9mJoIzDOQsyAB+bUae0sVxQ4dtnP5rkOnvFLPIAyfi3Ix7IjX8uk4m5BBGpRaIHIZznbCvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736774883; c=relaxed/simple;
	bh=7rUOl9/1nR9glA+jrEp1IsgcYZif+zrnnDsNYbXXe7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D9rgFPabHLBHeqGFrW0xUlz6esww6R6K0HFTZMn60fJ8OmDbT2uXhN/bXrRSUG42wqnN5yFitIrlyyiC2wCXcXEUui97SnShdNJxZ4GS1QzpLYHNjZYBnn02FvQdX2/RVpqFl7JaRCr1IpO0AzZb1WdQLaBsaTq1/bq4+tEc5+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=V2vaCFlI; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1736774880;
	bh=7rUOl9/1nR9glA+jrEp1IsgcYZif+zrnnDsNYbXXe7s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=V2vaCFlI7LtaP6gzu3haQArwV1qW46D7VOrs/qdLJ8sUPDUyg2LOLjlHsLtRAlrjL
	 0/LxSmCEoL6zYUrR+ouK8iCl0VEknejk2D4IXwG37vCw2bAK9QsKToR3kUiODHs02x
	 V5nP72xl112uYPutcnZFixjVZckScEWtBFMR86hBnxBUDsD05Wnw9d6U5qT5/lhQFo
	 i1+tf+TTJ1W1pQ2aAsJ7NAHbU8AuD8I0zpThCBjaPtrq0j4OmstMdib4/tAHeOXYfj
	 EdEF14LvXb4iNXdUVTYogUdBhjwfmZAnHNJecxsaDoip97FP6J4+YQvkmLkvcjQYdF
	 lvAx5Y5CXHxIw==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1000])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DDE0E17E0DD3;
	Mon, 13 Jan 2025 14:27:55 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Mon, 13 Jan 2025 10:27:12 -0300
Subject: [PATCH RESEND v2 1/5] thermal/drivers/mediatek/lvts: Disable
 monitor mode during suspend
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250113-mt8192-lvts-filtered-suspend-fix-v2-1-07a25200c7c6@collabora.com>
References: <20250113-mt8192-lvts-filtered-suspend-fix-v2-0-07a25200c7c6@collabora.com>
In-Reply-To: <20250113-mt8192-lvts-filtered-suspend-fix-v2-0-07a25200c7c6@collabora.com>
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

When configured in filtered mode, the LVTS thermal controller will
monitor the temperature from the sensors and trigger an interrupt once a
thermal threshold is crossed.

Currently this is true even during suspend and resume. The problem with
that is that when enabling the internal clock of the LVTS controller in
lvts_ctrl_set_enable() during resume, the temperature reading can glitch
and appear much higher than the real one, resulting in a spurious
interrupt getting generated.

Disable the temperature monitoring and give some time for the signals to
stabilize during suspend in order to prevent such spurious interrupts.

Cc: stable@vger.kernel.org
Reported-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
Closes: https://lore.kernel.org/all/20241108-lvts-v1-1-eee339c6ca20@chromium.org/
Fixes: 8137bb90600d ("thermal/drivers/mediatek/lvts_thermal: Add suspend and resume")
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 36 +++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 07f7f3b7a2fb569cfc300dc2126ea426e161adff..a1a438ebad33c1fff8ca9781e12ef9e278eef785 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -860,6 +860,32 @@ static int lvts_ctrl_init(struct device *dev, struct lvts_domain *lvts_td,
 	return 0;
 }
 
+static void lvts_ctrl_monitor_enable(struct device *dev, struct lvts_ctrl *lvts_ctrl, bool enable)
+{
+	/*
+	 * Bitmaps to enable each sensor on filtered mode in the MONCTL0
+	 * register.
+	 */
+	static const u8 sensor_filt_bitmap[] = { BIT(0), BIT(1), BIT(2), BIT(3) };
+	u32 sensor_map = 0;
+	int i;
+
+	if (lvts_ctrl->mode != LVTS_MSR_FILTERED_MODE)
+		return;
+
+	if (enable) {
+		lvts_for_each_valid_sensor(i, lvts_ctrl)
+			sensor_map |= sensor_filt_bitmap[i];
+	}
+
+	/*
+	 * Bits:
+	 *      9: Single point access flow
+	 *    0-3: Enable sensing point 0-3
+	 */
+	writel(sensor_map | BIT(9), LVTS_MONCTL0(lvts_ctrl->base));
+}
+
 /*
  * At this point the configuration register is the only place in the
  * driver where we write multiple values. Per hardware constraint,
@@ -1381,8 +1407,11 @@ static int lvts_suspend(struct device *dev)
 
 	lvts_td = dev_get_drvdata(dev);
 
-	for (i = 0; i < lvts_td->num_lvts_ctrl; i++)
+	for (i = 0; i < lvts_td->num_lvts_ctrl; i++) {
+		lvts_ctrl_monitor_enable(dev, &lvts_td->lvts_ctrl[i], false);
+		usleep_range(100, 200);
 		lvts_ctrl_set_enable(&lvts_td->lvts_ctrl[i], false);
+	}
 
 	clk_disable_unprepare(lvts_td->clk);
 
@@ -1400,8 +1429,11 @@ static int lvts_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	for (i = 0; i < lvts_td->num_lvts_ctrl; i++)
+	for (i = 0; i < lvts_td->num_lvts_ctrl; i++) {
 		lvts_ctrl_set_enable(&lvts_td->lvts_ctrl[i], true);
+		usleep_range(100, 200);
+		lvts_ctrl_monitor_enable(dev, &lvts_td->lvts_ctrl[i], true);
+	}
 
 	return 0;
 }

-- 
2.47.1


