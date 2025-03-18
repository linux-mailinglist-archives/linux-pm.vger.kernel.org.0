Return-Path: <linux-pm+bounces-24268-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 576AFA68050
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 00:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD5E41784E8
	for <lists+linux-pm@lfdr.de>; Tue, 18 Mar 2025 23:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9FF21423B;
	Tue, 18 Mar 2025 23:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UqMxC/Ws"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9994D21420E
	for <linux-pm@vger.kernel.org>; Tue, 18 Mar 2025 23:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742338862; cv=none; b=PwHCXb/P7oMu4mGP82TkxhAk4IwNYdq8B/v3RVOIAJY2jmzXoVb6+D9r0JJdpYQlXiojWYj+gkGhe2hY3MuIuRvozQz3fZgQu2cEgynEJ2l+/6PQLsdanpGlAhLVMtLh0BRW7VWWQStXAwxg4+CSCc+DYVlxv3q8P5sveZzkcrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742338862; c=relaxed/simple;
	bh=Dlk5H4z+VhU5Q7nLlJ6DokEx98BkmTjtJY03Wn8wrdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lcs8uK8WxK8rk5JvfBEYsm4aubV3F7RezVa+TXe3zNxFZDQXUJfjLTsLUmCm4s1SDWnJEHxNifamYKzsNl5CQw6UdDnSI7O1mbCEhPQUUykwv2y9HElXzIHk0uLA+5mHE4CU2of3NHpThJ1D+X5bWX39SmnXIiaKl++nW4pWuM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UqMxC/Ws; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2254e0b4b79so17800245ad.2
        for <linux-pm@vger.kernel.org>; Tue, 18 Mar 2025 16:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742338860; x=1742943660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmCr9y/zny2ubL+q+EvXUgJdImEUCfchERMe1C0cWbE=;
        b=UqMxC/Ws/KRLfEqF7NZkXoWc9+4bWSLVKult+CEP3cZQKHDNcxgcGaMLZyAsprJv/w
         O/Vwirgo8gX8ZZRjDWEjEhmgB95VCSMAySKO3BG8vZvJtBDQp5mL8JwNbx3jJOmZlO+a
         FvOfoEprIdD7T7++LJVzBXQ7yh8iMWlIfzt3cIczoUXx38zovzMIHouaWMtvvmK3d4aJ
         XuxJHLP8OgcoF9gCq4giyW4Gi7l30uK2d6RcHxqLAbj1HcyA10BCGqA/+vJuqcPRSuLy
         J95mQP3CtDh1H7lk+tZrGuVpF3Pw3EAs1/lvGa3w2BOy51HzRzYfBayEUVnpNKtth5Pu
         VejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742338860; x=1742943660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fmCr9y/zny2ubL+q+EvXUgJdImEUCfchERMe1C0cWbE=;
        b=e9fWMF6b9ClLmOtIC4jz/r+fx5YUpqhipWZGV30Pv54wf7VPY0xFBl43GEluAyouN2
         n9uXYkgHvTmY3WcTpIdzgG7jtORMDzS9ZgSOK5jkEAkx7AdExbFgQXoq27f4eM5WKnaB
         n/ZtrY2LbfOYUPx0IqA459iRfxNlALSivjF6YFcRmvRrhFkOUcQ7+/TMCJDlw897rbua
         TWHozGcKrL1crjwm2S9n5YEjQ4nPoqxZw/clrL0hE6V80RHz6nO2xdngrR9BmyhtsPpy
         fCNlTK1nIJ2Q4ipFgfFF7n+CpbyJCDhygNAyb7CdRCeayl7RI2uLAEBgyMloEhVPPzdo
         10Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUTRZvo3IJ52c+cuJT2XVqfs4datSGWlZrfl2aVZBfIpFml+qO1eVCE/S96gIQfkvChCVTS35kiaA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWCclXaqc5Fo2CLVjOjD9hPmEYvPykq7yTlV0KFNm2YCBzZ3at
	9s/L7D0+SVF9rXLEfFmF+UpPl4edY8B0S2uOP0cuuNPeyTb79hQrei/+G4f42Pw=
X-Gm-Gg: ASbGncuaGhnRPsSeoW6GDwD7QGjecGtV0CACV1W5zgwcm3YUQjAllaAI94PUCvvFc2H
	K420S+0YO8whqg+KF3HRpDPOQo3v3P7SNf7wO63Tg0A67Jc4XeTb9isF4bVYVbFS4GLnj0w4PCg
	P66DQbvMlyIispVL+FIk0+kXEShPO5IyIrfjzHA1PqGY2jlHNMwYk0b4yxQFwJyivW0YE2dKeQL
	yluLeRqIYPbZw0nWCUehY/UhautQEtrbqvpCEMiGNq+QINpPyb5yZyfJqky3z/+upc7mQk0V4Pk
	OX/pRfoby0kH+zjG+u1pRHS45KuDl13l7eSUeGfh6vr61B5waJcyv3M4ilS6a9PnCh4j2dVhFbX
	dlPf32byRKdTqW6X7MA==
X-Google-Smtp-Source: AGHT+IHoN+lflWvy8IsxGNjvVcOT3P03WGhfooUosnPSGHOlgyWeNcf/Uk7lY1kmD1/bWRv0OH1Aeg==
X-Received: by 2002:a17:902:f647:b0:224:f12:3734 with SMTP id d9443c01a7336-22649a43b2amr6644945ad.30.1742338860084;
        Tue, 18 Mar 2025 16:01:00 -0700 (PDT)
Received: from dev-linux.. (syn-076-088-115-008.res.spectrum.com. [76.88.115.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba6f14sm100739465ad.111.2025.03.18.16.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 16:00:59 -0700 (PDT)
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
Subject: [PATCH 3/4] ARM: dts: am335x: Set wakeup-source for UART0
Date: Tue, 18 Mar 2025 16:00:41 -0700
Message-Id: <20250318230042.3138542-4-sbellary@baylibre.com>
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

On am335x evm[1], UART0(UART1-HW) has a wakeup capability.
Set wakeup-source, which will be used in the omap serial driver to enable
the device wakeup capability.

[1] https://www.ti.com/tool/TMDXEVM3358
[2] AM335x TRM - https://www.ti.com/lit/ug/spruh73q/spruh73q.pdf

Signed-off-by: Sukrut Bellary <sbellary@baylibre.com>
---
 arch/arm/boot/dts/ti/omap/am335x-evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/am335x-evm.dts b/arch/arm/boot/dts/ti/omap/am335x-evm.dts
index 61bf8bcd4c4e..20222f82f21b 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-evm.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-evm.dts
@@ -388,7 +388,7 @@ AM33XX_PADCONF(AM335X_PIN_UART0_RTSN, PIN_INPUT_PULLDOWN, MUX_MODE2) /* uart0_rt
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins>;
-
+	wakeup-source;
 	status = "okay";
 };
 
-- 
2.34.1


