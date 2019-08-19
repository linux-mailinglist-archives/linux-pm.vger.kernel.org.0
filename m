Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB9FA920FB
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2019 12:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfHSKKM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Aug 2019 06:10:12 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34062 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfHSKKL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Aug 2019 06:10:11 -0400
Received: by mail-lj1-f194.google.com with SMTP id x18so1206557ljh.1
        for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2019 03:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bFsYBz11w/0+2ipDFc6RAzNYkyX/rGj3LfC3+f/vlp4=;
        b=beyi9uGJnPpG8O0vT7qQxG//HWz2f6IINF0hBwHiHXB3kM5NEIyK3NG65ahyuzltQn
         HwoxDU9bsUkPsLT2MHe2pzdSOftUh6tGgYxJ2PUa0Sw7H1uV3stySjV8LZplZKEUFRo1
         1Maodh2jZXqnsXwBVOS+g7SjZozY0N2P2ppxGP3+EPBO5n3rpwN1+RvTcGELgeGjE/+c
         SEYlGvgFZQlQ3cYuGhsm3Qg7gDua8/tTFp179tb3eMFcaWj5mh9KwHU7WogsqXdVypED
         HPITvLx5YQBBjPJOA37N4CS1M6xlUFJupOFzYyH+79Fvw+WcGFoKXUvrZfAYTlPZMgRY
         ZtCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bFsYBz11w/0+2ipDFc6RAzNYkyX/rGj3LfC3+f/vlp4=;
        b=s1uRvCIrNqTBP1SST/F3VlWQnyMmcnC5bAl0sdjIQGOKj4DIYweXwQ+JYwWh/Ee6EB
         HKpjDvpcFWyKSjkzygRwpNkpT+djIRlxauB7tvU3Ers7XYp1ST0p+XaOInIAkS32ZJNA
         PfUhhpPne1upVVXMWwFhb49kvk7Xi2GE0VlmP2wyUSJ+qk+9sjbxwOEAg4ctmmzpoh8y
         7wu6Z3UPZVTXR+0832zVeND4z/CBYHtuyjDPMktIe3cqPe94cuaIbLMpgnf1hwodQw8+
         1AS34ib3vrxwKEfQR39pEngFCQr09ZJ5rwSm6qLY9sVPeVsmQoAWe/VpgatFUOR/B0xN
         296g==
X-Gm-Message-State: APjAAAVcDDDQovTeuGSGPR4HuGHUIDG2AVp3aR44X24fQiJP1g6j8mHz
        e/LiEoC91UvOUoW+QjlgFek/oQ==
X-Google-Smtp-Source: APXvYqyKKUveTAbKAVd1czgb5WboXpJSisP+Hj43L+mlwuCq45a9rieZfHZEJUNuJ3gFablY68RhWA==
X-Received: by 2002:a05:651c:29b:: with SMTP id b27mr12017195ljo.74.1566209409256;
        Mon, 19 Aug 2019 03:10:09 -0700 (PDT)
Received: from localhost.localdomain (ua-84-219-138-247.bbcust.telenor.se. [84.219.138.247])
        by smtp.gmail.com with ESMTPSA id g9sm1401833lje.90.2019.08.19.03.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 03:10:08 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <agross@kernel.org>, Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/14] dt-bindings: cpufreq: qcom-nvmem: Support pstates provided by a power domain
Date:   Mon, 19 Aug 2019 12:09:57 +0200
Message-Id: <20190819100957.17095-1-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190725104144.22924-7-niklas.cassel@linaro.org>
References: <20190725104144.22924-7-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some Qualcomm SoCs have support for Core Power Reduction (CPR).
On these platforms, we need to attach to the power domain provider
providing the performance states, so that the leaky device (the CPU)
can configure the performance states (which represent different
CPU clock frequencies).

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes since V2:
-Picked up Rob's Reviewed-by on V2.
-As Rob pointed out in V1, it should be
"In 'cpu' nodes" and not "In 'cpus' nodes".
-In Example 2: include the qcom,opp-fuse-level property rather than "...",
since Rob pointed out in the review of V1 of "dt-bindings: opp: Add
 qcom-opp bindings with properties needed for CPR", that this property was
