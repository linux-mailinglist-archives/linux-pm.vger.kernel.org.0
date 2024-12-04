Return-Path: <linux-pm+bounces-18564-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2C99E4340
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 19:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 111F228213E
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 18:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C731A8F63;
	Wed,  4 Dec 2024 18:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2DeQ2Sg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F60C23918A;
	Wed,  4 Dec 2024 18:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733336669; cv=none; b=FhPfgxe2Jmoq9WjuFhEBQDs/z6OUA+cKp0kQIokC2SZVF9U+IpHRw2SyUvJZw9p2fqiAWZ53BEFrjhieliM5F/2sDVDbPug9OTnprIRXzpTwZdYmNDYPpoQsL1B6/xOPDbL3fKhoWNvvg1twoFnny7ShR8eyGHJODK+MF78dbNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733336669; c=relaxed/simple;
	bh=teJRNRfgc7cCnnMda3u8EJ6wNHFQis7Us4Eb0BdYAAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BKVIdVCyQlEPQCvnx6fdz4ZyRWmt5zohotboe3mdrzPSIEgBAlKdViRTOeeJvdbVdyAZ4cWeD0T6ICL6gDMaXqq5QrvtgMpfzdnhFRFDnbJlP7x8zxEPrMoTazAvo0YCdY4ZvG/rrOuNtBI57z94MyyBgAgsmtH73wEOK17PoTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2DeQ2Sg; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434b3e32e9dso890585e9.2;
        Wed, 04 Dec 2024 10:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733336665; x=1733941465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3UUdwfZQXeX07W4hYCOQ3ZxpgjLymP9Agnpc8RD0pck=;
        b=g2DeQ2SgqgjVh9DaG3SZldOOc+UJsIcAz6k3xTwXsrSXm5HF+lMekMP8gV+Vvg6Gld
         7+1b23sBP7e8H52iUfi97vVly3NwNZMugy3nqWPwx5fphn9rl3i/VSiFR/2UXc11bzfh
         JTMjGm1DlRdMPbqZ7pl+7//kxyUDHoy0+cj+p5NX36RQoNgZTKKhGg54KrOgcAk2BagV
         84y/CH4ctY8BaHKj6urcpmgsRBuwRL3T1Cojz0DR0CWCv8y4g+Stg17L7t2Q2LkELmvR
         e25/ZJrvrauHRTLjiFJPwBfK53bJQi0BJugaV2s45UEcIDZ7jRTGLGkbaMI4pToWAT9t
         uDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733336665; x=1733941465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3UUdwfZQXeX07W4hYCOQ3ZxpgjLymP9Agnpc8RD0pck=;
        b=CL4VZtv4HQ+S3OzALieGQHbFPyiXZg/YY1ed70hBWNfbsA8aPjMK7MOcKv4GxnXQux
         cHwNRVu+2+/hRsbR6K52oa29lymUzPwk9yp2z/wpM7rnV8A3JGiHxkwQDrJZGO1UAO7Y
         4IO4HhpIgjvLEDuJEBJPZ71sPthHuUIvaQAa4WPRqctU7ZzIFMmTHytJXUpHO3WKcQtN
         AI5x/PgA69a+yXMv5N/sNmfklfChxDXRX+9oXsarR9V1LvktuoDuOzG7NxoWfC6nnNKZ
         CD4PxoZguBqh6AwzAFNFUjNz2KULM73BLIr9lDvq8xl4f9SYf0YmWII+FUeVHsVR6Rst
         WXrQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2gl3goZMDxdwYl0LbxNiyP04+h+vcR/xsdQuJn7ZvtWST5POEiOBPMmYGENY3B1L2s0zWIzVN/3s=@vger.kernel.org, AJvYcCX0nNqymtdwg2ms8TE77yo3iWFdYFjUq6OrotrretsH0h+EBN7sgF8fX1sVr2ieCSsaeJFBTWyZv0TfbQ2Q@vger.kernel.org, AJvYcCXpHL+rTmyaOG12vM7RoHwermkHYqI7ppjGYzoU8GLWyvImZdpyZAGu6hoDlXzx/UIRPd93ltmPVNv8@vger.kernel.org
X-Gm-Message-State: AOJu0YytrK6DIg+eaVGXySRPbbGtWfPfZ+ctJo/i9Uzoms4wLEvX6fdG
	GUb6nXRWWIOTbGvunGCz2l5H6beXyVjWPvELNM+YIVBt+Kr3kjM6
