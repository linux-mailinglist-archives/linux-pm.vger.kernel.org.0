Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C503798E2
	for <lists+linux-pm@lfdr.de>; Mon, 10 May 2021 23:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbhEJVNB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 May 2021 17:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbhEJVNA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 May 2021 17:13:00 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1F0C061760;
        Mon, 10 May 2021 14:11:54 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id t11so25407029lfl.11;
        Mon, 10 May 2021 14:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ybiSyEHiHhpZwxGAHloT2ZV0d6LrcnSv5Cr6VIeCqOk=;
        b=RZ3Hvofan3xeL4p404LLxQOKHcRwb2zlOMHaZ4BV0B24BSnb1o0ZdFLGILHIur4EWx
         1oPMZ+zWa4QWB4CE2WgJlN5ok+Yg5ZyUvOgGgYif3KEukDSD8sBxqMJ+n/yTtR/yWcHP
         z2uG2Ymcq5mma6NNssAV10sMpcTXCDpRVeL/qIQBUQBRlRffpV+pKIKX9QCBtWIrWhw4
         tPWJZ7OjkKbWKVu2yErxtNCQsD2Z1ssKuq6Sywny39QyZ2EKM8PjK1IjdPohCsSCLPfk
         oSrZvKiRU0IpSGkVa8qyKoo5PQN3vlAIMxy0fxFT31J44dMVyJIPRyZgFJJXyi/MlSCW
         sSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ybiSyEHiHhpZwxGAHloT2ZV0d6LrcnSv5Cr6VIeCqOk=;
        b=gwrSaLW6RnCIGtMEXGHDU5LB6U0ewpHHuv47lJjikRfnqQEA7dUxrLSSBya9PSuRQr
         +E4B0WlAi0CpKx+qIwyHb69BhMCkFL2KLMjrhJsFziMohKXH8PQuF7azskJR81wXuInt
         KJJcTKjRK97oGJ40KSeD2KpCd+Fqw2OGK1RU7hNJ7++U442YtyL8iBBlIifjF+x0mCg/
         szzvUEmXeH37LNggZpylGgglVEddn0VhWSb+VGT40ktRTmqPGmNAuz9xs6nlnSvUJLoM
         pJDb0NtkOdcKyZQOlvTobAN0Rg5eQppIg80OqJQ3c2OjNF5a8iTAJ71hkX9HaHg5gKJp
         TYPA==
X-Gm-Message-State: AOAM532XVp1MrVOussOG/Gaxc+Dc6NdvLVymEqir35ZJewW9H5pjqw+6
        foruus2pe84sNR9Wf939/Hg=
X-Google-Smtp-Source: ABdhPJzY5bf7qKfAVZRtbjolWvcRElCM93yIIsmKgXySglYMaiJNFUAxOip8Axt0PYOkc2fZ71zf1g==
X-Received: by 2002:a05:6512:2287:: with SMTP id f7mr17746341lfu.475.1620681112593;
        Mon, 10 May 2021 14:11:52 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-91.dynamic.spd-mgts.ru. [109.252.193.91])
        by smtp.gmail.com with ESMTPSA id x4sm2365339lfa.173.2021.05.10.14.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 14:11:52 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v1 5/7] ARM: tegra: Add cooling cells to ACTMON device-tree node
Date:   Tue, 11 May 2021 00:10:06 +0300
Message-Id: <20210510211008.30300-6-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210510211008.30300-1-digetx@gmail.com>
References: <20210510211008.30300-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The ACTMON module monitors activity of memory clients and decisions
about a minimum required memory frequency are made based on info from
ACTMON. Add cooling cells to ACTMON device-tree node in order to turn
it into a cooling device that will throttle memory freq on overheat.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra124.dtsi | 3 ++-
 arch/arm/boot/dts/tegra30.dtsi  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 0b678afb2a5c..8b38f123f554 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -283,7 +283,7 @@ flow-controller@60007000 {
 		reg = <0x0 0x60007000 0x0 0x1000>;
 	};
 
-	actmon@6000c800 {
+	actmon: actmon@6000c800 {
 		compatible = "nvidia,tegra124-actmon";
 		reg = <0x0 0x6000c800 0x0 0x400>;
 		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
@@ -295,6 +295,7 @@ actmon@6000c800 {
 		operating-points-v2 = <&emc_bw_dfs_opp_table>;
 		interconnects = <&mc TEGRA124_MC_MPCORER &emc>;
 		interconnect-names = "cpu-read";
+		#cooling-cells = <2>;
 	};
 
 	gpio: gpio@6000d000 {
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 44a6dbba7081..c577c191be4b 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -410,7 +410,7 @@ ahb: ahb@6000c000 {
 		reg = <0x6000c000 0x150>; /* AHB Arbitration + Gizmo Controller */
 	};
 
-	actmon@6000c800 {
+	actmon: actmon@6000c800 {
 		compatible = "nvidia,tegra30-actmon";
 		reg = <0x6000c800 0x400>;
 		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
@@ -422,6 +422,7 @@ actmon@6000c800 {
 		operating-points-v2 = <&emc_bw_dfs_opp_table>;
 		interconnects = <&mc TEGRA30_MC_MPCORER &emc>;
 		interconnect-names = "cpu-read";
+		#cooling-cells = <2>;
 	};
 
 	gpio: gpio@6000d000 {
-- 
2.30.2

