Return-Path: <linux-pm+bounces-8588-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06ED58FB974
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 18:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B6971F26971
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 16:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D63148FE6;
	Tue,  4 Jun 2024 16:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ADuKDlrc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAF014883E
	for <linux-pm@vger.kernel.org>; Tue,  4 Jun 2024 16:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717519640; cv=none; b=Y++aX2pMeM0dIuYwF5+fEuUcJVLDOvOApi3UsAu3lHBsinSDBEY6qLnFOf+NJFu0ZXo11y7lyc2Z2SW6gQVJZw+eDsmUmDUA9VszApL/7jVOX3kfHGWkFFw7bqK+I3ku9YUNKpV1ibIvrC/r1yBItpZRtm+c/tXloMG/Hzo4D5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717519640; c=relaxed/simple;
	bh=fEeSbzfW7og883E6MMBCf0UFNWwK83m/m3pTbV2VcBY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=M+J6sC9VroKSTrv7QtC44+NmqNCtdw7r3/MazbMePHVyvIag8KgmtsSz0Fg+kFRuhElagZqpbEqQhKR1Qc4mJvI94npS4XFyYHlJUIwN7LITsxcLa9t2WoVE3ueJ2sUPj+wlk1Xyo1KPcDI2WxmnkI3xKrJMNOb2ACKKPiP5aKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ADuKDlrc; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57a1fe63947so5312607a12.1
        for <linux-pm@vger.kernel.org>; Tue, 04 Jun 2024 09:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717519636; x=1718124436; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f0ESKMQFpm4YiLCeUzvQbkRJki5AHo+qK/u6Y+vz6Y8=;
        b=ADuKDlrccR1+FOA3CSFbfFHd9K/1iH0yRLokQ49zmFbqIS0VeZbn17bOmDR1QPEOMT
         NYZQCIIt5HUHsk+1ToqccBRKdYX0x2REoSsP+Ar4n0eKQJGYhHpLw0zFBxfpwd2s7DpM
         gKP3R6/NPYQaDqOc5L8mcJwTQBIudy68im0ksOtqII+1xbqFLHgJeAoFFRiQvwna6jU+
         /c7BmJe1Jf52oulH4oVhEaE46ETd6S62H+t/kThHyrkLh0VkMBMEggFfZPqp35oB1oYb
         zUESbLMvskpmzUsFiQXmV/wkEKzAQMJP6DreLVaSsARfIJX9Yh0nDRIFfZ9MyK8IYJOe
         q15w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717519636; x=1718124436;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f0ESKMQFpm4YiLCeUzvQbkRJki5AHo+qK/u6Y+vz6Y8=;
        b=YUsw85AmsWaI+TNY8J3zs6Rl9UZ90hlRoIL6Nb7DCgSog7p5cpi+ZsZw+2BtevYSL6
         oeu/3I8XFUhMBeN+agwri0M2wQJfQ49JO/wrnRmu40GiyxIlNaWoCs410Wd+yCDy0tn9
         InzLG8UjNE2rcUxtXbo9TzatSEsSHyvrxdg7IAzIpEaU6VEjeGjeI87W2/mNU0yDWqTW
         7M9v60CF439XKwYN1LTy2CH4AaE9xKIwIOhOslNt0D6cV/88fVa8/UMJ+Z6ZJxZ+df6l
         d16E/3visLras3YNN1KgmuMeg4cmaki3Sj8YsfbKZKmZM+3epBEC/2j03YRNfyyRQgzl
         222A==
X-Gm-Message-State: AOJu0YybDFA25pROrVw1GK5/ePBiRjgHUqhwdS7+m+L2prBlq39U/wJP
	2goDwvYAiWOlL9qKNDEN1IQtW8inUYOmQQEJbuXiahDufLGN+90n2tb21qkZEygT3DIJIIui+Fm
	T
X-Google-Smtp-Source: AGHT+IFEPd0Vtbd+VXJMfTA36KaKJHIzdgkRVLIFSS5iHePEF4hFxrrXE82EzlfPdPNon9Pquk4nwQ==
X-Received: by 2002:a50:a411:0:b0:57a:4b31:5d7c with SMTP id 4fb4d7f45d1cf-57a8b6b7e3dmr105648a12.19.1717519635848;
        Tue, 04 Jun 2024 09:47:15 -0700 (PDT)
Received: from [127.0.1.1] ([84.102.31.231])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a3968bdb7sm7291358a12.46.2024.06.04.09.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 09:47:15 -0700 (PDT)
From: Julien Panis <jpanis@baylibre.com>
Date: Tue, 04 Jun 2024 18:46:58 +0200
Subject: [PATCH v2] thermal/drivers/mediatek/lvts_thermal: Return error in
 case of invalid efuse data
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240604-mtk-thermal-calib-check-v2-1-8f258254051d@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAFFX2YC/4WNSw7CMAxEr1J5jVGShi5YcQ/UReK6xOoPJVVEV
 fXuhF6A5ZvRvNkhcRROcK92iJwlyTIXMJcKKLj5xShdYTDKWNWoGqd1wDVwnNyI5EbxSIFpQO8
 Mk7FOU22grN+Re/mc5mdbOEhal7idR1n/0v/OrFHjrWt8r6yy2tLDu63Uka+0TNAex/EFcms9U
 sEAAAA=
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Nicolas Pitre <npitre@baylibre.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Julien Panis <jpanis@baylibre.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717519634; l=1587;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=fEeSbzfW7og883E6MMBCf0UFNWwK83m/m3pTbV2VcBY=;
 b=cLEAzCE+q/hlZXnwOs3Z0gAUMVPvwZApsPRLT5AzjW3HNJ27YxRfcwRnYZkWI5avHQFon6E/2
 GGk0D05B68pCh+oeaWZfQt7ze5LG8FokCaZHE17FRCX+sMr2p3SF0kY
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=

This patch prevents from registering thermal entries and letting the
driver misbehave if efuse data is invalid. A device is not properly
calibrated if the golden temperature is zero.

Fixes: f5f633b18234 ("thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver")
Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
Guard against invalid calibration data, following this discussion:
https://lore.kernel.org/all/ad047631-16b8-42ce-8a8d-1429e6af4517@collabora.com/
---
Changes in v2:
- Add Fixes tag.
- Link to v1: https://lore.kernel.org/r/20240603-mtk-thermal-calib-check-v1-1-5d6bf040414c@baylibre.com
---
 drivers/thermal/mediatek/lvts_thermal.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 0bb3a495b56e..185d5a32711f 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -769,7 +769,11 @@ static int lvts_golden_temp_init(struct device *dev, u8 *calib,
 	 */
 	gt = (((u32 *)calib)[0] >> lvts_data->gt_calib_bit_offset) & 0xff;
 
-	if (gt && gt < LVTS_GOLDEN_TEMP_MAX)
+	/* A zero value for gt means that device has invalid efuse data */
+	if (!gt)
+		return -ENODATA;
+
+	if (gt < LVTS_GOLDEN_TEMP_MAX)
 		golden_temp = gt;
 
 	golden_temp_offset = golden_temp * 500 + lvts_data->temp_offset;

---
base-commit: 632483ea8004edfadd035de36e1ab2c7c4f53158
change-id: 20240603-mtk-thermal-calib-check-ba2ec24a1c32

Best regards,
-- 
Julien Panis <jpanis@baylibre.com>


