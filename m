Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47DBC2BFD75
	for <lists+linux-pm@lfdr.de>; Mon, 23 Nov 2020 01:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbgKWAbj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 22 Nov 2020 19:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727489AbgKWAbi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Nov 2020 19:31:38 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE956C061A4A;
        Sun, 22 Nov 2020 16:31:36 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id u18so21416833lfd.9;
        Sun, 22 Nov 2020 16:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C+ZejMZBwTITHgd+60JV9BgPIyky09ffml3Xu0dz0Og=;
        b=T/m3D0LgFz8/h6Msy392ZYJwYP9+ZVlKv3DpS7AUvx1b8rI2nDpU1S8vfm+YWgWITB
         GN4Nxl7ZCJO9DG1/6ysarjGb8y1V3Vm7JzX3EKNEc4aTSiKJiGAMFHH8mRyi0e6le5Ux
         1N8bokTDbLHEevCqo3VVa5xgs3hay4zYuhxVT0hViCkaO5TtibS+/TaB5WGCEvEx+54I
         hE9tMJsUe28zQPD71kPdmHoy+6HFmR9exCBmgPx92avolreGbuKj7K7uVqTQntwvIQUi
         TX10i3Gnt37D8zPEkIstzuah16SPTxraBRdhiWCDqm+q1hFrsM2CM+otBLR2RVu7dj7J
         CNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C+ZejMZBwTITHgd+60JV9BgPIyky09ffml3Xu0dz0Og=;
        b=dJV5C+zamzdiKUjfyTp5pyaR1y9hFwZ4ltw1HPu+Q6yZ1HPTly768KsKZTdYpw7S7k
         p8WGjmB7E6Mpx2wyW6KCqU4Rv/AoVuicw/AKqksfHoJGRhlMlY3nCP2NLQHJZ43Z2g7I
         7LGCqbJ8kKomM1ljKf3P7kn4afgDbARP7crAyFt185IWLosxZDexoMxgshjsXXFDaNzN
         JYnEJdP8tnHwnh2V9E8tM/BXMhNomyfJMWK3V4v/xO59vZIT/I1WSABL2ySspN0iXxDJ
         fPg/+QS0bPcY2ExufhIegsC/5cdjG9V8QQP8pvSq/q8ifWQV2vSEtxGQAihCZm8rH4TN
         clRg==
X-Gm-Message-State: AOAM531PhO9jMocCJuVDcic2cUeLg+ymnGXzOZui4LHfUtSciyvbIDji
        iGSGPjtKr+Jn6Y+R7d/NySI=
X-Google-Smtp-Source: ABdhPJwBDxvpKb6vg8p256OBFDDnZwVytcvk3JXvOGxJIdOogg2AtfHYcvQ8ooQFShH/9qvx+sVCAw==
X-Received: by 2002:a19:c847:: with SMTP id y68mr13679738lff.325.1606091495174;
        Sun, 22 Nov 2020 16:31:35 -0800 (PST)
