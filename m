Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3B2FE3F12
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2019 00:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730759AbfJXWRy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Oct 2019 18:17:54 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45059 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730733AbfJXWRx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Oct 2019 18:17:53 -0400
Received: by mail-lj1-f193.google.com with SMTP id q64so328927ljb.12;
        Thu, 24 Oct 2019 15:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vyj3Be8ThUFoK8NpwpKfu1gKOQi5QB5c0e9A2mKmK20=;
        b=n7ux1CRFg4jPC+fCnnx5zXkZUdX5q/Pi2HXBawFzaNkNG8sBZ/CmltstLxlIaj8w7d
         xi0m1awbvIgRCjBDImmik6bYbJJN8JpNVRqjaCBdT595K/CjkhjB7ujwLPPmtSdXIMKa
         daCB5c6D39xss0v8cIekki2DOf4qTayHmcODOiVytJ0lxZkk1B2b24UtDAeSGHXnEO/o
         55jLd1F2HxbDI79pfxvS8u/due4yJTtdvbVmIz0pyqU1llk3WOxRfwp+OqeF6Ku3mF5Z
         TPi2/hHMy4u/xlULWCCZh77knNjSCMesOoIfhEjxKnFQk103U8Pkg42/BSdZI2YCcY+G
         3bBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vyj3Be8ThUFoK8NpwpKfu1gKOQi5QB5c0e9A2mKmK20=;
        b=fjiFj+1eawaClPrSkLtq8XPhHpFKIKYKo0f/8c+0emW+z+T/JWR4LIrG31IH004T36
         tShOiWEjyfDYnUSAht/QCW4loARQmwVV89qAtXidhRxnuGaYTwN2GDvmaqzecT1n957F
         UTfiauS6SeiVdvgBAtPkZL5ZJ0iaZeY9RWXdzt+sQIzW0foBPecNeuGRPU6sRzHan/nQ
         3Rb0u5/2UwU+GuLajUM646pYtVhJVxB/kA7HgREPK1VuvPhGS5JOnGjlF+AcEy98f6Sc
         avTHiVZUNAKwaQA4n1KDuHUNOeEbmJiof7Q7rnydpU9lRsaADilhslkNf2vWe4RkuwVN
         alYQ==
X-Gm-Message-State: APjAAAW6QKd447ITeQe7uTW3+B9JvSJL73LbsNnxsNJ4rH1/xaiIv4Cg
        Drkx3tCt1/sn3ZOuSKYsbLw=
X-Google-Smtp-Source: APXvYqwen03VEfHw4MV5info0TIfzU+Gljh/2KM2cNwme9LoiF+pgehP+Nil6rgeLT9BOA0MWHd0dQ==
X-Received: by 2002:a2e:99cc:: with SMTP id l12mr28063ljj.175.1571955470973;
        Thu, 24 Oct 2019 15:17:50 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id i6sm11338765lfo.83.2019.10.24.15.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 15:17:50 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/17] ARM: dts: tegra20: paz00: Set up voltage regulators for DVFS
Date:   Fri, 25 Oct 2019 01:14:12 +0300
Message-Id: <20191024221416.14197-14-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024221416.14197-1-digetx@gmail.com>
References: <20191024221416.14197-1-digetx@gmail.com>
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

