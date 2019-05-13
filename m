Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9B21BDB3
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 21:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbfEMTXL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 15:23:11 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45522 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfEMTXK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 May 2019 15:23:10 -0400
Received: by mail-lj1-f193.google.com with SMTP id r76so12042206lja.12
        for <linux-pm@vger.kernel.org>; Mon, 13 May 2019 12:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PRL03ayf+3gKTw6ZyGNmbuvOXDVJf1omVj5w82VYj+c=;
        b=Znmj+Rap5uWxgIXFcTCRFXUCBeWlHqU14s7GfponHlIVTdIN7IzEc61HXMm4h5nMBl
         pijn+Gtm6cLPHDMK+OyeGhMq851kXOyT9eVvz5Eyww1m2u+MiAMZ1ZmxhMmNVVYT67kD
         mS34rNa0TU+vC/QIphSceYIH1L6a0ZvjhvREogDJycRMkS+Rs2TfV8eY8m+0ZbMStq5P
         dk5lfkFlLuy6i4z/FJSh7h6pWspZbXExojy+vKqzYVKfbdd54IxWPB6JsuTVRCSLt0ye
         MCtEkLESrZG/lkG0+OyQr8OvzGk5uYyHT8MItOwqjKlbO+fTi4c83DsDsSQhdL3amg2j
         JoKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PRL03ayf+3gKTw6ZyGNmbuvOXDVJf1omVj5w82VYj+c=;
        b=b5/FOukN8Rsoa9p6mq009KfEidvoPDNckopqWW8b+mw1TIMkMOXeT1aN7uXOkmtP/2
         x/pG58UYtVSiPUJsdKdNz+b7Tz4he0ZE96Fnh32DN07aPvnr95Tfg5+bGjg+pje/pLKr
         CPUYUs95NeMCse1ppsdxhNaz7ZSQxndJdK0hsOVpgNX0JkMCnkZaBxd8IhA5DtEMm4oL
         mjzHRZj+KEAvI+I9gQoZntOhNkQUgIsTR5PnXY7bEC1wGlMb6zrjO/dggLKrt4JrMpU0
         osXMpiwuxhs2pCL7SFl0DXCr/Yk2qWcTYvwlQzoIBpNecBCSEzkEkXOhW4Qo7YBoyiwq
         k5XQ==
X-Gm-Message-State: APjAAAUE4acvW+jgVvKX4QaFjoIya0g8FkL32CulYh6PmEgRGmZ9Bnun
        1FYjRSN0WTgiQCNba1W16PrSUA==
X-Google-Smtp-Source: APXvYqw+k+LeWintu25cglIZU1CDGNn5D+9RA2OiP0AoKwBrDnOS5hnqd/Xey6gfGS2F/GmEje2j4w==
X-Received: by 2002:a2e:86c5:: with SMTP id n5mr14855773ljj.184.1557775387446;
        Mon, 13 May 2019 12:23:07 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id q21sm3449365lfa.84.2019.05.13.12.23.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 12:23:06 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 01/18] dt: psci: Update DT bindings to support hierarchical PSCI states
Date:   Mon, 13 May 2019 21:22:43 +0200
Message-Id: <20190513192300.653-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513192300.653-1-ulf.hansson@linaro.org>
References: <20190513192300.653-1-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Lina Iyer <lina.iyer@linaro.org>

Update DT bindings to represent hierarchical CPU and CPU PM domain idle
states for PSCI. Also update the PSCI examples to clearly show how
flattened and hierarchical idle states can be represented in DT.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Co-developed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes:
	- None.

---
 .../devicetree/bindings/arm/psci.txt          | 166 ++++++++++++++++++
 1 file changed, 166 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/psci.txt b/Documentation/devicetree/bindings/arm/psci.txt
index a2c4f1d52492..e6d3553c8df8 100644
--- a/Documentation/devicetree/bindings/arm/psci.txt
+++ b/Documentation/devicetree/bindings/arm/psci.txt
@@ -105,7 +105,173 @@ Case 3: PSCI v0.2 and PSCI v0.1.
 		...
 	};
 
