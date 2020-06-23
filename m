Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22598205A2E
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jun 2020 20:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733165AbgFWSIo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jun 2020 14:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732973AbgFWSIn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jun 2020 14:08:43 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FE4C061755;
        Tue, 23 Jun 2020 11:08:43 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r12so4192348wrj.13;
        Tue, 23 Jun 2020 11:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wmk06+uHMYStxINkbw/YmMFydULrtqnVnBZmXZdaYkU=;
        b=gw4tvqYyWuEvNESNYG3QCDqaQ0LpAJi9MJQxZQgwm/xprtH3C8rrXykG/dGPiKKRWE
         ZZA4YTnFkNrVTzSoci6jBuV6mtipIPVf0SdCAttl6VZHk40Tr7DbJpqhc1zFn5v93v0s
         cHK5fqxdKbeuPxn+06PHWCZik72DvPCu6gLL2+IPuIOrNoDYwB4QVws4VsXaQXARXbAX
         HGdA1Xd+FsM5e+xHJH6JoLq9QZnQXe6iEEy6xwG54tgzEHq/80DkXkdU5TjWuGwppfnz
         ysYL8ZPGIO19wLkiXnnlbJDslMgCZ54OpVfax1gDXEtpuAEI4GzC3gG4NfwbQegVhWEi
         hNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wmk06+uHMYStxINkbw/YmMFydULrtqnVnBZmXZdaYkU=;
        b=grnCY/G4hfwiRiZaiSesg4qKnyPy5lXCo94zc/Qt6lfJc+KgBP2dCKLE+MP4XdWX8G
         NkmLLbbp6NqducZmSeGU7Ork2taSuTOQnHtRFc+oH+Headl6SvoTFI8e11iPmCgtKxcO
         z2jIiEezbmdNIYypconIruN7DuV+FlIFPu4pn2udUbNpCRpFSS1UjjN/bYjYaHl5KLv6
         GRrqf2qIDltrYe5e1wTlhr+1liiarBKIidiWoryRGYdxmrA2J8I4AWF4/bgFjcNg0Ax+
         oLscc90wU2LpwaAgEq5wIFFoCWedrHs5kLA0UWjBI1TzHzfpQITg9frG6PN606OgQ2PG
         orbA==
X-Gm-Message-State: AOAM532/GK0BXNCsdSuC9Zn9KHrjlSybo8f3zhsPm6FXpdJNlzENI1M8
        oB+XpDy1NWlSwKNE9ThsRdg=
X-Google-Smtp-Source: ABdhPJyTfs0KGdP7wzNf0RdFp0ndR475lqXCS5YjNCYCXDjIsT7+XPkpIDeGVqTT//m53ZeIIrWcBA==
X-Received: by 2002:adf:e545:: with SMTP id z5mr25716968wrm.89.1592935722251;
        Tue, 23 Jun 2020 11:08:42 -0700 (PDT)
Received: from localhost.localdomain (abag196.neoplus.adsl.tpnet.pl. [83.6.170.196])
        by smtp.googlemail.com with ESMTPSA id c16sm4719529wml.45.2020.06.23.11.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 11:08:41 -0700 (PDT)
From:   Konrad Dybcio <konradybcio@gmail.com>
To:     skrzynka@konradybcio.pl
Cc:     Konrad Dybcio <konradybcio@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 2/8] arm64: dts: qcom: sdm630: Add RPM power domains support
Date:   Tue, 23 Jun 2020 20:08:26 +0200
Message-Id: <20200623180832.254163-3-konradybcio@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623180832.254163-1-konradybcio@gmail.com>
References: <20200623180832.254163-1-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the rpmpd node on the sdm630 and define the available levels.

Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 46 ++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index 88efe8200c80..ea85f28032d2 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -428,6 +428,52 @@ rpmcc: clock-controller {
 				compatible = "qcom,rpmcc-sdm660", "qcom,rpmcc";
 				#clock-cells = <1>;
 			};
+
+			rpmpd: power-controller {
+				compatible = "qcom,sdm660-rpmpd";
+				#power-domain-cells = <1>;
+				operating-points-v2 = <&rpmpd_opp_table>;
+
+				rpmpd_opp_table: opp-table {
+					compatible = "operating-points-v2";
+
+					rpmpd_opp_ret: opp1 {
+						opp-level = <16>;
+					};
+
+					rpmpd_opp_ret_plus: opp2 {
+						opp-level = <32>;
+					};
+
+					rpmpd_opp_min_svs: opp3 {
+						opp-level = <48>;
+					};
+
+					rpmpd_opp_low_svs: opp4 {
+						opp-level = <64>;
+					};
+
+					rpmpd_opp_svs: opp5 {
+						opp-level = <128>;
+					};
+
+					rpmpd_opp_svs_plus: opp6 {
+						opp-level = <192>;
+					};
+
+					rpmpd_opp_nom: opp7 {
+						opp-level = <256>;
+					};
+
+					rpmpd_opp_nom_plus: opp8 {
+						opp-level = <320>;
+					};
+
+					rpmpd_opp_turbo: opp9 {
+						opp-level = <384>;
+					};
+				};
+			};
 		};
 	};
 
-- 
2.27.0

