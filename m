Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF71190D39
	for <lists+linux-pm@lfdr.de>; Tue, 24 Mar 2020 13:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbgCXMUc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Mar 2020 08:20:32 -0400
Received: from mga03.intel.com ([134.134.136.65]:4902 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727337AbgCXMU1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 24 Mar 2020 08:20:27 -0400
IronPort-SDR: 1J91S85GuyxS5YgY+RtGbMTfxETyAllcemjRweYFN8BoAiamCW390/dbcSmsyBKhRE/ze6V/pv
 dviBsTtGLq9A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 05:20:27 -0700
IronPort-SDR: w2UuZHQPtrOYo+rz0+T7luwq1AAVIMGhLOr4bvz8eNrs2Xvw95XhmtqM9EAaG0mr35bSIFQC6b
 mjCD6BFnRdAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,300,1580803200"; 
   d="scan'208";a="447859322"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 24 Mar 2020 05:20:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8E01D65; Tue, 24 Mar 2020 14:20:24 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ferry Toth <fntoth@gmail.com>
Subject: [PATCH v2 2/3] driver core: Read atomic counter once in driver_probe_done()
Date:   Tue, 24 Mar 2020 14:20:22 +0200
Message-Id: <20200324122023.9649-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200324122023.9649-1-andriy.shevchenko@linux.intel.com>
References: <20200324122023.9649-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Between printing the debug message and actual check atomic counter can be
altered. For better debugging experience read atomic counter value only once.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Ferry Toth <fntoth@gmail.com>
---
v2: picked up tags
 drivers/base/dd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 43720beb5300..efd0e4c16ba5 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -669,9 +669,10 @@ static int really_probe_debug(struct device *dev, struct device_driver *drv)
  */
 int driver_probe_done(void)
 {
-	pr_debug("%s: probe_count = %d\n", __func__,
-		 atomic_read(&probe_count));
-	if (atomic_read(&probe_count))
+	int local_probe_count = atomic_read(&probe_count);
+
+	pr_debug("%s: probe_count = %d\n", __func__, local_probe_count);
+	if (local_probe_count)
 		return -EBUSY;
 	return 0;
 }
-- 
2.25.1

