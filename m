Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBC554A576
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2019 17:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbfFRPeX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Jun 2019 11:34:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:57878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729189AbfFRPeX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 18 Jun 2019 11:34:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 860A920673;
        Tue, 18 Jun 2019 15:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560872063;
        bh=9D/42xyOb+KaqTJ5nNJs2LH1myBYgLNC9AstkAR3VTk=;
        h=From:To:Cc:Subject:Date:From;
        b=dcsjRBVz5mzwY+pR9PGdkV5MMRPBCqVygARs5czZ0SeDmbi/FdMI516/pbu6aYrUc
         IsT3NTypIrcWZktv9zJShRwQbqcGYc+PISfmQnK5V+zvoGwDRB+xhmP6iYhbataOSX
         hUYcTmOgkdVR76nzInP9JZ472vU/4XZa3Q1wbbcI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     rjw@rjwysocki.net
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH] drivers: base: power: remove wakeup_sources_stats_dentry variable
Date:   Tue, 18 Jun 2019 17:34:16 +0200
Message-Id: <20190618153416.6786-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

wakeup_sources_stats_dentry is assigned when the debugfs file is
created, but then never used ever again.  So no need for it at all, just
remove it and call debugfs_create_file() on its own.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/power/wakeup.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 5b2b6a05a4f3..ee31d4f8d856 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -968,8 +968,6 @@ void pm_wakep_autosleep_enabled(bool set)
 }
 #endif /* CONFIG_PM_AUTOSLEEP */
 
-static struct dentry *wakeup_sources_stats_dentry;
-
 /**
  * print_wakeup_source_stats - Print wakeup source statistics information.
  * @m: seq_file to print the statistics into.
@@ -1099,8 +1097,8 @@ static const struct file_operations wakeup_sources_stats_fops = {
 
 static int __init wakeup_sources_debugfs_init(void)
 {
-	wakeup_sources_stats_dentry = debugfs_create_file("wakeup_sources",
-			S_IRUGO, NULL, NULL, &wakeup_sources_stats_fops);
+	debugfs_create_file("wakeup_sources", S_IRUGO, NULL, NULL,
+			    &wakeup_sources_stats_fops);
 	return 0;
 }
 
-- 
2.22.0

