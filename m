Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6EC27A193
	for <lists+linux-pm@lfdr.de>; Sun, 27 Sep 2020 17:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgI0PKG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Sep 2020 11:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgI0PKF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Sep 2020 11:10:05 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955F6C0613CE;
        Sun, 27 Sep 2020 08:10:05 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id d4so3863377wmd.5;
        Sun, 27 Sep 2020 08:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JiAbE/SJFaiXXWha+UZiz5ngLuS7vuLVdaMJTivRPyQ=;
        b=ODbXkF8Wh1TzUQoRi7zRknzD3nNTxIGB3PW+ys8JVNIYjnfREoYrXLT3qQtKDX23H7
         SOu59Mi0HQKNKikKQYyah8dkhgbCDry751o5vmGorza8MTtj8FN6wtKhvLyNujPJNtlP
         32tP49HJM0zyqugzgb3jGNq/Ngpjsd1C4DELu7ss7B8gIdejQe7WzThXzfjwwTkIcFaW
         zhVPySMBfAl2J2aT7xLBGpH3BU8RHwbi60wH0yLI0p0XkcnC5NfjBXupTusSU7051ZLN
         mHQLM/W14tpCx/fxNOiIKNhEHIkFLAz8MqnhenTUn6yk4uG1yFbL5d+vM0qkiUEIOveN
         ALGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JiAbE/SJFaiXXWha+UZiz5ngLuS7vuLVdaMJTivRPyQ=;
        b=MSM/lQUUn87XKs6+ym3arq0h1+YxukDFzQj1y69pof8y8JX3NAqixCKRQLb57vvHWU
         W9LilzUcR2YCWyI7VPOHT6FB8gl+OI6INNMaGt9sYZXHde0y1sSDLCmTDfLqY6uHdIFq
         oOvPAK+Ps+8gyt94exfOj7YeUZD8xaHsSwVO92W6ishHTQ7gzwIf6XRyruQjv90B43G9
         XTlzk78GbuStGvtTGIvPd7DE+m1G9hs0O6MiJwyf+mniddKM4dP5fMM53tEIOI7AIwf2
         bq4uSUCGu6Sq5rGrYTmdpyJQu7+JdkZu0p8hZj2UZQAR+7aknBrk1/TNMX4VbcYqgQrr
         qerg==
X-Gm-Message-State: AOAM5303/QJXnBa4mNFxJ1W5mXssYsDISLARlz3Wup3BORi1mWY3AVxP
        9h0gCkIm09ng/nDIs3u83QAmDp5YHQXF9uGR
X-Google-Smtp-Source: ABdhPJxRhKwmnznqBlQCmvDqbFbox2+Y4y4DbRbccIs4gUeOyJjheF4paOvjtzZ6VPFySdoMDTpkBA==
X-Received: by 2002:a1c:2903:: with SMTP id p3mr7569765wmp.170.1601219404304;
        Sun, 27 Sep 2020 08:10:04 -0700 (PDT)
Received: from arrakis.kwizart.net (lfbn-nic-1-212-171.w2-15.abo.wanadoo.fr. [2.15.59.171])
        by smtp.gmail.com with ESMTPSA id s11sm9565114wrt.43.2020.09.27.08.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 08:10:03 -0700 (PDT)
From:   Nicolas Chauvet <kwizart@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        Nicolas Chauvet <kwizart@gmail.com>
Subject: [PATCH v2 3/6] arm64: tegra: Add missing hot temperatures to tegra132 thermal-zones
Date:   Sun, 27 Sep 2020 17:09:53 +0200
Message-Id: <20200927150956.34609-4-kwizart@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200927150956.34609-1-kwizart@gmail.com>
References: <20200927150956.34609-1-kwizart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

According to dmesg, thermal-zones for mem and cpu are missing hot
temperatures properties.

  throttrip: pll: missing hot temperature
...
  throttrip: mem: missing hot temperature
...

Adding them will clear the messages.

Signed-off-by: Nicolas Chauvet <kwizart@gmail.com>
---
 arch/arm64/boot/dts/nvidia/tegra132.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra132.dtsi b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
index e40281510c0c..cd913e59ba26 100644
--- a/arch/arm64/boot/dts/nvidia/tegra132.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
@@ -925,6 +925,11 @@ mem_shutdown_trip {
 					hysteresis = <1000>;
 					type = "critical";
 				};
+				mem_throttle_trip {
+					temperature = <99000>;
+					hysteresis = <1000>;
+					type = "hot";
+				};
 			};
 
 			cooling-maps {
@@ -975,6 +980,11 @@ pllx_shutdown_trip {
 					hysteresis = <1000>;
 					type = "critical";
 				};
+				pllx_throttle_trip {
+					temperature = <99000>;
+					hysteresis = <1000>;
+					type = "hot";
+				};
 			};
 
 			cooling-maps {
-- 
2.25.4

