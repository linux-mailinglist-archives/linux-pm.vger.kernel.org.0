Return-Path: <linux-pm+bounces-42655-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6W9eNxe9kGn7cgEAu9opvQ
	(envelope-from <linux-pm+bounces-42655-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 19:21:11 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B0B13CD50
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 19:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3CEB53016502
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 18:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDDC31063B;
	Sat, 14 Feb 2026 18:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3tSl6uk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EF52F6573
	for <linux-pm@vger.kernel.org>; Sat, 14 Feb 2026 18:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771093214; cv=none; b=EBvckuU2sxnH8gYKGF9kpfNOGCWnFg39oQVHl8k97wttV7jpOp8A2E88XUVdRWBeADxghqPrnxLGnmXnbnrAKyHFH36/lqLeL7MlamvTPPTOd7Q7EGXMZsjA1savqv6vr9S7RgG41AeTPLax2oAtcUWIpmBXyYEOxG3HdkR4VVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771093214; c=relaxed/simple;
	bh=07Gfn4DPjwR/0sRoWt/L0WS45nxocPzX2R/645HpccE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQ8wJPob+PB6U7rl8L0xtvZbwcdZyIECy4PX3Nlpoq6gYH58UDxCt0Xy2t5PqiAyK5y/n+yQz1EZNZzH1NKGGW32+v66CfrZ+g0RXlLFjfCq5+nedVVrVp6IrWiHCNj4H7xRxmpW0K75vq0i/Y6Mmo/F10QYHtK0qiVeANNcfUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H3tSl6uk; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2a962230847so16902115ad.3
        for <linux-pm@vger.kernel.org>; Sat, 14 Feb 2026 10:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771093213; x=1771698013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1D1hHSd7ku04iGe6HhlRrD0l+nMik2FyODF+cOhPL3M=;
        b=H3tSl6ukgqmGNaV5RI/ZhI49TbQ0ElOwh3fvlA39g+fvLohj3bZkoYOyX+H/pBbuhd
         BIt6DoekBADSbIETpTtaZkurXTe97/YuGegTBvPdu6hh5yQYhXn3OjfAGbmrT25u9Gs0
         2awIb4aF15PJVpYSeYsuQltsTbnAssuuF1tt3AasZYRb3+o8ucvsn71T4IVdAAp0H4SH
         PnJWbb2qy+8JES0Fnz9YuzEogjn9T+743qaJICSSIDiBYxCRiAhlS9a0QctfhPJl6HfL
         sMGDOpVBbqyyFXB/sPG6n52tLIOoEuOZfrzK//11Orato+/gvyTNzv5Kwyh2BYZzrCT9
         7uuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771093213; x=1771698013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1D1hHSd7ku04iGe6HhlRrD0l+nMik2FyODF+cOhPL3M=;
        b=sga1lGlYKYaPmORduwcWagJ153aHKIP7tdCeVj5tNzuU9gcjxrJfQdVAHcKIV7kvGU
         ktM4UDMjhqYCpISQNafJKnNtfLYsWZTwHyu86BzdVmewFXzc+qzKIFjE0o79jHpCIUTa
         i0eztbP+K3Sxu+Cre77sq4Snd+foK0Dh4+iGrW03UQOR4yzte8WElE1X7OgMKOEdYqta
         8K7fUOuobCAYS+/HaA0CdhYk2MDButq8wduu+Wl8Utkhba0jZnGjL1Zfldy38+S/+ZQS
         KQftClPaCugki5ClBrRz6SydYj0JRoII/0H562XA1LM9pdElv7FMetcelHMGPtY1kIAZ
         YdKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsDsIWXYeAvReu45IEYZb/+xTLLnmWc4DleKvw4ITqui0Av2SAXXpdD6ATA+dwxqZPmK5NFTbz+A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqE6RhLy/kFEIAsvlNE3tmxPCtigLuUfDTi+G80P7OMb8+LRQ7
	imb5IhYfBVeQ5oyCHU8+tLYWuLvb3FRRE4QEgwzuLZ4HW4xDNPnwT6pT
X-Gm-Gg: AZuq6aIWqX8Lr3aKtZV63NdGAcXy4ZM9sipKLFUVh0yoA4pfSd3qSqEGhr4RGGtZMwT
	3RwUYQFm9gfmo3nOY9/8oSXgmT3OvGTummlcOaOMAPGVnNxvHSMBMUWAY7sbjVlm7PWq/M7DvOD
	/+lIcg8r/Sg5opru2qaj1EaABBSU2qpZ5VfhPTFxU1uP+lem3PcxYKVa+G/2RTlblCz20/jUzEZ
	MWUKqptDvnChYKO6W3NtMBEVrT6CMD9TjsdRc2kBrCzjCKeB6M2RFRV3NxR/SCl6+/gQGLSRCaZ
	H8EHczhzdeAEnCqagQ7T4b/NafX6d+4SF2bB+WsKW9DAA6hzaBqtIGtanSP9UtSZbZ2+1ATqdHr
	rwU2udjHfFE30PIwY/x0mMbqvg5GIF14va5EGIRI39llO6DX/DTb0HXY0fyS3rDB5XlaT9lZo3n
	SLevJUZ3ZPKtARxrbRTG8=
X-Received: by 2002:a17:903:1b28:b0:2aa:d39c:d68 with SMTP id d9443c01a7336-2ab50596948mr60204805ad.29.1771093212674;
        Sat, 14 Feb 2026 10:20:12 -0800 (PST)
Received: from rockpi-5b ([45.112.0.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a9d5e06sm28406615ad.50.2026.02.14.10.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 10:20:11 -0800 (PST)
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
Subject: [PATCH v8 5/9] thermal/drivers/exynos: Remove unused base_second mapping and references
Date: Sat, 14 Feb 2026 23:49:02 +0530
Message-ID: <20260214181930.238981-6-linux.amoon@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42655-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D8B0B13CD50
X-Rspamd-Action: no action

The base_second field has been removed from struct exynos_tmu_data
because it was unused. This cleanup also eliminates its mapping in
exynos_map_dt_data() and ensures that TRIMINFO access in
exynos4412_tmu_initialize() consistently uses the base field across
all SoCs. This streamlines the code and optimizes memory usage.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v8: None
v7: new patch in this series,
   Improve the commit message
   simplify the logic to TRIMINFO for all SoC.
---
 drivers/thermal/samsung/exynos_tmu.c | 30 +++++++---------------------
 1 file changed, 7 insertions(+), 23 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 3d12e95703bf..146f29fadea9 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -139,12 +139,11 @@ enum soc_type {
  * struct exynos_tmu_data : A structure to hold the private data of the TMU
  *			    driver
  * @base: base address of the single instance of the TMU controller.
- * @base_second: base address of the common registers of the TMU controller.
  * @irq: irq number of the TMU controller.
  * @soc: id of the SOC type.
  * @lock: lock to implement synchronization.
  * @clk: pointer to the clock structure.
- * @clk_sec: pointer to the clock structure for accessing the base_second.
+ * @clk_sec: pointer to the clock structure for accessing the gpu clk.
  * @sclk: pointer to the clock structure for accessing the tmu special clk.
  * @cal_type: calibration type for temperature
  * @efuse_value: SoC defined fuse value
@@ -172,7 +171,6 @@ enum soc_type {
  */
 struct exynos_tmu_data {
 	void __iomem *base;
-	void __iomem *base_second;
 	int irq;
 	enum soc_type soc;
 	struct mutex lock;
@@ -444,24 +442,17 @@ static void exynos4412_tmu_initialize(struct platform_device *pdev)
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 	unsigned int trim_info, ctrl;
 
-	if (data->soc == SOC_ARCH_EXYNOS3250 ||
-	    data->soc == SOC_ARCH_EXYNOS4412 ||
-	    data->soc == SOC_ARCH_EXYNOS5250) {
-		if (data->soc == SOC_ARCH_EXYNOS3250) {
-			ctrl = readl(data->base + EXYNOS_TMU_TRIMINFO_CON1);
-			ctrl |= EXYNOS_TRIMINFO_RELOAD_ENABLE;
-			writel(ctrl, data->base + EXYNOS_TMU_TRIMINFO_CON1);
-		}
+	if (data->soc == SOC_ARCH_EXYNOS3250) {
+		ctrl = readl(data->base + EXYNOS_TMU_TRIMINFO_CON1);
+		ctrl |= EXYNOS_TRIMINFO_RELOAD_ENABLE;
+		writel(ctrl, data->base + EXYNOS_TMU_TRIMINFO_CON1);
+	} else {
 		ctrl = readl(data->base + EXYNOS_TMU_TRIMINFO_CON2);
 		ctrl |= EXYNOS_TRIMINFO_RELOAD_ENABLE;
 		writel(ctrl, data->base + EXYNOS_TMU_TRIMINFO_CON2);
 	}
 
-	/* On exynos5420 the triminfo register is in the shared space */
-	if (data->soc == SOC_ARCH_EXYNOS5420_TRIMINFO)
-		trim_info = readl(data->base_second + EXYNOS_TMU_REG_TRIMINFO);
-	else
-		trim_info = readl(data->base + EXYNOS_TMU_REG_TRIMINFO);
+	trim_info = readl(data->base + EXYNOS_TMU_REG_TRIMINFO);
 
 	sanitize_temp_error(data, trim_info);
 }
@@ -974,13 +965,6 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	data->base_second = devm_ioremap(&pdev->dev, res.start,
-					resource_size(&res));
-	if (!data->base_second) {
-		dev_err(&pdev->dev, "Failed to ioremap memory\n");
-		return -ENOMEM;
-	}
-
 	return 0;
 }
 
-- 
2.50.1


