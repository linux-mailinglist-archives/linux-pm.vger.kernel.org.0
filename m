Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 526EFD81AF
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2019 23:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389775AbfJOVRk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Oct 2019 17:17:40 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34332 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389607AbfJOVRT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2019 17:17:19 -0400
Received: by mail-lf1-f67.google.com with SMTP id r22so15644211lfm.1;
        Tue, 15 Oct 2019 14:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sq46IP0Uprw+T0UXBXHvTxIAkrExDdXPqqIRm720IcE=;
        b=fu/g29kM2JflQ9oSRQWfgKbXN/zBmWXOkWWhoAfzqHVdnSWiguc7nERY5Y1NWbpcyl
         P52CycKowkEBgIcXD41ZT0RL81OYO8aPHTFNTBcJGm9aTdF6TaLUd85ZIopcH/BMHauN
         ovIghN2xHVwQnht+9LxAYXqJ73bdTEK/t1LgE++mcvu5IbQGY/i6N/IjV72qtCMp/Y+t
         NJoWyGR7zASkc+UoqMEZxSfJ1iU1cdNcyCrSEASWMDY9tZwO6AQ0z8FMxKedr7Q8ZpQb
         fA9ewBYHiSPxIo4dTmfPP1Cv2U5IyjYS9MS9Oh80G9E1DdWnyQGzchj4drGaWG9dWsNy
         gXHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sq46IP0Uprw+T0UXBXHvTxIAkrExDdXPqqIRm720IcE=;
        b=h3gyfBWmmeYLsE/cNQ/W3hYoSCtsSF9OsvWz5HkaYk0aOswfDmbjlVcmQ9gxliEnEC
         q5WyPQbWTT2sagsHC9/4G3xM8L/5hBnPKWEGSWCiQuT6LvY3yTgwwmiEQatjkmSGCsIt
         pUmPbmpiYBRObyfhTMS+K/m+2B4wzEhkNXLkCRoW6/k1VUnPkfVeS5S6gtSD9eewDgAA
         33cu8KBX2fLNNOO2vmtpzySRwajdDu3ejB1BJxSL/l7kIDkZVly+08y9B+08rZxRFfQl
         L1Ezb7Eb4tvdYDNttHabyBu7ZIk9wxna/eoL9N1/qQPKATMQTEYrPMXy+bSFMv9M6iM6
         LBKw==
X-Gm-Message-State: APjAAAXopQoY6NWC3JsHxcfVMcJjRwtt0yEZJuy4qs3fC9IK/N6SkKaq
        /TXovJbNzEsH7tct/4ek88E=
X-Google-Smtp-Source: APXvYqyF91brI2ncSfBlyDg5INknMNmNbmhlRJOLxyaqMizQQT8iXbkbwxOj4qUKexMuhB4hgdN2eQ==
X-Received: by 2002:ac2:4196:: with SMTP id z22mr22148769lfh.171.1571174235938;
        Tue, 15 Oct 2019 14:17:15 -0700 (PDT)
Received: from localhost.localdomain ([94.29.10.250])
        by smtp.gmail.com with ESMTPSA id t16sm5269186ljj.29.2019.10.15.14.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 14:17:15 -0700 (PDT)
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
Subject: [PATCH v1 15/17] ARM: dts: tegra20: trimslice: Add CPU Operating Performance Points
Date:   Wed, 16 Oct 2019 00:16:16 +0300
Message-Id: <20191015211618.20758-16-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015211618.20758-1-digetx@gmail.com>
References: <20191015211618.20758-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Utilize common Tegra20 CPU OPP table. CPU voltage scaling is available now
on TrimSlice.

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

