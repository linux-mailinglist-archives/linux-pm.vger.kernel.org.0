Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1D14603A3
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2019 11:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbfGEJ6v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jul 2019 05:58:51 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41026 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728431AbfGEJ6v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jul 2019 05:58:51 -0400
Received: by mail-lf1-f65.google.com with SMTP id 62so5940830lfa.8
        for <linux-pm@vger.kernel.org>; Fri, 05 Jul 2019 02:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BouLqQLTHVtW6gFNYbo0Duh1Donpb8dO1sfN++w1gqU=;
        b=eOccLffmHigtjDuidT0JUO5zFObHn2WpwcWTuU72p0WEJ2F32za6U/ywDevYSzdSpz
         vYKgDSFPO7O6Jf3MeaCgP/S9Aejb5L28A8tElumX/rJiPrQ9b5PBgQ4s873/Bg7vTnj2
         i7P2yfv6c6SQr6Q7uGBpObvLBErMaqGHpeudyBS2/vljXpRHKWSDwUb9qQUzlPKHDF48
         +mt34SXz7xsgOeZQEPwOCn9UXzNVqkxrg3ul2P3VXHjgTYbR9IQzJRJDvxU7lz8RODW5
         JuONCzE44IK0ED0Z6Vopbd9bej2zo2qPbyn5LD5do4YsP8LjHBJXO/QhOzYzvxWQ59EX
         kb7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BouLqQLTHVtW6gFNYbo0Duh1Donpb8dO1sfN++w1gqU=;
        b=EWxTgLAnenQkyHgsKcfttBhEy6onWPmYA1NY8ew3VXskaoJjpjDynBAIGPfUT8IU3e
         eHOH69N9E7jmRpNQgF28miTavq4TBa4onqhZzeyK8gguykv8sKiEJFPqMhF4838pbCMr
         KzsTnJW2TB7HvmOfi5FqRjObYJKIz+l/HF0qvhZ+XUqUJPO350iyeO9OekUD15OouLtG
         IWx5SALDyNDTWAILAGT2dv/YqU0aGWN+ufiIXer0mzOGDOC1HnL2cR49R6Z6YDmAaxmE
         +1bMnEgCQ1QqIzNbUeUCtJHuN7UdiCex+XmICDNiriMaxwXTAiAzF8tO2o0o8RVojIsH
         GsFA==
X-Gm-Message-State: APjAAAXUTUzmOMrncPHYshYymobr5OOdKFT0hlIMRPJRot9KuIB1vvST
        Hu4vItRpctWWwYIJ35L9giqUxQ==
X-Google-Smtp-Source: APXvYqxwBj6+cx9oMqstKNbcYa5jdZwb9JBq6Hbs2rtLoooEU8TMHSnjKOAdQW1aCbt6OG+HWNAsOQ==
X-Received: by 2002:ac2:5b09:: with SMTP id v9mr1562324lfn.22.1562320728034;
        Fri, 05 Jul 2019 02:58:48 -0700 (PDT)
Received: from localhost.localdomain (ua-83-226-34-119.bbcust.telenor.se. [83.226.34.119])
        by smtp.gmail.com with ESMTPSA id m5sm1152111lfa.47.2019.07.05.02.58.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 02:58:47 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, sboyd@kernel.org,
        vireshk@kernel.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/13] dt-bindings: power: avs: Add support for CPR (Core Power Reduction)
Date:   Fri,  5 Jul 2019 11:57:20 +0200
Message-Id: <20190705095726.21433-10-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190705095726.21433-1-niklas.cassel@linaro.org>
References: <20190705095726.21433-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add DT bindings to describe the CPR HW found on certain Qualcomm SoCs.

Changes since RFC:
-Make compatible string SoC specific.
-Changed interrupt definition.
-Use clock binding for reference clock.
-Clarified qcom,vdd-apc-step-up-limit description.
-Added missing properties.
-Updated the example.

Co-developed-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 .../bindings/power/avs/qcom,cpr.txt           | 193 ++++++++++++++++++
 1 file changed, 193 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/avs/qcom,cpr.txt

diff --git a/Documentation/devicetree/bindings/power/avs/qcom,cpr.txt b/Documentation/devicetree/bindings/power/avs/qcom,cpr.txt
new file mode 100644
index 000000000000..93be67fa8f38
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/avs/qcom,cpr.txt
@@ -0,0 +1,193 @@
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
+- qcom,cpr-timer-delay-us:
+	Usage: required
+	Value type: <u32>
+	Definition: delay in uS for the timer interval
+
+- qcom,cpr-timer-cons-up:
+	Usage: required
+	Value type: <u32>
+	Definition: Consecutive number of timer intervals, or units of
+		    qcom,cpr-timer-delay-us, that occur before issuing an up
+		    interrupt
+
+- qcom,cpr-timer-cons-down:
+	Usage: required
+	Value type: <u32>
+	Definition: Consecutive number of timer intervals, or units of
+		    qcom,cpr-timer-delay-us, that occur before issuing a down
+		    interrupt
+
+- qcom,cpr-up-threshold:
+	Usage: optional
+	Value type: <u32>
+	Definition: The threshold for CPR to issue interrupt when error_steps
+		    is greater than it when stepping up
+
+- qcom,cpr-down-threshold:
+	Usage: optional
+	Value type: <u32>
+	Definition: The threshold for CPR to issue interrupt when error_steps
+		    is greater than it when stepping down
+
+- qcom,cpr-idle-clocks:
+	Usage: optional
+	Value type: <u32>
+	Definition: Idle clock cycles ring oscillator can be in
+
+- qcom,cpr-gcnt-us:
+	Usage: required
+	Value type: <u32>
+	Definition: The time for gate count in uS
+
+- qcom,vdd-apc-step-up-limit:
+	Usage: required
+	Value type: <u32>
+	Definition: Limit of number of vdd-apc-supply regulator steps for
+		    scaling up
+
+- qcom,vdd-apc-step-down-limit:
+	Usage: required
+	Value type: <u32>
+	Definition: Limit of number of vdd-apc-supply regulator steps for
+		    scaling down
+
+Example:
+
+	cpr_opp_table: cpr-opp-table {
+		compatible = "operating-points-v2-qcom-level";
+
+		cpr_opp1: opp1 {
+			opp-level = <1>;
+			....
+		};
+		cpr_opp2: opp2 {
+			opp-level = <2>;
+			....
+		};
+		cpr_opp3: opp3 {
+			opp-level = <3>;
+			....
+		};
+	};
+
+	cpr@b018000 {
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
+
+		qcom,cpr-timer-delay-us = <5000>;
+		qcom,cpr-timer-cons-up = <0>;
+		qcom,cpr-timer-cons-down = <2>;
+		qcom,cpr-up-threshold = <1>;
+		qcom,cpr-down-threshold = <3>;
+		qcom,cpr-idle-clocks = <15>;
+		qcom,cpr-gcnt-us = <1>;
+		qcom,vdd-apc-step-up-limit = <1>;
+		qcom,vdd-apc-step-down-limit = <1>;
+	};
-- 
2.21.0

