Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A6D58345E
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jul 2022 23:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbiG0VDH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jul 2022 17:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbiG0VDG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jul 2022 17:03:06 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08256564D9
        for <linux-pm@vger.kernel.org>; Wed, 27 Jul 2022 14:03:05 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id u14-20020a05600c00ce00b003a323062569so93260wmm.4
        for <linux-pm@vger.kernel.org>; Wed, 27 Jul 2022 14:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FpbqvLMg6Bjlhza3zNTTUTKxz+iSd6bcmpn4ixx34eY=;
        b=VNiwfVrm+6AlZGuYkwdI3/uth6zjOKSBihIKnTILHUK9njlNY1kDScq/P7CG2+Km/C
         VNIyydLkKX67pSDQ5XGoPOpH4iNs4yStPMGgw0sZPsWCQpvBzTSIdAhb+QGLTEHYVyeu
         Au6KVcp0m1CvvgVbr+/B53PPHDSuzEYvtrGBgRa3rsDTF6Q5jjdEK++uJxqc5YXl77Zh
         lXf77gDzFk4/PGpjyWC18puCQrYIVqS85DyHgQg06Te9d2JdgMmpj9cJZzgySWZPoOXS
         aJ7AcApD/wlQi+HK797pFE3E0A5p0g0v9jBBqB1FiuOGn7D/jBIfdY8jRHKxrcTBXZKe
         4ktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FpbqvLMg6Bjlhza3zNTTUTKxz+iSd6bcmpn4ixx34eY=;
        b=hDe6lxE+2u9WipO8irTXxvqrpKP0rCx1av3S343583bQNRV0lN8ztSTDDEu31c5N0S
         oylPd3U3nOPYrm50Og7W80Nlsc4V/jVytlI7hzl1Zv5HwvmoaVrLsZh47KAKVoYt/1Vq
         DRk77AOs6kTFSeRVI7Ko2ipLERxM6CBhvzXed3KJd5Xwa2WYadpxWnOIRUq11KYv/sAx
         YnwR60fWiAi9+WOO+97+p1N0ZCMqNx9oz7UP3kh/lOkzC63slUHvTbo5bTISNI4iKAuy
         1tJYoMONmrjfB1CFVpEXfAplbLA4VFX4XaOVYFFS485x/qzyW+KQpOtvoe0rdmfrgenn
         Sw8Q==
X-Gm-Message-State: AJIora84kDgh5MxULo5/nVp83My7oCXpbQHuXE8SV36QlSxhf9q5yrk4
        748TW7W5m79FacGKaSgAY56Lnw==
X-Google-Smtp-Source: AGRyM1une8eyqDx/MSQl6cp9ufsuULNuvBhRGWCkxIL7E+In/9pL61pxejn2zGjVn8MLXUbBfAdmaQ==
X-Received: by 2002:a05:600c:35c7:b0:3a3:2612:f823 with SMTP id r7-20020a05600c35c700b003a32612f823mr4313993wmq.33.1658955783487;
        Wed, 27 Jul 2022 14:03:03 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:65a8:ebd8:4098:d9d0])
        by smtp.gmail.com with ESMTPSA id h6-20020a05600c350600b003a38606385esm37908wmq.3.2022.07.27.14.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 14:03:02 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com, broonie@kernel.org,
        damien.lemoal@opensource.wdc.com, heiko@sntech.de,
        hayashi.kunihiko@socionext.com, mhiramat@kernel.org,
        talel@amazon.com, thierry.reding@gmail.com, digetx@gmail.com,
        jonathanh@nvidia.com, anarsoul@gmail.com, tiny.windzz@gmail.com,
        baolin.wang7@gmail.com, f.fainelli@gmail.com,
        bjorn.andersson@linaro.org, mcoquelin.stm32@gmail.com,
        glaroque@baylibre.com, miquel.raynal@bootlin.com,
        shawnguo@kernel.org, niklas.soderlund@ragnatech.se,
        matthias.bgg@gmail.com, j-keerthy@ti.com
Subject: [PATCH v3 00/32] New thermal OF code
Date:   Wed, 27 Jul 2022 23:02:21 +0200
Message-Id: <20220727210253.3794069-1-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following changes are depending on:

 - 20220722200007.1839356-1-daniel.lezcano@linexp.org

which are present in the thermal/linux-next branch:

https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/log/?h=thermal/linux-next

The series introduces a new thermal OF code. The patch description gives
a detailed explanation of the changes. Basically we write new OF parsing
functions, we migrate all the users of the old thermal OF API to the new
one and then we finish by removing the old OF code.

That is the second step to rework the thermal OF code. More patches will
come after that to remove the duplication of the trip definitions in the
different drivers which will result in more code duplication removed and
consolidation of the core thermal framework.

Thanks for those who tested the series on their platform and
investigated the regression with the disabled by default thermal zones.

Changelog:
 v3:
   - Rebased on the right branch as reported by Niklas Söderlund
   - Collected more tags
 v2:
   - Changed the code in the register thermal zone function to prevent
     the 'const' annotation being removed in the different drivers
   - Collected the tags and adding Cc for more context
   - Changed the first line patch description to comply to the 'input'
     subsystem format
   - Give a more detailed description in the changelog for the drivers
   - Remove pointless calls to unregister as the devm version is used
     instead
   - Moved dummy functions from one patch to another to prevent git
     bisecting issue when THERMAL_OF=n
   - Fixed thermal zone disabled by default

