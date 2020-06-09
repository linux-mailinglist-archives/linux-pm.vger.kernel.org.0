Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9281F3BC9
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 15:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbgFINQa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 09:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729332AbgFINPA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 09:15:00 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67931C08C5C5;
        Tue,  9 Jun 2020 06:14:58 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id c17so24952690lji.11;
        Tue, 09 Jun 2020 06:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AG+TQmILbbrHUh9/3fg4pGtkuDKOX+TOZbe0Aj0MBf0=;
        b=EiGhSOh1ZZPDLaZRrYIeHCwKkcNsouIcTJjk0UxCLEePd/J+r5pwQyDnLWuIeTo8cq
         gV/ci5m3Vqo4aYx143Z/Mzz9uozgdSH6gSl1TK3z0y/3VP1U3hPVMHRWHoYj6C5KYwda
         HroGQYKYI0+uAe1cm29/AeJ07m8HZKzojXdxbRujvQUuOgVxLWrHXRtSHD9IQVEaBMuE
         CJJOTef/97J7HEvFO6iicAJq/7/e8AY3fuCvYSQ2AsdLNPDDOCCHQMNqYh/yRrxCSjnF
         2TpuG2F+JIqqL6kTkzDfCZ448ytMSV92/cOS2dmdXZer+G85yg9YyWrjGVr4Fabt2XoN
         UiLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AG+TQmILbbrHUh9/3fg4pGtkuDKOX+TOZbe0Aj0MBf0=;
        b=RE0eBTe4JpaVmIWYU8YJedzwLfGGT7mKRHikO7G2j4zoDU32bLBcpFhBlOQGenucuD
         hDwBFkZBJQxQWBavx3Ezld3BLEsAe4zauSvbBoJoY/noI+lZUR3k9dkccDQVgqAfu/oN
         09T57/11wPN8g+dfE3Lpjb0XpqBGdYAMS7GzSFV1sNxQjTVunhm1LgFRa9oDMNkgxqR0
         crJN+aKmbp25UjTqkhoCESixMnZZM9eSsj4xAjNHHF/8qMGNcIk9LUNBorOCBYW0JxbM
         0/jhCcFBVnPG6IDUY0MjYc79haoYqnuOjFi0iKZd47F0IuZ2CJJtLQlbqvWd82IvBCRG
         Ps5g==
X-Gm-Message-State: AOAM530as8/6XzaNPnmqqo6cFoUOcfNXRYnRGbDhBZtou8iZlP6eABGp
        rutQAfuHj6B2O0dRe3Y+yXI=
X-Google-Smtp-Source: ABdhPJyiYfbTzP2nZhf3fgnnkhVUB7Ysq7mpxP+V8W5Yvzw4oCoUQgYrSVYyt565zMhI60iILUnTfQ==
X-Received: by 2002:a2e:89da:: with SMTP id c26mr13060673ljk.447.1591708496791;
        Tue, 09 Jun 2020 06:14:56 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id l22sm4323522lji.120.2020.06.09.06.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 06:14:56 -0700 (PDT)
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
Subject: [PATCH v4 26/37] ARM: tegra: Add interconnect properties to Tegra30 device-tree
Date:   Tue,  9 Jun 2020 16:13:53 +0300
Message-Id: <20200609131404.17523-27-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200609131404.17523-1-digetx@gmail.com>
References: <20200609131404.17523-1-digetx@gmail.com>
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

