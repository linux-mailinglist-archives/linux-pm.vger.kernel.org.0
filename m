Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60ECA1F0E86
	for <lists+linux-pm@lfdr.de>; Sun,  7 Jun 2020 20:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbgFGS6z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jun 2020 14:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728923AbgFGS5r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jun 2020 14:57:47 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E02DC061A0E;
        Sun,  7 Jun 2020 11:57:46 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id a9so14202982ljn.6;
        Sun, 07 Jun 2020 11:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AG+TQmILbbrHUh9/3fg4pGtkuDKOX+TOZbe0Aj0MBf0=;
        b=LIq4c8YbjlyO0sK/gqRyiPHgJQTiyjSMFqPnqw8CnrhRifowuVWK/bN5TPuol27HNH
         XQYOD4rqSMx+ziPSh4b0n/OKjA/EqAJw1igg7gKrXlJMwNQjd0iBbEKBVft6leByyE+o
         s4s0Sf2PwuayhukHlDP7Cgh2bqyxK9uZADTErRWShkosBV6huDREWh4EG44YCrxlc6Ak
         FMIl3qTb15u4Ten/09SY8bt2rT1YcgBZWVzJzf+HiHbhu6E7GoQMvGEEsqHC1PYic5nN
         FITSTnuJBt+7tI+pZ1JlBx2kpcQ6YF9rIFOF2TQLCEDFLt3/LPRophmf+lx0tOOBu6L3
         sBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AG+TQmILbbrHUh9/3fg4pGtkuDKOX+TOZbe0Aj0MBf0=;
        b=T+48c/iZc002h4zgZlsezt6wHRj8/1yyunom7pDG6ODYjNSPKHUZEq0NBgcCJVupkU
         Hqw0aOAzSLKKrXmBC53XD4mKYFdkzEqnOUkkROK4Nx+U8v9palNo7S3hhIVduXYPpZ4b
         iGSAH/nEIKKh0zH4qy1wa7fCRGSBC6Bm3p6qK6SWAAfxy9RnS5BxpbfW73zg8bCg9Wks
         bnICwkZZg0jgjNMq6dWBdup2IudknR5kHUzw6qnf4smR8BZVo4m84CeAxAe7/PmLlW63
         FOINVn7HoMZNWO12yu4Z7zB8hdbJyk8ydDgeUSYN+Vl8RTs3w5Qn9CNW5r+CE5g4cnVt
         CfuA==
X-Gm-Message-State: AOAM532GB8FiWymlqtCFdCjTAdnhYPd4yd7bXWKvecI0swrmjlLGR/s0
        Rq+jpE5aYt6V0/uvUiYyY5E=
X-Google-Smtp-Source: ABdhPJyzHgDDjmNOTd8FYboo4P8nIdCH9ClNwLd7hbY9gzNdY2NSabkELJ2Zn6ABhqGtUXsXbGNkzQ==
X-Received: by 2002:a2e:911:: with SMTP id 17mr9786613ljj.411.1591556264654;
        Sun, 07 Jun 2020 11:57:44 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id e21sm3650953ljb.135.2020.06.07.11.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 11:57:44 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 26/39] ARM: tegra: Add interconnect properties to Tegra30 device-tree
Date:   Sun,  7 Jun 2020 21:55:17 +0300
Message-Id: <20200607185530.18113-27-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200607185530.18113-1-digetx@gmail.com>
References: <20200607185530.18113-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add interconnect properties to the memory controller, external memory
controller and the display controller nodes in order to describe hardware
interconnection.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra30.dtsi | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index d2d05f1da274..2b183025629f 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -208,6 +208,15 @@ dc@54200000 {
 
 			nvidia,head = <0>;
 
+			interconnects = <&mc TEGRA30_MC_DISPLAY0A &emc>,
+					<&mc TEGRA30_MC_DISPLAY0B &emc>,
+					<&mc TEGRA30_MC_DISPLAY0C &emc>,
+					<&mc TEGRA30_MC_DISPLAY1B &emc>;
+			interconnect-names = "display0a",
+					     "display0b",
+					     "display0c",
+					     "display1b";
+
 			rgb {
 				status = "disabled";
 			};
@@ -227,6 +236,15 @@ dc@54240000 {
 
 			nvidia,head = <1>;
 
+			interconnects = <&mc TEGRA30_MC_DISPLAY0AB &emc>,
+					<&mc TEGRA30_MC_DISPLAY0BB &emc>,
+					<&mc TEGRA30_MC_DISPLAY0CB &emc>,
+					<&mc TEGRA30_MC_DISPLAY1BB &emc>;
+			interconnect-names = "display0a",
+					     "display0b",
+					     "display0c",
+					     "display1b";
+
 			rgb {
 				status = "disabled";
 			};
@@ -733,15 +751,18 @@ mc: memory-controller@7000f000 {
 
 		#iommu-cells = <1>;
 		#reset-cells = <1>;
+		#interconnect-cells = <1>;
 	};
 
-	memory-controller@7000f400 {
+	emc: memory-controller@7000f400 {
 		compatible = "nvidia,tegra30-emc";
 		reg = <0x7000f400 0x400>;
 		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA30_CLK_EMC>;
 
 		nvidia,memory-controller = <&mc>;
+
+		#interconnect-cells = <0>;
 	};
 
 	fuse@7000f800 {
-- 
2.26.0

