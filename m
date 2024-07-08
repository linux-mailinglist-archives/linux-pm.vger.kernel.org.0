Return-Path: <linux-pm+bounces-10764-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABE592A297
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 14:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50352284796
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 12:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C082C135A79;
	Mon,  8 Jul 2024 12:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y9zNjX6e"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D665132109
	for <linux-pm@vger.kernel.org>; Mon,  8 Jul 2024 12:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720441390; cv=none; b=M6p7psQ1Mk1GnjVNU2EMY8fhGlX+Z4t1qhuyzfZz06Jn5xcWg/niaZ4tLbB6RayjVTLXTRR+l/7lpWAi8NWi04ZW6bJRBQCn8ID/iAhOutRFpDFAoaMIdCKYFODA5eTadMkgoYdIxUsHoZwSYhJRsB+1d2o/RXLyTMDOaKc5wlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720441390; c=relaxed/simple;
	bh=Wmml6hetLnrK6osoIWlLKX4VBPJjFr4OuDi5tTldbY8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QMWli6tMVX9iwos/mx77alwmkydV5mUhQ0M7bA0fIxnqI2nqaqBkpG3NE6q4cQoiQMt6Kr9Ii5Gd4Q/44KTviKcr7DSs4NRA5cfOr3pd8TY78tjwSkNLSeEytGLBXMInQL1qGomDBKv7axhW/UmbBMVjdUzK41WXoYeefk6XVjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y9zNjX6e; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52ea79e689eso3912106e87.1
        for <linux-pm@vger.kernel.org>; Mon, 08 Jul 2024 05:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720441386; x=1721046186; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DE/7eJQHePQ4xKfVi2IWIe5SUccHU+P6ps3RrhqI1kM=;
        b=y9zNjX6edExK4Or8S6OhbN6NwEayf4xdCasA17sX0VzooeJ9KRs59ZQiii/wj3dRMo
         cUL4RXW0oI19RAOrdj3moYAgtSg3CnXKilldR1ST5FBw+syoi9gnRSYCaCwSzlVlT0rd
         7/0c23oO5I1pSrHvLv7ByjMy7ZxXpHVu2ci9wU7n5lbtjxOweK01NzqTGhzL7cfjwWBf
         hhmssQQUpDsKGvvnxUBdVBSm+0pZcLPiyaUGMG6+yP3iHfy/tcCzO0wyn5k6Kvs7GsP+
         263I+a2bSHyMwD3Uc5wS6kbONrKV9aqvupY7mk49FiTJ8ji4qZjlCzbpxqugYfRobIcY
         8xhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720441386; x=1721046186;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DE/7eJQHePQ4xKfVi2IWIe5SUccHU+P6ps3RrhqI1kM=;
        b=DCcokli71A7kgNcduYlvFHjU3CTftF/q8u/XvI85gNzhpdYreO4LsLqjH8cN8Qvx9z
         BBqKLJm9CUDrRru5/ds/ZvdLYgz8MtBRIdNdTaigP//wdFNcjwQQ4idAETpgFtm13Tuo
         l5JlXY0AAJ1Iukb35dm3r6dL5XVlhpWMWaPt9XG6znYQqwQy/unsCgQh6p+K2ymoLtNE
         7/opiEOMTQMO7xcpfcJxIl024c29a0xab6gs9cjpzSzGMHOqgqHH9kcmPMwfZRVlldKR
         0K76lo1Zp5FSS0LoucqPMuMzBdFBzas8OZjuK8ylj+wTmvzUx+xfw51gCFO/yJFh6FUI
         eEBg==
X-Forwarded-Encrypted: i=1; AJvYcCX8EoKRh0lHrN5DGQxYZBsVy+roLpVcH1LjCDwOfL5tJKDZ5jI0fmMNeRokwoHQ4SVEPQiHIwwQXPQsMi0d/AsqVLszFtbdE3s=
X-Gm-Message-State: AOJu0YwkG6HDiSXE+eri/ZW6XJAQrLrRmUDKBRUR6bHXRuHCa5lo/bUS
	WUfmJwJ6cZZX82pmdSw2vgRG4GlqCWlvN8Iz0Nb+VphQFNcoZxDPGvSZ+hxnq8Y=