+ARM systems can have multiple cores sometimes in hierarchical arrangement.
+This often, but not always, maps directly to the processor power topology of
+the system. Individual nodes in a topology have their own specific power states
+and can be better represented in DT hierarchically.
+
+For these cases, the definitions of the idle states for the CPUs and the CPU
+topology, must conform to the domain idle state specification [3]. The domain
+idle states themselves, must be compatible with the defined 'domain-idle-state'
+binding [1], and also need to specify the arm,psci-suspend-param property for
+each idle state.
+
+DT allows representing CPUs and CPU idle states in two different ways -
+
+The flattened model as given in Example 1, lists CPU's idle states followed by
+the domain idle state that the CPUs may choose. Note that the idle states are
+all compatible with "arm,idle-state". Additionally, for the domain idle state
+the "arm,psci-suspend-param" represents a superset of the CPU's idle state.
+
+Example 2 represents the hierarchical model of CPUs and domain idle states.
+CPUs define their domain provider in their psci DT node. The domain controls
+the power to the CPU and possibly other h/w blocks that would enter an idle
+state along with the CPU. The CPU's idle states may therefore be considered as
+the domain's idle states and have the compatible "arm,idle-state". Such domains
+may also be embedded within another domain that may represent common h/w blocks
+between these CPUs. The idle states of the CPU topology shall be represented as
+the domain's idle states. Note that for the domain idle state, the
+"arm,psci-suspend-param" represents idle states hierarchically.
+
+In PSCI firmware v1.0, the OS-Initiated mode is introduced. However, the
+flattened vs hierarchical DT representation is orthogonal to the OS-Initiated
+vs the platform-coordinated PSCI CPU suspend modes, thus should be considered
+independent of each other.
+
+The hierarchical representation helps and makes it easy to implement OSI mode
+and OS implementations may choose to mandate it. For the default platform-
+coordinated mode, both representations are viable options.
+
+Example 1: Flattened representation of CPU and domain idle states
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		CPU0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0>;
+			enable-method = "psci";
+			cpu-idle-states = <&CPU_PWRDN>, <&CLUSTER_RET>,
+					  <&CLUSTER_PWRDN>;
+		};
+
+		CPU1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			reg = <0x100>;
+			enable-method = "psci";
+			cpu-idle-states = <&CPU_PWRDN>, <&CLUSTER_RET>,
+					  <&CLUSTER_PWRDN>;
+		};
+
+		idle-states {
+			CPU_PWRDN: cpu-power-down {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x0000001>;
+				entry-latency-us = <10>;
+				exit-latency-us = <10>;
+				min-residency-us = <100>;
+			};
+
+			CLUSTER_RET: cluster-retention {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x1000011>;
+				entry-latency-us = <500>;
+				exit-latency-us = <500>;
+				min-residency-us = <2000>;
+			};
+
+			CLUSTER_PWRDN: cluster-power-down {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x1000031>;
+				entry-latency-us = <2000>;
+				exit-latency-us = <2000>;
+				min-residency-us = <6000>;
+			};
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+Example 2: Hierarchical representation of CPU and domain idle states
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		CPU0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0>;
+			enable-method = "psci";
+			power-domains = <&CPU_PD0>;
+			power-domain-names = "psci";
+		};
+
+		CPU1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			reg = <0x100>;
+			enable-method = "psci";
+			power-domains = <&CPU_PD1>;
+			power-domain-names = "psci";
+		};
+
+		idle-states {
+			CPU_PWRDN: cpu-power-down {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x0000001>;
+				entry-latency-us = <10>;
+				exit-latency-us = <10>;
+				min-residency-us = <100>;
+			};
+
+			CLUSTER_RET: cluster-retention {
+				compatible = "domain-idle-state";
+				arm,psci-suspend-param = <0x1000010>;
+				entry-latency-us = <500>;
+				exit-latency-us = <500>;
+				min-residency-us = <2000>;
+			};
+
+			CLUSTER_PWRDN: cluster-power-down {
+				compatible = "domain-idle-state";
+				arm,psci-suspend-param = <0x1000030>;
+				entry-latency-us = <2000>;
+				exit-latency-us = <2000>;
+				min-residency-us = <6000>;
+			};
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+
+		CPU_PD0: cpu-pd0 {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&CPU_PWRDN>;
+			power-domains = <&CLUSTER_PD>;
+		};
+
+		CPU_PD1: cpu-pd1 {
+			#power-domain-cells = <0>;
+			domain-idle-states =  <&CPU_PWRDN>;
+			power-domains = <&CLUSTER_PD>;
+		};
+
+		CLUSTER_PD: cluster-pd {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&CLUSTER_RET>, <&CLUSTER_PWRDN>;
+		};
+	};
+
 [1] Kernel documentation - ARM idle states bindings
     Documentation/devicetree/bindings/arm/idle-states.txt
 [2] Power State Coordination Interface (PSCI) specification
     http://infocenter.arm.com/help/topic/com.arm.doc.den0022c/DEN0022C_Power_State_Coordination_Interface.pdf
+[3]. PM Domains description
+    Documentation/devicetree/bindings/power/power_domain.txt
-- 
2.17.1

