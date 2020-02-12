Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB0B15B509
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 00:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbgBLXqm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 18:46:42 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39693 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbgBLXql (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2020 18:46:41 -0500
Received: by mail-lf1-f67.google.com with SMTP id t23so2865096lfk.6;
        Wed, 12 Feb 2020 15:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Eq2aT2KbyFm5O0Maq2+OCMfbsMjQLSKCyn1ZBpg4cFA=;
        b=lrCUuLV+5a/t9tyxNLyOQ8tiN18sXz2EqWNiMib4wkF9GFW+IExcU0u3GChLU3lp5t
         OJ2K+zNUFchLN6xx85oN3/c2rUbWFtW+F3SDnCodkZ70ECYuYD4CruthYFlabE5+mZxE
         5sZ3yVwwhZAO0b0YsAxHEJ6HxBypSsNN/J4Oq+I++6vb1siE7Lc+voPYxspwNgd6rH4W
         ugWoyKpaDtg5A7eMAjzeSTesf+GXhCkIjT86Tpk0VRyOnSQZDJgeuSzdH1NEiK8y9bE/
         KKLCjjE9kExnW/RAIevDYDWWx2mqj+9U9dNawcSzbNI3tUwekVWOyrUeqfYTwCK5BM90
         ptnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Eq2aT2KbyFm5O0Maq2+OCMfbsMjQLSKCyn1ZBpg4cFA=;
        b=Iz+28dT995kJS2sP/Yzup2/M3oEDwFtNFSA7wuAfPAPw7iy5Suzfn0IzoYskxb8dg1
         2Tsz8PWfSUCw2sXS5GKTnJ/bZtI7HQL8SPbQFqMRvHSJvdG74+L7aMisJnB2IX+zdSg5
         nvPkYd3qKw5hykiasD+rRU+yuSAq7lgbdkRXunhj5veyN3vUmVFtK8pGmQS02GHtdfg1
         KXBpcYCaY8D1UiKhhxTuQPwoTLWMZYFXyAQCLgQFXON4x9SHRjENJIFfaXtqtPVL+ng7
         N7dRrqw2Umh7gH6AJbowzkK8xOeaffTwBV8HsBMlo+JNLO8Xn2qELTDQaH1mU5Nvwbsg
         1uQA==
X-Gm-Message-State: APjAAAXtaileKsBz7XIxlrMqz+Q3UfnYXuNPrHv6ZTCuS5FNytWbD9qp
        LBA47K2kg1+Vzu1WwcFlef0c1xk7
X-Google-Smtp-Source: APXvYqxr9CrLjDlEfOSYVeO0n/+bT17NYlRg9gYEeeiKtzWWHfOBHJN0VkvlTQ6oziEol52ljnOMKw==
X-Received: by 2002:a19:f811:: with SMTP id a17mr7795071lff.182.1581551198795;
        Wed, 12 Feb 2020 15:46:38 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id u15sm234453lfl.87.2020.02.12.15.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 15:46:38 -0800 (PST)
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
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 08/12] dt-bindings: cpufreq: Add binding for NVIDIA Tegra20/30
Date:   Thu, 13 Feb 2020 02:46:03 +0300
Message-Id: <20200212234607.11521-9-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200212234607.11521-1-digetx@gmail.com>
References: <20200212234607.11521-1-digetx@gmail.com>
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
Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Marcel Ziswiler <marcel@ziswiler.com>
Tested-by: Jasper Korten <jja2000@gmail.com>
Tested-by: David Heidelberg <david@ixit.cz>
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

