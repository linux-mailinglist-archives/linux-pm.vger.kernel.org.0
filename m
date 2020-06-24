Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61234206F0C
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jun 2020 10:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389400AbgFXIgf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jun 2020 04:36:35 -0400
Received: from smtp.asem.it ([151.1.184.197]:60963 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389042AbgFXIgf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 24 Jun 2020 04:36:35 -0400
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 6.5.2)
        with ESMTP id SG000337910.MSG 
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2020 10:36:32 +0200S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 24
 Jun 2020 10:36:29 +0200
Received: from flavio-x.asem.intra (172.16.17.208) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 24 Jun 2020 10:36:29 +0200
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH 1/1] power: supply: axp20x_usb_power: fix spelling mistake
Date:   Wed, 24 Jun 2020 10:36:29 +0200
Message-ID: <20200624083629.9507-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-SGHeloLookup-Result: pass smtp.helo=webmail.asem.it (ip=172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A090209.5EF3108E.005F,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix typo: "triger" --> "trigger"

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 drivers/power/supply/axp20x_usb_power.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 4fde24b5f35a..d01dc0332edc 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -78,7 +78,7 @@ static bool axp20x_usb_vbus_needs_polling(struct axp20x_usb_power *power)
 	/*
 	 * Polling is only necessary while VBUS is offline. While online, a
 	 * present->absent transition implies an online->offline transition
-	 * and will triger the VBUS_REMOVAL IRQ.
+	 * and will trigger the VBUS_REMOVAL IRQ.
 	 */
 	if (power->axp20x_id >= AXP221_ID && !power->online)
 		return true;
-- 
2.17.1

