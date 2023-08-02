Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B893D76C200
	for <lists+linux-pm@lfdr.de>; Wed,  2 Aug 2023 03:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjHBBQH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Aug 2023 21:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjHBBQG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Aug 2023 21:16:06 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7031A2722;
        Tue,  1 Aug 2023 18:16:04 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-78caeb69125so2241037241.3;
        Tue, 01 Aug 2023 18:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690938963; x=1691543763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAeGF4mL0U2q2+/1xZ74W46SMa201+Ip//omt4RdE74=;
        b=dsqK1GMWXIBC6UJMbsw/JMvswH6+QiFa3PpuJqQaIyOPvglTmOjMbbuv0EHd/ckxW+
         /wM6b9Is6S55FAA/Bjx4mlsrYiZhpGpg2XQon6fAAyxULi15eqSSWZ8SlTwrnpS17X3k
         8HdpV57hIUKeRYWRG4VB83LRjIcTqtTBD6sgsG2F9CjAiMWHR4X6/kYPvoLksJfXpDlq
         ALABKg6eQfXu5DT8AhpmxvJF7AbBeeCxTTK2dncIRS3+yIhGel2quTPRRjpoF0dGIO+U
         rxLbjxsfglb+k7+UV464EGDAtjCubcPvPLCiPwPIEd4ws92Kx/BxOjeEXsfvQG9YR6Hm
         ulbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690938963; x=1691543763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DAeGF4mL0U2q2+/1xZ74W46SMa201+Ip//omt4RdE74=;
        b=bS85s985w8nP7GFREa1cNf2mhEdLWkWSDuDM8QLmd2lQmyRU+sy+VrQVa+a2OVfOY/
         o+W7aDe3w16MRN2ObHzlAu8fgMRP5OlLFQzU03vrhlpcP09oc8Zi8rhWmyyKzbLMaw4I
         wfBJFPxjS7UqS4uUW0EcXuQ9R8eO0NjzzLpeFLERXUOIYjFI/J7Fwl8lPmjZzQLZuOMY
         UGx1Pf8kzjbQu+3rbh0SdH4HG+ICgmAj2wIau52oeyFNnuOI+v8rreXouu/3r6ExxVE7
         4q7xalre7K5uPW8FISuiV96SeJzs4ep1MdwJdkhd/hy4JcZ5ueTcNpun3uoLUOpKTM7Q
         sCgA==
X-Gm-Message-State: ABy/qLY+LMle4uSJDpSONVXKJMieFjIGuekvOOwp05gwJpKpD95vPDb6
        57uNIy7CrksK2xEwhCkHmR8=
X-Google-Smtp-Source: APBJJlGYLG50Q1jCaV27Tp++ymoceFb3c1tE7JKNuRkHZf2E3HDdCfT4s/jybaUxig94ym8TgYnMdg==
X-Received: by 2002:a05:6102:106:b0:443:8034:be54 with SMTP id z6-20020a056102010600b004438034be54mr3696749vsq.32.1690938963485;
        Tue, 01 Aug 2023 18:16:03 -0700 (PDT)
Received: from localhost ([2607:fea8:529e:7800::7cda])
        by smtp.gmail.com with ESMTPSA id m128-20020a252686000000b00d1dd5c6c035sm3435494ybm.62.2023.08.01.18.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 18:16:03 -0700 (PDT)
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
Subject: [PATCH v2 4/4] arm64: dts: qcom: sdm670: add frequency profile
Date:   Tue,  1 Aug 2023 21:15:52 -0400
Message-ID: <20230802011548.387519-10-mailingradian@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802011548.387519-6-mailingradian@gmail.com>
References: <20230802011548.387519-6-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
index e1ef3fc2ace0..0ac39d3d68ca 100644
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

