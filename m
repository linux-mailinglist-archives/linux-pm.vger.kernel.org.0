Return-Path: <linux-pm+bounces-19444-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A679F6D8C
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 19:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5198164D7C
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 18:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7FA1FA8DD;
	Wed, 18 Dec 2024 18:44:41 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6656D1FA179
	for <linux-pm@vger.kernel.org>; Wed, 18 Dec 2024 18:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734547481; cv=none; b=FSSIwWtgZSkgEkK6X4NGgwO/MnT66X+ZhWrviy4PfPK+dpQfo2kq33E/h1v+sZJekTh29uTeL05MY8ma6Q9VUZfdO8kUruF5xZagvLvuGPi0Vqb7sJjNjoW7N8xK+VPmi/EDc1HXsZdiZpCCV1inxKeDlYHEUd0Ml33w0ND3B8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734547481; c=relaxed/simple;
	bh=UJgX3Hk1rWjjicLnoEb8a2Mna1kMH+TWDwr1Jx+4MOA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xpb8Uhhyi/GuEelWvGZ67gf4Ck5fGGAaXc+5G+cnCBAuWkxPjOFCxXW2rc9MJVRBlS1qWbqm/ik9fRVVNlsOKVNTgap1WEO/SQunorky5LcNxdPvMvz/LXLYsPCTLVl6poX4L/syOSraRgBkQee9TbYWGbBc91/7MkjbinppSuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1tNz2A-0007xa-Dy; Wed, 18 Dec 2024 19:44:34 +0100
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <l.stach@pengutronix.de>)
	id 1tNz29-0044o2-00;
	Wed, 18 Dec 2024 19:44:33 +0100
From: Lucas Stach <l.stach@pengutronix.de>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org,
	kernel@pengutronix.de,
	patchwork-lst@pengutronix.de,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] pmdomain: core: add dummy release function to genpd device
Date: Wed, 18 Dec 2024 19:44:33 +0100
Message-Id: <20241218184433.1930532-1-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

The genpd device, which is really only used as a handle to lookup
OPP, but not even registered to the device core otherwise and thus
lifetime linked to the genpd struct it is contained in, is missing
a release function. After b8f7bbd1f4ec ("pmdomain: core: Add
missing put_device()") the device will be cleaned up going through
the driver core device_release() function, which will warn when no
release callback is present for the device. Add a dummy release
function to shut up the warning.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
It's a bit unfortunate that the genpd even needs to have this
not-really-a-device just for the sake of the OPP lookup.
---
 drivers/pmdomain/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index bb11f467dc78..83659d79e07d 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2142,6 +2142,11 @@ static int genpd_set_default_power_state(struct generic_pm_domain *genpd)
 	return 0;
 }
 
+static void genpd_release_opp_dev(struct device *dev)
+{
+	/* nothing to be done here */
+}
+
 static int genpd_alloc_data(struct generic_pm_domain *genpd)
 {
 	struct genpd_governor_data *gd = NULL;
@@ -2173,6 +2178,7 @@ static int genpd_alloc_data(struct generic_pm_domain *genpd)
 
 	genpd->gd = gd;
 	device_initialize(&genpd->dev);
+	genpd->dev.release = genpd_release_opp_dev;
 
 	if (!genpd_is_dev_name_fw(genpd)) {
 		dev_set_name(&genpd->dev, "%s", genpd->name);
-- 
2.47.1


