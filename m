Return-Path: <linux-pm+bounces-27176-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1536FAB7DC1
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 08:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFB684A5892
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 06:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCB5296FB8;
	Thu, 15 May 2025 06:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sViS8clH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC9928ECFD;
	Thu, 15 May 2025 06:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747290134; cv=none; b=K4/X0qfCIPIk/uhT2JlT/PE22OK+yUlSSJ9lLJ10kw0w39mGDiE01A/slJNb3CRKukVlh/ZFyJHAMxoEWLMls80gXpYEJ1/8uvQ7rumDry08F3vjY/ee2Zhs/wGFlY5tcCWBfZtz973olJSRPATLfy2vqBTfSsG5Go4aAhXb+5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747290134; c=relaxed/simple;
	bh=YqWGrU8cX3R/33Hu+No/4eVZ8F/0zOZxaEmFKaDt9Rs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oGTrYkabpyFpgkpN+H7j8OUhiDF52wRnGket06MpMb43MZoWhGFXV/MwKfzdpOGnIWYSDCHz3A4b3ZMSCCQ8qgw+wWbvYepEArqZk+7F5D1QZhimhkuO+dmhE0B3GLtfgtTULiWQVui8+FQvA/bRAVGU3u0BWCzv64PlOZI2beM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sViS8clH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33C6BC4CEED;
	Thu, 15 May 2025 06:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747290134;
	bh=YqWGrU8cX3R/33Hu+No/4eVZ8F/0zOZxaEmFKaDt9Rs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sViS8clHDRk3GeItaERopQztxC6OvynmqGK+6mJz4p9pNWXxiufe18S8/B018LjtQ
	 wmqh6UhvpaRDEzxPCPBjwOkG5tCE8GSC7prQJlqLrqT4+vWD2Vg9IMosXLjd9ulFsm
	 JKudBKM49s+y33aSIrfEM+AwgkgtrC2LFqBZbMjBL6mAj2l+ckH1Kmfc6H2sMMMv4T
	 o/5kKgnJDfpeotZ7UOK9omAPr5yEj0tb6U78jxz06k8buN4YS6n9HR1W3JtfULnAnG
	 X0tGnVkKwtQkbWHDgUhFXWx4C+s1wgZUeMCjKRbmx1oJgqBFWgjf3IuZT639EgnRni
	 5H15WOOI/cTHA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2846FC3ABC3;
	Thu, 15 May 2025 06:22:14 +0000 (UTC)
From: Sven Peter via B4 Relay <devnull+sven.svenpeter.dev@kernel.org>
Date: Thu, 15 May 2025 06:21:13 +0000
Subject: [PATCH v6 01/10] dt-bindings: gpio: Add Apple Mac SMC GPIO block
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250515-smc-6-15-v6-1-c47b1ef4b0ae@svenpeter.dev>
References: <20250515-smc-6-15-v6-0-c47b1ef4b0ae@svenpeter.dev>
In-Reply-To: <20250515-smc-6-15-v6-0-c47b1ef4b0ae@svenpeter.dev>
To: Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>, 
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2267; i=sven@svenpeter.dev;
 h=from:subject:message-id;
 bh=xmmWJKUzKUzVswg1Q+PRKaHVbvTBfUPSGjlwfAn6Cio=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ4ZqB4f925YdCzULsze2FzzP2Xnq/dTDmd4nHljOSlrPr
 HmtvNqio5SFQYyDQVZMkWX7fnvTJw/fCC7ddOk9zBxWJpAhDFycAjCRQBGG/97871bP7zzsbJn/
 o2PHK5386+G3N29+8NTF7TiXm+s/xV0M/xRsox4IGPburbzxKz1w0VOLA+xVuVK7rEsEg8+X3zd
 s5wIA
X-Developer-Key: i=sven@svenpeter.dev; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@svenpeter.dev/default with
 auth_id=167
X-Original-From: Sven Peter <sven@svenpeter.dev>
Reply-To: sven@svenpeter.dev

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>

Add the DT binding for the Apple Mac System Management Controller GPIOs.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 .../devicetree/bindings/gpio/apple,smc-gpio.yaml   | 29 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/apple,smc-gpio.yaml b/Documentation/devicetree/bindings/gpio/apple,smc-gpio.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..621faf506be8ff80c082cf7621566f83fdd99c59
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
+  - Sven Peter <sven@svenpeter.dev>
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
index 96b82704950184bd71623ff41fc4df31e4c7fe87..b53f3929b06006f9f38f5cda048516891c18c7ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2267,6 +2267,7 @@ F:	Documentation/devicetree/bindings/arm/apple/*
 F:	Documentation/devicetree/bindings/clock/apple,nco.yaml
 F:	Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
 F:	Documentation/devicetree/bindings/dma/apple,admac.yaml
+F:	Documentation/devicetree/bindings/gpio/apple,smc-gpio.yaml
 F:	Documentation/devicetree/bindings/i2c/apple,i2c.yaml
 F:	Documentation/devicetree/bindings/input/touchscreen/apple,z2-multitouch.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/apple,*

-- 
2.34.1



