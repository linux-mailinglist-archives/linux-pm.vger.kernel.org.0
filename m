Return-Path: <linux-pm+bounces-39965-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E12D6CDFF33
	for <lists+linux-pm@lfdr.de>; Sat, 27 Dec 2025 17:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C0C53009F45
	for <lists+linux-pm@lfdr.de>; Sat, 27 Dec 2025 16:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1842459C6;
	Sat, 27 Dec 2025 16:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jm0.eu header.i=@jm0.eu header.b="FDbCjAvm";
	dkim=permerror (0-bit key) header.d=jm0.eu header.i=@jm0.eu header.b="bLz5xEqO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF1E32470E;
	Sat, 27 Dec 2025 16:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766853093; cv=pass; b=u70cwLp63UUTMkImx1xsE4mbLqcSxF8xKuaRsBYkxHm7Gh32H2s+xH+WUcOn4Gj1L7xMq+nPWw7qMMLDASmPb6HGxl73lpYTJ42v23xOJAl2gaqw9+uKzolfXjAuE3OuyC7DQLt5T3OY1Jm1u8fiN6qMxQD9OiyghKPw+hkZFxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766853093; c=relaxed/simple;
	bh=VN/x373hy69itGeNHk2nWJqOctFWWyrBo9tktBSIn0U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kqUxS2MOQsUK9XJCdmHq4pkRrZnMMVwvgwVwbIu0FFbWGyKR2AgBFAQXHPH8TT2Jv0zEq8Ej7bExrUOD//iici7oD1yBhBrwk5Ws7VxSqeBcChsK8EW/liKhJaZm9Akw9GshXcCUOg/vZvaovKCv1ZqgbDvdY+GPQbDKqu+GTPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jm0.eu; spf=none smtp.mailfrom=jm0.eu; dkim=pass (2048-bit key) header.d=jm0.eu header.i=@jm0.eu header.b=FDbCjAvm; dkim=permerror (0-bit key) header.d=jm0.eu header.i=@jm0.eu header.b=bLz5xEqO; arc=pass smtp.client-ip=85.215.255.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jm0.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jm0.eu
ARC-Seal: i=1; a=rsa-sha256; t=1766852905; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=iaa71vAjezJNy/1pjiRbSfjHyn3IdNOUUdn/4cXs5aVq/hHhWR3ladntH/CTGO/3h6
    aiSqhfMhvAF5yFWqLzQaIo3DrFfivD5VBu46PQSazWKgPQxpGS6C1hmZxhQgA2st5kq9
    IIjHzBq71Ui61IiVdOyCLqiDFZ5w3PRy5xX5panKiIZ9WkvStYuzwstHJIQMiqRTG8RX
    5UObJ1+wWQvn7QYIYueRi2UY/Xvv5+jdULrfL8sOgJfRDgpPDpBmhsHpiz/0FnYUGD9c
    RTxXAvx7tp93RDlWasZBnoR35rtc1X7+Bd+Zg1c/MqRCFltA15OXrw5HFsPC64HRVbD4
    b+oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1766852905;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=BuD5YZ4N03UhpFzeELt8Wte/+AalKTr8rt0ghSZkn0s=;
    b=jASsQmOGTK07y99JraOF0l9hgphZXm9vb8J4Yq4xkOD1Rl3OWTBv23ai3/gyZE8zko
    G0BlRj21ylJw58k70sacQLoqqVf1GmDoht8mVXX3M50awaOIkVQLry4nlrMMj5Zd0to5
    HqyUp9how0o6l3j/QOt1/Ig8HrKc3umY7BW/cfz5RclqmqYDRIQUx+TEBpibuvxklNbP
    v47wtMbhHPQCoLQUDACrJ0VbBj6BAarlZ3pt+d2TDedc4QgHhqsIj7EjodtVBr28S/Xi
    QoA5XbMOZzWh+0EqTSaNxKy/1eXUMVHmwBTOxQtnkC2DmA+DzJ3vXNAdPmtwIhqssmfX
    1fAA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1766852905;
    s=strato-dkim-0002; d=jm0.eu;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=BuD5YZ4N03UhpFzeELt8Wte/+AalKTr8rt0ghSZkn0s=;
    b=FDbCjAvmvqCbwcOhWfjRcxcHxzdtFVBV/b2uhyVRdM58xsCYNXs+tEV6ySWZ7q/Qr7
    frHXHnre7El7un9+ytVEPGo58XSefaJmU/PSwj+mMKkt+eRksXTFDL5/yjNFgeW6b1ZB
    iqMAohVtYDa2dqJOm+tvkUB+Bggi/VcEA/BO83UPVEILcoyOS4q4mWf8SePK9Br65LS7
    MwQSJGfHyIX7FFAslh27csONq8kei/tr89AxLlESCBTnLVVUpNcWUOJeoLpfLxAuWatN
    W8IJP0fxeJQkxj1KlSkGNGbe6f5XBArjhRYeu1YRXvd9rl0SudqZ9aoRotNQz9C3M3RT
    iGAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1766852905;
    s=strato-dkim-0003; d=jm0.eu;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=BuD5YZ4N03UhpFzeELt8Wte/+AalKTr8rt0ghSZkn0s=;
    b=bLz5xEqOh+2dF9YJyWADchR8kRgH+MArwclgvjgGugEEr9R6IXs67Onj3lPpxRNCWs
    TpsBCFXPixcbxJIqlqCQ==
