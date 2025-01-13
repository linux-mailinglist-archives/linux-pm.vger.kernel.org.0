Return-Path: <linux-pm+bounces-20334-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59565A0B822
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 14:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E0433A73F1
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 13:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22663233D90;
	Mon, 13 Jan 2025 13:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ghhsYwpk"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E2B23DE92;
	Mon, 13 Jan 2025 13:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736774902; cv=none; b=PmxzFjSaM5iaWyRvD+Zbtd0sgNMadiTcJRCv6nI7DKFChdYp7u/d8WtUyVepEL5PitHqk6TsSszbuP6D9jPWGEbZ1nQpdw6jC5qbwp3vP6HVO0HPII/KXqR8hfsFRNq4U05ZynASrTbtO2NT/vXV1dMpbjaO5U8N76qzn4DWaXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736774902; c=relaxed/simple;
	bh=lW1axWGwqjml20H6LdTNuoi+6eJxj6sq/fDlSzC6y+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=im7yerzvcI6lUTaORpkNyb5zcmA80Bbdx7j9OKXTDxi2b/dcRxnJCnBZFn1oGTiSgHPR/sNHyGYM8Buavz3bodPa4Gan7t/0nc3FGu2AaDBOIckMm0AiGxlkwAD5v0HDwVkw8TdD3fIA8bv9bo/HRrH8ht+5f7iUX7EOQqFkmk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ghhsYwpk; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1736774898;
	bh=lW1axWGwqjml20H6LdTNuoi+6eJxj6sq/fDlSzC6y+E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ghhsYwpkE4VfJ2vCBAbRQhhvm/6WsodbS7qTUfdeaSncn5wLZE7+2L3g2I8CvHyqy
	 W22Gu1zqdAeUXxeJABjLXoJ4uLqDCJ6hxtZH6J1BwM2Ik0QGe30aY7gIVd7vJ/T+w8
	 12pruuiXmXsXedH4AbOy0uHix3ukxqD1sDnuipMZE4ZqZKoP/bRVX+Woju/GQxS17e
	 F9hx81HbMoum3iBtPZ+iJVCtf40zd+Sn+I8hjoo7j23uXBTpNYCeUPjHPi1Sd0PrTr
	 a1CUttmISg65RplBiu5n0RdM+dHjz9vRLTnV6Pj1OthLL02DcZuyTQzEPNCAiHajft
	 Ww1LpYe7+iqpQ==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1000])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7E94917E0DD3;
	Mon, 13 Jan 2025 14:28:14 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Mon, 13 Jan 2025 10:27:16 -0300
Subject: [PATCH RESEND v2 5/5] thermal/drivers/mediatek/lvts: Only update
 IRQ enable for valid sensors
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250113-mt8192-lvts-filtered-suspend-fix-v2-5-07a25200c7c6@collabora.com>
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
2.47.1


