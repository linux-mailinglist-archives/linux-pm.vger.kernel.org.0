Return-Path: <linux-pm+bounces-6783-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B81DC8ACB51
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 12:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC4CB1C212FA
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 10:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07C3146D45;
	Mon, 22 Apr 2024 10:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="l6q05YOv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CF61465B4
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 10:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713783246; cv=none; b=GA5z5InDPPaBnIvP/23U4t8IWpbtgdN9cEHYGGAxrmo6OQGQ8ZJgKSSHlZTArea7ygmQ8fK4+qTobNpL6JQg4btWDusFlPRdR+m9TOBTxlFFg4g77hIkCHCCLkRoX4spZddT7Onum89mIcIdG6BFOmfsr13kqW2zQohqYpr5x6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713783246; c=relaxed/simple;
	bh=zuBydgDK8eySkvZTtgHumqD0x7INAbqhfmpZNRl7iZI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kfvi3guS6ccFj6EPDnAAsZ59gfeCLptkwlAqPGVhZ8bYLgDbF2RH5+KFeUvQnYOpag3um+hAdMR6WuU+wa43uBZnpbY7Xlhz0UO5cA9HSmQBRhlNn8UzunfXv/v2rO8ol/SlE/98ISQ0XoTxAHbIJ6G7zz7cP4+PzIfxrNtrbSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=l6q05YOv; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41a1d88723bso7818125e9.0
        for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 03:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713783243; x=1714388043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ARMUZPHrxZWnn6veFR4DVaFmlfvykL4Uf0lprJBp4A=;
        b=l6q05YOv/NICmclNiouKl5ViNuTPfVroav2ATHjaamWPSVxJY3sMzBWp+iL7pAkPlT
         +7C8hdW/N0wHBKiOnMziTRXvXRfrJ1pd1BwoGoq2SFCvHm+0fXH0QWLW+jHnrY5YncYU
         qwzbhR8VO1KXypTJgR7EPLtUKEY3YSa3IBymeAai6H9fg+45bpfiVOmxchj8bnEYlGXP
         McvEhw1DLD4YU/Q+Xx3iumUhzJmtKOC2w6zCe4stw6fUTadEZdsEndOmhjLBJjxFQcPs
         bj72sZq40vvuyRAG0FROysaEz5U2pEUZEfNoFTV7c9c+UENhLpsX2rn04HSmjJ9Hvqpo
         14AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713783243; x=1714388043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ARMUZPHrxZWnn6veFR4DVaFmlfvykL4Uf0lprJBp4A=;
        b=ZGkwdz/ybjY8BADmarYLdliA5x5G0Td4s/wJlExZzk5J6EExv7FNCTObz9yw9QSQHg
         W2rBTFHJf9Brw+Dmy8YOEwnWwLcjs897gxpAY6ljg2ARwpBxQXQ125E37N9wz+pxQgxR
         y1PauAnUoE1hbp7K21D14OD1A7M5dyVVVF0BIW1VmbRD21LQlhNZv3qY6iKidnXcU98g
         rWaXkmUekDW0Hd/QkgEB1dauuGTLV/uVzX9uMgv0yEycmxV3NULMZgGAj1zoL3dpfkGd
         JMXqyosMq6M2kScfYS3yNySitklPeTQY7FPqBpF+YY4sEQMURoJNVbx7K7B/AWIH28Pf
         uEzw==
X-Forwarded-Encrypted: i=1; AJvYcCVayM13J6H+atJvV/km7+m7+F9P8FqNcSSk8fBSSjX3F6OfA3pH7wnEUJJs+8rfXbm6eFzyNJ3bliALJDI5xxQ+weWTVtoUpRU=
X-Gm-Message-State: AOJu0YyZ2T9SgxW7+P8nmag9S1mpPHE4guIFKWW2Odx6Died0TCiu7R3
	mLKGzzrqXw/DMZD4A1nLArAW75estizZWVCfESdKlf6pO7tEyou7dWWvh7Vl2n0=
