Return-Path: <linux-pm+bounces-6784-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 009D18ACB58
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 12:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59234B227B5
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 10:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2961474B1;
	Mon, 22 Apr 2024 10:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="PiCsSLE6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D9D145342
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 10:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713783248; cv=none; b=FNnpzAmNhtzD3j6ZCWC2uidiuTf4FJB22u07hF/jL+XNuuAOA2uPbWdCe4pGjQUigCuresydvzk1LCWcNrbakZIBZl66NZzaZEvw2OJ7Aep/UJ0BADWi6EQb8tgeFxZykEHkUMPbMziEf8YXl9oxkYR5zeigaONs3fX5l4/C1j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713783248; c=relaxed/simple;
	bh=DAURA/SctP3A5mGX8sS9JbsxOWN2+gRI7JV51DX+W2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iFQztWRg3xaY0VsSn0MFPtnEAO/z25ZswL+iVPY6eWV+6ckXiKopRAWDn1VAWmfNVMGwV7X7Od+BOUuc6csiFgeJE+b3NpoIIvrBmNLt5VAbfwo23Z1WqXhQbLrvJgNqjpdPHADOmSeg5vlD42mL4tnOu+XgRzjPiaZsZAM/oYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=PiCsSLE6; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-343d7ff2350so3131098f8f.0
        for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 03:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713783245; x=1714388045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YtPB6ctP7od8zgdwyqg5bLwGVgQvxXp2ISVh1oG7rJs=;
        b=PiCsSLE6ERJ6uUPCKaqo2i3bd8ho/Qd3PJGqRkMU28FM9uLuE3NaTuCYz0DUKc7Ifr
         30r/r/VROkZIERpjSF4P2wtURQxhaAlOMGIVZ6Iamn2CGICvyxaJAHl4xyEN/nsA/C7G
         QmgZzkAWAxUK9XlE3dYinQqaAHLro9dHBo2/+o80snczC+1c360DINIeB3mPgGxZA6Th
         BLfIXdixJNvpKVE7jVsQHTR4qWcWzIVtJHtUJHcnxIV+C94X1mUUgBR6Jq6IwDQB6oLH
         KH1RTy7+u7P5mQLTYLx5OoHX7TrlzBH3Rq9u+F+cFR7rieqqlE+DE+KNUy6V7zsXbnfG
         EkfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713783245; x=1714388045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YtPB6ctP7od8zgdwyqg5bLwGVgQvxXp2ISVh1oG7rJs=;
        b=gP3pUW0iDR9lMARfXtMH4Yy5Vi8TIUMs60VZxfgcZGZC4JpiV6uQPOFmAun72d14WV
         8Dz1Pe1h5CU/fuo+dQiECz9d5iByNmDqjDslFQJIqs5jpTkeasxqIvgUAW0Rwt2fOoi4
         KJxetS4v4Ke0HKUHNV8gx4t2BozJFZXdw0VabjqFthPqDsqKkfsYH0ULW4+x3FiTeQPa
         lMzhd0tEPuTRP/TQkycFV/w/BK+N2qCyXV7XivAFgix1CT/R5loGR0iiYNztRKQCzYiH
         +5ceBJJ2kk1+LPdqgzjWrMXSfaDdrH42Rpy0F1e6ArhuWTj1OgI7oyc0xefOpXIzy4Zd
         Ok8g==
X-Forwarded-Encrypted: i=1; AJvYcCWmcdyzFCuKoU7Ktiahl6n6y0IszxgjiBD9Sc7J2EMCrIynq97jZwJWzUpjAjm7PZo9SPubItswr0Mov3rvqHztCFL23m1r594=
X-Gm-Message-State: AOJu0YxyoHQ2lJmXdwkw/6rSwBtZa+qyXDtKSeStza1PiZXXNaiUpi9G
	rf+38I+XP1QRw+r0jJnu0K9RBtYi05wmQ2Y9NEzsaAB2y8Pe1fut+Fu2SHk5yZM=
