Return-Path: <linux-pm+bounces-24266-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C8CA6804C
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 00:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89AA23B62A1
	for <lists+linux-pm@lfdr.de>; Tue, 18 Mar 2025 23:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB88213E72;
	Tue, 18 Mar 2025 23:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nlIkKEIH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018D3205E04
	for <linux-pm@vger.kernel.org>; Tue, 18 Mar 2025 23:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742338858; cv=none; b=iuv2y54zUKwGqraTmzLhMvqUbVd7QcqGtN0nnj/KmuLc0GJA6WKFZebuAH8ySaNz8bN24Nv6Nyb4CtPyR46ESg3g7vvFXVV/4T8YQ2eWklnGHuMgjO7HS9Bq8tYpo3HyywLLKFWuMm9guCJ7/x7kamB/L1QtD1eYCZNfj+RpVIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742338858; c=relaxed/simple;
	bh=rE41wxgzlKpGpaGBnybaNjCM4MuLIzqRK5L9RODPghQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F1ro2NWqhT0k1lmdpMxsJsiOD8N1tdqJWxuW2+0uu33eLHstoXTxdS58bRtMAT3LE8tUHBjtcH0A8ZrSBB4I3iP05PFiCWcIIbCIzkpO0glXfSAkH2X7+pcmZ95kPbQNpLghxb8UFEyzbuC/JW1kQEq/3Kyn3FNJnIBrii3OVik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nlIkKEIH; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22423adf751so109605775ad.2
        for <linux-pm@vger.kernel.org>; Tue, 18 Mar 2025 16:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742338855; x=1742943655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRK1BYeq9oENOjqMtHoyse0xgVkJUai4Nnq/5BnLYx4=;
        b=nlIkKEIHwMf3cR4Wk3WJjBcUVgZxE+HKLvJNp+cei7lFycQs8fI6bl4zC8qtoeinUn
         NMrOBHTFrc2HpG+mKoCL21nG3h8l/uMsKwDx1HkDzUX0BXzXoE3vrWzOZDbjDioMbk9R
         X4vrMkRAtpEPxYqHbKsMApSP7aCBNK5AKZ5QwZHkBV+BXhlUDydjG5Bh1Q2e7iVI9I2w
         ttNUKF4Q0CXIW2fNmLk8clxzZG9nWHMdTT0femhHz0UOngkhaEN4F/VRXRXysq03iIb0
         elKF3FjoUTRWtMPfOr0gQ6gA4zJGl0mMagmisUaLRoL6BCExH6ymVZ8uu57yxSLk14CN
         icjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742338855; x=1742943655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NRK1BYeq9oENOjqMtHoyse0xgVkJUai4Nnq/5BnLYx4=;
        b=gEPZPlYbdvdb24IpGs1bTTS5jRL8bQdqV3UM065Z/J/e4Uf0CPslBuRt8mbmf+TZ57
         mm0O63IESbA5vEODqTyHr1pwVE+qqbTTbD1LimNv+JB1qkaKosc6r26oUQ977LZeiT4+
         zhooCQuOeaaTmxRHv6Uxk6KqU0+wU1fD2V4JjZoQmZ1SeiCwAMqI0itvBTDpw4tzG5o+
         t8HWikjGfWK95JDY1LH0IwpbnVB8T8BLc3q61Ao3ovgSJAnL+9ivLkIT0zwQHK34b8Fa
         ofI5hlenXFDtWS/Y1oLsK367igk6xgKWUbMFCG5JyAaqfNiM7MdFZDhife6IVVOWIIIU
         foTg==
X-Forwarded-Encrypted: i=1; AJvYcCVwUlVd1AJF1JwRjAhBeXrTr48ZZ96rGXzj/CsRCDZ3mfBY3w9US5+6zkj1TkkKNLqdXF+SXiODTg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwT8NciYyarX203VMD6t1EXHotrRwY3ie3cv/vv6/W92N2j97ft
	DknK6FlGynbDUoyYJekwQVz16QEImDxKAZaQqe7CTBOLczBxUJ4bD0sUpt7G580=
X-Gm-Gg: ASbGnctpNF/4evbFCfYkBG2t6iOkwnkQGvJcnEJ7e8w0h1DJ1qyJ3G1Mir+hmCExEOQ
	ypdLeemsUwjeWpnFq8Q0hJUPwQfdCX2eyvbsFf9xCyA5m4t5RK/w0H4qHrVWA9skIASDpN5/CLD
	BJ76Wsc3vY1ttgYhCG7QIgHbfZ1S3nfMCUkSsjJERt/m+4yXKnXNQXglNB/v6AACg0gN5VItarh
	Ng5Pj9BCTdlonrRJqMA9LE1xR/m0nvAW38srmyHDrJxofu02xGOUVoC18Wcxwb83E3LlJfoanp9
	xcc57+kxxOUm7QR9ZvCWMc/nRMrM0v9tBKXhkU++NpwGNmpeMRoXG5A6hRbNoEpd4BF48tJKhTJ
	4PzYMJwlBy6IpaQM1wA==
