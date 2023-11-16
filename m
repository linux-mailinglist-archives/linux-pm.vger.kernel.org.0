Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC2F7EDFCF
	for <lists+linux-pm@lfdr.de>; Thu, 16 Nov 2023 12:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjKPL1D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Nov 2023 06:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjKPL1A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Nov 2023 06:27:00 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00A219B
        for <linux-pm@vger.kernel.org>; Thu, 16 Nov 2023 03:26:56 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3aWH-00084B-AI; Thu, 16 Nov 2023 12:26:49 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3aWG-009RE3-D5; Thu, 16 Nov 2023 12:26:48 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3aWG-002aLs-3s; Thu, 16 Nov 2023 12:26:48 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Guillaume La Roque <glaroque@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH 0/2] thermal: amlogic: Two cleanups
Date:   Thu, 16 Nov 2023 12:26:34 +0100
Message-ID: <20231116112633.668826-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=488; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=1W289yYk/64muKBz1G6Qv0Lggh4SPXvmUP3B6/ALE6w=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtTQP1mLJVh/8IfMuq6nYOK3wFdxg3rRl+K+Fy9VpsUdb DNWj1jTyWjMwsDIxSArpshi37gm06pKLrJz7b/LMINYmUCmMHBxCsBEllax/w/S57c6tbVUdWs+ i4TGmZ13t/+LMWzem1Iz4RiT0pNn1gG3BGv/8B7XVV/0JCnd/GTbkmxt19SDrSHZRfbiuWbGRxf 4Zp+RiXtuFb95n9XOZy8MVBemXWd5uWWpg6PE3+Lvk8W1tYwOpf1OVV9soX/yoW3z1YOtVas+rD vQ5VLAVT7r6a6i0C1VrxexL83xCZR4Z7J2ZpyAlO3mxtNPqxYx34lYvfROmE2azLGN7c6GxS9Oh /lrP8wo8Jy72XFCasu02XNFfjF6nmd8FXm+Tf3H58iSKHsJrdL3k5t5ok8laOw916c6bdvihXVy f/5dKNvdms08NaW9qzVFdoGmwsGXLkyXYqRcNNiEeLV6AA==
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

while rebasing my patch stack to v6.7-rc1 I spotted these two patch
opportunities for the amlogic thermal driver.

Best regards
Uwe

Uwe Kleine-König (2):
  thermal: amlogic: Make amlogic_thermal_disable() return void
  thermal: amlogic: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions

 drivers/thermal/amlogic_thermal.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

base-commit: f31817cbcf48d191faee7cebfb59197d2048cd64
-- 
2.42.0

