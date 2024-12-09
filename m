Return-Path: <linux-pm+bounces-18842-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C860F9E9C71
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 18:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E728168238
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 17:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA531F0E52;
	Mon,  9 Dec 2024 17:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OzJBv+B3"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A081F0E49;
	Mon,  9 Dec 2024 17:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733763651; cv=none; b=NnJlT8i1qcFp2WdvCs6Lq8mAMGrXx3NOqwAUf1QsL3vQ3rrB6/4FDw6S6kCJgNZHCjfHKsS8nm5EBoV8ngVTuS15rVgmR/e/XCCnNEn8qOOek2eD1nrtdGNKK8r26b4AI9Mq6Y7l20yw50ZaUfUgt4dZpaQmi/pdfg7aINrnPuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733763651; c=relaxed/simple;
	bh=aiDivIqNPWrEAznb447RKc5XOvk3UR3b13+v8yLgwj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EL8Ttsuzge3hhCVCOehTtjrBj1oCLv5Hp8vU6vfKpnJi3YCR81T2KvwZ+nrhsBpbzSoCud313N7wtbc/g1Rj2R3V5bCIaSts9h8QbQ2J2UrONEF03e69WAO5xoOaWY+bpQXympJQOvJhuOn2Ltap8U3mDVu2TX+a+vRsTKJePLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OzJBv+B3; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733763647;
	bh=aiDivIqNPWrEAznb447RKc5XOvk3UR3b13+v8yLgwj4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OzJBv+B3JvRHA6tIebLfaKSSfSWFPJ7NCrG2pDgjkcaGBUtZvAg01CC6Km4ZsNAqJ
	 pYe9sEl5n5Njz/65mWU+o9pZjfpUHvmv0/sdVSPDFNJ1kSLNJMPXoBjOta9DQ739m2
	 8qBn5ItjUBNNYd1k9DUVwi6y4K6ps36Obu1OocGqu3zkud+7e9eQPpaIURwUjrWREa
	 Y3EmbdUpohdfabZVZ8W4PWwhTMGFzfnyNMjQX+Ja0rT1X2f3JNsxqy6WO7jew1BiIh
	 ndTwmByfpM8p3hTol2FiHxHA1olXDPWEzM6OujSV8QiAtli1tkhf0YLQFRAGQe/P8a
	 xKHRLY3/wViZA==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DDCE317E37C6;
	Mon,  9 Dec 2024 18:00:42 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Mon, 09 Dec 2024 14:00:06 -0300
Subject: [PATCH v2 5/5] thermal/drivers/mediatek/lvts: Only update IRQ
 enable for valid sensors
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241209-mt8192-lvts-filtered-suspend-fix-v2-5-5b046a99baa9@collabora.com>
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
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.2

Only sensors that are valid need to have their interrupts enable status
updated based on their thresholds. Use the lvts_for_each_valid_sensor()
helper in lvts_update_irq_mask() to ignore invalid sensors.

Currently, since the invalid sensors will always contain zeroed out
thresholds (from kzalloc), they will always get their interrupts
disabled on this loop. So this commit doesn't change the resulting
interrupts configuration, but it slightly optimizes the loop by skipping
the invalid sensors, avoids potential future surprises if at some point
memory is no longer allocated for invalid sensors, as well as makes the
code more obvious.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 38668b5b34c7375d3a3b0dcf8dcc965a254776cc..088481d91e6e294a31fac7ceed7f3ff62ee3a98d 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -346,7 +346,7 @@ static void lvts_update_irq_mask(struct lvts_ctrl *lvts_ctrl)
 
 	value = readl(LVTS_MONINT(lvts_ctrl->base));
 
-	for (i = 0; i < ARRAY_SIZE(masks); i++) {
+	lvts_for_each_valid_sensor(i, lvts_ctrl) {
 		if (lvts_ctrl->sensors[i].high_thresh == lvts_ctrl->high_thresh
 		    && lvts_ctrl->sensors[i].low_thresh == lvts_ctrl->low_thresh) {
 			/*

-- 
2.47.0