X-Gm-Gg: ASbGncu8e1Nn6XBlhLbjK9jP8CvDOLKNQyVCdFVad3OLRfnA1rEAeYg7/UK61eoJu2H
	8GNd8GV/VP0ijAcDuOZy/x3Ja7CSkGLw/cuE/G0Q6QJ+8PGWOxQQEfC+4dD/vKIFAfnRKBm09Cq
	03GrnELEQlUic1tjYJ7tWkiiSF/+Buw0CyDiVFF+swPm5a4TF2+lxrpjF7vVCHm8sEBkqnbHtl1
	lOv8LSMPIb7Vtaq0FKJ9ebzqMNlxZdpaK7GQcTZTA6Z8YuBM+3n3b9ztk3BgUUusJcn3oh5mfuY
	oe6fmk1WkV0bo8C+9gs=
X-Google-Smtp-Source: AGHT+IGxPvq6WXUU8aqpA1mC5eIU9alMNZ9Wu5khh0vS0NiLfPaQigkG6g8AFJABgP9jFPcyF/szpg==
X-Received: by 2002:a05:600c:3c99:b0:431:157a:986e with SMTP id 5b1f17b1804b1-434d0a03387mr59204645e9.20.1733336665329;
        Wed, 04 Dec 2024 10:24:25 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-434d527f5d2sm32861855e9.17.2024.12.04.10.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 10:24:24 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@airoha.com
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v6 1/2] dt-bindings: cpufreq: Document support for Airoha EN7581 CPUFreq
Date: Wed,  4 Dec 2024 19:23:09 +0100
Message-ID: <20241204182323.15192-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document required property for Airoha EN7581 CPUFreq .

On newer Airoha SoC, CPU Frequency is scaled indirectly with SMCCC commands
to ATF and no clocks are exposed to the OS.

The SoC have performance state described by ID for each OPP, for this a
Power Domain is used that sets the performance state ID according to the
required OPPs defined in the CPU OPP tables.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
Changes v6:
- No changes
Changes v5:
- Add Reviewed-by tag
- Fix OPP node name error
- Rename cpufreq node name to power-domain
- Rename CPU node power domain name to perf
- Add model and compatible to example
Changes v4:
- Add this patch

 .../cpufreq/airoha,en7581-cpufreq.yaml        | 262 ++++++++++++++++++
 1 file changed, 262 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml

