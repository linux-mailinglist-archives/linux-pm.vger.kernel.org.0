Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57288E8D14
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 17:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390650AbfJ2QpH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 12:45:07 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44905 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390653AbfJ2QpH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2019 12:45:07 -0400
Received: by mail-lf1-f65.google.com with SMTP id v4so7622160lfd.11
        for <linux-pm@vger.kernel.org>; Tue, 29 Oct 2019 09:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vwZc8kmFy7PANbXlKQ6pebxa/rQt81fGNlatlAwVkyY=;
        b=fOtx+sxl1X6dXEMgiZzjAp5+wekh0iKtzO7J+xgzDvSNTad4qHfvVwMUAKQhAIQ8jf
         Ekd2ueLYicVs3TL/Su+e0oV8sGSqrcqChCs+kglR/KfEM8yNm5XCIJiZElqvYXJLlNRu
         rsbE4lCNknRG6peGNSu3DERrS+Wd1oPFG6FWPvHOZxQGapfN/6lVMrJq1WfG+hZDld6V
         WgFy5gf+RRh6SEierUrRfKLj2smidEY2EgDnCKGsg23iaz6hPer8iczkGSDYb6iHsze0
         8DyoQtspp0iZSrYX7pWVw1f0BJVkeTCFWfp9XhfTmL2YRdedbE3ZE50LbhvOtAYT3CJB
         7fwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vwZc8kmFy7PANbXlKQ6pebxa/rQt81fGNlatlAwVkyY=;
        b=uGxCLLxPNN8qErmmhjtrOe3+aZmRvbRIUv3g++cqOTCNFRiMzNxJNaPg7Z9qdFg3wi
         3URgSJ9lwWNO6/WOriYlHObzELU/kZH4BdEa7jbegFvP39GzpmkGaUzDSsBUIyT40nFJ
         zyOrB81NdSav4jXYDb0E02r+yWRf8GfD3GaDbvERMTsz/tcZiqpePTiD92ew7kQAKGnL
         n3f9ul1b3ptqeof9bdzeNwTKqa5nPH9QlBnfN6ga2PC9r3X0HbfXLt7UD4k20zA8Gjkl
         I3d7VAhVNHfnn7R/iDzHQ8Rym/gXmABM6h2TZzbZviVGg2sdYeaQy8S4o4LhGT1GEqG4
         oopQ==
X-Gm-Message-State: APjAAAVNtxufnneeGl2rh3IYTpGHsUwOIViJsKw60gM+h1K/zkWCiL7N
        NJr06Va2oEztzP2TpwViNtxHNtb0qZk=
X-Google-Smtp-Source: APXvYqzM3lnQ7Juqkap735jfK5Im438rtYjMAQLaGTdKg6f8+RrokngHQ+4cn+wEcm+cJHs45nW/6g==
X-Received: by 2002:a19:7511:: with SMTP id y17mr3184754lfe.19.1572367504558;
        Tue, 29 Oct 2019 09:45:04 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id f28sm2048161lfh.35.2019.10.29.09.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 09:45:03 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>, linux-pm@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v2 13/13] arm64: dts: Convert to the hierarchical CPU topology layout for MSM8916
Date:   Tue, 29 Oct 2019 17:44:38 +0100
Message-Id: <20191029164438.17012-14-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191029164438.17012-1-ulf.hansson@linaro.org>
References: <20191029164438.17012-1-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To enable the OS to better support PSCI OS initiated CPU suspend mode,
let's convert from the flattened layout to the hierarchical layout.

In the hierarchical layout, let's create a power domain provider per CPU
and describe the idle states for each CPU inside the power domain provider
node. To group the CPUs into a cluster, let's add another power domain
provider and make it act as the master domain. Note that, the CPU's idle
states remains compatible with "arm,idle-state", while the cluster's idle
state becomes compatible with "domain-idle-state".

Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Dropped CC of Andy, due to wrong email anyway. Instead include him for
	the series.

---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 57 +++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 5ea9fb8f2f87..1ece0c763592 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -102,10 +102,11 @@
 			reg = <0x0>;
 			next-level-cache = <&L2_0>;
 			enable-method = "psci";
-			cpu-idle-states = <&CPU_SLEEP_0>;
 			clocks = <&apcs>;
 			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>;
+			power-domains = <&CPU_PD0>;
+			power-domain-names = "psci";
 		};
 
 		CPU1: cpu@1 {
@@ -114,10 +115,11 @@
 			reg = <0x1>;
 			next-level-cache = <&L2_0>;
 			enable-method = "psci";
-			cpu-idle-states = <&CPU_SLEEP_0>;
 			clocks = <&apcs>;
 			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>;
+			power-domains = <&CPU_PD1>;
+			power-domain-names = "psci";
 		};
 
 		CPU2: cpu@2 {
@@ -126,10 +128,11 @@
 			reg = <0x2>;
 			next-level-cache = <&L2_0>;
 			enable-method = "psci";
-			cpu-idle-states = <&CPU_SLEEP_0>;
 			clocks = <&apcs>;
 			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>;
+			power-domains = <&CPU_PD2>;
+			power-domain-names = "psci";
 		};
 
 		CPU3: cpu@3 {
@@ -138,10 +141,11 @@
 			reg = <0x3>;
 			next-level-cache = <&L2_0>;
 			enable-method = "psci";
-			cpu-idle-states = <&CPU_SLEEP_0>;
 			clocks = <&apcs>;
 			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>;
+			power-domains = <&CPU_PD3>;
+			power-domain-names = "psci";
 		};
 
 		L2_0: l2-cache {
@@ -161,12 +165,57 @@
 				min-residency-us = <2000>;
 				local-timer-stop;
 			};
+
+			CLUSTER_RET: cluster-retention {
+				compatible = "domain-idle-state";
+				arm,psci-suspend-param = <0x41000012>;
+				entry-latency-us = <500>;
+				exit-latency-us = <500>;
+				min-residency-us = <2000>;
+			};
+
+			CLUSTER_PWRDN: cluster-gdhs {
+				compatible = "domain-idle-state";
+				arm,psci-suspend-param = <0x41000032>;
+				entry-latency-us = <2000>;
+				exit-latency-us = <2000>;
+				min-residency-us = <6000>;
+			};
 		};
 	};
 
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
+
+		CPU_PD0: cpu-pd0 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&CPU_SLEEP_0>;
+		};
+
+		CPU_PD1: cpu-pd1 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&CPU_SLEEP_0>;
+		};
+
+		CPU_PD2: cpu-pd2 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&CPU_SLEEP_0>;
+		};
+
+		CPU_PD3: cpu-pd3 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&CPU_SLEEP_0>;
+		};
+
+		CLUSTER_PD: cluster-pd {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&CLUSTER_RET>, <&CLUSTER_PWRDN>;
+		};
 	};
 
 	pmu {
-- 
2.17.1

