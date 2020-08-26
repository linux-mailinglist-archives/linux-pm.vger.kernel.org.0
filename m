Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE99D252CDE
	for <lists+linux-pm@lfdr.de>; Wed, 26 Aug 2020 13:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbgHZLvD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Aug 2020 07:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729177AbgHZLux (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Aug 2020 07:50:53 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16147C061786
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2020 04:50:53 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id s2so162660pjr.4
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2020 04:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mMrx74aqpPy539a6A/Yo+1JwsYH3QMCExymMf82DTaQ=;
        b=Hz33D5lsEgEtv8WYUg0ruN/s5+mBABM/Mxg8jDIRSMNb+T/V9z3KomR63AuCLYmcuD
         8JtGNK4lnLMN08DWkzXryWv5rmkkaRs+IK9m9ZD9EV5pgRfzJuKuZsXiX9W8xw4bzYDM
         jT4aOhUBDLpR1Ide7LQHs5Dx2yQOHaSRMK1xuTiYJm1qjiqyYQ3O6/0q+HvelSgKuuCS
         g8nwX/LpvbvjIZSHXeT1ygcYLVCu4luXvh/rO54FSonqMLm2NAV6RFiUB/BgzgwAv4sK
         ljCpUPkV7loj9Nn9e+9jpTmU1onq3Xay4iLBK+xTp3wi+BuakmbV4i5/sUvOa2Y2BE4B
         59pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mMrx74aqpPy539a6A/Yo+1JwsYH3QMCExymMf82DTaQ=;
        b=FnmO/ciLOpR2Ud5HSsI3LuxfRfuPbYlhm12qP8X8GXfvmzj0V1yRa49HRrzZzbxNY9
         59fpuPml20V3EmO2vwDZd22PZZCei8hCDb45gh7Md6E60sDFp7xV8JzzP2u+22HRZ4pU
         d1WQVQNGB95IrWqIOsSKWmjhsf+WCIXY9h/hdKbxxTUSTwe0WT2EA5zBSv41JeElk1sz
         /JCDe+s1V9lNtxkcS5G5D5XCdvrFSv160jmNhw+ezfoi3jcK1/lBloK8LK8ImssM5IPD
         FTTdF8bsRAjDQo+guqM275GutWHpnzDYW2PQ6+Co5J/eZ6Ny9HeUGpg8lAT2k3TOtsQw
         90GQ==
X-Gm-Message-State: AOAM530S00VP/ur/PdEPZkuXtNsUKwVsIcpeeM+Wb7Q+CSUncQ2ptDLo
        m61ToBfvKS4HOGb1aC1BDWUwbA==
X-Google-Smtp-Source: ABdhPJwy9eRF7OEBWICU21Pl6UBx8oMQ3H7Nk3BEsLjLXj1xfDxV7bkqUjqxNi7Dwx3XogLaCQKgVA==
X-Received: by 2002:a17:902:820c:: with SMTP id x12mr266462pln.279.1598442650275;
        Wed, 26 Aug 2020 04:50:50 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id y20sm2772424pfn.183.2020.08.26.04.50.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Aug 2020 04:50:49 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ARM: tegra: Pass multiple versions in opp-supported-hw property
Date:   Wed, 26 Aug 2020 17:20:30 +0530
Message-Id: <b13f1b112532fe0189d1f7bbb50903d9e1defb07.1598442485.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1598442485.git.viresh.kumar@linaro.org>
References: <cover.1598442485.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We can now pass multiple versions in "opp-supported-hw" property, lets
do that and simplify the tables a bit.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

---
Dmitry, I think there is further scope of simplifying stuff here by
using the opp-microvolt-<name> property and corresponding
dev_pm_opp_set_prop_name() call.
---
 .../boot/dts/tegra20-cpu-opp-microvolt.dtsi   |  36 -
 arch/arm/boot/dts/tegra20-cpu-opp.dtsi        |  67 +-
 .../boot/dts/tegra30-cpu-opp-microvolt.dtsi   | 512 ---------
 arch/arm/boot/dts/tegra30-cpu-opp.dtsi        | 986 +++---------------
 4 files changed, 149 insertions(+), 1452 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-cpu-opp-microvolt.dtsi b/arch/arm/boot/dts/tegra20-cpu-opp-microvolt.dtsi
index dce85d39480d..6f3e8c5fc5f0 100644
--- a/arch/arm/boot/dts/tegra20-cpu-opp-microvolt.dtsi
+++ b/arch/arm/boot/dts/tegra20-cpu-opp-microvolt.dtsi
@@ -26,14 +26,6 @@ opp@456000000,800 {
 			opp-microvolt = <800000 800000 1125000>;
 		};
 
-		opp@456000000,800,2,2 {
-			opp-microvolt = <800000 800000 1125000>;
-		};
-
-		opp@456000000,800,3,2 {
-			opp-microvolt = <800000 800000 1125000>;
-		};
-
 		opp@456000000,825 {
 			opp-microvolt = <825000 825000 1125000>;
 		};
@@ -46,10 +38,6 @@ opp@608000000,800 {
 			opp-microvolt = <800000 800000 1125000>;
 		};
 
-		opp@608000000,800,3,2 {
-			opp-microvolt = <800000 800000 1125000>;
-		};
-
 		opp@608000000,825 {
 			opp-microvolt = <825000 825000 1125000>;
 		};
@@ -78,18 +66,6 @@ opp@760000000,875 {
 			opp-microvolt = <875000 875000 1125000>;
 		};
 
-		opp@760000000,875,1,1 {
-			opp-microvolt = <875000 875000 1125000>;
-		};
-
-		opp@760000000,875,0,2 {
-			opp-microvolt = <875000 875000 1125000>;
-		};
-
-		opp@760000000,875,1,2 {
-			opp-microvolt = <875000 875000 1125000>;
-		};
-
 		opp@760000000,900 {
 			opp-microvolt = <900000 900000 1125000>;
 		};
@@ -134,14 +110,6 @@ opp@912000000,950 {
 			opp-microvolt = <950000 950000 1125000>;
 		};
 
-		opp@912000000,950,0,2 {
-			opp-microvolt = <950000 950000 1125000>;
-		};
-
-		opp@912000000,950,2,2 {
-			opp-microvolt = <950000 950000 1125000>;
-		};
-
 		opp@912000000,1000 {
 			opp-microvolt = <1000000 1000000 1125000>;
 		};
@@ -170,10 +138,6 @@ opp@1000000000,1000 {
 			opp-microvolt = <1000000 1000000 1125000>;
 		};
 
-		opp@1000000000,1000,0,2 {
-			opp-microvolt = <1000000 1000000 1125000>;
-		};
-
 		opp@1000000000,1025 {
 			opp-microvolt = <1025000 1025000 1125000>;
 		};
diff --git a/arch/arm/boot/dts/tegra20-cpu-opp.dtsi b/arch/arm/boot/dts/tegra20-cpu-opp.dtsi
index 9b8fedb57a1b..702a635e88e7 100644
--- a/arch/arm/boot/dts/tegra20-cpu-opp.dtsi
+++ b/arch/arm/boot/dts/tegra20-cpu-opp.dtsi
@@ -37,19 +37,8 @@ opp@456000000,750 {
 
 		opp@456000000,800 {
 			clock-latency-ns = <400000>;
-			opp-supported-hw = <0x03 0x0006>;
-			opp-hz = /bits/ 64 <456000000>;
-		};
-
-		opp@456000000,800,2,2 {
-			clock-latency-ns = <400000>;
-			opp-supported-hw = <0x04 0x0004>;
-			opp-hz = /bits/ 64 <456000000>;
-		};
-
-		opp@456000000,800,3,2 {
-			clock-latency-ns = <400000>;
-			opp-supported-hw = <0x08 0x0004>;
+			opp-supported-hw = <0x03 0x0006>, <0x04 0x0004>,
+					   <0x08 0x0004>;
 			opp-hz = /bits/ 64 <456000000>;
 		};
 
@@ -67,13 +56,7 @@ opp@608000000,750 {
 
 		opp@608000000,800 {
 			clock-latency-ns = <400000>;
-			opp-supported-hw = <0x04 0x0006>;
-			opp-hz = /bits/ 64 <608000000>;
-		};
-
-		opp@608000000,800,3,2 {
-			clock-latency-ns = <400000>;
-			opp-supported-hw = <0x08 0x0004>;
+			opp-supported-hw = <0x04 0x0006>, <0x08 0x0004>;
 			opp-hz = /bits/ 64 <608000000>;
 		};
 
@@ -115,25 +98,8 @@ opp@760000000,850 {
 
 		opp@760000000,875 {
 			clock-latency-ns = <400000>;
-			opp-supported-hw = <0x04 0x0001>;
-			opp-hz = /bits/ 64 <760000000>;
-		};
-
-		opp@760000000,875,1,1 {
-			clock-latency-ns = <400000>;
-			opp-supported-hw = <0x02 0x0002>;
-			opp-hz = /bits/ 64 <760000000>;
-		};
-
-		opp@760000000,875,0,2 {
-			clock-latency-ns = <400000>;
-			opp-supported-hw = <0x01 0x0004>;
-			opp-hz = /bits/ 64 <760000000>;
-		};
-
-		opp@760000000,875,1,2 {
-			clock-latency-ns = <400000>;
-			opp-supported-hw = <0x02 0x0004>;
+			opp-supported-hw = <0x04 0x0001>, <0x02 0x0002>,
+					   <0x01 0x0004>, <0x02 0x0004>;
 			opp-hz = /bits/ 64 <760000000>;
 		};
 
@@ -199,19 +165,8 @@ opp@912000000,925 {
 
 		opp@912000000,950 {
 			clock-latency-ns = <400000>;
-			opp-supported-hw = <0x02 0x0006>;
-			opp-hz = /bits/ 64 <912000000>;
-		};
-
-		opp@912000000,950,0,2 {
-			clock-latency-ns = <400000>;
-			opp-supported-hw = <0x01 0x0004>;
-			opp-hz = /bits/ 64 <912000000>;
-		};
-
-		opp@912000000,950,2,2 {
-			clock-latency-ns = <400000>;
-			opp-supported-hw = <0x04 0x0004>;
+			opp-supported-hw = <0x02 0x0006>, <0x01 0x0004>,
+					   <0x04 0x0004>;
 			opp-hz = /bits/ 64 <912000000>;
 		};
 
@@ -253,13 +208,7 @@ opp@1000000000,975 {
 
 		opp@1000000000,1000 {
 			clock-latency-ns = <400000>;
-			opp-supported-hw = <0x02 0x0006>;
-			opp-hz = /bits/ 64 <1000000000>;
-		};
-
-		opp@1000000000,1000,0,2 {
-			clock-latency-ns = <400000>;
-			opp-supported-hw = <0x01 0x0004>;
+			opp-supported-hw = <0x02 0x0006>, <0x01 0x0004>;
 			opp-hz = /bits/ 64 <1000000000>;
 		};
 
diff --git a/arch/arm/boot/dts/tegra30-cpu-opp-microvolt.dtsi b/arch/arm/boot/dts/tegra30-cpu-opp-microvolt.dtsi
index d682f7437146..1be715d2a442 100644
--- a/arch/arm/boot/dts/tegra30-cpu-opp-microvolt.dtsi
+++ b/arch/arm/boot/dts/tegra30-cpu-opp-microvolt.dtsi
@@ -74,22 +74,6 @@ opp@475000000,850 {
 			opp-microvolt = <850000 850000 1250000>;
 		};
 
-		opp@475000000,850,0,1 {
-			opp-microvolt = <850000 850000 1250000>;
-		};
-
-		opp@475000000,850,0,4 {
-			opp-microvolt = <850000 850000 1250000>;
-		};
-
-		opp@475000000,850,0,7 {
-			opp-microvolt = <850000 850000 1250000>;
-		};
-
-		opp@475000000,850,0,8 {
-			opp-microvolt = <850000 850000 1250000>;
-		};
-
 		opp@608000000,850 {
 			opp-microvolt = <850000 850000 1250000>;
 		};
@@ -106,62 +90,6 @@ opp@640000000,850 {
 			opp-microvolt = <850000 850000 1250000>;
 		};
 
-		opp@640000000,850,1,1 {
-			opp-microvolt = <850000 850000 1250000>;
-		};
-
-		opp@640000000,850,2,1 {
-			opp-microvolt = <850000 850000 1250000>;
-		};
-
-		opp@640000000,850,3,1 {
-			opp-microvolt = <850000 850000 1250000>;
-		};
-
-		opp@640000000,850,1,4 {
-			opp-microvolt = <850000 850000 1250000>;
-		};
-
-		opp@640000000,850,2,4 {
-			opp-microvolt = <850000 850000 1250000>;
-		};
-
-		opp@640000000,850,3,4 {
-			opp-microvolt = <850000 850000 1250000>;
-		};
-
-		opp@640000000,850,1,7 {
-			opp-microvolt = <850000 850000 1250000>;
-		};
-
-		opp@640000000,850,2,7 {
-			opp-microvolt = <850000 850000 1250000>;
-		};
-
-		opp@640000000,850,3,7 {
-			opp-microvolt = <850000 850000 1250000>;
-		};
-
-		opp@640000000,850,4,7 {
-			opp-microvolt = <850000 850000 1250000>;
-		};
-
-		opp@640000000,850,1,8 {
-			opp-microvolt = <850000 850000 1250000>;
-		};
-
-		opp@640000000,850,2,8 {
-			opp-microvolt = <850000 850000 1250000>;
-		};
-
-		opp@640000000,850,3,8 {
-			opp-microvolt = <850000 850000 1250000>;
-		};
-
-		opp@640000000,850,4,8 {
-			opp-microvolt = <850000 850000 1250000>;
-		};
-
 		opp@640000000,900 {
 			opp-microvolt = <900000 900000 1250000>;
 		};
@@ -170,94 +98,10 @@ opp@760000000,850 {
 			opp-microvolt = <850000 850000 1250000>;
 		};
 
-		opp@760000000,850,3,1 {
-			opp-microvolt = <850000 850000 1250000>;
-		};
-
-		opp@760000000,850,3,2 {
-			opp-microvolt = <850000 850000 1250000>;
-		};
-
-		opp@760000000,850,3,3 {
-			opp-microvolt = <850000 850000 1250000>;
-		};
-
-		opp@760000000,850,3,4 {
-			opp-microvolt = <850000 850000 1250000>;
-		};
-
-		opp@760000000,850,3,7 {
-			opp-microvolt = <850000 850000 1250000>;
-		};
-
-		opp@760000000,850,4,7 {
-			opp-microvolt = <850000 850000 1250000>;
-		};
-
-		opp@760000000,850,3,8 {
-			opp-microvolt = <850000 850000 1250000>;
-		};
-
-		opp@760000000,850,4,8 {
-			opp-microvolt = <850000 850000 1250000>;
-		};
-
-		opp@760000000,850,0,10 {
-			opp-microvolt = <850000 850000 1250000>;
-		};
-
 		opp@760000000,900 {
 			opp-microvolt = <900000 900000 1250000>;
 		};
 
-		opp@760000000,900,1,1 {
-			opp-microvolt = <900000 900000 1250000>;
-		};
-
-		opp@760000000,900,2,1 {
-			opp-microvolt = <900000 900000 1250000>;
-		};
-
-		opp@760000000,900,1,2 {
-			opp-microvolt = <900000 900000 1250000>;
-		};
-
-		opp@760000000,900,2,2 {
-			opp-microvolt = <900000 900000 1250000>;
-		};
-
-		opp@760000000,900,1,3 {
-			opp-microvolt = <900000 900000 1250000>;
-		};
-
-		opp@760000000,900,2,3 {
-			opp-microvolt = <900000 900000 1250000>;
-		};
-
-		opp@760000000,900,1,4 {
-			opp-microvolt = <900000 900000 1250000>;
-		};
-
-		opp@760000000,900,2,4 {
-			opp-microvolt = <900000 900000 1250000>;
-		};
-
-		opp@760000000,900,1,7 {
-			opp-microvolt = <900000 900000 1250000>;
-		};
-
-		opp@760000000,900,2,7 {
-			opp-microvolt = <900000 900000 1250000>;
-		};
-
-		opp@760000000,900,1,8 {
-			opp-microvolt = <900000 900000 1250000>;
-		};
-
-		opp@760000000,900,2,8 {
-			opp-microvolt = <900000 900000 1250000>;
-		};
-
 		opp@760000000,912 {
 			opp-microvolt = <912000 912000 1250000>;
 		};
@@ -282,90 +126,10 @@ opp@860000000,900 {
 			opp-microvolt = <900000 900000 1250000>;
 		};
 
-		opp@860000000,900,2,1 {
-			opp-microvolt = <900000 900000 1250000>;
-		};
-
-		opp@860000000,900,3,1 {
-			opp-microvolt = <900000 900000 1250000>;
-		};
-
-		opp@860000000,900,2,2 {
-			opp-microvolt = <900000 900000 1250000>;
-		};
-
-		opp@860000000,900,3,2 {
-			opp-microvolt = <900000 900000 1250000>;
-		};
-
-		opp@860000000,900,2,3 {
-			opp-microvolt = <900000 900000 1250000>;
-		};
-
-		opp@860000000,900,3,3 {
-			opp-microvolt = <900000 900000 1250000>;
-		};
-
-		opp@860000000,900,2,4 {
-			opp-microvolt = <900000 900000 1250000>;
-		};
-
-		opp@860000000,900,3,4 {
-			opp-microvolt = <900000 900000 1250000>;
-		};
-
-		opp@860000000,900,2,7 {
-			opp-microvolt = <900000 900000 1250000>;
-		};
-
-		opp@860000000,900,3,7 {
-			opp-microvolt = <900000 900000 1250000>;
-		};
-
-		opp@860000000,900,4,7 {
-			opp-microvolt = <900000 900000 1250000>;
-		};
-
-		opp@860000000,900,2,8 {
-			opp-microvolt = <900000 900000 1250000>;
-		};
-
-		opp@860000000,900,3,8 {
-			opp-microvolt = <900000 900000 1250000>;
-		};
-
-		opp@860000000,900,4,8 {
-			opp-microvolt = <900000 900000 1250000>;
-		};
-
 		opp@860000000,975 {
 			opp-microvolt = <975000 975000 1250000>;
 		};
 
-		opp@860000000,975,1,1 {
-			opp-microvolt = <975000 975000 1250000>;
-		};
-
-		opp@860000000,975,1,2 {
-			opp-microvolt = <975000 975000 1250000>;
-		};
-
-		opp@860000000,975,1,3 {
-			opp-microvolt = <975000 975000 1250000>;
-		};
-
-		opp@860000000,975,1,4 {
-			opp-microvolt = <975000 975000 1250000>;
-		};
-
-		opp@860000000,975,1,7 {
-			opp-microvolt = <975000 975000 1250000>;
-		};
-
-		opp@860000000,975,1,8 {
-			opp-microvolt = <975000 975000 1250000>;
-		};
-
 		opp@860000000,1000 {
 			opp-microvolt = <1000000 1000000 1250000>;
 		};
@@ -382,62 +146,6 @@ opp@1000000000,975 {
 			opp-microvolt = <975000 975000 1250000>;
 		};
 
-		opp@1000000000,975,2,1 {
-			opp-microvolt = <975000 975000 1250000>;
-		};
-
-		opp@1000000000,975,3,1 {
-			opp-microvolt = <975000 975000 1250000>;
-		};
-
-		opp@1000000000,975,2,2 {
-			opp-microvolt = <975000 975000 1250000>;
-		};
-
-		opp@1000000000,975,3,2 {
-			opp-microvolt = <975000 975000 1250000>;
-		};
-
-		opp@1000000000,975,2,3 {
-			opp-microvolt = <975000 975000 1250000>;
-		};
-
-		opp@1000000000,975,3,3 {
-			opp-microvolt = <975000 975000 1250000>;
-		};
-
-		opp@1000000000,975,2,4 {
-			opp-microvolt = <975000 975000 1250000>;
-		};
-
-		opp@1000000000,975,3,4 {
-			opp-microvolt = <975000 975000 1250000>;
-		};
-
-		opp@1000000000,975,2,7 {
-			opp-microvolt = <975000 975000 1250000>;
-		};
-
-		opp@1000000000,975,3,7 {
-			opp-microvolt = <975000 975000 1250000>;
-		};
-
-		opp@1000000000,975,4,7 {
-			opp-microvolt = <975000 975000 1250000>;
-		};
-
-		opp@1000000000,975,2,8 {
-			opp-microvolt = <975000 975000 1250000>;
-		};
-
-		opp@1000000000,975,3,8 {
-			opp-microvolt = <975000 975000 1250000>;
-		};
-
-		opp@1000000000,975,4,8 {
-			opp-microvolt = <975000 975000 1250000>;
-		};
-
 		opp@1000000000,1000 {
 			opp-microvolt = <1000000 1000000 1250000>;
 		};
@@ -454,66 +162,10 @@ opp@1100000000,975 {
 			opp-microvolt = <975000 975000 1250000>;
 		};
 
-		opp@1100000000,975,3,1 {
-			opp-microvolt = <975000 975000 1250000>;
-		};
-
-		opp@1100000000,975,3,2 {
-			opp-microvolt = <975000 975000 1250000>;
-		};
-
-		opp@1100000000,975,3,3 {
-			opp-microvolt = <975000 975000 1250000>;
-		};
-
-		opp@1100000000,975,3,4 {
-			opp-microvolt = <975000 975000 1250000>;
-		};
-
-		opp@1100000000,975,3,7 {
-			opp-microvolt = <975000 975000 1250000>;
-		};
-
-		opp@1100000000,975,4,7 {
-			opp-microvolt = <975000 975000 1250000>;
-		};
-
-		opp@1100000000,975,3,8 {
-			opp-microvolt = <975000 975000 1250000>;
-		};
-
-		opp@1100000000,975,4,8 {
-			opp-microvolt = <975000 975000 1250000>;
-		};
-
 		opp@1100000000,1000 {
 			opp-microvolt = <1000000 1000000 1250000>;
 		};
 
-		opp@1100000000,1000,2,1 {
-			opp-microvolt = <1000000 1000000 1250000>;
-		};
-
-		opp@1100000000,1000,2,2 {
-			opp-microvolt = <1000000 1000000 1250000>;
-		};
-
-		opp@1100000000,1000,2,3 {
-			opp-microvolt = <1000000 1000000 1250000>;
-		};
-
-		opp@1100000000,1000,2,4 {
-			opp-microvolt = <1000000 1000000 1250000>;
-		};
-
-		opp@1100000000,1000,2,7 {
-			opp-microvolt = <1000000 1000000 1250000>;
-		};
-
-		opp@1100000000,1000,2,8 {
-			opp-microvolt = <1000000 1000000 1250000>;
-		};
-
 		opp@1100000000,1025 {
 			opp-microvolt = <1025000 1025000 1250000>;
 		};
@@ -534,66 +186,10 @@ opp@1200000000,1000 {
 			opp-microvolt = <1000000 1000000 1250000>;
 		};
 
-		opp@1200000000,1000,3,1 {
-			opp-microvolt = <1000000 1000000 1250000>;
-		};
-
-		opp@1200000000,1000,3,2 {
-			opp-microvolt = <1000000 1000000 1250000>;
-		};
-
-		opp@1200000000,1000,3,3 {
-			opp-microvolt = <1000000 1000000 1250000>;
-		};
-
-		opp@1200000000,1000,3,4 {
-			opp-microvolt = <1000000 1000000 1250000>;
-		};
-
-		opp@1200000000,1000,3,7 {
-			opp-microvolt = <1000000 1000000 1250000>;
-		};
-
-		opp@1200000000,1000,4,7 {
-			opp-microvolt = <1000000 1000000 1250000>;
-		};
-
-		opp@1200000000,1000,3,8 {
-			opp-microvolt = <1000000 1000000 1250000>;
-		};
-
-		opp@1200000000,1000,4,8 {
-			opp-microvolt = <1000000 1000000 1250000>;
-		};
-
 		opp@1200000000,1025 {
 			opp-microvolt = <1025000 1025000 1250000>;
 		};
 
-		opp@1200000000,1025,2,1 {
-			opp-microvolt = <1025000 1025000 1250000>;
-		};
-
-		opp@1200000000,1025,2,2 {
-			opp-microvolt = <1025000 1025000 1250000>;
-		};
-
-		opp@1200000000,1025,2,3 {
-			opp-microvolt = <1025000 1025000 1250000>;
-		};
-
-		opp@1200000000,1025,2,4 {
-			opp-microvolt = <1025000 1025000 1250000>;
-		};
-
-		opp@1200000000,1025,2,7 {
-			opp-microvolt = <1025000 1025000 1250000>;
-		};
-
-		opp@1200000000,1025,2,8 {
-			opp-microvolt = <1025000 1025000 1250000>;
-		};
-
 		opp@1200000000,1050 {
 			opp-microvolt = <1050000 1050000 1250000>;
 		};
@@ -610,90 +206,18 @@ opp@1300000000,1000 {
 			opp-microvolt = <1000000 1000000 1250000>;
 		};
 
-		opp@1300000000,1000,4,7 {
-			opp-microvolt = <1000000 1000000 1250000>;
-		};
-
-		opp@1300000000,1000,4,8 {
-			opp-microvolt = <1000000 1000000 1250000>;
-		};
-
 		opp@1300000000,1025 {
 			opp-microvolt = <1025000 1025000 1250000>;
 		};
 
-		opp@1300000000,1025,3,1 {
-			opp-microvolt = <1025000 1025000 1250000>;
-		};
-
-		opp@1300000000,1025,3,7 {
-			opp-microvolt = <1025000 1025000 1250000>;
-		};
-
-		opp@1300000000,1025,3,8 {
-			opp-microvolt = <1025000 1025000 1250000>;
-		};
-
 		opp@1300000000,1050 {
 			opp-microvolt = <1050000 1050000 1250000>;
 		};
 
-		opp@1300000000,1050,2,1 {
-			opp-microvolt = <1050000 1050000 1250000>;
-		};
-
-		opp@1300000000,1050,3,2 {
-			opp-microvolt = <1050000 1050000 1250000>;
-		};
-
-		opp@1300000000,1050,3,3 {
-			opp-microvolt = <1050000 1050000 1250000>;
-		};
-
-		opp@1300000000,1050,3,4 {
-			opp-microvolt = <1050000 1050000 1250000>;
-		};
-
-		opp@1300000000,1050,3,5 {
-			opp-microvolt = <1050000 1050000 1250000>;
-		};
-
-		opp@1300000000,1050,3,6 {
-			opp-microvolt = <1050000 1050000 1250000>;
-		};
-
-		opp@1300000000,1050,2,7 {
-			opp-microvolt = <1050000 1050000 1250000>;
-		};
-
-		opp@1300000000,1050,2,8 {
-			opp-microvolt = <1050000 1050000 1250000>;
-		};
-
-		opp@1300000000,1050,3,12 {
-			opp-microvolt = <1050000 1050000 1250000>;
-		};
-
-		opp@1300000000,1050,3,13 {
-			opp-microvolt = <1050000 1050000 1250000>;
-		};
-
 		opp@1300000000,1075 {
 			opp-microvolt = <1075000 1075000 1250000>;
 		};
 
-		opp@1300000000,1075,2,2 {
-			opp-microvolt = <1075000 1075000 1250000>;
-		};
-
-		opp@1300000000,1075,2,3 {
-			opp-microvolt = <1075000 1075000 1250000>;
-		};
-
-		opp@1300000000,1075,2,4 {
-			opp-microvolt = <1075000 1075000 1250000>;
-		};
-
 		opp@1300000000,1100 {
 			opp-microvolt = <1100000 1100000 1250000>;
 		};
@@ -722,10 +246,6 @@ opp@1400000000,1150 {
 			opp-microvolt = <1150000 1150000 1250000>;
 		};
 
-		opp@1400000000,1150,2,4 {
-			opp-microvolt = <1150000 1150000 1250000>;
-		};
-
 		opp@1400000000,1175 {
 			opp-microvolt = <1175000 1175000 1250000>;
 		};
@@ -738,42 +258,10 @@ opp@1500000000,1125 {
 			opp-microvolt = <1125000 1125000 1250000>;
 		};
 
-		opp@1500000000,1125,4,5 {
-			opp-microvolt = <1125000 1125000 1250000>;
-		};
-
-		opp@1500000000,1125,4,6 {
-			opp-microvolt = <1125000 1125000 1250000>;
-		};
-
-		opp@1500000000,1125,4,12 {
-			opp-microvolt = <1125000 1125000 1250000>;
-		};
-
-		opp@1500000000,1125,4,13 {
-			opp-microvolt = <1125000 1125000 1250000>;
-		};
-
 		opp@1500000000,1150 {
 			opp-microvolt = <1150000 1150000 1250000>;
 		};
 
-		opp@1500000000,1150,3,5 {
-			opp-microvolt = <1150000 1150000 1250000>;
-		};
-
-		opp@1500000000,1150,3,6 {
-			opp-microvolt = <1150000 1150000 1250000>;
-		};
-
-		opp@1500000000,1150,3,12 {
-			opp-microvolt = <1150000 1150000 1250000>;
-		};
-
-		opp@1500000000,1150,3,13 {
-			opp-microvolt = <1150000 1150000 1250000>;
-		};
-
 		opp@1500000000,1200 {
 			opp-microvolt = <1200000 1200000 1250000>;
 		};
diff --git a/arch/arm/boot/dts/tegra30-cpu-opp.dtsi b/arch/arm/boot/dts/tegra30-cpu-opp.dtsi
index 8e434f6713cd..16a96e004d04 100644
--- a/arch/arm/boot/dts/tegra30-cpu-opp.dtsi
+++ b/arch/arm/boot/dts/tegra30-cpu-opp.dtsi
@@ -109,667 +109,190 @@ opp@475000000,800 {
 
 		opp@475000000,850 {
 			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x0F 0x0001>;
-			opp-hz = /bits/ 64 <475000000>;
-		};
-
-		opp@475000000,850,0,1 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x01 0x0002>;
-			opp-hz = /bits/ 64 <475000000>;
-		};
-
-		opp@475000000,850,0,4 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x01 0x0010>;
-			opp-hz = /bits/ 64 <475000000>;
-		};
-
-		opp@475000000,850,0,7 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x01 0x0080>;
-			opp-hz = /bits/ 64 <475000000>;
-		};
-
-		opp@475000000,850,0,8 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x01 0x0100>;
-			opp-hz = /bits/ 64 <475000000>;
-		};
-
-		opp@608000000,850 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x1F 0x0400>;
-			opp-hz = /bits/ 64 <608000000>;
-		};
-
-		opp@608000000,912 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x1F 0x0200>;
-			opp-hz = /bits/ 64 <608000000>;
-		};
-
-		opp@620000000,850 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x1E 0x306C>;
-			opp-hz = /bits/ 64 <620000000>;
-		};
-
-		opp@640000000,850 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x0F 0x0001>;
-			opp-hz = /bits/ 64 <640000000>;
-		};
-
-		opp@640000000,850,1,1 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x02 0x0002>;
-			opp-hz = /bits/ 64 <640000000>;
-		};
-
-		opp@640000000,850,2,1 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x04 0x0002>;
-			opp-hz = /bits/ 64 <640000000>;
-		};
-
-		opp@640000000,850,3,1 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x0002>;
-			opp-hz = /bits/ 64 <640000000>;
-		};
-
-		opp@640000000,850,1,4 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x02 0x0010>;
-			opp-hz = /bits/ 64 <640000000>;
-		};
-
-		opp@640000000,850,2,4 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x04 0x0010>;
-			opp-hz = /bits/ 64 <640000000>;
-		};
-
-		opp@640000000,850,3,4 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x0010>;
-			opp-hz = /bits/ 64 <640000000>;
-		};
-
-		opp@640000000,850,1,7 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x02 0x0080>;
-			opp-hz = /bits/ 64 <640000000>;
-		};
-
-		opp@640000000,850,2,7 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x04 0x0080>;
-			opp-hz = /bits/ 64 <640000000>;
-		};
-
-		opp@640000000,850,3,7 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x0080>;
-			opp-hz = /bits/ 64 <640000000>;
-		};
-
-		opp@640000000,850,4,7 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x10 0x0080>;
-			opp-hz = /bits/ 64 <640000000>;
-		};
-
-		opp@640000000,850,1,8 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x02 0x0100>;
-			opp-hz = /bits/ 64 <640000000>;
-		};
-
-		opp@640000000,850,2,8 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x04 0x0100>;
-			opp-hz = /bits/ 64 <640000000>;
-		};
-
-		opp@640000000,850,3,8 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x0100>;
-			opp-hz = /bits/ 64 <640000000>;
-		};
-
-		opp@640000000,850,4,8 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x10 0x0100>;
-			opp-hz = /bits/ 64 <640000000>;
-		};
-
-		opp@640000000,900 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x01 0x0192>;
-			opp-hz = /bits/ 64 <640000000>;
-		};
-
-		opp@760000000,850 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x1E 0x3461>;
-			opp-hz = /bits/ 64 <760000000>;
-		};
-
-		opp@760000000,850,3,1 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x0002>;
-			opp-hz = /bits/ 64 <760000000>;
-		};
-
-		opp@760000000,850,3,2 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x0004>;
-			opp-hz = /bits/ 64 <760000000>;
-		};
-
-		opp@760000000,850,3,3 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x0008>;
-			opp-hz = /bits/ 64 <760000000>;
-		};
-
-		opp@760000000,850,3,4 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x0010>;
-			opp-hz = /bits/ 64 <760000000>;
-		};
-
-		opp@760000000,850,3,7 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x0080>;
-			opp-hz = /bits/ 64 <760000000>;
-		};
-
-		opp@760000000,850,4,7 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x10 0x0080>;
-			opp-hz = /bits/ 64 <760000000>;
-		};
-
-		opp@760000000,850,3,8 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x0100>;
-			opp-hz = /bits/ 64 <760000000>;
-		};
-
-		opp@760000000,850,4,8 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x10 0x0100>;
-			opp-hz = /bits/ 64 <760000000>;
-		};
-
-		opp@760000000,850,0,10 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x01 0x0400>;
-			opp-hz = /bits/ 64 <760000000>;
-		};
-
-		opp@760000000,900 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x01 0x0001>;
-			opp-hz = /bits/ 64 <760000000>;
-		};
-
-		opp@760000000,900,1,1 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x02 0x0002>;
-			opp-hz = /bits/ 64 <760000000>;
-		};
-
-		opp@760000000,900,2,1 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x04 0x0002>;
-			opp-hz = /bits/ 64 <760000000>;
-		};
-
-		opp@760000000,900,1,2 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x02 0x0004>;
-			opp-hz = /bits/ 64 <760000000>;
-		};
-
-		opp@760000000,900,2,2 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x04 0x0004>;
-			opp-hz = /bits/ 64 <760000000>;
-		};
-
-		opp@760000000,900,1,3 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x02 0x0008>;
-			opp-hz = /bits/ 64 <760000000>;
-		};
-
-		opp@760000000,900,2,3 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x04 0x0008>;
-			opp-hz = /bits/ 64 <760000000>;
-		};
-
-		opp@760000000,900,1,4 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x02 0x0010>;
-			opp-hz = /bits/ 64 <760000000>;
-		};
-
-		opp@760000000,900,2,4 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x04 0x0010>;
-			opp-hz = /bits/ 64 <760000000>;
-		};
-
-		opp@760000000,900,1,7 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x02 0x0080>;
-			opp-hz = /bits/ 64 <760000000>;
-		};
-
-		opp@760000000,900,2,7 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x04 0x0080>;
-			opp-hz = /bits/ 64 <760000000>;
-		};
-
-		opp@760000000,900,1,8 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x02 0x0100>;
-			opp-hz = /bits/ 64 <760000000>;
-		};
-
-		opp@760000000,900,2,8 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x04 0x0100>;
-			opp-hz = /bits/ 64 <760000000>;
-		};
-
-		opp@760000000,912 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x1F 0x0200>;
-			opp-hz = /bits/ 64 <760000000>;
-		};
-
-		opp@760000000,975 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x01 0x0192>;
-			opp-hz = /bits/ 64 <760000000>;
-		};
-
-		opp@816000000,850 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x1F 0x0400>;
-			opp-hz = /bits/ 64 <816000000>;
-		};
-
-		opp@816000000,912 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x1F 0x0200>;
-			opp-hz = /bits/ 64 <816000000>;
-		};
-
-		opp@860000000,850 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x0C 0x0001>;
-			opp-hz = /bits/ 64 <860000000>;
-		};
-
-		opp@860000000,900 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x02 0x0001>;
-			opp-hz = /bits/ 64 <860000000>;
-		};
-
-		opp@860000000,900,2,1 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x04 0x0002>;
-			opp-hz = /bits/ 64 <860000000>;
-		};
-
-		opp@860000000,900,3,1 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x0002>;
-			opp-hz = /bits/ 64 <860000000>;
-		};
-
-		opp@860000000,900,2,2 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x04 0x0004>;
-			opp-hz = /bits/ 64 <860000000>;
-		};
-
-		opp@860000000,900,3,2 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x0004>;
-			opp-hz = /bits/ 64 <860000000>;
-		};
-
-		opp@860000000,900,2,3 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x04 0x0008>;
-			opp-hz = /bits/ 64 <860000000>;
-		};
-
-		opp@860000000,900,3,3 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x0008>;
-			opp-hz = /bits/ 64 <860000000>;
-		};
-
-		opp@860000000,900,2,4 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x04 0x0010>;
-			opp-hz = /bits/ 64 <860000000>;
-		};
-
-		opp@860000000,900,3,4 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x0010>;
-			opp-hz = /bits/ 64 <860000000>;
-		};
-
-		opp@860000000,900,2,7 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x04 0x0080>;
-			opp-hz = /bits/ 64 <860000000>;
-		};
-
-		opp@860000000,900,3,7 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x0080>;
-			opp-hz = /bits/ 64 <860000000>;
-		};
-
-		opp@860000000,900,4,7 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x10 0x0080>;
-			opp-hz = /bits/ 64 <860000000>;
-		};
-
-		opp@860000000,900,2,8 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x04 0x0100>;
-			opp-hz = /bits/ 64 <860000000>;
-		};
-
-		opp@860000000,900,3,8 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x0100>;
-			opp-hz = /bits/ 64 <860000000>;
-		};
-
-		opp@860000000,900,4,8 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x10 0x0100>;
-			opp-hz = /bits/ 64 <860000000>;
-		};
-
-		opp@860000000,975 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x01 0x0001>;
-			opp-hz = /bits/ 64 <860000000>;
-		};
-
-		opp@860000000,975,1,1 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x02 0x0002>;
-			opp-hz = /bits/ 64 <860000000>;
-		};
-
-		opp@860000000,975,1,2 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x02 0x0004>;
-			opp-hz = /bits/ 64 <860000000>;
-		};
-
-		opp@860000000,975,1,3 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x02 0x0008>;
-			opp-hz = /bits/ 64 <860000000>;
-		};
-
-		opp@860000000,975,1,4 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x02 0x0010>;
-			opp-hz = /bits/ 64 <860000000>;
-		};
-
-		opp@860000000,975,1,7 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x02 0x0080>;
-			opp-hz = /bits/ 64 <860000000>;
-		};
-
-		opp@860000000,975,1,8 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x02 0x0100>;
-			opp-hz = /bits/ 64 <860000000>;
-		};
-
-		opp@860000000,1000 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x01 0x0192>;
-			opp-hz = /bits/ 64 <860000000>;
-		};
-
-		opp@910000000,900 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x18 0x3060>;
-			opp-hz = /bits/ 64 <910000000>;
-		};
-
-		opp@1000000000,900 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x0C 0x0001>;
-			opp-hz = /bits/ 64 <1000000000>;
-		};
-
-		opp@1000000000,975 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x03 0x0001>;
-			opp-hz = /bits/ 64 <1000000000>;
-		};
-
-		opp@1000000000,975,2,1 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x04 0x0002>;
-			opp-hz = /bits/ 64 <1000000000>;
-		};
-
-		opp@1000000000,975,3,1 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x0002>;
-			opp-hz = /bits/ 64 <1000000000>;
-		};
-
-		opp@1000000000,975,2,2 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x04 0x0004>;
-			opp-hz = /bits/ 64 <1000000000>;
-		};
-
-		opp@1000000000,975,3,2 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x0004>;
-			opp-hz = /bits/ 64 <1000000000>;
-		};
-
-		opp@1000000000,975,2,3 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x04 0x0008>;
-			opp-hz = /bits/ 64 <1000000000>;
-		};
-
-		opp@1000000000,975,3,3 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x0008>;
-			opp-hz = /bits/ 64 <1000000000>;
-		};
-
-		opp@1000000000,975,2,4 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x04 0x0010>;
-			opp-hz = /bits/ 64 <1000000000>;
-		};
-
-		opp@1000000000,975,3,4 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x0010>;
-			opp-hz = /bits/ 64 <1000000000>;
-		};
-
-		opp@1000000000,975,2,7 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x04 0x0080>;
-			opp-hz = /bits/ 64 <1000000000>;
-		};
-
-		opp@1000000000,975,3,7 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x0080>;
-			opp-hz = /bits/ 64 <1000000000>;
+			opp-supported-hw = <0x0F 0x0001>,
+				<0x01 0x0002>,
+				<0x01 0x0010>,
+				<0x01 0x0080>,
+				<0x01 0x0100>;
+			opp-hz = /bits/ 64 <475000000>;
 		};
 