X-Google-Smtp-Source: AGHT+IFLCJwMoJjU6D0NWaWvNE1gp038ynHMSy1TehAKgDSlKi/ffr0hQ2I4cGne8RszfNJgK/2ZdA==
X-Received: by 2002:adf:ed84:0:b0:34a:e6bb:bd9e with SMTP id c4-20020adfed84000000b0034ae6bbbd9emr3145768wro.46.1713783244989;
        Mon, 22 Apr 2024 03:54:04 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.53])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c444d00b0041a3f700ccesm4321037wmn.40.2024.04.22.03.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 03:54:04 -0700 (PDT)
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
Subject: [PATCH v4 3/8] dt-bindings: clock: r9a07g054-cpg: Add power domain IDs
Date: Mon, 22 Apr 2024 13:53:50 +0300
Message-Id: <20240422105355.1622177-4-claudiu.beznea.uj@bp.renesas.com>
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

Add power domain IDs for RZ/V2L (R9A07G054) SoC.

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

 include/dt-bindings/clock/r9a07g054-cpg.h | 58 +++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/include/dt-bindings/clock/r9a07g054-cpg.h b/include/dt-bindings/clock/r9a07g054-cpg.h
index 43f4dbda872c..2c99f89397c4 100644
--- a/include/dt-bindings/clock/r9a07g054-cpg.h
+++ b/include/dt-bindings/clock/r9a07g054-cpg.h
@@ -226,4 +226,62 @@
 #define R9A07G054_TSU_PRESETN		83
 #define R9A07G054_STPAI_ARESETN		84
 
+/* Power domain IDs. */
+#define R9A07G054_PD_ALWAYS_ON		0
+#define R9A07G054_PD_GIC		1
+#define R9A07G054_PD_IA55		2
+#define R9A07G054_PD_MHU		3
+#define R9A07G054_PD_CORESIGHT		4
+#define R9A07G054_PD_SYC		5
+#define R9A07G054_PD_DMAC		6
+#define R9A07G054_PD_GTM0		7
+#define R9A07G054_PD_GTM1		8
+#define R9A07G054_PD_GTM2		9
+#define R9A07G054_PD_MTU		10
+#define R9A07G054_PD_POE3		11
+#define R9A07G054_PD_GPT		12
+#define R9A07G054_PD_POEGA		13
+#define R9A07G054_PD_POEGB		14
+#define R9A07G054_PD_POEGC		15
+#define R9A07G054_PD_POEGD		16
+#define R9A07G054_PD_WDT0		17
+#define R9A07G054_PD_WDT1		18
+#define R9A07G054_PD_SPI		19
+#define R9A07G054_PD_SDHI0		20
+#define R9A07G054_PD_SDHI1		21
+#define R9A07G054_PD_3DGE		22
+#define R9A07G054_PD_ISU		23
+#define R9A07G054_PD_VCPL4		24
+#define R9A07G054_PD_CRU		25
+#define R9A07G054_PD_MIPI_DSI		26
+#define R9A07G054_PD_LCDC		27
+#define R9A07G054_PD_SSI0		28
+#define R9A07G054_PD_SSI1		29
+#define R9A07G054_PD_SSI2		30
+#define R9A07G054_PD_SSI3		31
+#define R9A07G054_PD_SRC		32
+#define R9A07G054_PD_USB0		33
+#define R9A07G054_PD_USB1		34
+#define R9A07G054_PD_USB_PHY		35
+#define R9A07G054_PD_ETHER0		36
+#define R9A07G054_PD_ETHER1		37
+#define R9A07G054_PD_I2C0		38
+#define R9A07G054_PD_I2C1		39
+#define R9A07G054_PD_I2C2		40
+#define R9A07G054_PD_I2C3		41
+#define R9A07G054_PD_SCIF0		42
+#define R9A07G054_PD_SCIF1		43
+#define R9A07G054_PD_SCIF2		44
+#define R9A07G054_PD_SCIF3		45
+#define R9A07G054_PD_SCIF4		46
+#define R9A07G054_PD_SCI0		47
+#define R9A07G054_PD_SCI1		48
+#define R9A07G054_PD_IRDA		49
+#define R9A07G054_PD_RSPI0		50
+#define R9A07G054_PD_RSPI1		51
+#define R9A07G054_PD_RSPI2		52
+#define R9A07G054_PD_CANFD		53
+#define R9A07G054_PD_ADC		54
+#define R9A07G054_PD_TSU		55
+
 #endif /* __DT_BINDINGS_CLOCK_R9A07G054_CPG_H__ */
-- 
2.39.2


