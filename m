Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83A7DD81D7
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2019 23:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389466AbfJOVRJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Oct 2019 17:17:09 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44047 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388648AbfJOVRI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2019 17:17:08 -0400
Received: by mail-lj1-f194.google.com with SMTP id m13so21709349ljj.11;
        Tue, 15 Oct 2019 14:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wentp7FFll65K1llUGqB9K42nqf09O9M82PtyoqU4C8=;
        b=lIzH0Mlz0MdjUT2f0/sVwJF9Kj4s88ea9jJwObSq29uh/p9BT0qKaZZ25HhnctIMOg
         jBSzlV5SdpwczxJGKQUjPQUbPLFec1SbuxNvNGdvyaSuIVBZxFDpPNOzCA0m+S7OBIea
         6C6kKEG0ow0WoA5QWS+wDTZdTOunGANiTYAjE5rJvsPAz9/iyV98zh5WvBabusx5Xi/I
         f3Wv4Kl3lr2asOVVsaibKAB9cjFO5bf64NAoH3wPeVWTENN1WcxcR/GEfcbAXeyfesnW
         EkLemn03I7RCcC5NfHnfl3SD2MSOnT0EtoDO/4km/xE46Tbrwd/ywNT3VhIKxHeTE8lL
         6J5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wentp7FFll65K1llUGqB9K42nqf09O9M82PtyoqU4C8=;
        b=q4+9NQfXow0q7lP+1d7WwbNQyFnfSm6wWonI0PrP+MKHV2cceWmm0vRvLaAKb/kYBj
         EMyobK9UZkZrWjYgYCzZQiAskDY9dSHhUGsrc03abPTa/Gp+SiEyWuTstxiXJ+8uBUig
         CRYLvzYpjlAscNlx0xdS+8t/CdwI+XW9UqKbgFrKDA0pBDsu+SQtNSDltmqZGHQxwgUD
         5ie78Ml25FKjVH1UzqbZfwy5JMu4BAeEMaUq31lLtMWpHleYy5VRC5KrdMcNC48XeugQ
         vrGWj6HFe0AsbPc8mTFvHYdN2VOcF9Jbc28WAmDEg9WdmbmHSx8yUsVLz46m+a8a8lFb
         y0Tg==
X-Gm-Message-State: APjAAAVZ94YkoAbvLO7L7nB+wviiG6Nvm571FHM6uEqoUclK6HhuX08z
        n0hx1F4EI4x9uBo0jXlKwnM=
X-Google-Smtp-Source: APXvYqw/jKUk2M6TLUii+Jp447FpsmXx1/s99l2ZBbA91XttDU+nzbMQtRxQj6Yf/Nb7FWSV0t8y6w==
X-Received: by 2002:a2e:420a:: with SMTP id p10mr13183152lja.16.1571174225657;
        Tue, 15 Oct 2019 14:17:05 -0700 (PDT)
Received: from localhost.localdomain ([94.29.10.250])
        by smtp.gmail.com with ESMTPSA id t16sm5269186ljj.29.2019.10.15.14.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 14:17:05 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 06/17] dt-bindings: cpufreq: Add binding for NVIDIA Tegra20/30
Date:   Wed, 16 Oct 2019 00:16:07 +0300
Message-Id: <20191015211618.20758-7-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015211618.20758-1-digetx@gmail.com>
References: <20191015211618.20758-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add device-tree binding that describes CPU frequency-scaling hardware
found on NVIDIA Tegra20/30 SoCs.

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

