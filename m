Return-Path: <linux-pm+bounces-25328-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5983A871C1
	for <lists+linux-pm@lfdr.de>; Sun, 13 Apr 2025 13:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28E94189AB91
	for <lists+linux-pm@lfdr.de>; Sun, 13 Apr 2025 11:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393151A5BA8;
	Sun, 13 Apr 2025 11:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8VY0B2E"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AC51A314E;
	Sun, 13 Apr 2025 11:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744542660; cv=none; b=E+wmGaMQfPbvzusS4IbbbBXSsQJBktVM0pjdiLlrStStatLmeV2JtVVdGiiPGgAS2ES3MHP7dgFKIhJnUpNeqsS7FuTi6NCKElnS/phN01ArAST7iino0zYEnqkP3JR+a0p4XLDLCCq8V1kZbrI+lOVpzzMZWLTt5dRN7QPMrXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744542660; c=relaxed/simple;
	bh=X2a0y9/B0jI4AAJ86ta/g8LdLh80roBapHte9WAl4b4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aZyHiitB3XpVrGkF6ZygvlxC4JujJFAAkWVMDEJQmUDsqSsMgerfdi2K0jG34OPBQp1hm1hZMXnHxk4RWpmZTgpB8YuObxFnIdMjPF+isMvZ6rKCndL3aaCD636k1KaAOgijuAOPJFrFft5hxPLWnzEyFYhVETImKOygAKsSoKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8VY0B2E; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-abbb12bea54so679360666b.0;
        Sun, 13 Apr 2025 04:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744542657; x=1745147457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48v5ru+il/PLdzW8wzxpo+r32d4X4MBM1FD42Cv+dFI=;
        b=K8VY0B2Enb74fpaLOPLx5Jwi8qb36TwKukasfQWY0vIDFzjDn0mUCAkbA613hzZI3P
         4OJJOvsPefUsS3cHioUhSj5g96KpG+SIWLfEK3K5WnDjQJ1W1cQzXUS5iyyK57blNBgc
         8QQCQsTfnaXz0ujoej4MUrrNOQ5EOY1Q3BzOc0UHIAo++1TsoJtgkAOUD1QwkZ2fBq8k
         zdvoPjfoubu33DYS5vEvJoCoFMY1RRXsXlF1N6LrTDEkRaWvrvX/IGrVU6w+yMYgfaVY
         u7yHRQka2auo8QfyFBygeoW4Mh2rWk7QfyXaVW9CDOjLCGfJ+uGpBsbogGxkMR1OYeNl
         ry9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744542657; x=1745147457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=48v5ru+il/PLdzW8wzxpo+r32d4X4MBM1FD42Cv+dFI=;
        b=J66Ehsp20S8YIFLHkSzBna/syvfFDRncNVivuX+/mcjpibPNDI1x6fBF3V9US1MLDi
         j07t+ivonJkiaHSZfA+X6pDn+BEjogtQNUEfbWceAoJZwxkWhKpZLo/RHKtYDRxGZppN
         wqop1C4Bbrlbd8kpkJxOzhm0Od0mrLV9u3Rqgqv8kqdlBiG4zPo9FRvvPp1yik/AIVEC
         G0V+ApuZQ8J3mWlVEH8lx71I8ou7T9zhSn/w29/ffKt8N9smljX4/DIQKCF7Qp/XQ95L
         kzTZ4wzao/3oks1WuDj5jSYR/Agw/Phx7oN/IRDPETlIwsKJ+/FxNv8YQiZIedgpUCyl
         yzGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV1hMD154nkmD4G3peLU/M7tDmPtl77w/3ivlw4g+ZuyA7TRVinLFmcqLkgrSoYpFLDSKOu39BpKkZVi8=@vger.kernel.org, AJvYcCWDAxY7cdEGnUmzJQCIbloKKwPo2fUyx9IwYDR9jQ7RfypRSPooT30/AnfT3a081AleQDrAb9NKQQdq@vger.kernel.org, AJvYcCWILP1bsTWwKLEdq3i665QX44VAAYrLa1CXUnO/1pt8lY7gxHzIBJNCyW/4l1RFCYYYgqIz79r+DMM83AVo@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt5oVBaZWQbtC+GaIQG7y3RzAccf7Ry4d8EIptWBEa59kIAxwx
	3Wchg8EoqvYjNks0FDftVfmk6opVKep0WrS4Jhf0HA4Y/6w1bktL
X-Gm-Gg: ASbGncuRgg2+r/ovuldkaDqHugxymPB3NoQOykAvH3+xXPMgtEteo7fW3XNFStptArs
	usuMyJ8J0+ZvvhOCNtdNKUlo8kNFUP4QjQr+NsgllHg98dgZoqyVTGpHb7Pvbj/KxshUuJoScGs
	jGLsAjm213gzaFDWsNxLlAtUD11uce8j0RzFlSe+Vm9zdlLPcGvyN6FYerTjmMJNL17YC+rJ6gw
	ZvoBVA0GBmaisGIwZJhYA8OZedtstOOuUfydu0zkLop13FpH9mpHZlm+6sLZsl/n/fU8o9ln3Uo
	q4DT0VYZLlO2gbWFJzPnc6tMJR88E3n2mG6+NT1KIp4=
X-Google-Smtp-Source: AGHT+IGl4lvsO+0vvy3R3ukgxLsi6KJBwXpEwGD/F7kFuojFxQOCh0eb7pjPt43Tyv3JQ8xDXn9YlA==
X-Received: by 2002:a17:907:94cc:b0:ac3:8899:d2a6 with SMTP id a640c23a62f3a-acad3456f74mr717634366b.12.1744542656388;
        Sun, 13 Apr 2025 04:10:56 -0700 (PDT)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1be98d4sm728571266b.59.2025.04.13.04.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 04:10:56 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Heiko Stuebner <heiko@sntech.de>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v2 2/4] dt-bindings: power: supply: Document Pegatron Chagall fuel gauge
Date: Sun, 13 Apr 2025 14:10:31 +0300
Message-ID: <20250413111033.11408-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250413111033.11408-1-clamor95@gmail.com>
References: <20250413111033.11408-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add binding for Pegatron Chagall tablets battery monitor.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../power/supply/pegatron,chagall-ec.yaml     | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/pegatron,chagall-ec.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/pegatron,chagall-ec.yaml b/Documentation/devicetree/bindings/power/supply/pegatron,chagall-ec.yaml
new file mode 100644
index 000000000000..defb0861e268
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/pegatron,chagall-ec.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/pegatron,chagall-ec.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Pegatron Chagall EC
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+description:
+  Pegatron Chagall EC is based on an 8-bit programmable microcontroller from
+  Infineon/Cypress Semiconductor, it communicates over I2C and is used in the
+  Pegatron Chagall tablet for fuel gauge and battery control functions.
+
+$ref: /schemas/power/supply/power-supply.yaml
+
+properties:
+  compatible:
+    const: pegatron,chagall-ec
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
+            compatible = "pegatron,chagall-ec";
+            reg = <0x10>;
+
+            monitored-battery = <&battery>;
+            power-supplies = <&mains>;
+        };
+    };
+...
-- 
2.43.0


