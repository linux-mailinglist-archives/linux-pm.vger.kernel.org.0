Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE922A6AEC
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 17:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731500AbgKDQtv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 11:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731493AbgKDQtu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 11:49:50 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF12C0613D4;
        Wed,  4 Nov 2020 08:49:49 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id y16so23729252ljk.1;
        Wed, 04 Nov 2020 08:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d/Sk3dwc3ZzPQh0+4njd7Ejlh1IFm+rB1ccMwqr+vGE=;
        b=l3LKe/mpPu0S8/dCOq6M2kz5lSPjJIkDiZkJ392mXO0421xd0wR0g+uOXZu3Dp6GNh
         tig0xwfVmcWuRwSddNabK0tKmD9eiUiHmMnpBBpYyQsiolkHs6ybryKNoGIVmvUoj6mT
         ZoVdAYiceuqcnDB8+mK/Y52+5BOgvmMeR8RuFYe5GfwIbOlNfG7+BJWLe6WZpsli+6Pf
         JdpL/bqxj2ePobj0I6x+B4d6skuRAUZdvSHHxJhupeFc3dDdE3n0DFN/kYXJWmBqH0GV
         6PBYnodpQBz72zJUvr33uIEYqRK5w81me4rBiefPXZLOBAHDnuZCa6+wdwuq0NWJzPtm
         LWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d/Sk3dwc3ZzPQh0+4njd7Ejlh1IFm+rB1ccMwqr+vGE=;
        b=qKfTEtsSWSrWgctAWYgOXQ4Jyjah02Nlt4J54rryEd/wAXEM+UYAw2RlsaIugtEbWV
         CPHSeTaek1Mmjt9PyMO0ImsHrrZGciSb2a7F88XoSyz6ie3fTlh4e9yAXsBg3O5Cmzxz
         CBIa9/LNz5PQn8LKLncZawHivQt0sWB+ADyClsj4jL8rkzJhSZ1ma6nHmkhd7yx7ITuK
         ziKT/c5sr0tfmNOBm8vPhONKwz5ER1EQDjqhT6z0eWWHtWW+lro6n00Pk6IVCrGn/KOY
         yxGC5TfXsjirY+a61vk9PIZv7PCckoHuS2kpZkva65lbvBZ9vt8YvmNEezIQvzL0TC6F
         npTQ==
X-Gm-Message-State: AOAM530IG87kQ5oJPmWL0til37cryXF8AgJthnZZjK/coHApI+w4su8v
        fv2CPrNJ21WKSa/Ww9IWqsI=
X-Google-Smtp-Source: ABdhPJzOM97kyPaLdS5FBsoSI5pNCOmFXgHHRAlsYMvgYsazvVkHm7oOeCMGO/mgd30CUSSL1TDgdg==
X-Received: by 2002:a2e:3a08:: with SMTP id h8mr11610597lja.125.1604508588138;
        Wed, 04 Nov 2020 08:49:48 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m2sm454587lfo.25.2020.11.04.08.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:49:47 -0800 (PST)
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
Subject: [PATCH v7 15/47] dt-bindings: tegra30-actmon: Document OPP and interconnect properties
Date:   Wed,  4 Nov 2020 19:48:51 +0300
Message-Id: <20201104164923.21238-16-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104164923.21238-1-digetx@gmail.com>
References: <20201104164923.21238-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Document EMC DFS OPP table and interconnect paths that will be used
for scaling of system's memory bandwidth based on memory utilization
statistics. Previously ACTMON was supposed to drive EMC clock rate
directly, but now it should do it using interconnect framework in order
to support shared voltage scaling in addition to the frequency scaling.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../arm/tegra/nvidia,tegra30-actmon.txt       | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra30-actmon.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra30-actmon.txt
index ea670a5d7ee3..897eedfa2bc8 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra30-actmon.txt
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra30-actmon.txt
@@ -18,8 +18,30 @@ clock-names. See ../../clock/clock-bindings.txt for details.
 ../../reset/reset.txt for details.
 - reset-names: Must include the following entries:
   - actmon
+- operating-points-v2: See ../bindings/opp/opp.txt for details.
+- interconnects: Should contain entries for memory clients sitting on
+                 MC->EMC memory interconnect path.
+- interconnect-names: Should include name of the interconnect path for each
+                      interconnect entry. Consult TRM documentation for
+                      information about available memory clients, see MEMORY
+                      CONTROLLER section.
+
+For each opp entry in 'operating-points-v2' table:
+- opp-supported-hw: bitfield indicating SoC speedo ID mask
+- opp-peak-kBps: peak bandwidth of the memory channel
 
 Example:
+	dfs_opp_table: opp-table {
+		compatible = "operating-points-v2";
+
+		opp@12750000 {
+			opp-hz = /bits/ 64 <12750000>;
+			opp-supported-hw = <0x000F>;
+			opp-peak-kBps = <51000>;
+		};
+		...
+	};
+
 	actmon@6000c800 {
 		compatible = "nvidia,tegra124-actmon";
 		reg = <0x0 0x6000c800 0x0 0x400>;
@@ -29,4 +51,7 @@ Example:
 		clock-names = "actmon", "emc";
 		resets = <&tegra_car 119>;
 		reset-names = "actmon";
+		operating-points-v2 = <&dfs_opp_table>;
+		interconnects = <&mc TEGRA124_MC_MPCORER &emc>;
+		interconnect-names = "cpu";
 	};
-- 
2.27.0

