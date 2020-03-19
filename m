Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40BF018BFEF
	for <lists+linux-pm@lfdr.de>; Thu, 19 Mar 2020 20:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgCSTE2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Mar 2020 15:04:28 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35735 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727605AbgCSTE2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2020 15:04:28 -0400
Received: by mail-lf1-f65.google.com with SMTP id m15so2585204lfp.2;
        Thu, 19 Mar 2020 12:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FzD7KM1adJ8Gdad+SjbdNnB2giwK8d8O4lhpA1iChjI=;
        b=La/uSPx8FTVei4FU1VbWMVxuNbaBvJfMTXeORDKylSu+QXDz+dxViJJlI31XLVT5fl
         KADAGdkDgWWfN63q0601+IsmlJVBm4EHCl4LWxvjMiOf255nzjLer+RTZqMkhVzSe0rM
         Q0sMbTnR6J+HgVFsZOYnjh+4FApTXfv0TxEqfTLQRg72QMPTrWcSpoZxdp2g8SkxFxs+
         dLKBK4l0yEs7mnnMHD07skmYV9KkeYkvJjmLun/S1cWMHO+dPSK+yDD01dVeQQOrn/84
         tnrh/Kws8GJU+XW2RSWWpqwa/Itc5fa0fkbV10PDe21uUPITgwmZqCJ3jnQrf3XAySqP
         m0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FzD7KM1adJ8Gdad+SjbdNnB2giwK8d8O4lhpA1iChjI=;
        b=X9MMtvrhf7ElfqQipc/TAcQaw9SHQUUcHvJNKt5cVhmAYir6jRQ57j20LWXQiLz/Tu
         4xh8xSG1nGIkrRoFbAxi//UgBEO5X1tpDyMPS97oMdGPoKnYZc0Dc/Hyrh4cxmhaBVBQ
         xODKCKgDV1xwjKbvV8MFw73OcS8UbVXSLxBWBOzbxjLJDp0cgVbkbJ0cH1EEOr8hXy+n
         XdP8inDcZLICnkMp3d1bzzWJPPpJgv605MmmajS/wgG7INJMMVefA/O24dv44oHj4FhO
         2bTYPXS3OHvGpVo9TLjGtBF7qWbJDSXqXaTzEfpc5sPOidoKkXp7qAnL3S7UsNHIYh4t
         kjuA==
X-Gm-Message-State: ANhLgQ0LDqDBMI5dYhZJyF/x0FjVO454urARoIHxQ8sk3v4XqV35Al5W
        JbreBYcRcml/Px5zyLTxXpI=
X-Google-Smtp-Source: ADFU+vvXgwoXHt8F4Hhxl+v/+A9sCmOkV1/dC6+JllXYIW1tUhx3W7HUxzuvar+MVCBV61kah2kmcA==
X-Received: by 2002:a05:6512:68b:: with SMTP id t11mr3063580lfe.214.1584644664509;
        Thu, 19 Mar 2020 12:04:24 -0700 (PDT)
Received: from localhost.localdomain (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.gmail.com with ESMTPSA id k14sm2025380lfg.96.2020.03.19.12.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 12:04:23 -0700 (PDT)
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
Subject: [PATCH v8 12/12] ARM: dts: tegra30: beaver: Add CPU Operating Performance Points
Date:   Thu, 19 Mar 2020 22:02:29 +0300
Message-Id: <20200319190229.32200-13-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200319190229.32200-1-digetx@gmail.com>
References: <20200319190229.32200-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Utilize common Tegra30 CPU OPP table. CPU DVFS is available now on beaver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra30-beaver.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-beaver.dts b/arch/arm/boot/dts/tegra30-beaver.dts
index a143cac22340..6b6fd8a8058f 100644
--- a/arch/arm/boot/dts/tegra30-beaver.dts
+++ b/arch/arm/boot/dts/tegra30-beaver.dts
@@ -2,6 +2,8 @@
 /dts-v1/;
 
 #include "tegra30.dtsi"
+#include "tegra30-cpu-opp.dtsi"
+#include "tegra30-cpu-opp-microvolt.dtsi"
 
 / {
 	model = "NVIDIA Tegra30 Beaver evaluation board";
@@ -2130,4 +2132,26 @@ sound {
 		assigned-clock-parents = <&tegra_car TEGRA30_CLK_PLL_A_OUT0>,
 					 <&tegra_car TEGRA30_CLK_EXTERN1>;
 	};
+
+	cpus {
+		cpu0: cpu@0 {
+			cpu-supply = <&vddctrl_reg>;
+			operating-points-v2 = <&cpu0_opp_table>;
+		};
+
+		cpu@1 {
+			cpu-supply = <&vddctrl_reg>;
+			operating-points-v2 = <&cpu0_opp_table>;
+		};
+
+		cpu@2 {
+			cpu-supply = <&vddctrl_reg>;
+			operating-points-v2 = <&cpu0_opp_table>;
+		};
+
+		cpu@3 {
+			cpu-supply = <&vddctrl_reg>;
+			operating-points-v2 = <&cpu0_opp_table>;
+		};
+	};
 };
-- 
2.25.1

