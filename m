Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12162BFD69
	for <lists+linux-pm@lfdr.de>; Mon, 23 Nov 2020 01:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgKWAbi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 22 Nov 2020 19:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgKWAbh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Nov 2020 19:31:37 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866A4C0613CF;
        Sun, 22 Nov 2020 16:31:35 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id a9so21452491lfh.2;
        Sun, 22 Nov 2020 16:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7OvydWlfMXgO/KNOaprymyQ2ECcFyi64JacxpdVtbzc=;
        b=ES3jJEuM3Dq7+isH6lUcIeR/O03fqJKTS1R0WwOD3vzqxSZNVEJOWOZ5ckmDinym0+
         vRHyDO3cNjHUk4KaXtVn/dJdQ+Bwv4WBJXcRYtqt4zddvS0nz+8nWHZS1SxN9E2UCsBu
         KWnFSejnVFWua3Ko+XwM7e0apHxPciuplT4mCtb4KFw78BpNQMfTIpXAK0jjXR4yPjSS
         4m1wme42haED1zgXk/PmNkK8MlJldvav/8G7hVi+Jxmd4VlWj5qHcEbM+QFYBcD4JJr9
         EgaQZHxWj1Nexzi8FfmAmHzeQi2dBXfPltMomnUldlgXjAKVEqAZtjeKyOPTC5xRSw+b
         LCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7OvydWlfMXgO/KNOaprymyQ2ECcFyi64JacxpdVtbzc=;
        b=cP/ZS1hGVYZiyQrVxTKkpm3HJNSI097Go3rJkJGWH0bapsRxLBgNp70Ig9xeg3MGS/
         viwUGp0H5qAcRWRuAz/NEpM5Cl/qjai7pyPdquvnvBDgWdVqRQ8tM2s8VMumLL2sFFU2
         1hn+a3A7/dcRJL2Bu1T9TFnDn2MD/XnLznoYtkCCsUi6U7MG2QqGrll9EUL++eQQlFdJ
         aKWrEr9fsY0k5DxFg3FUD5mcofxGPxkbXEPIGeBZbo+6NlBlqDkkhon+vmwCYkDQsgjK
         5qGWGExnjXSofT+1qTm6EwmZsZycf2ZmIirYKaYUT1XduK8HzFtByqee7du7x5PYhpbg
         4pWQ==
X-Gm-Message-State: AOAM533kOc2dHv9v0jcVPPAR7VgSuXrFqIymMNWGwaunQs2H3sxp3sa4
        OX5EDL6y7rws90EiZtZaj1A=
X-Google-Smtp-Source: ABdhPJwtawPyXGRV72VOoSsuj3T/a97TSkgvj1FngOPmKrUtA+61JwHsa8WuU1G7xLZsXckd+Nm5eg==
X-Received: by 2002:a19:6d8:: with SMTP id 207mr2262975lfg.42.1606091494031;
        Sun, 22 Nov 2020 16:31:34 -0800 (PST)
Received: from localhost.localdomain (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.gmail.com with ESMTPSA id r27sm1225823lfn.290.2020.11.22.16.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 16:31:33 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v10 18/19] ARM: tegra: Add EMC OPP and ICC properties to Tegra30 EMC and ACTMON device-tree nodes
Date:   Mon, 23 Nov 2020 03:27:22 +0300
Message-Id: <20201123002723.28463-19-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201123002723.28463-1-digetx@gmail.com>
References: <20201123002723.28463-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add EMC OPP tables and interconnect paths that will be used for
dynamic memory bandwidth scaling based on memory utilization statistics.
Update board device-trees by removing unsupported EMC OPPs.

Note that ACTMON watches all memory interconnect paths, but we use a
single CPU-READ interconnect path for driving memory bandwidth, for
simplicity.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 ...30-asus-nexus7-grouper-memory-timings.dtsi |  12 +
 arch/arm/boot/dts/tegra30-ouya.dts            |   8 +
 .../arm/boot/dts/tegra30-peripherals-opp.dtsi | 383 ++++++++++++++++++
 arch/arm/boot/dts/tegra30.dtsi                |   6 +
 4 files changed, 409 insertions(+)
 create mode 100644 arch/arm/boot/dts/tegra30-peripherals-opp.dtsi

