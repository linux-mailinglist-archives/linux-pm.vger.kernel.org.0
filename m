Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72CA3D81BD
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2019 23:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389797AbfJOVRu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Oct 2019 17:17:50 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:43645 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389606AbfJOVRT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2019 17:17:19 -0400
Received: by mail-lj1-f173.google.com with SMTP id n14so21721846ljj.10;
        Tue, 15 Oct 2019 14:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vyj3Be8ThUFoK8NpwpKfu1gKOQi5QB5c0e9A2mKmK20=;
        b=YHeBAiYt40wicKD4soqpP+F3/G6/Yq0bhA7631qLsCTU9uj4mahMi0/kMPtLB8kiV3
         XIC7ri9eT/JCJkvso9o6JQ1/MdLZLCaWG04GB9XWsaRdS+0JvjGRckdJFlCdUzgLKARq
         XM0Zb/sHFgNsWXPFQ1af8sJAIdhRF+gUqKoxVzy+7Z2GSuUOdLzwiIjH3q+uLZEtdy9T
         x5yynhpCOaNzyhkXhszuGlQNF4TRdEpEe/GSyajCg5gnA1vtau5pRkUgwa01hN2rU8wX
         NkbIm0GlxL1G/wojm+HETb4WT6Lmp0EAvlQnRN2xOJkIZ/CGxjFmjXwMBkb9MnKhXpY0
         oCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vyj3Be8ThUFoK8NpwpKfu1gKOQi5QB5c0e9A2mKmK20=;
        b=ByXmGK907RczP6hwlaqbfllYpYCnlk+jsPV3Gbup62Fsa+iGwlxpDq4Hnd+X16P208
         T3BEcSYn/60+w1hhGcBsJsDJax5Fm6QyTHCN13NrO/nd1/PrRfafj785k86bJKEYonZ7
         BssWAa6ZdtPc5lWKhK4WEuWfBNkDCNb8OnV2J0NAhFlsD0EVSyg9EgU9koaIvG4e8z5f
         Sdz2D827bpeYey3YhmSFGaSpJafVN4hfI4iJ8fz4lPYl/nSPDOgd6kFCxYfBB+W29Dkp
         Avkb/Zt3Hec/srzofezV9jljgMMX9kwByfpObFn6CP9owiKzMXltvQ2md5fbBjUrj1Xq
         YyuA==
X-Gm-Message-State: APjAAAU+Dg17gpF1TmL3SBXQ5wDHkiFxO9LSOx/CxYo6SW2Hij2TREa8
        Do/QIon8W1WgNueATxQAsZ8=
X-Google-Smtp-Source: APXvYqzJRGTHIgu3Uz53ZQRsmJW6F3jxI8jO8imI2wWaTsKceblOY07mrjSCvFVZlYWv4yY6yIOx4g==
X-Received: by 2002:a2e:5d5b:: with SMTP id r88mr23680868ljb.170.1571174233808;
        Tue, 15 Oct 2019 14:17:13 -0700 (PDT)
Received: from localhost.localdomain ([94.29.10.250])
        by smtp.gmail.com with ESMTPSA id t16sm5269186ljj.29.2019.10.15.14.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 14:17:13 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 13/17] ARM: dts: tegra20: paz00: Set up voltage regulators for DVFS
Date:   Wed, 16 Oct 2019 00:16:14 +0300
Message-Id: <20191015211618.20758-14-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015211618.20758-1-digetx@gmail.com>
References: <20191015211618.20758-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Set min/max voltage and couple CPU/CORE/RTC regulators.

Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra20-paz00.dts | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-paz00.dts b/arch/arm/boot/dts/tegra20-paz00.dts
index 8861e0976e37..6e9fe192c648 100644
--- a/arch/arm/boot/dts/tegra20-paz00.dts
+++ b/arch/arm/boot/dts/tegra20-paz00.dts
@@ -337,18 +337,26 @@
 					regulator-always-on;
 				};
 
-				sm0 {
+				core_vdd_reg: sm0 {
 					regulator-name = "+1.2vs_sm0,vdd_core";
 					regulator-min-microvolt = <1200000>;
-					regulator-max-microvolt = <1200000>;
+					regulator-max-microvolt = <1225000>;
+					regulator-coupled-with = <&rtc_vdd_reg &cpu_vdd_reg>;
+					regulator-coupled-max-spread = <170000 450000>;
 					regulator-always-on;
+
+					nvidia,tegra-core-regulator;
 				};
 
-				sm1 {
+				cpu_vdd_reg: sm1 {
 					regulator-name = "+1.0vs_sm1,vdd_cpu";
-					regulator-min-microvolt = <1000000>;
-					regulator-max-microvolt = <1000000>;
+					regulator-min-microvolt = <750000>;
+					regulator-max-microvolt = <1100000>;
+					regulator-coupled-with = <&core_vdd_reg &rtc_vdd_reg>;
+					regulator-coupled-max-spread = <450000 450000>;
 					regulator-always-on;
+
+					nvidia,tegra-cpu-regulator;
 				};
 
 				sm2_reg: sm2 {
@@ -367,10 +375,15 @@
 					regulator-always-on;
 				};
 
-				ldo2 {
+				rtc_vdd_reg: ldo2 {
 					regulator-name = "+1.2vs_ldo2,vdd_rtc";
 					regulator-min-microvolt = <1200000>;
-					regulator-max-microvolt = <1200000>;
+					regulator-max-microvolt = <1225000>;
+					regulator-coupled-with = <&core_vdd_reg &cpu_vdd_reg>;
+					regulator-coupled-max-spread = <170000 450000>;
+					regulator-always-on;
+
+					nvidia,tegra-rtc-regulator;
 				};
 
 				ldo3 {
-- 
2.23.0

