Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE2ED81A7
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2019 23:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfJOVR3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Oct 2019 17:17:29 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33570 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389641AbfJOVRU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2019 17:17:20 -0400
Received: by mail-lf1-f65.google.com with SMTP id y127so15637955lfc.0;
        Tue, 15 Oct 2019 14:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7wI6f4nvMYsmBCMp+G12GdGK/taTCqKZ+wxQzPpgr3A=;
        b=oueMGy5g3X4vHEeaCzMAX5QTU3ohEPkX6HhN/89mJlHOx0anq8ZqkeV5yXFufZMdZm
         XKaaBl1POydlSARBtPkDE/+Uk0kvJwojv5etdr2i+Vz5jTD0CHjh//JBBTPDGKBrzGRI
         SPTrX5lyZ+AprpF8dY8uR86U53vpSTudhMqdRGPmvTBwWUiaJAHfe27IJn/O+4RTDBCl
         XIjoU3EcmDtERanpE48nq6nJr+sRwTFbWZIk4wOC0jJ7u3JwMEaTPS4kjNuyi9GJuJ5P
         m5xjKfOnxJ0KHYco2GthEzFhk30RH5GPLOm3BY4lKVfuRaPFyJK7YfUuYBtGYMPvZCDB
         R93w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7wI6f4nvMYsmBCMp+G12GdGK/taTCqKZ+wxQzPpgr3A=;
        b=rmwNi4NX8ag7YyXMKopScBnHpIUnNU+NF2WxOToWFaT9v9l+bMeKCv81Sn1109GcHv
         e54RXFJ+BaVDZYdR/Q45h695sI0cH5l2g6Pha0WtzoBiEIqEcNXrnBSkZMzPIHOHKZek
         4zjqakRIrNfQACoq/zfyciWSwDYjuBsBDcYyfB+yDFHDkfdFxf/j+lKpfaWYXj+8UBMU
         pKKdDrDVsbJvcOniXMgcJoctUbMnwCNAJVCrMC2JNYmg84My4daFvZu8oWRvgUq8JcNF
         JWzdMNAcehl7Hpj5VTJH8jxZrOKd7dNKAMtpLXD1Yw2zMySB6+YyVfGcAiozutJQT2cv
         rPvw==
X-Gm-Message-State: APjAAAVc9GltLK4gKX2/vI0BriIOpBntXr3Pb3/MFCM+shsm0GCqeC+K
        n3k25I4tQWAQHX8UOnrf+z4=
X-Google-Smtp-Source: APXvYqw8RqSSgfSjfLh0K97RBAkMqjwTZYj/SHAkvypjVfIO0si8Y+The8uvAZIvoAL+l2QaAdjkKw==
X-Received: by 2002:ac2:428b:: with SMTP id m11mr22224763lfh.64.1571174237011;
        Tue, 15 Oct 2019 14:17:17 -0700 (PDT)
Received: from localhost.localdomain ([94.29.10.250])
        by smtp.gmail.com with ESMTPSA id t16sm5269186ljj.29.2019.10.15.14.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 14:17:16 -0700 (PDT)
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
Subject: [PATCH v1 16/17] ARM: dts: tegra30: beaver: Set up voltage regulators for DVFS
Date:   Wed, 16 Oct 2019 00:16:17 +0300
Message-Id: <20191015211618.20758-17-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015211618.20758-1-digetx@gmail.com>
References: <20191015211618.20758-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Set min/max voltage and couple CPU/CORE regulators.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra30-beaver.dts | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-beaver.dts b/arch/arm/boot/dts/tegra30-beaver.dts
index a3b0f3555cd2..6ebb3105af9e 100644
--- a/arch/arm/boot/dts/tegra30-beaver.dts
+++ b/arch/arm/boot/dts/tegra30-beaver.dts
@@ -1806,9 +1806,14 @@
 
 				vddctrl_reg: vddctrl {
 					regulator-name = "vdd_cpu,vdd_sys";
-					regulator-min-microvolt = <1000000>;
-					regulator-max-microvolt = <1000000>;
+					regulator-min-microvolt = <800000>;
+					regulator-max-microvolt = <1250000>;
+					regulator-coupled-with = <&core_vdd_reg>;
+					regulator-coupled-max-spread = <300000>;
+					regulator-max-step-microvolt = <100000>;
 					regulator-always-on;
+
+					nvidia,tegra-cpu-regulator;
 				};
 
 				vio_reg: vio {
@@ -1868,17 +1873,22 @@
 			};
 		};
 
-		tps62361@60 {
+		core_vdd_reg: tps62361@60 {
 			compatible = "ti,tps62361";
 			reg = <0x60>;
 
 			regulator-name = "tps62361-vout";
 			regulator-min-microvolt = <500000>;
 			regulator-max-microvolt = <1500000>;
+			regulator-coupled-with = <&vddctrl_reg>;
+			regulator-coupled-max-spread = <300000>;
+			regulator-max-step-microvolt = <100000>;
 			regulator-boot-on;
 			regulator-always-on;
 			ti,vsel0-state-high;
 			ti,vsel1-state-high;
+
+			nvidia,tegra-core-regulator;
 		};
 	};
 
-- 
2.23.0

