Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD65EEA577
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2019 22:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfJ3Vfp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 17:35:45 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38645 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbfJ3Vfg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2019 17:35:36 -0400
Received: by mail-lj1-f193.google.com with SMTP id y23so3940957ljc.5;
        Wed, 30 Oct 2019 14:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7wI6f4nvMYsmBCMp+G12GdGK/taTCqKZ+wxQzPpgr3A=;
        b=rDeqytxnY1lMSwbNo19GxcF6E2Km7OBfX8XzxvlbUrTtMbJRUbOv73NXQ7wBpfy6Jh
         Grri4pplXKRLRQl+g5WZUqfur1Nlf0iKQya2ck2RPepa3xYyyMhZIsby7NesI2w/jjbN
         61cb/QwkvqOeVcUxxbX6mETerzh4veIDM0pCmZPwAQZmGOE5HiWPWSR/ndfAvWTucpbX
         cdhgoD+IaZFW5B+7RuBQJOPPR0tg1K24IAqk7xb7Z+x45zZykLDyN43w8umk2jvpZH+F
         xGVthh34S77T2guVmh3BmzA9oKjBSApDcS9y7Ahx0ZijIOqZmAFOdCIzZ3wrplSDRbDE
         /0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7wI6f4nvMYsmBCMp+G12GdGK/taTCqKZ+wxQzPpgr3A=;
        b=hZBzrtehT8tPgxhU8WMznFeWxWmPqfue1chpdiNo/V9qNAII24olRYAzi/oGvlINg+
         z6sGawnbZUiiVB45jUaTImOuhYGUCAXUFQY++Nq7rcVgbev+VAUO/pkfbIfYfKLotzUN
         P2SlCkyyP3K33hiniK2Ffw2M0tFPJHDdYWpOaknxqVGlriZlBGAjxxJ2IM7O4VU4+IMD
         4Baz5g4sgy/K+F7qsIizf+oEPON83ZiDccpv+7CcNj9dLes4oWggH9qBoMYaCGgeSLfc
         jhaTZCUZ4ffHoXDbl7mm4aWyTAUGmB3MAck5KBZfQstTqyCXJtvKQ/F5eMjS5SmVcTbg
         /anQ==
X-Gm-Message-State: APjAAAWe1H+K9UDamYWwYZM/AU+Tk4cL+cWTZ5PGTmDz1bpeVK46cOKC
        5yCqzqK61hVVpTN0E2CwzTs=
X-Google-Smtp-Source: APXvYqzoH8fuZdbDSgAU9MjlE8QYenK/QsipZ5KucXZXBebsErH0ojtuYDMQH7mN/gw0gqCygQ6hYA==
X-Received: by 2002:a05:651c:119b:: with SMTP id w27mr1144514ljo.221.1572471334103;
        Wed, 30 Oct 2019 14:35:34 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id c24sm553812lfm.20.2019.10.30.14.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 14:35:33 -0700 (PDT)
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
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/10] ARM: dts: tegra30: beaver: Set up voltage regulators for DVFS
Date:   Thu, 31 Oct 2019 00:33:59 +0300
Message-Id: <20191030213400.29434-10-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191030213400.29434-1-digetx@gmail.com>
References: <20191030213400.29434-1-digetx@gmail.com>
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

