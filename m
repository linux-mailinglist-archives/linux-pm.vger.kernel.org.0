Return-Path: <linux-pm+bounces-17266-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D24609C2D42
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2024 13:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02C1A1C20DE4
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2024 12:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD88198E78;
	Sat,  9 Nov 2024 12:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2KXXQ3m"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EEF198822;
	Sat,  9 Nov 2024 12:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731156289; cv=none; b=bM3IEUfro+8nyuYExgHwgCOkg0AE4ZfKNHRiaMBJzYwMZdtUS+hj8oJQgdwyUQolWWqE1D75phxSmFb7IRS15Tw1XFWGaF54GSm2mY3K2I+fwe1+twA1CLBIXY0FjwGs6DRoWgASmmQO4tWLAZp1tLxrfIyrMXnjtNTbxDDYyCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731156289; c=relaxed/simple;
	bh=mseh9WRqz5C4m+dJG3gKVqO4w2mq1wg/wZdf/mAK3Mc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hG9C6OG39iMEqiFXlDWQ8ZX47dlutHAj2uhe6A54YotqlYU66loeVOhrp5+1XqGpFVzepRLlHjmK3/FN0HPjhLA6L1inG4K8bL/cFhM7QbzgDvwiaif0HDS52tGoOVBSlIgvprRrVJHNUq6hlw9EcW9NtGMPAeR/3MoZV3nOaGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2KXXQ3m; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9ed49ec0f1so522813566b.1;
        Sat, 09 Nov 2024 04:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731156286; x=1731761086; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6NYjmB31gxcjk36kydLhN1LaoAFU9bSgURFqpBpxQVM=;
        b=U2KXXQ3mZ8B2bHY76oVjLFsJvZ1VH53RuxisGu8rMCfmkTqV2XC4qhdqksEgGbrcHK
         mXnQYPBIyWd8G6v+eeeGK/vdcq+rqKb7bHLEgUGJU8rZo9VEnV1izu3f5000tbPAAoI1
         i2/MAeXK11xYcC4fAQhudzApVcMDD0d4QbuPUENsZ87gARjgZklMKgh4Cs59MokT6BQT
         nqBP7PFVkJEqbSugk5LUg1vi6RTmX7LXrqcov9smWC0Ks+d93etnFbu31cWXYQPm7d+Q
         aT5wMcg0FwvFicpILr8IRVWeHzmNxen6TdUNL+a1ULiApl0W33xrQjNpEycrET51bi1a
         iVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731156286; x=1731761086;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6NYjmB31gxcjk36kydLhN1LaoAFU9bSgURFqpBpxQVM=;
        b=T3Q3IWXlYhtZk4u6MBQp0x5ObDWxMhbGw8mbV2405p027ezSc2VhDdKdtCQj13q3I3
         HdgFKinqy5Cl+iZYeFabFH4UO5uaWOXMBkMlhTHJM/JYcb+USIEfu/rmT/mVaSilHf18
         bnWgRPTe58mgkC7zBF346e/1fjzeWrwqMeJEaqVVxzbJ4KaYfoxGSSghTA6RFklnoXya
         imeomM+d3L8k7NujpftzvsGfngJ2iExLz/EEFYQoPjeUcVQEcDIH/bbRR1ccxUDI60lL
         28G+uIX92i3jjaa2eDGfsFotTKQ7gcRJGcS+pi8VVP3MfI+ZbVV4ZGi63/FWQDYPU8m/
         xMig==
