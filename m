Return-Path: <linux-pm+bounces-6782-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E33E28ACB4E
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 12:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 916CD2821AD
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 10:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367EB146A67;
	Mon, 22 Apr 2024 10:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="qOYB3O6D"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043E214658C
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 10:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713783245; cv=none; b=fbo+Uv5+Dszdci8/gPHmZYJxjWm9M+7znakeV/rvE/28LifdjR819/XZ5hHyqmg+868vDszPIaPNfnU7qCnhDzVzXRL5M+QZ+srvZTcmwMVUUUjQMBn/XRLPmb7DxRBf/NyA9s3fUvJfoN20a9jhLyZsts167dDBQ1LyosTMgC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713783245; c=relaxed/simple;
	bh=nasE2d/SaWmaI1mXEgsloYfjMTW1nFFlm9lGYxvJ7Jw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N3hvDhcT+Fhb7q0mo080Adv7GWy9pVJLf7MKETkXB6WCh+pHtdVeDytdRVr0iVClhZ8Huc5a0u6m4a5B7B7AcDWAZAhKOaoxanFXirbZ+8dS19nEwzMLJAFWX45tBycN/fZzrj4i+QA0/v7Xz3HN81fGdbMI4jO/eC4CzUtZj7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=qOYB3O6D; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41a5b68ed85so4200145e9.1
        for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 03:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713783241; x=1714388041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=542/ywAaHZGwPc69BIK8qmVTXHU1k2NH/XrpCYbWuDs=;
        b=qOYB3O6DYWjf7HhQQMCiR5UKeAk2VxsobubHQsbdYv5U/sYH5BsrlGe0IEo4uI+Rfb
         B51ihq9Ep0Cv34Mh+LWdk/9zErYsRUI3Cu6LpkMjaKlHyvt9A7VTMemjvRDHD9UNmBBl
         ul3hQU8IkZQOoP8kwe6gKlGJWl7FkaMRPsOHvyU9IlVsVlylkGE5ppaLNUFhrheUUxuc
         00Ar7lCO8YWeTSIxuq5IXwcrW94nxQ3Hecy4jahQVDAcjo6jarNn8ihK8ZN9gTGQ0Zle
         uhU9uRZMFIn6VT0MV59Mwz3/B1z2CBxASFqqJaZbnlmPnLwPAu3byxuA1PQRdC0Bnu4p
         aotA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713783241; x=1714388041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=542/ywAaHZGwPc69BIK8qmVTXHU1k2NH/XrpCYbWuDs=;
        b=RZxNKM6GDp4mPVcblIEanjRS/LeSFBC8fEfKJQEqlJOK8N1Fl8dasqJgZptWcWrh4W
         SUfxu5fgN9H8JYkngY41XMsQkYZTK4k6a1bLR4CE+uMHpOKok4q3wUmO+v1XvS8Y5LAs
         EfwVjWxcPiVE1t0o/AfiNu58TLCTCkUItxjYdHHRGtVqXsTRz/Ayzs6r0rPA4zZ97SXu
         szvMFtoGhat7TjK858fMycjfv4/6XOU0EQ6P1c9xpIje66t6CRcAlhMgbsVBTlVA8Qra
         nspCCuK9tO6yLPvzkBSmddKtKXqUK8ZEi3N9Z4QOO+zf9JwEfCGY4tMmnmfVZi0Ops17
         wEYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsnC97ghrIXwzXx3F5nD66JTwrmbprgo0Iy4ipbW37SVGNUMtj9cALhQMFTlJBGT+q/b2sxjMaCIOqki2zylaS0gs5omhcMcg=
X-Gm-Message-State: AOJu0Yy5rA+zcJK9XW1/sF63RS7bmnCFHc1TH1FQyvnUX8l2qzG+dcWi
	j5CjKd1Pjg81Ka2fuC7OORK5cwfApSwQjKNYVYg4Lw7Ym8adHq4NqpYeBQO9hqY=
X-Google-Smtp-Source: AGHT+IHabouCTcJMeIW5AmQvEPKkFqlkcfdmP2ze+pndbXNYk3F+ugclHS1ird1ge/bIOeLjtDi57g==
X-Received: by 2002:a05:600c:3513:b0:418:91ae:befc with SMTP id h19-20020a05600c351300b0041891aebefcmr9060599wmq.0.1713783241285;
        Mon, 22 Apr 2024 03:54:01 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.53])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c444d00b0041a3f700ccesm4321037wmn.40.2024.04.22.03.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 03:54:00 -0700 (PDT)
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
Subject: [PATCH v4 1/8] dt-bindings: clock: r9a07g043-cpg: Add power domain IDs
Date: Mon, 22 Apr 2024 13:53:48 +0300
Message-Id: <20240422105355.1622177-2-claudiu.beznea.uj@bp.renesas.com>
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

