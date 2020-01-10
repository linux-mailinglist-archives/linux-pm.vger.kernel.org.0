Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B99D136A99
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2020 11:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbgAJKIQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jan 2020 05:08:16 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:45009 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbgAJKIQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jan 2020 05:08:16 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iprDA-0008VQ-EW; Fri, 10 Jan 2020 10:08:12 +0000
From:   Colin King <colin.king@canonical.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] PM: hibernate: fix spelling mistake "shapshot" -> "snapshot"
Date:   Fri, 10 Jan 2020 10:08:12 +0000
Message-Id: <20200110100812.236881-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a pr_info message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 kernel/power/snapshot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 353c5e9070ed..befe3c94767c 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1841,7 +1841,7 @@ int hibernate_preallocate_memory(void)
 
  out:
 	stop = ktime_get();
-	pr_info("Allocated %lu pages for shapshot\n", pages);
+	pr_info("Allocated %lu pages for snapshot\n", pages);
 	swsusp_show_speed(start, stop, pages, "Allocated");
 
 	return 0;
-- 
2.24.0