X-Google-Smtp-Source: AGHT+IHdNYudNQrKRJYbNO8tKZv7fexJeXFTkUuajSjQrqfC+IP76hd/8HGEo15LPdOK5Ylw/STnrA==
X-Received: by 2002:a17:903:41c2:b0:223:2630:6b82 with SMTP id d9443c01a7336-2264981b460mr7589085ad.10.1742338855286;
        Tue, 18 Mar 2025 16:00:55 -0700 (PDT)
Received: from dev-linux.. (syn-076-088-115-008.res.spectrum.com. [76.88.115.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba6f14sm100739465ad.111.2025.03.18.16.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 16:00:54 -0700 (PDT)
From: Sukrut Bellary <sbellary@baylibre.com>
To: Kevin Hilman <khilman@baylibre.com>,
	Russell King <linux@armlinux.org.uk>,
	Rob Herring <robh@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Sukrut Bellary <sbellary@baylibre.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Roger Quadros <rogerq@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Bajjuri Praneeth <praneeth@ti.com>,
	Raghavendra Vignesh <vigneshr@ti.com>,
	Bin Liu <b-liu@ti.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 1/4] ARM: OMAP2+: Fix l4ls clk domain handling in STANDBY
Date: Tue, 18 Mar 2025 16:00:39 -0700
Message-Id: <20250318230042.3138542-2-sbellary@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318230042.3138542-1-sbellary@baylibre.com>
References: <20250318230042.3138542-1-sbellary@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't put the l4ls clk domain to sleep in case of standby.
Since CM3 PM FW[1](ti-v4.1.y) doesn't wake-up/enable the l4ls clk domain
upon wake-up, CM3 PM FW fails to wake-up the MPU.

[1] https://git.ti.com/cgit/processor-firmware/ti-amx3-cm3-pm-firmware/

Signed-off-by: Sukrut Bellary <sbellary@baylibre.com>
---
 arch/arm/mach-omap2/clockdomain.h           |  1 +
 arch/arm/mach-omap2/clockdomains33xx_data.c |  2 +-
 arch/arm/mach-omap2/cm33xx.c                | 14 +++++++++++++-
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
index c36fb2721261..86a2f9e5d0ef 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -48,6 +48,7 @@
 #define CLKDM_NO_AUTODEPS			(1 << 4)
 #define CLKDM_ACTIVE_WITH_MPU			(1 << 5)
 #define CLKDM_MISSING_IDLE_REPORTING		(1 << 6)
+#define CLKDM_STANDBY_FORCE_WAKEUP		BIT(7)
 
 #define CLKDM_CAN_HWSUP		(CLKDM_CAN_ENABLE_AUTO | CLKDM_CAN_DISABLE_AUTO)
 #define CLKDM_CAN_SWSUP		(CLKDM_CAN_FORCE_SLEEP | CLKDM_CAN_FORCE_WAKEUP)
diff --git a/arch/arm/mach-omap2/clockdomains33xx_data.c b/arch/arm/mach-omap2/clockdomains33xx_data.c
index 87f4e927eb18..c05a3c07d448 100644
--- a/arch/arm/mach-omap2/clockdomains33xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains33xx_data.c
@@ -19,7 +19,7 @@ static struct clockdomain l4ls_am33xx_clkdm = {
 	.pwrdm		= { .name = "per_pwrdm" },
 	.cm_inst	= AM33XX_CM_PER_MOD,
 	.clkdm_offs	= AM33XX_CM_PER_L4LS_CLKSTCTRL_OFFSET,
-	.flags		= CLKDM_CAN_SWSUP,
+	.flags		= CLKDM_CAN_SWSUP | CLKDM_STANDBY_FORCE_WAKEUP,
 };
 
 static struct clockdomain l3s_am33xx_clkdm = {
diff --git a/arch/arm/mach-omap2/cm33xx.c b/arch/arm/mach-omap2/cm33xx.c
index acdf72a541c0..a4dd42abda89 100644
--- a/arch/arm/mach-omap2/cm33xx.c
+++ b/arch/arm/mach-omap2/cm33xx.c
@@ -20,6 +20,9 @@
 #include "cm-regbits-34xx.h"
 #include "cm-regbits-33xx.h"
 #include "prm33xx.h"
+#if IS_ENABLED(CONFIG_SUSPEND)
+#include <linux/suspend.h>
+#endif
 
 /*
  * CLKCTRL_IDLEST_*: possible values for the CM_*_CLKCTRL.IDLEST bitfield:
@@ -328,8 +331,17 @@ static int am33xx_clkdm_clk_disable(struct clockdomain *clkdm)
 {
 	bool hwsup = false;
 
+#if IS_ENABLED(CONFIG_SUSPEND)
+	/*
+	 * In case of standby, Don't put the l4ls clk domain to sleep.
+	 * Since CM3 PM FW doesn't wake-up/enable the l4ls clk domain
+	 * upon wake-up, CM3 PM FW fails to wake-up th MPU.
+	 */
+	if (pm_suspend_target_state == PM_SUSPEND_STANDBY &&
+	    (clkdm->flags & CLKDM_STANDBY_FORCE_WAKEUP))
+		return 0;
+#endif
 	hwsup = am33xx_cm_is_clkdm_in_hwsup(clkdm->cm_inst, clkdm->clkdm_offs);
-
 	if (!hwsup && (clkdm->flags & CLKDM_CAN_FORCE_SLEEP))
 		am33xx_clkdm_sleep(clkdm);
 
-- 
2.34.1


