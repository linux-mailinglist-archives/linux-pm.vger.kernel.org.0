Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD3B62D2C0
	for <lists+linux-pm@lfdr.de>; Thu, 17 Nov 2022 06:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbiKQFcM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Nov 2022 00:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbiKQFcH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Nov 2022 00:32:07 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A9B59871
        for <linux-pm@vger.kernel.org>; Wed, 16 Nov 2022 21:32:05 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id z26so756276pff.1
        for <linux-pm@vger.kernel.org>; Wed, 16 Nov 2022 21:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWX3PFtX+iNvvcqKHYXPbN+3ItiEZ3sX7UGhc0uTyP8=;
        b=PR/8mCOnSsExiSeGPcrsDsleREB/V6THyCi3uFVYT0j0AN5xogqVE3FLHGytVZcWU4
         kB2+/E1fXz3G8tOdtQZJv62+cYuQYbCDqOTRuJk9Nl3DfGNHUaepKJxMKKBfiV5mj6NT
         hNvdH6hk7hESk5PBu5cMBukPXuuhmgzS5XXW67ZaryqwsmDtbDZkoRcIQpOCiPFyH5FJ
         Tc+wzJ4zbz8lsPF8hreHyuD8Zipsqgx63uVcvMlOOhw8mEG3oi1t1R7hBabZxme/JJ8A
         8/FbAP//ZlNkdEEHUH5leHxw3lvbaIW1P7hrr3tR4H72HVWY4Kr0LJSEIOXpnmfl+Mtm
         8faQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWX3PFtX+iNvvcqKHYXPbN+3ItiEZ3sX7UGhc0uTyP8=;
        b=zs2YKcePVObuVbPFspX/BKugfBI26oan0KZ7OiqjpjDYSj3M9T55f0nFalniMU5Yiz
         dGgF2PKNEYoOxcqAkTKfXqs9DMe4WFq3BIfauz5fA4sq2Mn6470JAxf0v3WGmenP7FIs
         RkW5lQMgy34hZhLYbcTLNM91e/BUhPUfiJwX0WszFhNmBomu0Ergk2c9CtFvjy0dpPGc
         B6L1fGkZDreUDGLvwgqFo+d2brjkVV5jsDbGuxDwLuqzTXyeiB8tAr+Bw9OqbAnnuHLp
         39q2okOiu+qVYDvvWXxSaoy2Tr7dlM9muOwOLt/amTNAo5mXzHzoYLlIBq0DCYY8ufYc
         1NLQ==
X-Gm-Message-State: ANoB5pkEVUrISF3+QIjEA57Qi7VPI8cvzACy86tYlfePiTL3WkBbL21H
        0XIs1/2IBWdYF9mLQ5tINkLo
X-Google-Smtp-Source: AA0mqf596ElvuTAZzHJPp1dMZ8uSpBb2RkvwDNIyWnM89C+eP/0uDvGfayB9kJqfdCh3qB/iOlGssw==
X-Received: by 2002:a65:6d95:0:b0:46f:f482:6920 with SMTP id bc21-20020a656d95000000b0046ff4826920mr670439pgb.327.1668663125387;
        Wed, 16 Nov 2022 21:32:05 -0800 (PST)
Received: from localhost.localdomain ([117.193.208.31])
        by smtp.gmail.com with ESMTPSA id q4-20020a17090311c400b001865c298588sm96600plh.258.2022.11.16.21.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 21:32:04 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, viresh.kumar@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        robh+dt@kernel.org
Cc:     johan@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v7 2/4] arm64: dts: qcom: sm8450: Supply clock from cpufreq node to CPUs
Date:   Thu, 17 Nov 2022 11:01:43 +0530
Message-Id: <20221117053145.10409-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221117053145.10409-1-manivannan.sadhasivam@linaro.org>
References: <20221117053145.10409-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index d32f08df743d..234d2722a4fa 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -51,6 +51,7 @@ CPU0: cpu@0 {
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
+			clocks = <&cpufreq_hw 0>;
 			L2_0: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -70,6 +71,7 @@ CPU1: cpu@100 {
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
+			clocks = <&cpufreq_hw 0>;
 			L2_100: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -86,6 +88,7 @@ CPU2: cpu@200 {
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
+			clocks = <&cpufreq_hw 0>;
 			L2_200: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -102,6 +105,7 @@ CPU3: cpu@300 {
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
+			clocks = <&cpufreq_hw 0>;
 			L2_300: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -118,6 +122,7 @@ CPU4: cpu@400 {
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
+			clocks = <&cpufreq_hw 1>;
 			L2_400: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -134,6 +139,7 @@ CPU5: cpu@500 {
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
+			clocks = <&cpufreq_hw 1>;
 			L2_500: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -151,6 +157,7 @@ CPU6: cpu@600 {
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
+			clocks = <&cpufreq_hw 1>;
 			L2_600: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -167,6 +174,7 @@ CPU7: cpu@700 {
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 2>;
 			#cooling-cells = <2>;
+			clocks = <&cpufreq_hw 2>;
 			L2_700: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -3075,6 +3083,7 @@ cpufreq_hw: cpufreq@17d91000 {
 				     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "dcvsh-irq-0", "dcvsh-irq-1", "dcvsh-irq-2";
 			#freq-domain-cells = <1>;
+			#clock-cells = <1>;
 		};
 
 		gem_noc: interconnect@19100000 {
-- 
2.25.1

