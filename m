Return-Path: <linux-pm+bounces-19778-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9089FD66B
	for <lists+linux-pm@lfdr.de>; Fri, 27 Dec 2024 18:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23FF77A1ACB
	for <lists+linux-pm@lfdr.de>; Fri, 27 Dec 2024 17:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2283B1F890D;
	Fri, 27 Dec 2024 17:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MemUQStJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787B135974;
	Fri, 27 Dec 2024 17:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735319730; cv=none; b=lJHA2NhYKgT8GmQwvjr88eWBgTTw6+QuGhkIjyTiHn7eE/xN6CsZH5N/hJ+hVIAl1edZjoPwSQBh7/utdwy1Up/L2KmpmiDv4QIr5GTc2TNHjjUIpsMsW8iXY4Vx8Wu4ql4GpGtGQ3lQbl4SrME+xaWYToSN+OAJod7aJvfcOG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735319730; c=relaxed/simple;
	bh=P6D0+6QQngFutJoilW+irGFKIWthCOIahNe4+TNdzqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kfn7c+236QQ91R/mBT4zQWoS4QkzIRoczFvbhBPkVNL9dWBo4wxxBMpe7PPMsD2/9l+FrqjJeb/3ASfqJAqR2VmK2uX2cyrGsUpZPYGtM83AsGU1g522AX3575H8elfmbEIxXgZ6ZsLZLXHVK7LG+3DLqZEl3P24p9N2tZ/pqS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MemUQStJ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2163dc5155fso88858725ad.0;
        Fri, 27 Dec 2024 09:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735319728; x=1735924528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VAUvk7RBIs42sziCKORnbSfkimwL77gcLuSYfajjTk=;
        b=MemUQStJ38xrWBcNK46U9nC+aBmqQXbumpBFWO0CRuLwMvtPL18wIls4AFJOVWA1ll
         Nj417aU9b382IVOcg9zWHcduDp6/epLlIqRIEJ08tJFtZeVy3GHdvdIJtnJuvAmQT3CP
         SS07yf2BS1zs4wbg7uUG0pMALC/sGZTRYa6gfXcf83gT3Sp/H/JyyfHe2EXobZ1hh31j
         ok7Tk+/w/RIrX5uWVC7T7/wTadoey+oul8cvuhRVviMrrIqrO1BwPuuElBoveje4JVZI
         U+UlliZ/xBzydCdsCPGzBhP5vld8n6OvGv13lFn44wxeJjFLl/1ns7+nUL4np4IzZLy9
         Yq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735319728; x=1735924528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1VAUvk7RBIs42sziCKORnbSfkimwL77gcLuSYfajjTk=;
        b=mpkT/KqO9y024JhfWN8MvBwrs4yxS64e29svD0D/Unv2/caXj7NZuLcbJESadfaZMb
         UKXJy8OtSmSUF8QhIq04auPEgFJEikIg31Kf+oibds6VtIyEUYMvV5QYNf/6JGloJk+V
         lqyplMW2GcM10n2z+i17Xr59XNu8qpwkquigpGrRk76eYkMflWOt7o3Gf/zGT4T2WUms
         9TbJYWIClh7XiAZMWH8bRSfLM8N+7qYcrYAmfwNPf1P+qb/hu8J/k1wAHF57vlxTtoUC
         o/jQDpPu4Pr1KUvMjvCqsuU2kvn/Osd3+k/Vs6Ovll/FN854rcJrguMxE7sJVD9iX92c
         fGFw==
X-Forwarded-Encrypted: i=1; AJvYcCUhu9bX1PoCHTx1ZuJZXjUCnreSIwn26isCbOWH9dTttTU/qStO7OWkZMGJ4/c9EkGrTLcoI4PoPjHB@vger.kernel.org, AJvYcCVdleLLfNj+hThfp8JH9xfUJwk3N5Eg7cqaJO4PQZGC60d+58reeKD0/nT7O11WtH100H4NVgVfrkVut1lQ@vger.kernel.org, AJvYcCVgtoHDuMn1I0KTrlsmIBXgL3HbtKOzeuXwjY4Vov/TlyG7PNz8+Jqo23wQULNvas4k+EsSLngrHhU=@vger.kernel.org, AJvYcCX1EGfdk9XDaLGcwq4O64y32v/SClQCl6URNZeZG4awy4SxlmO5TpbzvDdMsaoAEju3AAPIeYxCsBQmkpai@vger.kernel.org, AJvYcCXv1nC6VWCSYk7khn8X0EMjbecLrQNoIF2azwxU9EhMT2UHG9Kd3FDJxukrfmEuCnPI9gJje/OvLw3xI88lwvYqRSmk+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTAxzEqy8CsyJDtpTu66SIYX7vMXHvYGioGIY9GNEnYntkgX1u
	12sY2XJxNX4v65vKC89Y9V5g4OHLsI6DFrTMNyVjpgM8e2OvfFb9WLdnOGzpATb7e4nH
