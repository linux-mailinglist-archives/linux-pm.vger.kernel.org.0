Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D04F401AE9
	for <lists+linux-pm@lfdr.de>; Mon,  6 Sep 2021 14:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241558AbhIFMGq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Sep 2021 08:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241425AbhIFMGo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Sep 2021 08:06:44 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35C4C061575;
        Mon,  6 Sep 2021 05:05:36 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id n27so13077788eja.5;
        Mon, 06 Sep 2021 05:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1jSWxQD3ZakGUw6t3PqAHw4n2IXaSLh4ZsA1sASlt9o=;
        b=kIMOOeXQwVNBwDAWMehjWUBA1cnNcm/6CMVB3Y2jTJNPEMNK/XYcBwrw9aSidnM618
         bwC6jQp7CqXN/7J2CJtBh3byoNxv/o4m7kipxXXr3X/8O0QjIZwaI9gjDskvKOmJPSq7
         Un0Sx3lAYjfM88gkbhtVC4Au1c1rLuYIe1WMW5law0+SKko8xarqNsEIuCS5BbT64150
         jYzKIpmlkhsRwcd4wL1elJm9btpPX3NrfLE1OSCt5Ob2zT9Mp1PAmFRPAsDMGnZGlVOg
         UbTk1n2DMBOoRzKqVot5eggpLzg/dV7JTqjD3hodrGZDbmIm97dn/VNJLi1zahE9gV8l
         AUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1jSWxQD3ZakGUw6t3PqAHw4n2IXaSLh4ZsA1sASlt9o=;
        b=gVL36EEwKMhCzWYdDWDnxAVt3DTKcWa/1egilPEIBBpgm5JPCo/Lw93CHnuOMUNA9k
         XSHYcnLl4S744cc0BKRSid1k6PIz2xKmVJj9PKaVTtipJ5+h8yrq+kCBTbSphBLLaiFp
         rJ8uTEOREBKvxm+FAkq7XGLROeN8MAJXc86oJPMTOoR8IzewMEYnObdNoHjZXkSzenjI
         iDuqNU+hQCtX6HiEo6a2100cVBpx0cyD0bRutCkhHpDziEf1LVR/xAfpY+aQBcBgPGSh
         TYIYJSHvsFiwSaneZfTONv3D9LYeMEflGOPtLiMf3Yo+JlfJPskHVVHyvGVmVxyDJG+s
         hdvw==
X-Gm-Message-State: AOAM533uh17LnEienaRE86sPI/OvHdLvPqDsm/vQ4obaTWOYtZ/1AjQN
        I7lf5SK5G8sNhWOyohbd4VOgkjOH2CJY/QpX
X-Google-Smtp-Source: ABdhPJy/cwcqasiNdqkpW55WGrmKCcwe3js4BRGA8fMxCasOSDxAnSs05DUepDolnR8WgP9eoctUOA==
X-Received: by 2002:a17:906:3497:: with SMTP id g23mr13250953ejb.85.1630929935384;
        Mon, 06 Sep 2021 05:05:35 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id b8sm4536954edv.96.2021.09.06.05.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 05:05:35 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org, p.zabel@pengutronix.de, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/4] arm64: dts: fix resets in tsadc node for rk356x.dtsi
Date:   Mon,  6 Sep 2021 14:04:04 +0200
Message-Id: <20210906120404.10005-4-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210906120404.10005-1-jbx6244@gmail.com>
References: <20210906120404.10005-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In the rockchip_thermal.c driver we now get the resets with
a devm_reset_control_array_get() function, so remove
the reset-names property as it is no longer needed.
Although no longer required in rockchip-thermal.yaml
sort tsadc-apb as first item.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index d89831bee..2dc997eff 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -837,9 +837,8 @@
 		assigned-clock-rates = <17000000>, <700000>;
 		clocks = <&cru CLK_TSADC>, <&cru PCLK_TSADC>;
 		clock-names = "tsadc", "apb_pclk";
-		resets = <&cru SRST_TSADC>, <&cru SRST_P_TSADC>,
+		resets = <&cru SRST_P_TSADC>, <&cru SRST_TSADC>,
 			 <&cru SRST_TSADCPHY>;
-		reset-names = "tsadc", "tsadc-apb", "tsadc-phy";
 		rockchip,grf = <&grf>;
 		rockchip,hw-tshut-temp = <95000>;
 		pinctrl-names = "init", "default", "sleep";
-- 
2.20.1

