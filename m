Return-Path: <linux-pm+bounces-19968-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3333EA01B0F
	for <lists+linux-pm@lfdr.de>; Sun,  5 Jan 2025 18:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF5B87A1841
	for <lists+linux-pm@lfdr.de>; Sun,  5 Jan 2025 17:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F5619F13C;
	Sun,  5 Jan 2025 17:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5ZwCUFq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB0D150980;
	Sun,  5 Jan 2025 17:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736099052; cv=none; b=nvzBEYHDqXs907ErJJMT+9JkvuIVLynZKkOWAHMkogB8FLNziy5ZB4NdFxQ54HE6r94oeV8S51MuDMqoQceAlRemKzskK1cDWbGMJSNOEyRQIwRrXf/aYnsb+BDPX0NM9fjdRccCiJVFdgEhHajKsK6gghHukkv4Z2ipi6pwC+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736099052; c=relaxed/simple;
	bh=SsJ2nIH7zhgX3bhLQ/5arHhAxQzX7v2lgKf2tN9SYDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jz1Xnx4sAqnjpiIAr8nxIZWyJX3sCK4VCtvuEnc7ZjL6MgYWSJdMpqbi/tiArhJPkLtWM01sVa4j4w3jf+FXake5gLfYlF9nKGiBhVTqbmpO1zDt3aSNEYhOaudWIOMFWTwR3NEH8tXH5/tMPaKzxcJCM+4qnn5ck3c60+Cycb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5ZwCUFq; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2162c0f6a39so201184255ad.0;
        Sun, 05 Jan 2025 09:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736099050; x=1736703850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FP8JF37fOOztONXH0znKizD1r51roxZMEdyoSYLxZ4=;
        b=L5ZwCUFqowdHAV7kydjGUPYM32q0vZ+2K4cXB9g/3i0KLAjU4264kDoz67omtsUxA0
         TGihVG/btchMnXgpOPVO5xG9v7kCDowfglGgSXOjQyytM0nnX40Sf7nA+W3kxJC/945C
         i+Q7bTft9hVZXOzNREN5jHkihI9IcQNOyHEyjNyHqAQr3MtxQ45yD03dh+WzTCiu0jJM
         O0LPt2+lR4bBPvYrGdjM3UTXifb8aoh7mRTMJDoDSe/QWrfCz5rcyIjZc/RHs/P0yFPD
         w2UbLDf4/ZIu7GewZtG4rsMd+PDk6vFqHcH9F1LeKcTYy1cLs7RYEpKe7GGPFArILtA0
         8M2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736099050; x=1736703850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0FP8JF37fOOztONXH0znKizD1r51roxZMEdyoSYLxZ4=;
        b=Bk5wVxtYSk1DDn+hKNtnaz4H8H+N5YsEC9/jqdmvDAMfh4EhDdYNcf0TavXraOmZWE
         kNaHUZh3Q1H4FZue08pJNdPu3RqclUemR0L/VLTdSYu5JznpzdwlYhZkWWk/9wAJ96hU
         tEcmyHFCehchxbIw+YVqtfuthyEZ1yvt2PXfbgTFaBcLRHibu4XkvVpafdK5JIl3DdAx
         PMuH30eTktqRzhNfjswwJsHwcjnuF4gf5WM5p/mLmDyXMhjvW8lPf6D0O61vu8T330u1
         LMoX0J8thAxHrruZO5lLqyyGRcXbiQc91nLun+KeUSvcmZqp4wlQ6mpqwyjKRrJnJjjF
         VfFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/zzNeL3w9XKjsM0wZgSy26ZBpmbeB0rfXS+2UB8/FrX01kl9wLo7/omKbXDY2pyOiRvvLKh9p2H6hXpw=@vger.kernel.org, AJvYcCUDF+GZE3NMt0sRrvDnDaklnXq7J+YAxqkYlmBJZtcT6puFRHPt3TBSJiOskr7E7Bd0IqBSG1hcPvb+HFQF77WJ5maSfw==@vger.kernel.org, AJvYcCURo75GdHMlZ1EXjboilRhPAxVKANcKDvfdK+nYbtIA15pUtgw1Hi90LwTRF1FZBrrUycK7c99V4j4V/PxT@vger.kernel.org, AJvYcCVUhGKAubwSKxfQ4E3g+/TO8rn+qMI0ts077Q2uSLrTRGDAItcPU8yGLWVxMG6MljXDe99buthej/oCIgEj@vger.kernel.org, AJvYcCWUIwcHNvEpsrz8wUkQMzOqGidyfotnyuVPZLvruYM5zg99FhzstVBrL9E7uOGOm4nqE3R7+CAZdP0c@vger.kernel.org, AJvYcCWj2s1eocMtnPeYR4YHlek8f883M4X6zvbrEvxXxEGa2+0z/CzObWLUm8qgpHgInRRBplKnknYGsIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHYedJeJb572w96RjXo3nAPIwOoL6mAftIgwfwKYtX9tVnwEp+
	vTt8i796OEf+8ZU29fcifhlnRWoo+uUlZEISVIXYcSTAfV2NMlet
