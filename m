Return-Path: <linux-pm+bounces-20333-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B812EA0B823
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 14:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4043118856C9
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 13:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D5523A592;
	Mon, 13 Jan 2025 13:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pZhb4B82"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AA423A587;
	Mon, 13 Jan 2025 13:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736774897; cv=none; b=I6GeCeG0dRV5B0xS5wRz1uk2risq/X3J0Mn3QnZzGo+f0YGqMtwFvKS/TFKsp0kjDFWYu29g0pHuUIIe2mTuM7NRMIZDDDCGyznkCuLlZ3BbmTulAF7KssAdCdPJX/dW69+mdZulzhJo+xRKfrayMSEzGoi61RvdZV05Gk22J0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736774897; c=relaxed/simple;
	bh=AktmW7JFPLzeN3KumqXBxvzZLmczb0J988S02mCLAZw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WfvI9HEiI6M0lwxZdkYDfHpsJ57xvcQ3AyjyGT4m6ec2aDa+Z1CcLY0gEhAgTV0QcRrDNmNfMJp608n2w+QnUMjjbMMLz8gzcj6oGYu05e5hDtmWfVZcVr8klOzk5WsSk8AT7doljVJ79Pm2DLf/Ap78UQLVW/6ssA465zCMUBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pZhb4B82; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1736774894;
	bh=AktmW7JFPLzeN3KumqXBxvzZLmczb0J988S02mCLAZw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pZhb4B82c8fAg5lLeiTx59OQZsidzUPI3e8XZUaoze3dry4ZB+8nWtON7V2lzjr4M
	 /rGM7v6K+YDQihy3OiOeDGSM58ykZp+pvHayajiNOCJlSS/3c8BLiH+/EnddzyNUr7
	 SeR+YcdPSvUHbrbsdCLgq1/adDmoWlrwoDKV2PdvyIPYSVV9r8vqP+H0Vk9eXbjbrV
	 3yJC5oT9K1tWYgkepgSSWiKS0GxglHI+8R3f12waD4taa6RTyN62s9ToAhtXyxUDVx
	 YiGaC2Jy4ASLjO6Jo2WFuhztW+DXH4WHvqX/Y/wMI/mSW1USEN4uKChmz8IdVDnmMi
	 XXwfEQjBnxAWg==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1000])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 096AF17E0E9D;
	Mon, 13 Jan 2025 14:28:09 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Mon, 13 Jan 2025 10:27:15 -0300
Subject: [PATCH RESEND v2 4/5] thermal/drivers/mediatek/lvts: Start sensor
 interrupts disabled
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250113-mt8192-lvts-filtered-suspend-fix-v2-4-07a25200c7c6@collabora.com>
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
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.2

Interrupts are enabled per sensor in lvts_update_irq_mask() as needed,
there's no point in enabling all of them during initialization. Change
the MONINT register initial value so all sensor interrupts start
disabled.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 04bfbfe93a71ee9e3428bfd7f8bd359fe9446e88..38668b5b34c7375d3a3b0dcf8dcc965a254776cc 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -65,7 +65,6 @@
 #define LVTS_HW_FILTER				0x0
 #define LVTS_TSSEL_CONF				0x13121110
 #define LVTS_CALSCALE_CONF			0x300
-#define LVTS_MONINT_CONF			0x0300318C
 
 #define LVTS_MONINT_OFFSET_HIGH_INTEN_SENSOR0		BIT(3)
 #define LVTS_MONINT_OFFSET_HIGH_INTEN_SENSOR1		BIT(8)
@@ -951,7 +950,7 @@ static int lvts_irq_init(struct lvts_ctrl *lvts_ctrl)
 	 * The LVTS_MONINT register layout is the same as the LVTS_MONINTSTS
 	 * register, except we set the bits to enable the interrupt.
 	 */
-	writel(LVTS_MONINT_CONF, LVTS_MONINT(lvts_ctrl->base));
+	writel(0, LVTS_MONINT(lvts_ctrl->base));
 
 	return 0;
 }

-- 
2.47.1


