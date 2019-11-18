Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26B79100CD0
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 21:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfKRUFo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 15:05:44 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36224 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbfKRUFn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2019 15:05:43 -0500
Received: by mail-lj1-f196.google.com with SMTP id k15so20441787lja.3;
        Mon, 18 Nov 2019 12:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2iFp0McD4dqk5YgWCVTRp0Ssb3SKcWOgq/D9CcGeKIY=;
        b=tL04NoA4xOq6oRXud1L8c1zw/ONwWYxS2KnE9NjB4O9oWkqqhu46L6KBAoQl4OrZq3
         6AMZduD/v9J09W7TGRLhqhlOVPba5f7a8+KnPxC8dtEfDv2BIskgdiTm5BPpm0UAlW++
         jbM8TgYS2IbvZxOOEGmAgnkodqL8CX4B/AuVKNoDS+ka+kgnWWs+L0FK7+VW9Ts+wx4+
         T50tuH2lMPcupJm7qH87zRPw3QsFKNgKsE1vYQZtO9TJQu6nMXxo/A0Zep4V7ShQWsYP
         C0rNeMgsuDEQj4LHrt7T4c0k+wUYIsPoRXtKM+aAnkefU9tcyBfzSD75D6m5HDcByYe4
         Gp/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2iFp0McD4dqk5YgWCVTRp0Ssb3SKcWOgq/D9CcGeKIY=;
        b=Sy3U9i0YqT1vXagQUk/ALWNhUVyBEOKAV/LZZpxF38YkktroScqUQtOUC7oVj+8wyz
         GQijvzbE2StcXKFBoGEJ7DOvL2+q+3A3/Shg7JVOZqk07L2M52o2BqXOK1xfZRU6ny9Q
         0nCPen1VlD0Dbp8AcA9OaxcePy9zH7JZbnUS3DQhOIFQFLLJg9ALaWqgIXpG3jRZZDDc
         HaiC0FM3naH/V1VahfolbADc1+caLQoTH1kFVjDXBjrAt24Yvq/+bW4+bQf1t8JKiU5m
         Ju9G5v3vPSydrN0EQAsA1G96wxBsPF2yD4XvKPK+Olcwni7b1UmQQlkyDbDRqv87rE6c
         4R6g==
X-Gm-Message-State: APjAAAWaJEXcLCShk3uhSVhsqgtpU68Cp5j3Ei1XEhQ5cmTqwUBVHR1G
        C/xrTkzmprfDOCLPVQoasiM=
X-Google-Smtp-Source: APXvYqyhq0nkF8z5M/s9tUqCARtFUhFB8Jl3ISigj1qsNidZbs53NZUOJaj7p6egJlDCTN7SQFdzIg==
X-Received: by 2002:a2e:898a:: with SMTP id c10mr871793lji.177.1574107539717;
        Mon, 18 Nov 2019 12:05:39 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id j23sm9166942lji.41.2019.11.18.12.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 12:05:39 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v1 09/29] ARM: tegra: Add interconnect properties to Tegra20 device-tree
Date:   Mon, 18 Nov 2019 23:02:27 +0300
Message-Id: <20191118200247.3567-10-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118200247.3567-1-digetx@gmail.com>
References: <20191118200247.3567-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add interconnect properties to the memory controller, external memory
controller and the display controller nodes to describe interconnection
of these nodes.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra20.dtsi | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 9c58e7fcf5c0..2aa10a34516b 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -3,6 +3,7 @@
 #include <dt-bindings/gpio/tegra-gpio.h>
 #include <dt-bindings/memory/tegra20-mc.h>
 #include <dt-bindings/pinctrl/pinctrl-tegra.h>
+#include <dt-bindings/interconnect/tegra-icc.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 / {
@@ -108,6 +109,9 @@
 
 			nvidia,head = <0>;
 
+			interconnects = <&mc TEGRA_ICC_MC_DC &emc TEGRA_ICC_EMEM>;
+			interconnect-names = "dma-mem";
+
 			rgb {
 				status = "disabled";
 			};
@@ -125,6 +129,9 @@
 
 			nvidia,head = <1>;
 
+			interconnects = <&mc TEGRA_ICC_MC_DCB &emc TEGRA_ICC_EMEM>;
+			interconnect-names = "dma-mem";
+
 			rgb {
 				status = "disabled";
 			};
@@ -624,15 +631,17 @@
 		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
 		#reset-cells = <1>;
 		#iommu-cells = <0>;
+		#interconnect-cells = <1>;
 	};
 
-	memory-controller@7000f400 {
+	emc: memory-controller@7000f400 {
 		compatible = "nvidia,tegra20-emc";
 		reg = <0x7000f400 0x200>;
 		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA20_CLK_EMC>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		#interconnect-cells = <1>;
 	};
 
 	fuse@7000f800 {
-- 
2.23.0

