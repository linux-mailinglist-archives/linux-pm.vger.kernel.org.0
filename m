Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADD97E1126
	for <lists+linux-pm@lfdr.de>; Sat,  4 Nov 2023 22:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjKDVPv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Nov 2023 17:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjKDVPs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Nov 2023 17:15:48 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DEAD6A
        for <linux-pm@vger.kernel.org>; Sat,  4 Nov 2023 14:15:45 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzNza-0007wk-IH; Sat, 04 Nov 2023 22:15:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzNzX-006e11-N8; Sat, 04 Nov 2023 22:15:39 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzNzX-00D1ak-Dc; Sat, 04 Nov 2023 22:15:39 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-kbuild@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        linux-actions@lists.infradead.org,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 00/14] power: reset: Drop platform_driver_probe() and convert to platform remove callback returning void
Date:   Sat,  4 Nov 2023 22:15:02 +0100
Message-ID: <20231104211501.3676352-16-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3239; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=ASJpJ0PbRdt9ZtFZlOFmy3zBFQUV+f7OBE5g1UcY3qM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlRrRW2nlD3Bq26a3P3sYG5qAEG5GwUfm6B9YOc 7QqQI7xub+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZUa0VgAKCRCPgPtYfRL+ Ts6VB/9MYH4OE9JZxwtQ11ZFXv37CHQWuj2H7yDF2BNpbvz84sSUIBsB2cZ/P7qmXPmDGGnN9YH R/at02fE+3cIvpTPFySkqRu+sErOGGxzGIlcb+TY3IMtSpAfGsw19fH6vdOUiwweAAvFp6haRF6 ftt1EHSNdOTPHV3DMCX7XsfCW9JAuhaaDbXEoJwMB6JjqA4o/DJrEI+JANq5W/hKFvSY1C0Z0AT Q/XMroNdUYtHirVUJ7JqurjHCeYLVWXlHLSuEtyLMq6g+zpQOWbPuUdBP/iRLJx8dDd4b/IRuEa 5YUGw7TsAGg7bR/dIxQ3GGTak4rbbahwjrJV9xcC40W0gL7Q
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

there are two different types of patches here that would justify to
different series. But as the patches are not independant I chose to put
them in a single series.

The first three patches drop usage of platform_driver_probe(). This is a
concept that isn't so relevant any more today. I didn't check, but it
saves typically only a few 100k and there are thoughts to deprecate it
to simplify the core. Getting the usage right is not trivial though the
at91 drivers got it nearly right. The alternative to these patches is to
add __ref to the driver struct ideally with a comment describing the
need like is e.g. done in commit 5b44abbc39ca ("platform/x86: hp-wmi::
Mark driver struct with __refdata to prevent section mismatch warning").

The remaining patches convert the platform drivers to .remove_new(), see
commit 5c5a7680e67b ("platform: Provide a remove callback that returns
no value") for an extended explanation and the eventual goal. All
conversions but one are trivial as the remove functions return zero
unconditionally. The only exception is the tps65086-restart driver.

Best regards
Uwe

Uwe Kleine-König (14):
  power: reset: at91-poweroff: Stop using module_platform_driver_probe()
  power: reset: at91-reset:: Stop using module_platform_driver_probe()
  power: reset: at91-sama5d2_shdwc: Stop using
    module_platform_driver_probe()
  power: reset: as3722-poweroff: Convert to platform remove callback
    returning void
  power: reset: at91-poweroff: Convert to platform remove callback
    returning void
  power: reset: atc260x-poweroff: Convert to platform remove callback
    returning void
  power: reset: ltc2952-poweroff: Convert to platform remove callback
    returning void
  power: reset: mt6323-poweroff: Convert to platform remove callback
    returning void
  power: reset: qnap-poweroff: Convert to platform remove callback
    returning void
  power: reset: regulator-poweroff: Convert to platform remove callback
    returning void
  power: reset: restart-poweroff: Convert to platform remove callback
    returning void
  power: reset: rmobile-reset: Convert to platform remove callback
    returning void
  power: reset: syscon-poweroff: Convert to platform remove callback
    returning void
  power: reset: tps65086-restart: Convert to platform remove callback
    returning void

 drivers/power/reset/as3722-poweroff.c    |  6 ++----
 drivers/power/reset/at91-poweroff.c      | 11 +++++------
 drivers/power/reset/at91-reset.c         |  9 +++++----
 drivers/power/reset/at91-sama5d2_shdwc.c |  9 +++++----
 drivers/power/reset/atc260x-poweroff.c   |  6 ++----
 drivers/power/reset/ltc2952-poweroff.c   |  5 ++---
 drivers/power/reset/mt6323-poweroff.c    |  6 ++----
 drivers/power/reset/qnap-poweroff.c      |  5 ++---
 drivers/power/reset/regulator-poweroff.c |  6 ++----
 drivers/power/reset/restart-poweroff.c   |  6 ++----
 drivers/power/reset/rmobile-reset.c      |  5 ++---
 drivers/power/reset/syscon-poweroff.c    |  6 ++----
 drivers/power/reset/tps65086-restart.c   | 12 +++++++-----
 13 files changed, 40 insertions(+), 52 deletions(-)


base-commit: e27090b1413ff236ca1aec26d6b022149115de2c
-- 
2.42.0

