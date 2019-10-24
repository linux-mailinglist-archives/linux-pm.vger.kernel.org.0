Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A86FEE3EEE
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2019 00:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730633AbfJXWRr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Oct 2019 18:17:47 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44456 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730564AbfJXWRp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Oct 2019 18:17:45 -0400
Received: by mail-lf1-f68.google.com with SMTP id g3so8187613lfb.11;
        Thu, 24 Oct 2019 15:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WCKPag+natMXLr1Inj19Tp4WM7nWhFIVt8BL/QkXlOA=;
        b=p1fZ4qb5mc/GErglUFZh3cOMdakEgNVOAu0mY0B6sZRgjm6IhvBzZwnePZ0wUWM+5C
         bxoJLCPQJX3B1xx5KytYDo5G4O2S4gtN3DwTwpOnEtwxZgkjPyQsd716LfEvQ12LrRU6
         XbzzFsVdH0ahJji2GTdh+RUkxYAoCOpmF9NutGnlxeiQzuzbEkvME38Pthn787MdeTrm
         wPU2FvPob+aCGtra/5+YGR5qv8CzSbG4PDQXcQK2EtFsPKdXzeo7bQM5H51Lle75W6au
         tsgD+Qdx4fqCM08fGpgrag2vBObZa3YbFgxCaoLIuwAHikeHclDPv5q6B1uWaNqBsYS9
         wSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WCKPag+natMXLr1Inj19Tp4WM7nWhFIVt8BL/QkXlOA=;
        b=PLLrTohYysSBNNz8s73Xk9y9QZErlT/5CRHkhRS+jITQyS/FpDone1sa5c31qGHDVH
         EVx4X7ZtKApdXk45csNKdHziyKLtm4qh2LUdwUbtoBBlcG5I4qMiFHHLCiU1y/gr1b/J
         ABAYKKwGQ9qt3Qva7M06+agIlcvOgixq/O8s0KzgHviFw+TLsZOhsCUYrY2Ko/dW9Pqh
         X8GY+5D28TbXg/roR5NrA9p/qBCqeu+LQiEKViVjYRw/dY05FIYc9uhmh8MSGJptUveO
         DVg10PDD+icJ4k6shgezeV+mYe3TzTiVBMXcHKmho+urOWdljuwopy1I0JfGOee6WTsg
         lu5A==
X-Gm-Message-State: APjAAAWoT9aIF91EbKfG5gklR3r9npirpeAscZfGFu7ZMxKcfANfpNfp
        IJ72CKaKo4G/T8btK3gAPBqNxLb6
X-Google-Smtp-Source: APXvYqwwtYVHuUuuQImABCbCyFQQzbQm9Mi/WXFeJ11ow7T6Vp9Nks6bBohJUwwFBTGBckjyAEbEEg==
X-Received: by 2002:a19:5517:: with SMTP id n23mr259950lfe.139.1571955462121;
        Thu, 24 Oct 2019 15:17:42 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id i6sm11338765lfo.83.2019.10.24.15.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 15:17:41 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/17] dt-bindings: cpufreq: Add binding for NVIDIA Tegra20/30
Date:   Fri, 25 Oct 2019 01:14:05 +0300
Message-Id: <20191024221416.14197-7-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024221416.14197-1-digetx@gmail.com>
References: <20191024221416.14197-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add device-tree binding that describes CPU frequency-scaling hardware
found on NVIDIA Tegra20/30 SoCs.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
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

