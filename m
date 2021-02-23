Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D41ED322C1D
	for <lists+linux-pm@lfdr.de>; Tue, 23 Feb 2021 15:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbhBWOWJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Feb 2021 09:22:09 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:51339 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232372AbhBWOWD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Feb 2021 09:22:03 -0500
X-Greylist: delayed 553 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Feb 2021 09:22:00 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1614090122; x=1645626122;
  h=from:to:cc:subject:date:message-id;
  bh=2fp/h+MFy4C94ZBy2aHYmsFqKEX/f1YM6UAUvV3YSYo=;
  b=XpIiwwsfms8Bq3JeUp79MBLM/YWThsqjAq70mKowDA2bcgQmIxz0VQX0
   rsWXOuvkoqeD3+En570Of9xj4H0zMRbO4clTLoImKBhKzTn6ZhqW4hq7A
   r87Pmg7AsEBawephKOcnOvUUIYJ4yswYb3+VQkg7LbSOvRqD6+XCuaTJw
   i5dzJLbl0a68ARfdoYPsWEq4t6qQlJzvwZXlg1YKmZNbht/mGNEaD3UuO
   7ZyCicyuX2/9vlDoNBHH2NecXura0220PAXKfQoMWC8lRwND1dsMk1/u6
   /Gdos0nuTAcq3U99a1FcWl7khEmWSgNAMTvqZY/vcRtNh0eXbvxKnyeQB
   g==;
IronPort-SDR: oCBYHjBgw25+TMhwbpZ/YBi7ACG7FpjjKIRXkH002gLmwynxEpxzuCPnvg2ms1z76QJ92MCFV0
 Tl//hqWd5AeymTSubJCy4fh6lduh0CC8Am7L/hukVmerlg+GZ09QnAYi3rn4wK/Y9TRTxAW/kI
 2HxLXcJTDeIJQMmratUlVGopIPy1evDCcbqB2Wu66fIT9s7RVx541sgsDXeagdxKRoWXImU+Bt
 /e5SMnfiqbdwIZnHNI39gu+kMPApDIfHwtkyZpdvMuAMYfRs58tARoILJh22GFPPgk92i3tGku
 xng=
X-IronPort-AV: E=Sophos;i="5.81,200,1610406000"; 
   d="scan'208";a="16125540"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 23 Feb 2021 15:12:04 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 23 Feb 2021 15:12:04 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 23 Feb 2021 15:12:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1614089524; x=1645625524;
  h=from:to:cc:subject:date:message-id;
  bh=2fp/h+MFy4C94ZBy2aHYmsFqKEX/f1YM6UAUvV3YSYo=;
  b=UjE7DYIiyrdvncNx7vto7fP8Y1WH6ZLiNS1UhS5r3sHFmKeQ7JnpcgDR
   aYWxdzp0YFEE7DYHkXtACp7fu4dBvnZDX4mMuj3nVw3wF5P3bVbIFUanc
   Mc72+JtPsvJwWrhvT3FtJJB7VEFfMgd/U61AdzCo51yzOc/1zYNoHJLAZ
   hXpTuPUmAi1N943P4RD7I6Qe0U8zjdxYshtx4wsspty0VWqBCkdSPk+8p
   gg0LIhgL5ihxcFYNPEgDJXhI8dsw46nXOharl+zkaRX0D/lwT7r+YMXeo
   Ao6ymAmdFD/yznS6mjMc37m8Xd5Gu9WivtyoiQ6vpJvTQwkpEJa/aukTX
   w==;
IronPort-SDR: 8tnXJ4h3EdfEFzdjsuzZ448E/V+k5LhiTO0OH4Xsfql+BP+tWkte+sa80HMI+KADGdep8PTwMY
 TR+1SOEMqtDblhyO1Wvg5w4QzDjpHEIFjkO5Z3iA0MKWmmPmWHpKHb+geSF0g6JcV9gfhfxDvj
 DheZJQd63SxO64AozQmqS4KQrx9/T0jzg5DYf2SqAIJ2QM7P8Jw8bMtwNRYXsLPM1T/L8g3jKO
 Gk/IGmnuaqCLJWPNJ7Zeyfnv10RRNR6+6yIuGeiTSFnKvnpXdIqrhQgiJhCFUmcVzy7Ne8zX5J
 1VE=
X-IronPort-AV: E=Sophos;i="5.81,200,1610406000"; 
   d="scan'208";a="16125539"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 23 Feb 2021 15:12:04 +0100
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.121.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 8DE40280070;
        Tue, 23 Feb 2021 15:12:04 +0100 (CET)
X-CheckPoint: {60350D2A-41-8E0BEC96-E002885D}
X-MAIL-CPID: A7A44E8E2DA0280225A603E4669CA7E3_4
X-Control-Analysis: str=0001.0A782F1B.60350D34.00E7,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Dan Murphy <dmurphy@ti.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 1/3] power: supply: bq27xxx: fix sign of current_now for newer ICs
Date:   Tue, 23 Feb 2021 15:11:20 +0100
Message-Id: <20210223141122.9574-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Commit cd060b4d0868 ("power: supply: bq27xxx: fix polarity of current_now")
changed the sign of current_now for all bq27xxx variants, but on BQ28Z610
I'm now seeing negated values *with* that patch.

The GTA04/Openmoko device that was used for testing uses a BQ27000 or
BQ27010 IC, so I assume only the BQ27XXX_O_ZERO code path was incorrect.
Revert the behaviour for newer ICs.

Fixes: cd060b4d0868 "power: supply: bq27xxx: fix polarity of current_now"
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

@Andreas Kemnade: It would be great to get a confirmation that the
Openmoko battery indeed uses BQ27000/BQ27010 - I was having some trouble
finding that information.


 drivers/power/supply/bq27xxx_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 4c4a7b1c64c5..cb6ebd2f905e 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1827,7 +1827,7 @@ static int bq27xxx_battery_current(struct bq27xxx_device_info *di,
 		val->intval = curr * BQ27XXX_CURRENT_CONSTANT / BQ27XXX_RS;
 	} else {
 		/* Other gauges return signed value */
-		val->intval = -(int)((s16)curr) * 1000;
+		val->intval = (int)((s16)curr) * 1000;
 	}
 
 	return 0;
-- 
2.17.1

