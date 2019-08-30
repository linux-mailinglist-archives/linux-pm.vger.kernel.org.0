Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8CCA34F4
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2019 12:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfH3K3X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Aug 2019 06:29:23 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40956 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727521AbfH3K3X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Aug 2019 06:29:23 -0400
Received: by mail-lj1-f194.google.com with SMTP id e27so5975759ljb.7
        for <linux-pm@vger.kernel.org>; Fri, 30 Aug 2019 03:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=77jjzv0Z9CzErPSRHF84ZQ30/TlT+daBnsbqrJqJCd4=;
        b=Pf2xiclZwwkFi4pPMvFrD4oBHqaPKSusBqloCaplvgLWIbPC5oH6J8nSFdYgrMURxK
         XNRzdtUAG1gZ1p4U0kmKOiFjF8bXqPCiUlsMYqjXNk7Gb66QODKm3AETHHzBqvHLieEd
         0+i/nehhw3anG74awucIWO/fUwOk/jR0+3Woz3A7bzK4fpcBZOVXEABjHdcBZNj5hzk4
         1UuJsIn7X+Vp/KBQsvl9cbl0c9w4hFmDvqRV8sqFenRUB7MKkE9Cphs/KuXdfTjHeqZj
         +ERRSybPlqUD9bPHV5SPvwe+QgTmUNpg2klC11Bk4uXzy5CCfgwbhtVR84p7ueTI6duW
         9KyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=77jjzv0Z9CzErPSRHF84ZQ30/TlT+daBnsbqrJqJCd4=;
        b=bTSNq/vY8MSpEUKO87EyoDBtmEm+tnLOXK9vdwzf+T5TwQ9VhR8r5+Lfa2PiuHM4d7
         GcjdH+sgZk4VTxAkACrzl3T/lDjJpeFXcmRkE8Zhwx2GiFAHSH30zXx5BdApy0rjtLSm
         RT/7hCILcp1WNYzOUSKxFcB3i8rZEnaXke7mbf9yg2ZzEEIVum9HV5HP+bOUaloRIjmA
         SM+PG4rhGLJVVeuLKCs07FwrUKhnonTYyjdiKm/x+UoAfc5oL7aVOYkS570yNOREbaJ1
         DmzO8F4iG587MNwzaNHhP2sTC+bjLt7mMQEWLCnEbR0bTde9wArDo4haZNCP4FYSvoAI
         FCQg==
X-Gm-Message-State: APjAAAU1gI9c6x0AQxEfnNaUq0TZ7wbSkTfj7aj1bQtLeOi7tRPOwIRk
        fM2MIbICRqeOmCRKrDVYmJsCRQ==
X-Google-Smtp-Source: APXvYqxafQzvzz4MY5Rs0uUe86I235CVUgWRrKRXteTpBF1m851Sy/GmfwzhCJVCHjj32713TXhdvg==
X-Received: by 2002:a2e:a313:: with SMTP id l19mr8299166lje.32.1567160960375;
        Fri, 30 Aug 2019 03:29:20 -0700 (PDT)
Received: from localhost.localdomain (ua-84-219-138-247.bbcust.telenor.se. [84.219.138.247])
        by smtp.gmail.com with ESMTPSA id l8sm778786lja.38.2019.08.30.03.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 03:29:19 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Ilia Lin <ilia.lin@kernel.org>, Andy Gross <agross@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/14] dt-bindings: opp: qcom-nvmem: Support pstates provided by a power domain
Date:   Fri, 30 Aug 2019 12:29:15 +0200
Message-Id: <20190830102915.7418-1-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190819100957.17095-1-niklas.cassel@linaro.org>
References: <20190819100957.17095-1-niklas.cassel@linaro.org>
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
Changes since V3:
-In Example 2: rename the node name from cpr to power-controller,
and rename the label from cprpd to cpr.

 .../bindings/opp/qcom-nvmem-cpufreq.txt       | 113 +++++++++++++++++-
 1 file changed, 112 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt b/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
index c5ea8b90e35d..4751029b9b74 100644
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
+			power-domains = <&cpr>;
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
+			power-domains = <&cpr>;
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
+			power-domains = <&cpr>;
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
+			power-domains = <&cpr>;
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
+	cpr: power-controller@b018000 {
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

