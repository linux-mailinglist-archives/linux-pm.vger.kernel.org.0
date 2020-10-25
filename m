Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653DC2983E6
	for <lists+linux-pm@lfdr.de>; Sun, 25 Oct 2020 23:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1419233AbgJYWSC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Oct 2020 18:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1419223AbgJYWSA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Oct 2020 18:18:00 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF47C061755;
        Sun, 25 Oct 2020 15:17:59 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id y16so7733259ljk.1;
        Sun, 25 Oct 2020 15:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0740cGeDLzxAAo2TlTDiFrIsS1dz3vXBgXp/Zr3nT0c=;
        b=ttfvcCvbOafUKmL4941gOnJUcNMZQnIWFg3j0/UPwjrDMICvY7cEhW95qBrNz8UGpu
         +7S51ZsnZuiiS2MJobt6Gidz/RSA2Xw4xYuH9oM3Q2Jy6N7/n2E2An9iYblptzyLDHHM
         ME/EIOlOUgL7PCU7x3KSWu/5zl1pA5jBEVwtgIEaV7vx55u6rxNwC2SLFA+6UUxEPFM7
         e0ilSLR9ZYsXyOJT2J12p/uRnT5+Z5og4pJ55/CRKcvrGoqCldL9Y+zd3gQYYA1BTcRq
         ezgAwFmkocimIX/DZC9HT/DcgBpt9PDn0it2Aux+kBf1UTRX770yjJ+HZ5RsIV/YmoRq
         Pg1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0740cGeDLzxAAo2TlTDiFrIsS1dz3vXBgXp/Zr3nT0c=;
        b=YFFiLemzTQkWy/UydNgiWWPl+M1QA40D2+xRRIfKO0A4yIyLVWmf5q7JPcUlP9luSH
         /YnHSeWioyzlm8tru5riBIAvaK1HJ1EgEzPPz+Kz4/G23pYKOw7wd45xiS2wVaZ0I2ft
         kZmBRC7ZsSxD8ds25vT0oCS4cTIZg4HNonptFSjsl9YiZFz1Jqf1+IbNisVpzcY6Sb99
         r7fOJzvhYL6a9IyCqXNcgn74tRVWT6FQfP/uGqg2A0GRnQZxYfWBt+3sWEa1IYteO1Yn
         tqBIAV2PQxU4++iwm2sWcMT3GPabJDr4+NYEsH4/EDnmF07OhFC35cx2QAMPnt0BlGL5
         /v1w==
X-Gm-Message-State: AOAM53200/mCC+OTJayRcl0FFRAMZ4/S7MCSO2QZcmlmHFdWbPHLt3bx
        8+fV0+qH2VkuQ291Ueszfg0=
X-Google-Smtp-Source: ABdhPJxloaTwFeklwsY/+5Ju68thV+F7bYpTG2xFtB2QPPixyhirfXN8cys+UbWW0w4n6gI9Gs5AlQ==
X-Received: by 2002:a2e:9450:: with SMTP id o16mr198285ljh.296.1603664277969;
        Sun, 25 Oct 2020 15:17:57 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.gmail.com with ESMTPSA id k13sm932423ljh.136.2020.10.25.15.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 15:17:57 -0700 (PDT)
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
Subject: [PATCH v6 08/52] dt-bindings: memory: tegra20: emc: Document mfd-simple compatible and statistics sub-device
Date:   Mon, 26 Oct 2020 01:16:51 +0300
Message-Id: <20201025221735.3062-9-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201025221735.3062-1-digetx@gmail.com>
References: <20201025221735.3062-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

External Memory Controller can gather various hardware statistics that
are intended to be used for debugging purposes and for dynamic frequency
scaling of memory bus.

Document the new mfd-simple compatible and EMC statistics sub-device.
The subdev contains EMC DFS OPP table and interconnect paths to be used
for dynamic scaling of system's memory bandwidth based on EMC utilization
statistics.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../memory-controllers/nvidia,tegra20-emc.txt | 43 +++++++++++++++++--
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
index 8d09b228ac42..382aabcd6952 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
@@ -4,7 +4,7 @@ Properties:
 - name : Should be emc
 - #address-cells : Should be 1
 - #size-cells : Should be 0
-- compatible : Should contain "nvidia,tegra20-emc".
+- compatible : Should contain "nvidia,tegra20-emc" and "simple-mfd".
 - reg : Offset and length of the register set for the device
 - nvidia,use-ram-code : If present, the sub-nodes will be addressed
   and chosen using the ramcode board selector. If omitted, only one
@@ -17,7 +17,8 @@ Properties:
 - core-supply: Phandle of voltage regulator of the SoC "core" power domain.
 - operating-points-v2: See ../bindings/opp/opp.txt for details.
 
-Child device nodes describe the memory settings for different configurations and clock rates.
+Child device nodes describe the memory settings for different configurations and clock rates,
+as well as EMC activity statistics collection sub-device.
 
 Example:
 
@@ -31,17 +32,34 @@ Example:
 		...
 	};
 
+	emc_bw_dfs_opp_table: emc_opp_table1 {
+		compatible = "operating-points-v2";
+
+		opp@36000000 {
+			opp-hz = /bits/ 64 <36000000>;
+			opp-peak-kBps = <144000>;
+		};
+		...
+	};
+
 	memory-controller@7000f400 {
 		#address-cells = < 1 >;
 		#size-cells = < 0 >;
 		#interconnect-cells = < 0 >;
-		compatible = "nvidia,tegra20-emc";
+		compatible = "nvidia,tegra20-emc", "simple-mfd";
 		reg = <0x7000f400 0x400>;
 		interrupts = <0 78 0x04>;
 		clocks = <&tegra_car TEGRA20_CLK_EMC>;
 		nvidia,memory-controller = <&mc>;
 		core-supply = <&core_vdd_reg>;
 		operating-points-v2 = <&emc_icc_dvfs_opp_table>;
+
+		emc-stats {
+			compatible = "nvidia,tegra20-emc-statistics";
+			operating-points-v2 = <&emc_bw_dfs_opp_table>;
+			interconnects = <&mc TEGRA20_MC_MPCORER &emc>;
+			interconnect-names = "cpu";
+		};
 	}
 
 
@@ -120,3 +138,22 @@ Properties:
 						 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 						 0 0 0 0 >;
 		};
+
+
+
+Embedded Memory Controller statistics gathering sub-device
+
+EMC statistics subdev gathers information about hardware utilization
+which is intended to be used for debugging purposes and for dynamic
+frequency scaling based on the collected stats.
+
+Properties:
+- name : Should be emc-stats.
+- compatible : Should contain "nvidia,tegra20-emc-statistics".
+- operating-points-v2: See ../bindings/opp/opp.txt for details.
+- interconnects: Should contain entries for memory clients sitting on
+                 MC->EMC memory interconnect path.
+- interconnect-names: Should include name of the interconnect path for each
+                      interconnect entry. Consult TRM documentation for
+                      information about available memory clients, see MEMORY
+                      CONTROLLER section.
-- 
2.27.0

