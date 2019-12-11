Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3066211B3D0
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2019 16:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731436AbfLKPoS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Dec 2019 10:44:18 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45921 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387457AbfLKPoR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Dec 2019 10:44:17 -0500
Received: by mail-lj1-f196.google.com with SMTP id d20so24559715ljc.12
        for <linux-pm@vger.kernel.org>; Wed, 11 Dec 2019 07:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=57/Z02+ucp7qKhXMSKtjmCrn1ezz0VtvAepCcM3y9Cc=;
        b=HxhRgIlMOIogsf/2YoKGG7lRsb3JKtwXbwg/B+A9tR9+NMsIdFtsixap/nqd8MoTzl
         GrsbrUO2vFmbPPehEfbKpSxV4uRB5sF4pttcQGE99l4RzImTKaTkL0IcD36XP4L7dJ/Z
         uOmVdMlWnzD/2tACIb9pT5g95D31moKGr2rPMGIAA/K+0+7tNSoIGnEOij7XTsdzCqer
         8pCULS86IVVXtAU2cZTeDeXSfa2471IKM+MKNCENeTwL9O5RjcszBs2eWIt4fiRulCqz
         ID9ddiWjUdxsimsGUzcppKKFQCiwiP0R+vH4htW5jcYdC+0JVhykOaS0qCE4RupNX0TO
         CiKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=57/Z02+ucp7qKhXMSKtjmCrn1ezz0VtvAepCcM3y9Cc=;
        b=hDd8yU8DbICGIn1HcspskRdP7VBwiMbhsVnBuXCmHdSgMXFvb6xD1oyh14KdG3v8Au
         rb7yJbD7AihV60Je3BYJJ3CDEWwH7C8SiSnjGle2QO2O2aNjdmPGMaSyp87UT+iISRx6
         y8TwUpr5USI5CDNTkfsnDuSYnp2Jj0NUPy47fQqC3XF3LJlB5SelnC0sj0TlMD3Y/ct5
         0t+TXLWtD/+5OOhaAVwNv+CxYLH61bBOOv1CI04+shfqhacvPfDOPV4i9cLbT+uB0yTu
         hweFwH1HT6a4zbCZNlvMjHca7uIskXPw9ZzFWH2hxeItMcK1hsd2WarHwxkEz7QFwyRZ
         vSzw==
X-Gm-Message-State: APjAAAXid6BqhbTkGx3eN0ZeHhy6+2BuHL0WumehKJMwe3mbSOm06BEx
        PACnsXtWzxrG0sV0Tj3NiNUQ0g==
X-Google-Smtp-Source: APXvYqyzctDkVvnOP0bzJjLRPlg3nz19kJBie5gSq1vN5AM9HWkLvEF/wbc9WcyDRH9/GLpw3TU3WQ==
X-Received: by 2002:a2e:97cf:: with SMTP id m15mr2609300ljj.130.1576079054866;
        Wed, 11 Dec 2019 07:44:14 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id b14sm1389608lff.68.2019.12.11.07.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 07:44:14 -0800 (PST)
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
Subject: [PATCH v4 14/14] arm64: dts: Convert to the hierarchical CPU topology layout for MSM8916
Date:   Wed, 11 Dec 2019 16:43:43 +0100
Message-Id: <20191211154343.29765-15-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191211154343.29765-1-ulf.hansson@linaro.org>
References: <20191211154343.29765-1-ulf.hansson@linaro.org>
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

Changes in v4:
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

