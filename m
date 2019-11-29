Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A52F10DB2F
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2019 22:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfK2Vj0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Nov 2019 16:39:26 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41124 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbfK2VjY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Nov 2019 16:39:24 -0500
Received: by mail-lj1-f196.google.com with SMTP id m4so33293131ljj.8
        for <linux-pm@vger.kernel.org>; Fri, 29 Nov 2019 13:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CtdLO3BiiDckbba/jOWuHZ5pqirfCEByMIQAzPx8214=;
        b=BavR3UpTHnmbsDK2KKPSRwZ1J4zVQ4D9SJo7FVC2DWk/t6FLi/mkuWgkmBB1qTQ5yh
         +1SDnUN3O+XZwOp1TqgmEnxDp7+txVWorIAYaY4vntKki6gAV7rfIQ9zzyCpoGEESFzR
         DyTjAno3NjZfg3Msn2RebkvTRE+YCRtr9DSya5bGCcoyH+P0UkUKDJdxxbpnXz65b147
         SeEjCiBa3XuWIU/ahYSBiJHpsq0n74aLjsDjdHzdqNGjtgrMx403HBUiIZYq345g4ivC
         OM4hDXN+Ugh92XtVX0NheTKs/ZDQt1AHsZL0CNvlrJoeXoV4p93bdwbKxi/HdOvhmfVb
         oWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CtdLO3BiiDckbba/jOWuHZ5pqirfCEByMIQAzPx8214=;
        b=Rc6Dr+zO/+VzB7Clfp0sK9wGyS6D272Z6XwPlWV/B/YS/m0nB97RFgdhHfEtA2C4Ip
         TMb4C/+I3hlb2wArqmKHRL4h0u9tMKwYCpX4rdLYKdNez4vLI+pEfa+nNY2+jJ742ib6
         D3LgYfwmCaic9VJh9uo37i3/6RTelTZ2Al5whDnxHySEtQpbUoktiCSBH3ob97PckP8m
         lyOTt+JN3kY5fr9hmjuIRUu81vV/Q8m+xnUcwaksjSUHLvt7uM/prvVE/YAfCEX1OLiH
         e+bEJ3gEjwlhZdzO030O6kohnT28hL2ieQTvIUmxAC8+rEkYWWkw6uRyag0CR8uItM5L
         cNrQ==
X-Gm-Message-State: APjAAAUjN7i3W1SiHAkUwAie5lhHCQmbAjNwESD7v4O9iS7/ox7s9HPk
        UbWPP2HsHA/Nk9G8T1J9YhEvVA==
X-Google-Smtp-Source: APXvYqyqblJ2FJP/SevCJojPYdPTRR326gd3foy65sWXVr9DxWlG3H9Luhg3u5z/v0JPV6hE/GfQQQ==
X-Received: by 2002:a2e:a304:: with SMTP id l4mr38293021lje.178.1575063562136;
        Fri, 29 Nov 2019 13:39:22 -0800 (PST)
Received: from centauri.lan (ua-84-217-220-205.bbcust.telenor.se. [84.217.220.205])
        by smtp.gmail.com with ESMTPSA id b190sm10742234lfd.39.2019.11.29.13.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 13:39:21 -0800 (PST)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Niklas Cassel <nks@flawful.org>
Cc:     linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org,
        sboyd@kernel.org, vireshk@kernel.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, Niklas Cassel <niklas.cassel@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/5] dt-bindings: power: avs: Add support for CPR (Core Power Reduction)
Date:   Fri, 29 Nov 2019 22:39:11 +0100
Message-Id: <20191129213917.1301110-2-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191129213917.1301110-1-niklas.cassel@linaro.org>
References: <20191129213917.1301110-1-niklas.cassel@linaro.org>
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
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
Changes since v6:
-Picked up Bjorn's and Ulf's Reviewed-by.

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

