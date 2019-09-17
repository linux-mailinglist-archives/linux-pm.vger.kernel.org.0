Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89E98B57A3
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2019 23:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfIQVfI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Sep 2019 17:35:08 -0400
Received: from muru.com ([72.249.23.125]:33528 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbfIQVfH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 17 Sep 2019 17:35:07 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 0A1738140;
        Tue, 17 Sep 2019 21:35:38 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, Merlijn Wajer <merlijn@wizzup.org>
Subject: [PATCH 1/3] power: supply: cpcap-charger: Limit voltage to 4.2V for battery
Date:   Tue, 17 Sep 2019 14:34:59 -0700
Message-Id: <20190917213501.16907-2-tony@atomide.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190917213501.16907-1-tony@atomide.com>
References: <20190917213501.16907-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Pavel Machek <pavel@ucw.cz>

There have been some cases of droid4 battery bulging that seem to
be related to being left connected to the charger for several weeks.

It is suspected that the 4.35V charge voltage configured for the battery
is too much in the long run, so lets limit the charge voltage to 4.2V.

Note that we are using the same register values as the Android distros
on droid4, so it is suspected that the same problem also exists in
Android.

Fixes: 3ae5f06681fc ("power: supply: cpcap-charger: Fix charge voltage configuration")
Reported-by: Merlijn Wajer <merlijn@wizzup.org>
Signed-off-by: Pavel Machek <pavel@ucw.cz>
[tony@atomide.com: added description of the problem and fixes tag]
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/cpcap-charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -457,7 +457,7 @@ static void cpcap_usb_detect(struct work_struct *work)
 			max_current = CPCAP_REG_CRM_ICHRG_0A532;
 
 		error = cpcap_charger_set_state(ddata,
-						CPCAP_REG_CRM_VCHRG_4V35,
+						CPCAP_REG_CRM_VCHRG_4V20,
 						max_current, 0);
 		if (error)
 			goto out_err;
-- 
2.23.0
