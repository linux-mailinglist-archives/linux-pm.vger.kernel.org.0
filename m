Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEB0350AB9
	for <lists+linux-pm@lfdr.de>; Thu,  1 Apr 2021 01:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbhCaX1P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Mar 2021 19:27:15 -0400
Received: from mga12.intel.com ([192.55.52.136]:4846 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233048AbhCaX0r (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 31 Mar 2021 19:26:47 -0400
IronPort-SDR: IOdkt1rXMoGFY4n1pR/2e1rXsIY7AWIyeZb+Li4wdK9fTEg7knuPLYEJk+GiYxj/ajJBjv7IAb
 YqLIVr8ZyGdQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="171528083"
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="171528083"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 16:26:46 -0700
IronPort-SDR: KBaEEHfAMUyPl8/Nxxr+qT5mUb6pkm63N6LMX/XOKzr4DFT4WTRVKmF8zqHbnDFypkagkuKgfu
 Vdzf5W/m/QXw==
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="610685765"
Received: from dfrayn-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.146.236])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 16:26:45 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend,
        aka swsusp))
Subject: [PATCH 5/7] PM: clk: remove kernel-doc warning
Date:   Wed, 31 Mar 2021 18:26:12 -0500
Message-Id: <20210331232614.304591-6-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210331232614.304591-1-pierre-louis.bossart@linux.intel.com>
References: <20210331232614.304591-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Remove make W=1 warning:

drivers/base/power/clock_ops.c:148: warning: expecting prototype for
pm_clk_enable(). Prototype was for __pm_clk_enable() instead

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/base/power/clock_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
index 84d5acb6301b..0251f3e6e61d 100644
--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -140,7 +140,7 @@ static void pm_clk_op_unlock(struct pm_subsys_data *psd, unsigned long *flags)
 }
 
 /**
- * pm_clk_enable - Enable a clock, reporting any errors
+ * __pm_clk_enable - Enable a clock, reporting any errors
  * @dev: The device for the given clock
  * @ce: PM clock entry corresponding to the clock.
  */
-- 
2.25.1

