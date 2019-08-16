Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36A239087C
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2019 21:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfHPTnU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Aug 2019 15:43:20 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:15051 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbfHPTnK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Aug 2019 15:43:10 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d5707590000>; Fri, 16 Aug 2019 12:43:21 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 16 Aug 2019 12:43:09 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 16 Aug 2019 12:43:09 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 16 Aug
 2019 19:43:09 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 16 Aug 2019 19:43:09 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.166.126]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d57074b0002>; Fri, 16 Aug 2019 12:43:09 -0700
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
Subject: [PATCH v9 21/22] arm64: dts: tegra210-p2180: Jetson TX1 SC7 timings
Date:   Fri, 16 Aug 2019 12:42:06 -0700
Message-ID: <1565984527-5272-22-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565984527-5272-1-git-send-email-skomatineni@nvidia.com>
References: <1565984527-5272-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565984601; bh=3ikE8x0cNN1fPtdTTddMKObVTKhfyEJPwIrj8ksa4Wg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Iavdj7NLGpwbmjuzIGNf77P7i24HDgJiNt6StWuf8JYSQYUa4WIIMljNArnTiC6c7
         FluOnPE+Mk/PNOuEtFTcEFgyvZORRedYP2yuj7KqkYcmhhUTFyb8bYS/bWBwENkVZK
         3Fkch8RkA//oBjmPshhymQeGwB52bRRicQBtiE9zbUB/jIoc9kLeAu6wO0gGmrf6mB
         dBnPtj7iqOKlqhb+omsieYI6c4WrivZu9TQ7llbbg2i6QeL/D4tWc1abYpmt6BkqEb
         vyyI4plgDmZYrVUYbhPvppGvuUZ4pTNwIV9ExNWulYfa87UzwbO7nu6iH3B9pOX7q6
         0Pk2NN6rIS7ug==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch has Jetson TX1 platform specific SC7 timing configuration
in device tree.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi b/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
index 27723829d033..cb58f79deb48 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
@@ -279,6 +279,13 @@
 
 	pmc@7000e400 {
 		nvidia,invert-interrupt;
+		nvidia,suspend-mode = <0>;
+		nvidia,cpu-pwr-good-time = <0>;
+		nvidia,cpu-pwr-off-time = <0>;
+		nvidia,core-pwr-good-time = <4587 3876>;
+		nvidia,core-pwr-off-time = <39065>;
+		nvidia,core-power-req-active-high;
+		nvidia,sys-clock-req-active-high;
 	};
 
 	/* eMMC */
-- 
2.7.4

