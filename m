Return-Path: <linux-pm+bounces-12743-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F31595BA86
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 17:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3F95B27EAE
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 15:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E99A1D1F4A;
	Thu, 22 Aug 2024 15:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="UCi6OkzB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB8C1D0DED
	for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 15:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724340531; cv=none; b=PbQ6SyjlYdS6JaDfw06Q51WiMeErCQcENvsy00t8JPUpIq0g0sz5rUm369Qs0JDlgE0k1OgOAALlkrNmab2Lk0iApnrUOiIP6ilA2jFjJwW6e2WDTWTbd3gO4dEzwC+FlnWw/WQ6C9B446h4kTwQxnNo1QaE9UzPiwzjEkOlnZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724340531; c=relaxed/simple;
	bh=PusSluqZ4VefZMGZNtGaHZ4rDX2ovrpP75F+MreF79w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WKMxQZqAGAxJ4S5VBYq2dyYERl7iOteVmwdQwWVVqVM/AUyXgs5pvuMjOGbWZVuJdAbiKsjIHlRXTvUkM73y5X+88oS4Eo6h8b8cZn4H0T+wZ/Qj5vsb7M+Qh3mEbNvy3h3m8CDb92iCT3wRg5SHO7XcbHLVkcfkMoBYdyZRZa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=UCi6OkzB; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4281ca54fd3so7500955e9.2
        for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 08:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1724340528; x=1724945328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dHeWW2RAWv56keT/WvGpAcv9ZdqYWF6HJpLE3tjHw58=;
        b=UCi6OkzBgr/KdjK42SoQ6Jp+8eXLRyU+2K91t5be1po6fpawA8PRWcYBIXTwVcIAUP
         kEvOPP1VUirgK+zwLEAXdYUPj/IGw3mWTBCdoRp6+ggsb97EXn1u2cef/BkIGnIJTGeI
         F5FSL0rzZq2ZavUWx36xWfHImCSSO3hHdNWcRRMS3XrnpyoiAPJtk98pFRH47hNvf/P0
         US+C7vheu0VecSdb7m/ZF0VyEMmCWqp9W8oe5JMxI5WnRxziamM9sIKk9BgRAlQb1oGY
         7ZLAWsUjqAZbZmSqpO5OYHgUrbS5CpEkitAg5wEDJf50tXeay46L3dTR/Q/d1FWF1J5z
         YINg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724340528; x=1724945328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dHeWW2RAWv56keT/WvGpAcv9ZdqYWF6HJpLE3tjHw58=;
        b=alQkGGVYvP/FdArHtghctvT6oBUSLcpdV4WyP0Ntb3gXfwWtBZydh4/gAoXDqnMnM0
         v2Js6v84Gu1FKvN49j6OtZAiO2DeekLsWFtRsWBSOFFXDmhKgL+H9PtB+Dl+NOIkZPmr
         glOIXkAZ3pcV6jhMy0AGztFl8ZzRJI5TkCyacYjaGJ+Uuwq9hz5diMRvFzusmXkl6osR
         sHLgcrH0ozvSPI+5rjJCIFgmQieN/Un5Ywa+00D8tdQz2zVJ5+0NNXJcWE6DMomQ5guq
         KTcUOziQv9E+B4UHsKhhzNobX3VBxGaW+K3q2yO4k5+YlAaWPUoRCj2f6gMlBA6iKWVp
         NSxA==
X-Forwarded-Encrypted: i=1; AJvYcCXSHVkKHjtwsSLc2Uwlr16P7fxMOP6Dfq3mqhZHjT3325iGiWSAl/BUUOVz2tgUoe5guUntbv9dOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGcW+qhDr20StQrhhpNYt0XQ9lptCO2VnNOw2J+we1EPz0Gyhc
	k8a1XXBllr6skn8GDlt02Cq2ZWvkHLViBeRMnt+R+zlBwE+jD4MqDoJUNeeoBU0=
X-Google-Smtp-Source: AGHT+IEpM56P+rOfWzF8q9z39ghmNLCQnzP/RLGHl+du2H4z+ac9zrTbNQqtdYtd7xDVKiZkepmRnQ==
X-Received: by 2002:a05:6000:110b:b0:371:8e50:2d08 with SMTP id ffacd0b85a97d-372fd720340mr3982596f8f.38.1724340527530;
        Thu, 22 Aug 2024 08:28:47 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f484dc5sm134189166b.171.2024.08.22.08.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 08:28:46 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	gregkh@linuxfoundation.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	yoshihiro.shimoda.uh@renesas.com,
	biju.das.jz@bp.renesas.com,
	ulf.hansson@linaro.org
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 15/16] arm64: dts: renesas: rzg3s-smarc: Enable USB support
Date: Thu, 22 Aug 2024 18:28:00 +0300
Message-Id: <20240822152801.602318-16-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Enable USB support (host, device, USB PHYs and sysc).

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi | 61 ++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
index deb2ad37bb2e..fd9355936803 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
@@ -66,6 +66,29 @@ vccq_sdhi1: regulator-vccq-sdhi1 {
 	};
 };
 
+&ehci0 {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&hsusb {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&ohci0 {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&ohci1 {
+	status = "okay";
+};
+
 &pinctrl {
 	key-1-gpio-hog {
 		gpio-hog;
@@ -124,6 +147,27 @@ cd {
 			pinmux = <RZG2L_PORT_PINMUX(0, 2, 1)>; /* SD1_CD */
 		};
 	};
+
+	usb0_pins: usb0 {
+		peri {
+			pinmux = <RZG2L_PORT_PINMUX(5, 0, 1)>, /* VBUS */
+				 <RZG2L_PORT_PINMUX(5, 2, 1)>; /* OVC */
+		};
+
+		otg {
+			pinmux = <RZG2L_PORT_PINMUX(5, 3, 1)>; /* OTG_ID */
+			bias-pull-up;
+		};
+	};
+
+	usb1_pins: usb1 {
+		pinmux = <RZG2L_PORT_PINMUX(5, 4, 5)>, /* OVC */
+			 <RZG2L_PORT_PINMUX(6, 0, 1)>; /* VBUS */
+	};
+};
+
+&phyrst {
+	status = "okay";
 };
 
 &scif0 {
@@ -144,3 +188,20 @@ &sdhi1 {
 	max-frequency = <125000000>;
 	status = "okay";
 };
+
+&sysc {
+	status = "okay";
+};
+
+&usb2_phy0 {
+	pinctrl-0 = <&usb0_pins>;
+	pinctrl-names = "default";
+	vbus-supply = <&usb0_vbus_otg>;
+	status = "okay";
+};
+
+&usb2_phy1 {
+	pinctrl-0 = <&usb1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
-- 
2.39.2