Received: from localhost.localdomain (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.gmail.com with ESMTPSA id r27sm1225823lfn.290.2020.11.22.16.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 16:31:34 -0800 (PST)
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
Subject: [PATCH v10 19/19] ARM: tegra: Add EMC OPP and ICC properties to Tegra124 EMC and ACTMON device-tree nodes
Date:   Mon, 23 Nov 2020 03:27:23 +0300
Message-Id: <20201123002723.28463-20-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201123002723.28463-1-digetx@gmail.com>
References: <20201123002723.28463-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add EMC OPP DVFS/DFS tables and interconnect paths that will be used for
dynamic memory bandwidth scaling based on memory utilization statistics.
Update board device-trees by removing unsupported EMC OPPs.

Note that ACTMON watches all memory interconnect paths, but we use a
single CPU-READ interconnect path for driving memory bandwidth, for
simplicity.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra124-apalis-emc.dtsi    |   8 +
 .../arm/boot/dts/tegra124-jetson-tk1-emc.dtsi |   8 +
 arch/arm/boot/dts/tegra124-nyan-big-emc.dtsi  |  10 +
 .../arm/boot/dts/tegra124-nyan-blaze-emc.dtsi |  10 +
 .../boot/dts/tegra124-peripherals-opp.dtsi    | 419 ++++++++++++++++++
 arch/arm/boot/dts/tegra124.dtsi               |   6 +
 6 files changed, 461 insertions(+)
 create mode 100644 arch/arm/boot/dts/tegra124-peripherals-opp.dtsi

diff --git a/arch/arm/boot/dts/tegra124-apalis-emc.dtsi b/arch/arm/boot/dts/tegra124-apalis-emc.dtsi
index 32401457ae71..a7ac805eeed5 100644
--- a/arch/arm/boot/dts/tegra124-apalis-emc.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis-emc.dtsi
@@ -1465,3 +1465,11 @@ timing-924000000 {
 		};
 	};
 };
+
+&emc_icc_dvfs_opp_table {
+	/delete-node/ opp@1200000000,1100;
+};
+
+&emc_bw_dfs_opp_table {
+	/delete-node/ opp@1200000000;
+};
diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1-emc.dtsi b/arch/arm/boot/dts/tegra124-jetson-tk1-emc.dtsi
index 861d3f22116b..df4e463afbd1 100644
--- a/arch/arm/boot/dts/tegra124-jetson-tk1-emc.dtsi
+++ b/arch/arm/boot/dts/tegra124-jetson-tk1-emc.dtsi
@@ -2420,3 +2420,11 @@ timing-924000000 {
 		};
 	};
 };
+
+&emc_icc_dvfs_opp_table {
+	/delete-node/ opp@1200000000,1100;
+};
+
+&emc_bw_dfs_opp_table {
+	/delete-node/ opp@1200000000;
+};
diff --git a/arch/arm/boot/dts/tegra124-nyan-big-emc.dtsi b/arch/arm/boot/dts/tegra124-nyan-big-emc.dtsi
index c91647d13a50..a0f56cc9da5c 100644
--- a/arch/arm/boot/dts/tegra124-nyan-big-emc.dtsi
+++ b/arch/arm/boot/dts/tegra124-nyan-big-emc.dtsi
@@ -6649,3 +6649,13 @@ timing-792000000 {
 		};
 	};
 };
+
+&emc_icc_dvfs_opp_table {
+	/delete-node/ opp@924000000,1100;
+	/delete-node/ opp@1200000000,1100;
+};
+
+&emc_bw_dfs_opp_table {
+	/delete-node/ opp@924000000;
+	/delete-node/ opp@1200000000;
+};
diff --git a/arch/arm/boot/dts/tegra124-nyan-blaze-emc.dtsi b/arch/arm/boot/dts/tegra124-nyan-blaze-emc.dtsi
index d2beea0bd15f..35c98734d35f 100644
--- a/arch/arm/boot/dts/tegra124-nyan-blaze-emc.dtsi
+++ b/arch/arm/boot/dts/tegra124-nyan-blaze-emc.dtsi
@@ -2048,3 +2048,13 @@ timing-792000000 {
 		};
 	};
 };
