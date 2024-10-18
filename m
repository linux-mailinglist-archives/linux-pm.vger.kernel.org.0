Return-Path: <linux-pm+bounces-15930-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1419A3841
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 10:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A2D92872CF
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 08:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EDA18FDBA;
	Fri, 18 Oct 2024 08:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4UgVM89"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F3A18C936;
	Fri, 18 Oct 2024 08:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729239124; cv=none; b=JE368t/Zad1BqHHQyk/nqqNqoeKisDqa4xfMxosTT+JnBQJeNfrVWAWGnxPvPvSaXjveISmMLnCrDG8no3eSsOdCfyzVfPkFF3GdxndhcNsZd1tnrnmagdyBkFUEuh3CCdH9kNQxGI/Hpzrp7fhXCfPkeZybPGFRP5HiHNp8QYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729239124; c=relaxed/simple;
	bh=1IU7rchA1NI7Q1y+xykq0jrk6FSz8Bkg/LF6qgma2Qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Li5L0lyElHnacxpuDncZ0fCQOu3pokzilXXWuK2ydXyEUjd02ZIV5EySmiReZkdMlJuLLiEnBYI4GZrCCcAVNb/2tbSi6z5bgk/ePjGS2yzFWOMhk7N28BVffKxBTjOQl0hqhz/bKA0bl32cBoaorEFswcUy0kjioaAsEZne/KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4UgVM89; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539f2b95775so2301058e87.1;
        Fri, 18 Oct 2024 01:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729239121; x=1729843921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZjjRK96GfuXcw6nB88pboztj/XL99IucjnOaEslf5E=;
        b=W4UgVM89DC6v3xGqVwgckjJap5qkMmQZ0zOlbZXbO0n+3KmNbytOqitsI71PmTJXuy
         XwPWaSktUNo9kreeC0zgJmPt3E21GRNY3D5lnOKMmvdx5hFR3KXUn2SsKLuG2ZwQAat4
         fIK63q8CAiDXyxmYJxzbTw2yHwdOPJq88vH/hUMc/ZKy4Rhwtfg/HxDKtwQhWlUKPzpd
         zczYtWnp4YY+i8wpqwb5dGIM1nhPOsyuhYC8mH9JF9qt4f4nbiVFqjtq0w3yC8/lm8b2
         MvLcdhSr5GsIb/dUCyW4Yr2w6s4Pjc24vKduhtkkATiXSnEw+kfSULxr89vK0pIQCdxW
         PQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729239121; x=1729843921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZjjRK96GfuXcw6nB88pboztj/XL99IucjnOaEslf5E=;
        b=bairHm3/LDrRlNa7tLM/6CNyoRD9bG24hUc5lNgewAM9wAt7FANHmNnU+6/uSNB179
         0vPUDY8ouIHXnYaQXmCbOTIPMubHgfeSWxl8Jt1s2wcCQDLNyiynalAWA73RmwXFL/vU
         seVWQarw2icZlk7cQDecvJ5dhZsf5YkuYwxErVQv+xocyN0TIeLFgjKDC77qItvocF/+
         KTubthVScABUie3olFZtiXQb/5Du3uOrSOM0PdlaZPEjIgJoiphLp0uTVmsIA40FG3JD
         GeAQGMvZH58s8Cxw1lepXfukhkpKio04o/UfDDeghzzE40XGd7YE//P4zNPcvP3/2Wcj
         7I2g==
X-Forwarded-Encrypted: i=1; AJvYcCV8436Fy747lO5Ne8/06e2UkT4sQHZESZiJ5eddWv/97IBnn4KqQaMmFT4dc0DdWbC0GckgZRSyWDWR6dKR@vger.kernel.org, AJvYcCW061bvwT1IRftlQ1V555m40ZI7TGcRzFzqI3p8Ksi70IZHb4EOvIo4XIjT9DHi2u/AA2FXURwRE1g=@vger.kernel.org, AJvYcCWN/tPSo/zQZx/BhPGJwstUV8dvRLamc99d0pLG6h9pHYH/iqQKBGKmMfBdyDg9cJXxYpRUWwF8FPvVPHU=@vger.kernel.org, AJvYcCXrLbmBdQ/wGr8MQnoiv/RsZWV03xlPcV+vEiQkna+hUrbEalwEyAJwc3fLV1LGY8PxR4epCd6Pk10V@vger.kernel.org
X-Gm-Message-State: AOJu0YxmHrB1ivsgItluQskvb64hSbat0fth/A067zQlOiiDdfe7lEUM
	0E/RtskCH9KcURWvmR8jrs20yx129KGcevWrPYI7WmAWyJliy9zy
