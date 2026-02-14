Return-Path: <linux-pm+bounces-42657-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4A3dJUm9kGntcgEAu9opvQ
	(envelope-from <linux-pm+bounces-42657-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 19:22:01 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 318CC13CDA1
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 19:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74A79305043B
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 18:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFB63101CE;
	Sat, 14 Feb 2026 18:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AybXx2PI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A69C30F7EA
	for <linux-pm@vger.kernel.org>; Sat, 14 Feb 2026 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771093228; cv=none; b=NG2M626LKKVafY2R8EKsW+tc1Nmk64Av9JL0sNZnqy89E3LoSosDNT/muCXYtu1hRefkfDmrIXw6xCNy0sr3+0BgjJ3OtgIgyTI7jPGVbJ13wser+JhNC3cMDIDEoHMb0nkZpZx/fCQQktzo3ZAikPTrYBkWBIK9kp0C7Y1JPH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771093228; c=relaxed/simple;
	bh=puR2ZAnhbJTFdaZPK2ZgfUswLeVKzkccy/lRwFKnxWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MzlV1uRb/MjiGzSaDJMBN/0reUkfNxfjaf8IV+3xE2A0EVBNObaRatCTH4t3EIXsakyjSGgOf2GnQq3O14GM7pNVAGW70iNaz/4dF07pLtVw7TlM2SUiucvopzqJO/Si02YUXzhB9/nFTAqASMtwej1Qi40HcdU6r6SDt2OW8IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AybXx2PI; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-c54f700b5b1so1343902a12.0
        for <linux-pm@vger.kernel.org>; Sat, 14 Feb 2026 10:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771093226; x=1771698026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Y1oNWapjfNVh50FsYoZ5SBQ/1IdNgNulUCh0e82XQ4=;
        b=AybXx2PImA03AEMXdTGn4TxSUEVf+ke2PeStwGeDRdPjdUT5FpxiUGVKr+XjTGQrDb
         KMI2xGHi0e5q2BGULKlffkJLAu7QNuyV5FFDW+dwxyYF/nIqWv8FMXhlZV2d8Q16JPxM
         3avsiwT8UHO9FHKqiLNMtPMnF+WsGFMBjItFQWpDwxKdV+9yY7q9CwleWbiDvFoQIoYP
         Uz7KiiI/z5eGftpqrzVLTKWO+kg6QmGv62/wR+vwOag/e3FBaaBcsWdxhkaEqWWm+3YN
         O0RziVcMc2LKUd8WIQCcqFqJkrdo9PGdMew2TNHcXfKnHBEQSbXobELfnYwcOiUq62xk
         5Xqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771093226; x=1771698026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Y1oNWapjfNVh50FsYoZ5SBQ/1IdNgNulUCh0e82XQ4=;
        b=ME91zEzP0YlTcGHOUmGu+giZ8jsMAmwthdG60Iee7Ho6KvRX4tWwnks4ktnbKhASmR
         qzZ76ZMgf5CUgSBOtWTKtmwvPvFHPdtDCACfM4ZkBqVKMu0mgepqnWilgi6zAe+8fSbR
         g+MigtUSl0SQNi5I7raM7yj/+jtQJ24cwZie3kkui13yPoEFqhv8teLq4NF3gJBvYwdd
         214HIqJLyefgIy6I+ppNkp1CwjVHMYNX+mTa8JF6pG0kFMhnt3g9305E0bqGReeROAR7
         ad2cgp8mUdEyDutn0Bn1/IJkYqgmYqS9W8XGzdIIM7hgOVF2+YfDzbONmKmvbGVjKUx+
         FgEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOdS9HsBfnm5Vi9hrVoksnDK12ehiJTuvrZotikyXDoVujnsNCe451kIXP9LrHgnWg6tMyUZ2Pfw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzz4Fg8UB+z32Vk7ss2ZNTioT03Dx+zlTDpzpsxBDtTF7fvqPN
	AAyjIs0Uo9D8L91GZRSZ4+G7IjmxrOTVE0Ex0taZknpod1q+7wnUMZZA
X-Gm-Gg: AZuq6aJFylTCXy2buRrG1O1HyM3rtFmuwRN7R/3lUu5N4QBj5KG1OU6h43JWhBi7/kV
	kOUumKRZdxPp9/ux5Qm3cMCqGuND6t849x77ZqZHnLvsRWHKczWoJHgNu3zs1xQDCV9lgJCCaEs
	h6+98DfIGmVogZmAZKdD9fzx44fYCH3+qjnLs49TR0esD7IuxXzRvG7n23MvXIshTC8g6mdNN9h
	4OQ1C/C1oKLy+zZnuCpoR6JX9OmJg9yNHuU2zv1CuenFMROS0ipcv7hjzRjxrCg5+BuvWe7KhfA
	YzuZhCMCRtVvr5H/fETnys+igKexjyNshFmE054pkwMsgICbflFLCQHVO6eNMzeFekea6oNLrhG
	pUZ6k52z/OGuh9oFe+wLkJhZ5nvs/1wOoDcrLKdmhmfbs/GyFhRsD/jiniMtXVQLXJKMSpY61i0
	aG2WS+ZyUPMNgXhF2Ochg=
X-Received: by 2002:a17:903:1107:b0:2aa:e0c4:c076 with SMTP id d9443c01a7336-2ad17596f38mr36024625ad.54.1771093226306;
        Sat, 14 Feb 2026 10:20:26 -0800 (PST)
Received: from rockpi-5b ([45.112.0.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a9d5e06sm28406615ad.50.2026.02.14.10.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 10:20:25 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-pm@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
	linux-samsung-soc@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v8 7/9] thermal/drivers/exynos: Relocate exynos_sensor_ops for forward declatition
Date: Sat, 14 Feb 2026 23:49:04 +0530
Message-ID: <20260214181930.238981-8-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260214181930.238981-1-linux.amoon@gmail.com>
References: <20260214181930.238981-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42657-lists,linux-pm=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,linaro.org,intel.com,arm.com,samsung.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linuxamoon@gmail.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 318CC13CDA1
X-Rspamd-Action: no action

Relocate exynos_set_trips() and exynos_sensor_ops to a different
position in the file to resolve forward declaration dependencies
for register to pointer to thermal_zone_device structure.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v8: new patch.
---
 drivers/thermal/samsung/exynos_tmu.c | 56 ++++++++++++++--------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index f77abdcdc62b..1d657802a310 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -808,6 +808,34 @@ static void exynos4210_tmu_clear_irqs(struct exynos_tmu_data *data)
 	writel(val_irq, data->base + tmu_intclear);
 }
 
+static int exynos_set_trips(struct thermal_zone_device *tz, int low, int high)
+{
+	struct exynos_tmu_data *data = thermal_zone_device_priv(tz);
+
+	mutex_lock(&data->lock);
+	clk_enable(data->clk);
+
+	if (low > INT_MIN)
+		data->soc_config->tmu_set_low_temp(data, low / MCELSIUS);
+	else
+		data->soc_config->tmu_disable_low(data);
+	if (high < INT_MAX)
+		data->soc_config->tmu_set_high_temp(data, high / MCELSIUS);
+	else
+		data->soc_config->tmu_disable_high(data);
+
+	clk_disable(data->clk);
+	mutex_unlock(&data->lock);
+
+	return 0;
+}
+
+static const struct thermal_zone_device_ops exynos_sensor_ops = {
+	.get_temp = exynos_get_temp,
+	.set_emul_temp = exynos_tmu_set_emulation,
+	.set_trips = exynos_set_trips,
+};
+
 static const struct exynos_tmu_soc_config exynos3250_data = {
 	.soc = SOC_ARCH_EXYNOS3250,
 	.tmu_set_low_temp = exynos4412_tmu_set_low_temp,
@@ -1008,34 +1036,6 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 	return 0;
 }
 
-static int exynos_set_trips(struct thermal_zone_device *tz, int low, int high)
-{
-	struct exynos_tmu_data *data = thermal_zone_device_priv(tz);
-
-	mutex_lock(&data->lock);
-	clk_enable(data->clk);
-
-	if (low > INT_MIN)
-		data->soc_config->tmu_set_low_temp(data, low / MCELSIUS);
-	else
-		data->soc_config->tmu_disable_low(data);
-	if (high < INT_MAX)
-		data->soc_config->tmu_set_high_temp(data, high / MCELSIUS);
-	else
-		data->soc_config->tmu_disable_high(data);
-
-	clk_disable(data->clk);
-	mutex_unlock(&data->lock);
-
-	return 0;
-}
-
-static const struct thermal_zone_device_ops exynos_sensor_ops = {
-	.get_temp = exynos_get_temp,
-	.set_emul_temp = exynos_tmu_set_emulation,
-	.set_trips = exynos_set_trips,
-};
-
 static int exynos_tmu_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-- 
2.50.1