Daniel Lezcano (32):
  thermal/of: Rework the thermal device tree initialization
  thermal/of: Make new code and old code co-exist
  thermal/drivers/rockchip: Switch to new of API
  thermal/drivers/uniphier: Switch to new of API
  thermal/drivers/generic-adc: Switch to new of API
  thermal/drivers/mmio: Switch to new of API
  thermal/drivers/tegra: Switch to new of API
  thermal/drivers/sun8i: Switch to new of API
  thermal/drivers/sprd: Switch to new of API
  thermal/drivers/broadcom: Switch to new of API
  thermal/drivers/qcom: Switch to new of API
  thermal/drivers/st: Switch to new of API
  thermal/drivers/amlogic: Switch to new of API
  thermal/drivers/armada: Switch to new of API
  thermal/drivers/db8500: Switch to new of API
  thermal/drivers/imx: Switch to new of API
  thermal/drivers/rcar: Switch to new of API
  thermal/drivers/rzg2l: Switch to new of API
  thermal/drivers/qoriq: Switch to new of API
  thermal/drivers/mtk: Switch to new of API
  thermal/drivers/banggap: Switch to new of API
  thermal/drivers/maxim: Switch to new of API
  thermal/drivers/hisilicon: Switch to new of API
  thermal/drivers/ti-soc: Switch to new of API
  ata/drivers/ahci_imx: Switch to new of thermal API
  hwmon/drivers: Switch to new of thermal API
  iio/drivers/sun4i_gpadc: Switch to new of thermal API
  Input: sun4i-ts - switch to new of thermal API
  regulator/drivers/max8976: Switch to new of thermal API
  thermal/drivers/samsung: Switch to new of thermal API
  thermal/core: Move set_trip_temp ops to the sysfs code
  thermal/of: Remove old OF code

 drivers/ata/ahci_imx.c                        |   15 +-
 drivers/hwmon/hwmon.c                         |   14 +-
 drivers/hwmon/scpi-hwmon.c                    |   14 +-
 drivers/iio/adc/sun4i-gpadc-iio.c             |   12 +-
 drivers/input/touchscreen/sun4i-ts.c          |   10 +-
 drivers/regulator/max8973-regulator.c         |   10 +-
 drivers/thermal/amlogic_thermal.c             |   16 +-
 drivers/thermal/armada_thermal.c              |   12 +-
 drivers/thermal/broadcom/bcm2711_thermal.c    |   14 +-
 drivers/thermal/broadcom/bcm2835_thermal.c    |   14 +-
 drivers/thermal/broadcom/brcmstb_thermal.c    |   20 +-
 drivers/thermal/broadcom/ns-thermal.c         |   50 +-
 drivers/thermal/broadcom/sr-thermal.c         |   16 +-
 drivers/thermal/db8500_thermal.c              |    8 +-
 drivers/thermal/hisi_thermal.c                |   14 +-
 drivers/thermal/imx8mm_thermal.c              |   14 +-
 drivers/thermal/imx_sc_thermal.c              |   14 +-
 drivers/thermal/k3_bandgap.c                  |   12 +-
 drivers/thermal/k3_j72xx_bandgap.c            |   12 +-
 drivers/thermal/max77620_thermal.c            |    8 +-
 drivers/thermal/mtk_thermal.c                 |   10 +-
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c      |   19 +-
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c   |   12 +-
 drivers/thermal/qcom/tsens.c                  |   16 +-
 drivers/thermal/qoriq_thermal.c               |   12 +-
 drivers/thermal/rcar_gen3_thermal.c           |   16 +-
 drivers/thermal/rcar_thermal.c                |   13 +-
 drivers/thermal/rockchip_thermal.c            |   14 +-
 drivers/thermal/rzg2l_thermal.c               |   10 +-
 drivers/thermal/samsung/exynos_tmu.c          |   24 +-
 drivers/thermal/sprd_thermal.c                |   18 +-
 drivers/thermal/st/stm_thermal.c              |   16 +-
 drivers/thermal/sun8i_thermal.c               |   14 +-
 drivers/thermal/tegra/soctherm.c              |   21 +-
 drivers/thermal/tegra/tegra-bpmp-thermal.c    |   19 +-
 drivers/thermal/tegra/tegra30-tsensor.c       |   12 +-
 drivers/thermal/thermal-generic-adc.c         |   10 +-
 drivers/thermal/thermal_core.c                |    6 -
 drivers/thermal/thermal_core.h                |    2 -
 drivers/thermal/thermal_mmio.c                |   17 +-
 drivers/thermal/thermal_of.c                  | 1140 ++++++-----------
 drivers/thermal/thermal_sysfs.c               |    5 +-
 .../ti-soc-thermal/ti-thermal-common.c        |   16 +-
 drivers/thermal/uniphier_thermal.c            |   10 +-
 include/linux/thermal.h                       |   89 +-
 45 files changed, 709 insertions(+), 1131 deletions(-)

-- 
2.25.1