X-Forwarded-Encrypted: i=1; AJvYcCU+QsPjVV9KYDP2EFDf5j0u+04HBfg7GczK5t6n44wwTHdHG/sZW+Xbb3Rs1nJ3pqdW+9x4/VHHCVlA@vger.kernel.org, AJvYcCU8Zk36m1wFU2kVGDKU5h71j4hUd9B/XLsNBCAjvi2xIDVLSrx6f0Udo+5pANEfjBsZX4ebcHtDY7TXKeGOPqlZKak=@vger.kernel.org, AJvYcCVwMeUKWQiFJme71Vv8dZpOvb0wIICbqic/HNZFl2mGUy9uXZgw6HCpPNVDkBnNhCZQeHnfe6/iMnq0tpDO@vger.kernel.org, AJvYcCX0Io8V2qfhUiqjDOohRY8IHlDffVEP8Y0xMyjw87DgtWAmSOoo4Q3nP3bR9CLzQOveodoeTdPR/6klYQstoA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzN76wyNhTw/o1OxJeNS/m/rIRF+KPR9dP3WuJtntVcp4PJ7tKs
	LND5+LZPhHF3+qeO4jgnPGADsoMVC5inipRgtVaZbTsk6f+6gJ4Sp84NPP+h
X-Google-Smtp-Source: AGHT+IHmuYr9plCibE5R6SWQvYCuz+uxGfvZMDTXTYfiyiiZ0cPupHyPtkL4o3yovyQ65WSVh8GayA==
X-Received: by 2002:a17:907:7d8e:b0:a99:f183:ea8a with SMTP id a640c23a62f3a-a9eeff40bb9mr643164866b.28.1731156286012;
        Sat, 09 Nov 2024 04:44:46 -0800 (PST)
Received: from [127.0.1.1] (leased-line-46-53-189-50.telecom.by. [46.53.189.50])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03b5d793sm2940166a12.17.2024.11.09.04.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 04:44:45 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Sat, 09 Nov 2024 15:44:34 +0300
Subject: [PATCH 2/4] power: supply: max17042: implement dts shared-irq
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241109-b4-max17042-v1-2-9e2b07e54e76@gmail.com>
References: <20241109-b4-max17042-v1-0-9e2b07e54e76@gmail.com>
In-Reply-To: <20241109-b4-max17042-v1-0-9e2b07e54e76@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, Sebastian Reichel <sre@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731156277; l=1696;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=mseh9WRqz5C4m+dJG3gKVqO4w2mq1wg/wZdf/mAK3Mc=;
 b=p6RG8L2ppMseJHrGFGFXqKD0cvO/hmr64avCyPTMrXOmpbKJvR/L7yqOw+I7HkKgDykpfAaQc
 K5rjsIUntQwDRGn+xKnFPr/5z2IEZy24Orl7n7sVxJn+1/jtzpqtQCh
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

If shared-irq specified in device tree, request irq as shared.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 drivers/power/supply/max17042_battery.c | 3 ++-
 include/linux/power/max17042_battery.h  | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 496c3e1f2ee6..f3d89d4d5c42 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -933,6 +933,7 @@ max17042_get_of_pdata(struct max17042_chip *chip)
 		pdata->vmin = INT_MIN;
 	if (of_property_read_s32(np, "maxim,over-volt", &pdata->vmax))
 		pdata->vmax = INT_MAX;
+	pdata->is_irq_shared = of_property_read_bool(np, "shared-irq");
 
 	return pdata;
 }
@@ -1109,7 +1110,7 @@ static int max17042_probe(struct i2c_client *client)
 		 * On ACPI systems the IRQ may be handled by ACPI-event code,
 		 * so we need to share (if the ACPI code is willing to share).
 		 */
-		if (acpi_id)
+		if (acpi_id || chip->pdata->is_irq_shared)
 			flags |= IRQF_SHARED | IRQF_PROBE_SHARED;
 
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
diff --git a/include/linux/power/max17042_battery.h b/include/linux/power/max17042_battery.h
index c417abd2ab70..1261dbaa5e8f 100644
--- a/include/linux/power/max17042_battery.h
+++ b/include/linux/power/max17042_battery.h
@@ -250,6 +250,7 @@ struct max17042_platform_data {
 	int num_init_data; /* Number of enties in init_data array */
 	bool enable_current_sense;
 	bool enable_por_init; /* Use POR init from Maxim appnote */
+	bool is_irq_shared;
 
 	/*
 	 * R_sns in micro-ohms.

-- 
2.39.2


