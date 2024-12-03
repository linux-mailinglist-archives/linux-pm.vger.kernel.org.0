Return-Path: <linux-pm+bounces-18495-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D7D9E2785
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 17:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFB0716709A
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 16:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAF11F8AC9;
	Tue,  3 Dec 2024 16:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEAaTmAq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA04C1F4707;
	Tue,  3 Dec 2024 16:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733243556; cv=none; b=WcZI1eluVnz3vgDjCudxl87A8r606P0PVx4kfYUlOkAsVctlqaJBDF0OEOadmJUmB/eDXP5WysWj8Cv+URa5IOoSICbCswomIKGCFHHahgycFcJ2NzHyT8ZTjIsv4IwTThzj63UNNdUJyhWwV82GYm6UIcqNyt1n/YSX8tL6yAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733243556; c=relaxed/simple;
	bh=CkYf/8CYcrj8kGmjuOj0GEm6sFuG1+1rLXA4I9CRwRY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LGc7axKxZBp0Cdg2klxE6MF4n4tvxYNcp5y5njSJwPZK6nU3ftxueL7/JBVpvWr2Qbw4IIGEgE/ITRSE2H9t4/WuziVTKJGlIopDaE2zLfr2BnF2DjBPENl0o2pcF0yiRV3G8DkLYmRTw8PXjv2XXgtU1mLRUyFGXdV+ezdzDQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEAaTmAq; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385ed7f6605so1601539f8f.3;
        Tue, 03 Dec 2024 08:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733243553; x=1733848353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B5yY4dZc3x1Tz5DlEul+4inFUgQiQmVpaurubff/PAU=;
        b=YEAaTmAqHQJ2CAc+0BVL9+Y1oL+5TKSiVSxP31LUQ7juWrFMBLrtiu0edgL9LTt4V2
         rI3eiEpeoWlqJVr1PxM1tlvokKv4RczfGqB3/JccHKmmxyHBJxE1IscG/cPRIoJz38G4
         In9Mlr9p5ZTb/l3NWh8P9YvXxKML7UKnW5EkY6C5D3hJwZR7oPpyCBxEDMqbr9VtV+sp
         42ZYSfNvEDuhRFNToHjbi9aXG84O5tm4+EMOwYmsBZQxGCL/8JT3iaE0RGUTSlnWBz9J
         cxDnRff+/rBb8dTJM0Ilu1MR1e+kTHyd1AKiB8P32roZ1MsqzAf7xCIwKVFlIN+o26By
         setQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733243553; x=1733848353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B5yY4dZc3x1Tz5DlEul+4inFUgQiQmVpaurubff/PAU=;
        b=guLEzHSlOorMbc+B8RcsCghQ1im9qkn3USZLBwJik+J7CHKoeEC7rViQx/NOQPRXg2
         rlJl3i3iddrhfKY0LqSPXu1RBVWqQbHzST4LQMfSxfEplngcvoR6+hQendIrbFe0pEtG
         0NoVG1mRHXRZZshvVrlqsgbQnJOmJKn60pPuH4Nlk4qPrsuhbJ1KJbvyY+GvcUVskR01
         QdakpE1IceduT0unZrqvSIVmzNloVrYRUmW8s8WQIjjQPPE6jSsJf9R5Sx3zytTHKs7/
         sderzayHCCY8TTiWdOMquKHs3ofKWZI8tptPn8qHaRh0YvuOJZ9ixY97Lk06eUFkoqtD
         +bVg==
X-Forwarded-Encrypted: i=1; AJvYcCU+xs+PNPGu3bvqN5cJf2Eul2XlqmX6AM1vuczje0smKFAMeZ60v+UgqbxAS4HZbz23M04E3h+7rLpR@vger.kernel.org, AJvYcCVgmT9F3SBlGHE57d0QfVf4Fb2iQ80SR27sbV+hJcy4+bd2gKpYHnNvtzFB6xAZSDZeUZ9nSz9derHH7Br9@vger.kernel.org, AJvYcCXN0Tzj0lkEQvFVC77tDrrkUURKQj6DnqTkY2UFOKXaSKDE8UlbA7P6oO68QKBNI+tnnx9AsVIP+u4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlm2BMtMc5jtA2LM/M8ukT5mwsY+O8QLNGqDnbmbm2kekoGjeT
	ULto+xzKuUjnJfDYDp7c+6AF6lgUmgafLiEvmbhFPvu58CKV9utwh6npKQ==
X-Gm-Gg: ASbGncsVXEiGK725q9mvt8ZvC9LWQSdAfI44MDMsmRcZMH+pcAy/FPL/p3ApRX7Raxy
	cBiHpvGbO6Jn8CpQkcGae3PjDxO7c/IqyU1on/MrTQenbAtbU7uPpsSMnHS1xCOY6fYv65cmqKt
	pP9XSZ8EDWE5XDKlMlp8/OQR2+uw6a+bduSSwI1tjpzzDMwkLpkrNnJSlGAhTvZ5lfCkIBK2VoT
	P4Y8d7tSMH7HjR3OYqxHhqlJHOGFU91gBpOralRDVQdiTqyZnwFgmR/lWCCL1LoEEaD2dMlKqMX
	kbBs1djWS1vAERcqnGI=
X-Google-Smtp-Source: AGHT+IFFpuWxZaS4cfA4xIg4GaMRLeVJzqm/WbgfIJZ8DTffUl2opgftKsOWkLa/rdZHNV1CXm7ByQ==
X-Received: by 2002:a05:6000:1acd:b0:385:de67:2297 with SMTP id ffacd0b85a97d-385fd532bdcmr2408472f8f.54.1733243552663;
        Tue, 03 Dec 2024 08:32:32 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-434d43a100csm2707655e9.1.2024.12.03.08.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 08:32:32 -0800 (PST)
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
Subject: [PATCH v5 1/2] dt-bindings: cpufreq: Document support for Airoha EN7581 CPUFreq
Date: Tue,  3 Dec 2024 17:31:49 +0100
Message-ID: <20241203163158.580-1-ansuelsmth@gmail.com>
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