X-Gm-Gg: ASbGncvdgKSXE/TqCkZjC57RoknW8GJmeO8y28ZEFiXD7XIoYCjNRvirZziFNQ4CU4S
	JcAZ6TXVbCZtnnd+u+v8+u++x0eouOABSqcgnxMNba+N6OJ870zjhU4na49Gnt5i+TW4ONjQgfn
	mBYq7lvtGs8pKt0TPM9UtO6npqjFW2FPXV8uT/pGpzcJXtrEGfd+Y5KE2B84x1/LnmP+uKwU5UZ
	mr9ryy5lOdoObLjJ0boKxS+HXQyoiLvP+9vBgNh0q8=
X-Google-Smtp-Source: AGHT+IEPr8iaPSgHKsDtMx1pH5avIF3Rej3lFgiK3Oyf8vLucpQfyG31/G0JZeNcPMJvdkZzIEM6Fw==
X-Received: by 2002:a17:90b:3cc6:b0:2ee:aa95:6de9 with SMTP id 98e67ed59e1d1-2f452eed7e1mr41094794a91.33.1735319727649;
        Fri, 27 Dec 2024 09:15:27 -0800 (PST)
Received: from nuvole.. ([2a09:bac1:76a0:dd10::2e9:62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f5227sm138566925ad.185.2024.12.27.09.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2024 09:15:27 -0800 (PST)
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Nikita Travkin <nikita@trvn.ru>,
	Pengyu Luo <mitltlatltl@gmail.com>
Subject: [PATCH 1/5] dt-bindings: platform: Add Huawei Matebook E Go EC
Date: Sat, 28 Dec 2024 01:13:49 +0800
Message-ID: <20241227171353.404432-2-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241227171353.404432-1-mitltlatltl@gmail.com>
References: <20241227171353.404432-1-mitltlatltl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add binding for the EC found in the Huawei Matebook E Go (sc8280xp) and
Huawei Matebook E Go LTE (sc8180x) 2in1 tablet.

Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
---
 .../bindings/platform/huawei,gaokun-ec.yaml   | 116 ++++++++++++++++++
 1 file changed, 116 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/platform/huawei,gaokun-ec.yaml

diff --git a/Documentation/devicetree/bindings/platform/huawei,gaokun-ec.yaml b/Documentation/devicetree/bindings/platform/huawei,gaokun-ec.yaml
new file mode 100644
index 000000000..f5488b57b
--- /dev/null
+++ b/Documentation/devicetree/bindings/platform/huawei,gaokun-ec.yaml
@@ -0,0 +1,116 @@
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
+  Different from other Qualcomm Snapdragon sc8180x sc8280xp based machines,
+  the Huawei Matebook E Go tablets use embedded controllers while others
+  use something called pmic glink which handles battery, UCSI, USB Type-C DP
+  alt mode. Huawei one handles even more, like charging thresholds, FN lock,
+  lid status, HPD events for the USB Type-C DP alt mode, etc.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - huawei,sc8180x-gaokun-ec
+          - huawei,sc8280xp-gaokun-ec
+      - const: huawei,gaokun-ec
+
+  reg:
+    const: 0x38
+
+  interrupts:
+    maxItems: 1
+
+  connector:
+    $ref: /schemas/connector/usb-connector.yaml#
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c15 {
+        clock-frequency = <400000>;
+
+        pinctrl-names = "default";
+        pinctrl-0 = <&i2c15_default>;
+
+        embedded-controller@38 {
+            compatible = "huawei,sc8280xp-gaokun-ec", ""huawei,gaokun-ec";
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
-- 
2.47.1


