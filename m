Return-Path: <linux-pm+bounces-15927-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7497B9A3833
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 10:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA5841F2792E
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 08:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681FA18EFF3;
	Fri, 18 Oct 2024 08:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCLWgwAY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362F418EFC8;
	Fri, 18 Oct 2024 08:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729239113; cv=none; b=OqD9HDEACEHU7HwxbkQ+r2aNlm7O2XvTG9savWgc/12+6zblEtvQujEgeeQ48wC8BG8HVHfVg0ODXa5K0kDGBtLW7IbbrrqqNd1Dt4RWu8uj6dOeapJ15J9rVTKKXCNS3u75SWiYjpcKc6qlZlOmjbhaXOjEq0cyq9B6QAiIaig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729239113; c=relaxed/simple;
	bh=IC01ds47wcxqb5YfuVOUtfoWDWUiS3mSO867OWSPki0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJvKXsL7YUystoiTghMZ1UCbkaQOBUoIoFvochByv4XrB6xBs/ZmcosstgXVzwIqmLP2orOywA5WEqEyxsZPMHP1D1M+1hwRKCQhb8MHd7yONTOHJQmk5y62szuxovsWgRi7u4YC1yxtcaitGYviSdxV29CMhaX40o49I6D3gh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCLWgwAY; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a99f1fd20c4so230296566b.0;
        Fri, 18 Oct 2024 01:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729239109; x=1729843909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGPuJ1DPbJWD/7aGIkg0kCrcVRwzs5u7uPTAqdlyYD8=;
        b=XCLWgwAY0oP7o8laA49W15sluck+7pMcCQQBxncI50BW7XaIVozv72aLrK3jpsU5pZ
         duYgkd6Pk17SvAxxHPkI0/F4tvgowqR0TfDs9ZzL9uATEFBhr2beSci0V0EFSb+cPJn/
         5O3t+w1nkbg/X6aLzRcijQNLqjMQqIKJLPPC5e/3sz1M/7yJq4YEFzPt5igSWZKnjlbJ
         5DolaQeHmYTkjh6MqHx5fSzCNS00NB8+MkfGgk8ai9wS+BtDUKnYTjdqMpYsB26EqBDV
         iFWJD9hZ5TVAvxqUSCDdZznJ0mHRKSrUwJLS3/nxGKkwbJJQvCvfL8m6B1O8778zYgEp
         Mn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729239109; x=1729843909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGPuJ1DPbJWD/7aGIkg0kCrcVRwzs5u7uPTAqdlyYD8=;
        b=eKpZgZDwH1Lxj5ltk2PRM+FDMpo6aOeqaZa8sVnvQ1W/aGO7FVqDh6c8zm9M1ZAfi+
         0x+OeNf37gIIXnJy/UdbEbEfkVDBmdFXmRZ6CmKwEHAabRfAqY54k9Ifoo/UK89sWTP1
         JeiGdKcLO3v5SxCeCip1+W/semqnf8WvhpZlU5hvXNQzoALMBY2N/gDSl8ypyB23L9qS
         a/2oG8HUwMOLIBPUT49xj2x6lqK+1qhRQRbK/t+GV7QiN5aZ9gs3Co49HSxMY0oAkdNb
         sw5W61TMhp1i4r8LZ8zOkX0W6hk55bTodtqZp8occu0FAg52v0lC0GlUMtTj3too80aZ
         BxxA==
X-Forwarded-Encrypted: i=1; AJvYcCU7yKRHuQbAHOvSCLq5rBCkEItXqCRB4erH58QT6ANp2XSUihTS0n/jz0qGEA9vVfxUAYP8paz6/jyKr7kK@vger.kernel.org, AJvYcCUD6nn6Tl/l2gqF8BIK+/f2AfX6MGG6VRgIA2bcX1nRcvct4WwlF/dUiOJm7CXi8jQ/NPDbfC+xtC7ACco=@vger.kernel.org, AJvYcCUEqxM4KDooAynhVEYwflD2FkiKaPnoS0OpkJv0hIPhUl917zMg6kbK5tDLZ9oPWPXR6lGhJ6xoLI/T@vger.kernel.org, AJvYcCUrECBdaUafSjJ4ZL8vrbiUT60nxndHRdrfQZoV2pddUMZfb9oAXdtys2obqWa8z+Zz/5T1QnbE4Z0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6/cB9fYimbiTHrafJe2orslKA+acH8Vu+ueWr1gEKFBBckV5x
	m+TfLo6FBuVxgjnw74w4bXalVXCgrEjREZY3Qq+dat1r9sEv75kl
