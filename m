Return-Path: <linux-pm+bounces-18358-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 352DA9E06B8
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 16:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA07D2816A3
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 15:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9151D20B80B;
	Mon,  2 Dec 2024 15:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtMKtyhi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7B6208961;
	Mon,  2 Dec 2024 15:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733152391; cv=none; b=Mj1l4Z279fO5xpQpejVNGqFpaVLN9TzDf2C2bS8xWoO09pCxpr6TWffaVdGedl+3hWXHK3qyHT90KtTS3pSpgneMXvmUST2RrGcDJxITanQiTmRicdr3l7LhNG3RPrUoGn5MEhjnvAQAQv4j2eha19n15f1aVo5Qh5dUyCKrb2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733152391; c=relaxed/simple;
	bh=0+85hBsAAVyBCsqJMbxTet713CTzVnDYnspM4mprZaw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gDlvupHK0ROizjsBiKzg+a0DjdXX4qwyd+Bh/xZZ7akmwtGB8wH3EqImqqK28ThKhK1k/HOGHXRzeTT8gnxxc/QWZwTB3ENIh0Y1FPIa5egLnBn76lgo1BfzpH00oWTAGykPsVnn7RtYFyy1CrusTHjwqoexHS6OfDPR9kReeiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtMKtyhi; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434a766b475so40467065e9.1;
        Mon, 02 Dec 2024 07:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733152388; x=1733757188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RYDk8+MRGMFot5WQw/bRG5y608If/PrmSuOwHf+c1F0=;
        b=DtMKtyhibFIwUplxtN8ykOk67r46bBN0tcQ2A+ixX2ijQjb1xJsYqba8+sRqo7yICp
         jwUmANeT4QcRhlWELJSq/0WdO0M1Heb2sj7LuiMzVpZqLHihin6vyfbqmj78nasp+R6H
         elC+TASNTR7jpJjauGJ4jeYuiiix25LdSQCiCC2yQWtUssPnvNjQCUA5998VG4TY2pGv
         VIMc7Os6B549bXZBZNXOKVLRIX1seMyS5jKdCkCSsB8c2xQZcJrQi+4qa2zcRwe7fhqc
         fxHyaXFxs1My93ngIr7a78Qin6W+oNJXEDp/JcYrtepQuKe9DMWxSpyvTd4oFqDIIMT7
         /nRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733152388; x=1733757188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RYDk8+MRGMFot5WQw/bRG5y608If/PrmSuOwHf+c1F0=;
        b=Skp6VQIo4l+Hvi57B+1lFxMDEIN+cyqIn3pEfUUZsYJS1ahbQ5GhcbeF+QsHsz6X02
         PZQ1GegJNUerMuqJ4ZR3fH5a9IgibFQy+3i0nlBtZVg0ulplRZ/LojQzPyewAeeYCIvC
         r+ZzC/90Nz8frbseCKrdemL8O79snxdicrSpxWYRLcdamqKLTrV140dsNBUlH1pNVvWh
         +I4raE3PMmtk4nwMUTZBjHKf956efdcldy4MLZ5lsqZqjwE2i4P9bvNeZuglYcMBoFLS
         e7zlHbzZkdXECW5jVBwl60bJcQ7X2lrTzoFUPzt8TIClVfAewkhpf0H0Q+9LMI4r3tGQ
         zfHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVL6IBW2kCnJ/aSH/wrJnTDemDRxUemWbMZzSmw8b/iXp1ZckYVIAkHmz9LAbj2YRrBEMtTmt14zfrt@vger.kernel.org, AJvYcCWK6RGDE6Eja0RD38YLqImyZa7JVAOiQzNK3MGJB3eKuJLbX4ArcrptgHVBgIweGRSbNvtJdCvJfco=@vger.kernel.org, AJvYcCXirdae7hsSztHQoPpWkhUCr6s+FcixbuUKQqhdq0GqVQnmKaD1i8mVJJq3FIrEnvt6X7PbtoEN8fiG0/gw@vger.kernel.org
X-Gm-Message-State: AOJu0YwnOS7v7LzDTcM2WUg9eetYO5hQWV/+K+bCwAvNUtU2qrlY7ydd
	uKplCF7BaX52nYI7K2zuFFVRDxaxMKGTjqXAUcG3rnOZzE6Jn7xR
