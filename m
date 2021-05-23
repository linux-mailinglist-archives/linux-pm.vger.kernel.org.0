Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E99938DDDE
	for <lists+linux-pm@lfdr.de>; Mon, 24 May 2021 01:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbhEWXPd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 May 2021 19:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbhEWXP0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 May 2021 19:15:26 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7944EC061347;
        Sun, 23 May 2021 16:13:56 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id v5so31100340ljg.12;
        Sun, 23 May 2021 16:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CLef4wehN1atwulqXH4JMD3Wb9mRwmm7RCBYkfihR6M=;
        b=q8OE32ksRKGosCK+LYF50KZjWnr4BrTkG5NV8DsISyPFTjW1Cb8NkdrK6ZCx6tgbEl
         UnU/FZ8ZJDvL0GMMRWyc3Htcij3DIwXBN3Kc0wn+/RV0q6b67Ur7Q5Exdgc0+kC69vSR
         h6HeW4RT8LT9vGTFonXK3ZzVolLa2IDXH3xW0G1IHvRo5DYyYQC/0D8SlFpw/8Vg5wTd
         538KwkzEbNvLqJ2Yb2u3VbBIlNC/vD9app/a4aFk2LPe26x/lvw7mbt9gTD2x/0qGfuU
         xfYv+p6OEBag117vzQcrVJTw4ESv/nud0Zvqq89etQIWy8P4JL0D5apK8pwpVyrn+LtZ
         zDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CLef4wehN1atwulqXH4JMD3Wb9mRwmm7RCBYkfihR6M=;
        b=k5MmmLeY/d+kW2p8qCVBHe0kk67MbfuduI6grc/XFowizNnrlv1LSG9xGe40lMjujJ
         dzf7Bnr1VnIK0c52oq0SIuGo5JyMuO93jpw1uZJwcuxTDT36m+RWfsSpUffaKMyU9lUx
         Cgm5pJwf0jiUlvcXO87NLRhlzeomeLmHp0ZZVpQ9zNnDXq83qDeNd+IY+Hay0KXfQ9fR
         bs8Dmo9PNhwBoyyhdFfwkzqjAP8JhiM1IIGCrpHP2M2gw2pC2EdoKomyueDtyegtbw0+
         a/Un3ICarbMQ1Hcyf5pUofBNmpA/N1WFnw9v4XN0joeCvKXLLcPUGuHYxY5dvnFiT8jk
         k3gQ==
X-Gm-Message-State: AOAM530KNb1X1YmY90tAFafgdPFX5J4jgCtbMueFLrsaeCjD+e9H9r1i
        iijCwp1g0QBhZf/fpWaxMDc=
X-Google-Smtp-Source: ABdhPJxiz2PloL72xwJdy9pO4Q4QoVOcgdof3BrnKDqrKhXw6F30BZ3Lz2JMCTBt7Ow7TeHQ36hn3Q==
X-Received: by 2002:a05:651c:1316:: with SMTP id u22mr15284197lja.197.1621811634864;
        Sun, 23 May 2021 16:13:54 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-110.dynamic.spd-mgts.ru. [109.252.193.110])
        by smtp.gmail.com with ESMTPSA id p7sm1268619lfr.184.2021.05.23.16.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 16:13:54 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        =?UTF-8?q?Nikola=20Milosavljevi=C4=87?= <mnidza@outlook.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Paul Fertser <fercerpav@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        linux-clk@vger.kernel.org
Subject: [PATCH v2 09/14] memory: tegra: Enable compile testing for all drivers
Date:   Mon, 24 May 2021 02:13:30 +0300
Message-Id: <20210523231335.8238-10-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210523231335.8238-1-digetx@gmail.com>
References: <20210523231335.8238-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enable compile testing for all Tegra memory drivers.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/Kconfig | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/memory/tegra/Kconfig b/drivers/memory/tegra/Kconfig
index a70967a56e52..c63ffa74ab94 100644
--- a/drivers/memory/tegra/Kconfig
+++ b/drivers/memory/tegra/Kconfig
@@ -2,16 +2,18 @@
 config TEGRA_MC
 	bool "NVIDIA Tegra Memory Controller support"
 	default y
-	depends on ARCH_TEGRA
+	depends on ARCH_TEGRA || COMPILE_TEST
 	select INTERCONNECT
 	help
 	  This driver supports the Memory Controller (MC) hardware found on
 	  NVIDIA Tegra SoCs.
 
+if TEGRA_MC
+
 config TEGRA20_EMC
 	tristate "NVIDIA Tegra20 External Memory Controller driver"
 	default y
-	depends on TEGRA_MC && ARCH_TEGRA_2x_SOC
+	depends on ARCH_TEGRA_2x_SOC || COMPILE_TEST
 	select DEVFREQ_GOV_SIMPLE_ONDEMAND
 	select PM_DEVFREQ
 	help
@@ -23,7 +25,7 @@ config TEGRA20_EMC
 config TEGRA30_EMC
 	tristate "NVIDIA Tegra30 External Memory Controller driver"
 	default y
-	depends on TEGRA_MC && ARCH_TEGRA_3x_SOC
+	depends on ARCH_TEGRA_3x_SOC || COMPILE_TEST
 	select PM_OPP
 	help
 	  This driver is for the External Memory Controller (EMC) found on
@@ -34,8 +36,8 @@ config TEGRA30_EMC
 config TEGRA124_EMC
 	tristate "NVIDIA Tegra124 External Memory Controller driver"
 	default y
-	depends on TEGRA_MC && ARCH_TEGRA_124_SOC
-	select TEGRA124_CLK_EMC
+	depends on ARCH_TEGRA_124_SOC || COMPILE_TEST
+	select TEGRA124_CLK_EMC if ARCH_TEGRA
 	select PM_OPP
 	help
 	  This driver is for the External Memory Controller (EMC) found on
@@ -49,10 +51,12 @@ config TEGRA210_EMC_TABLE
 
 config TEGRA210_EMC
 	tristate "NVIDIA Tegra210 External Memory Controller driver"
-	depends on TEGRA_MC && ARCH_TEGRA_210_SOC
+	depends on ARCH_TEGRA_210_SOC || COMPILE_TEST
 	select TEGRA210_EMC_TABLE
 	help
 	  This driver is for the External Memory Controller (EMC) found on
 	  Tegra210 chips. The EMC controls the external DRAM on the board.
 	  This driver is required to change memory timings / clock rate for
 	  external memory.
+
+endif
-- 
2.30.2

