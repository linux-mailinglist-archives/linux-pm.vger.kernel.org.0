Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6BFF825E2
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2019 22:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbfHEUIy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Aug 2019 16:08:54 -0400
Received: from gateway33.websitewelcome.com ([192.185.145.87]:37515 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727460AbfHEUIy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Aug 2019 16:08:54 -0400
X-Greylist: delayed 1474 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Aug 2019 16:08:54 EDT
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id E9C9971092
        for <linux-pm@vger.kernel.org>; Mon,  5 Aug 2019 14:44:19 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id uiu3hEmXi3Qi0uiu3hyFNZ; Mon, 05 Aug 2019 14:44:19 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WZPbcno5kDstBvt8/14fBFARpkWyA04NEb7lNKhBwGo=; b=Od0w6vJjgFOjV4WuKR7HZjOgLO
        8TuIhgXjPRkicKU9lFgd6WQoTHi0q+24vrDj3y7WjG44MKbrSfs85etsIW2TQfFbXKkaEfJahLpqD
        +wuvNejPnQRI74S/vh3SPLono+L6uJlcJjnj9hrG4KlYgfob+REwCDSir0iOJ3ZlGNOoMPvilltbW
        7eJN+GNnMsg2qWCjjM7aLSqx4oo7HKADwTl1u1DZvK++mXGRZznSMKWyAAO3/2i8HTVgzNcj4R+01
        6N19tIierQic0sY61GLjt0lvYQZJdM01hR34NSZEd4GbE87k2WvhxuchvuktOzOaKPQQUAooxKGCz
        /Rqx/3RA==;
Received: from [187.192.11.120] (port=38214 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1huiu2-003O9k-Rw; Mon, 05 Aug 2019 14:44:18 -0500
Date:   Mon, 5 Aug 2019 14:44:18 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] power: supply: ab8500_charger: Mark expected switch
 fall-through
Message-ID: <20190805194418.GA14438@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.11.120
X-Source-L: No
X-Exim-ID: 1huiu2-003O9k-Rw
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:38214
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Mark switch cases where we are expecting to fall through.

This patch fixes the following warning (Building: allmodconfig arm):

drivers/power/supply/ab8500_charger.c:738:6: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/power/supply/ab8500_charger.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index 30de448de802..1be75a2fed9b 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -742,6 +742,7 @@ static int ab8500_charger_max_usb_curr(struct ab8500_charger *di,
 						USB_CH_IP_CUR_LVL_1P5;
 			break;
 		}
+		/* else, fall through */
 	case USB_STAT_HM_IDGND:
 		dev_err(di->dev, "USB Type - Charging not allowed\n");
 		di->max_usb_in_curr.usb_type_max = USB_CH_IP_CUR_LVL_0P05;
-- 
2.22.0

