Return-Path: <linux-pm+bounces-10322-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 764F7923910
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 11:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9E27B2480B
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 09:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD725152166;
	Tue,  2 Jul 2024 09:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNPFnrZT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271B4374C6;
	Tue,  2 Jul 2024 09:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719911000; cv=none; b=NxvLV1N4l+buVRmh5k/SkvYIoAKmRVp9ki5j8CwNzdfi+4ZF2K+C0Maq4OnmcBEzIvTw/VtN4Ximqf/fOlVOHOVy5kVLSias70bYb9dgLbBv+28kayhPEuHNIUIZn1a4ql5CxdJuYD7roGeE+OVz7v/fVE/FXETJtNP3Hv6EnEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719911000; c=relaxed/simple;
	bh=oWQXiJwISQuh+zA4iHBxpfKXSpVFiBBbywDkIKpyQgg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FYdZHQ8scWhDBg7ADTj1wFJADcMggasLTl3hN+ufY6rMYRoq/Q3dRNQMku5Og2DAbpKRaABiS36dJkv2BO5Jt8qXvQ4PsoGxhsGFA4iUCIQbmuUad1sjKZMfq66zDvpIjXmRFsGE2E6O13it7Zbjq1mBg6iP2cZYXsKhuK8zZnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNPFnrZT; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52e8037f8a5so3655185e87.1;
        Tue, 02 Jul 2024 02:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719910997; x=1720515797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEWcRMVUd56LpYqAzoehcVPieaArh1+8ciF5XnXVvtM=;
        b=fNPFnrZT9dUi8MFIxSAaI2imZRrwacB0Z8XPh5AeKj1/YlOUqv7VHyOTg7QFuADOWZ
         ibreH9R72z85VUxzT04fsmjQjQM41+5AIFlqkZBac/1aitFsBqQ2cOJGULWohId2slam
         NriBXLlejADH8Bq9GnHa+G+l6qNZjbVNXY6EdMu86f4oCQMeI3Jpjz3sl0uDNZxueb43
         AcRMIwyh9CvZ1nPNxAn31u1gTZjmGz18zgO+2WU3EEA4LW0Z7z82M+fZcb2W3JB77b/H
         7H2UDLLuy+Yj1F2rRJmbWFgbMv8Iu74jEGtXYF1XY1FgwQjSYRsLDzRGuUzD11lE1DVT
         myNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719910997; x=1720515797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CEWcRMVUd56LpYqAzoehcVPieaArh1+8ciF5XnXVvtM=;
        b=ZyNpjCnPaZhok8YicVgxp7oJZQR77Kst86LSKI+k4sCQaFZ/AThIgkZVuSIJnJUF45
         4ebBREFTvtD0fHYeTLdEV+KYUBcCKURQojeqtYosXPQ/w3Za7DGdENnA26WwGQCJQ6ob
         uOUxCxsEuLLIqAb2+jHusGet+1aiim0q8B6tlQWELKDBvKu8YpSsDQmDHwpK2xL+aiea
         pIDh3Np9DMhCL5y/2Ly4htMPk0u53NOkIb30EI1vPK/0E0XwTFF/Vx42YZyuo21FMLno
         s3nT8idFCHtdcQ1xloBH6EuoR3KGQnhT4RrELXAyizfuKP2Bze21pwtmJGLUZgwIvIu4
         oB/w==
X-Forwarded-Encrypted: i=1; AJvYcCUAWYx9KHISPgn4DBGsicSFxKCpLIUkcSZ+llcULqzATIlOBXtaEfEJGSQX7r2f62ZsliYQWEUQhYAwFsRdgFET2iJ8N0tTg90bUkpPpd2nzyEnHHNHRpg27G5jYmE0BzWp4ssLMK0O/qIlzLUQvZBitAwSfFmHKMALr0xcME/mvxFs
X-Gm-Message-State: AOJu0YzQVQJsRFX7oLrLuQS+tm7YcgZpmDOZ6k1NxJ4YYEvqJH+YRdWN
	K5y9vVRsjtMc4HMyXDqAc+t8E6Vked9pjxy3wZUMCYuNu3TfPLEttt3ZVA==
X-Google-Smtp-Source: AGHT+IEmeFh+Jld3e3U2Rsd8Pzu2RT7K2MXp/5tqpRv/Tw3wpdlofFqVuG6zY3LcSjO+vDCBE/bRxQ==
X-Received: by 2002:a05:6512:b0b:b0:52c:e0e1:9ae3 with SMTP id 2adb3069b0e04-52e8274885amr5335202e87.57.1719910996443;
        Tue, 02 Jul 2024 02:03:16 -0700 (PDT)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0e1688sm12616624f8f.60.2024.07.02.02.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 02:03:15 -0700 (PDT)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v6 1/2] dt-bindings: power: supply: add support for MAX17201/MAX17205 fuel gauge
Date: Tue,  2 Jul 2024 11:03:07 +0200
Message-Id: <20240702090308.8848-2-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240702090308.8848-1-dima.fedrau@gmail.com>
References: <20240702090308.8848-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding documentation for MAXIMs MAX17201/MAX17205 fuel gauge.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 .../bindings/power/supply/maxim,max17201.yaml | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max17201.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max17201.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max17201.yaml
new file mode 100644
index 000000000000..fe3dd9bd5585
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max17201.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/maxim,max17201.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX17201 fuel gauge
+
+maintainers:
+  - Dimitri Fedrau <dima.fedrau@gmail.com>
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - const: maxim,max17201
+      - items:
+          - enum:
+              - maxim,max17205
+          - const: maxim,max17201
+
+  reg:
+    items:
+      - description: ModelGauge m5 registers
+      - description: Nonvolatile registers
+
+  reg-names:
+    items:
+      - const: m5
+      - const: nvmem
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      fuel-gauge@36 {
+        compatible = "maxim,max17201";
+        reg = <0x36>, <0xb>;
+        reg-names = "m5", "nvmem";
+        interrupt-parent = <&gpio0>;
+        interrupts = <31 IRQ_TYPE_LEVEL_LOW>;
+      };
+    };
-- 
2.39.2


