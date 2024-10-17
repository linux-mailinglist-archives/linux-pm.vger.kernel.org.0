Return-Path: <linux-pm+bounces-15877-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D534A9A2542
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 16:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EBED1F21730
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 14:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1051DE880;
	Thu, 17 Oct 2024 14:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/otaqd5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBA410F2;
	Thu, 17 Oct 2024 14:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729175953; cv=none; b=ujGaueW01mFF7krj0AvMZz6vTeZ+v2SrGy/uHDc2Gk4XoSzGimZEROVrvNdPm/1iThdB+PGNsE3Sjf5h1B4ONvSNxQTy6KTAOKxmyYiMFynLofJrHF4XH38LrZHROWJvAMgXaYvXFejs3Imc7C28LaTYfKk4xuR42rU9RF+4N/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729175953; c=relaxed/simple;
	bh=RSdMFumWyD7Mx4sKNxKfjNlsDJaTB6uemxsTmcKyHuo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hlpZP5XB7GSFq7to4x/E6s8BtXZYyC0xI5kKxtGWGjZymLQjxyTUPjszPA2tbDAYw0ODstaxkfEU62P45h+kSTo7z6F6ZkK8c21sOCeLienJS8ZURt8tohd/gtOyV7jRwsyHnFyvEuPEBl6C9ms9m/A/gK2mcNJoJ7rPk0iAAIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/otaqd5; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d4b0943c7so747985f8f.1;
        Thu, 17 Oct 2024 07:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729175947; x=1729780747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NRHQQGm7cGssgdoLEtNCNKA/IiRlPKI/cHGPt5rH+50=;
        b=O/otaqd54QBlBX+Op+mhyy76V1F5w0K1G9/Ie+1LuK/n03BTM/mk1ZDFsaCgQM4j3q
         NhX0BNGFqPHMzsTYS6CfSk9EFmO9Vknnv64Ps+rlf8ArHKuwi0/G7bA7LVsjyjBSQWlq
         mLdxp8rXjmAj/6OPEpCIqMJ1anPxb1XSsuGO7a9HOoOXX4u3epiCbynd+6gVxGYlRjoA
         ofpsP3M1/BWZG4k1xPQ/jEaNyAwHRJ7c8RgcPEj8Dm56V5x5Qd8Jens2tpIKohrwr5UF
         p11EKOXL6IOPeeOEHeXANXLAD2faj+X1qYBttQXtuWjUu60cvQd6Nxuygjr6lJs1TRLY
         DdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729175947; x=1729780747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NRHQQGm7cGssgdoLEtNCNKA/IiRlPKI/cHGPt5rH+50=;
        b=epG9GhFwzfqZxSy5i2wfsd9lmAk/XFDztWh46U963cDheqiVQrY6JEzmASNHTIw++E
         oi6Qdy795R9/699qOcuNhG4ow7T8KFjafRU6T1xkMnmTNm1PmpPJmAJ+5qoW8R3Y99UF
         Cjgs4rzVNm6f6Gc4Pjrt2tVQFydzsnpUzXb4FIv82ncwHqu7nHoPQbL7fw+Bhey5pK2S
         kgXtHXuOhHcGvAXOdx/iBBMEYmPjz3BcfKgWOAy5VS5HQ3FYZME+oxAyNIL16QU87f/8
         pp6kTPtD9V0KPaqu2ItMWvf1si146lbmNlzMQL+HUi8WC+VnedVKu1F7oU4aos5AgYou
         +9gQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHiWQ/AqpdV/k4s8XbBfXgXjkgXDLQ4oJSqH3HvL+esd60HMU1rvUitMw0GwDwctw0Ouh4fQSmbK23@vger.kernel.org, AJvYcCW0UKUa895ZfTWqbYdJ9QgJEqVgCJZ0vPfbUgCmPJ4g44B7RrOTVvVMGreHDR2MHVkH+bcL2dnrwzWt5zpP@vger.kernel.org, AJvYcCWGqngQRDaPB3nSiwFm+M0u8s8RgKn6+5mtc/vYr4IamPNAF+rqQpL+l1j4Gp/eJi4TcPanUi82XKE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Wg13bz25bEHDQh0jOwxlW1lUdqwvWOcacTMcQTBNcVekpFuU
	ud0/DsMEkbEAvjGuxFz/bulg58isOGEttlI0sHOW3nNJpWSMe6Fh
X-Google-Smtp-Source: AGHT+IHurhqL3M/WK0hFCGWAVhEuLelLlozmUE30CPXOnitE4Wu9IcCt+oBAvpCfr+HSmToSGIUGRQ==
X-Received: by 2002:a5d:5985:0:b0:37d:511b:aecc with SMTP id ffacd0b85a97d-37d86d6fec8mr6196339f8f.54.1729175946450;
        Thu, 17 Oct 2024 07:39:06 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37d7fa7a12fsm7442784f8f.6.2024.10.17.07.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 07:39:06 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	upstream@airoha.com
Subject: [PATCH v2 1/2] dt-bindings: thermal: Add support for Airoha EN7581 thermal sensor
Date: Thu, 17 Oct 2024 16:37:56 +0200
Message-ID: <20241017143830.1656-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Airoha EN7581 thermal sensor and monitor. This is a
simple sensor for the CPU or SoC Package that provide thermal sensor and
trip point for hot low and critical condition to fire interrupt and
react on the abnormal state.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
Changes v2:
- Add Reviewed-by tag

 .../thermal/airoha,en7581-thermal.yaml        | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/airoha,en7581-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/airoha,en7581-thermal.yaml b/Documentation/devicetree/bindings/thermal/airoha,en7581-thermal.yaml
new file mode 100644
index 000000000000..ca0242ef0378
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/airoha,en7581-thermal.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/airoha,en7581-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha EN7581 Thermal Sensor and Monitor
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+properties:
+  compatible:
+    const: airoha,en7581-thermal
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  airoha,chip-scu:
+    description: phandle to the chip SCU syscon
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  '#thermal-sensor-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - airoha,chip-scu
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    thermal-sensor@1efbd800 {
+        compatible = "airoha,en7581-thermal";
+        reg = <0x1efbd000 0xd5c>;
+        interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+        airoha,chip-scu = <&chip_scu>;
+
+        #thermal-sensor-cells = <0>;
+    };
-- 
2.45.2


