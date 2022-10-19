Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF8460498A
	for <lists+linux-pm@lfdr.de>; Wed, 19 Oct 2022 16:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbiJSOmu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Oct 2022 10:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiJSOm2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Oct 2022 10:42:28 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2908A17A036
        for <linux-pm@vger.kernel.org>; Wed, 19 Oct 2022 07:28:08 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id df9so11451426qvb.9
        for <linux-pm@vger.kernel.org>; Wed, 19 Oct 2022 07:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5vgVZXeinbhpnwzOcj3FGms9cM/M5Xj4R/cDa4Tk1cA=;
        b=rk5peA0BMWFeyDVMmseRsE34nvZ6ETndaDo8/pPXbdaMYNHXtIqBDx9Voigy0BlSKB
         w4Ch9hzSDZ6TEnBjZPBnKyTIPHIy4UaziH9o03NjzzrQ8HJ4nrvBXc35I8Bjo02kHFhH
         HTRueBS7B0zoCmi47wCK+/JrVRDlzKZICYaueC0HQ4YE5gmQ4CVRwJMmTS1EOvVl5kLy
         safAUk6uLnfvYRatROHZzB5PFDfETN+QPQAOLHEEvH5zyHPZs6SvPRJVGQCTUnmznXPP
         FanCKOiU1cWgR7wzMsBBed7tYw5v0bwiRzvdg0pD74ea8tYwgMTvlQ3jQeb9y23XbeaJ
         khrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5vgVZXeinbhpnwzOcj3FGms9cM/M5Xj4R/cDa4Tk1cA=;
        b=QSwzRPVYuJPgYssiN5NKXemZfxdg4OMvkh18dBChHA0SuhVUHKpBv8mrEOkE8m7q0q
         To5B2ziiXSwrATC5BaqzYoOYpfHtZk3EThMPAlKDLx/RxiiFY6BreZ+0mNbVb/BlR81R
         jMuQZWQ/N+rQ5ZCClzXMvhIxsZvL3pawc56q+bpjuHLWV8NJARxH1W9+2N8a2xHhF3P4
         c8h5J8Rj2mIFUeiEasCf4CdRzz4/q2LYHtB7AulqKdp70VeYm1lJqj6R1I3a1vhUoAGQ
         DyLv+jCRW7/iPk7HLO+b3zAYijsJ+fGrxGiVOQvrH0D3pAhDn5Is5BzDhXmw4MURLMO6
         oimQ==
X-Gm-Message-State: ACrzQf0DE/OX7YNpGiICUawp2BJBdQ9ABPv3GUBzmwSJ9SrYFY50ttlK
        7XexYtpcsHN3l5Im9Q/eZ87gZO9WNXdiiUd/dg==
X-Google-Smtp-Source: AMsMyM4mOJ/ZRGynrSUABhwfAdolVCW+k/oCuD8MciOZ3QxKdz/q9Sa33mzbHg22ndZhxIQLzGpdgQ==
X-Received: by 2002:a17:903:48e:b0:17e:ea4a:394e with SMTP id jj14-20020a170903048e00b0017eea4a394emr8350170plb.48.1666187999426;
        Wed, 19 Oct 2022 06:59:59 -0700 (PDT)
Received: from localhost.localdomain ([117.193.210.93])
        by smtp.gmail.com with ESMTPSA id 194-20020a6216cb000000b0053e199aa99bsm11240322pfw.220.2022.10.19.06.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 06:59:58 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, viresh.kumar@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        robh+dt@kernel.org
Cc:     johan@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 4/4] arm64: dts: qcom: sm8450: Supply clock from cpufreq node to CPUs
Date:   Wed, 19 Oct 2022 19:29:25 +0530
Message-Id: <20221019135925.366162-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221019135925.366162-1-manivannan.sadhasivam@linaro.org>
References: <20221019135925.366162-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Qualcomm platforms making use of CPUFreq HW Engine (EPSS/OSM) supply clocks
to the CPU cores. But this relationship is not represented in DTS so far.

So let's make cpufreq node as the clock provider and CPU nodes as the
consumers. The clock index for each CPU node is based on the frequency
domain index.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 6c18cfca9a34..8f26cf9aad01 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -52,6 +52,7 @@ CPU0: cpu@0 {
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
+			clocks = <&cpufreq_hw 0>;
 			L2_0: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -71,6 +72,7 @@ CPU1: cpu@100 {
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
+			clocks = <&cpufreq_hw 0>;
 			L2_100: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -87,6 +89,7 @@ CPU2: cpu@200 {
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
+			clocks = <&cpufreq_hw 0>;
 			L2_200: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -103,6 +106,7 @@ CPU3: cpu@300 {
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
+			clocks = <&cpufreq_hw 0>;
 			L2_300: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -119,6 +123,7 @@ CPU4: cpu@400 {
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
+			clocks = <&cpufreq_hw 1>;
 			L2_400: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -135,6 +140,7 @@ CPU5: cpu@500 {
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
+			clocks = <&cpufreq_hw 1>;
 			L2_500: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -152,6 +158,7 @@ CPU6: cpu@600 {
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
+			clocks = <&cpufreq_hw 1>;
 			L2_600: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -168,6 +175,7 @@ CPU7: cpu@700 {
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 2>;
 			#cooling-cells = <2>;
+			clocks = <&cpufreq_hw 2>;
 			L2_700: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -3804,6 +3812,7 @@ cpufreq_hw: cpufreq@17d91000 {
 				     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "dcvsh-irq-0", "dcvsh-irq-1", "dcvsh-irq-2";
 			#freq-domain-cells = <1>;
+			#clock-cells = <1>;
 		};
 
 		gem_noc: interconnect@19100000 {
-- 
2.25.1

