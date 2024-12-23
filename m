Return-Path: <linux-pm+bounces-19689-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D019FAF1E
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 15:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35DBF18856D4
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 14:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E351B4135;
	Mon, 23 Dec 2024 14:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4RyGF54"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AD41B3934;
	Mon, 23 Dec 2024 14:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734962403; cv=none; b=NPgutRha8lBhR7uGFIfP/SNn6lCl1FfRPrtqWtceQ7en1xBL2hPpHva7S/VcpxgRKcqSVBIJdrbnjzVvVdd8ynajbj4ToSMIK4eWo7J1I1okgTk0Gtr/GcPdGXc0lnLc7JuHIFr6VEYOb7JAhhErdT+f0tkJlpbi4jo7Z5FScyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734962403; c=relaxed/simple;
	bh=W3R0sAEsh89KI9k2TtMER4sOCc8bejuu1Gu7C+v3ml0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ayuK6Wi7nkDj9jUumS3pR1xDyF4DfNLfZea0muyEB8dIg8pIB55WWnMxu82iaBHGUCiwNEIjdcOC6eR3dGYQLmHla49LQOCBppvaqw8DNJvARat+OfYK+uOT80YN5mJzPJAaiNmGnzp23315Z4XqTaculxJ0W1tRPN/JdUjjZfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4RyGF54; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d647d5df90so6923657a12.2;
        Mon, 23 Dec 2024 06:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734962400; x=1735567200; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LyNrH/v1nn6Cpsrp8y8ejskaGapYhbwc7aBDhXiWAeU=;
        b=C4RyGF54ue8KfzxBGyD75NFi1YXF5ZN7J5UyhSl2eyTQaq++bpdH+MUgiEYXjKxeW9
         YLbs5XPhA7vkFDY1opOiximLXYzy8o/8PfLuTFDsyzGypEzRJhrPIA5Z8Qximefrjqxa
         AWahmO9vyRjf+60YqGnfFRWVF6lUqjnag7pYBf/mHm7BuGFsw9DMi/73DkH4TlBnWkUJ
         fJjCutPByYA5ELpFVzXomc3RHu4k1TvqgapZjhKUliSOcucpvw+Dhl5XBzmzqePuHaeC
         PAE0oYISF8NTRf0V0lShJ9wsR8hziVOsa8ynJDK+p0w6Ix2H4vqkZouJ2XiugWIVn8P8
         cHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734962400; x=1735567200;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LyNrH/v1nn6Cpsrp8y8ejskaGapYhbwc7aBDhXiWAeU=;
        b=RmcOYurzDFRwzGQ9TVMFX+0NrPQRqOAMH+22ZVIPTx6aMW0AwUYs8ocbKGu1XbBRhw
         n1nyKe7JsAmx6N80aacfM4eu/sBfyMprxBitDxNL5ms+EOTl8FkHTFBAcAo4dIE7pxZv
         hyw7kLWDsaxdSXzJ0QpSJcYLkj3ZuStmIIVJCw7BNE0bHkuksfkZpNzWbCOH926xMVHb
         YVPstgcb1WAgobp4i7fEQExODd8wgwFG+xSFZugglP4F+0DDkvlaujc5KzYUeuoG7Jk3
         iVF+1mBQANr+mQBpne2bg4XHldCg+pINXjGJitgp/YC/q73PzizsrqKi3VKDiJnLeeyD
         hAww==
