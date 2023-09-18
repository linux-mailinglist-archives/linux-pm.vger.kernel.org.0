Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50D17A4EB2
	for <lists+linux-pm@lfdr.de>; Mon, 18 Sep 2023 18:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjIRQVU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Sep 2023 12:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjIRQVQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Sep 2023 12:21:16 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F0825AFC
        for <linux-pm@vger.kernel.org>; Mon, 18 Sep 2023 09:15:36 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER2-0001ol-LY; Mon, 18 Sep 2023 15:37:08 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER0-007EY0-9P; Mon, 18 Sep 2023 15:37:06 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiEQz-002fVp-Vq; Mon, 18 Sep 2023 15:37:06 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>, linux-pm@vger.kernel.org,
        kernel@pengutronix.de,
        Support Opensource <support.opensource@diasemi.com>,
        =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        patches@opensource.cirrus.com
Subject: [PATCH 00/32] power: supply: Convert to platform remove callback returning void
Date:   Mon, 18 Sep 2023 15:36:28 +0200
Message-Id: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5547; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=zDMwjycGeTGiZ3FSzkteltW3FjQsXLuBPKrTOwygC1E=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCFJPzrH3CuAv2QQ4SExLD4a066R/+iZjNcTYo D3dCIYo1Q6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQhSTwAKCRCPgPtYfRL+ Tqz9CACgTeh8nLbbW83jIivIL4Qp72E3mPWnhVdgUSr3a/sPrKkb3hlPB40C68vMqG1ihYsokRa rnAAAKj+g61TK2y0NvklUVZ0nAKs4v7gx73/2MGMuWyX7Trlqe0dGFN5kzYNH3ltKXqG6ZxLU6w S5y/bNgdDQHrk0iLAFO5NAVGJDFz2YG86LdysFA285D2Sp4ry8uoj5l6ZkU2H4ldhzehmIQmC7D fBJxik/WANtcbC4VCm1FbPeBa4g0TjkA0QTHu95wqXPIPjuUW4SNSz65PcoORsvUrl2Fu6q7qXL VajF4cNLHYZ8DLDcR6WijQjbj0GQh5dQqTI2JHc5V/mqxAhc
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hello,

this series convert all platform drivers below drivers/power/supply to
use remove_new. The motivation is to get rid of an integer return code
that is (mostly) ignored by the platform driver core and error prone on
the driver side.

See commit 5c5a7680e67b ("platform: Provide a remove callback that
returns no value") for an extended explanation and the eventual goal.

There are no interdependencies between the patches. As there are still
quite a few drivers to convert, I'm happy about every patch that makes
it in. So even if there is a merge conflict with one patch until you
apply, please apply the remainder of this series anyhow.

Best regards
Uwe

Uwe Kleine-König (32):
  power: supply: ab8500_btemp: Convert to platform remove callback
    returning void
  power: supply: ab8500_chargalg: Convert to platform remove callback
    returning void
  power: supply: ab8500_charger: Convert to platform remove callback
    returning void
  power: supply: ab8500_fg: Convert to platform remove callback
    returning void
  power: supply: acer_a500_battery: Convert to platform remove callback
    returning void
  power: supply: act8945a_charger: Convert to platform remove callback
    returning void
  power: supply: charger-manager: Convert to platform remove callback
    returning void
  power: supply: cpcap-battery: Convert to platform remove callback
    returning void
  power: supply: cpcap-charger: Convert to platform remove callback
    returning void
  power: supply: da9030_battery: Convert to platform remove callback
    returning void
  power: supply: da9052-battery: Convert to platform remove callback
    returning void
  power: supply: da9150-charger: Convert to platform remove callback
    returning void
  power: supply: goldfish_battery: Convert to platform remove callback
    returning void
  power: supply: ipaq_micro_battery: Convert to platform remove callback
    returning void
  power: supply: isp1704_charger: Convert to platform remove callback
    returning void
  power: supply: lp8788-charger: Convert to platform remove callback
    returning void
  power: supply: max14577_charger: Convert to platform remove callback
    returning void
  power: supply: max77650-charger: Convert to platform remove callback
    returning void
  power: supply: max77693_charger: Convert to platform remove callback
    returning void
  power: supply: max8925_power: Convert to platform remove callback
    returning void
  power: supply: pcf50633-charger: Convert to platform remove callback
    returning void
  power: supply: qcom_smbb: Convert to platform remove callback
    returning void
  power: supply: rx51_battery: Convert to platform remove callback
    returning void
  power: supply: sc2731_charger: Convert to platform remove callback
    returning void
  power: supply: tps65090-charger: Convert to platform remove callback
    returning void
  power: supply: tps65217_charger: Convert to platform remove callback
    returning void
  power: supply: twl4030_charger: Convert to platform remove callback
    returning void
  power: supply: twl4030_madc_battery: Convert to platform remove
    callback returning void
  power: supply: wm831x_backup: Convert to platform remove callback
    returning void
  power: supply: wm831x_power: Convert to platform remove callback
    returning void
  power: supply: wm8350_power: Convert to platform remove callback
    returning void
  power: supply: wm97xx_battery: Convert to platform remove callback
    returning void

 drivers/power/supply/ab8500_btemp.c         | 6 ++----
 drivers/power/supply/ab8500_chargalg.c      | 6 ++----
 drivers/power/supply/ab8500_charger.c       | 6 ++----
 drivers/power/supply/ab8500_fg.c            | 6 ++----
 drivers/power/supply/acer_a500_battery.c    | 6 ++----
 drivers/power/supply/act8945a_charger.c     | 6 ++----
 drivers/power/supply/charger-manager.c      | 6 ++----
 drivers/power/supply/cpcap-battery.c        | 6 ++----
 drivers/power/supply/cpcap-charger.c        | 6 ++----
 drivers/power/supply/da9030_battery.c       | 6 ++----
 drivers/power/supply/da9052-battery.c       | 6 ++----
 drivers/power/supply/da9150-charger.c       | 6 ++----
 drivers/power/supply/goldfish_battery.c     | 5 ++---
 drivers/power/supply/ipaq_micro_battery.c   | 6 ++----
 drivers/power/supply/isp1704_charger.c      | 6 ++----
 drivers/power/supply/lp8788-charger.c       | 6 ++----
 drivers/power/supply/max14577_charger.c     | 6 ++----
 drivers/power/supply/max77650-charger.c     | 6 ++----
 drivers/power/supply/max77693_charger.c     | 6 ++----
 drivers/power/supply/max8925_power.c        | 5 ++---
 drivers/power/supply/pcf50633-charger.c     | 6 ++----
 drivers/power/supply/qcom_smbb.c            | 6 ++----
 drivers/power/supply/rx51_battery.c         | 6 ++----
 drivers/power/supply/sc2731_charger.c       | 6 ++----
 drivers/power/supply/tps65090-charger.c     | 6 ++----
 drivers/power/supply/tps65217_charger.c     | 6 ++----
 drivers/power/supply/twl4030_charger.c      | 6 ++----
 drivers/power/supply/twl4030_madc_battery.c | 6 ++----
 drivers/power/supply/wm831x_backup.c        | 6 ++----
 drivers/power/supply/wm831x_power.c         | 5 ++---
 drivers/power/supply/wm8350_power.c         | 5 ++---
 drivers/power/supply/wm97xx_battery.c       | 5 ++---
 32 files changed, 64 insertions(+), 123 deletions(-)


base-commit: 7fc7222d9680366edeecc219c21ca96310bdbc10
-- 
2.40.1

