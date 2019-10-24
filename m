Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C78BE3F01
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2019 00:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730820AbfJXWR5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Oct 2019 18:17:57 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34808 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730772AbfJXWR4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Oct 2019 18:17:56 -0400
Received: by mail-lj1-f193.google.com with SMTP id 139so176510ljf.1;
        Thu, 24 Oct 2019 15:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8N97qQTC+6XrG8bUfxHlYQEAtBQiZweZkcpA8OraE+o=;
        b=Zuln4PF99RumN7y2yHDLvAytC1Bjo1+VWFZCYG/Xx25lto0cj4XN7olK/s5fXeRTmw
         JSnFHGX8kE6zd/FGvFRgSwRulkQN0ma0Dqg6oYEhYSfJMhmJNXag1r3hYrxVNHB9fLOu
         c1X/hi1TfL9mj0ZXqdyDDvSb6yam7g7jPdpq12cTpcvb2OCnU7b1gVANKlflmoVj24Ta
         lRCtkYNs80X58WA5O5xMSZn+5jv7uPTLTnteh/zBGxewHQKyPvRKeYUFsVGFJiRn26+y
         xvkpeNfhQdAiKr0UfpZVPkmWHXer054NAmmaQ+p/cIk0xEkVQU0BdTYvCLJVGRKSJBI4
         l3eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8N97qQTC+6XrG8bUfxHlYQEAtBQiZweZkcpA8OraE+o=;
        b=iBwZXGQr+NkOzdQTbY2I+kKXjl6COXztiVwZH4eEN0wbPLWmIWzAYBzBvR6SxcJgn5
         YNBBobJtvO4WRYW1nu6qORsj0EvNcTXkrp/W7O3cO3jUiTBJAXa05akUuveGgpzlN7rT
         Maymc2+W0VZGM84dVcsMqUMwCjykfD1WiJ3UteTL/QzS3X6/b4s+zL0SGbNd6a/ZUly/
         VYOZPmG4BNqfFuuLGxQ555+33TRv0M6Aw+9834E9i8gbU3AaTcydCZNqIRSOtgBhS6y8
         OHQ6X2rFIb7bjWVlwys3xHtdM1qPXFvImD7VIvjGah8JTwR5FnO0333k6rNGjLCyck70
         sFng==
X-Gm-Message-State: APjAAAVGABINJsEQIiGmTIb8idvgrZfAs+JcOozy/EUDPolE4kegjn6Q
        ENnLoX1TVUAHdrkxDeV9hEE=
X-Google-Smtp-Source: APXvYqy/vcg/TIZtag8K/q71ytHrRoLfgvwU3ibLV8j1c/f21I1gG36sjHNODftbGHZZJiPiIaOKqw==
X-Received: by 2002:a2e:7312:: with SMTP id o18mr60702ljc.32.1571955473681;
        Thu, 24 Oct 2019 15:17:53 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id i6sm11338765lfo.83.2019.10.24.15.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 15:17:52 -0700 (PDT)
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
Subject: [PATCH v2 15/17] ARM: dts: tegra20: trimslice: Add CPU Operating Performance Points
Date:   Fri, 25 Oct 2019 01:14:14 +0300
Message-Id: <20191024221416.14197-16-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024221416.14197-1-digetx@gmail.com>
References: <20191024221416.14197-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Utilize common Tegra20 CPU OPP table. CPU voltage scaling is available now
on TrimSlice.

Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra20-trimslice.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-trimslice.dts b/arch/arm/boot/dts/tegra20-trimslice.dts
index 3e5ac096d85e..8debd3d3c20d 100644
--- a/arch/arm/boot/dts/tegra20-trimslice.dts
+++ b/arch/arm/boot/dts/tegra20-trimslice.dts
@@ -3,6 +3,7 @@
 
 #include <dt-bindings/input/input.h>
 #include "tegra20.dtsi"
+#include "tegra20-cpu-opp.dtsi"
 
 / {
 	model = "Compulab TrimSlice board";
@@ -471,4 +472,14 @@
 			 <&tegra_car TEGRA20_CLK_CDEV1>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
 	};
+
+	cpus {
+		cpu0: cpu@0 {
+			operating-points-v2 = <&cpu0_opp_table>;
+		};
+
+		cpu@1 {
+			operating-points-v2 = <&cpu0_opp_table>;
+		};
+	};
 };
-- 
2.23.0

