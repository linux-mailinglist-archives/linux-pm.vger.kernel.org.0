Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D7E35F447
	for <lists+linux-pm@lfdr.de>; Wed, 14 Apr 2021 14:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347460AbhDNMxZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Apr 2021 08:53:25 -0400
Received: from mga02.intel.com ([134.134.136.20]:43895 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233219AbhDNMxY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 14 Apr 2021 08:53:24 -0400
IronPort-SDR: CMRkoYIJh6iXqzY6evPLHFK3GEfDjSewTrZzGw50vOpcMbEzowbFAZVJ5M0neuqSgNX2/T4KOF
 YltwgqHVwZDA==
X-IronPort-AV: E=McAfee;i="6200,9189,9953"; a="181752898"
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; 
   d="scan'208";a="181752898"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 05:52:59 -0700
IronPort-SDR: gBmXIM8veVAxT7Hn07lrxXQ362rYwApjt03bfEfQ8myftldKBvfA7LoHUU3Nhr+oDeffy2i9Fh
 p6cmIuF10h9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; 
   d="scan'208";a="383667999"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 14 Apr 2021 05:52:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 356B012A; Wed, 14 Apr 2021 15:53:13 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Joe Perches <joe@perches.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] PM / wakeup: use dev_set_name() directly
Date:   Wed, 14 Apr 2021 15:53:10 +0300
Message-Id: <20210414125310.10900-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We have open coded dev_set_name() implementation, replace that
with a direct call.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/power/wakeup_stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/wakeup_stats.c b/drivers/base/power/wakeup_stats.c
index d638259b829a..5ade7539ac02 100644
--- a/drivers/base/power/wakeup_stats.c
+++ b/drivers/base/power/wakeup_stats.c
@@ -154,7 +154,7 @@ static struct device *wakeup_source_device_create(struct device *parent,
 	dev_set_drvdata(dev, ws);
 	device_set_pm_not_required(dev);
 
-	retval = kobject_set_name(&dev->kobj, "wakeup%d", ws->id);
+	retval = dev_set_name(dev, "wakeup%d", ws->id);
 	if (retval)
 		goto error;
 
-- 
2.30.2

