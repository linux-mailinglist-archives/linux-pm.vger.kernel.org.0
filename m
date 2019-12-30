Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 521A012D10D
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2019 15:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfL3Oog (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Dec 2019 09:44:36 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40860 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbfL3Oof (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Dec 2019 09:44:35 -0500
Received: by mail-lj1-f193.google.com with SMTP id u1so33494975ljk.7
        for <linux-pm@vger.kernel.org>; Mon, 30 Dec 2019 06:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pFHyotJ6IeS0NnPGUwSrCQs8d27XE2yrJ5nxr3VtYic=;
        b=s5zzc4Lzvw9BL4eBPMqCkzI1609Ctjtx+HMMegsZzrLbvJR3PQGlrle85pbQIAjvQv
         spD0gMVv3McQxNFa9n7sHSB0CtaQvF20UZS6K5kWhrw/1n0QclJEHvtiB5eSVvJ3yfWG
         lTg1kc+5OHIy3eladTvA82JxUYopI+/UzQCz8HJiivLaVAl3CPevey+/gcyxcbXuu4lo
         Ae882oP6a3qVoJHFFKttCYL4xHchd0e9DRbh+BmiqVAJGnXrXoajVof6Mep88AChD8nP
         bMhjSjVl8YnbU5WlaYGRh8onvQMHN7Gi3m37K1wv4IZidNEBKaAgQzZaK9dNoDXCyQtA
         EXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pFHyotJ6IeS0NnPGUwSrCQs8d27XE2yrJ5nxr3VtYic=;
        b=BQtfEKVlVKXh8Rk9z2N2jdgmAtnUyvnWdIAHgbxhfeMu9+bZOS67PaCYLyd7CL1hSF
         apYMtT3BC1+owF3xRuSrvfnvdcGpmJOkfYiEbuWuhhdqTy8t12nP+4S+PAwR6Suu+Sg3
         gdlGMQfYWHvwe/aSj/lz5hORuQ/0L68XtO8Heek8XzUypreD0Pgsn8XActMNjDt4VxjW
         mj92+VPEQLGlanxdOWjwwGWqXeGbCSFN9uq7tTCKhOjA9koUDJRTQ9SN5eQsLjXWOeVv
         qZMak/B6+wUm2m2w5pxody1N56qobrzXpGYh0C/obCw/dHYUumMKdCeyFZCBEr606Rx0
         cbPw==
X-Gm-Message-State: APjAAAXCBD+8OXwcGGURBAwcxtSzHDmbD0KXcVY+Szc8nLuYw+TfsXqa
        FQurgxcYGFQMdnGiP8yTKUMDeA==
X-Google-Smtp-Source: APXvYqxdwGv5e3gJirom9yUfoCDD87334k/2EA5omu7hFVl0AB/wYbg/vlbug4VqdBA+bheY1tQrbA==
X-Received: by 2002:a2e:9a01:: with SMTP id o1mr37050340lji.247.1577717072600;
        Mon, 30 Dec 2019 06:44:32 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id a21sm18744931lfg.44.2019.12.30.06.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 06:44:32 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v5 15/15] arm64: dts: Convert to the hierarchical CPU topology layout for MSM8916
Date:   Mon, 30 Dec 2019 15:44:02 +0100
Message-Id: <20191230144402.30195-16-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191230144402.30195-1-ulf.hansson@linaro.org>
References: <20191230144402.30195-1-ulf.hansson@linaro.org>
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
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
---

Changes in v5:
	- None.

---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 57 +++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 8686e101905c..282c36c8fa3b 100644
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

