Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D3E1C2D66
	for <lists+linux-pm@lfdr.de>; Sun,  3 May 2020 17:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbgECPVw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 May 2020 11:21:52 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:43713 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728627AbgECPVN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 3 May 2020 11:21:13 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49FV7W0x0HzKc;
        Sun,  3 May 2020 17:21:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1588519271; bh=aHxtsC8N7E1pudNhXZCf8OSOZbxQCCFh3AVsjrqFoGw=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=Kp1cDprUo9JxAqyaSmhflDRfLxph2C3xK63hbVGONN3KhsQTD4zKJ81Y6S51mJMil
         lj4fQzOr3ss2zY18IrsUtBSoh/h1X/qCPNcMiwa5kiXtzW+2CQPvnkweDxpt8rSKxS
         O0xerEJigOeHJpFZQY0TEeAe49eVwD0PZ4cfE9IQk+JFDbIUwH6E55kvAc9l2f9W1t
         QoOR6WbNjWpsdINW/JNUNZXi/0T0EYIIPBQiYTqF/Cq5Ck8Jdv820cPI+ag/iXCiJh
         GO8/HV1LY7AdF8Ftwyr7fpa4f6RqzPedsD/gt9nPdvEpAZrgWiTgN8r+RzqUwGH6/Z
         wydbTYZkX+asA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Sun, 03 May 2020 17:21:10 +0200
Message-Id: <ef2a17d5eced06f0e16b12169387b162433937d7.1588517058.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1588517058.git.mirq-linux@rere.qmqm.pl>
References: <cover.1588517058.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 03/11] power: bq25890: make property table const
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Property list should not change, so mark it const.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/power/supply/bq25890_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index f9f29edadddc..c4a69fd69f34 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -668,7 +668,7 @@ static int bq25890_hw_init(struct bq25890_device *bq)
 	return 0;
 }
 
-static enum power_supply_property bq25890_power_supply_props[] = {
+static const enum power_supply_property bq25890_power_supply_props[] = {
 	POWER_SUPPLY_PROP_MANUFACTURER,
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_STATUS,
-- 
2.20.1

