Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3594B32C2FD
	for <lists+linux-pm@lfdr.de>; Thu,  4 Mar 2021 01:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350299AbhCDAAI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Mar 2021 19:00:08 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:50861 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357485AbhCCKuA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 3 Mar 2021 05:50:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1614768599; x=1646304599;
  h=from:to:cc:subject:date:message-id;
  bh=Lk8fMpF0BlGCPbPFLfDRN183I0CaSpoMX3F4ElWcTBQ=;
  b=aKwJ6Ufy9RxeRN6Jqk/CVlGZ6hWvjayl2jAeRhX5hnfhJuaVvr9fLOqi
   Duv0J1AjNi/IEndg0PBkO8STf2EpLe2QNZlp3QsOoq7ScpFsRwjKxp5Oq
   rDS2V542mRdMNtvpSzXI0gUNCfjo6R8PBgz1GwAEjOT1uOEovC4wiXYuo
   deXy4w5quk1MimM5nM7dNupxIAIKC+FMe6irkuo919NiiDV+jx91GtTFx
   CbqmhX9oEqcucFc4b0RV+3GpZt1oY0RVE4W+3ywKKcN2dDfVJ8Mf+ZCGo
   kDyPewTFncgSW7Z/Lu0yTAqWX9O/eQ9aTgjLDg4PfzZXpM+EGaVVio8UT
   w==;
IronPort-SDR: NYOsdZeS9zpQ4EHROOlzU537W1uPHSrS6hesMcOy9wPzv2uoMVaBuQgErTmCGiNt6OBWaokaiN
 u0BtzgyPrfuIjLwe2uF4YAHCR3E7dIady6moJmalMY9Hi1Huk662AuAJ/5aPNzXKF8zPMObBwN
 wjVbdY4gspOBSKBd+SlMpVhzWT/YJsV0sSGeWL4t4czyeqyPueZh2Qv0j2R/U92BdV2YtEgXep
 cO8J2AcVKkEo1/6cuT7tcy/N1gF26cqnlz2yb2pP/4BdhgtiJSdLNtdDCmfRTbINuBc99/HE5K
 fWw=
X-IronPort-AV: E=Sophos;i="5.81,219,1610406000"; 
   d="scan'208";a="16258530"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 03 Mar 2021 10:54:40 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 03 Mar 2021 10:54:40 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 03 Mar 2021 10:54:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1614765280; x=1646301280;
  h=from:to:cc:subject:date:message-id;
  bh=Lk8fMpF0BlGCPbPFLfDRN183I0CaSpoMX3F4ElWcTBQ=;
  b=p/M+Ska/H9lyRz4kadHfbXhf5C6sZwDqi+lN0NCAilEY3CCpGh/Q0MRO
   RsbWGjvvfumBFMS/jIRbTlH+860DbxF5YcBRYkTs5aKvONS4Z0FN6SL4K
   8L2tJu6jyhoPgpg1NrksuM+8DibeI8Wpwlrt/4kfGPa4WMcB5PPdB7v8G
   AOO6d71Q/XTG4MRYbLpxN0eJ8EJETN+vfyVdWA0ubzP5VbMM4NxMkLEfQ
   lrUiM9MHwoKL1ebo7IaAjbSDDStOzUvdjT3U/GtCEoSiAQFMtneMXaAwa
   bcjRDKHkaqvRKptCSDKNLFqdKqZj47aJcV5l+2jsEfExu4GuZ7QAT0H7x
   g==;
IronPort-SDR: z9+Bf9AS9rc7mlWXH6r2Y9TNt04GEQrbf0GJD9vb93NVKtnY60ZiuMpWgrWFzSEyxp7rwa61UF
 UPjh43W4Uk2h2NlGqbw9XM8sDFeKY7dDxt4TKeVLFiRco5VLdquhpNiSOqXh61CUdUz2x77Kdg
 m+d4espDuQYlBO0mnNRZzYC69IairUDIQpfIsptvvjiqdVmurWNKUfzBknbAqnyRjK7BTY8/qL
 xHlg9y+WGGOTXDkS9yWZds12cFAPfDvFCfa6mAXY8XTxbb6CPc2XeURZBRndhKxVoK4KmYInOv
 pys=
X-IronPort-AV: E=Sophos;i="5.81,219,1610406000"; 
   d="scan'208";a="16258529"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 03 Mar 2021 10:54:40 +0100
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.121.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id C6E29280070;
        Wed,  3 Mar 2021 10:54:39 +0100 (CET)
X-CheckPoint: {603F5CDC-2-6615631E-D10D9432}
X-MAIL-CPID: 0F55706C1DA52CCAE30BBBD14F1BC4BB_2
X-Control-Analysis: str=0001.0A782F1F.603F5CE0.0018,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v2 1/3] power: supply: bq27xxx: fix sign of current_now for newer ICs
Date:   Wed,  3 Mar 2021 10:54:18 +0100
Message-Id: <20210303095420.29054-1-matthias.schiffer@ew.tq-group.com>
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

v2: no changes

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

