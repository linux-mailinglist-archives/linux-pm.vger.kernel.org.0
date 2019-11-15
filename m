Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65025FDD36
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2019 13:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfKOMRn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Nov 2019 07:17:43 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35944 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbfKOMRm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Nov 2019 07:17:42 -0500
Received: by mail-lf1-f66.google.com with SMTP id r14so1231874lff.3
        for <linux-pm@vger.kernel.org>; Fri, 15 Nov 2019 04:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WjYI/X9KhLpPe+dM6Xb8a7TPwu69OizRLxEzrmHuCFU=;
        b=hyyUxA5gdn4bskn0ZMaZCkdLeEDoWoWMTf8lZ7rmIlwT1VoZOGOMEkYbpQqVDgsfBi
         l5z0uzX79gRiW3zEsCJEc3M+x8gocqPrhDjneeMQ/Uxd86EZE4Aijb8x3vRh1pwR0vNA
         01AM7aW2/egNsiFrR/CKmnC5fepi/+H1wYz1XyKwiduIkMmn9Wni8r58C2iVEqXOtRgP
         FygXOrtDOzH8dvxdDcQzk7Nziovb7SggUEVwk06S3/w5oNcRnO7RM1ux/xk+IePLPcbC
         mSbqaMs84yYBmTgdtvOeJv7LxIwOV0v0oZPcmx+TFfHgqECxpSMXBdoKOTOEuoOPRq7z
         Yx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WjYI/X9KhLpPe+dM6Xb8a7TPwu69OizRLxEzrmHuCFU=;
        b=KCCImrjTdHXEigTlxglnEkPnQ2kA7/1QIVSXQ/nNmn1NIXJ078+HKJAncm5AyP9Bt2
         ADvyTIXmt6LEynSsl67z0+yvUig8W/cFB7OhKjrRKo6CzAk2s4qwBsTaP0Ru+3zIOk87
         SAMPDU7pwLmTp2ii71EAZG+D/qQcNYNGhXRZ5FQEiB/t0+SEFFWGhy/SKIuWflUH3Qqx
         WJirB/GopIiuJYtFiNc8mBG3UeGB9nS7Q7ZxNeiMBHP8oDXCaKGldmMHAoQc/GayLkeU
         JSCWtfm/I5KX8pU1YgtNWtdT8KQJE5ek/32a5M1ED8/+etqeoeOoyunvrYf/nMeQtMeG
         INCA==
X-Gm-Message-State: APjAAAX6WKKsRjVn9tGN4ngk7md3H8XiSn/vhrc3g1thn5BbD/DqSe+z
        NOq4NZYBQtzehj7hwgY0kLjZEg==
X-Google-Smtp-Source: APXvYqx9qd14EnMDllQArw8rO5lIJb+BFcYr8n00pdazSp1RmuothxW3F4Wv7Y0suyVvSD5DGLveQg==
X-Received: by 2002:a19:41d7:: with SMTP id o206mr10887081lfa.188.1573820259986;
        Fri, 15 Nov 2019 04:17:39 -0800 (PST)
Received: from centauri.lan (ua-84-217-220-205.bbcust.telenor.se. [84.217.220.205])
        by smtp.gmail.com with ESMTPSA id y18sm4107961lja.12.2019.11.15.04.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 04:17:39 -0800 (PST)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org,
        sboyd@kernel.org, vireshk@kernel.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/5] dt-bindings: power: avs: Add support for CPR (Core Power Reduction)
Date:   Fri, 15 Nov 2019 13:15:38 +0100
Message-Id: <20191115121544.2339036-2-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191115121544.2339036-1-niklas.cassel@linaro.org>
References: <20191115121544.2339036-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add DT bindings to describe the CPR HW found on certain Qualcomm SoCs.

Co-developed-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes since v4:
-Dropped "qcom,*" properties as per review comment from
Stephen Boyd. This is now SoC config data in the driver
that changes based on the SoC compatible string.

 .../bindings/power/avs/qcom,cpr.txt           | 130 ++++++++++++++++++
 1 file changed, 130 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/avs/qcom,cpr.txt

