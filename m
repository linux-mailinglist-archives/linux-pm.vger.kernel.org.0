Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14FEC33A6E0
	for <lists+linux-pm@lfdr.de>; Sun, 14 Mar 2021 17:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234386AbhCNQsm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 14 Mar 2021 12:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbhCNQsV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 14 Mar 2021 12:48:21 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F40C061574;
        Sun, 14 Mar 2021 09:48:20 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id f16so13406947ljm.1;
        Sun, 14 Mar 2021 09:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1kQEK+vDmG5FfSSdZGh9UANwHmQxe+AZ4HqIwt9hQtI=;
        b=dc/6Fwhy3kw5Z9ai/K8bW7qJnYlrvuVaIOC0Dp4yNxtGq1ld7NzSmoLh2ZZl8TSjNb
         z/FNMTxxI5GHQqaPQJ9DPIfrt0Vb+qnbHWhzi2rzMHhk5T6OqeY2l5H5B7hbTaJECQ3Z
         KY9vhhibKtPC2SuX26tYqCnNVltygSKcSjir/77XQw58pXVD57BDPVxMxSMdK9ejLiju
         4YLKrbzMu10bH/e5Je811ldTiutyGkpC9Nr9EIYoHz4a/3EmvPo+OOjEqE6HannlQhZJ
         Vsu+D6XUuWwI7aXHMOnhnRMKipaTtpfE+/pX58Z/Pi4sh+LFvTtsUrKHUbbaJjKJ3h89
         c97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1kQEK+vDmG5FfSSdZGh9UANwHmQxe+AZ4HqIwt9hQtI=;
        b=WihCU/UZpw1KH5vjh6qkRU7LfeM9OUu9YEPMjtBfogHwY1qTPAwzgsaRHWnJ5/OlUo
         pxA9He9hEp5KyuhZBTy/0DXEgR7mSnF4wu+TY4DOpot6OTxroamNSh4hnPLEUHw1TlWa
         7vPSWYBqUS3h3HKl1EJBAhx6O86sgkSzo8GaSyftAZte7LBV1EKB/+XT7HHYb1tlxFJx
         RR0WPGyWsXvJ7Zidh8nMSdnJbqEePYgF1kJQT9uy3K0aiybOBFiZFgDiUBNouRGbuwtO
         8G3HHdvujWI8lOpwx39Q1msHY5yytuA2MrKBBqXceg3UFQSiWP60HVhkhxHgY0AKAB+3
         LVHg==
X-Gm-Message-State: AOAM532KoWtjRBRIRVj5poj0HFi1bxtv6F+YI2OyT0ms+IOaKDlCCAIR
        BsJQAdCxxCAm/gqRj85t3s8=
X-Google-Smtp-Source: ABdhPJxONkqWJ0U9m/Tf7dewWR5YbxKsmfN40vxRK+2lG7TkT946V5VUWBNPC6CTkgXg8YRb35O7qQ==
X-Received: by 2002:a2e:9704:: with SMTP id r4mr8096948lji.486.1615740499177;
        Sun, 14 Mar 2021 09:48:19 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id a3sm2387993lfr.55.2021.03.14.09.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 09:48:18 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Paul Fertser <fercerpav@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/6] soc/tegra: Add CONFIG_SOC_TEGRA_COMMON and select PM_OPP by default
Date:   Sun, 14 Mar 2021 19:48:06 +0300
Message-Id: <20210314164810.26317-3-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210314164810.26317-1-digetx@gmail.com>
References: <20210314164810.26317-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add new Kconfig SOC_TEGRA_COMMON option which selects configuration
options that are common for all Tegra SoCs. Select PM_OPP by default
since from now on OPPs will be used by Tegra drivers which present on
all SoC generations, like display controller driver for example.

Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
Tested-by: Paul Fertser <fercerpav@gmail.com> # PAZ00 T20
Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20 and TK1 T124
Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/Kconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/soc/tegra/Kconfig b/drivers/soc/tegra/Kconfig
index 976dee036470..bcd61ae59ba3 100644
--- a/drivers/soc/tegra/Kconfig
+++ b/drivers/soc/tegra/Kconfig
@@ -13,6 +13,7 @@ config ARCH_TEGRA_2x_SOC
 	select PINCTRL_TEGRA20
 	select PL310_ERRATA_727915 if CACHE_L2X0
 	select PL310_ERRATA_769419 if CACHE_L2X0
