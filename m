Return-Path: <linux-pm+bounces-5605-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8939D89126D
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 05:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3F1C1F21BB4
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 04:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437392B9AD;
	Fri, 29 Mar 2024 04:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bYgNhOtt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B956728F7
	for <linux-pm@vger.kernel.org>; Fri, 29 Mar 2024 04:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711687387; cv=none; b=FgEYdphYMwSvrTQe4a/WCCtpDrxN3aLvYPimoTvPZV3SYow4d6p0pSTm7FcHPMI7lhwvHPhKgUj4nByxwBtjriJODI2k5kwWdmC4ItvK12RXR5/McTXbFm3F2oVT1/kVbLe0iBxXAa/4lo2uXwKEWtNPnyAiZHHkplqKXFK1b60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711687387; c=relaxed/simple;
	bh=My3f7M5mMYJXacZvdy1j2CVdTWB2Yzw0VQy6ISU7+O4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZNDwhx7Z9QnXR5S0rwl72RFeKmuqvoQHIoyCnMgITJ75u11OswcNEPI4OxaJdWXDcSZnlqgFEM5bzwWv6dl8NYG2EvkJHn6bP/K5RKEKzEEJ8Mf2AZAwnfKY1EE361MhIXXaR9q/R4jx5e/6BZhblmzFr2aJ2nOOYjkGXWhzzH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bYgNhOtt; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e00d1e13acso11831165ad.0
        for <linux-pm@vger.kernel.org>; Thu, 28 Mar 2024 21:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711687385; x=1712292185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T+F3MEmVUPzwWL0/FLP/CCB6bmOFJ8TO+NbHdWfRAjA=;
        b=bYgNhOttv9vwUmTA/yUR6B8HTLEeBPJzqhsjY+SBmpi2nwqat6W1p2bsqaClBoD15k
         2cePg7qTpU4lgaFmh34MvZux+5AGmxNFFsPKKksSSi58Mn0ktOhIXhd7IhPUuW7r3a4d
         HC++QsAD88pW5gC2PC/zyWQ5Z1eytaHvmBF48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711687385; x=1712292185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T+F3MEmVUPzwWL0/FLP/CCB6bmOFJ8TO+NbHdWfRAjA=;
        b=Cxx4yXFJg9HuN/BytPnSYe4UO98pwF7kgkA0JKtc4OgpfmrntX2U2YkxfTBmuEY7hU
         n9HVpQI0kCjSL1AbBpJ6NHx28VAT46n24kttHYb6dcaL2ZIXTo//zHAues+XhkFI/yyi
         z+xqXuxHMjhPGKj7MUw9uopn7UMnUJ00dBKYP/UZo8rFKBq6c/EHtz0GibPy3hJ6pG0x
         j4NQJY70oRNYyCEGAkAM7PawPbUyR7bsFpXHBa/Gr+HgmRtkViaGTo6Go7lZk5Gt44na
         ZKTTCTOBg6SmCRaIgMcmpd41L8CjwjwRP5q9Z5SAeO01F74FkWPM09oVKIawvw0Ykk1l
         H8iw==
X-Forwarded-Encrypted: i=1; AJvYcCX58KJbBO5G7HynIurYDVjzp4zNlkD1CFKHZKjYvw88ulpMllwdEXRPaGtyIFOpYCltiK3Z4uFm3Es8Dk3Po5OJlCm/i8TFs/s=
X-Gm-Message-State: AOJu0YwZr7232LeK8BI+qs+aGS1+p6PrPxEli51BV1wAyQ574qlDN3z1
	oujKG/wg1K+bQszAXwAXDNhdnJQOoEWSPZNcOuWFHJ0zikalO0r9WM8Iwik/Bg==
