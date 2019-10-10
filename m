Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60E6ED2834
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2019 13:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732792AbfJJLk3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Oct 2019 07:40:29 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45542 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732931AbfJJLk3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Oct 2019 07:40:29 -0400
Received: by mail-lj1-f195.google.com with SMTP id q64so5808594ljb.12
        for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2019 04:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=seqtCL6qQP1lHpVV6JxVbCofE6J8aEcyzCDtbKaRiuo=;
        b=ttocmxpO4BTiaii5K7cn0npU6eVhqZ9uMEDMEG7dnyW79epK0rCXS/lpw4SkqbYIYg
         W59Vn7rAze9cJVsyqKmksnN9Di4v2QsCN03gmrmsqBwJ/hkNQiPz0b1pmIgAI601KtUS
         aSppXlnpANOGQrmU9eDiPdCo6OV3bH+oi46O/xtlYtnNSj1loyozvQ3GaZcs7LOYfHih
         30F0tcFKMkGwAo2oAQogPCkIcT9AmDSJ9rlR/88iiStn7tuBkFUijM/paQ7/7P3O8FJp
         cMKAdQl/TnVG7+eXCp+OBz/Zuzksl0YdnzPxvlspzR/jpoJqQbicu/XpqqncUNiFreNm
         lOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=seqtCL6qQP1lHpVV6JxVbCofE6J8aEcyzCDtbKaRiuo=;
        b=AlHHu2W4OlyJMdxqbt2ea1yRriSIA2dwFCkiqRo1T2IO//JRQ3SxkJSW5qIIPF7qRD
         2Yzi2qWKHpeUlL5yqCYPSGZMgAoG8bQY7zznM6SgXNUC9bWOvXE7Lk5FofuKx4ObPcN1
         JgczmwUdrE2BhP++BFiAfnwZoveiKn03gSN3Duhb0lDABqMnDLozjbJ1dFznv00AgQ2p
         W39hZRAKUBPYfmyw+wZaVIBxxeopzEozUO85l/fKrvYAjUEf8aASf1lTGaGZQVOd6AeT
         3+T9wvqYKhzzG2cmpn4TyJ6/GiEhaXbiWoF5EzVYVmhGZpWZubY7cmvQMZT/KaaTWTiG
         vrTg==
X-Gm-Message-State: APjAAAXGkB3Vx2h6sdJ9T5NiRsMgsunNS5EWm0hucgkpD/TVqkQiU0ea
        xcnWFGpIh7nDo87cMunKkaJa7g==
X-Google-Smtp-Source: APXvYqzAtQRFaFdOYUhWXaaCWhBIREvEFZI1olu/oFVmp742iMrFKC80mDD/KfhtuHeGyAmVXW6Erg==
X-Received: by 2002:a2e:9205:: with SMTP id k5mr6239604ljg.202.1570707626147;
        Thu, 10 Oct 2019 04:40:26 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id p3sm1168937ljn.78.2019.10.10.04.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 04:40:25 -0700 (PDT)
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
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH 13/13] arm64: dts: Convert to the hierarchical CPU topology layout for MSM8916
Date:   Thu, 10 Oct 2019 13:39:37 +0200
Message-Id: <20191010113937.15962-14-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191010113937.15962-1-ulf.hansson@linaro.org>
References: <20191010113937.15962-1-ulf.hansson@linaro.org>
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

Cc: Andy Gross <andy.gross@linaro.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
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

