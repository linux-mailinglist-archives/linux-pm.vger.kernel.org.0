Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D878A90892
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2019 21:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbfHPTne (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Aug 2019 15:43:34 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13177 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727605AbfHPTnF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Aug 2019 15:43:05 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d57074b0000>; Fri, 16 Aug 2019 12:43:07 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 16 Aug 2019 12:43:05 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 16 Aug 2019 12:43:05 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 16 Aug
 2019 19:43:04 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 16 Aug 2019 19:43:04 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.166.126]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d5707470002>; Fri, 16 Aug 2019 12:43:04 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <linus.walleij@linaro.org>,
        <stefan@agner.ch>, <mark.rutland@arm.com>
CC:     <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <jckuo@nvidia.com>,
        <josephl@nvidia.com>, <talho@nvidia.com>, <skomatineni@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mperttunen@nvidia.com>, <spatra@nvidia.com>, <robh+dt@kernel.org>,
        <digetx@gmail.com>, <devicetree@vger.kernel.org>,
        <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH v9 18/22] arm64: tegra: Enable wake from deep sleep on RTC alarm
Date:   Fri, 16 Aug 2019 12:42:03 -0700
Message-ID: <1565984527-5272-19-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565984527-5272-1-git-send-email-skomatineni@nvidia.com>
References: <1565984527-5272-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565984587; bh=r/7sch8XJz5tT01ckyUKnesfNR9nppNjP97KIR+puRI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=qWKqGaguwl9s9rmE2pikyUDQOdCDZJYLw4ePhOCcl9J6IDSTwowJ5GDWcpdhwrLCT
         8gTNa6a8G7HqknQ/Yl6WnGSoCLln3Olh+qQYHG7UwnLoZtgQp3Uiiz3Bq+AP4jQB00
         v3wX+X2cw0u48lG2+DufUOyMyqDzZv2LJVx0V2AEV7efTRHslsz11nGtVabpMcPWBH
         qOSUtTGRryFobs8Ixl9S8iiAAX/uJ6GzrTvxnXCDKzaE6m3uDwUDZ4SCpG/wMnmNim
         GJ0l2lm5EqSCFvj9O4FlltmPR7KYVEdEUhn8ZV90A1NmDcHdy+RpwbWkKYJ2zOTZF1
         oQGhkNJ/KQ67w==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch updates device tree for RTC and PMC to allow system wake
from deep sleep on RTC alarm.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 659753118e96..30a7c48385a2 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -768,7 +768,8 @@
 	rtc@7000e000 {
 		compatible = "nvidia,tegra210-rtc", "nvidia,tegra20-rtc";
 		reg = <0x0 0x7000e000 0x0 0x100>;
-		interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <16 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&pmc>;
 		clocks = <&tegra_car TEGRA210_CLK_RTC>;
 		clock-names = "rtc";
 	};
@@ -778,6 +779,8 @@
 		reg = <0x0 0x7000e400 0x0 0x400>;
 		clocks = <&tegra_car TEGRA210_CLK_PCLK>, <&clk32k_in>;
 		clock-names = "pclk", "clk32k_in";
+		#interrupt-cells = <2>;
+		interrupt-controller;
 
 		powergates {
 			pd_audio: aud {
-- 
2.7.4