-		opp@1000000000,975,4,7 {
+		opp@608000000,850 {
 			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x10 0x0080>;
-			opp-hz = /bits/ 64 <1000000000>;
+			opp-supported-hw = <0x1F 0x0400>;
+			opp-hz = /bits/ 64 <608000000>;
 		};
 
-		opp@1000000000,975,2,8 {
+		opp@608000000,912 {
 			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x04 0x0100>;
-			opp-hz = /bits/ 64 <1000000000>;
+			opp-supported-hw = <0x1F 0x0200>;
+			opp-hz = /bits/ 64 <608000000>;
 		};
 
-		opp@1000000000,975,3,8 {
+		opp@620000000,850 {
 			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x0100>;
-			opp-hz = /bits/ 64 <1000000000>;
+			opp-supported-hw = <0x1E 0x306C>;
+			opp-hz = /bits/ 64 <620000000>;
 		};
 
-		opp@1000000000,975,4,8 {
+		opp@640000000,850 {
 			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x10 0x0100>;
-			opp-hz = /bits/ 64 <1000000000>;
+			opp-supported-hw = <0x0F 0x0001>, <0x02 0x0002>,
+					   <0x04 0x0002>, <0x08 0x0002>,
+					   <0x02 0x0010>, <0x04 0x0010>,
+					   <0x08 0x0010>, <0x02 0x0080>,
+					   <0x04 0x0080>, <0x08 0x0080>,
+					   <0x10 0x0080>, <0x02 0x0100>,
+					   <0x04 0x0100>, <0x08 0x0100>,
+					   <0x10 0x0100>;
+			opp-hz = /bits/ 64 <640000000>;
 		};
 
-		opp@1000000000,1000 {
+		opp@640000000,900 {
 			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x02 0x019E>;
-			opp-hz = /bits/ 64 <1000000000>;
+			opp-supported-hw = <0x01 0x0192>;
+			opp-hz = /bits/ 64 <640000000>;
 		};
 
-		opp@1000000000,1025 {
+		opp@760000000,850 {
 			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x01 0x0192>;
-			opp-hz = /bits/ 64 <1000000000>;
+			opp-supported-hw = <0x1E 0x3461>, <0x08 0x0002>,
+					   <0x08 0x0004>, <0x08 0x0008>,
+					   <0x08 0x0010>, <0x08 0x0080>,
+					   <0x10 0x0080>, <0x08 0x0100>,
+					   <0x10 0x0100>, <0x01 0x0400>;
+			opp-hz = /bits/ 64 <760000000>;
 		};
 
-		opp@1100000000,900 {
+		opp@760000000,900 {
 			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x0001>;
-			opp-hz = /bits/ 64 <1100000000>;
+			opp-supported-hw = <0x01 0x0001>, <0x02 0x0002>,
+					   <0x04 0x0002>, <0x02 0x0004>,
+					   <0x04 0x0004>, <0x02 0x0008>,
+					   <0x04 0x0008>, <0x02 0x0010>,
+					   <0x04 0x0010>, <0x02 0x0080>,
+					   <0x04 0x0080>, <0x02 0x0100>,
+					   <0x04 0x0100>;
+			opp-hz = /bits/ 64 <760000000>;
 		};
 
-		opp@1100000000,975 {
+		opp@760000000,912 {
 			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x06 0x0001>;
-			opp-hz = /bits/ 64 <1100000000>;
+			opp-supported-hw = <0x1F 0x0200>;
+			opp-hz = /bits/ 64 <760000000>;
 		};
 
-		opp@1100000000,975,3,1 {
+		opp@760000000,975 {
 			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x0002>;
-			opp-hz = /bits/ 64 <1100000000>;
+			opp-supported-hw = <0x01 0x0192>;
+			opp-hz = /bits/ 64 <760000000>;
 		};
 
-		opp@1100000000,975,3,2 {
+		opp@816000000,850 {
 			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x0004>;
-			opp-hz = /bits/ 64 <1100000000>;
+			opp-supported-hw = <0x1F 0x0400>;
+			opp-hz = /bits/ 64 <816000000>;
 		};
 
-		opp@1100000000,975,3,3 {
+		opp@816000000,912 {
 			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x0008>;
-			opp-hz = /bits/ 64 <1100000000>;
+			opp-supported-hw = <0x1F 0x0200>;
+			opp-hz = /bits/ 64 <816000000>;
 		};
 
-		opp@1100000000,975,3,4 {
+		opp@860000000,850 {
 			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x0010>;
-			opp-hz = /bits/ 64 <1100000000>;
+			opp-supported-hw = <0x0C 0x0001>;
+			opp-hz = /bits/ 64 <860000000>;
 		};
 
-		opp@1100000000,975,3,7 {
+		opp@860000000,900 {
 			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x0080>;
-			opp-hz = /bits/ 64 <1100000000>;
+			opp-supported-hw = <0x02 0x0001>, <0x04 0x0002>,
+					   <0x08 0x0002>, <0x04 0x0004>,
+					   <0x08 0x0004>, <0x04 0x0008>,
+					   <0x08 0x0008>, <0x04 0x0010>,
+					   <0x08 0x0010>, <0x04 0x0080>,
+					   <0x08 0x0080>, <0x10 0x0080>,
+					   <0x04 0x0100>, <0x08 0x0100>,
+					   <0x10 0x0100>;
+			opp-hz = /bits/ 64 <860000000>;
 		};
 
-		opp@1100000000,975,4,7 {
+		opp@860000000,975 {
 			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x10 0x0080>;
-			opp-hz = /bits/ 64 <1100000000>;
+			opp-supported-hw = <0x01 0x0001>, <0x02 0x0002>,
+					   <0x02 0x0004>, <0x02 0x0008>,
+					   <0x02 0x0010>, <0x02 0x0080>,
+					   <0x02 0x0100>;
+			opp-hz = /bits/ 64 <860000000>;
 		};
 
-		opp@1100000000,975,3,8 {
+		opp@860000000,1000 {
 			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x0100>;
-			opp-hz = /bits/ 64 <1100000000>;
+			opp-supported-hw = <0x01 0x0192>;
+			opp-hz = /bits/ 64 <860000000>;
 		};
 
-		opp@1100000000,975,4,8 {
+		opp@910000000,900 {
 			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x10 0x0100>;
-			opp-hz = /bits/ 64 <1100000000>;
+			opp-supported-hw = <0x18 0x3060>;
+			opp-hz = /bits/ 64 <910000000>;
 		};
 
-		opp@1100000000,1000 {
+		opp@1000000000,900 {
 			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x01 0x0001>;
-			opp-hz = /bits/ 64 <1100000000>;
+			opp-supported-hw = <0x0C 0x0001>;
+			opp-hz = /bits/ 64 <1000000000>;
 		};
 
-		opp@1100000000,1000,2,1 {
+		opp@1000000000,975 {
 			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x04 0x0002>;
-			opp-hz = /bits/ 64 <1100000000>;
+			opp-supported-hw = <0x03 0x0001>, <0x04 0x0002>,
+					   <0x08 0x0002>, <0x04 0x0004>,
+					   <0x08 0x0004>, <0x04 0x0008>,
+					   <0x08 0x0008>, <0x04 0x0010>,
+					   <0x08 0x0010>, <0x04 0x0080>,
+					   <0x08 0x0080>, <0x10 0x0080>,
+					   <0x04 0x0100>, <0x08 0x0100>,
+					   <0x10 0x0100>;
+			opp-hz = /bits/ 64 <1000000000>;
 		};
 
-		opp@1100000000,1000,2,2 {
+		opp@1000000000,1000 {
 			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x04 0x0004>;
-			opp-hz = /bits/ 64 <1100000000>;
+			opp-supported-hw = <0x02 0x019E>;
+			opp-hz = /bits/ 64 <1000000000>;
 		};
 
-		opp@1100000000,1000,2,3 {
+		opp@1000000000,1025 {
 			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x04 0x0008>;
-			opp-hz = /bits/ 64 <1100000000>;
+			opp-supported-hw = <0x01 0x0192>;
+			opp-hz = /bits/ 64 <1000000000>;
 		};
 
-		opp@1100000000,1000,2,4 {
+		opp@1100000000,900 {
 			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x04 0x0010>;
+			opp-supported-hw = <0x08 0x0001>;
 			opp-hz = /bits/ 64 <1100000000>;
 		};
 
-		opp@1100000000,1000,2,7 {
+		opp@1100000000,975 {
 			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x04 0x0080>;
+			opp-supported-hw = <0x06 0x0001>, <0x08 0x0002>,
+					   <0x08 0x0004>, <0x08 0x0008>,
+					   <0x08 0x0010>, <0x08 0x0080>,
+					   <0x10 0x0080>, <0x08 0x0100>,
+					   <0x10 0x0100>;
 			opp-hz = /bits/ 64 <1100000000>;
 		};
 
-		opp@1100000000,1000,2,8 {
+		opp@1100000000,1000 {
 			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x04 0x0100>;
+			opp-supported-hw = <0x01 0x0001>, <0x04 0x0002>,
+					   <0x04 0x0004>, <0x04 0x0008>,
+					   <0x04 0x0010>, <0x04 0x0080>,
+					   <0x04 0x0100>;
 			opp-hz = /bits/ 64 <1100000000>;
 		};
 
@@ -799,97 +322,20 @@ opp@1200000000,975 {
 
 		opp@1200000000,1000 {
 			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x04 0x0001>;
-			opp-hz = /bits/ 64 <1200000000>;
-		};
-
-		opp@1200000000,1000,3,1 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x0002>;
-			opp-hz = /bits/ 64 <1200000000>;
-		};
-
-		opp@1200000000,1000,3,2 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x0004>;
-			opp-hz = /bits/ 64 <1200000000>;
-		};
-
-		opp@1200000000,1000,3,3 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x0008>;
-			opp-hz = /bits/ 64 <1200000000>;
-		};
-
-		opp@1200000000,1000,3,4 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x0010>;
-			opp-hz = /bits/ 64 <1200000000>;
-		};
-
-		opp@1200000000,1000,3,7 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x0080>;
-			opp-hz = /bits/ 64 <1200000000>;
-		};
-
-		opp@1200000000,1000,4,7 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x10 0x0080>;
-			opp-hz = /bits/ 64 <1200000000>;
-		};
-
-		opp@1200000000,1000,3,8 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x0100>;
-			opp-hz = /bits/ 64 <1200000000>;
-		};
-
-		opp@1200000000,1000,4,8 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x10 0x0100>;
+			opp-supported-hw = <0x04 0x0001>, <0x08 0x0002>,
+					   <0x08 0x0004>, <0x08 0x0008>,
+					   <0x08 0x0010>, <0x08 0x0080>,
+					   <0x10 0x0080>, <0x08 0x0100>,
+					   <0x10 0x0100>;
 			opp-hz = /bits/ 64 <1200000000>;
 		};
 
 		opp@1200000000,1025 {
 			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x02 0x0001>;
-			opp-hz = /bits/ 64 <1200000000>;
-		};
-
-		opp@1200000000,1025,2,1 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x04 0x0002>;
-			opp-hz = /bits/ 64 <1200000000>;
-		};
-
-		opp@1200000000,1025,2,2 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x04 0x0004>;
-			opp-hz = /bits/ 64 <1200000000>;
-		};
-
-		opp@1200000000,1025,2,3 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x04 0x0008>;
-			opp-hz = /bits/ 64 <1200000000>;
-		};
-
-		opp@1200000000,1025,2,4 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x04 0x0010>;
-			opp-hz = /bits/ 64 <1200000000>;
-		};
-
-		opp@1200000000,1025,2,7 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x04 0x0080>;
-			opp-hz = /bits/ 64 <1200000000>;
-		};
-
-		opp@1200000000,1025,2,8 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x04 0x0100>;
+			opp-supported-hw = <0x02 0x0001>, <0x04 0x0002>,
+					   <0x04 0x0004>, <0x04 0x0008>,
+					   <0x04 0x0010>, <0x04 0x0080>,
+					   <0x04 0x0100>;
 			opp-hz = /bits/ 64 <1200000000>;
 		};
 
@@ -913,133 +359,33 @@ opp@1200000000,1100 {
 
 		opp@1300000000,1000 {
 			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x0001>;
-			opp-hz = /bits/ 64 <1300000000>;
-		};
-
-		opp@1300000000,1000,4,7 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x10 0x0080>;
-			opp-hz = /bits/ 64 <1300000000>;
-		};
-
-		opp@1300000000,1000,4,8 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x10 0x0100>;
+			opp-supported-hw = <0x08 0x0001>, <0x10 0x0080>,
+					   <0x10 0x0100>;
 			opp-hz = /bits/ 64 <1300000000>;
 		};
 
 		opp@1300000000,1025 {
 			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x04 0x0001>;
-			opp-hz = /bits/ 64 <1300000000>;
-		};
-
-		opp@1300000000,1025,3,1 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x0002>;
-			opp-hz = /bits/ 64 <1300000000>;
-		};
-
-		opp@1300000000,1025,3,7 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x0080>;
-			opp-hz = /bits/ 64 <1300000000>;
-		};
-
-		opp@1300000000,1025,3,8 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x0100>;
+			opp-supported-hw = <0x04 0x0001>, <0x08 0x0002>,
+					   <0x08 0x0080>, <0x08 0x0100>;
 			opp-hz = /bits/ 64 <1300000000>;
 		};
 
 		opp@1300000000,1050 {
 			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x12 0x3061>;
-			opp-hz = /bits/ 64 <1300000000>;
-		};
-
-		opp@1300000000,1050,2,1 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x04 0x0002>;
-			opp-hz = /bits/ 64 <1300000000>;
-		};
-
-		opp@1300000000,1050,3,2 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x0004>;
-			opp-hz = /bits/ 64 <1300000000>;
-		};
-
-		opp@1300000000,1050,3,3 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x0008>;
-			opp-hz = /bits/ 64 <1300000000>;
-		};
-
-		opp@1300000000,1050,3,4 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x0010>;
-			opp-hz = /bits/ 64 <1300000000>;
-		};
-
-		opp@1300000000,1050,3,5 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x0020>;
-			opp-hz = /bits/ 64 <1300000000>;
-		};
-
-		opp@1300000000,1050,3,6 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x0040>;
-			opp-hz = /bits/ 64 <1300000000>;
-		};
-
-		opp@1300000000,1050,2,7 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x04 0x0080>;
-			opp-hz = /bits/ 64 <1300000000>;
-		};
-
-		opp@1300000000,1050,2,8 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x04 0x0100>;
-			opp-hz = /bits/ 64 <1300000000>;
-		};
-
-		opp@1300000000,1050,3,12 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x1000>;
-			opp-hz = /bits/ 64 <1300000000>;
-		};
-
-		opp@1300000000,1050,3,13 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x2000>;
+			opp-supported-hw = <0x12 0x3061>, <0x04 0x0002>,
+					   <0x08 0x0004>, <0x08 0x0008>,
+					   <0x08 0x0010>, <0x08 0x0020>,
+					   <0x08 0x0040>, <0x04 0x0080>,
+					   <0x04 0x0100>, <0x08 0x1000>,
+					   <0x08 0x2000>;
 			opp-hz = /bits/ 64 <1300000000>;
 		};
 
 		opp@1300000000,1075 {
 			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x02 0x0182>;
-			opp-hz = /bits/ 64 <1300000000>;
-		};
-
-		opp@1300000000,1075,2,2 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x04 0x0004>;
-			opp-hz = /bits/ 64 <1300000000>;
-		};
-
-		opp@1300000000,1075,2,3 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x04 0x0008>;
-			opp-hz = /bits/ 64 <1300000000>;
-		};
-
-		opp@1300000000,1075,2,4 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x04 0x0010>;
+			opp-supported-hw = <0x02 0x0182>, <0x04 0x0004>,
+					   <0x04 0x0008>, <0x04 0x0010>;
 			opp-hz = /bits/ 64 <1300000000>;
 		};
 