diff --git a/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml b/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml
new file mode 100644
index 000000000000..7e36fa037e4b
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml
@@ -0,0 +1,262 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/cpufreq/airoha,en7581-cpufreq.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha EN7581 CPUFreq
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description: |
+  On newer Airoha SoC, CPU Frequency is scaled indirectly with SMCCC commands
+  to ATF and no clocks are exposed to the OS.
+
+  The SoC have performance state described by ID for each OPP, for this a
+  Power Domain is used that sets the performance state ID according to the
+  required OPPs defined in the CPU OPP tables.
+
+properties:
+  compatible:
+    const: airoha,en7581-cpufreq
+
+  '#clock-cells':
+    const: 0
+
+  '#power-domain-cells':
+    const: 0
+
+  operating-points-v2: true
+
+required:
+  - compatible
+  - '#clock-cells'
+  - '#power-domain-cells'
+  - operating-points-v2
+
+additionalProperties: false
+
+examples:
+  - |
+    / {
+        model = "Airoha EN7581 Evaluation Board";
+        compatible = "airoha,en7581-evb", "airoha,en7581";
+
+        #address-cells = <2>;
+      	#size-cells = <2>;
+
+        cpus {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            cpu0: cpu@0 {
+                device_type = "cpu";
+                compatible = "arm,cortex-a53";
+                reg = <0x0>;
+                operating-points-v2 = <&cpu_opp_table>;
+                enable-method = "psci";
+                clocks = <&cpu_pd>;
+                clock-names = "cpu";
+                power-domains = <&cpu_pd>;
+                power-domain-names = "perf";
+                next-level-cache = <&l2>;
+                #cooling-cells = <2>;
+            };
+
+            cpu1: cpu@1 {
+                device_type = "cpu";
+                compatible = "arm,cortex-a53";
+                reg = <0x1>;
+                operating-points-v2 = <&cpu_opp_table>;
+                enable-method = "psci";
+                clocks = <&cpu_pd>;
+                clock-names = "cpu";
+                power-domains = <&cpu_pd>;
+                power-domain-names = "perf";
+                next-level-cache = <&l2>;
+                #cooling-cells = <2>;
+            };
+
+            cpu2: cpu@2 {
+                device_type = "cpu";
+                compatible = "arm,cortex-a53";
+                reg = <0x2>;
+                operating-points-v2 = <&cpu_opp_table>;
+                enable-method = "psci";
+                clocks = <&cpu_pd>;
+                clock-names = "cpu";
+                power-domains = <&cpu_pd>;
+                power-domain-names = "perf";
+                next-level-cache = <&l2>;
+                #cooling-cells = <2>;
+            };
+
+            cpu3: cpu@3 {
+                device_type = "cpu";
+                compatible = "arm,cortex-a53";
+                reg = <0x3>;
+                operating-points-v2 = <&cpu_opp_table>;
+                enable-method = "psci";
+                clocks = <&cpu_pd>;
+                clock-names = "cpu";
+                power-domains = <&cpu_pd>;
+                power-domain-names = "perf";
+                next-level-cache = <&l2>;
+                #cooling-cells = <2>;
+            };
+        };
+
+        cpu_opp_table: opp-table-cpu {
+            compatible = "operating-points-v2";
+            opp-shared;
+
+            opp-500000000 {
+                opp-hz = /bits/ 64 <500000000>;
+                required-opps = <&smcc_opp0>;
+            };
+
+            opp-550000000 {
+                opp-hz = /bits/ 64 <550000000>;
+                required-opps = <&smcc_opp1>;
+            };
+
+            opp-600000000 {
+                opp-hz = /bits/ 64 <600000000>;
+                required-opps = <&smcc_opp2>;
+            };
+
+            opp-650000000 {
+                opp-hz = /bits/ 64 <650000000>;
+                required-opps = <&smcc_opp3>;
+            };
+
+            opp-7000000000 {
+                opp-hz = /bits/ 64 <700000000>;
+                required-opps = <&smcc_opp4>;
+            };
+
+            opp-7500000000 {
+                opp-hz = /bits/ 64 <750000000>;
+                required-opps = <&smcc_opp5>;
+            };
+
+            opp-8000000000 {
+                opp-hz = /bits/ 64 <800000000>;
+                required-opps = <&smcc_opp6>;
+            };
+
+            opp-8500000000 {
+                opp-hz = /bits/ 64 <850000000>;
+                required-opps = <&smcc_opp7>;
+            };
+
+            opp-9000000000 {
+                opp-hz = /bits/ 64 <900000000>;
+                required-opps = <&smcc_opp8>;
+            };
+
+            opp-9500000000 {
+                opp-hz = /bits/ 64 <950000000>;
+                required-opps = <&smcc_opp9>;
+            };
+
+            opp-10000000000 {
+                opp-hz = /bits/ 64 <1000000000>;
+                required-opps = <&smcc_opp10>;
+            };
+
+            opp-10500000000 {
+                opp-hz = /bits/ 64 <1050000000>;
+                required-opps = <&smcc_opp11>;
+            };
+
+            opp-11000000000 {
+                opp-hz = /bits/ 64 <1100000000>;
+                required-opps = <&smcc_opp12>;
+            };
+
+            opp-11500000000 {
+                opp-hz = /bits/ 64 <1150000000>;
+                required-opps = <&smcc_opp13>;
+            };
+
+            opp-12000000000 {
+                opp-hz = /bits/ 64 <1200000000>;
+                required-opps = <&smcc_opp14>;
+            };
+        };
+
+        cpu_smcc_opp_table: opp-table-smcc {
+            compatible = "operating-points-v2";
+
+            smcc_opp0: opp-0 {
+               opp-level = <0>;
+            };
+
+            smcc_opp1: opp-1 {
+                opp-level = <1>;
+            };
+
+            smcc_opp2: opp-2 {
+               opp-level = <2>;
+            };
+
+            smcc_opp3: opp-3 {
+               opp-level = <3>;
+            };
+
+            smcc_opp4: opp-4 {
+                opp-level = <4>;
+            };
+
+            smcc_opp5: opp-5 {
+                opp-level = <5>;
+            };
+
+            smcc_opp6: opp-6 {
+               opp-level = <6>;
+            };
+
+            smcc_opp7: opp-7 {
+               opp-level = <7>;
+            };
+
+            smcc_opp8: opp-8 {
+                opp-level = <8>;
+            };
+
+            smcc_opp9: opp-9 {
+               opp-level = <9>;
+            };
+
+            smcc_opp10: opp-10 {
+                opp-level = <10>;
+            };
+
+            smcc_opp11: opp-11 {
+                opp-level = <11>;
+            };
+
+            smcc_opp12: opp-12 {
+                opp-level = <12>;
+            };
+
+            smcc_opp13: opp-13 {
+                opp-level = <13>;
+            };
+
+            smcc_opp14: opp-14 {
+                opp-level = <14>;
+            };
+        };
+
+        cpu_pd: power-domain {
+            compatible = "airoha,en7581-cpufreq";
+
+            operating-points-v2 = <&cpu_smcc_opp_table>;
+
+            #power-domain-cells = <0>;
+            #clock-cells = <0>;
+        };
+    };
-- 
2.45.2


