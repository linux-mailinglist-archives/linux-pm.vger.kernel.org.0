Return-Path: <linux-pm+bounces-34298-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 563C6B50545
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 20:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A29F14E4EF5
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 18:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7FF3680A3;
	Tue,  9 Sep 2025 18:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uuu2SGqx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EB1362092;
	Tue,  9 Sep 2025 18:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757442583; cv=none; b=GtAXDIfLR1FTKYyfwS835fTeMmaKPMO3e1SU9qk/hKtpd4xf3oDUAAeJoBoEVkhaQtYJAvxGKjL5BAh2dJPdqPh6LvTMGBTkmnsQr1cHtAQCndKcfq+OEEpuz7ufOQzzfRfbsCuXKopYlXN2Gx5reFsmAEG8sdXIttbpvy6hvos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757442583; c=relaxed/simple;
	bh=uhZjx01PPl+bdqGcbmMs8H3FSpiWecI/idkaYe7I1qs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dxNdCqvdXMuWuITJXwxssydVk6f9Z4/2JoDKIB/PhozqSvkh6cHwfhm1wfpXRkhcclfRzUO8hOt3HGnrYgxQp/qiLJnS5aBXA9Iqfm/5xFxytMb/0ovls4xgNGDE4tDxuH4UhiE4lXf7K+X3RSUs254kShrI7hZyipLHzy3W6+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uuu2SGqx; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb7ace3baso1028211366b.3;
        Tue, 09 Sep 2025 11:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757442580; x=1758047380; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2IsTNlsBIxhidJqanKk05pz8jsYCjvOdpYNz8PoVsZM=;
        b=Uuu2SGqx1rLjDnTaWQjDM6AxaB+9cwdQG1GsUV5WS9adjdqe4/sxgOT0sv3L+ubDya
         BigfREgg08DPW1FO+7a8pJaxKlCBlaXCCrDKMg0/cW/lN00BxTrNwpm1t64I7iOdbe0G
         H332BbSgpRHL9WC8vhKb6mXF/qr8+mHbTIqdCCFhgR+6569JDV8TUgYw7dmFOKoaiPDp
         mGK6hEXgr/vj3L/EYE3dzrX70YByJcvssOTCC1gXd/kjnzfXpoBN91hbjna9mkHccaNJ
         EWHET1Q40Fu12HQBKIdORXVFw7EGppMyvmhRnBpFxG6OFOAC7OBCxSQLENoM+5ZRnEkA
         5+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757442580; x=1758047380;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2IsTNlsBIxhidJqanKk05pz8jsYCjvOdpYNz8PoVsZM=;
        b=GxjnS699au0NPbumIzPoC3s8Kk/dUI3ji0jpAbSAx33qrrwTP3xGTNeihPEklru85V
         dnhFR6taGGoMGD/iI+2814sFtTGGj1CQEbeur+wwLW3TxfeSDD1NaVbGUxALGczmdj4Y
         m7AD1pm70ybtFw8BC0Cql2T773taWriCDOkxmlOhawqxIXv/YzpIJ2SBetdJKM9sAdp8
         IvvI/nIDvj4lOlzwDyBiIsS93phcQOogJ8AitNyJrMW/MkL7BbTAu0MoJIjU7qlX0gPv
         QkYrfbLKLsGZZHECvHo616fwNNLk0zmi5R3VdmXVoQbLmpSoK/9t8UhraS8iQvRwLAJi
         j7KA==
X-Forwarded-Encrypted: i=1; AJvYcCU/kb6B7k75tYHHBLcITHSsNe3xBUFaC1+SKCq/EPGhgctwQtUM/vMg5J1ZnynzlUwfPEVWTHs3HXjK99k=@vger.kernel.org, AJvYcCVxbPvVpJ5+9vmtzR7kjfHLIDQEQvrp0cOOcXwNZ+49D8OiNUzVYEtpy/L2InGONv4u/ZWiX9HabNM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzum44tiMrtgFv6MIHFvwGL36TpBery2XUYOKGfIKnkl1SdPe09
	VTxjX58WgeDl/KDRRPnalp+AJ7O69EgZHIHS5LvH2iCSY3ZGMMvpyeJq
