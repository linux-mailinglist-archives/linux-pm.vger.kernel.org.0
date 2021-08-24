Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9FF3F570A
	for <lists+linux-pm@lfdr.de>; Tue, 24 Aug 2021 06:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhHXEKw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Aug 2021 00:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbhHXEKu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Aug 2021 00:10:50 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B912C061764;
        Mon, 23 Aug 2021 21:10:07 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id x10-20020a056830408a00b004f26cead745so42438406ott.10;
        Mon, 23 Aug 2021 21:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CTuSMH4A7Ffb6ZlHMh0V3hg0lEYSc6xST4UQtOrkdPg=;
        b=nsgbg02JwlShAq7cJxYmyQ7JCCMcGcs2PR8DjNTKpXe47zEnHcVc1RyfGYqVzTqDXi
         zIZexFaeFYSNO3E2CuhLjOVmBDCLAvwZRLP0A+qCL5ElIDk4kgx6YJrzjml50QNIURQ/
         +mXUInDNMNJZr/O3v8qn3ZlPdbZepdyA4kwxb9bHgirjV7074510jc25WH0/JOWvxk6E
         +Vg/pahCot7bpCPnxn3cR11gMDIYTTnNrJ9tm/iAW9ZlBoIYuWQCXCaRyzLtQXxWmFmq
         pIvyoBJbXFF56eNbEjMSTyO29Dk1O1BxLXJAschZsGB9pYT1oD2w9AqR5seQ74Io452B
         IDyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CTuSMH4A7Ffb6ZlHMh0V3hg0lEYSc6xST4UQtOrkdPg=;
        b=K8bCfzP/j8lXxfA0ZmwMQ/6H5Xo7ahTXwsmgEmaacsXOU8r+9R1tYsg6J2ZXZ6QxsH
         TLl94NOnDWGA1TM2eWt5dmGXgrXJ7KdqBRo1tfQ5hWdcZnFtxFcJc9KLWrXc2BkM2H54
         7/xJLMlzOlqbWtFxn3lul83B1TcPkh+5vMKASNc8SdyEgV+MgtJP3sn8U8gDhoa/gT6N
         ots9pR4dQ1cual4OrstDBay2QUmDVectXgWRancOXbpzD/uuBAgIRZJONV4Ybk11cVRI
         EYcbclSlj7mU7z8ujy23MDNZ+F/phbcVXXmoe7zqK7zkdRyOBZSi/GK1fC2D8EvkRE3n
         3P3A==
X-Gm-Message-State: AOAM533HDzqGZyW3bqIk3ffMstNa+vrEVzDJ6B698JCA8BJnFvML/EhF
        0cFP3ISu3Rf44VhhBU9yZks=
X-Google-Smtp-Source: ABdhPJzqzGy4ZoICrUJBkf5gxu6S47uboiH2IPeK8+Or3r4y4ewf+rFxOxSEHvZY+AaKxiY7KtWy+A==
X-Received: by 2002:a05:6830:25ce:: with SMTP id d14mr30899783otu.87.1629778206646;
        Mon, 23 Aug 2021 21:10:06 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id i19sm3922818ooe.44.2021.08.23.21.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 21:10:06 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lee.jones@linaro.org, robh+dt@kernel.org, heiko@sntech.de,
        sre@kernel.org, maccraft123mc@gmail.com,
        devicetree@vger.kernel.org, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v4 4/4] arm64: dts: rockchip: add rk817 charger to Odroid Go Advance
Date:   Mon, 23 Aug 2021 23:09:55 -0500
Message-Id: <20210824040955.29112-5-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210824040955.29112-1-macroalpha82@gmail.com>
References: <20210824040955.29112-1-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

Add the new rk817 charger driver to the Odroid Go Advance. Create a
monitored battery node as well for the charger to use. All values
from monitored battery are gathered from the BSP kernel for the
Odroid Go Advance provided by HardKernel.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
---
 .../boot/dts/rockchip/rk3326-odroid-go2.dts   | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
index 7fc674a99a6c..aff8d0768c5a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
@@ -52,6 +52,25 @@ backlight: backlight {
 		pwms = <&pwm1 0 25000 0>;
 	};
 
+	battery_cell: battery-cell {
+		compatible = "simple-battery";
+		charge-full-design-microamp-hours = <3000000>;
+		charge-term-current-microamp = <300000>;
+		constant-charge-current-max-microamp = <2000000>;
+		constant-charge-voltage-max-microvolt = <4200000>;
+		factory-internal-resistance-micro-ohms = <180000>;
+		voltage-max-design-microvolt = <4100000>;
+		voltage-min-design-microvolt = <3500000>;
+
+		ocv-capacity-celsius = <20>;
+		ocv-capacity-table-0 =	<4106000 100>, <4071000 95>, <4018000 90>, <3975000 85>,
+					<3946000 80>, <3908000 75>, <3877000 70>, <3853000 65>,
+					<3834000 60>, <3816000 55>, <3802000 50>, <3788000 45>,
+					<3774000 40>, <3760000 35>, <3748000 30>, <3735000 25>,
+					<3718000 20>, <3697000 15>, <3685000 10>, <3625000 5>,
+					<3500000 0>;
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
@@ -462,6 +481,13 @@ regulator-state-mem {
 			};
 		};
 
+		rk817_battery: battery {
+			monitored-battery = <&battery_cell>;
+			rockchip,resistor-sense-micro-ohms = <10000>;
+			rockchip,sleep-enter-current-microamp = <300000>;
+			rockchip,sleep-filter-current-microamp = <100000>;
+		};
+
 		rk817_codec: codec {
 			rockchip,mic-in-differential;
 		};
-- 
2.25.1

