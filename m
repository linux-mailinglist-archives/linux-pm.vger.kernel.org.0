Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1872BFD65
	for <lists+linux-pm@lfdr.de>; Mon, 23 Nov 2020 01:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbgKWAbf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 22 Nov 2020 19:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgKWAbe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Nov 2020 19:31:34 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473F0C0613CF;
        Sun, 22 Nov 2020 16:31:34 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id e139so21472995lfd.1;
        Sun, 22 Nov 2020 16:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F4lu70q76wttiD4daoWhN3gO8Tpkf8A/mm/9ivX7uhk=;
        b=CBUSFql/urOfwSudKzXoynlCS5pyFxbsUvjbKpfGH/VXttnCRv1K3KH8JqtyxXtUIv
         90aAzQh9y5yYo8QCgar1gnFtkRvYHAnuN9UPRdaWjSCQlSdReP3g8MNEL+k/zENa3Yn0
         2B6hgBiHdUIcHjLdunS9B8ZFeXXd9fo5KHnvszUy8gDVpf/ciGkYvFVLn5o7T3bJGi6Q
         Tcg6FhlCACnnpsJqlBqgfXxq+qBAs1LeehNl9Kw36JVBp5g/cwQLPCZBhQFzD7flO1LA
         m5S56GnUKfUZfv1xm/1Kb8rkbpwu+Plgw2YrSjvQi0WUhAJxOey10l+aYwEAU5qssO6J
         agYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F4lu70q76wttiD4daoWhN3gO8Tpkf8A/mm/9ivX7uhk=;
        b=K4lEPbn+dMS9rFh3lTdagnRTmOPDgXPnXLe5vj0HHqiWCvCCg+h0RCuWd5kwinMfOr
         bnQr3Kr/Y7rM/0//8bXXL8pKhM9cXmho5ykBaSahpsIZl98mZ8zO3RQKyLwCDRq5r0Xa
         lcwWXlMgGyHoMcH0AaPI9bBMuOtt01yxAK8k6NgYqvZdu4MuGZtbPK6HuW0xYhr8y7tC
         xi0eJqmchLr62xuhe7OJRHyNCw8TD1ZJ5GS8SZd0rLvOABAbOihlgVzwQMYQcO38FJRi
         w8B8ZnKxZTRExYMmjJTZ66qhqupWoPLPY0M6RC+oGMyIH9/bwS7PkawjnlMzKYYLCA3+
         CsdA==
X-Gm-Message-State: AOAM5305XzGXyngrEKUv3S9OuIMdev3bxnZiE5G5El2rHpExxlHwwgk6
        OQmI+X3eeKaplKDcVIEbP5M=
X-Google-Smtp-Source: ABdhPJyaimJijkWdRgfZpRHSe52jm6egKYIITaw34fkGokzZpEk82OGraeQlmql5c/0mF54D540pHg==
X-Received: by 2002:a19:42d2:: with SMTP id p201mr2193580lfa.273.1606091492816;
        Sun, 22 Nov 2020 16:31:32 -0800 (PST)
Received: from localhost.localdomain (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.gmail.com with ESMTPSA id r27sm1225823lfn.290.2020.11.22.16.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 16:31:32 -0800 (PST)
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
Subject: [PATCH v10 17/19] ARM: tegra: Add EMC OPP properties to Tegra20 device-trees
Date:   Mon, 23 Nov 2020 03:27:21 +0300
Message-Id: <20201123002723.28463-18-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201123002723.28463-1-digetx@gmail.com>
References: <20201123002723.28463-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add EMC OPP DVFS tables and update board device-trees by removing
unsupported OPPs.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../boot/dts/tegra20-acer-a500-picasso.dts    |   5 +
 arch/arm/boot/dts/tegra20-colibri.dtsi        |   4 +
 arch/arm/boot/dts/tegra20-paz00.dts           |   4 +
 .../arm/boot/dts/tegra20-peripherals-opp.dtsi | 109 ++++++++++++++++++
 arch/arm/boot/dts/tegra20.dtsi                |   3 +
 5 files changed, 125 insertions(+)
 create mode 100644 arch/arm/boot/dts/tegra20-peripherals-opp.dtsi

diff --git a/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts b/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
index 827e029281e0..f418e8647d82 100644
--- a/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
+++ b/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
@@ -1451,3 +1451,8 @@ emc-table@300000 {
 		};
 	};
 };
