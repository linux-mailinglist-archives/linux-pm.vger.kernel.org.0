Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B451DEB82
	for <lists+linux-pm@lfdr.de>; Fri, 22 May 2020 17:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730288AbgEVPJ7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 May 2020 11:09:59 -0400
Received: from mga07.intel.com ([134.134.136.100]:51580 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729931AbgEVPJ7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 22 May 2020 11:09:59 -0400
IronPort-SDR: V+aAXBWQyfi/d1kAEU5BB9wJfJERrKL1r/PCtPiunHzTj4hyEqodq7UgGJEm0C5/16X77btDHL
 +TdTxYKcYBRA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2020 08:09:58 -0700
IronPort-SDR: 2jn8BY/M/jV+/9S7+y8MTnvLJxohHXbErBp9HxVj/ipA8opS/TRgiMmIU4udLQL5KpR7Sj5jRm
 M5yi0VgsJfwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,422,1583222400"; 
   d="scan'208";a="309392734"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 22 May 2020 08:09:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 01F8C449; Fri, 22 May 2020 18:09:56 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] PM-runtime: Make clear what we do when conditions are wrong in rpm_suspend()
Date:   Fri, 22 May 2020 18:09:55 +0300
Message-Id: <20200522150955.40569-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

rpm_suspend() simple bails out when conditions are wrong. But this is not
immediately obvious from the code.  Make it clear what we do when conditions
are wrong in rpm_suspend().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/power/runtime.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 99c7da112c95..9f62790f644c 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -523,13 +523,11 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 
  repeat:
 	retval = rpm_check_suspend_allowed(dev);
-
 	if (retval < 0)
-		;	/* Conditions are wrong. */
+		goto out;	/* Conditions are wrong. */
 
 	/* Synchronous suspends are not allowed in the RPM_RESUMING state. */
-	else if (dev->power.runtime_status == RPM_RESUMING &&
-	    !(rpmflags & RPM_ASYNC))
+	if (dev->power.runtime_status == RPM_RESUMING && !(rpmflags & RPM_ASYNC))
 		retval = -EAGAIN;
 	if (retval)
 		goto out;
-- 
2.26.2