X-Gm-Gg: ASbGnctVYryHGQGKRpsRvpFdxYQxfZyV5XZZQHrUih0I1mXYvwdLS1A1DsOfbiA21eI
	MddXRzubMWhEhPOoC8UrbhPp7h6dgdZZj0KMld+Mv7mydtkVtWFawqhNUfbxoNMU9KxKnQNfVjT
	FnRhhMzAoseS+AZFXorLKGZkBY85Z7AlQHMgQ+jNoZkercUYYaCD6QVglx69rJj/7f9G/oDSlLS
	2de7jQ8LlcbPOZ+zMl0IIkhA02L8YTOxg6iQhLxuhFm+h2IrSBD4iWfDYEb3Q8/x1vS1IJJ4jJJ
	+fli/k/eIW5pp/h7e43IFu4N6opWX6QAAdAeabf+fgez3Da7IEnJM5z31cdSG/hnnsTfv6TMa4i
	0iInVjLX+vWtt+QcrbU0A66v4KOpprBI=
X-Google-Smtp-Source: AGHT+IFia/+L+AKZwrcIvhRq30VpvOWSDjlumDVs/H+Q0xYQT8wJDO27ftWn5N5g6hz7Ba0S7jG4GQ==
X-Received: by 2002:a17:906:6a04:b0:b04:6264:cf7c with SMTP id a640c23a62f3a-b04b16dd3bfmr1264169766b.44.1757442579952;
        Tue, 09 Sep 2025 11:29:39 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b07833ebe61sm30520666b.89.2025.09.09.11.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 11:29:39 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Tue, 09 Sep 2025 21:29:17 +0300
Subject: [PATCH v2 7/9] power: supply: max77705_charger: use
 REGMAP_IRQ_REG_LINE macro
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-max77705_77976_charger_improvement-v2-7-a8d2fba47159@gmail.com>
References: <20250909-max77705_77976_charger_improvement-v2-0-a8d2fba47159@gmail.com>
In-Reply-To: <20250909-max77705_77976_charger_improvement-v2-0-a8d2fba47159@gmail.com>
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757442571; l=3504;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=uhZjx01PPl+bdqGcbmMs8H3FSpiWecI/idkaYe7I1qs=;
 b=adV1fAd6FxfmwMfbXsdnvPG+K1Tin48Db9L+DseKUMzhVHdU60KOoZ40778JWvDA0jkYTXsPy
 1+7OMN9WwGoBqtjFXk0quLk5T3AY7N0gPAWEZHeq1vwBs5UVu6/PNUD
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Refactor regmap_irq declarations with REGMAP_IRQ_REG_LINE saves a few
lines on definitions.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 drivers/power/supply/max77705_charger.c | 16 ++++++-------
 include/linux/power/max77705_charger.h  | 42 +++++++++++++--------------------
 2 files changed, 24 insertions(+), 34 deletions(-)

