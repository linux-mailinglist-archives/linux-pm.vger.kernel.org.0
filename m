Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E055E2AE589
	for <lists+linux-pm@lfdr.de>; Wed, 11 Nov 2020 02:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732868AbgKKBPv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 20:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732844AbgKKBPu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 20:15:50 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE28FC0613D1;
        Tue, 10 Nov 2020 17:15:48 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id c9so519367wml.5;
        Tue, 10 Nov 2020 17:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pLbRWZodAWHryje7XdgngwZooRzE7B+sWeFpLwWIFLg=;
        b=L2nGyd1hoSYca71deEj6QrNwd1Mfe1ynvvNfAPZdbM0r3u8YjBetM0GAj0Yl8apMh2
         ArJr0wlVHFXCXwooBpJ48JzrG+pss1VD+jcfPwqLPiPIuwYy4N+yjANNoEXQaNAsHPLh
         ib7I/uDe9pCkid7o0VliV55R7Q4LYwc2NfPDhCSFh0KFCaAZgqyYpfqjRrj7F43esTrT
         75SY10Eg2eJkEDzrqsp4tLAp1hRYN2nOsZNuK94+x3Ei7MbSi4ijzewbyhPpVezLia63
         MVUrELU7H7JO1oKotzWtxKLF/MhcpbGjWd7OFx0wnWSTWuUv4602iO04zgMmX1yz5Hic
         vZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pLbRWZodAWHryje7XdgngwZooRzE7B+sWeFpLwWIFLg=;
        b=aYZSmy2AiMOYOGXjyJT763lNXMvao2YjLdXtvOhWASErH2iE3jAln57NHmdOFxNwXd
         OYspmBtCrFMBFMmhOvaJTSlsFb7AJXbJaPBoff2Io7E6MxGVJytaHxf+tNabBWJE9GCm
         qj5ohEgFgdf12ShGWmTyOMENfNN4kLD5jwJ9/SU6xFgt+DWyRyC1PX8BPfMN3bHM4K73
         bhfhQpPbkdUCdKL+oQSCy6tUL9PbmA6wedbvozGS/yc3B3IcKELX/EjxohArdvAkpYr0
         1RRnatuC5OjlF/DCbnwiGbon55uvOR7WNNZ/FAVd/M+C9tktbE6bsodrQ0H3hNP5zgGZ
         yt9A==
X-Gm-Message-State: AOAM5315M0yE/8xAqgBsJS+lwqqb0UQ/BRNB8GOfUTrzZsuglTEDupPa
        a78cEp9xO1Cat0KR3ci4HLo=
X-Google-Smtp-Source: ABdhPJzERI9IUMPDNlGr8X9mBk7KyFjpvv1wNzeOj81e8oT8e6EKe6MSqWpz1EQDoUwz4RNFe2LdAg==
X-Received: by 2002:a7b:cbc8:: with SMTP id n8mr936438wmi.124.1605057347455;
        Tue, 10 Nov 2020 17:15:47 -0800 (PST)
Received: from localhost.localdomain (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.gmail.com with ESMTPSA id g131sm564329wma.35.2020.11.10.17.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 17:15:46 -0800 (PST)
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
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v8 22/26] ARM: tegra: Add interconnect properties to Tegra124 device-tree
Date:   Wed, 11 Nov 2020 04:14:52 +0300
Message-Id: <20201111011456.7875-23-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201111011456.7875-1-digetx@gmail.com>
References: <20201111011456.7875-1-digetx@gmail.com>
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
2.29.2