X-Google-Smtp-Source: AGHT+IFc+McOteL5VPmGxgxqXitDP1GUotcOSNEdtZCvOApgh6hUobyU6tTMLc/kIfASGRM8FH86QQ==
X-Received: by 2002:ac2:5e2a:0:b0:52c:d2ab:693a with SMTP id 2adb3069b0e04-52ea06a673cmr7841846e87.54.1720441385476;
        Mon, 08 Jul 2024 05:23:05 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77e52ccf19sm208983666b.147.2024.07.08.05.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 05:23:05 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 08 Jul 2024 14:22:35 +0200
Subject: [PATCH v15 04/10] dt-bindings: soc: qcom: cpr3: Add bindings for
 CPR3+ driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-topic-cpr3h-v15-4-5bc8b8936489@linaro.org>
References: <20240708-topic-cpr3h-v15-0-5bc8b8936489@linaro.org>
In-Reply-To: <20240708-topic-cpr3h-v15-0-5bc8b8936489@linaro.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Niklas Cassel <nks@flawful.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Robert Marko <robimarko@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, Jeffrey Hugo <quic_jhugo@quicinc.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720441372; l=10110;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=ik8RK9Ie3BviA6NfBk4NawRgtBhRWoEsNL3XFx2OwzU=;
 b=/AkYuekKkq1NvkIP7vtRP+2OUSs1dhl7gPczC+NJQn5b5fPAcypyjqD/BarQLzFnJOT+i72OC
 V0COe4cddCQCoBys2F0B7Wnqmp6gIp7WH3RdPLeOseQAmW8KYKgMkCX
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

Add the bindings for the Qualcomm CPR3+ hardware.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
[Konrad: Make binding check pass, some other changes]
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/soc/qcom/qcom,cpr3.yaml    | 286 +++++++++++++++++++++
 1 file changed, 286 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