X-Gm-Gg: ASbGncv7UVmY+qqyMsm7HWX7V1wU6KXFypQfGmRhM7aXiIqXThvVEZJNyAIBgVs1s9C
	6tx8E8Q3PbYVr2rWe5kkwuaL9t1u3b243SWzYTv3oJ65trJ1zuYC8Nq1zd71s3RVNiAOH01HV35
	qTyzjyZvFuCpTAVnIyNyhZKEqCz4EhZ6e/I3LqGNCorbXku8pscmrrelCHDyrtJNimZo8HraHyV
	YKW/6EszNhr+G3TLMZunzl4MoL1a6WZzbSrLH8kXvq+D6gxjAJbWA+Nu/yT2tt6AYQM0BUz9bzN
	5vzwc3YfnswCTMcr+T0=
X-Google-Smtp-Source: AGHT+IE1U7sBAbgplQQZM/NpKK/dDqbCgKJKJFAWXW9mxeLyED8xIdSV4Z6b4BHwnT/6UbguGw2IxA==
X-Received: by 2002:a05:600c:458b:b0:431:5f1c:8359 with SMTP id 5b1f17b1804b1-434a9dcfd5emr218795755e9.15.1733152384193;
        Mon, 02 Dec 2024 07:13:04 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-434b0dc6831sm154173915e9.20.2024.12.02.07.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 07:13:03 -0800 (PST)
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
Subject: [PATCH v4 1/2] dt-bindings: cpufreq: Document support for Airoha EN7581 CPUFreq
Date: Mon,  2 Dec 2024 16:12:03 +0100
Message-ID: <20241202151228.32609-1-ansuelsmth@gmail.com>
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
---
Changes v4:
- Add this patch

 .../cpufreq/airoha,en7581-cpufreq.yaml        | 259 ++++++++++++++++++
 1 file changed, 259 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml

diff --git a/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml b/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml
new file mode 100644
index 000000000000..a5bdea7f34b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml
@@ -0,0 +1,259 @@
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
+                clocks = <&cpufreq>;
+                clock-names = "cpu";
+                power-domains = <&cpufreq>;
+                power-domain-names = "cpu_pd";
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
+                clocks = <&cpufreq>;
+                clock-names = "cpu";
+                power-domains = <&cpufreq>;
+                power-domain-names = "cpu_pd";
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
+                clocks = <&cpufreq>;
+                clock-names = "cpu";
+                power-domains = <&cpufreq>;
+                power-domain-names = "cpu_pd";
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
+                clocks = <&cpufreq>;
+                clock-names = "cpu";
+                power-domains = <&cpufreq>;
+                power-domain-names = "cpu_pd";
+                next-level-cache = <&l2>;
+                #cooling-cells = <2>;
+            };
+        };
+
+        cpu_opp_table: opp-table {
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
+        cpu_smcc_opp_table: opp-table-cpu-smcc {
+            compatible = "operating-points-v2";
+
+            smcc_opp0: opp0 {
+               opp-level = <0>;
+            };
+
+            smcc_opp1: opp1 {
+                opp-level = <1>;
+            };
+
+            smcc_opp2: opp2 {
+               opp-level = <2>;
+            };
+
+            smcc_opp3: opp3 {
+               opp-level = <3>;
+            };
+
+            smcc_opp4: opp4 {
+                opp-level = <4>;
+            };
+
+            smcc_opp5: opp5 {
+                opp-level = <5>;
+            };
+
+            smcc_opp6: opp6 {
+               opp-level = <6>;
+            };
+
+            smcc_opp7: opp7 {
+               opp-level = <7>;
+            };
+
+            smcc_opp8: opp8 {
+                opp-level = <8>;
+            };
+
+            smcc_opp9: opp9 {
+               opp-level = <9>;
+            };
+
+            smcc_opp10: opp10 {
+                opp-level = <10>;
+            };
+
+            smcc_opp11: opp11 {
+                opp-level = <11>;
+            };
+
+            smcc_opp12: opp12 {
+                opp-level = <12>;
+            };
+
+            smcc_opp13: opp13 {
+                opp-level = <13>;
+            };
+
+            smcc_opp14: opp14 {
+                opp-level = <14>;
+            };
+        };
+
+        cpufreq: cpufreq {
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


