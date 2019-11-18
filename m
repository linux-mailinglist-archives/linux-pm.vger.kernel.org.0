Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB0F10098B
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 17:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfKRQqz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 11:46:55 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44526 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfKRQqy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2019 11:46:54 -0500
Received: by mail-lj1-f194.google.com with SMTP id g3so19709502ljl.11;
        Mon, 18 Nov 2019 08:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UXRoHcvapztDcfGo7L2UwrKkYpLR6LIFA1LRvGGCLHM=;
        b=ebx11epXp1Gz3ihhOwsxX6YPyaqQzXRfgHR4U50FAG7AxHVm3FrNhGEtwySbonpbiF
         gjRh7qAlkUjzhWJtdVfoWBLrzrh/vNVLaXbbnVoNjAwHPCQZTjaGcwC8W8JCfdm/qMix
         VibJFioGUCAZ2afPqJ+k8DU8yDDiZfWHK0jPxzLGDoc97fCXNPRmA++LNkX3YDd8XsnR
         ZOD7ZBkiVQZBC6wNJnxd5rMJre5IiEEeQXegl35yEbPGry3NGGLH12QQrrG+6naxvzxq
         MdoLOlfSkZsJviqqJwBEdCQXXGN9AWMXC+hEG5pu+G/6rKBVI/djsVhfLPx0QMZQM+kG
         MbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UXRoHcvapztDcfGo7L2UwrKkYpLR6LIFA1LRvGGCLHM=;
        b=pMf+ZfiSYkTEk5aZadNGM1A6rwTzHC9Bj7XImCT1S8xNULP5tG2KJ7qkFtLstACuLS
         /xiBnkadtwYHkglC42ihdAfSqDAHJBfpzEpIsm69Qgfg7h4lWIuH1I422/loTq+C4avl
         ZAgWrFFt5cwB5HbC6tStZUW75Zv6E+NsySllQqqBwZx2+x0XFXUmP/0cFUelpS0Ye5tl
         DAKUz6ZoAebHYUT8CowOcC9Yr3gJRbsuKK79qLCNPHJ8dn2uF9c9BlmWQnRBUZiqYhkL
         K5QAhkB17o/m3nkocmF9zO+ei4kdnnljNZPYnGAi0XFaj3dmv05X5saddc441HNSYL7u
         OBzg==
X-Gm-Message-State: APjAAAVo++W03pE4YkMlsLe68rEB+XlRFA6IOkUg+7TsRZ9uqboUiiw4
        9PCxzjm9zXOgJmqEAyHTWqM=
X-Google-Smtp-Source: APXvYqxUqsmjkdNpu1mD4oVQBY8s9NJw54ddMUiTEOvjA9Fh/1M+LplMfvnij1DnqfqrMr8H3NaWsA==
X-Received: by 2002:a2e:9d84:: with SMTP id c4mr245952ljj.187.1574095612096;
        Mon, 18 Nov 2019 08:46:52 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id d4sm8880307lfi.32.2019.11.18.08.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 08:46:51 -0800 (PST)
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
Subject: [PATCH v5 06/11] dt-bindings: cpufreq: Add binding for NVIDIA Tegra20/30
Date:   Mon, 18 Nov 2019 19:45:07 +0300
Message-Id: <20191118164512.8676-7-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118164512.8676-1-digetx@gmail.com>
References: <20191118164512.8676-1-digetx@gmail.com>
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

