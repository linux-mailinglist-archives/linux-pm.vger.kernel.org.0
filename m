Return-Path: <linux-pm+bounces-26682-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D7EAAA894
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 02:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E867172E2D
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 00:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB972980A3;
	Mon,  5 May 2025 22:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pueKcere"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B8D2980A1;
	Mon,  5 May 2025 22:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484834; cv=none; b=bl269oV9u7EEhoH2shCXjvEYV0iUqS9ujaVQnLBJYqYZOeFioUsWsBWKzrp5adIFeDo4zyOsgl+m0rFoM1Oaed3g9JMW1ty68Ew+ae7iPH1xT9tDMIHK0++Xgr+pO8/IumPIpk2cNoaG66PNu7m/SBtYPBZlYgdpTVnloawQDLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484834; c=relaxed/simple;
	bh=KIgy7Ibl/ZmptAPTdNDHWeodw8H4ZjskznkbvsrWrJM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qne7iaOaM4kGFJkpFPNFXSrUVE6hBMO3V/cBks5Li+UAR23ECKxxWAOPDVZMs30tBzV0HkSrbXhWWCLjvLeUDRryKi9TRUo9Bvuv0375gzYHDTPleztfZwSz/+SExUaJemOIP4oMMaI6uHPSlf9TxjJ9RAB1kV2k+GVVBuNTYHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pueKcere; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B0BEC4CEE4;
	Mon,  5 May 2025 22:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484834;
	bh=KIgy7Ibl/ZmptAPTdNDHWeodw8H4ZjskznkbvsrWrJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pueKcerevEWNPUUbFI8Fo0PIcExpqVxNRggpBDBHDLOjuYnkljavmdI1tvrP3GmCA
	 rewbwgUFVahXsUad7OiQiK4it+7fWgotWEO998nJd1E9YMXBd+6UgwYHOVmNucAQH5
	 ibraaj3ntTBJZofQbWEmVC4LE/9EE/QULIgqjLcunn+uApctEJcRwDbRb+nrEqkUsx
	 PV9O+bjLK/fZ2jinZ3827PnWC9AAiWzY7ouzVRGVV6nkI3x1OhcEiKsvBiOLKmSyC4
	 wPQbbLzfbDJ9h7UpFWSMNZpQTvYTPNzhyFzitj+mm1VIUam4WBfV4PjEKnflXi3NLZ
	 jjLvGdzvfoNtQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	matthias.bgg@gmail.com,
	jpanis@baylibre.com,
	npitre@baylibre.com,
	colin.i.king@gmail.com,
	u.kleine-koenig@baylibre.com,
	wenst@chromium.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 037/486] thermal/drivers/mediatek/lvts: Start sensor interrupts disabled
Date: Mon,  5 May 2025 18:31:53 -0400
Message-Id: <20250505223922.2682012-37-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Nícolas F. R. A. Prado <nfraprado@collabora.com>

[ Upstream commit 2738fb3ec6838a10d2c4ce65cefdb3b90b11bd61 ]

Interrupts are enabled per sensor in lvts_update_irq_mask() as needed,
there's no point in enabling all of them during initialization. Change
the MONINT register initial value so all sensor interrupts start
disabled.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Link: https://lore.kernel.org/r/20250113-mt8192-lvts-filtered-suspend-fix-v2-4-07a25200c7c6@collabora.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/mediatek/lvts_thermal.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 4b3225377e8f8..3295b27ab70d2 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -65,7 +65,6 @@
 #define LVTS_HW_FILTER				0x0
 #define LVTS_TSSEL_CONF				0x13121110
 #define LVTS_CALSCALE_CONF			0x300
-#define LVTS_MONINT_CONF			0x0300318C
 
 #define LVTS_MONINT_OFFSET_SENSOR0		0xC
 #define LVTS_MONINT_OFFSET_SENSOR1		0x180
@@ -929,7 +928,7 @@ static int lvts_irq_init(struct lvts_ctrl *lvts_ctrl)
 	 * The LVTS_MONINT register layout is the same as the LVTS_MONINTSTS
 	 * register, except we set the bits to enable the interrupt.
 	 */
-	writel(LVTS_MONINT_CONF, LVTS_MONINT(lvts_ctrl->base));
+	writel(0, LVTS_MONINT(lvts_ctrl->base));
 
 	return 0;
 }
-- 
2.39.5


