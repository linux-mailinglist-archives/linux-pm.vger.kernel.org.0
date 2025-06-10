Return-Path: <linux-pm+bounces-28396-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A00D2AD3E6D
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 18:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D51593A4149
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 16:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2D8241103;
	Tue, 10 Jun 2025 16:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRNaShsw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFE123C501;
	Tue, 10 Jun 2025 16:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749571840; cv=none; b=AlnyvHUtGb4cC8m0ZmnY6btgO5TMnSrU9Q1TxjOPdz3w5DyS9qU/nbMAzCF9etGAPXcWz8gQnOiM4nARZ0A2PMdnFm7X2prRk0rWGkeACOR0iRjfBDOAzIc2/g1WuCsxqFncNYe/hr5QTg+egIOubn5/L4Duiz/fR+hnyaTjsxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749571840; c=relaxed/simple;
	bh=KS5KZh83WhFoHDXQ2W/EWKz/ArbrhyBg7ZBRgDlrWe0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TCaZFQG/39JilCkfBZRmvvGIlz862AsnyGiEAaL99fLelPEFEtPhaVzXnxEOVjKHLbJLGR6D+89oS7QVjKEq+PB+6hh23HBSUcvwmWZN0k2o6euXX49f1TuPIl7W78OLEXTbKuVZnTS3PecwZsUEanxEOERRnzdC5qj2kdjorbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pRNaShsw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58DAEC4CEF1;
	Tue, 10 Jun 2025 16:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749571839;
	bh=KS5KZh83WhFoHDXQ2W/EWKz/ArbrhyBg7ZBRgDlrWe0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pRNaShsw9P/X545nF4QHLzjKgNg+/bfrWYi9K41GQwFLdXCk68IqRKuikjRKzqeB+
	 UHKYuSlHn9H8QN2vwHQKk5JISMQpGQj/X93MxMJZ1GTmoyMERNt4zPvlfiEOHKM4jD
	 oXOTcF8aDb9QoGix11vYnWyxDu6TA1vsXpF1TutFc7xQyj+uWSMmFI91BaFEB7HhNJ
	 P/C45cJkhGq4nVLSA43bJqRzB3OwE7UMoCMtMR78oBM5YqRNV8Pa+rW1UUD12T8C8f
	 LAwwCziocHCt5d/EyafqSOYJROSnU1MrfGKhri7FBaIk8ebPurP7df7OPhttFhBF53
	 JQzDjLiZmoZqw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AD6C71130;
	Tue, 10 Jun 2025 16:10:39 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Tue, 10 Jun 2025 15:29:42 +0000
Subject: [PATCH v7 01/10] dt-bindings: gpio: Add Apple Mac SMC GPIO block
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-smc-6-15-v7-1-556cafd771d3@kernel.org>
References: <20250610-smc-6-15-v7-0-556cafd771d3@kernel.org>
In-Reply-To: <20250610-smc-6-15-v7-0-556cafd771d3@kernel.org>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Hector Martin <marcan@marcan.st>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
 Lee Jones <lee@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2261; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=Dle4XqGGzX04NP6gmHjHUQRP+Y2skcv80CBrmz9twWY=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ4aHf2FxrPtsXTfRtF9zLz97Kjp3MbOF5JIFWtfZo/0r1
 L9IdUV3lLIwiHEwyIopsmzfb2/65OEbwaWbLr2HmcPKBDKEgYtTACaSMI2R4VW24cJNwnt/hBxU
 aeIp8jb7vXZzVKTTV4Y61ymzzMU+eDAytFS+z+e/J7JwtaxUi5STrOVchvxP+/K6jthZHfy0rlW
 TEQA=
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>

Add the DT binding for the Apple Mac System Management Controller GPIOs.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Sven Peter <sven@kernel.org>
---
 .../devicetree/bindings/gpio/apple,smc-gpio.yaml   | 29 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/apple,smc-gpio.yaml b/Documentation/devicetree/bindings/gpio/apple,smc-gpio.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..42b1bc0a10c97a5586c435413b3c3ef1bb9fc797
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/apple,smc-gpio.yaml
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/apple,smc-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple Mac System Management Controller GPIO
+
+maintainers:
+  - Sven Peter <sven@kernel.org>
+
+description:
+  Apple Mac System Management Controller GPIO block.
+
+properties:
+  compatible:
+    const: apple,smc-gpio
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    const: 2
+
+required:
+  - compatible
+  - gpio-controller
+  - '#gpio-cells'
+
+additionalProperties: false
diff --git a/MAINTAINERS b/MAINTAINERS
index a92290fffa163f9fe8fe3f04bf66426f9a894409..68097b1a44251b076bfd55cc07cffa5d0e3e83c5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2331,6 +2331,7 @@ F:	Documentation/devicetree/bindings/arm/apple/*
 F:	Documentation/devicetree/bindings/clock/apple,nco.yaml
 F:	Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
 F:	Documentation/devicetree/bindings/dma/apple,admac.yaml
+F:	Documentation/devicetree/bindings/gpio/apple,smc-gpio.yaml
 F:	Documentation/devicetree/bindings/i2c/apple,i2c.yaml
 F:	Documentation/devicetree/bindings/input/touchscreen/apple,z2-multitouch.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/apple,*

-- 
2.34.1