missing in this patch.

 .../bindings/opp/qcom-nvmem-cpufreq.txt       | 113 +++++++++++++++++-
 1 file changed, 112 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt b/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
index c5ea8b90e35d..1e6261570f3e 100644
--- a/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
+++ b/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
@@ -14,7 +14,7 @@ operating-points-v2 table when it is parsed by the OPP framework.
 
 Required properties:
 --------------------
-In 'cpus' nodes:
+In 'cpu' nodes:
 - operating-points-v2: Phandle to the operating-points-v2 table to use.
 
 In 'operating-points-v2' table:
@@ -23,6 +23,15 @@ In 'operating-points-v2' table:
 
 Optional properties:
 --------------------
+In 'cpu' nodes:
+- power-domains: A phandle pointing to the PM domain specifier which provides
+		the performance states available for active state management.
+		Please refer to the power-domains bindings
+		Documentation/devicetree/bindings/power/power_domain.txt
+		and also examples below.
+- power-domain-names: Should be
+	- 'cpr' for qcs404.
+
 In 'operating-points-v2' table:
 - nvmem-cells: A phandle pointing to a nvmem-cells node representing the
 		efuse registers that has information about the
@@ -682,3 +691,105 @@ soc {
 		};
 	};
 };
+
+Example 2:
+---------
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		CPU0: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x100>;
+			....
+			clocks = <&apcs_glb>;
+			operating-points-v2 = <&cpu_opp_table>;
+			power-domains = <&cprpd>;
+			power-domain-names = "cpr";
+		};
+
+		CPU1: cpu@101 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x101>;
+			....
+			clocks = <&apcs_glb>;
+			operating-points-v2 = <&cpu_opp_table>;
+			power-domains = <&cprpd>;
+			power-domain-names = "cpr";
+		};
+
+		CPU2: cpu@102 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x102>;
+			....
+			clocks = <&apcs_glb>;
+			operating-points-v2 = <&cpu_opp_table>;
+			power-domains = <&cprpd>;
+			power-domain-names = "cpr";
+		};
+
+		CPU3: cpu@103 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x103>;
+			....
+			clocks = <&apcs_glb>;
+			operating-points-v2 = <&cpu_opp_table>;
+			power-domains = <&cprpd>;
+			power-domain-names = "cpr";
+		};
+	};
+
+	cpu_opp_table: cpu-opp-table {
+		compatible = "operating-points-v2-kryo-cpu";
+		opp-shared;
+
+		opp-1094400000 {
+			opp-hz = /bits/ 64 <1094400000>;
+			required-opps = <&cpr_opp1>;
+		};
+		opp-1248000000 {
+			opp-hz = /bits/ 64 <1248000000>;
+			required-opps = <&cpr_opp2>;
+		};
+		opp-1401600000 {
+			opp-hz = /bits/ 64 <1401600000>;
+			required-opps = <&cpr_opp3>;
+		};
+	};
+
+	cpr_opp_table: cpr-opp-table {
+		compatible = "operating-points-v2-qcom-level";
+
+		cpr_opp1: opp1 {
+			opp-level = <1>;
+			qcom,opp-fuse-level = <1>;
+		};
+		cpr_opp2: opp2 {
+			opp-level = <2>;
+			qcom,opp-fuse-level = <2>;
+		};
+		cpr_opp3: opp3 {
+			opp-level = <3>;
+			qcom,opp-fuse-level = <3>;
+		};
+	};
+
+....
+
+soc {
+....
+	cprpd: cpr@b018000 {
+		compatible = "qcom,qcs404-cpr", "qcom,cpr";
+		reg = <0x0b018000 0x1000>;
+		....
+		vdd-apc-supply = <&pms405_s3>;
+		#power-domain-cells = <0>;
+		operating-points-v2 = <&cpr_opp_table>;
+		....
+	};
+};
-- 
2.21.0

