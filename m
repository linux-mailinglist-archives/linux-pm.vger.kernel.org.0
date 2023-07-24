Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E2576016A
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jul 2023 23:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjGXVnG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Jul 2023 17:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbjGXVm6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jul 2023 17:42:58 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C056CE9;
        Mon, 24 Jul 2023 14:42:55 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5774335bb2aso53620497b3.0;
        Mon, 24 Jul 2023 14:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690234975; x=1690839775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0oxSjPAKp2xoMPL2iv15VWWXcukMXGWFr8bEVz88bk=;
        b=daJ4Ql/3z+fbfRToWZCvoimhluP2tZ8D9KBzNvHqybugivGNDyfqKQDNrDVQhkx3qb
         htrYjbvtFmqsIOIdyfKk+oSOmNaJaDULlGX+K2gvNGMnl+e9AXFsZb5kHQEfk5eOzvDb
         STSkYfutQ9FPOfwoLkX/fAvHIORC8kqz6YqGIxGO0wu1XBFvLhJtHjympuqItcoVFKE5
         RaQaue4mDFnpDc8QY15+ELdVMSxeFXu3/ArAJqbvr736K/hoWpdbjv5c0L26kv93QjnW
         5Ts9uMGKO/6NCw0QfnbPt4WCdz/ciiRx8lkd0/shMwKTIOstliJwIQCPfCFpVg/Apjah
         /zRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690234975; x=1690839775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0oxSjPAKp2xoMPL2iv15VWWXcukMXGWFr8bEVz88bk=;
        b=BkfmZqG1VqiJJe5Ij/Zq59eB3r73h7nHhorEPFjTTRzW8w9fQ0Fsi/E+Y5ZggZv/Mi
         GIT18clMlhh7Zmdk+68innGKbhNX8LMQqqJcUASHxR3RoRQ229qXZr3YThs7Hv/ZbYnv
         eZfVCyD7XzoLD1xy+jIXzOVFva/YZm7iVmM1Ssf5Ypntxa1qY21ufEh1j1KwpmtDr+Y1
         ynB/H8Tnvo55PuqXr6HFR/rJE4np7YKMlix3fIEhnO2xQ3StpSluzXPvc8LvdAK6tbqt
         OI6z4T0OU5Ywm+J8i+7smpt5dEzuAxQkU86Bl/CzcAeQmpW6ZAxWf8lAObh2wXzTruva
         w0qg==
X-Gm-Message-State: ABy/qLYYs+Xbcwwj/ThQvOZHllkwPOEq40vj/3BC49CArtBTJzcH6Ff3
        LI+7GX7nr/XZStf6o5rCNac=
X-Google-Smtp-Source: APBJJlGpTNQFQsnIOd1TggpD5JshBpx/fNgVmXC2mgc1j5pyABRvTfZCee0+nmJmn6HEwyAKiP9SWw==
X-Received: by 2002:a0d:d402:0:b0:569:479f:6d7f with SMTP id w2-20020a0dd402000000b00569479f6d7fmr7505007ywd.43.1690234974881;
        Mon, 24 Jul 2023 14:42:54 -0700 (PDT)
Received: from localhost ([2607:fea8:529e:7800::3cbb])
        by smtp.gmail.com with ESMTPSA id e11-20020a81690b000000b00583803487ccsm3099267ywc.122.2023.07.24.14.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 14:42:54 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH 4/4] arm64: dts: qcom: sdm670: add frequency profile
Date:   Mon, 24 Jul 2023 17:42:14 -0400
Message-ID: <20230724214209.208699-10-mailingradian@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230724214209.208699-6-mailingradian@gmail.com>
References: <20230724214209.208699-6-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the coefficients for the CPU frequencies to aid in frequency
scaling.

