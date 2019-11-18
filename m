Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C037A100CDF
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 21:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfKRUHJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 15:07:09 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34515 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbfKRUFn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2019 15:05:43 -0500
Received: by mail-lj1-f194.google.com with SMTP id 139so20452088ljf.1;
        Mon, 18 Nov 2019 12:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3B7+0SNFIwKYfZnWg59M6CobeLtFL0LQksvAiCdlsLo=;
        b=GvfAMBwjwdcJwcfQkg3EYPixn7Fn9xRg5dcSxz41GPIA2pK3Lsv7ue0FOHHWASXzbR
         c8HdPA2WivTVy97ItI39CUEvrHkYTM2BFLLyihqmmzzYjmW7+8PNBFZpf8e5YJ33+QNj
         pg84s/xcDSukyKnuAui1kYlt6oAvk8L2dRImj4FI1leqMK91gJSnKs3urCrms5d6GrbD
         OnBPvMLZP8Hk5f50CVL3KPjPFnsEv+sL9Qc8Dr28XcoHvwEZFlclJr34gcg+fX2PoDCY
         /caJfWEf3TlFkSFovaSf7dqk9AZkEPVI4yVSiTdaCJxtGhJDZv2Fk6rWTCV8AAUkPLif
         a1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3B7+0SNFIwKYfZnWg59M6CobeLtFL0LQksvAiCdlsLo=;
        b=KHals7iJpq2q0HCApjNlW/N3pZ8Z73OdmTIXy1gsTV/Ki0v5wXwZHD/aTb1Fv1kdq7
         4bISanwnDyw3c5cnUobZlritGNyet/bhdCqKFofsCwV43QpMz2B8WAfbP8YVU/axOi+1
         PQckEiSJ0xD5YphQam9CSGa/EBWRuegWhFaRuu5VAs6WTHmk1M80/kp6lZx2OD9agQgn
         sRxtP41lWhYQ4N/dH/EXCmha0UgzxthyV48XczhTyURaOMwskL5U1MccWY/bKHF71FUy
         +D6CgW9HBeC9c/VZyRIJWv4GbL3Cy5D6AHKOECFIruKD0Ksww9b0bZ15Y1iG3pTtOaLT
         duHA==
X-Gm-Message-State: APjAAAVZN4/LOgjFgPEU1ReYmjBMH8UBJqavMQTEuJPRJTPNbhUEX3tz
        ZgwIRM60xy/mlACkYgEFaJ8=
X-Google-Smtp-Source: APXvYqw4Kk/DTPpOdb5NICSC77dWA+HpTh1Lw/70XFfbsOeRC7m2vVYJpp6tyFd+HjiY4uZyb2RFPQ==
X-Received: by 2002:a2e:921a:: with SMTP id k26mr944738ljg.238.1574107540692;
        Mon, 18 Nov 2019 12:05:40 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id j23sm9166942lji.41.2019.11.18.12.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 12:05:40 -0800 (PST)
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
Subject: [PATCH v1 10/29] ARM: tegra: Add interconnect properties to Tegra30 device-tree
Date:   Mon, 18 Nov 2019 23:02:28 +0300
Message-Id: <20191118200247.3567-11-digetx@gmail.com>
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
 arch/arm/boot/dts/tegra30.dtsi | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 55ae050042ce..69a239f1a823 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -3,6 +3,7 @@
 #include <dt-bindings/gpio/tegra-gpio.h>
 #include <dt-bindings/memory/tegra30-mc.h>
 #include <dt-bindings/pinctrl/pinctrl-tegra.h>
+#include <dt-bindings/interconnect/tegra-icc.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 / {
@@ -207,6 +208,9 @@
 
 			nvidia,head = <0>;
 
+			interconnects = <&mc TEGRA_ICC_MC_DC &emc TEGRA_ICC_EMEM>;
+			interconnect-names = "dma-mem";
+
 			rgb {
 				status = "disabled";
 			};
@@ -226,6 +230,9 @@
 
 			nvidia,head = <1>;
 
+			interconnects = <&mc TEGRA_ICC_MC_DCB &emc TEGRA_ICC_EMEM>;
+			interconnect-names = "dma-mem";
+
 			rgb {
 				status = "disabled";
 			};
@@ -731,15 +738,18 @@
 
 		#iommu-cells = <1>;
 		#reset-cells = <1>;
+		#interconnect-cells = <1>;
 	};
 
-	memory-controller@7000f400 {
+	emc: memory-controller@7000f400 {
 		compatible = "nvidia,tegra30-emc";
 		reg = <0x7000f400 0x400>;
 		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA30_CLK_EMC>;
 
 		nvidia,memory-controller = <&mc>;
+
+		#interconnect-cells = <1>;
 	};
 
 	fuse@7000f800 {
-- 
2.23.0

