Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF6CF12532E
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 21:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfLRUWK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 15:22:10 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44266 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbfLRUWI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 15:22:08 -0500
Received: by mail-lj1-f194.google.com with SMTP id u71so3580412lje.11;
        Wed, 18 Dec 2019 12:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+VS0hDmeQXhAmkJq5950YTYXxFjVBKr1yL5L6K4MJW0=;
        b=dZCt5akt7NinmUFRtXOZGeL/jOKHueYlmrvy/OFIdrr86GFypQeWBMhzZrI4jwblZN
         SjqSDlxAeVSt4svEQUEw2abFZNyWvvuRuM/uqsT8TmYPhk9Ja1qo082OqPzX5+7pSayh
         A6luVAzQHn7+YGvnhgSTpGefy5BR58c6oxnZbW+VTXLrNKXfsN+GeGiSJbTkecs9na/M
         QanZOpQZuxmPQSZFTtERhHU7R5a/ewS87w9WYKRgguFwg6MQj3DTkFQwKF1YRCCpQ1qZ
         2P+o1XZt7XlK0xpqbLmFqNup9YUxfAgQVqa/8Vo2qyoH59L5cmNZu2ATQ1Uvwo0+R7n0
         HwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+VS0hDmeQXhAmkJq5950YTYXxFjVBKr1yL5L6K4MJW0=;
        b=r5pwX2A63rKY1AdEFRErOEjFy0E5O/5BhY4S3Sdd+CAGeH47D4qgbdS5c5AMTpmB5o
         x6gvPp0YaFjvvqC66biTJn2WEassKeWmPFMt9JQqsCpn386W/EjrbBhJpLi4NbqWVXfn
         Tu7zBgrxlQ7ixcssJ+OYGYdoW4f9hLbJ7yS1IdNy0TT9g7PX0mCDTvOEAD5zBq4e0LrO
         fbHFWpV3O3K0nSgHqah3gXj8afM8hIH7F4rFilxGNiyu7J9WnGCNi3DohVIBQ8xEErcl
         /blGU3yJCzNDS1VTf/+jPE0X36iZIOxbn4M6TbiGSXDqjXHUHxrqsYVN+K4muPCcqrMA
         9FNg==
X-Gm-Message-State: APjAAAVbPkBrHvVT8Z9ravQYF9dOJ4j5WyQuMsRfPh2p8Akm6Ymlzf1I
        6RXkYmVboDj+x/Qbq6V+Q84=
X-Google-Smtp-Source: APXvYqyVuPEDqaRNv4qy6csyA6tsC1q5PJjWvsjVl55QFxJFUDzWy1MB0OAvj8xoTA9d/xNjHrIvRQ==
X-Received: by 2002:a2e:9ad1:: with SMTP id p17mr3297973ljj.26.1576700526408;
        Wed, 18 Dec 2019 12:22:06 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id m15sm1766993ljg.4.2019.12.18.12.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 12:22:05 -0800 (PST)
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
Subject: [PATCH v6 08/12] dt-bindings: cpufreq: Add binding for NVIDIA Tegra20/30
Date:   Wed, 18 Dec 2019 23:21:38 +0300
Message-Id: <20191218202142.11717-9-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191218202142.11717-1-digetx@gmail.com>
References: <20191218202142.11717-1-digetx@gmail.com>
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
2.24.0

