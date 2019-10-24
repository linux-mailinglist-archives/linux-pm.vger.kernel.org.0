Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 546EDE3EF7
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2019 00:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730893AbfJXWSD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Oct 2019 18:18:03 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36583 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730812AbfJXWR7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Oct 2019 18:17:59 -0400
Received: by mail-lf1-f65.google.com with SMTP id u16so20423259lfq.3;
        Thu, 24 Oct 2019 15:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SRZiQeucNCGBdlqwTzaIYE1CEk27ias9lFSKqU/IIKA=;
        b=uHHM44aNEYLJJSFeNN2LlFdNV8YVJN9NHQlXwaQT/IaV7a0m94/bLaBIqRiNdZEzaG
         EtEbkh6KBT1RczvbjjYpzXtjqE1yj/5qDp0zXLmrAkS8cs5JzIeJkacM7UJkisaFQlGI
         bUDau8ubRT28Cdg9O/mNm/U/Y/8Z82dC26aSYPIXP9wWKlpoV2CAsp4ofMsqsMaHwzUC
         DO3j+rkQACBCJSY4FJrWaIv9vRWdwgQMpiZrmp1L6R3dZUXYwpshZCXDCFdQg+xqyYhA
         OOKw+QbN1PDozRWwrA4ISYZMdPXFsvXaOYm5wUM09BvkbiojW0uD+f7NBG5i4sOqTJ3m
         akAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SRZiQeucNCGBdlqwTzaIYE1CEk27ias9lFSKqU/IIKA=;
        b=iz4utn+oX7F/wbwjlG+letCmU9S8PF9Rw1RD9xZ1GWHNxDtIy8bQ7SLHtQxLSCn18y
         YzIccrK3jXV3dR0ClVgFDB34WHnfKiSAGDUO4p1r+jcrNsQiZPCkAo+Y1rBBrVThrfKD
         AwweSdan7IlBVDfQlZ3y++u82B+EdbztLutA/YnUlyvRm2TmnoEN/qHkus0heaGdJKi/
         yAcWZiqM4nOqma6LbhP2OemzghIyLRVpGFK4H0Z5TQuqpjjWr43iweKR9wP2uncUWT0p
         Qpp56SCiWxewr9lHGcYH5+MUk4Iw6Ypse/6eriW2qc0hrNwhl9OczV0nuAKlEvvRL5m7
         7HOA==
X-Gm-Message-State: APjAAAWVvPGZLcph0OciloVQv3GfAzmX4u8I9gg1MSCUVuCgZaSY8v4p
        xgvH05lxDOgs9mJwDpX4U84=
X-Google-Smtp-Source: APXvYqwZ82ySmk2BMPumPLP/kcKQAnUR5TxNVS4XlEzxyTJb6KeVq3x+/jSGnWqc0xQbCSfpt6YQGg==
X-Received: by 2002:a19:640c:: with SMTP id y12mr328182lfb.78.1571955476117;
        Thu, 24 Oct 2019 15:17:56 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id i6sm11338765lfo.83.2019.10.24.15.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 15:17:55 -0700 (PDT)
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
Subject: [PATCH v2 17/17] ARM: dts: tegra30: cardhu-a04: Add CPU Operating Performance Points
Date:   Fri, 25 Oct 2019 01:14:16 +0300
Message-Id: <20191024221416.14197-18-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024221416.14197-1-digetx@gmail.com>
References: <20191024221416.14197-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Utilize common Tegra30 CPU OPP table. CPU DVFS is available now on
cardhu-a04.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra30-cardhu-a04.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-cardhu-a04.dts b/arch/arm/boot/dts/tegra30-cardhu-a04.dts
index 0d71925d4f0b..9234988624ec 100644
--- a/arch/arm/boot/dts/tegra30-cardhu-a04.dts
+++ b/arch/arm/boot/dts/tegra30-cardhu-a04.dts
@@ -2,6 +2,8 @@
 /dts-v1/;
 
 #include "tegra30-cardhu.dtsi"
+#include "tegra30-cpu-opp.dtsi"
+#include "tegra30-cpu-opp-microvolt.dtsi"
 
 /* This dts file support the cardhu A04 and later versions of board */
 
@@ -127,4 +129,26 @@
 			nvidia,tegra-core-regulator;
 		};
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
2.23.0

