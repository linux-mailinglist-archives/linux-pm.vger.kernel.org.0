Return-Path: <linux-pm+bounces-15845-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB169A1D93
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 10:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C793283364
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 08:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2D41D5CCD;
	Thu, 17 Oct 2024 08:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHX5l13p"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B9E1C07C7;
	Thu, 17 Oct 2024 08:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729155121; cv=none; b=WuB8+RIkZj6b1Gwv0vyJ6GMDdiHmAqIESarEL7YoVW7/5o9RmlpoTNb1vA1ODDQNFXekqkvQcaMcsTz85VnNBA07oEtzBU66gxkyd82ODjMR9R6lOW/D231A4CC9JQZUvyghn9Gg13L/A6QsLzeyilc+ukHQToPgsCfhbU81CKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729155121; c=relaxed/simple;
	bh=26Jw6nHZi5IebIm7GrQ5mqzq6U+LxqTLhaoBfJPlUvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=drXPM0Mi03j87TIaOYBqrC0Pw5Sp1n1t2cmUsTR0ZPtsuPjDmLDDsjUo8qdPYfaYQeppJBKqEQLmRo6svp/BoNEAfgLZnshDJLIsSAGRuJhkgDkC3ODtOd8h0N/mNnJnXtz1gKUE67WHL0BzJ+c4nbvITuMuNLypRMMvsb/QJFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHX5l13p; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c9625cfe4dso929435a12.0;
        Thu, 17 Oct 2024 01:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729155117; x=1729759917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/z+P8UNvqP2F207yqlUX6ImNjWsCKBW8fNTzu+b0Lqk=;
        b=ZHX5l13pExyffVpOvkZ6dzm7Toa/TPlyGJ7hj/zkrYPG+36w3GgDzYVBgxtgrSzuXx
         pZe1Ue3jz8e4hFWwEO2r8uug87z+wQ4j9pBtdCkBWHVTSaaVCsAZ0Qi42EUoo9n+oaYP
         BQfj7W+0HXoxbArNmLGWHFdYUvQ+6FkVatsv1HT25SEQPrtAorAfPvEHThtSSEWiYqjA
         MX4uK0sEBw30vPQJid92ilj5I8+B0Sax3K/tR6J7N8CWz8ol4t/Ks1Nb6sOYZDZGu2ma
         yT9lmSQnXR1xKhqNPqERTEXaPXP8yfO7a2r1c+q74eEZYa9TG2wCh1BFiKiE5Wjq7csL
         DvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729155117; x=1729759917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/z+P8UNvqP2F207yqlUX6ImNjWsCKBW8fNTzu+b0Lqk=;
        b=tzQcf1iEkysNYyh8207TE60e86HvISJbbXF0sfxJoS6PSe7Xut2iJX9g4bqv8aiIGD
         rJB9Ubt3N783cIZpxqSdsIz84iNuJvVGvI88LiA2aHQUdXpIBMFnix223RJlzDW+oxeV
         AVZ7UwXcSPcrEtutb/BOw5az/ZL4ZYR6Ff76kYxRRQw6Q84WuY/7ITgupncsYy1uph1+
         NUwfLAIVCd912POf36kR04kHpgHkWwP/76NxjP0EZ8Lc0kO/3A+ol8xnhznlB8xwsl16
         vY03WHCP9NXF2pea8iV+lr5aKbZIutanIHQ6ZbLCUWxeAzv7Dg6zNtUzWBehFqcjunbV
         PU0g==
X-Forwarded-Encrypted: i=1; AJvYcCUipaxmk6N2V+IityOQBM8L/y19dVHJO22X0Gc0xgzKcTeezc+0aiYCl11KJabBCcHaLyXtdC5DaJexPj8L@vger.kernel.org, AJvYcCVBq/ay1l1Z5wowBkMu/hlXrIFTU3OHrUWZ2HDtEQ5Dfw2K0/tCnHkukD+vqhpBXe6onVON99AoXUiY@vger.kernel.org, AJvYcCWcF3ty4YKSdw/FZS5LEqHU/MOxORt9Z16RUnSi+3odIX6CLTS3Jmg6lKv3uiAxN0yNpCB+eNJ0i2c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1dkS18fmKjFNA2Eedt/ZRHbgPVwNNDhtmw6TKpTn6hZ8sw3oU
	FjRKoSFVvPZNXZnKvaKfaZuk1RPhSe3goEPLTr+5cZI6miNMcFFT
