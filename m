Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04B62D81BC
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2019 23:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389803AbfJOVRu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Oct 2019 17:17:50 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38821 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389585AbfJOVRS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2019 17:17:18 -0400
Received: by mail-lf1-f66.google.com with SMTP id u28so15618069lfc.5;
        Tue, 15 Oct 2019 14:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qUBAwOdtpZgi+MnUyIrnTd1TaWn9LHYTmkJ6UDbhmPk=;
        b=X2QuMH+4Mprgws7E9bew4AL+fIPEmI0keAdvnLCdMDnX0Nsh1UsKHL6MEdKCJyThuS
         srB13fnARNVip5dZmcH+096SJwfZ0MZ3wbCFxIz5ag7wdMiGDJ/yTvhNjzDc46KJVLDk
         F+0u2FTGT3B26sItSRKB2+WPjyLwHDT+J4Mk6GEbTDaispIaHVuOcvlxwGUevAEBjlvA
         TzL+XKUQH+o2rUP2RSWP82JqmXHMe/NzOgOuKCnTW7PRp7hxJC1AOAWHeOC02v38hX2A
         qRdCzPlb7xSx/RqOfuwm0CB2TDPlfvY+39eTgACDxLA+QAj7H2C5T7IKz7HTvV3zmom/
         j1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qUBAwOdtpZgi+MnUyIrnTd1TaWn9LHYTmkJ6UDbhmPk=;
        b=aBGYB+9N1HdSTv4oXofAlDxvH+LmXYGb7veLtPfBpckvy3SLy/sUnmXNCL6CU7hLcc
         kjcdjkh8IFgnx+kZWmZQ/RG1KkxMWcjUjLvSC19cydLXipF1VAdC2pSt99u47pPG4d/w
         1NSEQ4F/1mII4iNLr9lJGkMUmfcmOZsbL+pzG3/wkmAF02Dp7Pk7Nnn+4dgagezotLaq
         Kzr51bkH6sbOWMFieeQ4jC7HYoHVca1cfSjwWfQfoNPKAZ/SNImxgFo3Q7S5YRkOa+06
         5Z0vvKJm+2fc8xMZVtCNy9q5F6bG9i4iDYQCvd+zR94PRUw3KvuLwGIUThP8g+rt2KtL
         To9g==
X-Gm-Message-State: APjAAAXaalZrAfsIsn4bDsgNo/yr4odhEFd1s6+/ngFV3rV75sZxzMQS
        GNPoDb9n9AJ7t2grRc4nykc=
X-Google-Smtp-Source: APXvYqypqalVRZvYL8LDLcAe5fDXSaObl4g1nLtoW3nrwSadYxapybwFA5yDbTlfgvdtn7s/y9SwWw==
X-Received: by 2002:a19:5f50:: with SMTP id a16mr7974332lfj.104.1571174234868;
        Tue, 15 Oct 2019 14:17:14 -0700 (PDT)
Received: from localhost.localdomain ([94.29.10.250])
        by smtp.gmail.com with ESMTPSA id t16sm5269186ljj.29.2019.10.15.14.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 14:17:14 -0700 (PDT)
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
Subject: [PATCH v1 14/17] ARM: dts: tegra20: paz00: Add CPU Operating Performance Points
Date:   Wed, 16 Oct 2019 00:16:15 +0300
Message-Id: <20191015211618.20758-15-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015211618.20758-1-digetx@gmail.com>
References: <20191015211618.20758-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Utilize common Tegra20 CPU OPP table. CPU DVFS is available now on AC100.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra20-paz00.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-paz00.dts b/arch/arm/boot/dts/tegra20-paz00.dts
index 6e9fe192c648..85fce5bc72d6 100644
--- a/arch/arm/boot/dts/tegra20-paz00.dts
+++ b/arch/arm/boot/dts/tegra20-paz00.dts
@@ -3,6 +3,8 @@
 
 #include <dt-bindings/input/input.h>
 #include "tegra20.dtsi"
+#include "tegra20-cpu-opp.dtsi"
+#include "tegra20-cpu-opp-microvolt.dtsi"
 
 / {
 	model = "Toshiba AC100 / Dynabook AZ";
@@ -616,4 +618,16 @@
 			 <&tegra_car TEGRA20_CLK_CDEV1>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
 	};
+
+	cpus {
+		cpu0: cpu@0 {
+			cpu-supply = <&cpu_vdd_reg>;
+			operating-points-v2 = <&cpu0_opp_table>;
+		};
+
+		cpu@1 {
+			cpu-supply = <&cpu_vdd_reg>;
+			operating-points-v2 = <&cpu0_opp_table>;
+		};
+	};
 };
-- 
2.23.0

