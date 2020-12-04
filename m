Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D699E2CF006
	for <lists+linux-pm@lfdr.de>; Fri,  4 Dec 2020 15:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbgLDOum (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Dec 2020 09:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728722AbgLDOum (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Dec 2020 09:50:42 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1548DC061A4F;
        Fri,  4 Dec 2020 06:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2dK3ir+LWB8RCghaNvBM70NFqDOUmqfEAJGTzJx4JcM=; b=U/+dMsGz+KRkBhCjE3vEtvIyAW
        2+CuNTlRUDBVogyedVFbcSvgyyc6nsCCy/akGkVFrWCdc95OZxUabkAjoVYa+zS2Qk5CBjTcSZNAT
        4GGSLyEp1uGV2BFRfJlr8LRONuq+t+EykCwgUKzF9KvadFKpb8HIbHNg2PPzUX1U7W+A=;
Received: from p200300ccff0a0b001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0a:b00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1klCPG-0006nV-FI; Fri, 04 Dec 2020 15:49:58 +0100
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1klCPG-00026m-6o; Fri, 04 Dec 2020 15:49:58 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     pali@kernel.org, dmurphy@ti.com, sre@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] power: bq27xxx: fix polarity of current_now
Date:   Fri,  4 Dec 2020 15:49:50 +0100
Message-Id: <20201204144950.8062-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

current_now has to be negative during discharging and positive during
charging, the behavior seen is the other way round.

Tested on GTA04 with Openmoko battery

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/power/supply/bq27xxx_battery.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 315e0909e6a4..3ecc18b01d49 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1789,7 +1789,7 @@ static int bq27xxx_battery_current(struct bq27xxx_device_info *di,
 
 	if (di->opts & BQ27XXX_O_ZERO) {
 		flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, true);
-		if (flags & BQ27000_FLAG_CHGS) {
+		if (!(flags & BQ27000_FLAG_CHGS)) {
 			dev_dbg(di->dev, "negative current!\n");
 			curr = -curr;
 		}
@@ -1797,7 +1797,7 @@ static int bq27xxx_battery_current(struct bq27xxx_device_info *di,
 		val->intval = curr * BQ27XXX_CURRENT_CONSTANT / BQ27XXX_RS;
 	} else {
 		/* Other gauges return signed value */
-		val->intval = (int)((s16)curr) * 1000;
+		val->intval = -(int)((s16)curr) * 1000;
 	}
 
 	return 0;
-- 
2.20.1

