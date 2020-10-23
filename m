Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24EC296D40
	for <lists+linux-pm@lfdr.de>; Fri, 23 Oct 2020 13:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462587AbgJWLCe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Oct 2020 07:02:34 -0400
Received: from mga03.intel.com ([134.134.136.65]:19444 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S462539AbgJWLCd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 23 Oct 2020 07:02:33 -0400
IronPort-SDR: Qsn5xa3gojx3LSZk5pbzwitAUuhQ2zjsInc4HZk+D8HK9r0QmsMJHMxUeRXCHtEi7DO+78fElo
 VrZDBX54kxmA==
X-IronPort-AV: E=McAfee;i="6000,8403,9782"; a="167753448"
X-IronPort-AV: E=Sophos;i="5.77,408,1596524400"; 
   d="scan'208";a="167753448"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2020 04:02:26 -0700
IronPort-SDR: q1FWg+45L7+JkuPeQzL7GskBvC56WcPpAtJIQ+EkNjdvTM9Dh9u5PgR6XEjHN/EE8o3NmYIuAE
 xP3aAIuHSXPA==
X-IronPort-AV: E=Sophos;i="5.77,408,1596524400"; 
   d="scan'208";a="534359413"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2020 04:02:23 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH] PM / suspend: Print the driver flags of device during suspend resume
Date:   Fri, 23 Oct 2020 19:02:54 +0800
Message-Id: <20201023110254.26360-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently there are 4 driver flags to control system suspend/resume
behavior: DPM_FLAG_NO_DIRECT_COMPLETE, DPM_FLAG_SMART_PREPARE,
DPM_FLAG_SMART_SUSPEND and DPM_FLAG_MAY_SKIP_RESUME. Print these flags
during suspend resume so as to get a brief understanding of the
expected behavior of each device, and to facilitate suspend/resume
debugging/tuning.

To enable this tracing:
echo 'file drivers/base/power/main.c +p' >
/sys/kernel/debug/dynamic_debug/control

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/base/power/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 205a06752ca9..be6744bdfc93 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -442,9 +442,9 @@ static pm_callback_t pm_noirq_op(const struct dev_pm_ops *ops, pm_message_t stat
 
 static void pm_dev_dbg(struct device *dev, pm_message_t state, const char *info)
 {
-	dev_dbg(dev, "%s%s%s\n", info, pm_verb(state.event),
+	dev_dbg(dev, "%s%s%s driver flags: %x\n", info, pm_verb(state.event),
 		((state.event & PM_EVENT_SLEEP) && device_may_wakeup(dev)) ?
-		", may wakeup" : "");
+		", may wakeup" : "", dev->power.driver_flags);
 }
 
 static void pm_dev_err(struct device *dev, pm_message_t state, const char *info,
-- 
2.17.1

