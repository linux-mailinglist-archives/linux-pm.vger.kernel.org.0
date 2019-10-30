Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0AAEA57D
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2019 22:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfJ3Vfd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 17:35:33 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35522 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfJ3Vfc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2019 17:35:32 -0400
Received: by mail-lf1-f68.google.com with SMTP id y6so2779258lfj.2;
        Wed, 30 Oct 2019 14:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UXRoHcvapztDcfGo7L2UwrKkYpLR6LIFA1LRvGGCLHM=;
        b=X8LlcTkO5qk6BAPnP/ZDsx2WqswLMh/PlzCz3X1hCOJIvQTHIwF2xYPwuJoKli2k5c
         PN5cSfqN74IuCdT7Laf3+KG7RXFG60EYCO/SmsX8mkjZ5+UbHD+BCtMBy4s/MUksEwxE
         dadFFVkMwiBC3SruJ8i1sdTrX7Yv5vL1ERb+MMAw0hS5nNVdr12lq3a4xZpuuBE26knl
         bkVm6XP8TRAxwzuBAI9iQxvm1nDvKJg4o9iNFrRqR0UBHISpEx7GHPOUTWyipadkOt+G
         4As6deKLK54f/UUdAAiMazMVLfAc2V40ETjUPCTQW8FCKQ6iWLCjDv9ke9OyRqJRkrZf
         nLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UXRoHcvapztDcfGo7L2UwrKkYpLR6LIFA1LRvGGCLHM=;
        b=s9ksIqhlY8mrl6x6EczDU0bymS7tkIYkkpftFojQ8keLnKGkDaNp36FoENGMYJSkB8
         FsjJCScpd8sYbudXwI28enXlaJm1oUhyT33xgbPqoAxlcErZoc/7q5jTOAVofnxK3TX6
         MIjAYoQiD1GKwoZGNv6CdoRYwpx14kkt3vOnNTSP3e+0LxvQp3yjkkYk2VfEtdd4AxM5
         Xlq/ECt72V4pr5a/zpbtLZcnvPYfyX2cBG/agwd6WrXxXABD3dxpcmm7cxTZNvIeLuir
         Xedpe3heEve6ePR+w7Up7IwJ/KNyMxD/JEt10cx2mGrc8/hyl9+sKmhlOGxDpAQWbsHd
         qpWg==
X-Gm-Message-State: APjAAAV49Zg/BZJUfWLXEHegllE/qWKgHHgU57jYIrsQ+HEXBKPtctfm
        evbgqB6bbjEHTMkUHZHWDao=
X-Google-Smtp-Source: APXvYqz85dLnDyS/EvxduG8znGwSF4AE/WsU/G0Mpxr0dk7od8G9sPwJG5DaAu+AziQ2Jv3Raq97OQ==
X-Received: by 2002:ac2:5328:: with SMTP id f8mr258782lfh.128.1572471330483;
        Wed, 30 Oct 2019 14:35:30 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id c24sm553812lfm.20.2019.10.30.14.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 14:35:29 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/10] dt-bindings: cpufreq: Add binding for NVIDIA Tegra20/30
Date:   Thu, 31 Oct 2019 00:33:56 +0300
Message-Id: <20191030213400.29434-7-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191030213400.29434-1-digetx@gmail.com>
References: <20191030213400.29434-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add device-tree binding that describes CPU frequency-scaling hardware
found on NVIDIA Tegra20/30 SoCs.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../cpufreq/nvidia,tegra20-cpufreq.txt        | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt

diff --git a/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt b/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
new file mode 100644
index 000000000000..daeca6ae6b76
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
@@ -0,0 +1,56 @@
+Binding for NVIDIA Tegra20 CPUFreq
+==================================
+
+Required properties:
+- clocks: Must contain an entry for the CPU clock.
+  See ../clocks/clock-bindings.txt for details.
+- operating-points-v2: See ../bindings/opp/opp.txt for details.
+- #cooling-cells: Should be 2. See ../thermal/thermal.txt for details.
+
+For each opp entry in 'operating-points-v2' table:
+- opp-supported-hw: Two bitfields indicating:
+	On Tegra20:
+	1. CPU process ID mask
+	2. SoC speedo ID mask
+
+	On Tegra30:
+	1. CPU process ID mask
+	2. CPU speedo ID mask
+
+	A bitwise AND is performed against these values and if any bit
+	matches, the OPP gets enabled.
+
+- opp-microvolt: CPU voltage triplet.
+
+Optional properties:
+- cpu-supply: Phandle to the CPU power supply.
+
+Example:
+	regulators {
+		cpu_reg: regulator0 {
+			regulator-name = "vdd_cpu";
+		};
+	};
+
+	cpu0_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+
+		opp@456000000 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <825000 825000 1125000>;
+			opp-supported-hw = <0x03 0x0001>;
+			opp-hz = /bits/ 64 <456000000>;
+		};
+
+		...
+	};
+
+	cpus {
+		cpu@0 {
+			compatible = "arm,cortex-a9";
+			clocks = <&tegra_car TEGRA20_CLK_CCLK>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			cpu-supply = <&cpu_reg>;
+			#cooling-cells = <2>;
+		};
+	};
-- 
2.23.0

