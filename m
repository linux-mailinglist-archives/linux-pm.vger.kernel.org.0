Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE8C718BFEC
	for <lists+linux-pm@lfdr.de>; Thu, 19 Mar 2020 20:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbgCSTE0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Mar 2020 15:04:26 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43853 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbgCSTEZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2020 15:04:25 -0400
Received: by mail-lf1-f68.google.com with SMTP id n20so2557022lfl.10;
        Thu, 19 Mar 2020 12:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NCItyd8yjMwPtwwQd4zzBNEoARaFlEvxh+OiOGd8HtY=;
        b=d1qtGLvqLnU4YGXDa+6ltiSnOsN+uAC2wfCdh4DfRhRb4yiJlWqp3But/WMhc9h2FN
         0vBG2xchq3N/jf0HJGpqlMPpiVF7pTM5qs78TJaAc0wsDzZ5Jx/j92qfuJi0G3n9btzk
         GemnM26fj2voN77S85eLhsxb+n1zLB9fNGsl3gMpy5R0BwcAZNEqv0WRvwvFupg5zULG
         xqtPJ+EzGotxRDPxuPanWXH/DsIQnBJRDgLU3v4uRb/U/4EOfWXKClTiY48+2cRcABxo
         iRm558gtm8TVqt8gdg9Xgvyc7m23XXUznEGkc0wgstJwOf2Zj/ppbcMRvRUw3ZaIJ9//
         +7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NCItyd8yjMwPtwwQd4zzBNEoARaFlEvxh+OiOGd8HtY=;
        b=RIdNXd1IpOGJCJA0KvaxPXHQgwGx5jxI6H5Q30cYYwemwQ5k3qbc7tRlZfCBZiRZRw
         4vij9Kjus7xopug/wuLTJ1WqIalSY0SSgugoFrHcvX96hhUr51v2PS/cg3qEM2GW9DTZ
         8X6U+r3rIx2KfOPnY04fZNUdmChYMwx3TqCE0zkSwI8L2FoQgOHnFKfhM+j8QtG3eTTv
         QJ2GZUWPNZo0U6WtqdaFb62zR7AdxoxVzOLdKScB+bsL30KjN1/UeQc3c0jb4HIS0RIx
         KxuFoeg0yjafyanj5U2prPHzSbeMurBnLS6MurqUpZHxZHnxbDglOCRbrTd+RWdYcfG7
         cf1Q==
X-Gm-Message-State: ANhLgQ1dFS2PDrTgCFbuEDeFlOsdl9Nu33AKGmgXQUuDcvTuV5U85gIr
        C+hKwyg/PZ4sXf9SJCp7BdM=
X-Google-Smtp-Source: ADFU+vvxSPaWv4tBpO5i7RMaYY3eDnGk+xIwwnnb+6Co4FNBIO7VuuPcyNLUArribUaZTbJTOeXpZA==
X-Received: by 2002:ac2:4552:: with SMTP id j18mr3054551lfm.89.1584644663187;
        Thu, 19 Mar 2020 12:04:23 -0700 (PDT)
Received: from localhost.localdomain (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.gmail.com with ESMTPSA id k14sm2025380lfg.96.2020.03.19.12.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 12:04:22 -0700 (PDT)
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
Subject: [PATCH v8 11/12] ARM: dts: tegra30: beaver: Set up voltage regulators for DVFS
Date:   Thu, 19 Mar 2020 22:02:28 +0300
Message-Id: <20200319190229.32200-12-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200319190229.32200-1-digetx@gmail.com>
References: <20200319190229.32200-1-digetx@gmail.com>
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
index 45ef6002b225..a143cac22340 100644
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
2.25.1

