Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60AF3753653
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jul 2023 11:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235138AbjGNJXL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jul 2023 05:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234778AbjGNJXJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jul 2023 05:23:09 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1DE2D75
        for <linux-pm@vger.kernel.org>; Fri, 14 Jul 2023 02:23:06 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b703cbfaf5so24827531fa.1
        for <linux-pm@vger.kernel.org>; Fri, 14 Jul 2023 02:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689326584; x=1691918584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vVGIh/G1FqIKf0a/bpvjazsarPyTwft+F9eTqVTyiQc=;
        b=g7AZhihssoVkwwcW1zRMw8UNCnt0tk5GUeIYCybVh2YFDbt4LOJg0YB6PJ5wfgaUdi
         620Nku51QIxXhyzsF4PvFkbZAVdlOWcHlE9zQyYHtaDrysnjjc50E3eWLy3SETK/d47z
         z+9mT43tT0okBTaRA7oGLCMmIX3/w3IacTqajfuEtifpFfe/6X0CKQroF1L+7xKF+P1C
         WdShy9BjiHOk8ey6O447eo5QIXJJnAP+s0YyNX28vda64rKMs8n428Rdu/jhDcR14Qb8
         pGxRD46FAvjciOXKwYjvaYeATqEzScmFl/gl59ZOjXNWk8HIBkWEgYCMq/1Qq/BXt/oe
         SHzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689326584; x=1691918584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vVGIh/G1FqIKf0a/bpvjazsarPyTwft+F9eTqVTyiQc=;
        b=LUndC9ZqXOILKoENwtS3VirmUtICsuZM7mqacX/odL94fkIWxJKajuQVWgrsonX4MJ
         b8Uhd7USbGeeorlG6bsmfewozm7x2hUbGbrukgoC5ctPfTLWR09xV2XJR1MV+IXogwBp
         hfvNrdUlwYLGl6IU9oV06NlrRAzdmaYWjcfyBEZw7m6GcDqzI2S8gdIPr9ZZ1q9YhemP
         aqRQ/nA/kdNbghSf08/NoRtffxHrlllTx8eFdv8L3k5W/wxmBk/x71EcCu+Sd0iWalk0
         1xAzgUL6XO80u59Iw6FiwTdKDdnnE6HQCf1kp5Fd/Y+UQPZj+cW5CZ5j4H31MSV8ykZf
         r7gA==
X-Gm-Message-State: ABy/qLYoLRaB7bShVzFgnQ04pCwIuWekgtjHot7dtqjBtwiB5YbHpDf0
        OI3HoDGwqan5qVtJR8CRlx+aBw==
X-Google-Smtp-Source: APBJJlFHP+/p/WdyPHMNpUbubeLtkCIgr0z3wIRmyCu2YfhF46KiNr/v7q/0cYgxKTSlRpBrBiiE/g==
X-Received: by 2002:a2e:9092:0:b0:2b6:c394:91dd with SMTP id l18-20020a2e9092000000b002b6c39491ddmr3371295ljg.10.1689326584506;
        Fri, 14 Jul 2023 02:23:04 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id t24-20020a2e9c58000000b002b6c5bbc9aesm1876908ljj.91.2023.07.14.02.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 02:23:03 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, arm@kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@amd.com>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Walker Chen <walker.chen@starfivetech.com>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andreas Farber <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] Create the new genpd subsystem and start moving providers
Date:   Fri, 14 Jul 2023 11:23:01 +0200
Message-Id: <20230714092301.28690-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi SoC maintainers,

Here's a PR that creates a new genpd subsystem at drivers/genpd/ and moves most
of the genpd providers from drivers/soc/ and arch/arm/ into the new directory.

It looks like some platform maintainers may need to pull this too, especially to
avoid conflicts in linux-next. Therefore I have also made this available at an
immutable branch, see below.

git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git genpd_create_dir

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/genpd-v6.5-rc1-1

