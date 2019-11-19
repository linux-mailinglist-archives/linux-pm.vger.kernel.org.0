Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40E97102873
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2019 16:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbfKSPqk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Nov 2019 10:46:40 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35367 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728444AbfKSPq2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Nov 2019 10:46:28 -0500
Received: by mail-lf1-f67.google.com with SMTP id q28so3520482lfp.2
        for <linux-pm@vger.kernel.org>; Tue, 19 Nov 2019 07:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m7ifa4GadNMb+2byfdvLDxSqR7+zM2gWhgPAPeu92tc=;
        b=DG/8NtC0hi0+3I00Qm6wjNor789XyXnyK4oaKz424MVTpwcgUZL7rVPxyiwBvt196C
         vPoU6ZTDHQqgQTlGpQi7HZI9iQ9CKdrO2vinD4z/wLAv8SD7wf84EKgc7lDt4xHY+2Mu
         lZoQ1H4X8/Xjv5mhoPuvEGEEcy6yM+qHT6qN7KhuBtGI6Npdsz4XhndJlZzc1NfGuIga
         92P1Btup/es4Aod6zec+3/mX9mzySHYO9mqL7ZdveNLCBKMVArRBzXzMI6hLqmFx6fXH
         eJ7DIq0+oAqQUeKEfIQ6kDZ5EQ9XDGJO9dbdERNrslmU0QJaWSa0d+b7khIZoIVcRzax
         3b+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m7ifa4GadNMb+2byfdvLDxSqR7+zM2gWhgPAPeu92tc=;
        b=kHnJrcT04gCMN5FkuL7Wk3hYdK355R1UJBA9JNMbem1zQReosvqxCdK+DtmxnaNfmV
         guQR9W7mJOYaL+fdGT92KxUEEJ+KorTav9VgVjkFUVfVAj523nuuhAbtcn2cNd+1z7B7
         xZPyL5mOnIHTgTDG7dq4WYPGKpf8t26q3Kn0shaoCEsHsoXPbNSCLL9MXnVcXaXdhgqf
         WJg61+GeD7ddm8bu37YI/8rlexV27A6/r/w7hV9JqFUdu0e6sBv0AbdnDL/4r5eSUtc0
         7TQffhc6lNgYANnIyi+yVVIKf1vCMhrg4+VTyX2r3UH+goj0WUsiE1P+P1CS24BcwwJs
         3Jcg==
X-Gm-Message-State: APjAAAUhT9clsGz1dildwTgTEbUAXX6TiCk7R0JYtrC8sOjHu/geLzVk
        JSaIdv/7NCTdnIgerhghrGmmRQ==
X-Google-Smtp-Source: APXvYqxK9IHjk8CGsSTT+jX6XS5SLjDe3LY4wDQaBzA9GQBGP5/Wcdk/Pd4xX9vU5dTIhB+SOdAy9g==
X-Received: by 2002:a19:cc16:: with SMTP id c22mr4578097lfg.41.1574178385392;
        Tue, 19 Nov 2019 07:46:25 -0800 (PST)
Received: from centauri.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id v10sm9886281ljc.6.2019.11.19.07.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 07:46:24 -0800 (PST)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org,
        sboyd@kernel.org, vireshk@kernel.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/5] dt-bindings: power: avs: Add support for CPR (Core Power Reduction)
Date:   Tue, 19 Nov 2019 16:46:16 +0100
Message-Id: <20191119154621.55341-2-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191119154621.55341-1-niklas.cassel@linaro.org>
References: <20191119154621.55341-1-niklas.cassel@linaro.org>
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
Changes since v5:
-None

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

