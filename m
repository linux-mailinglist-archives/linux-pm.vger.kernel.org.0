Return-Path: <linux-pm+bounces-9802-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0C791327B
	for <lists+linux-pm@lfdr.de>; Sat, 22 Jun 2024 09:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 804BCB24F27
	for <lists+linux-pm@lfdr.de>; Sat, 22 Jun 2024 07:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A31914B095;
	Sat, 22 Jun 2024 07:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="l+xIVo97"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E93537F8;
	Sat, 22 Jun 2024 07:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719040456; cv=none; b=NQ9ajdEExcKIu7nEA3+8fHjVzmkG5N+VnCGpvSNeOUDDu/zTIHIMMt3ywsWdETdHjae8EtE/Cx4Zexx6t4Z544U/Gze1+ppeSHwWPSzzJA3YNJZZ9cZICARX3fXB54qP/m9ZKVwglGCTyfmMn+Cekz+iz8eNF6tNo1p61MhsNJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719040456; c=relaxed/simple;
	bh=ROtwTlkG5cpabYHy2Yp6KPPdQ7Q5s4LOJtozgevhba8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BewuSJLjmCnQnKPH5zHk+LS0nOOMU8ag5YcnX5tbLe7JPGhYcY1GMUVoQoIngmAdRYSVu5QbeFWB9YxGihHxcySAXiW5rkJQ2DCd78J3YGCc5nQsyzLdHGkztZOIHZEBCzibzkWRwUDVLJa5lpIWfz9BOt4KdrfHPvlFmg78/Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=l+xIVo97; arc=none smtp.client-ip=80.12.242.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.222.230])
	by smtp.orange.fr with ESMTPA
	id KuntsjGzHYBZjKuo3snU8T; Sat, 22 Jun 2024 09:05:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1719039903;
	bh=hkwN7e4nEYE8MOWatiktMuM7kfiZknW69Gg487q2Y7g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=l+xIVo97ZQwQ2Rzu9nZe38QJHneGV5De3NYCSnp/F/F2oUeuw11HKwjDvaThw1NlC
	 oFPptBag12wwq7LTWgsG8SJlkiuwKdbkuF8neIO+qhdQ9IxiJJX0Km62j+zBqmEAVb
	 VB7IaQAL+IcC1PYEBPiZOm9r5zDfGFXNJ1u5blyRfPthZnfzvOF5BNR3hH0wBEJp2s
	 q6GtIMnOtleVKfQXOncQF4KyyuUQvbVXnUDmbSxkTySXiaYYxCB4bvBHB/W02YuO4U
	 ha8t5U//cKUjIKtO7vkonfooaosuIzv4M3GgHIOhiG0elPAgL/BPqdHnPgYx/gqV7F
	 NDNzFam6OWmMA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 22 Jun 2024 09:05:03 +0200
X-ME-IP: 86.243.222.230
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: linus.walleij@linaro.org,
	sre@kernel.org,
	jic23@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/3] power: supply: ab8500: Use iio_read_channel_processed_scale()
Date: Sat, 22 Jun 2024 09:04:25 +0200
Message-ID: <5668d73b92eb6318c7f094a9a8fa914c909485ca.1719037737.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1719037737.git.christophe.jaillet@wanadoo.fr>
References: <cover.1719037737.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of rescaling current or voltage channels after the fact, use the
dedicated scaling API. This should reduce any inaccuracies resulting from
the scaling.

This is also slightly more efficient as it saves a function call and a
multiplication.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
It is inspired by:
  https://lore.kernel.org/all/20240620212005.821805-1-sean.anderson@linux.dev/
---
 drivers/power/supply/ab8500_charger.c | 28 +++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index 4b0ad1b4b4c9..2f06b93682ac 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -487,7 +487,9 @@ static int ab8500_charger_get_ac_voltage(struct ab8500_charger *di)
 
 	/* Only measure voltage if the charger is connected */
 	if (di->ac.charger_connected) {
-		ret = iio_read_channel_processed(di->adc_main_charger_v, &vch);
+		/* Convert to microvolt, IIO returns millivolt */
+		ret = iio_read_channel_processed_scale(di->adc_main_charger_v,
+						       &vch, 1000);
 		if (ret < 0) {
 			dev_err(di->dev, "%s ADC conv failed,\n", __func__);
 			return ret;
@@ -495,8 +497,7 @@ static int ab8500_charger_get_ac_voltage(struct ab8500_charger *di)
 	} else {
 		vch = 0;
 	}
-	/* Convert to microvolt, IIO returns millivolt */
-	return vch * 1000;
+	return vch;
 }
 
 /**
@@ -541,7 +542,9 @@ static int ab8500_charger_get_vbus_voltage(struct ab8500_charger *di)
 
 	/* Only measure voltage if the charger is connected */
 	if (di->usb.charger_connected) {
-		ret = iio_read_channel_processed(di->adc_vbus_v, &vch);
+		/* Convert to microvolt, IIO returns millivolt */
+		ret = iio_read_channel_processed_scale(di->adc_vbus_v,
+						       &vch, 1000);
 		if (ret < 0) {
 			dev_err(di->dev, "%s ADC conv failed,\n", __func__);
 			return ret;
@@ -549,8 +552,7 @@ static int ab8500_charger_get_vbus_voltage(struct ab8500_charger *di)
 	} else {
 		vch = 0;
 	}
-	/* Convert to microvolt, IIO returns millivolt */
-	return vch * 1000;
+	return vch;
 }
 
 /**
@@ -566,7 +568,9 @@ static int ab8500_charger_get_usb_current(struct ab8500_charger *di)
 
 	/* Only measure current if the charger is online */
 	if (di->usb.charger_online) {
-		ret = iio_read_channel_processed(di->adc_usb_charger_c, &ich);
+		/* Return microamperes */
+		ret = iio_read_channel_processed_scale(di->adc_usb_charger_c,
+						       &ich, 1000);
 		if (ret < 0) {
 			dev_err(di->dev, "%s ADC conv failed,\n", __func__);
 			return ret;
@@ -574,8 +578,7 @@ static int ab8500_charger_get_usb_current(struct ab8500_charger *di)
 	} else {
 		ich = 0;
 	}
-	/* Return microamperes */
-	return ich * 1000;
+	return ich;
 }
 
 /**
@@ -591,7 +594,9 @@ static int ab8500_charger_get_ac_current(struct ab8500_charger *di)
 
 	/* Only measure current if the charger is online */
 	if (di->ac.charger_online) {
-		ret = iio_read_channel_processed(di->adc_main_charger_c, &ich);
+		/* Return microamperes */
+		ret = iio_read_channel_processed_scale(di->adc_main_charger_c,
+						       &ich, 1000);
 		if (ret < 0) {
 			dev_err(di->dev, "%s ADC conv failed,\n", __func__);
 			return ret;
@@ -599,8 +604,7 @@ static int ab8500_charger_get_ac_current(struct ab8500_charger *di)
 	} else {
 		ich = 0;
 	}
-	/* Return microamperes */
-	return ich * 1000;
+	return ich;
 }
 
 /**
-- 
2.45.2