for you to fetch changes up to b43f11e5b453a9c48159d7121c88d79d81901276:

  ARM: ux500: Move power-domain driver to the genpd dir (2023-07-14 10:41:59 +0200)

----------------------------------------------------------------
Create the new genpd subsystem and start moving providers

There are currently ~60 users of the genpd provider interface, which
implementations are sprinkled across various subsystems. To help out with
maintenance and to gain a bit better control, this creates a new subsystem
(drivers/genpd) and moves some of the soc/platform specific providers in
here.

----------------------------------------------------------------
Ulf Hansson (18):
      genpd: Create a new subsystem directory to host genpd providers
      soc: actions: Move power-domain driver to the genpd dir
      soc: amlogic: Move power-domain drivers to the genpd dir
      soc: apple: Move power-domain driver to the genpd dir
      soc: bcm: Move power-domain drivers to the genpd dir
      soc: imx: Move power-domain drivers to the genpd dir
      soc: mediatek: Move power-domain drivers to the genpd dir
      soc: qcom: Move power-domain drivers to the genpd dir
      soc: renesas: Move power-domain drivers to the genpd dir
      soc: rockchip: Mover power-domain driver to the genpd dir
      soc: samsung: Move power-domain driver to the genpd dir
      soc: starfive: Move the power-domain driver to the genpd dir
      soc: sunxi: Move power-domain driver to the genpd dir
      soc: tegra: Move powergate-bpmp driver to the genpd dir
      soc: ti: Mover power-domain drivers to the genpd dir
      soc: xilinx: Move power-domain driver to the genpd dir
      ARM: ux500: Convert power-domain code into a regular platform driver
      ARM: ux500: Move power-domain driver to the genpd dir

 MAINTAINERS                                        | 22 ++++++++++++----
 arch/arm/mach-ux500/Makefile                       |  1 -
 arch/arm/mach-ux500/cpu-db8500.c                   |  5 ----
 arch/arm/mach-ux500/pm_domains.h                   | 17 ------------
 drivers/Makefile                                   |  1 +
 drivers/genpd/Makefile                             | 16 ++++++++++++
 drivers/genpd/actions/Makefile                     |  2 ++
 drivers/{soc => genpd}/actions/owl-sps.c           |  0
 drivers/genpd/amlogic/Makefile                     |  4 +++
 drivers/{soc => genpd}/amlogic/meson-ee-pwrc.c     |  0
 drivers/{soc => genpd}/amlogic/meson-gx-pwrc-vpu.c |  0
 drivers/{soc => genpd}/amlogic/meson-secure-pwrc.c |  0
 drivers/genpd/apple/Makefile                       |  2 ++
 .../apple/pmgr-pwrstate.c}                         |  0
 drivers/genpd/bcm/Makefile                         |  5 ++++
 drivers/{soc/bcm/bcm63xx => genpd/bcm}/bcm-pmb.c   |  0
 drivers/{soc => genpd}/bcm/bcm2835-power.c         |  0
 .../{soc/bcm/bcm63xx => genpd/bcm}/bcm63xx-power.c |  0
 drivers/{soc => genpd}/bcm/raspberrypi-power.c     |  0
 drivers/genpd/imx/Makefile                         |  7 +++++
 drivers/{soc => genpd}/imx/gpc.c                   |  0
 drivers/{soc => genpd}/imx/gpcv2.c                 |  0
 drivers/{soc => genpd}/imx/imx8m-blk-ctrl.c        |  0
 drivers/{soc => genpd}/imx/imx8mp-blk-ctrl.c       |  0
 drivers/{soc => genpd}/imx/imx93-blk-ctrl.c        |  0
 drivers/{soc => genpd}/imx/imx93-pd.c              |  0
 drivers/genpd/mediatek/Makefile                    |  3 +++
 .../{soc => genpd}/mediatek/mt6795-pm-domains.h    |  0
 .../{soc => genpd}/mediatek/mt8167-pm-domains.h    |  0
 .../{soc => genpd}/mediatek/mt8173-pm-domains.h    |  0
 .../{soc => genpd}/mediatek/mt8183-pm-domains.h    |  0
 .../{soc => genpd}/mediatek/mt8186-pm-domains.h    |  0
 .../{soc => genpd}/mediatek/mt8188-pm-domains.h    |  0
 .../{soc => genpd}/mediatek/mt8192-pm-domains.h    |  0
 .../{soc => genpd}/mediatek/mt8195-pm-domains.h    |  0
 drivers/{soc => genpd}/mediatek/mtk-pm-domains.c   |  0
 drivers/{soc => genpd}/mediatek/mtk-pm-domains.h   |  0
 drivers/{soc => genpd}/mediatek/mtk-scpsys.c       |  0
 drivers/genpd/qcom/Makefile                        |  4 +++
 drivers/{soc => genpd}/qcom/cpr.c                  |  0
 drivers/{soc => genpd}/qcom/rpmhpd.c               |  0
 drivers/{soc => genpd}/qcom/rpmpd.c                |  0
 drivers/genpd/renesas/Makefile                     | 30 ++++++++++++++++++++++
 drivers/{soc => genpd}/renesas/r8a7742-sysc.c      |  0
 drivers/{soc => genpd}/renesas/r8a7743-sysc.c      |  0
 drivers/{soc => genpd}/renesas/r8a7745-sysc.c      |  0
 drivers/{soc => genpd}/renesas/r8a77470-sysc.c     |  0
 drivers/{soc => genpd}/renesas/r8a774a1-sysc.c     |  0
 drivers/{soc => genpd}/renesas/r8a774b1-sysc.c     |  0
 drivers/{soc => genpd}/renesas/r8a774c0-sysc.c     |  0
 drivers/{soc => genpd}/renesas/r8a774e1-sysc.c     |  0
 drivers/{soc => genpd}/renesas/r8a7779-sysc.c      |  0
 drivers/{soc => genpd}/renesas/r8a7790-sysc.c      |  0
 drivers/{soc => genpd}/renesas/r8a7791-sysc.c      |  0
 drivers/{soc => genpd}/renesas/r8a7792-sysc.c      |  0
 drivers/{soc => genpd}/renesas/r8a7794-sysc.c      |  0
 drivers/{soc => genpd}/renesas/r8a7795-sysc.c      |  0
 drivers/{soc => genpd}/renesas/r8a7796-sysc.c      |  0
 drivers/{soc => genpd}/renesas/r8a77965-sysc.c     |  0
 drivers/{soc => genpd}/renesas/r8a77970-sysc.c     |  0
 drivers/{soc => genpd}/renesas/r8a77980-sysc.c     |  0
 drivers/{soc => genpd}/renesas/r8a77990-sysc.c     |  0
 drivers/{soc => genpd}/renesas/r8a77995-sysc.c     |  0
 drivers/{soc => genpd}/renesas/r8a779a0-sysc.c     |  0
 drivers/{soc => genpd}/renesas/r8a779f0-sysc.c     |  0
 drivers/{soc => genpd}/renesas/r8a779g0-sysc.c     |  0
 drivers/{soc => genpd}/renesas/rcar-gen4-sysc.c    |  0
 drivers/{soc => genpd}/renesas/rcar-gen4-sysc.h    |  0
 drivers/{soc => genpd}/renesas/rcar-sysc.c         |  0
 drivers/{soc => genpd}/renesas/rcar-sysc.h         |  0
 drivers/{soc => genpd}/renesas/rmobile-sysc.c      |  0
 drivers/genpd/rockchip/Makefile                    |  2 ++
 .../pm_domains.c => genpd/rockchip/pm-domains.c}   |  0
 drivers/genpd/samsung/Makefile                     |  2 ++
 .../samsung/exynos-pm-domains.c}                   |  0
 drivers/genpd/st/Makefile                          |  2 ++
 .../genpd/st/ste-ux500-pm-domain.c                 | 25 ++++++++++++++----
 drivers/genpd/starfive/Makefile                    |  2 ++
 .../jh71xx_pmu.c => genpd/starfive/jh71xx-pmu.c}   |  0
 drivers/genpd/sunxi/Makefile                       |  2 ++
 drivers/{soc => genpd}/sunxi/sun20i-ppu.c          |  0
 drivers/genpd/tegra/Makefile                       |  2 ++
 drivers/{soc => genpd}/tegra/powergate-bpmp.c      |  0
 drivers/genpd/ti/Makefile                          |  3 +++
 drivers/{soc => genpd}/ti/omap_prm.c               |  0
 drivers/{soc => genpd}/ti/ti_sci_pm_domains.c      |  0
 drivers/genpd/xilinx/Makefile                      |  2 ++
 .../xilinx/zynqmp-pm-domains.c}                    |  0
 drivers/soc/actions/Makefile                       |  1 -
 drivers/soc/amlogic/Makefile                       |  3 ---
 drivers/soc/apple/Makefile                         |  2 --
 drivers/soc/bcm/Kconfig                            | 22 +++++++++++++++-
 drivers/soc/bcm/Makefile                           |  3 ---
 drivers/soc/bcm/bcm63xx/Kconfig                    | 21 ---------------
 drivers/soc/bcm/bcm63xx/Makefile                   |  3 ---
 drivers/soc/imx/Makefile                           |  7 +----
 drivers/soc/mediatek/Makefile                      |  2 --
 drivers/soc/qcom/Makefile                          |  3 ---
 drivers/soc/renesas/Makefile                       | 27 -------------------
 drivers/soc/rockchip/Makefile                      |  1 -
 drivers/soc/samsung/Makefile                       |  1 -
 drivers/soc/starfive/Makefile                      |  3 ---
 drivers/soc/sunxi/Makefile                         |  1 -
 drivers/soc/tegra/Makefile                         |  1 -
 drivers/soc/ti/Makefile                            |  2 --
 drivers/soc/xilinx/Makefile                        |  1 -
 106 files changed, 150 insertions(+), 115 deletions(-)
 delete mode 100644 arch/arm/mach-ux500/pm_domains.h
 create mode 100644 drivers/genpd/Makefile
 create mode 100644 drivers/genpd/actions/Makefile
 rename drivers/{soc => genpd}/actions/owl-sps.c (100%)
 create mode 100644 drivers/genpd/amlogic/Makefile
 rename drivers/{soc => genpd}/amlogic/meson-ee-pwrc.c (100%)
 rename drivers/{soc => genpd}/amlogic/meson-gx-pwrc-vpu.c (100%)
 rename drivers/{soc => genpd}/amlogic/meson-secure-pwrc.c (100%)
 create mode 100644 drivers/genpd/apple/Makefile
 rename drivers/{soc/apple/apple-pmgr-pwrstate.c => genpd/apple/pmgr-pwrstate.c} (100%)
 create mode 100644 drivers/genpd/bcm/Makefile
 rename drivers/{soc/bcm/bcm63xx => genpd/bcm}/bcm-pmb.c (100%)
 rename drivers/{soc => genpd}/bcm/bcm2835-power.c (100%)
 rename drivers/{soc/bcm/bcm63xx => genpd/bcm}/bcm63xx-power.c (100%)
 rename drivers/{soc => genpd}/bcm/raspberrypi-power.c (100%)
 create mode 100644 drivers/genpd/imx/Makefile
 rename drivers/{soc => genpd}/imx/gpc.c (100%)
 rename drivers/{soc => genpd}/imx/gpcv2.c (100%)
 rename drivers/{soc => genpd}/imx/imx8m-blk-ctrl.c (100%)
 rename drivers/{soc => genpd}/imx/imx8mp-blk-ctrl.c (100%)
 rename drivers/{soc => genpd}/imx/imx93-blk-ctrl.c (100%)
 rename drivers/{soc => genpd}/imx/imx93-pd.c (100%)
 create mode 100644 drivers/genpd/mediatek/Makefile
 rename drivers/{soc => genpd}/mediatek/mt6795-pm-domains.h (100%)
 rename drivers/{soc => genpd}/mediatek/mt8167-pm-domains.h (100%)
 rename drivers/{soc => genpd}/mediatek/mt8173-pm-domains.h (100%)
 rename drivers/{soc => genpd}/mediatek/mt8183-pm-domains.h (100%)
 rename drivers/{soc => genpd}/mediatek/mt8186-pm-domains.h (100%)
 rename drivers/{soc => genpd}/mediatek/mt8188-pm-domains.h (100%)
 rename drivers/{soc => genpd}/mediatek/mt8192-pm-domains.h (100%)
 rename drivers/{soc => genpd}/mediatek/mt8195-pm-domains.h (100%)
 rename drivers/{soc => genpd}/mediatek/mtk-pm-domains.c (100%)
 rename drivers/{soc => genpd}/mediatek/mtk-pm-domains.h (100%)
 rename drivers/{soc => genpd}/mediatek/mtk-scpsys.c (100%)
 create mode 100644 drivers/genpd/qcom/Makefile
 rename drivers/{soc => genpd}/qcom/cpr.c (100%)
 rename drivers/{soc => genpd}/qcom/rpmhpd.c (100%)
 rename drivers/{soc => genpd}/qcom/rpmpd.c (100%)
 create mode 100644 drivers/genpd/renesas/Makefile
 rename drivers/{soc => genpd}/renesas/r8a7742-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a7743-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a7745-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a77470-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a774a1-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a774b1-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a774c0-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a774e1-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a7779-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a7790-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a7791-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a7792-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a7794-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a7795-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a7796-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a77965-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a77970-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a77980-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a77990-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a77995-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a779a0-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a779f0-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a779g0-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/rcar-gen4-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/rcar-gen4-sysc.h (100%)
 rename drivers/{soc => genpd}/renesas/rcar-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/rcar-sysc.h (100%)
 rename drivers/{soc => genpd}/renesas/rmobile-sysc.c (100%)
 create mode 100644 drivers/genpd/rockchip/Makefile
 rename drivers/{soc/rockchip/pm_domains.c => genpd/rockchip/pm-domains.c} (100%)
 create mode 100644 drivers/genpd/samsung/Makefile
 rename drivers/{soc/samsung/pm_domains.c => genpd/samsung/exynos-pm-domains.c} (100%)
 create mode 100644 drivers/genpd/st/Makefile
 rename arch/arm/mach-ux500/pm_domains.c => drivers/genpd/st/ste-ux500-pm-domain.c (75%)
 create mode 100644 drivers/genpd/starfive/Makefile
 rename drivers/{soc/starfive/jh71xx_pmu.c => genpd/starfive/jh71xx-pmu.c} (100%)
 create mode 100644 drivers/genpd/sunxi/Makefile
 rename drivers/{soc => genpd}/sunxi/sun20i-ppu.c (100%)
 create mode 100644 drivers/genpd/tegra/Makefile
 rename drivers/{soc => genpd}/tegra/powergate-bpmp.c (100%)
 create mode 100644 drivers/genpd/ti/Makefile
 rename drivers/{soc => genpd}/ti/omap_prm.c (100%)
 rename drivers/{soc => genpd}/ti/ti_sci_pm_domains.c (100%)
 create mode 100644 drivers/genpd/xilinx/Makefile
 rename drivers/{soc/xilinx/zynqmp_pm_domains.c => genpd/xilinx/zynqmp-pm-domains.c} (100%)
 delete mode 100644 drivers/soc/bcm/bcm63xx/Kconfig
 delete mode 100644 drivers/soc/bcm/bcm63xx/Makefile
 delete mode 100644 drivers/soc/starfive/Makefile
