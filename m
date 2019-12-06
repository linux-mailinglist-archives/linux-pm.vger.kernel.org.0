Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E21A01150F8
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2019 14:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfLFNX4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Dec 2019 08:23:56 -0500
Received: from baptiste.telenet-ops.be ([195.130.132.51]:60314 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfLFNX4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Dec 2019 08:23:56 -0500
Received: from ramsan ([84.195.182.253])
        by baptiste.telenet-ops.be with bizsmtp
        id adPu2100G5USYZQ01dPuM7; Fri, 06 Dec 2019 14:23:54 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1idDaM-0006C6-7a; Fri, 06 Dec 2019 14:23:54 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1idDaM-0007Z7-5s; Fri, 06 Dec 2019 14:23:54 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] block: Make request_queue.rpm_status an enum
Date:   Fri,  6 Dec 2019 14:23:50 +0100
Message-Id: <20191206132350.29040-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

request_queue.rpm_status is assigned values of the rpm_status enum only,
so reflect that in its type.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Perhaps this was done to avoid the need to #include <linux/pm.h>?
Let's see what kbuild has to report about this...
---
 include/linux/blkdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 397bb9bc230b6349..6419cd9523c370f8 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -466,7 +466,7 @@ struct request_queue {
 
 #ifdef CONFIG_PM
 	struct device		*dev;
-	int			rpm_status;
+	enum rpm_status		rpm_status;
 	unsigned int		nr_pending;
 #endif
 
-- 
2.17.1