X-Google-Smtp-Source: AGHT+IHCedueif2FtQVSxLOhPhqWgRritaTfZsBJlDn+eEkw34EDb+pABQ0tVdwsWrtdeb23F+EOuQ==
X-Received: by 2002:a17:903:2442:b0:1de:f18c:cdd with SMTP id l2-20020a170903244200b001def18c0cddmr1744816pls.3.1711687385018;
        Thu, 28 Mar 2024 21:43:05 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:89c9:dcae:ddce:1350])
        by smtp.gmail.com with ESMTPSA id q6-20020a17090311c600b001dd744f97d0sm2502345plh.273.2024.03.28.21.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 21:43:04 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Johnson Wang <johnson.wang@mediatek.com>,
	Fei Shao <fshao@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2] pmdomain: mediatek: Add MT8188 buck isolation setting
Date: Fri, 29 Mar 2024 12:38:40 +0800
Message-ID: <20240329044142.3095193-1-fshao@chromium.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johnson Wang <johnson.wang@mediatek.com>

From: Johnson Wang <johnson.wang@mediatek.com>

Add buck isolation setting to ADSP_AO, CAM_VCORE and IMG_VCORE power
domains in MT8188 for proper buck isolation control in power domain
on/off.

Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
Signed-off-by: Fei Shao <fshao@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---

Changes in v2:
[1] was reviewed but didn't get accepted at the time.
This rebases [1] on next-20240327 with revised commit message.

[1]: https://lore.kernel.org/all/20230315114505.25144-1-johnson.wang@mediatek.com/

 drivers/pmdomain/mediatek/mt8188-pm-domains.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/pmdomain/mediatek/mt8188-pm-domains.h b/drivers/pmdomain/mediatek/mt8188-pm-domains.h
index 06834ab6597c..007235be9efe 100644
--- a/drivers/pmdomain/mediatek/mt8188-pm-domains.h
+++ b/drivers/pmdomain/mediatek/mt8188-pm-domains.h
@@ -175,6 +175,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.ctl_offs = 0x35C,
 		.pwr_sta_offs = 0x16C,
 		.pwr_sta2nd_offs = 0x170,
+		.ext_buck_iso_offs = 0x3EC,
+		.ext_buck_iso_mask = BIT(10),
 		.bp_cfg = {
 			BUS_PROT_WR(INFRA,
 				    MT8188_TOP_AXI_PROT_EN_2_ADSP_AO_STEP1,
@@ -187,7 +189,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 				    MT8188_TOP_AXI_PROT_EN_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_2_STA),
 		},
-		.caps = MTK_SCPD_ALWAYS_ON,
+		.caps = MTK_SCPD_ALWAYS_ON | MTK_SCPD_EXT_BUCK_ISO,
 	},
 	[MT8188_POWER_DOMAIN_ADSP_INFRA] = {
 		.name = "adsp_infra",
@@ -524,6 +526,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.ctl_offs = 0x3A4,
 		.pwr_sta_offs = 0x16C,
 		.pwr_sta2nd_offs = 0x170,
+		.ext_buck_iso_offs = 0x3EC,
+		.ext_buck_iso_mask = BIT(12),
 		.bp_cfg = {
 			BUS_PROT_WR(INFRA,
 				    MT8188_TOP_AXI_PROT_EN_MM_IMG_VCORE_STEP1,
@@ -541,7 +545,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
 		},
-		.caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_DOMAIN_SUPPLY,
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_DOMAIN_SUPPLY |
+			MTK_SCPD_EXT_BUCK_ISO,
 	},
 	[MT8188_POWER_DOMAIN_IMG_MAIN] = {
 		.name = "img_main",
@@ -591,6 +596,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.ctl_offs = 0x3A0,
 		.pwr_sta_offs = 0x16C,
 		.pwr_sta2nd_offs = 0x170,
+		.ext_buck_iso_offs = 0x3EC,
+		.ext_buck_iso_mask = BIT(11),
 		.bp_cfg = {
 			BUS_PROT_WR(INFRA,
 				    MT8188_TOP_AXI_PROT_EN_MM_CAM_VCORE_STEP1,
@@ -618,7 +625,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
 		},
-		.caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_DOMAIN_SUPPLY,
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_DOMAIN_SUPPLY |
+			MTK_SCPD_EXT_BUCK_ISO,
 	},
 	[MT8188_POWER_DOMAIN_CAM_MAIN] = {
 		.name = "cam_main",
-- 
2.44.0.478.gd926399ef9-goog