X-Google-Smtp-Source: AGHT+IEqArqZjw0J6kyMM1EXu/gNsYMUNc/6DPGCzeEwzKw/XdRllF7sK5ixpgM51HOP4jp7jmy1bQ==
X-Received: by 2002:a17:907:97d5:b0:a99:ee83:2b19 with SMTP id a640c23a62f3a-a9a69bab048mr127321366b.35.1729239109233;
        Fri, 18 Oct 2024 01:11:49 -0700 (PDT)
Received: from zenbook.agu.edu.tr ([95.183.227.33])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68a8e734sm61129666b.24.2024.10.18.01.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 01:11:48 -0700 (PDT)
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
Subject: [PATCH 3/6] soc: mediatek: pwrap: Add support for MT6735 and MT6328 SoC/PMIC pair
Date: Fri, 18 Oct 2024 11:10:45 +0300
Message-ID: <20241018081050.23592-4-y.oudjana@protonmail.com>
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

Add register definitions and configuration for the MT6735 SoC and the
MT6328 PMIC which are commonly paired and communicate through the PMIC
wrapper.

Note that the PMIC wrapper on MT6735M has a slightly different register
map and is therefore NOT compatible with MT6735.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 251 ++++++++++++++++++++++++++-
 1 file changed, 248 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index 9fdc0ef792026..b9e8dd2a5999d 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2014 MediaTek Inc.
  * Author: Flora Fu, MediaTek
  */
+
 #include <linux/clk.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -100,7 +101,7 @@ enum dew_regs {
 	PWRAP_DEW_CIPHER_MODE,
 	PWRAP_DEW_CIPHER_SWRST,
 
-	/* MT6323 only regs */
+	/* MT6323 and MT6328 only regs */
 	PWRAP_DEW_CIPHER_EN,
 	PWRAP_DEW_RDDMY_NO,
 
