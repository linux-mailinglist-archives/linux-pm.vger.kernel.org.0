Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 733043D6726
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jul 2021 21:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbhGZSVW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Jul 2021 14:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbhGZSVU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jul 2021 14:21:20 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967F2C061760
        for <linux-pm@vger.kernel.org>; Mon, 26 Jul 2021 12:01:48 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id x15-20020a05683000cfb02904d1f8b9db81so10926437oto.12
        for <linux-pm@vger.kernel.org>; Mon, 26 Jul 2021 12:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vZfHRgT3Nz1lZYd7karZdl8CVKgaGTnZLjBxunPxNVw=;
        b=PNOfy3Hm9aXJEig+isQo3IM60LQrOlNBuPH4HHe+eTLZyHaDKOpmKItM3UUwwdXU8m
         PxJm3GU3oWHf2xM/DjGTjUEya1YOAXwdEjPhN9HvcV9eP7aJDCWmQYABzi8E/zaDcnfn
         Fv6ZGZiJNuRIW8g/7/KZdFTL/0VuZLZDhnWqXKgRjk3rsPG0ZD9sgNeXuSSaZLpf4z3u
         BrrefWncHg+temdILD1BkzmCOis1pBWbWiCSNdf0XSZQdsIkwlmJmS6cXXbSfdiGLtyr
         Jm+g7mCrzI1RrNw9y1E0B6LxCFpiWzhkyQN4mtzjIToJYG5rpbXNyl1biRIQItMtDFaR
         /29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vZfHRgT3Nz1lZYd7karZdl8CVKgaGTnZLjBxunPxNVw=;
        b=AcYS6YOSF4jjsN7IokOsqpqUBatnQ7uTjGhXoVvkHNaGZN3NuJ690asb2bTQF83ur+
         gpzTVj2MqM/3VVBuAOlnCSEX3+lz0AER1XBKnJcOtRAEUqCs6ztYwlzYnO7jSGQAt0ZV
         ey8Ll9G65fcDJaOFYr/yjJ7oYbi2iDEcV6jBdb0SdbBwLq96mS4W4SYasTmgUkgKx06n
         MsrXNNUZtICuFg5Xy4cmbvZxYFyqLxxZ35kRxYxH4bCScKEyRIjGvYrTyXZnLSoRN3dR
         fo6qSVUwNoAgMT36Acc5zcqr6QNMcqsHYsVIo97MLRPgRWU+1JoetLvSCYYNWnlt3pBN
         bElA==
X-Gm-Message-State: AOAM533S21vpjq4Ct7pnYHamF02X4hhDsU0el50pliW34o9T7coqvKLZ
        3hnuyXi8PAE89m+eFvr6uWiCEA7HZLA=
X-Google-Smtp-Source: ABdhPJxXNYp3ueyrRFGE3rLDg2ezTp+nMBK/elezfPDGJqQc4RY2bdb4DQU7t87TXRF3yoyeLwgyQg==
X-Received: by 2002:a9d:550c:: with SMTP id l12mr1495048oth.169.1627326107547;
        Mon, 26 Jul 2021 12:01:47 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id v7sm106610ooj.46.2021.07.26.12.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 12:01:47 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, maccraft123mc@gmail.com,
        sre@kernel.org, heiko@sntech.de, robh+dt@kernel.org,
        lee.jones@linaro.org, Chris Morgan <macromorgan@hotmail.com>
Subject: [RFC v2 4/4] arm64: dts: rockchip: add rk817 charger to Odroid Go Advance
Date:   Mon, 26 Jul 2021 14:01:30 -0500
Message-Id: <20210726190130.1973-5-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210726190130.1973-1-macroalpha82@gmail.com>
References: <20210726190130.1973-1-macroalpha82@gmail.com>
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
index 7fc674a99a6c..333bcf8da450 100644
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
+			rockchip,resistor-sense = <10000>;
+			rockchip,sleep-enter-current = <300000>;
+			rockchip,sleep-filter-current = <100000>;
+		};
+
 		rk817_codec: codec {
 			rockchip,mic-in-differential;
 		};
-- 
2.25.1

