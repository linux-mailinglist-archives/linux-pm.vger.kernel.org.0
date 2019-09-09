Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E83DAADC5C
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2019 17:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388840AbfIIPqR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Sep 2019 11:46:17 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33443 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388835AbfIIPqR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Sep 2019 11:46:17 -0400
Received: by mail-io1-f68.google.com with SMTP id m11so29837586ioo.0;
        Mon, 09 Sep 2019 08:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sAsg4pCxltmGzILf4YXVsFMOxOsAWMDU9ZZ3l3bhmCY=;
        b=idSpqUKFOUh1FRPn2pH5npRB/GJstm15pSB1JKTywkwVmUJGw6lgtOA4do/AS7USeV
         ZtePn1Eww8arHVlsadDfRlRiN/YhoFGX4+Q4xt/A70OXrp2ijpYtS7JBuhomoGme8MED
         05dmMt5yUT+b6bqIs0YAoI/sJ5crVVgpTvCyLBNGL+GMp7e4KQK2ltyheDed7Yz69OOT
         a4+xPSThgIvZIrpODu6qDNnCuJQYxZe+MBaPkgzhJWVwzvsoFtEd2l3GYiKPSU2YpSYW
         ZTVLP6hU4oLEduaeviXBXK48Z53Kabt9psCGFlk7l6tTBz7L0Bd03mky3OiFh7AgBOQo
         6xGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sAsg4pCxltmGzILf4YXVsFMOxOsAWMDU9ZZ3l3bhmCY=;
        b=o04X+LHbc1q3C29ak/VS5UBFvAjvyV+usa1lENTT0B/E64XRchT8esulGsyG6Sh8pz
         4OT937tiAHp9F041OdH/i2WXlH7lstpai5/+6cSl6TFs+YoprAjnsZoS6AUIHpuEBwJ8
         vEC44ZgMmid39yciyRshLFhDSiSjHT/oDOwXWadI5TDzPZE3Q3KebpIVJBg+BYN1OsJb
         pLdwBtVWPTyUPvIY5ihHNF9qtCxKUHoy7EJy8VNsbHhDn7JXK9kvteyLvba1PozjBL4C
         gAo7PmJ8CYZO4L8QlNO81P2FldlkeO/F4mQ3mUBYKM5J839RpvDhTWt/qch/J1n3jYne
         RAxg==
X-Gm-Message-State: APjAAAVCCq8eWPXR/5I+aP/Vc4hz8TwgOkIBGUlSHfK96jICsEyrzV5J
        258ZppLpgHAFFXSzEA7X2J1P0TG/ttc=
X-Google-Smtp-Source: APXvYqxGJQ8QXnAVO0BtgzY4Krmgi2/SSQmpZaUp65xrKuNmEVxpHkCnyCZUqHbrU6mgCIm3IjjQOw==
X-Received: by 2002:a02:3446:: with SMTP id z6mr27058650jaz.105.1568043975495;
        Mon, 09 Sep 2019 08:46:15 -0700 (PDT)
Received: from aford-OptiPlex-7050.logicpd.com ([174.46.170.158])
        by smtp.gmail.com with ESMTPSA id a21sm10402395ioe.27.2019.09.09.08.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 08:46:14 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-omap@vger.kernel.org
Cc:     neolynx@gmail.com, letux-kernel@openphoenux.org,
        andreas@kemnade.info, tony@atomide.com, adam.ford@logicpd.com,
        hns@goldelico.com, Adam Ford <aford173@gmail.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: Add OPP-V2 table for AM3517
Date:   Mon,  9 Sep 2019 10:45:02 -0500
Message-Id: <20190909154502.19804-2-aford173@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190909154502.19804-1-aford173@gmail.com>
References: <20190909154502.19804-1-aford173@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The AM3517 only lists 600MHz @ 1.2V, but the revister values for
0x4830A204 = 1b86 802f, it seems like am3517 might be a derivative
of the omap36 which has OPPs would be OPP50 (300 MHz) and OPP100
(600 MHz).

This patch sets up the OPP50 and OPP100 tables at 300MHz and 600MHz
for the AM3517 with each having an operating voltage at 1.2V.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/boot/dts/am3517.dtsi b/arch/arm/boot/dts/am3517.dtsi
index 23ea381d363f..a0f23361d4bc 100644
--- a/arch/arm/boot/dts/am3517.dtsi
+++ b/arch/arm/boot/dts/am3517.dtsi
@@ -16,6 +16,37 @@
 		can = &hecc;
 	};
 
+	cpus {
+		cpu: cpu@0 {
+			/* Based on OMAP3630 variants OPP50 and OPP100 */
+			operating-points-v2 = <&cpu0_opp_table>;
+
+			clock-latency = <300000>; /* From legacy driver */
+		};
+	};
+
+	cpu0_opp_table: opp-table {
+		compatible = "operating-points-v2-ti-cpu";
+		syscon = <&scm_conf>;
+		/*
+		 * AM3517 TRM only lists 600MHz @ 1.2V, but omap36xx
+		 * appear to operate at 300MHz as well. Since AM3517 only
+		 * lists one operating voltage, it will remain fixed at 1.2V
+		 */
+		opp50-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-microvolt = <1200000>;
+			opp-supported-hw = <0xffffffff 0xffffffff>;
+			opp-suspend;
+		};
+
+		opp100-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <1200000>;
+			opp-supported-hw = <0xffffffff 0xffffffff>;
+		};
+	};
+
 	ocp@68000000 {
 		am35x_otg_hs: am35x_otg_hs@5c040000 {
 			compatible = "ti,omap3-musb";
-- 
2.17.1