X-Forwarded-Encrypted: i=1; AJvYcCUD42q39DYzyfFEC207ttzmj1O+EeWveAptK5q52nm1hf4oj0ekwiBSVTjuKwK3dXIStrq1MSvFGQmsIg==@vger.kernel.org, AJvYcCV+DiNLIO0IXXT9XSn5Xf4jdHADEDhSaYTwDNXynrNGMCJg4vYcGT6f/Q2+lMTYcroS5MOCEeBpLLUpwh8=@vger.kernel.org, AJvYcCVB9gLZa1ELlbMKODZtLglmuNenzvMTwDbr1uzWLr7j5J6POkffZkbikBovKnm9DkB+Zf1cM2ID9o5M@vger.kernel.org, AJvYcCW4hO+rLC3bZ85dGU3T9XJCunBbFrx/8/Fz5zlz1WevmgmyGYPubKHNNldBROy3Y49NUBmukNfHaFwefMbo@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6BQStm6VJiFLe2g8+BSo11BoWzMZ58r4NHrU/RxMHd2zs5zqx
	hfy67tZI5aHl0cxjhsMjkRiq5aQawzv0+DUM5K6OO1NoxPLgpai78kZCWw==
X-Gm-Gg: ASbGncuI31DVUnm5kZb2BeBHCuQZpY4emWAiGq9Bpd8Dq7Zrx/FdAWWmAbSi13TTKlJ
	vqjySs7zI3wcLd99pLAYN2Dk8dKHNwXVxHsmoN0ZytZy5UkQpO47DVmfsEuHffqLitEPmaYLVDV
	atW7OCyWMHdYyLM+QVIIE7QR9fLmLKtNn0U2IzcljGGDyZrOz5admCI1MuDd9Xvz+ngZiLKSjHe
	VbsBVwQy1OGlsu5eCn7u9yTWCOo18ECfpDQSEubjOZMDhIr7jICh2wtgeVkPwMtj7QryM1m83Ow
	g7rkHBjGxfBqZlkUVpzrGQk99Q==
X-Google-Smtp-Source: AGHT+IF3EI3aiS8peDHQvCudeSD7IYB3OD6m/HHX6VoBtBuSM4Fb26SypNlJLZ8cqf1R2z5wkXVtaA==
X-Received: by 2002:a05:6402:51cf:b0:5d0:d18f:cc64 with SMTP id 4fb4d7f45d1cf-5d81dd64086mr11269286a12.4.1734962399439;
        Mon, 23 Dec 2024 05:59:59 -0800 (PST)
Received: from [127.0.1.1] (nat6-minsk-pool-46-53-210-232.telecom.by. [46.53.210.232])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d80701ca31sm4911485a12.88.2024.12.23.05.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 05:59:58 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Mon, 23 Dec 2024 16:59:40 +0300
Subject: [PATCH v13 03/10] dt-bindings: power: supply: add maxim,max77705
 charger
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241223-starqltechn_integration_upstream-v13-3-fbc610c70832@gmail.com>
References: <20241223-starqltechn_integration_upstream-v13-0-fbc610c70832@gmail.com>
In-Reply-To: <20241223-starqltechn_integration_upstream-v13-0-fbc610c70832@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734962389; l=1700;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=W3R0sAEsh89KI9k2TtMER4sOCc8bejuu1Gu7C+v3ml0=;
 b=ZChh0VTDwOaZjm1PVOpEbL/9xASm6oG1B+pqr51srt6I2107IUk1rGinPBLHPGyO21F8obdWo
 y57PadPDp1jDZyNK+rYwECheWQz3RTddXYdoUbZRz6EsDS0Sr++MtgG
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Add maxim,max77705 charger binding.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 Documentation/devicetree/bindings/power/supply/maxim,max77705.yaml | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max77705.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max77705.yaml
new file mode 100644
index 000000000000..e42dbd48d838
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max77705.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/maxim,max77705.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX777705 charger
+
+maintainers:
+  - Dzmitry Sankouski <dsankouski@gmail.com>
+
+description: |
+  This is a device tree bindings for charger found in Maxim MAX77705 chip.
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    const: maxim,max77705-charger
+
+  interrupts:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+required:
+  - reg
+  - compatible
+  - monitored-battery
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+        charger@69 {
+            compatible = "maxim,max77705-charger";
+            reg = <0x69>;
+            monitored-battery = <&battery>;
+            interrupt-parent = <&pm8998_gpios>;
+            interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+        };
+    };

-- 
2.39.5


