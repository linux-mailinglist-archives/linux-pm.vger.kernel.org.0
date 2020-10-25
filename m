Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B91A2984A6
	for <lists+linux-pm@lfdr.de>; Sun, 25 Oct 2020 23:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418985AbgJYWWN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Oct 2020 18:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1419217AbgJYWR6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Oct 2020 18:17:58 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F123C0613CE;
        Sun, 25 Oct 2020 15:17:58 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id m20so7724677ljj.5;
        Sun, 25 Oct 2020 15:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i/PNjU6itjrlyBa07JkRHNvay5XmCTm1sO/fh5dx5lk=;
        b=lQPso/WiJFAmOGYVl1iBH9ouDBMsFlTTViX4sx+MmmIEBjTcRDitlX2kVdMZ7U0yOB
         lRFxSsv5X1ZUyINJZPgPjjbx1hnslIu8ty8qNMVJ8Y6sgWCspG29RzF4vAGW+ch5otWg
         uUFkiT8F39OZj2dl9a6zt4S4bGn9i6VwCDFeYJNHcQo+JVhZJAw0HEVeRrgAypORoD0A
         K6XJKKlFrCj9P5c4ZW/qck04a+vfqA99dxI4s79rFEJpwPhsII+s6Knuw8DvGbWkmgAx
         XrtVx5yX3WQi51YBJwsdrGlJ7hQ3hV5amI77OrwskUMWA+4sl7TRKWC7t7BHHfnNXaNF
         w6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i/PNjU6itjrlyBa07JkRHNvay5XmCTm1sO/fh5dx5lk=;
        b=B0zfZIdHaY40XyTDNAshTMh0OSbR3KCr/ZIAxXqA3h2Dkqs6uOhv8XOzcImFPLStys
         2a5L7hEelvbKvgfxAu/R1iMcLo9cjOMWwjPoBsTwwB1jKpaUZSud5gZeE2PcXwLkyiml
         T3eWa4r07zXJlI5b2xruBWQnxg5hrTbz2cAXtWsR2DDlt4QznYmcDUPc/xA60D3/zBvI
         GU4+dQ5IrPntsq41FshlNzWC2FFlvTkavRdAnIaqhUBbPDNM+1VvpfSvxO5iylCD3Vce
         iWy0XYOgBMBn5ku9ZCsQ6wLamNEnp4FDfT3ZP7EIH4RIhgdYbqkogYYBZHinHfCgHHsH
         AJ2A==
X-Gm-Message-State: AOAM5315XVMaBXVqJ2/3DkmYSbBE+UIg089p1FLJ0iS0pVr/02agnOsf
        xarO0Bmn4roHFl3MuhOjkh8=
X-Google-Smtp-Source: ABdhPJwG6Hkkib/Jb8HPKUgje/QGgNKxkPlUMdgIM7PhcyXLFVojRxdBjbJNsNEM0zNH1Sr9HXO/MQ==
X-Received: by 2002:a2e:a288:: with SMTP id k8mr4678543lja.234.1603664276858;
        Sun, 25 Oct 2020 15:17:56 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.gmail.com with ESMTPSA id k13sm932423ljh.136.2020.10.25.15.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 15:17:56 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v6 07/52] dt-bindings: memory: tegra20: emc: Document OPP table and voltage regulator
Date:   Mon, 26 Oct 2020 01:16:50 +0300
Message-Id: <20201025221735.3062-8-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201025221735.3062-1-digetx@gmail.com>
References: <20201025221735.3062-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The SoC core voltage can't be changed without taking into account the
clock rate of External Memory Controller. Document OPP table that will
be used for dynamic voltage frequency scaling, taking into account EMC
voltage requirement. Document optional core voltage regulator, which is
optional because some boards may have a fixed core regulator and still
frequency scaling may be desired to have.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../memory-controllers/nvidia,tegra20-emc.txt      | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
index 0a53adc6ccba..8d09b228ac42 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
@@ -14,11 +14,23 @@ Properties:
 - clocks : Should contain EMC clock.
 - nvidia,memory-controller : Phandle of the Memory Controller node.
 - #interconnect-cells : Should be 0.
+- core-supply: Phandle of voltage regulator of the SoC "core" power domain.
+- operating-points-v2: See ../bindings/opp/opp.txt for details.
 
 Child device nodes describe the memory settings for different configurations and clock rates.
 
 Example:
 
+	emc_icc_dvfs_opp_table: emc_opp_table0 {
+		compatible = "operating-points-v2";
+
+		opp@36000000 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <36000000>;
+		};
+		...
+	};
+
 	memory-controller@7000f400 {
 		#address-cells = < 1 >;
 		#size-cells = < 0 >;
@@ -28,6 +40,8 @@ Example:
 		interrupts = <0 78 0x04>;
 		clocks = <&tegra_car TEGRA20_CLK_EMC>;
 		nvidia,memory-controller = <&mc>;
+		core-supply = <&core_vdd_reg>;
+		operating-points-v2 = <&emc_icc_dvfs_opp_table>;
 	}
 
 
-- 
2.27.0