+
+&emc_icc_dvfs_opp_table {
+	/delete-node/ opp@666000000;
+	/delete-node/ opp@760000000;
+};
diff --git a/arch/arm/boot/dts/tegra20-colibri.dtsi b/arch/arm/boot/dts/tegra20-colibri.dtsi
index 6162d193e12c..585a5b441cf6 100644
--- a/arch/arm/boot/dts/tegra20-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri.dtsi
@@ -742,6 +742,10 @@ sound {
 	};
 };
 
+&emc_icc_dvfs_opp_table {
+	/delete-node/ opp@760000000;
+};
+
 &gpio {
 	lan-reset-n {
 		gpio-hog;
diff --git a/arch/arm/boot/dts/tegra20-paz00.dts b/arch/arm/boot/dts/tegra20-paz00.dts
index ada2bed8b1b5..7e49112cd9a1 100644
--- a/arch/arm/boot/dts/tegra20-paz00.dts
+++ b/arch/arm/boot/dts/tegra20-paz00.dts
@@ -662,3 +662,7 @@ cpu@1 {
 		};
 	};
 };
+
+&emc_icc_dvfs_opp_table {
+	/delete-node/ opp@760000000;
+};
diff --git a/arch/arm/boot/dts/tegra20-peripherals-opp.dtsi b/arch/arm/boot/dts/tegra20-peripherals-opp.dtsi
new file mode 100644
index 000000000000..b84afecea154
--- /dev/null
+++ b/arch/arm/boot/dts/tegra20-peripherals-opp.dtsi
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/ {
+	emc_icc_dvfs_opp_table: emc-dvfs-opp-table {
+		compatible = "operating-points-v2";
+
+		opp@36000000 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <36000000>;
+			opp-supported-hw = <0x000F>;
+		};
+
+		opp@47500000 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <47500000>;
+			opp-supported-hw = <0x000F>;
+		};
+
+		opp@50000000 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <50000000>;
+			opp-supported-hw = <0x000F>;
+		};
+
+		opp@54000000 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <54000000>;
+			opp-supported-hw = <0x000F>;
+		};
+
+		opp@57000000 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <57000000>;
+			opp-supported-hw = <0x000F>;
+		};
+
+		opp@100000000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <100000000>;
+			opp-supported-hw = <0x000F>;
+		};
+
+		opp@108000000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <108000000>;
+			opp-supported-hw = <0x000F>;
+		};
+
+		opp@126666000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <126666000>;
+			opp-supported-hw = <0x000F>;
+		};
+
+		opp@150000000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <150000000>;
+			opp-supported-hw = <0x000F>;
+		};
+
+		opp@190000000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <190000000>;
+			opp-supported-hw = <0x000F>;
+		};
+
+		opp@216000000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <216000000>;
+			opp-supported-hw = <0x000F>;
+		};
+
+		opp@300000000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <300000000>;
+			opp-supported-hw = <0x000F>;
+		};
+
+		opp@333000000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <333000000>;
+			opp-supported-hw = <0x000F>;
+		};
+
+		opp@380000000 {
+			opp-microvolt = <1100000 1100000 1300000>;
+			opp-hz = /bits/ 64 <380000000>;
+			opp-supported-hw = <0x000F>;
+		};
+
+		opp@600000000 {
+			opp-microvolt = <1200000 1200000 1300000>;
+			opp-hz = /bits/ 64 <600000000>;
+			opp-supported-hw = <0x000F>;
+		};
+
+		opp@666000000 {
+			opp-microvolt = <1200000 1200000 1300000>;
+			opp-hz = /bits/ 64 <666000000>;
+			opp-supported-hw = <0x000F>;
+		};
+
+		opp@760000000 {
+			opp-microvolt = <1300000 1300000 1300000>;
+			opp-hz = /bits/ 64 <760000000>;
+			opp-supported-hw = <0x000F>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 8f8ad81916e7..6ce498178105 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -6,6 +6,8 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/soc/tegra-pmc.h>
 
+#include "tegra20-peripherals-opp.dtsi"
+
 / {
 	compatible = "nvidia,tegra20";
 	interrupt-parent = <&lic>;
@@ -664,6 +666,7 @@ emc: memory-controller@7000f400 {
 		#size-cells = <0>;
 		#interconnect-cells = <0>;
 
+		operating-points-v2 = <&emc_icc_dvfs_opp_table>;
 		nvidia,memory-controller = <&mc>;
 	};
 
-- 
2.29.2

