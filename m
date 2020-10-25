Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 212C429847F
	for <lists+linux-pm@lfdr.de>; Sun, 25 Oct 2020 23:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1419694AbgJYWVN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Oct 2020 18:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1419286AbgJYWSQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Oct 2020 18:18:16 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB30C0613D0;
        Sun, 25 Oct 2020 15:18:16 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id i2so7712416ljg.4;
        Sun, 25 Oct 2020 15:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QRlFO/P8PM5Cn8H1AicqJgfFzNfpVD518mHY1P3SV5Y=;
        b=SzJggAwDoCLpZKnhs4yqU1TOOL/PVnhO+B5UsLYstn5FSBOpAL/YAdp0J+RMrpcnUi
         BRBz0jixKxyk4C7oG0PCr60QEWHyxCjSuCgbhbi3CdalucyJm+cbeGD5khJkCjY/RHZI
         ipWS66W9KITel7MbfBgmgTjG22Bw/4fGeF2f5imTiwKucbL5JFmXOPC+Fi1tQaw73BUg
         1dWQFCjSfvtru2ifRg4XXsajcRkUris/kZ8IV7iiqXQl/y8SVc+cT0jEDWDobjY8hvRw
         iAzYf9vYdib6qBhnfQ1lfrQeCXdmmkcQcEsVMeX52wdeuunXLCfichXwuWnhCyy9WR+z
         zbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QRlFO/P8PM5Cn8H1AicqJgfFzNfpVD518mHY1P3SV5Y=;
        b=dGW536ZwozY3rl4MV6IQDg8y0E1MPCWgYomwyXX/Bqwm16RnJVoPjJ2EUzu0QJQij3
         1u/mu9HMa6i4I2n8lPjEI5RE6K84hjQbLMDdjyDMaJJd83Ty4MMHc/a9YnPqWL99Y8JN
         v2ghoyioExvLUqL3Y4fwKjng+U6PnmsMFPLchBG++CUSoA1XRGFNNlelg3rIKQ1tyFjI
         0pu1y3YJgA81Tfy9RYxXusnhpvt6/FNK9AP7ewDPOv9xc3xUsR1IDVAE7CkH0DJ2DK9U
         Dsfn6YASCxD3AiDPW5ECSWwibnv+fTapOOf/Sr3/gRFQKJWXn4/RPyXWd64orQKcRzrv
         2kxQ==
X-Gm-Message-State: AOAM531nVH/Z7r6HtedKnH7VzOQjMuyE4A1ifOQ0yOldwttT9A7hI1sp
        J5nSgd77s8gANpWXSGLKbME=
X-Google-Smtp-Source: ABdhPJyYBlMuWAyftPV0ynOBRahvzDJ4fYyvi7bDLQzk2E9d4+m3IffSaErKR3DR72K6XIKkmNbITw==
X-Received: by 2002:a2e:88c2:: with SMTP id a2mr4715037ljk.438.1603664294746;
        Sun, 25 Oct 2020 15:18:14 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.gmail.com with ESMTPSA id k13sm932423ljh.136.2020.10.25.15.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 15:18:14 -0700 (PDT)
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
Subject: [PATCH v6 23/52] ARM: tegra: Add interconnect properties to Tegra124 device-tree
Date:   Mon, 26 Oct 2020 01:17:06 +0300
Message-Id: <20201025221735.3062-24-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201025221735.3062-1-digetx@gmail.com>
References: <20201025221735.3062-1-digetx@gmail.com>
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

