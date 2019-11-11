Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98A74F81B8
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 21:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfKKU5R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 15:57:17 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36234 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbfKKU5P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Nov 2019 15:57:15 -0500
Received: by mail-lj1-f194.google.com with SMTP id k15so15326887lja.3;
        Mon, 11 Nov 2019 12:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UXRoHcvapztDcfGo7L2UwrKkYpLR6LIFA1LRvGGCLHM=;
        b=Y16K0lf1r0c5r7b0QZvjXDo856Bo2h0g3Vx8rA5ctOptD5GgpVn8RFRS7zHiQ8OQTW
         uLflg/MGAAckyQa6JdkhIr6QF/nbwGWVVVDY37UYqeDCgaWp4xbYTFbB/9+TQO8o7MRx
         o/y6DlTOmqv93+bt8jBGi4hm3X/UY8m+AGoQfJU/5v2u4/kA+d5X1WHqWnjQGiv07Y/p
         SFTmYN2AUM3MZqgtorAttIIpuSFGUvQ5oW7fzjkNlZMEA1F0qZcpsHVz7rVGY87aCHVx
         UUTsWi5NaiBQQ92aPO72QOm5q6xLuqFe/Y/TAjT2owFCAlqV2Uy6tzmT4OvNGdxWwBXz
         s7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UXRoHcvapztDcfGo7L2UwrKkYpLR6LIFA1LRvGGCLHM=;
        b=nOBGOwhXSFsVBIsqFpzbl+zUKFY/nsfA1XkOH48NNEOzXxPMMFeZur4QqArekiUm0D
         gR3mIJ7M4EdczhTKeTojkVpTFkUyHuTVc3EhNUTmXhPvpLuUDlkYycmRBmfFOGXzgXPy
         0II5TyzKzLydV6B0YeoEeTZuYho1D10MiUSSPsL6w3YbrukUuytSpeC2VwHJGLRwz8jm
         fJpIH34Py/vpIXQg9xoHxc0Rc4maWLZnk1vHkiEZIapEyqhjbVahbSMerKlvbvwW4bsU
         6EQ8hVgRdCqIHUeA7xpp4au2DloXV9spZaphmrnOTvLpQxZfaoK+ed3j4ldMu+BTXAe6
         UM/Q==
X-Gm-Message-State: APjAAAU9pa3CKfnm1Poz+8oONRlZqOMpJPC1+MMspF1OKapZlVmqpfGC
        Ohld0wE69Evd7sjNtpeUtd0=
X-Google-Smtp-Source: APXvYqyn0cx5YoyDXdIo5U0gzTbcs7JM4k2XHDa0/67O1r+p7CJ1LHcpUtT9Brf+sl4f6ssDZ8fRAQ==
X-Received: by 2002:a2e:8855:: with SMTP id z21mr3588643ljj.212.1573505833382;
        Mon, 11 Nov 2019 12:57:13 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id q124sm7423784ljq.93.2019.11.11.12.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 12:57:12 -0800 (PST)
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
Subject: [PATCH v4 06/10] dt-bindings: cpufreq: Add binding for NVIDIA Tegra20/30
Date:   Mon, 11 Nov 2019 23:54:15 +0300
Message-Id: <20191111205419.16768-7-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191111205419.16768-1-digetx@gmail.com>
References: <20191111205419.16768-1-digetx@gmail.com>
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

