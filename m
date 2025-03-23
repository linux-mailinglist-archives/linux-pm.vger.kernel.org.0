Return-Path: <linux-pm+bounces-24432-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA3EA6CE42
	for <lists+linux-pm@lfdr.de>; Sun, 23 Mar 2025 08:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85389189C251
	for <lists+linux-pm@lfdr.de>; Sun, 23 Mar 2025 07:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB6E202C4A;
	Sun, 23 Mar 2025 07:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtdzCkhl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED5220296E;
	Sun, 23 Mar 2025 07:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742714096; cv=none; b=GQ7U9lmbpJui+np8zzx5cV9YE+WRKRQeb99YQrGSUwWj+FayIXd6ueKXh9lqbnUrCP+7djTZl1Z5c6tCcV1G0MmeYsT+ZNseS1pQHEVUKDry2evqGzBqT9x4nYSUAJ2P4aQ0tqkVVEXeQ/azTGu/S5dq8sRdPJxdBXzUjr4SeKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742714096; c=relaxed/simple;
	bh=CWhQXv6t3smUOD52oWFdekfMPw+WhSEXP5k7xJ0iT2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQFoH5cGGgEDexPn6W7YMv2rCNuOHvI0ZlZr9oFTOQ1h0r1zcTJLc02ZHfNib00DVKdHmJWCs+xu09Pr3iTKNtHIOGJ9GJnsikKxFwBTpu5UjJ1NobCm0ExG29V8oWgRmwnIETyZib9Eu0kmEKDS8c1vKegRObX+xvYZ/N+fIo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VtdzCkhl; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e673822f76so5243734a12.2;
        Sun, 23 Mar 2025 00:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742714093; x=1743318893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29uewYC+iRTpdEimjLoyLiSalpqvIJ8kugFIJHF4NTA=;
        b=VtdzCkhlQtIR3cjFA88sSCeXgQZttGzzySb/+mGT28t5jRj73dN9d18PT8LVperQwN
         Snz8lh635Q5zP5ijmFTLhz7fdKAJk9CvjjHrrGQQGWJ7o6L0i8ir7Fn70sOQ3Qsy+li2
         7Jw4FxX3j3J39yMaBElVpcybayKiMjtlNe1vFD22tZEGhOz4So8UTeWlJD0QGdjcRLoX
         icvs1wP4R3aiZOSmFArchus12s4l5ti+UFVTzCisHOgzJsAF7SvEudwB5u9xtyhY7mxT
         +ctswss5+L2SX3FPYqUUPV2SzBoZc7yC1GsXE4lkEEhitGCvEffTvxPHO2sE8EWNZup/
         Erfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742714093; x=1743318893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=29uewYC+iRTpdEimjLoyLiSalpqvIJ8kugFIJHF4NTA=;
        b=G4pFuxbMjzSt4YKpo99lB2kR43SFsjhP8NYNEOoAndR4HR/4kkdOkTfouysPrQy0Gx
         IYeXAuOJ25naQPqRi/Q0OgpdVqUsNJLJ6V5dEzM6ne4hKQWwQvXkkhFMHCERWsx/UQEG
         Tf7i5MozcQBT7nHeT+KqskFfR+t7e5vNaJCg2o4NOg4/s4R0jxzlKkEDnoXHZpQOD9zo
         uHa/vRAgucVM+IN4IaS9R/LJ17YZphOzElmF3liN3kA2dI9SSwqNu0/5s+iP6cx42MNB
         FXn4G8p1FAjAFv9vwyZ8rrsKrIfE2b72eYlAhhLNtK+CiKL2gWXu7HDjm9yS5wgWgCRl
         PRUg==