new file mode 100644
index 000000000000..2e6712aa1c58
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
@@ -0,0 +1,286 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/qcom/qcom,cpr3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Core Power Reduction v3+
+
+description:
+  CPR (Core Power Reduction) is a technology to reduce core power of a CPU
+  (or another device). Each OPP of a device corresponds to a "corner" that
+  has a range of valid voltages for a particular frequency.
+  The CPR monitors dynamic factors such as temperature, etc. and suggests
+  or (in the CPR-hardened case) applies voltage adjustments to save power
+  and meet silicon characteristic requirements for a given chip unit.
+
+maintainers:
+  - Konrad Dybcio <konradybcio@kernel.org>
+
+properties:
+  compatible:
+    oneOf:
+      - const: qcom,cpr3
+      - const: qcom,cpr4
+      - items:
+          - enum:
+              - qcom,msm8998-cprh
+              - qcom,sdm630-cprh
+          - const: qcom,cprh
+
+  reg:
+    items:
+      - description: Register space of the CPR controller0
+      - description: Register space of the CPR controller1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: CPR reference clock
+
+  vdd-supply:
+    description: Autonomous Phase Control (APC) or other power supply
+
+  '#power-domain-cells':
+    const: 1
+
+  qcom,acc:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to syscon for writing ACC settings
+
+  nvmem-cells:
+    description: Cells containing the fuse corners and revision data
+    maxItems: 32
+
+  nvmem-cell-names:
+    maxItems: 32
+
+  operating-points-v2: true
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - operating-points-v2
+  - "#power-domain-cells"
+  - nvmem-cells
+  - nvmem-cell-names
+
+additionalProperties: false
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,msm8998-cprh
+    then:
+      properties:
+        nvmem-cell-names:
+          items:
+            - const: cpr_speed_bin
+            - const: cpr_fuse_revision
+            - const: cpr0_quotient1
+            - const: cpr0_quotient2
+            - const: cpr0_quotient3
+            - const: cpr0_quotient4
+            - const: cpr0_quotient_offset2
+            - const: cpr0_quotient_offset3
+            - const: cpr0_quotient_offset4
+            - const: cpr0_init_voltage1
+            - const: cpr0_init_voltage2
+            - const: cpr0_init_voltage3
+            - const: cpr0_init_voltage4
+            - const: cpr0_ring_osc1
+            - const: cpr0_ring_osc2
+            - const: cpr0_ring_osc3
+            - const: cpr0_ring_osc4
+            - const: cpr1_quotient1
+            - const: cpr1_quotient2
+            - const: cpr1_quotient3
+            - const: cpr1_quotient4
+            - const: cpr1_quotient_offset2
+            - const: cpr1_quotient_offset3
+            - const: cpr1_quotient_offset4
+            - const: cpr1_init_voltage1
+            - const: cpr1_init_voltage2
+            - const: cpr1_init_voltage3
+            - const: cpr1_init_voltage4
+            - const: cpr1_ring_osc1
+            - const: cpr1_ring_osc2
+            - const: cpr1_ring_osc3
+            - const: cpr1_ring_osc4
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-msm8998.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    cpus {
+        #address-cells = <2>;
+        #size-cells = <0>;
+
+        cpu@0 {
+            compatible = "qcom,kryo280";
+            device_type = "cpu";
+            reg = <0x0 0x0>;
+            operating-points-v2 = <&cpu0_opp_table>;
+            power-domains = <&apc_cprh 0>;
+            power-domain-names = "perf";
+        };
+
+        cpu@100 {
+            compatible = "qcom,kryo280";
+            device_type = "cpu";
+            reg = <0x0 0x100>;
+            operating-points-v2 = <&cpu4_opp_table>;
+            power-domains = <&apc_cprh 1>;
+            power-domain-names = "perf";
+        };
+    };
+
+    cpu0_opp_table: opp-table-cpu0 {
+        compatible = "operating-points-v2";
+        opp-shared;
+
+        opp-1843200000 {
+            opp-hz = /bits/ 64 <1843200000>;
+            required-opps = <&cprh_opp3>;
+        };
+
+        opp-1094400000 {
+            opp-hz = /bits/ 64 <1094400000>;
+            required-opps = <&cprh_opp2>;
+        };
+
+        opp-300000000 {
+            opp-hz = /bits/ 64 <300000000>;
+            required-opps = <&cprh_opp1>;
+        };
+    };
+
+    cpu4_opp_table: opp-table-cpu4 {
+        compatible = "operating-points-v2";
+        opp-shared;
+
+        opp-2208000000 {
+            opp-hz = /bits/ 64 <2208000000>;
+            required-opps = <&cprh_opp3>;
+        };
+
+        opp-1113600000 {
+            opp-hz = /bits/ 64 <1113600000>;
+            required-opps = <&cprh_opp2>;
+        };
+
+        opp-300000000 {
+            opp-hz = /bits/ 64 <300000000>;
+            required-opps = <&cprh_opp1>;
+        };
+    };
+
+    cprh_opp_table: opp-table-cprh {
+        compatible = "operating-points-v2-qcom-level";
+
+        cprh_opp1: opp-1 {
+            opp-level = <1>;
+            qcom,opp-fuse-level = <1>;
+            qcom,opp-cloop-vadj = <0>;
+            qcom,opp-oloop-vadj = <0>;
+        };
+
+        cprh_opp2: opp-2 {
+            opp-level = <2>;
+            qcom,opp-fuse-level = <2>;
+            qcom,opp-cloop-vadj = <0>;
+            qcom,opp-oloop-vadj = <0>;
+        };
+
+        cprh_opp3: opp-3 {
+            opp-level = <3>;
+            qcom,opp-fuse-level = <2 3>;
+            qcom,opp-cloop-vadj = <0>;
+            qcom,opp-oloop-vadj = <0>;
+        };
+    };
+
+    apc_cprh: power-controller@179c8000 {
+        compatible = "qcom,msm8998-cprh", "qcom,cprh";
+        reg = <0x0179c8000 0x4000>, <0x0179c4000 0x4000>;
+        clocks = <&gcc GCC_HMSS_RBCPR_CLK>;
+
+        operating-points-v2 = <&cprh_opp_table>;
+        #power-domain-cells = <1>;
+
+        nvmem-cells = <&cpr_efuse_speedbin>,
+                      <&cpr_fuse_revision>,
+                      <&cpr_quot0_pwrcl>,
+                      <&cpr_quot1_pwrcl>,
+                      <&cpr_quot2_pwrcl>,
+                      <&cpr_quot3_pwrcl>,
+                      <&cpr_quot_offset1_pwrcl>,
+                      <&cpr_quot_offset2_pwrcl>,
+                      <&cpr_quot_offset3_pwrcl>,
+                      <&cpr_init_voltage0_pwrcl>,
+                      <&cpr_init_voltage1_pwrcl>,
+                      <&cpr_init_voltage2_pwrcl>,
+                      <&cpr_init_voltage3_pwrcl>,
+                      <&cpr_ro_sel0_pwrcl>,
+                      <&cpr_ro_sel1_pwrcl>,
+                      <&cpr_ro_sel2_pwrcl>,
+                      <&cpr_ro_sel3_pwrcl>,
+                      <&cpr_quot0_perfcl>,
+                      <&cpr_quot1_perfcl>,
+                      <&cpr_quot2_perfcl>,
+                      <&cpr_quot3_perfcl>,
+                      <&cpr_quot_offset1_perfcl>,
+                      <&cpr_quot_offset2_perfcl>,
+                      <&cpr_quot_offset3_perfcl>,
+                      <&cpr_init_voltage0_perfcl>,
+                      <&cpr_init_voltage1_perfcl>,
+                      <&cpr_init_voltage2_perfcl>,
+                      <&cpr_init_voltage3_perfcl>,
+                      <&cpr_ro_sel0_perfcl>,
+                      <&cpr_ro_sel1_perfcl>,
+                      <&cpr_ro_sel2_perfcl>,
+                      <&cpr_ro_sel3_perfcl>;
+        nvmem-cell-names = "cpr_speed_bin",
+                           "cpr_fuse_revision",
+                           "cpr0_quotient1",
+                           "cpr0_quotient2",
+                           "cpr0_quotient3",
+                           "cpr0_quotient4",
+                           "cpr0_quotient_offset2",
+                           "cpr0_quotient_offset3",
+                           "cpr0_quotient_offset4",
+                           "cpr0_init_voltage1",
+                           "cpr0_init_voltage2",
+                           "cpr0_init_voltage3",
+                           "cpr0_init_voltage4",
+                           "cpr0_ring_osc1",
+                           "cpr0_ring_osc2",
+                           "cpr0_ring_osc3",
+                           "cpr0_ring_osc4",
+                           "cpr1_quotient1",
+                           "cpr1_quotient2",
+                           "cpr1_quotient3",
+                           "cpr1_quotient4",
+                           "cpr1_quotient_offset2",
+                           "cpr1_quotient_offset3",
+                           "cpr1_quotient_offset4",
+                           "cpr1_init_voltage1",
+                           "cpr1_init_voltage2",
+                           "cpr1_init_voltage3",
+                           "cpr1_init_voltage4",
+                           "cpr1_ring_osc1",
+                           "cpr1_ring_osc2",
+                           "cpr1_ring_osc3",
+                           "cpr1_ring_osc4";
+    };
+...

-- 
2.45.2


