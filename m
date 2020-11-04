Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3412A6A56
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 17:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731574AbgKDQuE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 11:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731546AbgKDQuD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 11:50:03 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC157C0613D3;
        Wed,  4 Nov 2020 08:50:02 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id v19so18769386lji.5;
        Wed, 04 Nov 2020 08:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dFSGg4PasVnoqN8htMG4TqVmGZvMBfVc7lhygIuCpIo=;
        b=IxEp3gGvgUWBIdRZutsNFqm5o5LO3KafWgBX7M7zAaaqmhvFfA615LNyoz1pNoxgnL
         GnVWLxbTHtFORFU9YGqhO/mOCQz7PuWtVwNuIG07eW+RLoeHOGeNnc4r2xnPJW8ORtdu
         i9SsH5EV4fiY8MIL5Vrno4gAprXBr1xH4CHxRoCNI0oLQu97xHR4JhcrgR2f4LM1H4dl
         R6zSFoRWwz9IZxeJ4aT38taqwpvwaQn1u1B6c0Rv9jIzawbOV7S3h/AvVz8n16qbucfb
         jVjpFCExVklO8ntJ1J66HwK7DvVK5ylrdunBaivjldNGYL08p577jyBbE9PxJmnYjALH
         FKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dFSGg4PasVnoqN8htMG4TqVmGZvMBfVc7lhygIuCpIo=;
        b=QbbePyoRHrh24Vs2HbX8s0YGVolz7Krb//p3v04LI8BBpFVwchMWy1HL3axwD29Upl
         Rp79dAZSyonwTrHatfjqOhIcwdpngGwy50d1PyG/S4bVXgzd0fBrwnZ0SuKh1uImJvCQ
         uCBlqIaOt+UWs73bu6Dd+4tQ0+3HkGkjwRCp2TV5Az2y3xwdQqwZ4dVaLPeKxMign2Vs
         ZBu6QiKFsOkZ2/1/TkBuw6lshzdWxr6Dc9Rr1bfHagDJduNNsP/bKuU/iKzJn4gBw/Bc
         DL8S+TDvm709YcWfUHCtwkyR3tCuyzhdEtwsZX94eEpmDwy8xvgfTgW8np7cPgM7SlPr
         wu2A==
X-Gm-Message-State: AOAM530+mfY0wHHnzXkoGgkhdI3OSoGulnGEhk/cfWjE0oh5i+XnGVBa
        lHWtQcVOZ8MaeTGEIFN4/9w=
X-Google-Smtp-Source: ABdhPJwAH3sMIk4D3MLyiek6fiOgh3JNSrFvXsuUMZ3pKLvLSm4VZaRC8ZPEPgOyWCQ/aAK86n7txA==
X-Received: by 2002:a2e:b04e:: with SMTP id d14mr5719946ljl.349.1604508601396;
        Wed, 04 Nov 2020 08:50:01 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m2sm454587lfo.25.2020.11.04.08.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:50:00 -0800 (PST)
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
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v7 26/47] ARM: tegra: Add DVFS properties to Tegra30 EMC and ACTMON device-tree nodes
Date:   Wed,  4 Nov 2020 19:49:02 +0300
Message-Id: <20201104164923.21238-27-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104164923.21238-1-digetx@gmail.com>
References: <20201104164923.21238-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add EMC OPP DVFS/DFS tables and interconnect paths that will be used for
dynamic memory bandwidth scaling based on memory utilization statistics.
Update board device-trees with optional EMC core supply and remove
unsupported OPPs.

Note that ACTMON watches all memory interconnect paths, but we use a
single CPU-READ interconnect path for driving memory bandwidth, for
simplicity.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../tegra30-asus-nexus7-grouper-common.dtsi   |   4 +
 ...30-asus-nexus7-grouper-memory-timings.dtsi |  12 +
 .../arm/boot/dts/tegra30-peripherals-opp.dtsi | 383 ++++++++++++++++++
 arch/arm/boot/dts/tegra30.dtsi                |   6 +
 4 files changed, 405 insertions(+)
 create mode 100644 arch/arm/boot/dts/tegra30-peripherals-opp.dtsi

diff --git a/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi b/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi
index 88ca03f57b3b..261e266c61d8 100644
--- a/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi
+++ b/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi
@@ -956,6 +956,10 @@ pmc@7000e400 {
 		nvidia,sys-clock-req-active-high;
 	};
 
+	memory-controller@7000f400 {
+		core-supply = <&vdd_core>;
+	};
+
 	ahub@70080000 {
 		i2s@70080400 {
 			status = "okay";
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
2.27.0

