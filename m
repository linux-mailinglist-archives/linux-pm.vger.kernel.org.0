Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC371D0142
	for <lists+linux-pm@lfdr.de>; Tue, 12 May 2020 23:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbgELVvf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 May 2020 17:51:35 -0400
Received: from muru.com ([72.249.23.125]:54342 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728313AbgELVvf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 12 May 2020 17:51:35 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 7B2C38047;
        Tue, 12 May 2020 21:52:24 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH] power: supply: cpcap-charger: Make VBUS already provided debug only
Date:   Tue, 12 May 2020 14:51:29 -0700
Message-Id: <20200512215129.41174-1-tony@atomide.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This should be only shown when debug is enabled.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/cpcap-charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -433,7 +433,7 @@ static void cpcap_charger_vbus_work(struct work_struct *work)
 	if (ddata->vbus_enabled) {
 		vbus = cpcap_charger_vbus_valid(ddata);
 		if (vbus) {
-			dev_info(ddata->dev, "VBUS already provided\n");
+			dev_dbg(ddata->dev, "VBUS already provided\n");
 
 			return;
 		}
-- 
2.26.2
