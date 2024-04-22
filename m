Return-Path: <linux-pm+bounces-6785-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7388ACB5C
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 12:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CC271C21434
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 10:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF8E147C81;
	Mon, 22 Apr 2024 10:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="VsiNJsI7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748011474C2
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 10:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713783250; cv=none; b=eDS4Bx+CesvHK4y2xGAHzeCokR9PMthDmVaoAMwjLVHZquTtVJVLM03gEC0hkq3hALzGR/OTN+K1y/6rFj9ccviyJREaleFivP+FZFx7DA6H7Vw42+CIibvX2ZUu8eVJ0+ODgW3rIfcQyAT9kz/G4hJu8C0082IyfQwQgS5Bccs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713783250; c=relaxed/simple;
	bh=jBL0JWjfGth/MHnnCju+Zzypdjywr5OYaa+Xd2xpy0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tDwM4vbA5plz+PKS6FYvvlEL/5r9lvtfK11OE7Wg4RDCPTuadq1Ru0PlAT51ydtfEu7gGq8KxODc4kYWTWFUrvuafY/WXZf4N43+5svt8KwwyjKe2pWzfG6cXE4/GgZyRSHWHEzwumTLhgYJJEIw/m2oCX89D/5VdYhoQx2lxJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=VsiNJsI7; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41a7c7abed9so2847845e9.3
        for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 03:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713783247; x=1714388047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DujxY81OusTjOSIAeK9ewJpf/aHOeWDHdo6vi/BYgw0=;
        b=VsiNJsI7eAekPmWG2ad9AUoy/p97RYqUwzM2luMo2IEA33zEUt4HHD+lLJ1b4weuzu
         32CQ0nKR7Rg3NahHz9VirIbssWGsAJxMC/WPp3CDm0NwNMgIUDGsmDQ97TTWEUHXTz5m
         E558pjIoxnD8ncpE8P9SjWGDKN4N3u7GXewNiemLUuegqlLNm4HBNlSBx7IIyvHOCHcp
         U2v60LH4WB+pdPgXf9g8dD+gdgqMhJBkPAQdCHozxFtERNOK8qX5ydT6ZJGdgcY92zru
         FdGTjiCJXvICpk5RgWthOx8fZUzeY6KNYLfJm5+mMZJI/BdTav+d1QfizipFM0af98TO
         HrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713783247; x=1714388047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DujxY81OusTjOSIAeK9ewJpf/aHOeWDHdo6vi/BYgw0=;
        b=px4/Qu03OjvsvuY1APybtgT//WkOfL2IqwD5aqbhQy4NejDu3p9CZESH8zV4TmDzCY
         ms9Xp5/etAEFu7DqFDZ67aAj1Gl+k9kOyRome1DISAWlZcSjlBLlHX42PGwXKF9ZVb6T
         Rj/ayp7P29Fm8EQQNlwNhME9TKNVzAYA3F7b35jn9H2jL4wBu9bAN+rl4NdA4Hvmrv7n
         LaXT4/MGtKjow08VUoRx0ORKqK4qpxtYT8g6yo0aiP0s/PWalEza/0qS85gDE4inhxLq
         lvE3K4pjRiQAH4pG+TgCyQvwOj9dieM6tICix+jQR4wiL8OYH/G1ukmDylqHBEEdG+O/
         YJpw==
X-Forwarded-Encrypted: i=1; AJvYcCX1ufzvwlN+H1rN4tJfpGGbeQOuhQywWp5gV/Dm5LrrKcw/E1jJjg8HMe3L1cDl3D8mN8o+8f4UMqteo5kA/d2gO7tHNnZKoco=
X-Gm-Message-State: AOJu0Yz7UvZxNsDALRyxpy3w0J87yGHu1vZ7Ctjf3u3f+i3EqOyYnRXH
	suyXWTrC89+fiXloVewz0qabPDIBWa8XF2cBniBSE31NdpydOJsZXnZNZtMYDMbTB5DC2ZhU7Hc
	gHjw=
X-Google-Smtp-Source: AGHT+IH6F32OmRNhUIxW1tBTqqfyu31kv89EAgKtlxPomEw0pOhp793hqWUc42QYmPoPxxHUWRWTTQ==
X-Received: by 2002:a05:600c:3582:b0:418:e304:4a13 with SMTP id p2-20020a05600c358200b00418e3044a13mr5184864wmq.19.1713783246988;
        Mon, 22 Apr 2024 03:54:06 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.53])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c444d00b0041a3f700ccesm4321037wmn.40.2024.04.22.03.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 03:54:06 -0700 (PDT)
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
Subject: [PATCH v4 4/8] dt-bindings: clock: r9a08g045-cpg: Add power domain IDs
Date: Mon, 22 Apr 2024 13:53:51 +0300
Message-Id: <20240422105355.1622177-5-claudiu.beznea.uj@bp.renesas.com>
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