diff --git a/drivers/power/supply/max77705_charger.c b/drivers/power/supply/max77705_charger.c
index 4e5219ffa87c..f381ece5502b 100644
--- a/drivers/power/supply/max77705_charger.c
+++ b/drivers/power/supply/max77705_charger.c
@@ -50,14 +50,14 @@ static irqreturn_t max77705_chgin_irq(int irq, void *irq_drv_data)
 }
 
 static const struct regmap_irq max77705_charger_irqs[] = {
-	{ .mask = MAX77705_BYP_IM,   },
-	{ .mask = MAX77705_INP_LIMIT_IM,   },
-	{ .mask = MAX77705_BATP_IM,   },
-	{ .mask = MAX77705_BAT_IM,   },
-	{ .mask = MAX77705_CHG_IM,   },
-	{ .mask = MAX77705_WCIN_IM,   },
-	{ .mask = MAX77705_CHGIN_IM,   },
-	{ .mask = MAX77705_AICL_IM,   },
+	REGMAP_IRQ_REG_LINE(MAX77705_BYP_I, BITS_PER_BYTE),
+	REGMAP_IRQ_REG_LINE(MAX77705_INP_LIMIT_I, BITS_PER_BYTE),
+	REGMAP_IRQ_REG_LINE(MAX77705_BATP_I, BITS_PER_BYTE),
+	REGMAP_IRQ_REG_LINE(MAX77705_BAT_I, BITS_PER_BYTE),
+	REGMAP_IRQ_REG_LINE(MAX77705_CHG_I, BITS_PER_BYTE),
+	REGMAP_IRQ_REG_LINE(MAX77705_WCIN_I, BITS_PER_BYTE),
+	REGMAP_IRQ_REG_LINE(MAX77705_CHGIN_I, BITS_PER_BYTE),
+	REGMAP_IRQ_REG_LINE(MAX77705_AICL_I, BITS_PER_BYTE),
 };
 
 static struct regmap_irq_chip max77705_charger_irq_chip = {
diff --git a/include/linux/power/max77705_charger.h b/include/linux/power/max77705_charger.h
index a612795577b6..6653abfdf747 100644
--- a/include/linux/power/max77705_charger.h
+++ b/include/linux/power/max77705_charger.h
@@ -12,34 +12,24 @@
 #include <linux/regmap.h>
 
 /* MAX77705_CHG_REG_CHG_INT */
-#define MAX77705_BYP_I		BIT(0)
-#define MAX77705_INP_LIMIT_I	BIT(1)
-#define MAX77705_BATP_I		BIT(2)
-#define MAX77705_BAT_I		BIT(3)
-#define MAX77705_CHG_I		BIT(4)
-#define MAX77705_WCIN_I		BIT(5)
-#define MAX77705_CHGIN_I	BIT(6)
-#define MAX77705_AICL_I		BIT(7)
-
-/* MAX77705_CHG_REG_CHG_INT_MASK */
-#define MAX77705_BYP_IM		BIT(0)
-#define MAX77705_INP_LIMIT_IM	BIT(1)
-#define MAX77705_BATP_IM	BIT(2)
-#define MAX77705_BAT_IM		BIT(3)
-#define MAX77705_CHG_IM		BIT(4)
-#define MAX77705_WCIN_IM	BIT(5)
-#define MAX77705_CHGIN_IM	BIT(6)
-#define MAX77705_AICL_IM	BIT(7)
+#define MAX77705_BYP_I		(0)
+#define MAX77705_INP_LIMIT_I	(1)
+#define MAX77705_BATP_I		(2)
+#define MAX77705_BAT_I		(3)
+#define MAX77705_CHG_I		(4)
+#define MAX77705_WCIN_I		(5)
+#define MAX77705_CHGIN_I	(6)
+#define MAX77705_AICL_I		(7)
 
 /* MAX77705_CHG_REG_CHG_INT_OK */
-#define MAX77705_BYP_OK		BIT(0)
-#define MAX77705_DISQBAT_OK	BIT(1)
-#define MAX77705_BATP_OK	BIT(2)
-#define MAX77705_BAT_OK		BIT(3)
-#define MAX77705_CHG_OK		BIT(4)
-#define MAX77705_WCIN_OK	BIT(5)
-#define MAX77705_CHGIN_OK	BIT(6)
-#define MAX77705_AICL_OK	BIT(7)
+#define MAX77705_BYP_OK		BIT(MAX77705_BYP_I)
+#define MAX77705_DISQBAT_OK	BIT(MAX77705_INP_LIMIT_I)
+#define MAX77705_BATP_OK	BIT(MAX77705_BATP_I)
+#define MAX77705_BAT_OK		BIT(MAX77705_BAT_I)
+#define MAX77705_CHG_OK		BIT(MAX77705_CHG_I)
+#define MAX77705_WCIN_OK	BIT(MAX77705_WCIN_I)
+#define MAX77705_CHGIN_OK	BIT(MAX77705_CHGIN_I)
+#define MAX77705_AICL_OK	BIT(MAX77705_AICL_I)
 
 /* MAX77705_CHG_REG_DETAILS_00 */
 #define MAX77705_BATP_DTLS		BIT(0)

-- 
2.39.5