X-Forwarded-Encrypted: i=1; AJvYcCV0tnujrOjcu/L57M7UdgDGMOiWdpf+OauFEaoCimmjWW7f1KjmvnFxiLgCqEddlWKtdnhNZlvHaCA=@vger.kernel.org, AJvYcCXCIrgCiNiPtkhaLfYSz3O9znNuze9riOl+YNPLMdq0o8YK7fo5/DtRRMWQRbnIqGhnJg3hX6I5hWGotaM=@vger.kernel.org, AJvYcCXltvT+GPbOoqwP6Hep4UX1qcVXKTl8McRJX15ch3kN8onk325DtikR0eJ6Vayp/7QN0EsuUoasYQEt4tA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwErWPEaKXrB1DnvnmmrReDpXdqbH2wS73ecZaXEcJODOVycaqh
	+UVm9c8I1Mn58Jc7MmoXa/idB9bJIMo66A2H7yES6yG1z2ANxMFT
X-Gm-Gg: ASbGncsb/ST1t9NSg6+MUQHHxd1h1v/rnl9RmNB/TtaWHcNlsfyv1CWZWnbzzN1z4Lj
	1f5A5xdvjRC7XTGI/Q2gei7stf9+XX13EBw3jQbnkBqLuCRN3opZMJwBeNyUs2gsJpS6bPNGcbo
	uQis4tRB3HgwYBJY2a4CEnVWExNsCpo38FkizZvoCBZsk+BkjzwVhceVQUcyL8zCC2BIMWwPgyE
	AvBygQRYd2998IltM1iCWnxW02m7OyDOQvg9C0l+VWH+kF7ur2wEjf4Pi0gm440xXypXIenm2YG
	14U/r/bzLPzy67GMTsd5zBo5SBMxK1Htk4kB
X-Google-Smtp-Source: AGHT+IEqd+7IPPUUb7zOi8eoTIbMKKkpIbd/z7ELoYmkbF9H9wVTaXKTVrjAw53cjx+cV8jr75ScWg==
X-Received: by 2002:a05:6402:27d3:b0:5e5:71e:8c63 with SMTP id 4fb4d7f45d1cf-5ebcd466aa5mr8265071a12.15.1742714092740;
        Sun, 23 Mar 2025 00:14:52 -0700 (PDT)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebccfaecfbsm4218283a12.41.2025.03.23.00.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 00:14:52 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sebastian Reichel <sre@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v1 2/4] dt-bindings: mfd: Document Infineon/Cypress CG7153AM MCU
Date: Sun, 23 Mar 2025 09:14:22 +0200
Message-ID: <20250323071424.48779-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250323071424.48779-1-clamor95@gmail.com>
References: <20250323071424.48779-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add binding for Cypress CG7153AM embedded controller. Pegatron implemented
a custom configuration of this MCU in their Chagall tablets, utilizing it
for battery monitoring.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../bindings/mfd/cypress,cg7153am.yaml        | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/cypress,cg7153am.yaml

diff --git a/Documentation/devicetree/bindings/mfd/cypress,cg7153am.yaml b/Documentation/devicetree/bindings/mfd/cypress,cg7153am.yaml
new file mode 100644
index 000000000000..f8469b5e3816
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/cypress,cg7153am.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/cypress,cg7153am.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Infineon/Cypress Semicon CG7153AM Microcontroller
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+description:
+  The CG7153AM, an 8-bit programmable microcontroller from Infineon/Cypress
+  Semiconductor, communicates over I2C and is implemented in devices like the
+  Pegatron Chagall tablet for fuel gauge and battery control functions.
+
+$ref: /schemas/power/supply/power-supply.yaml
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - pegatron,chagall-ec # Pegatron Chagall tablet device
+          - const: cypress,cg7153am
+      - items:
+          const: cypress,cg7153am
+
+  reg:
+    maxItems: 1
+
+  monitored-battery: true
+  power-supplies: true
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        embedded-controller@10 {
+            compatible = "pegatron,chagall-ec", "cypress,cg7153am";
+            reg = <0x10>;
+
+            monitored-battery = <&battery>;
+            power-supplies = <&mains>;
+        };
+    };
+...
-- 
2.43.0