X-Google-Smtp-Source: AGHT+IG/XJfjVTtfgJu/B4SxRIVqJ7/0zbQ8suItMSeCB50ek873cr/z9HpliECLOR1uLqeG0AMU2Q==
X-Received: by 2002:a05:600c:198b:b0:418:ea91:a579 with SMTP id t11-20020a05600c198b00b00418ea91a579mr6499785wmq.23.1713783243094;
        Mon, 22 Apr 2024 03:54:03 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.53])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c444d00b0041a3f700ccesm4321037wmn.40.2024.04.22.03.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 03:54:02 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	mturquette@baylibre.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	magnus.damm@gmail.com,
	ulf.hansson@linaro.org
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v4 2/8] dt-bindings: clock: r9a07g044-cpg: Add power domain IDs
Date: Mon, 22 Apr 2024 13:53:49 +0300
Message-Id: <20240422105355.1622177-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240422105355.1622177-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240422105355.1622177-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add power domain IDs for RZ/G2L (R9A07G044) SoC.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- none

Changes in v3:
- collected tags

Changes in v2:
- collected tag

 include/dt-bindings/clock/r9a07g044-cpg.h | 58 +++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/include/dt-bindings/clock/r9a07g044-cpg.h b/include/dt-bindings/clock/r9a07g044-cpg.h
index 0bb17ff1a01a..e209f96f92b7 100644
--- a/include/dt-bindings/clock/r9a07g044-cpg.h
+++ b/include/dt-bindings/clock/r9a07g044-cpg.h
@@ -217,4 +217,62 @@
 #define R9A07G044_ADC_ADRST_N		82
 #define R9A07G044_TSU_PRESETN		83
 
+/* Power domain IDs. */
+#define R9A07G044_PD_ALWAYS_ON		0
+#define R9A07G044_PD_GIC		1
+#define R9A07G044_PD_IA55		2
+#define R9A07G044_PD_MHU		3
+#define R9A07G044_PD_CORESIGHT		4
+#define R9A07G044_PD_SYC		5
+#define R9A07G044_PD_DMAC		6
+#define R9A07G044_PD_GTM0		7
+#define R9A07G044_PD_GTM1		8
+#define R9A07G044_PD_GTM2		9
+#define R9A07G044_PD_MTU		10
+#define R9A07G044_PD_POE3		11
+#define R9A07G044_PD_GPT		12
+#define R9A07G044_PD_POEGA		13
+#define R9A07G044_PD_POEGB		14
+#define R9A07G044_PD_POEGC		15
+#define R9A07G044_PD_POEGD		16
+#define R9A07G044_PD_WDT0		17
+#define R9A07G044_PD_WDT1		18
+#define R9A07G044_PD_SPI		19
+#define R9A07G044_PD_SDHI0		20
+#define R9A07G044_PD_SDHI1		21
+#define R9A07G044_PD_3DGE		22
+#define R9A07G044_PD_ISU		23
+#define R9A07G044_PD_VCPL4		24
+#define R9A07G044_PD_CRU		25
+#define R9A07G044_PD_MIPI_DSI		26
+#define R9A07G044_PD_LCDC		27
+#define R9A07G044_PD_SSI0		28
+#define R9A07G044_PD_SSI1		29
+#define R9A07G044_PD_SSI2		30
+#define R9A07G044_PD_SSI3		31
+#define R9A07G044_PD_SRC		32
+#define R9A07G044_PD_USB0		33
+#define R9A07G044_PD_USB1		34
+#define R9A07G044_PD_USB_PHY		35
+#define R9A07G044_PD_ETHER0		36
+#define R9A07G044_PD_ETHER1		37
+#define R9A07G044_PD_I2C0		38
+#define R9A07G044_PD_I2C1		39
+#define R9A07G044_PD_I2C2		40
+#define R9A07G044_PD_I2C3		41
+#define R9A07G044_PD_SCIF0		42
+#define R9A07G044_PD_SCIF1		43
+#define R9A07G044_PD_SCIF2		44
+#define R9A07G044_PD_SCIF3		45
+#define R9A07G044_PD_SCIF4		46
+#define R9A07G044_PD_SCI0		47
+#define R9A07G044_PD_SCI1		48
+#define R9A07G044_PD_IRDA		49
+#define R9A07G044_PD_RSPI0		50
+#define R9A07G044_PD_RSPI1		51
+#define R9A07G044_PD_RSPI2		52
+#define R9A07G044_PD_CANFD		53
+#define R9A07G044_PD_ADC		54
+#define R9A07G044_PD_TSU		55
+
 #endif /* __DT_BINDINGS_CLOCK_R9A07G044_CPG_H__ */
-- 
2.39.2


