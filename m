Return-Path: <linux-pm+bounces-27698-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6816AC5C83
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 23:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E5021BA5019
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 21:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1C621771B;
	Tue, 27 May 2025 21:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHP1SUDD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B828215F7D;
	Tue, 27 May 2025 21:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748382796; cv=none; b=Vb8+pF6UW3LPEcAY/TKgkcrqqLOR/hhoZuTmJqqmjnrSk4jN9CgqyKzovrR8MjkMcoKt31QJGhF3qzBKrdonS9Wqp7opEFT1KIBUIWbe0EofH7mkcQak0uAvAR5ICmZMR2ohp9H6cUb7sRO7vpT1YPr8uIL4mnvGMrXtpCxqHyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748382796; c=relaxed/simple;
	bh=KVB9knIN20EJn4MFg0e51m0GM1UWg3GyhnYxI4POLhI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TEMeJoqnxH45NOIsmBOx0YAfYpphN8YQVss3qKtWyNxuz2sLpFsqP9WdWcxaSC4i4vZoRbOZip+o0eda26HdF6wwTDYwTmpmvZFJI/m6tERCI7A96xcRVOy99xlKlPWqQjv/udCWvoe1vU9rKZKbKejvSM6tR9OEZ0BvVE54oQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHP1SUDD; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a37ed01aa0so3769175f8f.2;
        Tue, 27 May 2025 14:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748382793; x=1748987593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Wk226ElMjpVIGD7BaKvZ9Z3Q9dYE/ETf8tcRXkIeEA=;
        b=OHP1SUDDQMk2AeJ9OYmE7sEsm2a0oLT7ATUxZvWjN+Wcm9Dq9Q8MqEmvx7B9Wn5HGY
         oeRIhJKrERLlnvBtyi0AHhCMDMxsceVfwg9ahzY5bjUw3pb9il1ZoZDqFoEpzmOoKln0
         Kp9q65F32+h061QEB2uaUzacRXHqXbtVBYg8hz3VAcH1K01xdcoxxiwJsnr3Sf1KhPAt
         L932asHYSwA52HkGrzMVRkf+mrbzEE7U33q9da1wCC/Bxc3C/nlPIqv7Em2Aomh3fFjp
         RX92hAVHQvWo8xWwBgMAOso87zKkXLaWRWqWQn8aeLv6KMAOUnakLZ5ltnZIvmTZMyKN
         INEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748382793; x=1748987593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Wk226ElMjpVIGD7BaKvZ9Z3Q9dYE/ETf8tcRXkIeEA=;
        b=GbM5EiPRw1dle2Ett4sQe8NytIhhs/sKddv5+PQwmvV2kCIyJmpEvzsMRzws1wcGBj
         qs/zd17gC0Fus8Q0sq6ZuwO2Vy1sDh4tWOT3wjHT6iRULIVByMJpv4l4CuDI49S2NU6L
         Me0cIl3DOY0Ea3XFgPunC6UF8N0XLsm7r3EwYrjes63LGYHSUYQdMb5dgGHJYnLmwUJi
         zckf6dT74nzZmWG85wKpie49G8ayvEeBXvtCxA1OFAF1jnov9OKAHuGByX/FPe8o5XeX
         DE3WzL0bWnrhs05r1y2CPbk2lEwT9UxPc0t+bmo8wRxHEva6C03XA2GNNFDil39PYC8I
         ZvcA==
X-Forwarded-Encrypted: i=1; AJvYcCWBhsaKWcCbiaq79582O0NZsL29ABB7sURx1hPkCKAKV+qa0rE+/d/qtRQKEt1sSebazPS9bsU3gqJs8sLI@vger.kernel.org, AJvYcCWf17zremIb0/Y6s5Ic26nl2k17/P6HT4hc/V4e43DU9VxrlIvA/wWhFpYZXmSNGwl3dRyj56E73SDE@vger.kernel.org, AJvYcCXMtXZ9A97qKdn3o93wPejiAyZFK1B3eg8xXD/6Dm7QWgEFxc63WIFTIKojPXTCkWFToZO3POwguO0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2H/pkYYMxZogGff/7fI1SwsQkLgwfNZw+EmJkk9nhXE3lwer8
	BNX99mqgPDNsFU6I5rE5cfdj/U8U1x3eegRFvvlv9IGfmpgd8KF3VMVs
X-Gm-Gg: ASbGncuaa1iC7nxMfjHVSVpOtTZYfAkhuh+XoT430pU3wgYWIwrms7ld4cuCkpix5qV
	AtB/2HXmYPIuyr2gvRX54ptI19L+vkiOgoqjnPFCuTmAb+bu8nII966ELESnazEL6sbE/cfSic0
	iHEc581tMtIGseveSvgTULXhxZxmy+HRkW5lLLgi4BWO9+34Hb3spEXb7tRiN61BZOmbVYaXGTd
	PMSThACyZAB2tol+4TVLvtHmodVhpNkZCp62iG/2Ht3+bwwShJtH+xJcsa743c2hDHAynk76pmG
	awjmo4jX8Rx+LlLGTySXDSAEO85Wllp+gThdTiiyoAI+JVzqsDuJqC3hC+QGu9FxNErof+4gev6
	4Nu/ypxCPWzUjexoaJ5x+
X-Google-Smtp-Source: AGHT+IGzdRmpIiChZHvMpjw4//1BMh2wxfIxE1BvnrYjHNrpYnZI5pBznt8DKI9NHAcUBdgEeJZlyw==
X-Received: by 2002:a05:6000:2911:b0:3a4:e65d:5d8c with SMTP id ffacd0b85a97d-3a4e65d5d9emr1716337f8f.40.1748382792639;
        Tue, 27 May 2025 14:53:12 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a4e8b8dcdasm206656f8f.11.2025.05.27.14.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 14:53:12 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] dt-bindings: thermal: Document Airoha AN7583 support
Date: Tue, 27 May 2025 23:52:38 +0200
Message-ID: <20250527215241.25767-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250527215241.25767-1-ansuelsmth@gmail.com>
References: <20250527215241.25767-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document support for Airoha AN7583 thermal driver.

Airoha AN7583 follow the same logic of Airoha EN7581 to read the
temperature but lack all the support for the PTP_THERMAL used to monitor
and react when trip point are triggered.

Also the Airoha AN7583 lives entirely under the Chip SCU SoC register
space hence a dedicated schema is introduced.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../thermal/airoha,an7583-thermal.yaml        | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/airoha,an7583-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/airoha,an7583-thermal.yaml b/Documentation/devicetree/bindings/thermal/airoha,an7583-thermal.yaml
new file mode 100644
index 000000000000..cfd37e33c541
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/airoha,an7583-thermal.yaml
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/airoha,an7583-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha Thermal Sensor and Monitor
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+properties:
+  compatible:
+    const: airoha,an7583-thermal
+
+  '#thermal-sensor-cells':
+    const: 0
+
+required:
+  - compatible
+  - '#thermal-sensor-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    thermal-sensor {
+        compatible = "airoha,an7583-thermal";
+
+        #thermal-sensor-cells = <0>;
+    };
-- 
2.48.1


