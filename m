Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F086C2A6ABD
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 17:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731553AbgKDQuA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 11:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731550AbgKDQt7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 11:49:59 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BD4C0613D4;
        Wed,  4 Nov 2020 08:49:59 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id b1so27963034lfp.11;
        Wed, 04 Nov 2020 08:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QRlFO/P8PM5Cn8H1AicqJgfFzNfpVD518mHY1P3SV5Y=;
        b=JjuvAMG7mUgnQj24tLTtOndGkC1aW9WCMpYSx1Uqdlnjva57fFgswNL7gZIz5Vsca7
         /fj5kxRVQy02daPia7Tr9OOeM1NsbKOKIIfZPHXaamUt29sf8bmpDpU4mqM5YgInB92w
         RYQoy727Tgfjh9JDARE+Yx8M8ZT8z4fQVofOB18BFKvopiwUabMaIxxkaoVoUx1r0OgQ
         NVF2/KOWAAmbwPWHOnWvs9F6AibWjWxF9VvylhwHdVgBudiGyPa5A6mM7Lzvco7gAWbk
         dDxQ0T8C8swVpSiFygSfBRiaioQZkg7BC6Em09ZGoMPlUl2l6gXGKO0rw+5YEe9RkTid
         k+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QRlFO/P8PM5Cn8H1AicqJgfFzNfpVD518mHY1P3SV5Y=;
        b=XC3l5Ewv6tE5twLAGbTEhK33R3h8UEcWCATqmcsN8MS4lp71Mihb8tF/NgOCpc1Jz2
         VChfI1LrXqVuSiGuCBv6lSasf+V7/V8TUP6/J68ayP7v1Fno9qe1a0i2GGnZP16VVPQO
         jCqCUD3wWKzI2h0vzzrECAOnQFoXXkk2LDortwR18BtNrNJSCShl1ep9S5xQJD6SDg5N
         VAMn4kf2Kvbr1pHfMpDCiSoMKlxvZtSvbNE/C6g3gfSLHhV0wWYDMHdrOU2GP3RkcoaR
         4Zc6D3DQHPd3nQ1nEaXt58AJT4qyZM32ppoKVxJPoEynSTIzWTkxkhwBvhvhihWezBHQ
         D4jw==
X-Gm-Message-State: AOAM531QXDJubpg3sjOu+XdDEh0hNAB3wW4At+eBcxVMHnO6dcX7L71b
        xsW7Y5LFpb/tXmzoJ/MmogY=
X-Google-Smtp-Source: ABdhPJzNYKMXhnv2y71K4IH8Od3EIl2zV3SAC5E1nwSgucyjo2ZrsUQlvh9kkTAkh+Vsje/0FjHNFQ==
X-Received: by 2002:a19:5e19:: with SMTP id s25mr10683956lfb.430.1604508597896;
        Wed, 04 Nov 2020 08:49:57 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m2sm454587lfo.25.2020.11.04.08.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:49:57 -0800 (PST)
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
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v7 23/47] ARM: tegra: Add interconnect properties to Tegra124 device-tree
Date:   Wed,  4 Nov 2020 19:48:59 +0300
Message-Id: <20201104164923.21238-24-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104164923.21238-1-digetx@gmail.com>
References: <20201104164923.21238-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add interconnect properties to the Memory Controller, External Memory
Controller and the Display Controller nodes in order to describe hardware
interconnection.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra124.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 64f488ba1e72..1801e30b1d3a 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -113,6 +113,19 @@ dc@54200000 {
 			iommus = <&mc TEGRA_SWGROUP_DC>;
 
 			nvidia,head = <0>;
+
+			interconnects = <&mc TEGRA124_MC_DISPLAY0A &emc>,
+					<&mc TEGRA124_MC_DISPLAY0B &emc>,
+					<&mc TEGRA124_MC_DISPLAY0C &emc>,
+					<&mc TEGRA124_MC_DISPLAYHC &emc>,
+					<&mc TEGRA124_MC_DISPLAYD &emc>,
+					<&mc TEGRA124_MC_DISPLAYT &emc>;
+			interconnect-names = "wina",
+					     "winb",
+					     "winc",
+					     "cursor",
+					     "wind",
+					     "wint";
 		};
 
 		dc@54240000 {
@@ -127,6 +140,15 @@ dc@54240000 {
 			iommus = <&mc TEGRA_SWGROUP_DCB>;
 
 			nvidia,head = <1>;
+
+			interconnects = <&mc TEGRA124_MC_DISPLAY0AB &emc>,
+					<&mc TEGRA124_MC_DISPLAY0BB &emc>,
+					<&mc TEGRA124_MC_DISPLAY0CB &emc>,
+					<&mc TEGRA124_MC_DISPLAYHCB &emc>;
+			interconnect-names = "wina",
+					     "winb",
+					     "winc",
+					     "cursor";
 		};
 
 		hdmi: hdmi@54280000 {
@@ -628,6 +650,7 @@ mc: memory-controller@70019000 {
 
 		#iommu-cells = <1>;
 		#reset-cells = <1>;
+		#interconnect-cells = <1>;
 	};
 
 	emc: external-memory-controller@7001b000 {
@@ -637,6 +660,8 @@ emc: external-memory-controller@7001b000 {
 		clock-names = "emc";
 
 		nvidia,memory-controller = <&mc>;
+
+		#interconnect-cells = <0>;
 	};
 
 	sata@70020000 {
-- 
2.27.0