X-RZG-AUTH: ":JmMXYEHmdv4HaV2cbPh7iS0wbr/uKIfGM0EPTeoCaRth8YQvpoIkZXd2bnfIrOV7Mbk="
Received: from localhost.localdomain
    by smtp.strato.de (RZmta 54.1.0 DYNA|AUTH)
    with ESMTPSA id z0d4ec1BRGSPtuK
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 27 Dec 2025 17:28:25 +0100 (CET)
From: Josua Mayer <josua.mayer@jm0.eu>
Date: Sat, 27 Dec 2025 17:28:15 +0100
Subject: [PATCH 3/3] ARM: dts: imx: imx50-kobo-aura: add description for
 battery
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-kobo-aura-battery-v1-3-328a90ef5122@jm0.eu>
References: <20251227-kobo-aura-battery-v1-0-328a90ef5122@jm0.eu>
In-Reply-To: <20251227-kobo-aura-battery-v1-0-328a90ef5122@jm0.eu>
To: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Andreas Kemnade <andreas@kemnade.info>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Josua Mayer <josua.mayer@jm0.eu>
X-Mailer: b4 0.14.3

Kobo Aura has a rechargable battery that is monitored by the embedded
controller.

Battery markings: PR-285083 3.7V Typ. 1500mAh; 575327416288 5.55Wh.

Add description for this battery and link it for monitoring by the
embedded controller.

Signed-off-by: Josua Mayer <josua.mayer@jm0.eu>
---
 arch/arm/boot/dts/nxp/imx/imx50-kobo-aura.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx50-kobo-aura.dts b/arch/arm/boot/dts/nxp/imx/imx50-kobo-aura.dts
index b1a6a9c58ac33..dc8d9fd45cd23 100644
--- a/arch/arm/boot/dts/nxp/imx/imx50-kobo-aura.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx50-kobo-aura.dts
@@ -16,6 +16,14 @@ chosen {
 		stdout-path = "serial1:115200n8";
 	};
 
+	battery: battery {
+		compatible = "simple-battery";
+		voltage-min-design-microvolt = <3400000>;
+		voltage-max-design-microvolt = <4100000>;
+		energy-full-design-microwatt-hours = <5550000>;
+		charge-full-design-microamp-hours = <1500000>;
+	};
+
 	memory@70000000 {
 		device_type = "memory";
 		reg = <0x70000000 0x10000000>;
@@ -151,6 +159,7 @@ embedded-controller@43 {
 		system-power-controller;
 		interrupts-extended = <&gpio4 11 IRQ_TYPE_EDGE_FALLING>;
 		#pwm-cells = <2>;
+		monitored-battery = <&battery>;
 	};
 };
 

-- 
2.51.0