X-Gm-Gg: ASbGnctE1eLpGosXaXLx28Hss8epJbzxBoCxH2TKLS3wzp7zkM2D/hCJO7F5jvQ8ldZ
	+dzH2TAKq+jindgiXTQ2OVjxPlUT7yKxrQMkwNVVSLmejZxzT6kTL0KpCWXgeYeGonstGLWFpP/
	2AFgSAqGc9s25lzt6n3Ld132u4nC6HoxanzQ6mGnQ3jcFaSq4iPMd1qFFVsRCQqf5212V3OeEe2
	udHhnCRK8BpXoRaQvGq3nhrzwMsVyS4/56NfsETriCqWO4SFzrBKBg=
X-Google-Smtp-Source: AGHT+IGTc8rWvoDza2FaN/geBHMsJrWYntomG2besJ5VmrlXLGHDVS4FPvJdZC4cJHj/TisXjkoUvw==
X-Received: by 2002:a05:6a21:3987:b0:1e1:eaff:2c23 with SMTP id adf61e73a8af0-1e5c6f160bemr75464885637.12.1736099049682;
        Sun, 05 Jan 2025 09:44:09 -0800 (PST)
Received: from nuvole.. ([144.202.86.13])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842abd5927fsm27375046a12.10.2025.01.05.09.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 09:44:08 -0800 (PST)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Pengyu Luo <mitltlatltl@gmail.com>
Subject: [PATCH v2 1/5] dt-bindings: platform: Add Huawei Matebook E Go EC
Date: Mon,  6 Jan 2025 01:41:55 +0800
Message-ID: <20250105174159.227831-2-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250105174159.227831-1-mitltlatltl@gmail.com>
References: <20250105174159.227831-1-mitltlatltl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add binding for the EC found in the Huawei Matebook E Go and
Huawei Matebook E Go LTE 2-in-1 tablets, the former one is a QS sc8280xp
based tablet, the latter one is QS sc8180x based tablet.

This series has a codename, gaokun. More information about gaokun, please
check https://bugzilla.kernel.org/show_bug.cgi?id=219645

Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
---
 .../bindings/platform/huawei,gaokun-ec.yaml   | 127 ++++++++++++++++++
 1 file changed, 127 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/platform/huawei,gaokun-ec.yaml

diff --git a/Documentation/devicetree/bindings/platform/huawei,gaokun-ec.yaml b/Documentation/devicetree/bindings/platform/huawei,gaokun-ec.yaml
new file mode 100644
index 000000000..149c0cbe4
--- /dev/null
+++ b/Documentation/devicetree/bindings/platform/huawei,gaokun-ec.yaml
@@ -0,0 +1,127 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/platform/huawei,gaokun-ec.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Huawei Matebook E Go Embedded Controller
+
+maintainers:
+  - Pengyu Luo <mitltlatltl@gmail.com>
+
+description:
+  Different from other Qualcomm Snapdragon sc8180x and sc8280xp-based
+  machines, the Huawei Matebook E Go tablets use embedded controllers
+  while others use a system called PMIC GLink which handles battery,
+  UCSI, USB Type-C DP Alt Mode. In addition, Huawei's implementation
+  also handles additional features, such as charging thresholds, FN
+  lock, smart charging, tablet lid status, thermal sensors, and more.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - huawei,gaokun2
+          - huawei,gaokun3
+      - const: huawei,gaokun-ec
+
+  reg:
+    const: 0x38
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  interrupts:
+    maxItems: 1
+
+patternProperties:
+  '^connector@[01]$':
+    $ref: /schemas/connector/usb-connector.yaml#
+
+    properties:
+      reg:
+        maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |+
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        embedded-controller@38 {
+            compatible = "huawei,gaokun3", "huawei,gaokun-ec";
+            reg = <0x38>;
+
+            interrupts-extended = <&tlmm 107 IRQ_TYPE_LEVEL_LOW>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            connector@0 {
+                compatible = "usb-c-connector";
+                reg = <0>;
+                power-role = "dual";
+                data-role = "dual";
+
+                ports {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+
+                    port@0 {
+                        reg = <0>;
+
+                        ucsi0_ss_in: endpoint {
+                            remote-endpoint = <&usb_0_qmpphy_out>;
+                        };
+                    };
+
+                    port@1 {
+                        reg = <1>;
+
+                        ucsi0_sbu: endpoint {
+                            remote-endpoint = <&usb0_sbu_mux>;
+                        };
+                    };
+                };
+            };
+
+            connector@1 {
+                compatible = "usb-c-connector";
+                reg = <1>;
+                power-role = "dual";
+                data-role = "dual";
+
+                ports {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+
+                    port@0 {
+                        reg = <0>;
+
+                        ucsi1_ss_in: endpoint {
+                            remote-endpoint = <&usb_1_qmpphy_out>;
+                        };
+                    };
+
+                    port@1 {
+                        reg = <1>;
+
+                        ucsi1_sbu: endpoint {
+                            remote-endpoint = <&usb1_sbu_mux>;
+                        };
+                    };
+                };
+            };
+        };
+    };
-- 
2.47.1


