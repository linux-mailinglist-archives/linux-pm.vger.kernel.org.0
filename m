Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A217615B514
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 00:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbgBLXqw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 18:46:52 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44289 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729428AbgBLXqp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2020 18:46:45 -0500
Received: by mail-lj1-f193.google.com with SMTP id q8so4394901ljj.11;
        Wed, 12 Feb 2020 15:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xq9tBk/6KoDVPMtQ/rhYvGgBAgv98Cu3SgI5vW4OCek=;
        b=PG7Udi8bcc2n1H3a05otjSOGGZCtsp6Rn9pVmskrOMGeztPARSLFX0O2ABD02/dlX4
         XlBM5H9j8o9N2gKre+eTpgRf9oErS/UpIierdVRE9nPOTVWySlNP137HzqxNbYqoR3Co
         T6ouxcfB/eAPrkwLbT+QoUCqoe0IzrS1b9iEffsMAaRn3BYf43C59oew3KC5aZ8/Z58x
         hENhGeecIMAr/RGpgEPizN+rjuXfngJBxrLNotxMag5tqJkdhBK8uB/rP30SpZBv+dVM
         kEAEGKK12rnPYziQdpCu2ATub2fbMAN1JeknXmC2sfB4QLGrT6RIEznz8U5G9i33okcM
         t5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xq9tBk/6KoDVPMtQ/rhYvGgBAgv98Cu3SgI5vW4OCek=;
        b=r5ruepCdM5w0FroFneNdV1/JUT+ZmQWKOj/29V+Zts5+dbVgEGaFiZNL7jKCkfZ5CC
         xFE69HJW99BnXmzciMZa/CHSyNJFSC4oHCviiQTXj1vnlaC9U4DqRWgA1Y2jLJUPuQY7
         yA/wyqSFAqOhjtnsz/+FIuAxecO14SEX9GdqUGdk+PYxah26gwQ32wR3nkXFQUdK1fnF
         g2RkaZytx+bP8agCIyXCfR7JhZJ0DW3sNSxFxn9J4wWrcUi/Nu/c+NLSwW/CvpPqDu4S
         R6qwWjbScfBiNNutPyfoIYlyFNoYODbGzUiPN9qBf4EgpCZqYVOwZj8SrLRqvnLyxn7G
         /YsQ==
X-Gm-Message-State: APjAAAUWeB4pQQkjitqfTQqP+76JjfMjYLCCVITWrxGCMi55YWuMychI
        tgTIUGArE+oofSAtRA8Exbc=
X-Google-Smtp-Source: APXvYqyvFrklEk7ubbXdiW8Kd821C04G0XWZws5U+xsziFH/pjA21sNz4bQ+O/HFWS2tepUSkdm8pg==
X-Received: by 2002:a2e:a0d0:: with SMTP id f16mr9166327ljm.130.1581551202375;
        Wed, 12 Feb 2020 15:46:42 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id u15sm234453lfl.87.2020.02.12.15.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 15:46:41 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 11/12] ARM: dts: tegra30: beaver: Set up voltage regulators for DVFS
Date:   Thu, 13 Feb 2020 02:46:06 +0300
Message-Id: <20200212234607.11521-12-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200212234607.11521-1-digetx@gmail.com>
References: <20200212234607.11521-1-digetx@gmail.com>
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
@@ -1806,9 +1806,14 @@ vdd2_reg: vdd2 {
 
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
@@ -1868,17 +1873,22 @@ ldo8_reg: ldo8 {
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
2.24.0