diff --git a/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-memory-timings.dtsi b/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-memory-timings.dtsi
index bc0f6f29b956..bcff0997ee51 100644
--- a/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-memory-timings.dtsi
+++ b/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-memory-timings.dtsi
@@ -1563,3 +1563,15 @@ timing-667000000 {
 		};
 	};
 };
+
+&emc_icc_dvfs_opp_table {
+	/delete-node/ opp@750000000,1300;
+	/delete-node/ opp@800000000,1300;
+	/delete-node/ opp@900000000,1350;
+};
+
+&emc_bw_dfs_opp_table {
+	/delete-node/ opp@750000000;
+	/delete-node/ opp@800000000;
+	/delete-node/ opp@900000000;
+};
diff --git a/arch/arm/boot/dts/tegra30-ouya.dts b/arch/arm/boot/dts/tegra30-ouya.dts
index a5f16ad6c8f4..74da1360d297 100644
--- a/arch/arm/boot/dts/tegra30-ouya.dts
+++ b/arch/arm/boot/dts/tegra30-ouya.dts
@@ -4509,3 +4509,11 @@ drive_groups {
 		nvidia,slew-rate-falling = <TEGRA_PIN_SLEW_RATE_SLOWEST>;
 	};
 };
+
+&emc_icc_dvfs_opp_table {
+	/delete-node/ opp@900000000,1350;
+};
+
+&emc_bw_dfs_opp_table {
+	/delete-node/ opp@900000000;
+};
diff --git a/arch/arm/boot/dts/tegra30-peripherals-opp.dtsi b/arch/arm/boot/dts/tegra30-peripherals-opp.dtsi
new file mode 100644
index 000000000000..cbe84d25e726
--- /dev/null
+++ b/arch/arm/boot/dts/tegra30-peripherals-opp.dtsi
@@ -0,0 +1,383 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/ {
+	emc_icc_dvfs_opp_table: emc-dvfs-opp-table {
+		compatible = "operating-points-v2";
+
+		opp@12750000,950 {
+			opp-microvolt = <950000 950000 1350000>;
+			opp-hz = /bits/ 64 <12750000>;
+			opp-supported-hw = <0x0006>;
+		};
+
+		opp@12750000,1000 {
+			opp-microvolt = <1000000 1000000 1350000>;
+			opp-hz = /bits/ 64 <12750000>;
+			opp-supported-hw = <0x0001>;
+		};
+
+		opp@12750000,1250 {
+			opp-microvolt = <1250000 1250000 1350000>;
+			opp-hz = /bits/ 64 <12750000>;
+			opp-supported-hw = <0x0008>;
+		};
+
+		opp@25500000,950 {
+			opp-microvolt = <950000 950000 1350000>;
+			opp-hz = /bits/ 64 <25500000>;
+			opp-supported-hw = <0x0006>;
+		};
+
+		opp@25500000,1000 {
+			opp-microvolt = <1000000 1000000 1350000>;
+			opp-hz = /bits/ 64 <25500000>;
+			opp-supported-hw = <0x0001>;
+		};
+
+		opp@25500000,1250 {
+			opp-microvolt = <1250000 1250000 1350000>;
+			opp-hz = /bits/ 64 <25500000>;
+			opp-supported-hw = <0x0008>;
+		};
+
+		opp@27000000,950 {
+			opp-microvolt = <950000 950000 1350000>;
+			opp-hz = /bits/ 64 <27000000>;
+			opp-supported-hw = <0x0006>;
+		};
+
+		opp@27000000,1000 {
+			opp-microvolt = <1000000 1000000 1350000>;
+			opp-hz = /bits/ 64 <27000000>;
+			opp-supported-hw = <0x0001>;
+		};
+
+		opp@27000000,1250 {
+			opp-microvolt = <1250000 1250000 1350000>;
+			opp-hz = /bits/ 64 <27000000>;
+			opp-supported-hw = <0x0008>;
+		};
+
+		opp@51000000,950 {
+			opp-microvolt = <950000 950000 1350000>;
+			opp-hz = /bits/ 64 <51000000>;
+			opp-supported-hw = <0x0006>;
+		};
+
+		opp@51000000,1000 {
+			opp-microvolt = <1000000 1000000 1350000>;
+			opp-hz = /bits/ 64 <51000000>;
+			opp-supported-hw = <0x0001>;
+		};
+
+		opp@51000000,1250 {
+			opp-microvolt = <1250000 1250000 1350000>;
+			opp-hz = /bits/ 64 <51000000>;
+			opp-supported-hw = <0x0008>;
+		};
+
+		opp@54000000,950 {
+			opp-microvolt = <950000 950000 1350000>;
+			opp-hz = /bits/ 64 <54000000>;
+			opp-supported-hw = <0x0006>;
+		};
+
+		opp@54000000,1000 {
+			opp-microvolt = <1000000 1000000 1350000>;
+			opp-hz = /bits/ 64 <54000000>;
+			opp-supported-hw = <0x0001>;
+		};
+
+		opp@54000000,1250 {
+			opp-microvolt = <1250000 1250000 1350000>;
+			opp-hz = /bits/ 64 <54000000>;
+			opp-supported-hw = <0x0008>;
+		};
+
+		opp@102000000,950 {
+			opp-microvolt = <950000 950000 1350000>;
+			opp-hz = /bits/ 64 <102000000>;
+			opp-supported-hw = <0x0006>;
+		};
+
+		opp@102000000,1000 {
+			opp-microvolt = <1000000 1000000 1350000>;
+			opp-hz = /bits/ 64 <102000000>;
+			opp-supported-hw = <0x0001>;
+		};
+
+		opp@102000000,1250 {
+			opp-microvolt = <1250000 1250000 1350000>;
+			opp-hz = /bits/ 64 <102000000>;
+			opp-supported-hw = <0x0008>;
+		};
+
+		opp@108000000,1000 {
+			opp-microvolt = <1000000 1000000 1350000>;
+			opp-hz = /bits/ 64 <108000000>;
+			opp-supported-hw = <0x0007>;
+		};
+
+		opp@108000000,1250 {
+			opp-microvolt = <1250000 1250000 1350000>;
+			opp-hz = /bits/ 64 <108000000>;
+			opp-supported-hw = <0x0008>;
+		};
+
+		opp@204000000,1000 {
+			opp-microvolt = <1000000 1000000 1350000>;
+			opp-hz = /bits/ 64 <204000000>;
+			opp-supported-hw = <0x0007>;
+		};
+
+		opp@204000000,1250 {
+			opp-microvolt = <1250000 1250000 1350000>;
+			opp-hz = /bits/ 64 <204000000>;
+			opp-supported-hw = <0x0008>;
+		};
+
+		opp@333500000,1000 {
+			opp-microvolt = <1000000 1000000 1350000>;
+			opp-hz = /bits/ 64 <333500000>;
+			opp-supported-hw = <0x0006>;
+		};
+
+		opp@333500000,1200 {
+			opp-microvolt = <1200000 1200000 1350000>;
+			opp-hz = /bits/ 64 <333500000>;
+			opp-supported-hw = <0x0001>;
+		};
+
+		opp@333500000,1250 {
+			opp-microvolt = <1250000 1250000 1350000>;
+			opp-hz = /bits/ 64 <333500000>;
+			opp-supported-hw = <0x0008>;
+		};
+
+		opp@375000000,1000 {
+			opp-microvolt = <1000000 1000000 1350000>;
+			opp-hz = /bits/ 64 <375000000>;
+			opp-supported-hw = <0x0006>;
+		};
+
+		opp@375000000,1200 {
+			opp-microvolt = <1200000 1200000 1350000>;
+			opp-hz = /bits/ 64 <375000000>;
+			opp-supported-hw = <0x0001>;
+		};
+
+		opp@375000000,1250 {
+			opp-microvolt = <1250000 1250000 1350000>;
+			opp-hz = /bits/ 64 <375000000>;
+			opp-supported-hw = <0x0008>;
+		};
+
+		opp@400000000,1000 {
+			opp-microvolt = <1000000 1000000 1350000>;
+			opp-hz = /bits/ 64 <400000000>;
+			opp-supported-hw = <0x0006>;
+		};
+
+		opp@400000000,1200 {
+			opp-microvolt = <1200000 1200000 1350000>;
+			opp-hz = /bits/ 64 <400000000>;
+			opp-supported-hw = <0x0001>;
+		};
+
+		opp@400000000,1250 {
+			opp-microvolt = <1250000 1250000 1350000>;
+			opp-hz = /bits/ 64 <400000000>;
+			opp-supported-hw = <0x0008>;
+		};
+
+		opp@416000000,1200 {
+			opp-microvolt = <1200000 1200000 1350000>;
+			opp-hz = /bits/ 64 <416000000>;
+			opp-supported-hw = <0x0007>;
+		};
+
+		opp@416000000,1250 {
+			opp-microvolt = <1250000 1250000 1350000>;
+			opp-hz = /bits/ 64 <416000000>;
+			opp-supported-hw = <0x0008>;
+		};
+
+		opp@450000000,1200 {
+			opp-microvolt = <1200000 1200000 1350000>;
+			opp-hz = /bits/ 64 <450000000>;
+			opp-supported-hw = <0x0007>;
+		};
+
+		opp@450000000,1250 {
+			opp-microvolt = <1250000 1250000 1350000>;
+			opp-hz = /bits/ 64 <450000000>;
+			opp-supported-hw = <0x0008>;
+		};
+
+		opp@533000000,1200 {
+			opp-microvolt = <1200000 1200000 1350000>;
+			opp-hz = /bits/ 64 <533000000>;
+			opp-supported-hw = <0x0007>;
+		};
+
+		opp@533000000,1250 {
+			opp-microvolt = <1250000 1250000 1350000>;
+			opp-hz = /bits/ 64 <533000000>;
+			opp-supported-hw = <0x0008>;
+		};
+
+		opp@625000000,1200 {
+			opp-microvolt = <1200000 1200000 1350000>;
+			opp-hz = /bits/ 64 <625000000>;
+			opp-supported-hw = <0x0006>;
+		};
+
+		opp@625000000,1250 {
+			opp-microvolt = <1250000 1250000 1350000>;
+			opp-hz = /bits/ 64 <625000000>;
+			opp-supported-hw = <0x0008>;
+		};
+
+		opp@667000000,1200 {
+			opp-microvolt = <1200000 1200000 1350000>;
+			opp-hz = /bits/ 64 <667000000>;
+			opp-supported-hw = <0x0006>;
+		};
+
+		opp@750000000,1300 {
+			opp-microvolt = <1300000 1300000 1350000>;
+			opp-hz = /bits/ 64 <750000000>;
+			opp-supported-hw = <0x0004>;
+		};
+
+		opp@800000000,1300 {
+			opp-microvolt = <1300000 1300000 1350000>;
+			opp-hz = /bits/ 64 <800000000>;
+			opp-supported-hw = <0x0004>;
+		};
+
+		opp@900000000,1350 {
+			opp-microvolt = <1350000 1350000 1350000>;
+			opp-hz = /bits/ 64 <900000000>;
+			opp-supported-hw = <0x0004>;
+		};
+	};
+
+	emc_bw_dfs_opp_table: emc-bandwidth-opp-table {
+		compatible = "operating-points-v2";
+
+		opp@12750000 {
+			opp-hz = /bits/ 64 <12750000>;
+			opp-supported-hw = <0x000F>;
+			opp-peak-kBps = <102000>;
+		};
+
+		opp@25500000 {
+			opp-hz = /bits/ 64 <25500000>;
+			opp-supported-hw = <0x000F>;
+			opp-peak-kBps = <204000>;
+		};
+
+		opp@27000000 {
+			opp-hz = /bits/ 64 <27000000>;
+			opp-supported-hw = <0x000F>;
+			opp-peak-kBps = <216000>;
+		};
+
+		opp@51000000 {
+			opp-hz = /bits/ 64 <51000000>;
+			opp-supported-hw = <0x000F>;
+			opp-peak-kBps = <408000>;
+		};
+
+		opp@54000000 {
+			opp-hz = /bits/ 64 <54000000>;
+			opp-supported-hw = <0x000F>;
+			opp-peak-kBps = <432000>;
+		};
+
+		opp@102000000 {
+			opp-hz = /bits/ 64 <102000000>;
+			opp-supported-hw = <0x000F>;
+			opp-peak-kBps = <816000>;
+		};
+
+		opp@108000000 {
+			opp-hz = /bits/ 64 <108000000>;
+			opp-supported-hw = <0x000F>;
+			opp-peak-kBps = <864000>;
+		};
+
+		opp@204000000 {
+			opp-hz = /bits/ 64 <204000000>;
+			opp-supported-hw = <0x000F>;
+			opp-peak-kBps = <1632000>;
+		};
+
+		opp@333500000 {
+			opp-hz = /bits/ 64 <333500000>;
+			opp-supported-hw = <0x000F>;
+			opp-peak-kBps = <2668000>;
+		};
+
+		opp@375000000 {
+			opp-hz = /bits/ 64 <375000000>;
+			opp-supported-hw = <0x000F>;
+			opp-peak-kBps = <3000000>;
+		};
+
+		opp@400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-supported-hw = <0x000F>;
+			opp-peak-kBps = <3200000>;
+		};
+
+		opp@416000000 {
+			opp-hz = /bits/ 64 <416000000>;
+			opp-supported-hw = <0x000F>;
+			opp-peak-kBps = <3328000>;
+		};
+
+		opp@450000000 {
+			opp-hz = /bits/ 64 <450000000>;
+			opp-supported-hw = <0x000F>;
+			opp-peak-kBps = <3600000>;
+		};
+
+		opp@533000000 {
+			opp-hz = /bits/ 64 <533000000>;
+			opp-supported-hw = <0x000F>;
+			opp-peak-kBps = <4264000>;
+		};
+
+		opp@625000000 {
+			opp-hz = /bits/ 64 <625000000>;
+			opp-supported-hw = <0x000E>;
+			opp-peak-kBps = <5000000>;
+		};
+
+		opp@667000000 {
+			opp-hz = /bits/ 64 <667000000>;
+			opp-supported-hw = <0x0006>;
+			opp-peak-kBps = <5336000>;
+		};
+
+		opp@750000000 {
+			opp-hz = /bits/ 64 <750000000>;
+			opp-supported-hw = <0x0004>;
+			opp-peak-kBps = <6000000>;
+		};
+
+		opp@800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-supported-hw = <0x0004>;
+			opp-peak-kBps = <6400000>;
+		};
+
+		opp@900000000 {
+			opp-hz = /bits/ 64 <900000000>;
+			opp-supported-hw = <0x0004>;
+			opp-peak-kBps = <7200000>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 2caf6cc6f4b1..44a6dbba7081 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -6,6 +6,8 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/soc/tegra-pmc.h>
 
+#include "tegra30-peripherals-opp.dtsi"
+
 / {
 	compatible = "nvidia,tegra30";
 	interrupt-parent = <&lic>;
@@ -417,6 +419,9 @@ actmon@6000c800 {
 		clock-names = "actmon", "emc";
 		resets = <&tegra_car TEGRA30_CLK_ACTMON>;
 		reset-names = "actmon";
+		operating-points-v2 = <&emc_bw_dfs_opp_table>;
+		interconnects = <&mc TEGRA30_MC_MPCORER &emc>;
+		interconnect-names = "cpu-read";
 	};
 
 	gpio: gpio@6000d000 {
@@ -780,6 +785,7 @@ emc: memory-controller@7000f400 {
 		clocks = <&tegra_car TEGRA30_CLK_EMC>;
 
 		nvidia,memory-controller = <&mc>;
+		operating-points-v2 = <&emc_icc_dvfs_opp_table>;
 
 		#interconnect-cells = <0>;
 	};
-- 
2.29.2