Add power domain IDs for RZ/G2UL (R9A07G043) SoC.

Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- none

Changes in v3:
- collected tags

Changes in v2:
- added "RZ/G2UL Only" comments to some defines
- added RZ/Five specific defines

 include/dt-bindings/clock/r9a07g043-cpg.h | 52 +++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/include/dt-bindings/clock/r9a07g043-cpg.h b/include/dt-bindings/clock/r9a07g043-cpg.h
index a64139fec815..131993343777 100644
--- a/include/dt-bindings/clock/r9a07g043-cpg.h
+++ b/include/dt-bindings/clock/r9a07g043-cpg.h
@@ -200,5 +200,57 @@
 #define R9A07G043_AX45MP_CORE0_RESETN	78	/* RZ/Five Only */
 #define R9A07G043_IAX45_RESETN		79	/* RZ/Five Only */
 
+/* Power domain IDs. */
+#define R9A07G043_PD_ALWAYS_ON		0
+#define R9A07G043_PD_GIC		1	/* RZ/G2UL Only */
+#define R9A07G043_PD_IA55		2	/* RZ/G2UL Only */
+#define R9A07G043_PD_MHU		3	/* RZ/G2UL Only */
+#define R9A07G043_PD_CORESIGHT		4	/* RZ/G2UL Only */
+#define R9A07G043_PD_SYC		5	/* RZ/G2UL Only */
+#define R9A07G043_PD_DMAC		6
+#define R9A07G043_PD_GTM0		7
+#define R9A07G043_PD_GTM1		8
+#define R9A07G043_PD_GTM2		9
+#define R9A07G043_PD_MTU		10
+#define R9A07G043_PD_POE3		11
+#define R9A07G043_PD_WDT0		12
+#define R9A07G043_PD_SPI		13
+#define R9A07G043_PD_SDHI0		14
+#define R9A07G043_PD_SDHI1		15
+#define R9A07G043_PD_ISU		16	/* RZ/G2UL Only */
+#define R9A07G043_PD_CRU		17	/* RZ/G2UL Only */
+#define R9A07G043_PD_LCDC		18	/* RZ/G2UL Only */
+#define R9A07G043_PD_SSI0		19
+#define R9A07G043_PD_SSI1		20
+#define R9A07G043_PD_SSI2		21
+#define R9A07G043_PD_SSI3		22
+#define R9A07G043_PD_SRC		23
+#define R9A07G043_PD_USB0		24
+#define R9A07G043_PD_USB1		25
+#define R9A07G043_PD_USB_PHY		26
+#define R9A07G043_PD_ETHER0		27
+#define R9A07G043_PD_ETHER1		28
+#define R9A07G043_PD_I2C0		29
+#define R9A07G043_PD_I2C1		30
+#define R9A07G043_PD_I2C2		31
+#define R9A07G043_PD_I2C3		32
+#define R9A07G043_PD_SCIF0		33
+#define R9A07G043_PD_SCIF1		34
+#define R9A07G043_PD_SCIF2		35
+#define R9A07G043_PD_SCIF3		36
+#define R9A07G043_PD_SCIF4		37
+#define R9A07G043_PD_SCI0		38
+#define R9A07G043_PD_SCI1		39
+#define R9A07G043_PD_IRDA		40
+#define R9A07G043_PD_RSPI0		41
+#define R9A07G043_PD_RSPI1		42
+#define R9A07G043_PD_RSPI2		43
+#define R9A07G043_PD_CANFD		44
+#define R9A07G043_PD_ADC		45
+#define R9A07G043_PD_TSU		46
+#define R9A07G043_PD_PLIC		47	/* RZ/Five Only */
+#define R9A07G043_PD_IAX45		48	/* RZ/Five Only */
+#define R9A07G043_PD_NCEPLDM		49	/* RZ/Five Only */
+#define R9A07G043_PD_NCEPLMT		50	/* RZ/Five Only */
 
 #endif /* __DT_BINDINGS_CLOCK_R9A07G043_CPG_H__ */
-- 
2.39.2