X-Google-Smtp-Source: AGHT+IHOZo2zIv5xORZ3TfFiF94d8rr6g6N8wyJA6Yi6pZbzCQ0+fj68XKKyXsG1c3g2+PrJqW4LIw==
X-Received: by 2002:a05:6512:39cb:b0:538:9e36:7b6a with SMTP id 2adb3069b0e04-53a15494e4emr1432817e87.32.1729239121034;
        Fri, 18 Oct 2024 01:12:01 -0700 (PDT)
Received: from zenbook.agu.edu.tr ([95.183.227.33])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68a8e734sm61129666b.24.2024.10.18.01.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 01:12:00 -0700 (PDT)
From: Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	jason-ch chen <Jason-ch.Chen@mediatek.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	Flora Fu <flora.fu@mediatek.com>,
	Alexandre Mergnat <amergnat@baylibre.com>
Cc: Yassine Oudjana <y.oudjana@protonmail.com>,
	Yassine Oudjana <yassine.oudjana@gmail.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 6/6] Input: mtk-pmic-keys - Add support for MT6328
Date: Fri, 18 Oct 2024 11:10:48 +0300
Message-ID: <20241018081050.23592-7-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241018081050.23592-1-y.oudjana@protonmail.com>
References: <20241018081050.23592-1-y.oudjana@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yassine Oudjana <y.oudjana@protonmail.com>

Add a compatible string and related data for the PMIC keys on the
MT6328 PMIC.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 drivers/input/keyboard/mtk-pmic-keys.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
index 4364c3401ff1c..df1e4147e3365 100644
--- a/drivers/input/keyboard/mtk-pmic-keys.c
+++ b/drivers/input/keyboard/mtk-pmic-keys.c
@@ -9,6 +9,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/mfd/mt6323/registers.h>
+#include <linux/mfd/mt6328/registers.h>
 #include <linux/mfd/mt6331/registers.h>
 #include <linux/mfd/mt6357/registers.h>
 #include <linux/mfd/mt6358/registers.h>
@@ -78,6 +79,17 @@ static const struct mtk_pmic_regs mt6323_regs = {
 	.rst_lprst_mask = MTK_PMIC_RST_DU_MASK,
 };
 
+static const struct mtk_pmic_regs mt6328_regs = {
+	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
+		MTK_PMIC_KEYS_REGS(MT6328_TOPSTATUS,
+		0x2, MT6328_INT_MISC_CON, 0x4, MTK_PMIC_PWRKEY_RST),
+	.keys_regs[MTK_PMIC_HOMEKEY_INDEX] =
+		MTK_PMIC_KEYS_REGS(MT6328_TOPSTATUS,
+		0x4, MT6328_INT_MISC_CON, 0x2, MTK_PMIC_HOMEKEY_RST),
+	.pmic_rst_reg = MT6328_TOP_RST_MISC,
+	.rst_lprst_mask = MTK_PMIC_RST_DU_MASK,
+};
+
 static const struct mtk_pmic_regs mt6331_regs = {
 	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
 		MTK_PMIC_KEYS_REGS(MT6331_TOPSTATUS, 0x2,
@@ -287,6 +299,9 @@ static const struct of_device_id of_mtk_pmic_keys_match_tbl[] = {
 	}, {
 		.compatible = "mediatek,mt6323-keys",
 		.data = &mt6323_regs,
+	}, {
+		.compatible = "mediatek,mt6328-keys",
+		.data = &mt6328_regs,
 	}, {
 		.compatible = "mediatek,mt6331-keys",
 		.data = &mt6331_regs,
-- 
2.47.0