@@ -121,8 +122,10 @@ enum dew_regs {
 	PWRAP_RG_SPI_CON13,
 	PWRAP_SPISLV_KEY,
 
-	/* MT6359 only regs */
+	/* MT6359 and MT6328 only regs */
 	PWRAP_DEW_CRC_SWRST,
+
+	/* MT6359 only regs */
 	PWRAP_DEW_RG_EN_RECORD,
 	PWRAP_DEW_RECORD_CMD0,
 	PWRAP_DEW_RECORD_CMD1,
@@ -171,6 +174,23 @@ static const u32 mt6323_regs[] = {
 	[PWRAP_DEW_RDDMY_NO] =		0x01a4,
 };
 
+static const u32 mt6328_regs[] = {
+	[PWRAP_DEW_DIO_EN] =		0x02d4,
+	[PWRAP_DEW_READ_TEST] =		0x02d6,
+	[PWRAP_DEW_WRITE_TEST] =	0x02d8,
+	[PWRAP_DEW_CRC_SWRST] =		0x02da,
+	[PWRAP_DEW_CRC_EN] =		0x02dc,
+	[PWRAP_DEW_CRC_VAL] =		0x02de,
+	[PWRAP_DEW_MON_GRP_SEL] =	0x02e0,
+	[PWRAP_DEW_CIPHER_KEY_SEL] =	0x02e2,
+	[PWRAP_DEW_CIPHER_IV_SEL] =	0x02e4,
+	[PWRAP_DEW_CIPHER_EN] =		0x02e6,
+	[PWRAP_DEW_CIPHER_RDY] =	0x02e8,
+	[PWRAP_DEW_CIPHER_MODE] =	0x02ea,
+	[PWRAP_DEW_CIPHER_SWRST] =	0x02ec,
+	[PWRAP_DEW_RDDMY_NO] =		0x02ee,
+};
+
 static const u32 mt6331_regs[] = {
 	[PWRAP_DEW_DIO_EN] =		0x018c,
 	[PWRAP_DEW_READ_TEST] =		0x018e,
@@ -394,7 +414,7 @@ enum pwrap_regs {
 	PWRAP_ADC_RDATA_ADDR1,
 	PWRAP_ADC_RDATA_ADDR2,
 
-	/* MT7622 only regs */
+	/* MT7622 and MT6735 only regs */
 	PWRAP_STA,
 	PWRAP_CLR,
 	PWRAP_DVFS_ADR8,
@@ -417,6 +437,8 @@ enum pwrap_regs {
 	PWRAP_ADC_RDATA_ADDR,
 	PWRAP_GPS_STA,
 	PWRAP_SW_RST,
+
+	/* MT7622 only regs */
 	PWRAP_DVFS_STEP_CTRL0,
 	PWRAP_DVFS_STEP_CTRL1,
 	PWRAP_DVFS_STEP_CTRL2,
@@ -481,6 +503,50 @@ enum pwrap_regs {
 	/* MT8516 only regs */
 	PWRAP_OP_TYPE,
 	PWRAP_MSB_FIRST,
+
+	/* MT6735 only regs */
+	PWRAP_WACS3_EN,
+	PWRAP_INIT_DONE3,
+	PWRAP_WACS3_CMD,
+	PWRAP_WACS3_RDATA,
+	PWRAP_WACS3_VLDCLR,
+	PWRAP_MD_ADC_RDATA_ADDR_LATEST,
+	PWRAP_MD_ADC_RDATA_ADDR_WP,
+	PWRAP_MD_ADC_RDATA_ADDR_R0,
+	PWRAP_MD_ADC_RDATA_ADDR_R1,
+	PWRAP_MD_ADC_RDATA_ADDR_R2,
+	PWRAP_MD_ADC_RDATA_ADDR_R3,
+	PWRAP_MD_ADC_RDATA_ADDR_R4,
+	PWRAP_MD_ADC_RDATA_ADDR_R5,
+	PWRAP_MD_ADC_RDATA_ADDR_R6,
+	PWRAP_MD_ADC_RDATA_ADDR_R7,
+	PWRAP_MD_ADC_RDATA_ADDR_R8,
+	PWRAP_MD_ADC_RDATA_ADDR_R9,
+	PWRAP_MD_ADC_RDATA_ADDR_R10,
+	PWRAP_MD_ADC_RDATA_ADDR_R11,
+	PWRAP_MD_ADC_RDATA_ADDR_R12,
+	PWRAP_MD_ADC_RDATA_ADDR_R13,
+	PWRAP_MD_ADC_RDATA_ADDR_R14,
+	PWRAP_MD_ADC_RDATA_ADDR_R15,
+	PWRAP_MD_ADC_RDATA_ADDR_R16,
+	PWRAP_MD_ADC_RDATA_ADDR_R17,
+	PWRAP_MD_ADC_RDATA_ADDR_R18,
+	PWRAP_MD_ADC_RDATA_ADDR_R19,
+	PWRAP_MD_ADC_RDATA_ADDR_R20,
+	PWRAP_MD_ADC_RDATA_ADDR_R21,
+	PWRAP_MD_ADC_RDATA_ADDR_R22,
+	PWRAP_MD_ADC_RDATA_ADDR_R23,
+	PWRAP_MD_ADC_RDATA_ADDR_R24,
+	PWRAP_MD_ADC_RDATA_ADDR_R25,
+	PWRAP_MD_ADC_RDATA_ADDR_R26,
+	PWRAP_MD_ADC_RDATA_ADDR_R27,
+	PWRAP_MD_ADC_RDATA_ADDR_R28,
+	PWRAP_MD_ADC_RDATA_ADDR_R29,
+	PWRAP_MD_ADC_RDATA_ADDR_R30,
+	PWRAP_MD_ADC_RDATA_ADDR_R31,
+	PWRAP_MD_ADC_STA0,
+	PWRAP_MD_ADC_STA1,
+	PWRAP_MD_ADC_STA2,
 };
 
 static const int mt2701_regs[] = {
@@ -569,6 +635,156 @@ static const int mt2701_regs[] = {
 	[PWRAP_ADC_RDATA_ADDR2] =	0x154,
 };
 
+static const int mt6735_regs[] = {
+	[PWRAP_MUX_SEL] =			0x0,
+	[PWRAP_WRAP_EN] =			0x4,
+	[PWRAP_DIO_EN] =			0x8,
+	[PWRAP_SIDLY] =				0xc,
+	[PWRAP_RDDMY] =				0x10,
+	[PWRAP_SI_CK_CON] =			0x14,
+	[PWRAP_CSHEXT_WRITE] =			0x18,
+	[PWRAP_CSHEXT_READ] =			0x1c,
+	[PWRAP_CSLEXT_START] =			0x20,
+	[PWRAP_CSLEXT_END] =			0x24,
+	[PWRAP_STAUPD_PRD] =			0x28,
+	[PWRAP_STAUPD_GRPEN] =			0x2c,
+	[PWRAP_EINT_STA0_ADR] =			0x30,
+	[PWRAP_EINT_STA1_ADR] =			0x34,
+	[PWRAP_STA] =				0x38,
+	[PWRAP_CLR] =				0x3c,
+	[PWRAP_STAUPD_MAN_TRIG] =		0x40,
+	[PWRAP_STAUPD_STA] =			0x44,
+	[PWRAP_WRAP_STA] =			0x48,
+	[PWRAP_HARB_INIT] =			0x4c,
+	[PWRAP_HARB_HPRIO] =			0x50,
+	[PWRAP_HIPRIO_ARB_EN] =			0x54,
+	[PWRAP_HARB_STA0] =			0x58,
+	[PWRAP_HARB_STA1] =			0x5c,
+	[PWRAP_MAN_EN] =			0x60,
+	[PWRAP_MAN_CMD] =			0x64,
+	[PWRAP_MAN_RDATA] =			0x68,
+	[PWRAP_MAN_VLDCLR] =			0x6c,
+	[PWRAP_WACS0_EN] =			0x70,
+	[PWRAP_INIT_DONE0] =			0x74,
+	[PWRAP_WACS0_CMD] =			0x78,
+	[PWRAP_WACS0_RDATA] =			0x7c,
+	[PWRAP_WACS0_VLDCLR] =			0x80,
+	[PWRAP_WACS1_EN] =			0x84,
+	[PWRAP_INIT_DONE1] =			0x88,
+	[PWRAP_WACS1_CMD] =			0x8c,
+	[PWRAP_WACS1_RDATA] =			0x90,
+	[PWRAP_WACS1_VLDCLR] =			0x94,
+	[PWRAP_WACS2_EN] =			0x98,
+	[PWRAP_INIT_DONE2] =			0x9c,
+	[PWRAP_WACS2_CMD] =			0xa0,
+	[PWRAP_WACS2_RDATA] =			0xa4,
+	[PWRAP_WACS2_VLDCLR] =			0xa8,
+	[PWRAP_WACS3_EN] =			0xac,
+	[PWRAP_INIT_DONE3] =			0xb0,
+	[PWRAP_WACS3_CMD] =			0xb4,
+	[PWRAP_WACS3_RDATA] =			0xb8,
+	[PWRAP_WACS3_VLDCLR] =			0xbc,
+	[PWRAP_INT_EN] =			0xc0,
+	[PWRAP_INT_FLG_RAW] =			0xc4,
+	[PWRAP_INT_FLG] =			0xc8,
+	[PWRAP_INT_CLR] =			0xcc,
+	[PWRAP_SIG_ADR] =			0xd0,
+	[PWRAP_SIG_MODE] =			0xd4,
+	[PWRAP_SIG_VALUE] =			0xd8,
+	[PWRAP_SIG_ERRVAL] =			0xdc,
+	[PWRAP_CRC_EN] =			0xe0,
+	[PWRAP_TIMER_EN] =			0xe4,
+	[PWRAP_TIMER_STA] =			0xe8,
+	[PWRAP_WDT_UNIT] =			0xec,
+	[PWRAP_WDT_SRC_EN] =			0xf0,
+	[PWRAP_WDT_FLG] =			0xf4,
+	[PWRAP_DEBUG_INT_SEL] =			0xf8,
+	[PWRAP_DVFS_ADR0] =			0xfc,
+	[PWRAP_DVFS_WDATA0] =			0x100,
+	[PWRAP_DVFS_ADR1] =			0x104,
+	[PWRAP_DVFS_WDATA1] =			0x108,
+	[PWRAP_DVFS_ADR2] =			0x10c,
+	[PWRAP_DVFS_WDATA2] =			0x110,
+	[PWRAP_DVFS_ADR3] =			0x114,
+	[PWRAP_DVFS_WDATA3] =			0x118,
+	[PWRAP_DVFS_ADR4] =			0x11c,
+	[PWRAP_DVFS_WDATA4] =			0x120,
+	[PWRAP_DVFS_ADR5] =			0x124,
+	[PWRAP_DVFS_WDATA5] =			0x128,
+	[PWRAP_DVFS_ADR6] =			0x12c,
+	[PWRAP_DVFS_WDATA6] =			0x130,
+	[PWRAP_DVFS_ADR7] =			0x134,
+	[PWRAP_DVFS_WDATA7] =			0x138,
+	[PWRAP_DVFS_ADR8] =			0x13c,
+	[PWRAP_DVFS_WDATA8] =			0x140,
+	[PWRAP_DVFS_ADR9] =			0x144,
+	[PWRAP_DVFS_WDATA9] =			0x148,
+	[PWRAP_DVFS_ADR10] =			0x14c,
+	[PWRAP_DVFS_WDATA10] =			0x150,
+	[PWRAP_DVFS_ADR11] =			0x154,
+	[PWRAP_DVFS_WDATA11] =			0x158,
+	[PWRAP_DVFS_ADR12] =			0x15c,
+	[PWRAP_DVFS_WDATA12] =			0x160,
+	[PWRAP_DVFS_ADR13] =			0x164,
+	[PWRAP_DVFS_WDATA13] =			0x168,
+	[PWRAP_DVFS_ADR14] =			0x16c,
+	[PWRAP_DVFS_WDATA14] =			0x170,
+	[PWRAP_DVFS_ADR15] =			0x174,
+	[PWRAP_DVFS_WDATA15] =			0x178,
+	[PWRAP_SPMINF_STA] =			0x17c,
+	[PWRAP_CIPHER_KEY_SEL] =		0x180,
+	[PWRAP_CIPHER_IV_SEL] =			0x184,
+	[PWRAP_CIPHER_EN] =			0x188,
+	[PWRAP_CIPHER_RDY] =			0x18c,
+	[PWRAP_CIPHER_MODE] =			0x190,
+	[PWRAP_CIPHER_SWRST] =			0x194,
+	[PWRAP_DCM_EN] =			0x198,
+	[PWRAP_DCM_DBC_PRD] =			0x19c,
+	[PWRAP_EXT_CK] =			0x1a0,
+	[PWRAP_ADC_CMD_ADDR] =			0x1a4,
+	[PWRAP_PWRAP_ADC_CMD] =			0x1a8,
+	[PWRAP_ADC_RDATA_ADDR] =		0x1ac,
+	[PWRAP_GPS_STA] =			0x1b0,
+	[PWRAP_SW_RST] =			0x1b4,
+	[PWRAP_MD_ADC_RDATA_ADDR_LATEST] =	0x1b8,
+	[PWRAP_MD_ADC_RDATA_ADDR_WP] =		0x1bc,
+	[PWRAP_MD_ADC_RDATA_ADDR_R0] =		0x1c0,
+	[PWRAP_MD_ADC_RDATA_ADDR_R1] =		0x1c4,
+	[PWRAP_MD_ADC_RDATA_ADDR_R2] =		0x1c8,
+	[PWRAP_MD_ADC_RDATA_ADDR_R3] =		0x1cc,
+	[PWRAP_MD_ADC_RDATA_ADDR_R4] =		0x1d0,
+	[PWRAP_MD_ADC_RDATA_ADDR_R5] =		0x1d4,
+	[PWRAP_MD_ADC_RDATA_ADDR_R6] =		0x1d8,
+	[PWRAP_MD_ADC_RDATA_ADDR_R7] =		0x1dc,
+	[PWRAP_MD_ADC_RDATA_ADDR_R8] =		0x1e0,
+	[PWRAP_MD_ADC_RDATA_ADDR_R9] =		0x1e4,
+	[PWRAP_MD_ADC_RDATA_ADDR_R10] =		0x1e8,
+	[PWRAP_MD_ADC_RDATA_ADDR_R11] =		0x1ec,
+	[PWRAP_MD_ADC_RDATA_ADDR_R12] =		0x1f0,
+	[PWRAP_MD_ADC_RDATA_ADDR_R13] =		0x1f4,
+	[PWRAP_MD_ADC_RDATA_ADDR_R14] =		0x1f8,
+	[PWRAP_MD_ADC_RDATA_ADDR_R15] =		0x1fc,
+	[PWRAP_MD_ADC_RDATA_ADDR_R16] =		0x200,
+	[PWRAP_MD_ADC_RDATA_ADDR_R17] =		0x204,
+	[PWRAP_MD_ADC_RDATA_ADDR_R18] =		0x208,
+	[PWRAP_MD_ADC_RDATA_ADDR_R19] =		0x20c,
+	[PWRAP_MD_ADC_RDATA_ADDR_R20] =		0x210,
+	[PWRAP_MD_ADC_RDATA_ADDR_R21] =		0x214,
+	[PWRAP_MD_ADC_RDATA_ADDR_R22] =		0x218,
+	[PWRAP_MD_ADC_RDATA_ADDR_R23] =		0x21c,
+	[PWRAP_MD_ADC_RDATA_ADDR_R24] =		0x220,
+	[PWRAP_MD_ADC_RDATA_ADDR_R25] =		0x224,
+	[PWRAP_MD_ADC_RDATA_ADDR_R26] =		0x228,
+	[PWRAP_MD_ADC_RDATA_ADDR_R27] =		0x22c,
+	[PWRAP_MD_ADC_RDATA_ADDR_R28] =		0x230,
+	[PWRAP_MD_ADC_RDATA_ADDR_R29] =		0x234,
+	[PWRAP_MD_ADC_RDATA_ADDR_R30] =		0x238,
+	[PWRAP_MD_ADC_RDATA_ADDR_R31] =		0x23c,
+	[PWRAP_MD_ADC_STA0] =			0x240,
+	[PWRAP_MD_ADC_STA1] =			0x244,
+	[PWRAP_MD_ADC_STA2] =			0x248,
+};
+
 static const int mt6765_regs[] = {
 	[PWRAP_MUX_SEL] =		0x0,
 	[PWRAP_WRAP_EN] =		0x4,
@@ -1302,6 +1518,7 @@ static const int mt8186_regs[] = {
 
 enum pmic_type {
 	PMIC_MT6323,
+	PMIC_MT6328,
 	PMIC_MT6331,
 	PMIC_MT6332,
 	PMIC_MT6351,
@@ -1314,6 +1531,7 @@ enum pmic_type {
 
 enum pwrap_type {
 	PWRAP_MT2701,
+	PWRAP_MT6735,
 	PWRAP_MT6765,
 	PWRAP_MT6779,
 	PWRAP_MT6795,
@@ -1733,6 +1951,10 @@ static void pwrap_init_chip_select_ext(struct pmic_wrapper *wrp, u8 hext_write,
 static int pwrap_common_init_reg_clock(struct pmic_wrapper *wrp)
 {
 	switch (wrp->master->type) {
+	case PWRAP_MT6735:
+		pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_RDDMY_NO], 0x8);
+		pwrap_init_chip_select_ext(wrp, 0, 6, 0, 0);
+		break;
 	case PWRAP_MT6795:
 		if (wrp->slave->type == PMIC_MT6331) {
 			const u32 *dew_regs = wrp->slave->dew_regs;
@@ -1839,6 +2061,7 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
 		pwrap_writel(wrp, 1, PWRAP_CIPHER_START);
 		break;
 	case PWRAP_MT2701:
+	case PWRAP_MT6735:
 	case PWRAP_MT6765:
 	case PWRAP_MT6779:
 	case PWRAP_MT6795:
@@ -2194,6 +2417,14 @@ static const struct pwrap_slv_type pmic_mt6323 = {
 		PWRAP_SLV_CAP_SECURITY,
 };
 
+static const struct pwrap_slv_type pmic_mt6328 = {
+	.dew_regs = mt6328_regs,
+	.type = PMIC_MT6328,
+	.regops = &pwrap_regops16,
+	.caps = PWRAP_SLV_CAP_SPI | PWRAP_SLV_CAP_DUALIO |
+		PWRAP_SLV_CAP_SECURITY,
+};
+
 static const struct pwrap_slv_type pmic_mt6331 = {
 	.dew_regs = mt6331_regs,
 	.type = PMIC_MT6331,
@@ -2249,6 +2480,7 @@ static const struct pwrap_slv_type pmic_mt6397 = {
 
 static const struct of_device_id of_slave_match_tbl[] = {
 	{ .compatible = "mediatek,mt6323", .data = &pmic_mt6323 },
+	{ .compatible = "mediatek,mt6328", .data = &pmic_mt6328 },
 	{ .compatible = "mediatek,mt6331", .data = &pmic_mt6331 },
 	{ .compatible = "mediatek,mt6351", .data = &pmic_mt6351 },
 	{ .compatible = "mediatek,mt6357", .data = &pmic_mt6357 },
@@ -2277,6 +2509,18 @@ static const struct pmic_wrapper_type pwrap_mt2701 = {
 	.init_soc_specific = pwrap_mt2701_init_soc_specific,
 };
 
+static const struct pmic_wrapper_type pwrap_mt6735 = {
+	.regs = mt6735_regs,
+	.type = PWRAP_MT6735,
+	.arb_en_all = GENMASK(9, 0),
+	.int_en_all = GENMASK(31, 0),
+	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
+	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
+	.caps = PWRAP_CAP_RESET | PWRAP_CAP_DCM,
+	.init_reg_clock = pwrap_common_init_reg_clock,
+	.init_soc_specific = NULL,
+};
+
 static const struct pmic_wrapper_type pwrap_mt6765 = {
 	.regs = mt6765_regs,
 	.type = PWRAP_MT6765,
@@ -2446,6 +2690,7 @@ static const struct pmic_wrapper_type pwrap_mt8186 = {
 
 static const struct of_device_id of_pwrap_match_tbl[] = {
 	{ .compatible = "mediatek,mt2701-pwrap", .data = &pwrap_mt2701 },
+	{ .compatible = "mediatek,mt6735-pwrap", .data = &pwrap_mt6735 },
 	{ .compatible = "mediatek,mt6765-pwrap", .data = &pwrap_mt6765 },
 	{ .compatible = "mediatek,mt6779-pwrap", .data = &pwrap_mt6779 },
 	{ .compatible = "mediatek,mt6795-pwrap", .data = &pwrap_mt6795 },
-- 
2.47.0


