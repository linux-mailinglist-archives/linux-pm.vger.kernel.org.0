Return-Path: <linux-pm+bounces-9803-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FFC91327E
	for <lists+linux-pm@lfdr.de>; Sat, 22 Jun 2024 09:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E9E2B252E5
	for <lists+linux-pm@lfdr.de>; Sat, 22 Jun 2024 07:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780D914B09F;
	Sat, 22 Jun 2024 07:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="smE3l+DU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1990C537F8;
	Sat, 22 Jun 2024 07:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719040464; cv=none; b=medlVd0BhsPYWQ9HfcbfxgIGxdE01hWrIjbZEPOwXv/QqEhVTgpcdk3CONu/YLrruyQknTrbrec/Ac8O7YNrd0rohc1gkw/hGr0OCCgziybTCNfqNhrU46vRwxs2JCHDwseGuBhT/y0GsxYwVlDTK3RzqaP9C4hXk+n/msXGg8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719040464; c=relaxed/simple;
	bh=o+9+J9YMKQ5edY0HHEWToSepgGfJ24sYi1botHS2wM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NxL5B3kwefSn2jmWh4/tzhMPu4N24r83RYlKBjDeHznZlI3+JUkNSDq/xft0rEb0ni2PBQeG/se/h8t3GxD5pNRxbMxW4PTycP5je87aGC04ZvAL+ocV30LWp1zF1IMQiuOlqjScSGrNuniuKfydpWqPWAmV8nZF5a2SIfTzz1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=smE3l+DU; arc=none smtp.client-ip=80.12.242.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.222.230])
	by smtp.orange.fr with ESMTPA
	id KuntsjGzHYBZjKuo5snU8l; Sat, 22 Jun 2024 09:05:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1719039905;
	bh=iP+T2nUGdzwqIY61OldE2CGAadfgcHPDOk3hUvLcllw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=smE3l+DU7iZemJAaglX1DgD6ScomIRoESFyU8l4n845t8kflqLlW7e9RORM8/JoYa
	 /v+3RR1wQ0ZswYIIVSHJbICfVNnBxZn8/c1F8GeL2s5c8Ohn89unngG+Wj1drjYRBP
	 sw7kzJfrqvU/QbNhXvvPh0KjgRZsUyIHGkaYdsj3e8rvWnLKBv3lD07lBHKrndFSAI
	 6Q8cmevwXOFU3p8W9iY7xGsXXinmDmk4GkDzGqU+VIIeh+F6i86OJpL+cUyJHqipcF
	 +0JUQW9/s4rdubJNb6qq2LFoT8CyXtYbfbzIhiTxQwmhYWL6fU0I3YYMX/ymeZSnxX
	 KE2PfGoMXGCDg==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 22 Jun 2024 09:05:05 +0200
X-ME-IP: 86.243.222.230
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: linus.walleij@linaro.org,
	sre@kernel.org,
	jic23@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 3/3] power: supply: ab8500: Clean some error messages
Date: Sat, 22 Jun 2024 09:04:26 +0200
Message-ID: <e7ac0fa83c6100cbe4e0efa90cf99291c2423b10.1719037737.git.christophe.jaillet@wanadoo.fr>
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

There is an useless extra comma at the end of some error messages, remove
them.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/power/supply/ab8500_charger.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index 2f06b93682ac..93181ebfb324 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -491,7 +491,7 @@ static int ab8500_charger_get_ac_voltage(struct ab8500_charger *di)
 		ret = iio_read_channel_processed_scale(di->adc_main_charger_v,
 						       &vch, 1000);
 		if (ret < 0) {
-			dev_err(di->dev, "%s ADC conv failed,\n", __func__);
+			dev_err(di->dev, "%s ADC conv failed\n", __func__);
 			return ret;
 		}
 	} else {
@@ -546,7 +546,7 @@ static int ab8500_charger_get_vbus_voltage(struct ab8500_charger *di)
 		ret = iio_read_channel_processed_scale(di->adc_vbus_v,
 						       &vch, 1000);
 		if (ret < 0) {
-			dev_err(di->dev, "%s ADC conv failed,\n", __func__);
+			dev_err(di->dev, "%s ADC conv failed\n", __func__);
 			return ret;
 		}
 	} else {
@@ -572,7 +572,7 @@ static int ab8500_charger_get_usb_current(struct ab8500_charger *di)
 		ret = iio_read_channel_processed_scale(di->adc_usb_charger_c,
 						       &ich, 1000);
 		if (ret < 0) {
-			dev_err(di->dev, "%s ADC conv failed,\n", __func__);
+			dev_err(di->dev, "%s ADC conv failed\n", __func__);
 			return ret;
 		}
 	} else {
@@ -598,7 +598,7 @@ static int ab8500_charger_get_ac_current(struct ab8500_charger *di)
 		ret = iio_read_channel_processed_scale(di->adc_main_charger_c,
 						       &ich, 1000);
 		if (ret < 0) {
-			dev_err(di->dev, "%s ADC conv failed,\n", __func__);
+			dev_err(di->dev, "%s ADC conv failed\n", __func__);
 			return ret;
 		}
 	} else {
-- 
2.45.2