X-Google-Smtp-Source: AGHT+IHasxy8ZcBwQ63aPHXND9H4VsUQyIbWvOQ1NFxI6SZCCyCKPXsoumTK68tT8iJu7uplyyd/TQ==
X-Received: by 2002:a17:907:848:b0:a99:d587:6045 with SMTP id a640c23a62f3a-a99e3b319efmr1895383266b.19.1729155116394;
        Thu, 17 Oct 2024 01:51:56 -0700 (PDT)
Received: from zenbook.agu.edu.tr ([95.183.227.32])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a29816c24sm267045266b.110.2024.10.17.01.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 01:51:55 -0700 (PDT)
From: Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	Fabien Parent <fparent@baylibre.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Alexandre Bailon <abailon@baylibre.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Eugen Hristev <eugen.hristev@collabora.com>,
	MandyJH Liu <mandyjh.liu@mediatek.com>
Cc: Yassine Oudjana <y.oudjana@protonmail.com>,
	Yassine Oudjana <yassine.oudjana@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v3 1/2] dt-bindings: power: Add binding for MediaTek MT6735 power controller
Date: Thu, 17 Oct 2024 11:51:34 +0300
Message-ID: <20241017085136.68053-2-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241017085136.68053-1-y.oudjana@protonmail.com>
References: <20241017085136.68053-1-y.oudjana@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yassine Oudjana <y.oudjana@protonmail.com>

Add DT binding for MediaTek MT6735 SCPSYS power controller.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 .../bindings/power/mediatek,power-controller.yaml  |  1 +
 .../devicetree/bindings/soc/mediatek/scpsys.txt    |  1 +
 .../power/mediatek,mt6735-power-controller.h       | 14 ++++++++++++++
 3 files changed, 16 insertions(+)
 create mode 100644 include/dt-bindings/power/mediatek,mt6735-power-controller.h

diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
index 8985e2df8a566..6d37c06b2f65b 100644
--- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
@@ -23,6 +23,7 @@ properties:
 
   compatible:
     enum:
+      - mediatek,mt6735-power-controller
       - mediatek,mt6795-power-controller
       - mediatek,mt8167-power-controller
       - mediatek,mt8173-power-controller
diff --git a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
index 2bc367793aec1..3530a6668b486 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
+++ b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
@@ -20,6 +20,7 @@ Required properties:
 - compatible: Should be one of:
 	- "mediatek,mt2701-scpsys"
 	- "mediatek,mt2712-scpsys"
+	- "mediatek,mt6735-scpsys"
 	- "mediatek,mt6765-scpsys"
 	- "mediatek,mt6797-scpsys"
 	- "mediatek,mt7622-scpsys"
diff --git a/include/dt-bindings/power/mediatek,mt6735-power-controller.h b/include/dt-bindings/power/mediatek,mt6735-power-controller.h
new file mode 100644
index 0000000000000..6957075fcb9e5
--- /dev/null
+++ b/include/dt-bindings/power/mediatek,mt6735-power-controller.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_POWER_MT6735_POWER_CONTROLLER_H
+#define _DT_BINDINGS_POWER_MT6735_POWER_CONTROLLER_H
+
+#define MT6735_POWER_DOMAIN_MD1		0
+#define MT6735_POWER_DOMAIN_CONN	1
+#define MT6735_POWER_DOMAIN_DIS		2
+#define MT6735_POWER_DOMAIN_MFG		3
+#define MT6735_POWER_DOMAIN_ISP		4
+#define MT6735_POWER_DOMAIN_VDE		5
+#define MT6735_POWER_DOMAIN_VEN		6
+
+#endif
-- 
2.47.0


