Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A943B8B65
	for <lists+linux-pm@lfdr.de>; Thu,  1 Jul 2021 02:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238193AbhGAAsO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Jun 2021 20:48:14 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:46355 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237629AbhGAAsO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Jun 2021 20:48:14 -0400
X-UUID: c2b8a374425b4b68ba03d53489946f73-20210701
X-UUID: c2b8a374425b4b68ba03d53489946f73-20210701
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1162423325; Thu, 01 Jul 2021 08:45:41 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 1 Jul 2021 08:45:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 1 Jul 2021 08:45:40 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <gregkh@linuxfoundation.org>
CC:     <matthias.bgg@gmail.com>, <rjw@rjwysocki.net>, <pavel@ucw.cz>,
        <len.brown@intel.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <mark-pk.tsai@mediatek.com>,
        <yj.chiang@mediatek.com>
Subject: [PATCH] PM: sleep: use ktime_us_delta in initcall_debug_report()
Date:   Thu, 1 Jul 2021 08:45:38 +0800
Message-ID: <20210701004538.23483-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

usecs is no more used after trace_device_pm_report_time replaced
by device_pm_callback_start/end in the below change.

commit e8bca479c3f2 ("PM / sleep: trace events for device PM callbacks")

Use ktime_us_delta to make the debug log more precise instead of
nsecs >> 10.

Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
---
 drivers/base/power/main.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index f893c3c5af07..d568772152c2 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -220,16 +220,13 @@ static void initcall_debug_report(struct device *dev, ktime_t calltime,
 				  void *cb, int error)
 {
 	ktime_t rettime;
-	s64 nsecs;
 
 	if (!pm_print_times_enabled)
 		return;
 
 	rettime = ktime_get();
-	nsecs = (s64) ktime_to_ns(ktime_sub(rettime, calltime));
-
 	dev_info(dev, "%pS returned %d after %Ld usecs\n", cb, error,
-		 (unsigned long long)nsecs >> 10);
+		 (unsigned long long)ktime_us_delta(rettime, calltime));
 }
 
 /**
-- 
2.18.0

