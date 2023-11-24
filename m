Return-Path: <linux-pm+bounces-175-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1557F76F0
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 15:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 579242810D7
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 14:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71B71CFB7;
	Fri, 24 Nov 2023 14:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C62019A1
	for <linux-pm@vger.kernel.org>; Fri, 24 Nov 2023 06:53:50 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1r6XYp-0006o8-QO; Fri, 24 Nov 2023 15:53:39 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1r6XYp-00BI10-8U; Fri, 24 Nov 2023 15:53:39 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1r6XYp-00D3md-0U;
	Fri, 24 Nov 2023 15:53:39 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Mark Brown <broonie@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [PATCH v1 3/3] mmc: core: increase shutdown priority for MMC devices
Date: Fri, 24 Nov 2023 15:53:38 +0100
Message-Id: <20231124145338.3112416-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231124145338.3112416-1-o.rempel@pengutronix.de>
References: <20231124145338.3112416-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

Set a higher shutdown priority for MMC devices. By introducing a call to
This adjustment ensures that MMC storage devices are prioritized during the
system shutdown process, aligning with the critical nature of storage
devices in maintaining data integrity and preventing potential data loss
or corruption during emergency shutdown scenarios.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/mmc/core/bus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 0af96548e7da..90a40fe8d16f 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -128,6 +128,8 @@ static int mmc_bus_probe(struct device *dev)
 	struct mmc_driver *drv = to_mmc_driver(dev->driver);
 	struct mmc_card *card = mmc_dev_to_card(dev);
 
+	dev_set_shutdown_priority(dev, DEVICE_SHUTDOWN_PRIO_STORAGE);
+
 	return drv->probe(card);
 }
 
-- 
2.39.2