Add power domain IDs for RZ/G3S (R9A08G045) SoC.

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

 include/dt-bindings/clock/r9a08g045-cpg.h | 70 +++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/include/dt-bindings/clock/r9a08g045-cpg.h b/include/dt-bindings/clock/r9a08g045-cpg.h
index 410725b778a8..8281e9caf3a9 100644
--- a/include/dt-bindings/clock/r9a08g045-cpg.h
+++ b/include/dt-bindings/clock/r9a08g045-cpg.h
@@ -239,4 +239,74 @@
 #define R9A08G045_I3C_PRESETN		92
 #define R9A08G045_VBAT_BRESETN		93
 
+/* Power domain IDs. */
+#define R9A08G045_PD_ALWAYS_ON		0
+#define R9A08G045_PD_GIC		1
+#define R9A08G045_PD_IA55		2
+#define R9A08G045_PD_MHU		3
+#define R9A08G045_PD_CORESIGHT		4
+#define R9A08G045_PD_SYC		5
+#define R9A08G045_PD_DMAC		6
+#define R9A08G045_PD_GTM0		7
+#define R9A08G045_PD_GTM1		8
+#define R9A08G045_PD_GTM2		9
+#define R9A08G045_PD_GTM3		10
+#define R9A08G045_PD_GTM4		11
+#define R9A08G045_PD_GTM5		12
+#define R9A08G045_PD_GTM6		13
+#define R9A08G045_PD_GTM7		14
+#define R9A08G045_PD_MTU		15
+#define R9A08G045_PD_POE3		16
+#define R9A08G045_PD_GPT		17
+#define R9A08G045_PD_POEGA		18
+#define R9A08G045_PD_POEGB		19
+#define R9A08G045_PD_POEGC		20
+#define R9A08G045_PD_POEGD		21
+#define R9A08G045_PD_WDT0		22
+#define R9A08G045_PD_XSPI		23
+#define R9A08G045_PD_SDHI0		24
+#define R9A08G045_PD_SDHI1		25
+#define R9A08G045_PD_SDHI2		26
+#define R9A08G045_PD_SSI0		27
+#define R9A08G045_PD_SSI1		28
+#define R9A08G045_PD_SSI2		29
+#define R9A08G045_PD_SSI3		30
+#define R9A08G045_PD_SRC		31
+#define R9A08G045_PD_USB0		32
+#define R9A08G045_PD_USB1		33
+#define R9A08G045_PD_USB_PHY		34
+#define R9A08G045_PD_ETHER0		35
+#define R9A08G045_PD_ETHER1		36
+#define R9A08G045_PD_I2C0		37
+#define R9A08G045_PD_I2C1		38
+#define R9A08G045_PD_I2C2		39
+#define R9A08G045_PD_I2C3		40
+#define R9A08G045_PD_SCIF0		41
+#define R9A08G045_PD_SCIF1		42
+#define R9A08G045_PD_SCIF2		43
+#define R9A08G045_PD_SCIF3		44
+#define R9A08G045_PD_SCIF4		45
+#define R9A08G045_PD_SCIF5		46
+#define R9A08G045_PD_SCI0		47
+#define R9A08G045_PD_SCI1		48
+#define R9A08G045_PD_IRDA		49
+#define R9A08G045_PD_RSPI0		50
+#define R9A08G045_PD_RSPI1		51
+#define R9A08G045_PD_RSPI2		52
+#define R9A08G045_PD_RSPI3		53
+#define R9A08G045_PD_RSPI4		54
+#define R9A08G045_PD_CANFD		55
+#define R9A08G045_PD_ADC		56
+#define R9A08G045_PD_TSU		57
+#define R9A08G045_PD_OCTA		58
+#define R9A08G045_PD_PDM		59
+#define R9A08G045_PD_PCI		60
+#define R9A08G045_PD_SPDIF		61
+#define R9A08G045_PD_I3C		62
+#define R9A08G045_PD_VBAT		63
+
+#define R9A08G045_PD_DDR		64
+#define R9A08G045_PD_TZCDDR		65
+#define R9A08G045_PD_OTFDE_DDR		66
+
 #endif /* __DT_BINDINGS_CLOCK_R9A08G045_CPG_H__ */
-- 
2.39.2