+
+&emc_icc_dvfs_opp_table {
+	/delete-node/ opp@924000000,1100;
+	/delete-node/ opp@1200000000,1100;
+};
+
+&emc_bw_dfs_opp_table {
+	/delete-node/ opp@924000000;
+	/delete-node/ opp@1200000000;
+};
diff --git a/arch/arm/boot/dts/tegra124-peripherals-opp.dtsi b/arch/arm/boot/dts/tegra124-peripherals-opp.dtsi
new file mode 100644
index 000000000000..49d9420a3289
--- /dev/null
+++ b/arch/arm/boot/dts/tegra124-peripherals-opp.dtsi
@@ -0,0 +1,419 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/ {
+	emc_icc_dvfs_opp_table: emc-dvfs-opp-table {
+		compatible = "operating-points-v2";
+
+		opp@12750000,800 {
+			opp-microvolt = <800000 800000 1150000>;
+			opp-hz = /bits/ 64 <12750000>;
+			opp-supported-hw = <0x0003>;
+		};
+
+		opp@12750000,950 {
+			opp-microvolt = <950000 950000 1150000>;
+			opp-hz = /bits/ 64 <12750000>;
+			opp-supported-hw = <0x0008>;
+		};
+
+		opp@12750000,1050 {
+			opp-microvolt = <1050000 1050000 1150000>;
+			opp-hz = /bits/ 64 <12750000>;
+			opp-supported-hw = <0x0010>;
+		};
+
+		opp@12750000,1110 {
+			opp-microvolt = <1110000 1110000 1150000>;
+			opp-hz = /bits/ 64 <12750000>;
+			opp-supported-hw = <0x0004>;
+		};
+
+		opp@20400000,800 {
+			opp-microvolt = <800000 800000 1150000>;
+			opp-hz = /bits/ 64 <20400000>;
+			opp-supported-hw = <0x0003>;
+		};
+
+		opp@20400000,950 {
+			opp-microvolt = <950000 950000 1150000>;
+			opp-hz = /bits/ 64 <20400000>;
+			opp-supported-hw = <0x0008>;
+		};
+
+		opp@20400000,1050 {
+			opp-microvolt = <1050000 1050000 1150000>;
+			opp-hz = /bits/ 64 <20400000>;
+			opp-supported-hw = <0x0010>;
+		};
+
+		opp@20400000,1110 {
+			opp-microvolt = <1110000 1110000 1150000>;
+			opp-hz = /bits/ 64 <20400000>;
+			opp-supported-hw = <0x0004>;
+		};
+
+		opp@40800000,800 {
+			opp-microvolt = <800000 800000 1150000>;
+			opp-hz = /bits/ 64 <40800000>;
+			opp-supported-hw = <0x0003>;
+		};
+
+		opp@40800000,950 {
+			opp-microvolt = <950000 950000 1150000>;
+			opp-hz = /bits/ 64 <40800000>;
+			opp-supported-hw = <0x0008>;
+		};
+
+		opp@40800000,1050 {
+			opp-microvolt = <1050000 1050000 1150000>;
+			opp-hz = /bits/ 64 <40800000>;
+			opp-supported-hw = <0x0010>;
+		};
+
+		opp@40800000,1110 {
+			opp-microvolt = <1110000 1110000 1150000>;
+			opp-hz = /bits/ 64 <40800000>;
+			opp-supported-hw = <0x0004>;
+		};
+
+		opp@68000000,800 {
+			opp-microvolt = <800000 800000 1150000>;
+			opp-hz = /bits/ 64 <68000000>;
+			opp-supported-hw = <0x0003>;
+		};
+
+		opp@68000000,950 {
+			opp-microvolt = <950000 950000 1150000>;
+			opp-hz = /bits/ 64 <68000000>;
+			opp-supported-hw = <0x0008>;
+		};
+
+		opp@68000000,1050 {
+			opp-microvolt = <1050000 1050000 1150000>;
+			opp-hz = /bits/ 64 <68000000>;
+			opp-supported-hw = <0x0010>;
+		};
+
+		opp@68000000,1110 {
+			opp-microvolt = <1110000 1110000 1150000>;
+			opp-hz = /bits/ 64 <68000000>;
+			opp-supported-hw = <0x0004>;
+		};
+
+		opp@102000000,800 {
+			opp-microvolt = <800000 800000 1150000>;
+			opp-hz = /bits/ 64 <102000000>;
+			opp-supported-hw = <0x0003>;
+		};
+
+		opp@102000000,950 {
+			opp-microvolt = <950000 950000 1150000>;
+			opp-hz = /bits/ 64 <102000000>;
+			opp-supported-hw = <0x0008>;
+		};
+
+		opp@102000000,1050 {
+			opp-microvolt = <1050000 1050000 1150000>;
+			opp-hz = /bits/ 64 <102000000>;
+			opp-supported-hw = <0x0010>;
+		};
+
+		opp@102000000,1110 {
+			opp-microvolt = <1110000 1110000 1150000>;
+			opp-hz = /bits/ 64 <102000000>;
+			opp-supported-hw = <0x0004>;
+		};
+
+		opp@204000000,800 {
+			opp-microvolt = <800000 800000 1150000>;
+			opp-hz = /bits/ 64 <204000000>;
+			opp-supported-hw = <0x0003>;
+		};
+
+		opp@204000000,950 {
+			opp-microvolt = <950000 950000 1150000>;
+			opp-hz = /bits/ 64 <204000000>;
+			opp-supported-hw = <0x0008>;
+		};
+
+		opp@204000000,1050 {
+			opp-microvolt = <1050000 1050000 1150000>;
+			opp-hz = /bits/ 64 <204000000>;
+			opp-supported-hw = <0x0010>;
+		};
+
+		opp@204000000,1110 {
+			opp-microvolt = <1110000 1110000 1150000>;
+			opp-hz = /bits/ 64 <204000000>;
+			opp-supported-hw = <0x0004>;
+		};
+
+		opp@264000000,800 {
+			opp-microvolt = <800000 800000 1150000>;
+			opp-hz = /bits/ 64 <264000000>;
+			opp-supported-hw = <0x0003>;
+		};
+
+		opp@264000000,950 {
+			opp-microvolt = <950000 950000 1150000>;
+			opp-hz = /bits/ 64 <264000000>;
+			opp-supported-hw = <0x0008>;
+		};
+
+		opp@264000000,1050 {
+			opp-microvolt = <1050000 1050000 1150000>;
+			opp-hz = /bits/ 64 <264000000>;
+			opp-supported-hw = <0x0010>;
+		};
+
+		opp@264000000,1110 {
+			opp-microvolt = <1110000 1110000 1150000>;
+			opp-hz = /bits/ 64 <264000000>;
+			opp-supported-hw = <0x0004>;
+		};
+
+		opp@300000000,850 {
+			opp-microvolt = <850000 850000 1150000>;
+			opp-hz = /bits/ 64 <300000000>;
+			opp-supported-hw = <0x0003>;
+		};
+
+		opp@300000000,950 {
+			opp-microvolt = <950000 950000 1150000>;
+			opp-hz = /bits/ 64 <300000000>;
+			opp-supported-hw = <0x0008>;
+		};
+
+		opp@300000000,1050 {
+			opp-microvolt = <1050000 1050000 1150000>;
+			opp-hz = /bits/ 64 <300000000>;
+			opp-supported-hw = <0x0010>;
+		};
+
+		opp@300000000,1110 {
+			opp-microvolt = <1110000 1110000 1150000>;
+			opp-hz = /bits/ 64 <300000000>;
+			opp-supported-hw = <0x0004>;
+		};
+
+		opp@348000000,850 {
+			opp-microvolt = <850000 850000 1150000>;
+			opp-hz = /bits/ 64 <348000000>;
+			opp-supported-hw = <0x0003>;
+		};
+
+		opp@348000000,950 {
+			opp-microvolt = <950000 950000 1150000>;
+			opp-hz = /bits/ 64 <348000000>;
+			opp-supported-hw = <0x0008>;
+		};
+
+		opp@348000000,1050 {
+			opp-microvolt = <1050000 1050000 1150000>;
+			opp-hz = /bits/ 64 <348000000>;
+			opp-supported-hw = <0x0010>;
+		};
+
+		opp@348000000,1110 {
+			opp-microvolt = <1110000 1110000 1150000>;
+			opp-hz = /bits/ 64 <348000000>;
+			opp-supported-hw = <0x0004>;
+		};
+
+		opp@396000000,950 {
+			opp-microvolt = <950000 950000 1150000>;
+			opp-hz = /bits/ 64 <396000000>;
+			opp-supported-hw = <0x0008>;
+		};
+
+		opp@396000000,1000 {
+			opp-microvolt = <1000000 1000000 1150000>;
+			opp-hz = /bits/ 64 <396000000>;
+			opp-supported-hw = <0x0003>;
+		};
+
+		opp@396000000,1050 {
+			opp-microvolt = <1050000 1050000 1150000>;
+			opp-hz = /bits/ 64 <396000000>;
+			opp-supported-hw = <0x0010>;
+		};
+
+		opp@396000000,1110 {
+			opp-microvolt = <1110000 1110000 1150000>;
+			opp-hz = /bits/ 64 <396000000>;
+			opp-supported-hw = <0x0004>;
+		};
+
+		opp@528000000,950 {
+			opp-microvolt = <950000 950000 1150000>;
+			opp-hz = /bits/ 64 <528000000>;
+			opp-supported-hw = <0x0008>;
+		};
+
+		opp@528000000,1000 {
+			opp-microvolt = <1000000 1000000 1150000>;
+			opp-hz = /bits/ 64 <528000000>;
+			opp-supported-hw = <0x0003>;
+		};
+
+		opp@528000000,1050 {
+			opp-microvolt = <1050000 1050000 1150000>;
+			opp-hz = /bits/ 64 <528000000>;
+			opp-supported-hw = <0x0010>;
+		};
+
+		opp@528000000,1110 {
+			opp-microvolt = <1110000 1110000 1150000>;
+			opp-hz = /bits/ 64 <528000000>;
+			opp-supported-hw = <0x0004>;
+		};
+
+		opp@600000000,950 {
+			opp-microvolt = <950000 950000 1150000>;
+			opp-hz = /bits/ 64 <600000000>;
+			opp-supported-hw = <0x0008>;
+		};
+
+		opp@600000000,1000 {
+			opp-microvolt = <1000000 1000000 1150000>;
+			opp-hz = /bits/ 64 <600000000>;
+			opp-supported-hw = <0x0003>;
+		};
+
+		opp@600000000,1050 {
+			opp-microvolt = <1050000 1050000 1150000>;
+			opp-hz = /bits/ 64 <600000000>;
+			opp-supported-hw = <0x0010>;
+		};
+
+		opp@600000000,1110 {
+			opp-microvolt = <1110000 1110000 1150000>;
+			opp-hz = /bits/ 64 <600000000>;
+			opp-supported-hw = <0x0004>;
+		};
+
+		opp@792000000,1000 {
+			opp-microvolt = <1000000 1000000 1150000>;
+			opp-hz = /bits/ 64 <792000000>;
+			opp-supported-hw = <0x000B>;
+		};
+
+		opp@792000000,1050 {
+			opp-microvolt = <1050000 1050000 1150000>;
+			opp-hz = /bits/ 64 <792000000>;
+			opp-supported-hw = <0x0010>;
+		};
+
+		opp@792000000,1110 {
+			opp-microvolt = <1110000 1110000 1150000>;
+			opp-hz = /bits/ 64 <792000000>;
+			opp-supported-hw = <0x0004>;
+		};
+
+		opp@924000000,1100 {
+			opp-microvolt = <1100000 1100000 1150000>;
+			opp-hz = /bits/ 64 <924000000>;
+			opp-supported-hw = <0x0013>;
+		};
+
+		opp@1200000000,1100 {
+			opp-microvolt = <1100000 1100000 1150000>;
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-supported-hw = <0x0003>;
+		};
+	};
+
+	emc_bw_dfs_opp_table: emc-bandwidth-opp-table {
+		compatible = "operating-points-v2";
+
+		opp@12750000 {
+			opp-hz = /bits/ 64 <12750000>;
+			opp-supported-hw = <0x001F>;
+			opp-peak-kBps = <204000>;
+		};
+
+		opp@20400000 {
+			opp-hz = /bits/ 64 <20400000>;
+			opp-supported-hw = <0x001F>;
+			opp-peak-kBps = <326400>;
+		};
+
+		opp@40800000 {
+			opp-hz = /bits/ 64 <40800000>;
+			opp-supported-hw = <0x001F>;
+			opp-peak-kBps = <652800>;
+		};
+
+		opp@68000000 {
+			opp-hz = /bits/ 64 <68000000>;
+			opp-supported-hw = <0x001F>;
+			opp-peak-kBps = <1088000>;
+		};
+
+		opp@102000000 {
+			opp-hz = /bits/ 64 <102000000>;
+			opp-supported-hw = <0x001F>;
+			opp-peak-kBps = <1632000>;
+		};
+
+		opp@204000000 {
+			opp-hz = /bits/ 64 <204000000>;
+			opp-supported-hw = <0x001F>;
+			opp-peak-kBps = <3264000>;
+		};
+
+		opp@264000000 {
+			opp-hz = /bits/ 64 <264000000>;
+			opp-supported-hw = <0x001F>;
+			opp-peak-kBps = <4224000>;
+		};
+
+		opp@300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-supported-hw = <0x001F>;
+			opp-peak-kBps = <4800000>;
+		};
+
+		opp@348000000 {
+			opp-hz = /bits/ 64 <348000000>;
+			opp-supported-hw = <0x001F>;
+			opp-peak-kBps = <5568000>;
+		};
+
+		opp@396000000 {
+			opp-hz = /bits/ 64 <396000000>;
+			opp-supported-hw = <0x001F>;
+			opp-peak-kBps = <6336000>;
+		};
+
+		opp@528000000 {
+			opp-hz = /bits/ 64 <528000000>;
+			opp-supported-hw = <0x001F>;
+			opp-peak-kBps = <8448000>;
+		};
+
+		opp@600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-supported-hw = <0x001F>;
+			opp-peak-kBps = <9600000>;
+		};
+
+		opp@792000000 {
+			opp-hz = /bits/ 64 <792000000>;
+			opp-supported-hw = <0x001F>;
+			opp-peak-kBps = <12672000>;
+		};
+
+		opp@924000000 {
+			opp-hz = /bits/ 64 <924000000>;
+			opp-supported-hw = <0x0013>;
+			opp-peak-kBps = <14784000>;
+		};
+
+		opp@1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-supported-hw = <0x0003>;
+			opp-peak-kBps = <19200000>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 1801e30b1d3a..46441d10a3fc 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -8,6 +8,8 @@
 #include <dt-bindings/thermal/tegra124-soctherm.h>
 #include <dt-bindings/soc/tegra-pmc.h>
 
+#include "tegra124-peripherals-opp.dtsi"
+
 / {
 	compatible = "nvidia,tegra124";
 	interrupt-parent = <&lic>;
@@ -290,6 +292,9 @@ actmon@6000c800 {
 		clock-names = "actmon", "emc";
 		resets = <&tegra_car 119>;
 		reset-names = "actmon";
+		operating-points-v2 = <&emc_bw_dfs_opp_table>;
+		interconnects = <&mc TEGRA124_MC_MPCORER &emc>;
+		interconnect-names = "cpu-read";
 	};
 
 	gpio: gpio@6000d000 {
@@ -660,6 +665,7 @@ emc: external-memory-controller@7001b000 {
 		clock-names = "emc";
 
 		nvidia,memory-controller = <&mc>;
+		operating-points-v2 = <&emc_icc_dvfs_opp_table>;
 
 		#interconnect-cells = <0>;
 	};
-- 
2.29.2