diff --git a/Documentation/devicetree/bindings/power/avs/qcom,cpr.txt b/Documentation/devicetree/bindings/power/avs/qcom,cpr.txt
new file mode 100644
index 000000000000..ab0d5ebbad4e
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/avs/qcom,cpr.txt
@@ -0,0 +1,130 @@
+QCOM CPR (Core Power Reduction)
+
+CPR (Core Power Reduction) is a technology to reduce core power on a CPU
+or other device. Each OPP of a device corresponds to a "corner" that has
+a range of valid voltages for a particular frequency. While the device is
+running at a particular frequency, CPR monitors dynamic factors such as
+temperature, etc. and suggests adjustments to the voltage to save power
+and meet silicon characteristic requirements.
+
+- compatible:
+	Usage: required
+	Value type: <string>
+	Definition: should be "qcom,qcs404-cpr", "qcom,cpr" for qcs404
+
+- reg:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: base address and size of the rbcpr register region
+
+- interrupts:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: should specify the CPR interrupt
+
+- clocks:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: phandle to the reference clock
+
+- clock-names:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "ref"
+
+- vdd-apc-supply:
+	Usage: required
+	Value type: <phandle>
+	Definition: phandle to the vdd-apc-supply regulator
+
+- #power-domain-cells:
+	Usage: required
+	Value type: <u32>
+	Definition: should be 0
+
+- operating-points-v2:
+	Usage: required
+	Value type: <phandle>
+	Definition: A phandle to the OPP table containing the
+		    performance states supported by the CPR
+		    power domain
+
+- acc-syscon:
+	Usage: optional
+	Value type: <phandle>
+	Definition: phandle to syscon for writing ACC settings
+
+- nvmem-cells:
+	Usage: required
+	Value type: <phandle>
+	Definition: phandle to nvmem cells containing the data
+		    that makes up a fuse corner, for each fuse corner.
+		    As well as the CPR fuse revision.
+
+- nvmem-cell-names:
+	Usage: required
+	Value type: <stringlist>
+	Definition: should be "cpr_quotient_offset1", "cpr_quotient_offset2",
+		    "cpr_quotient_offset3", "cpr_init_voltage1",
+		    "cpr_init_voltage2", "cpr_init_voltage3", "cpr_quotient1",
+		    "cpr_quotient2", "cpr_quotient3", "cpr_ring_osc1",
+		    "cpr_ring_osc2", "cpr_ring_osc3", "cpr_fuse_revision"
+		    for qcs404.
+
+Example:
+
+	cpr_opp_table: cpr-opp-table {
+		compatible = "operating-points-v2-qcom-level";
+
+		cpr_opp1: opp1 {
+			opp-level = <1>;
+			qcom,opp-fuse-level = <1>;
+		};
+		cpr_opp2: opp2 {
+			opp-level = <2>;
+			qcom,opp-fuse-level = <2>;
+		};
+		cpr_opp3: opp3 {
+			opp-level = <3>;
+			qcom,opp-fuse-level = <3>;
+		};
+	};
+
+	power-controller@b018000 {
+		compatible = "qcom,qcs404-cpr", "qcom,cpr";
+		reg = <0x0b018000 0x1000>;
+		interrupts = <0 15 IRQ_TYPE_EDGE_RISING>;
+		clocks = <&xo_board>;
+		clock-names = "ref";
+		vdd-apc-supply = <&pms405_s3>;
+		#power-domain-cells = <0>;
+		operating-points-v2 = <&cpr_opp_table>;
+		acc-syscon = <&tcsr>;
+
+		nvmem-cells = <&cpr_efuse_quot_offset1>,
+			<&cpr_efuse_quot_offset2>,
+			<&cpr_efuse_quot_offset3>,
+			<&cpr_efuse_init_voltage1>,
+			<&cpr_efuse_init_voltage2>,
+			<&cpr_efuse_init_voltage3>,
+			<&cpr_efuse_quot1>,
+			<&cpr_efuse_quot2>,
+			<&cpr_efuse_quot3>,
+			<&cpr_efuse_ring1>,
+			<&cpr_efuse_ring2>,
+			<&cpr_efuse_ring3>,
+			<&cpr_efuse_revision>;
+		nvmem-cell-names = "cpr_quotient_offset1",
+			"cpr_quotient_offset2",
+			"cpr_quotient_offset3",
+			"cpr_init_voltage1",
+			"cpr_init_voltage2",
+			"cpr_init_voltage3",
+			"cpr_quotient1",
+			"cpr_quotient2",
+			"cpr_quotient3",
+			"cpr_ring_osc1",
+			"cpr_ring_osc2",
+			"cpr_ring_osc3",
+			"cpr_fuse_revision";
+	};
-- 
2.23.0