Profiling setup:
 - freqbench (https://github.com/kdrag0n/freqbench)
 - LineageOS kernel, android_kernel_google_msm-4.9
 - recommended configuration options by freqbench
 - disabled options that require clang or 32-bit compilers
 - mmc governor switched from simple_ondemand to powersave

    Frequency domains: cpu1 cpu6
    Offline CPUs: cpu1 cpu2 cpu3 cpu4 cpu5 cpu6 cpu7
    Sampling power every 1000 ms
    Baseline power usage: 445 mW

    ===== CPU 1 =====
    Frequencies: 300 576 748 998 1209 1324 1516 1612 1708

     300:  1114     3.7 C/MHz     43 mW   11.6 J   25.8 I/mJ   269.4 s
     576:  2138     3.7 C/MHz     51 mW    7.1 J   42.2 I/mJ   140.3 s
     748:  2780     3.7 C/MHz     67 mW    7.3 J   41.3 I/mJ   107.9 s
     998:  3706     3.7 C/MHz     73 mW    5.9 J   51.1 I/mJ    80.9 s
    1209:  4490     3.7 C/MHz     86 mW    5.7 J   52.2 I/mJ    66.8 s
    1324:  4918     3.7 C/MHz     90 mW    5.5 J   54.6 I/mJ    61.0 s
    1516:  5631     3.7 C/MHz    103 mW    5.5 J   54.9 I/mJ    53.3 s
    1612:  5987     3.7 C/MHz    109 mW    5.5 J   55.0 I/mJ    50.1 s
    1708:  6344     3.7 C/MHz    126 mW    5.9 J   50.5 I/mJ    47.3 s

    ===== CPU 6 =====
    Frequencies: 300 652 825 979 1132 1363 1536 1747 1843 1996

     300:  1868     6.2 C/MHz     53 mW    8.5 J   35.2 I/mJ   160.6 s
     652:  4073     6.2 C/MHz     96 mW    7.1 J   42.4 I/mJ    73.7 s
     825:  5132     6.2 C/MHz    117 mW    6.9 J   43.7 I/mJ    58.5 s
     979:  6099     6.2 C/MHz    151 mW    7.4 J   40.4 I/mJ    49.2 s
    1132:  7071     6.2 C/MHz    207 mW    8.8 J   34.1 I/mJ    42.4 s
    1363:  8482     6.2 C/MHz    235 mW    8.3 J   36.1 I/mJ    35.4 s
    1536:  9578     6.2 C/MHz    287 mW    9.0 J   33.3 I/mJ    31.3 s
    1747: 10892     6.2 C/MHz    340 mW    9.4 J   32.0 I/mJ    27.6 s
    1843: 11471     6.2 C/MHz    368 mW    9.6 J   31.1 I/mJ    26.2 s
    1996: 12425     6.2 C/MHz    438 mW   10.6 J   28.3 I/mJ    24.2 s

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
---
 arch/arm64/boot/dts/qcom/sdm670.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm670.dtsi b/arch/arm64/boot/dts/qcom/sdm670.dtsi
index d013d0279dc9..d68cdf34c31a 100644
--- a/arch/arm64/boot/dts/qcom/sdm670.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm670.dtsi
@@ -36,6 +36,8 @@ CPU0: cpu@0 {
 			compatible = "qcom,kryo360";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
+			capacity-dmips-mhz = <610>;
+			dynamic-power-coefficient = <203>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gladiator_noc MASTER_AMPSS_M0 3 &mem_noc SLAVE_EBI_CH0 3>,
@@ -61,6 +63,8 @@ CPU1: cpu@100 {
 			compatible = "qcom,kryo360";
 			reg = <0x0 0x100>;
 			enable-method = "psci";
+			capacity-dmips-mhz = <610>;
+			dynamic-power-coefficient = <203>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gladiator_noc MASTER_AMPSS_M0 3 &mem_noc SLAVE_EBI_CH0 3>,
@@ -81,6 +85,8 @@ CPU2: cpu@200 {
 			compatible = "qcom,kryo360";
 			reg = <0x0 0x200>;
 			enable-method = "psci";
+			capacity-dmips-mhz = <610>;
+			dynamic-power-coefficient = <203>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gladiator_noc MASTER_AMPSS_M0 3 &mem_noc SLAVE_EBI_CH0 3>,
@@ -101,6 +107,8 @@ CPU3: cpu@300 {
 			compatible = "qcom,kryo360";
 			reg = <0x0 0x300>;
 			enable-method = "psci";
+			capacity-dmips-mhz = <610>;
+			dynamic-power-coefficient = <203>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gladiator_noc MASTER_AMPSS_M0 3 &mem_noc SLAVE_EBI_CH0 3>,
@@ -121,6 +129,8 @@ CPU4: cpu@400 {
 			compatible = "qcom,kryo360";
 			reg = <0x0 0x400>;
 			enable-method = "psci";
+			capacity-dmips-mhz = <610>;
+			dynamic-power-coefficient = <203>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gladiator_noc MASTER_AMPSS_M0 3 &mem_noc SLAVE_EBI_CH0 3>,
@@ -141,6 +151,8 @@ CPU5: cpu@500 {
 			compatible = "qcom,kryo360";
 			reg = <0x0 0x500>;
 			enable-method = "psci";
+			capacity-dmips-mhz = <610>;
+			dynamic-power-coefficient = <203>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gladiator_noc MASTER_AMPSS_M0 3 &mem_noc SLAVE_EBI_CH0 3>,
@@ -161,6 +173,8 @@ CPU6: cpu@600 {
 			compatible = "qcom,kryo360";
 			reg = <0x0 0x600>;
 			enable-method = "psci";
+			capacity-dmips-mhz = <1024>;
+			dynamic-power-coefficient = <393>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			operating-points-v2 = <&cpu6_opp_table>;
 			interconnects = <&gladiator_noc MASTER_AMPSS_M0 3 &mem_noc SLAVE_EBI_CH0 3>,
@@ -181,6 +195,8 @@ CPU7: cpu@700 {
 			compatible = "qcom,kryo360";
 			reg = <0x0 0x700>;
 			enable-method = "psci";
+			capacity-dmips-mhz = <1024>;
+			dynamic-power-coefficient = <393>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			operating-points-v2 = <&cpu6_opp_table>;
 			interconnects = <&gladiator_noc MASTER_AMPSS_M0 3 &mem_noc SLAVE_EBI_CH0 3>,
-- 
2.41.0

