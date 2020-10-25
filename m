Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F65298485
	for <lists+linux-pm@lfdr.de>; Sun, 25 Oct 2020 23:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418843AbgJYWVW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Oct 2020 18:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1419281AbgJYWSO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Oct 2020 18:18:14 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7B5C061755;
        Sun, 25 Oct 2020 15:18:13 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id r127so9382821lff.12;
        Sun, 25 Oct 2020 15:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qXc6alv2GyhB3hhhLZedHDIUdftmQRoQ6V9Gv1leNe8=;
        b=G6CU/I9GbnvzY10MrdETnPX8Y9FK8jZ2VS1eEkZFKWM+mx9WxzE8Pb0TNuIuJuU4r3
         hwCjzn2S2s5zlBO5uCpQbt+t0N2BCMzZU3/SBmR8MIHvN3vT/eXuCZKJBZ7OWtazqYxp
         CW9CMBMh36p+etuJ3wq+gZ0zaQPP6/XL2r/mqyk+BQoSA2TTcouzD98uTqqyHzTj5ktT
         uOzWRf9QhGdQdEeWDS2fn+RPq5UdWtQ83joJxtstyMMijjjIfKiKOgCPDTTHIRGJcasV
         /tgp7hHVrkKH9Rxc5XcExIcSRA+qb8hb7bTiBdeZSpPgYjeQYJSjEWf4ovBBd2QAYtzp
         jbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qXc6alv2GyhB3hhhLZedHDIUdftmQRoQ6V9Gv1leNe8=;
        b=tJdQ+aVTdLy8vpUhWwRHOSj+qm9+5JsqNHJt6ILAQQWKnSZVUvjHYqNSj8akPc/Kll
         k7ZZMvRCC2BrU7h4kKrq5OgHxNccolDjcfsSVBy3ZOBc+3v3idcBuVrBNfU5yVM8Ujcs
         p4R+lpFyCwiEGg7TZXHaYcyJqQmiD6J6bLZd2drW/TFhVeYQSaWHFQrmnwP+abp9jgsF
         kYmhZ+cF/MYrE2xZesnaHB1cZpgE7VsztYp54GzCQf2pn4qn+XpkoR5MDcaie9SlHuM/
         3N2kTHmgN47Gd3SgOlNZRQJnxb9m+o+1yFMwWcaPxlx1wKyt7CVoCacqMuh/FDbzSiDj
         9lBA==
X-Gm-Message-State: AOAM532osL9GWT1V33aib+ldCfblQzZ3KGx045bo546Vx+/Zfp+Ty+xB
        bGMIxn2Ujek/8UUqgLJM6SM=
X-Google-Smtp-Source: ABdhPJxZ6phL/YfFsYul3o/0DLqnGI3fifIYeEWPWolgBfP0BBtk9aMQ63fWf5njWfi8lnm4NMOz8w==
X-Received: by 2002:a19:fc1c:: with SMTP id a28mr4367965lfi.517.1603664292475;
        Sun, 25 Oct 2020 15:18:12 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.gmail.com with ESMTPSA id k13sm932423ljh.136.2020.10.25.15.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 15:18:12 -0700 (PDT)
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
Subject: [PATCH v6 21/52] ARM: tegra: Add interconnect properties to Tegra20 device-tree
Date:   Mon, 26 Oct 2020 01:17:04 +0300
Message-Id: <20201025221735.3062-22-digetx@gmail.com>
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
 arch/arm/boot/dts/tegra20.dtsi | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 9347f7789245..2e1304493f7d 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -111,6 +111,17 @@ dc@54200000 {
 
 			nvidia,head = <0>;
 
+			interconnects = <&mc TEGRA20_MC_DISPLAY0A &emc>,
+					<&mc TEGRA20_MC_DISPLAY0B &emc>,
+					<&mc TEGRA20_MC_DISPLAY1B &emc>,
+					<&mc TEGRA20_MC_DISPLAY0C &emc>,
+					<&mc TEGRA20_MC_DISPLAYHC &emc>;
+			interconnect-names = "wina",
+					     "winb",
+					     "winb-vfilter",
+					     "winc",
+					     "cursor";
+
 			rgb {
 				status = "disabled";
 			};
@@ -128,6 +139,17 @@ dc@54240000 {
 
 			nvidia,head = <1>;
 
+			interconnects = <&mc TEGRA20_MC_DISPLAY0AB &emc>,
+					<&mc TEGRA20_MC_DISPLAY0BB &emc>,
+					<&mc TEGRA20_MC_DISPLAY1BB &emc>,
+					<&mc TEGRA20_MC_DISPLAY0CB &emc>,
+					<&mc TEGRA20_MC_DISPLAYHCB &emc>;
+			interconnect-names = "wina",
+					     "winb",
+					     "winb-vfilter",
+					     "winc",
+					     "cursor";
+
 			rgb {
 				status = "disabled";
 			};
@@ -630,15 +652,17 @@ mc: memory-controller@7000f000 {
 		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
 		#reset-cells = <1>;
 		#iommu-cells = <0>;
+		#interconnect-cells = <1>;
 	};
 
-	memory-controller@7000f400 {
+	emc: memory-controller@7000f400 {
 		compatible = "nvidia,tegra20-emc";
 		reg = <0x7000f400 0x400>;
 		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA20_CLK_EMC>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		#interconnect-cells = <0>;
 	};
 
 	fuse@7000f800 {
-- 
2.27.0

