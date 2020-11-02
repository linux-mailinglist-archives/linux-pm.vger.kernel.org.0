Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7BDF2A2A49
	for <lists+linux-pm@lfdr.de>; Mon,  2 Nov 2020 13:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbgKBMB7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Nov 2020 07:01:59 -0500
Received: from foss.arm.com ([217.140.110.172]:58570 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728623AbgKBMB7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Nov 2020 07:01:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9CE830E;
        Mon,  2 Nov 2020 04:01:58 -0800 (PST)
Received: from ubuntu.arm.com (unknown [10.57.53.184])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5FF6A3F66E;
        Mon,  2 Nov 2020 04:01:56 -0800 (PST)
From:   Nicola Mazzucato <nicola.mazzucato@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, vireshk@kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, nm@ti.com,
        daniel.lezcano@linaro.org
Cc:     morten.rasmussen@arm.com, chris.redpath@arm.com,
        nicola.mazzucato@arm.com
Subject: [PATCH v3 1/3] dt-bindings/opp: Update documentation for opp-shared
Date:   Mon,  2 Nov 2020 12:01:13 +0000
Message-Id: <20201102120115.29993-2-nicola.mazzucato@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201102120115.29993-1-nicola.mazzucato@arm.com>
References: <20201102120115.29993-1-nicola.mazzucato@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently the optional property opp-shared is used within an opp table
to tell that a set of devices share their clock/voltage lines (and the
opp points).
It is therefore possible to use an empty opp table to convey only that
information, useful in situations where the opp points are provided via
other means (hardware. firmware, etc).

Update the documentation to remark this additional case and provide an
example.

Signed-off-by: Nicola Mazzucato <nicola.mazzucato@arm.com>
---
 Documentation/devicetree/bindings/opp/opp.txt | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
index 9847dfeeffcb..a5f1f993eab9 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -72,6 +72,9 @@ Optional properties:
   switch their DVFS state together, i.e. they share clock/voltage/current lines.
   Missing property means devices have independent clock/voltage/current lines,
   but they share OPP tables.
+  This optional property can be used without any OPP nodes when its only purpose
+  is to describe a dependency of clock/voltage/current lines among a set of
+  devices.
 
 - status: Marks the OPP table enabled/disabled.
 
@@ -568,3 +571,53 @@ Example 6: opp-microvolt-<name>, opp-microamp-<name>:
 		};
 	};
 };
+
+Example 7: Single cluster Quad-core ARM cortex A53, OPP points from firmware,
+distinct clock controls but two sets of clock/voltage/current lines.
+
+/ {
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			compatible = "arm,cortex-a53";
+			reg = <0x0 0x100>;
+			next-level-cache = <&A53_L2>;
+			clocks = <&dvfs_controller 0>;
+			operating-points-v2 = <&cpu_opp0_table>;
+		};
+		cpu@1 {
+			compatible = "arm,cortex-a53";
+			reg = <0x0 0x101>;
+			next-level-cache = <&A53_L2>;
+			clocks = <&dvfs_controller 1>;
+			operating-points-v2 = <&cpu_opp0_table>;
+		};
+		cpu@2 {
+			compatible = "arm,cortex-a53";
+			reg = <0x0 0x102>;
+			next-level-cache = <&A53_L2>;
+			clocks = <&dvfs_controller 2>;
+			operating-points-v2 = <&cpu_opp1_table>;
+		};
+		cpu@3 {
+			compatible = "arm,cortex-a53";
+			reg = <0x0 0x103>;
+			next-level-cache = <&A53_L2>;
+			clocks = <&dvfs_controller 3>;
+			operating-points-v2 = <&cpu_opp1_table>;
+		};
+
+	};
+
+	cpu_opp0_table: opp0_table {
+		compatible = "operating-points-v2";
+		opp-shared;
+	};
+
+	cpu_opp1_table: opp1_table {
+		compatible = "operating-points-v2";
+		opp-shared;
+	};
+};
-- 
2.27.0

