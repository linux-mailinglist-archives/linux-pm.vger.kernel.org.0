Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167397DD852
	for <lists+linux-pm@lfdr.de>; Tue, 31 Oct 2023 23:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346781AbjJaW3j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Oct 2023 18:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346777AbjJaW3j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Oct 2023 18:29:39 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939D2F4
        for <linux-pm@vger.kernel.org>; Tue, 31 Oct 2023 15:29:36 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qxxEZ-0000Xv-UA; Tue, 31 Oct 2023 23:29:15 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qxxEY-005fLF-5Z; Tue, 31 Oct 2023 23:29:14 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qxxEX-00AENI-SK; Tue, 31 Oct 2023 23:29:13 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel@pengutronix.de, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        =?utf-8?b?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 0/9] interconnect: Convert to platform remove callback returning void
Date:   Tue, 31 Oct 2023 23:28:52 +0100
Message-ID: <20231031222851.3126434-11-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2603; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=3SkMgeZXUh2DxhiI9zyWc84nqltxgURpZ9fY1tc7VcE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlQX+jlzRrKrXFjomy7M9OrfEJANX39S9Ie6R5Y zKtfDvhyxeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZUF/owAKCRCPgPtYfRL+ TiDbCACQrtZBPLcPQ53kWNVGgjP5atluU4UudSSzUUjMbN7O3fO9xePZ3HPdqkZdoGnYGtTFxsV 5ueAhqHq/MUJ4DqZ4rGtEepyXodVTVEBfixTw/IrPEKBVqzLmD/yr9Se04UmsqaXjQxQT2zyWD2 IDs8r3dBbUoLRWNI6VBAsvG0I8Ct4odK5MHur08rUY1V3193j/pHMwZrARljq9tbhnxGVBSC45A bhjZW9LIE7yu8m/crBQP9jJ0xVMMpNupJ4SQ1i8xS9s2zFkVigMVKubk21zIy2+LDcruVVp1kTf 6fPhnRoX0G8lJLIm1tQBqyrZ/rGxalxnfqjaduYjesOm9QT0
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

this series converts all platform drivers below drivers/interconnect to
use .remove_new(). Compared to the traditional .remove() callback
.remove_new() returns no value. This is a good thing because the driver
core doesn't (and cannot) cope for errors during remove. The only effect
of a non-zero return value in .remove() is that the driver core emits a
warning. The device is removed anyhow and an early return from .remove()
usually yields resource leaks and/or use-after-free bugs.

See commit 5c5a7680e67b ("platform: Provide a remove callback that
returns no value") for an extended explanation and the eventual goal.

All drivers converted here already returned zero unconditionally in
.remove(), so they are converted here trivially. The imx drivers could
be slightly simplified, because the remove callback only called a single
function with the same prototype as .remove_new().

Best regards
Uwe

Uwe Kleine-König (9):
  interconnect: qcom: Make qnoc_remove return void
  interconnect: imx8mm: Convert to platform remove callback returning
    void
  interconnect: imx8mn: Convert to platform remove callback returning
    void
  interconnect: imx8mp: Convert to platform remove callback returning
    void
  interconnect: imx8mq: Convert to platform remove callback returning
    void
  interconnect: qcom/msm8974: Convert to platform remove callback
    returning void
  interconnect: qcom/osm-l3: Convert to platform remove callback
    returning void
  interconnect: qcom/smd-rpm: Convert to platform remove callback
    returning void
  interconnect: exynos: Convert to platform remove callback returning
    void

 drivers/interconnect/imx/imx8mm.c     | 9 +--------
 drivers/interconnect/imx/imx8mn.c     | 9 +--------
 drivers/interconnect/imx/imx8mp.c     | 9 +--------
 drivers/interconnect/imx/imx8mq.c     | 9 +--------
 drivers/interconnect/qcom/icc-rpm.c   | 4 +---
 drivers/interconnect/qcom/icc-rpm.h   | 2 +-
 drivers/interconnect/qcom/msm8916.c   | 2 +-
 drivers/interconnect/qcom/msm8939.c   | 2 +-
 drivers/interconnect/qcom/msm8974.c   | 6 ++----
 drivers/interconnect/qcom/msm8996.c   | 2 +-
 drivers/interconnect/qcom/osm-l3.c    | 6 ++----
 drivers/interconnect/qcom/qcm2290.c   | 2 +-
 drivers/interconnect/qcom/qcs404.c    | 2 +-
 drivers/interconnect/qcom/sdm660.c    | 2 +-
 drivers/interconnect/qcom/smd-rpm.c   | 6 ++----
 drivers/interconnect/samsung/exynos.c | 6 ++----
 16 files changed, 20 insertions(+), 58 deletions(-)


base-commit: 9c2d379d63450ae464eeab45462e0cb573cd97d0
-- 
2.42.0