+	select SOC_TEGRA_COMMON
 	select SOC_TEGRA_FLOWCTRL
 	select SOC_TEGRA_PMC
 	select SOC_TEGRA20_VOLTAGE_COUPLER
@@ -27,6 +28,7 @@ config ARCH_TEGRA_3x_SOC
 	select ARM_ERRATA_764369 if SMP
 	select PINCTRL_TEGRA30
 	select PL310_ERRATA_769419 if CACHE_L2X0
+	select SOC_TEGRA_COMMON
 	select SOC_TEGRA_FLOWCTRL
 	select SOC_TEGRA_PMC
 	select SOC_TEGRA30_VOLTAGE_COUPLER
@@ -40,6 +42,7 @@ config ARCH_TEGRA_114_SOC
 	select ARM_ERRATA_798181 if SMP
 	select HAVE_ARM_ARCH_TIMER
 	select PINCTRL_TEGRA114
+	select SOC_TEGRA_COMMON
 	select SOC_TEGRA_FLOWCTRL
 	select SOC_TEGRA_PMC
 	select TEGRA_TIMER
@@ -51,6 +54,7 @@ config ARCH_TEGRA_124_SOC
 	bool "Enable support for Tegra124 family"
 	select HAVE_ARM_ARCH_TIMER
 	select PINCTRL_TEGRA124
+	select SOC_TEGRA_COMMON
 	select SOC_TEGRA_FLOWCTRL
 	select SOC_TEGRA_PMC
 	select TEGRA_TIMER
@@ -66,6 +70,7 @@ if ARM64
 config ARCH_TEGRA_132_SOC
 	bool "NVIDIA Tegra132 SoC"
 	select PINCTRL_TEGRA124
+	select SOC_TEGRA_COMMON
 	select SOC_TEGRA_FLOWCTRL
 	select SOC_TEGRA_PMC
 	help
@@ -77,6 +82,7 @@ config ARCH_TEGRA_132_SOC
 config ARCH_TEGRA_210_SOC
 	bool "NVIDIA Tegra210 SoC"
 	select PINCTRL_TEGRA210
+	select SOC_TEGRA_COMMON
 	select SOC_TEGRA_FLOWCTRL
 	select SOC_TEGRA_PMC
 	select TEGRA_TIMER
@@ -99,6 +105,7 @@ config ARCH_TEGRA_186_SOC
 	select TEGRA_BPMP
 	select TEGRA_HSP_MBOX
 	select TEGRA_IVC
+	select SOC_TEGRA_COMMON
 	select SOC_TEGRA_PMC
 	help
 	  Enable support for the NVIDIA Tegar186 SoC. The Tegra186 features a
@@ -115,6 +122,7 @@ config ARCH_TEGRA_194_SOC
 	select TEGRA_BPMP
 	select TEGRA_HSP_MBOX
 	select TEGRA_IVC
+	select SOC_TEGRA_COMMON
 	select SOC_TEGRA_PMC
 	help
 	  Enable support for the NVIDIA Tegra194 SoC.
@@ -125,6 +133,7 @@ config ARCH_TEGRA_234_SOC
 	select TEGRA_BPMP
 	select TEGRA_HSP_MBOX
 	select TEGRA_IVC
+	select SOC_TEGRA_COMMON
 	select SOC_TEGRA_PMC
 	help
 	  Enable support for the NVIDIA Tegra234 SoC.
@@ -132,6 +141,10 @@ config ARCH_TEGRA_234_SOC
 endif
 endif
 
+config SOC_TEGRA_COMMON
+	bool
+	select PM_OPP
+
 config SOC_TEGRA_FUSE
 	def_bool y
 	depends on ARCH_TEGRA
-- 
2.30.2