@@ -1081,13 +427,7 @@ opp@1400000000,1125 {
 
 		opp@1400000000,1150 {
 			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x02 0x000C>;
-			opp-hz = /bits/ 64 <1400000000>;
-		};
-
-		opp@1400000000,1150,2,4 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x04 0x0010>;
+			opp-supported-hw = <0x02 0x000C>, <0x04 0x0010>;
 			opp-hz = /bits/ 64 <1400000000>;
 		};
 
@@ -1105,61 +445,17 @@ opp@1400000000,1237 {
 
 		opp@1500000000,1125 {
 			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x0010>;
-			opp-hz = /bits/ 64 <1500000000>;
-		};
-
-		opp@1500000000,1125,4,5 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x10 0x0020>;
-			opp-hz = /bits/ 64 <1500000000>;
-		};
-
-		opp@1500000000,1125,4,6 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x10 0x0040>;
-			opp-hz = /bits/ 64 <1500000000>;
-		};
-
-		opp@1500000000,1125,4,12 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x10 0x1000>;
-			opp-hz = /bits/ 64 <1500000000>;
-		};
-
-		opp@1500000000,1125,4,13 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x10 0x2000>;
+			opp-supported-hw = <0x08 0x0010>, <0x10 0x0020>,
+					   <0x10 0x0040>, <0x10 0x1000>,
+					   <0x10 0x2000>;
 			opp-hz = /bits/ 64 <1500000000>;
 		};
 
 		opp@1500000000,1150 {
 			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x04 0x0010>;
-			opp-hz = /bits/ 64 <1500000000>;
-		};
-
-		opp@1500000000,1150,3,5 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x0020>;
-			opp-hz = /bits/ 64 <1500000000>;
-		};
-
-		opp@1500000000,1150,3,6 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x0040>;
-			opp-hz = /bits/ 64 <1500000000>;
-		};
-
-		opp@1500000000,1150,3,12 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x1000>;
-			opp-hz = /bits/ 64 <1500000000>;
-		};
-
-		opp@1500000000,1150,3,13 {
-			clock-latency-ns = <100000>;
-			opp-supported-hw = <0x08 0x2000>;
+			opp-supported-hw = <0x04 0x0010>, <0x08 0x0020>,
+					   <0x08 0x0040>, <0x08 0x1000>,
+					   <0x08 0x2000>;
 			opp-hz = /bits/ 64 <1500000000>;
 		};
 
-- 
2.25.0.rc1.19.g042ed3e048af

