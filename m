Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4FF350ABA
	for <lists+linux-pm@lfdr.de>; Thu,  1 Apr 2021 01:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbhCaX1P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Mar 2021 19:27:15 -0400
Received: from mga12.intel.com ([192.55.52.136]:4846 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232994AbhCaX0p (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 31 Mar 2021 19:26:45 -0400
IronPort-SDR: WgFnvD9EaNbYkFuVurB3RYCIS3vAyAmvDRAO+k4UX7d1Gs2rbRCF2NcPjN1xsxa2D8iq98yCEP
 zq6lQv53TAHg==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="171528077"
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="171528077"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 16:26:45 -0700
IronPort-SDR: YdVgIW+2reo/4T7hpnQTUqXDM4q1s9A8gBwYLEGiVs2xHSH6ysWVqAYBKErReMOidEDNmu4xbd
 rJKVSX/wOPqg==
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="610685756"
Received: from dfrayn-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.146.236])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 16:26:43 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org (open list:SUSPEND TO RAM)
Subject: [PATCH 4/7] PM: wakeup: fix kernel-doc warnings and fix typos
Date:   Wed, 31 Mar 2021 18:26:11 -0500
Message-Id: <20210331232614.304591-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210331232614.304591-1-pierre-louis.bossart@linux.intel.com>
References: <20210331232614.304591-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Remove make W=1 warnings and fit 'Itereates' typos

drivers/base/power/wakeup.c:403: warning: wrong kernel-doc identifier on line:
 * device_wakeup_arm_wake_irqs(void)

drivers/base/power/wakeup.c:419: warning: wrong kernel-doc identifier on line:
 * device_wakeup_disarm_wake_irqs(void)

drivers/base/power/wakeup.c:537: warning: Function parameter or member
'enable' not described in 'device_set_wakeup_enable'

drivers/base/power/wakeup.c:592: warning: expecting prototype for
wakup_source_activate(). Prototype was for wakeup_source_activate()
instead

drivers/base/power/wakeup.c:697: warning: expecting prototype for
wakup_source_deactivate(). Prototype was for
wakeup_source_deactivate() instead

drivers/base/power/wakeup.c:795: warning: Function parameter or member
't' not described in 'pm_wakeup_timer_fn'

drivers/base/power/wakeup.c:795: warning: Excess function parameter
'data' description in 'pm_wakeup_timer_fn'

drivers/base/power/wakeup.c:1027: warning: Function parameter or
member 'set' not described in 'pm_wakep_autosleep_enabled'

drivers/base/power/wakeup.c:1027: warning: Excess function parameter
'enabled' description in 'pm_wakep_autosleep_enabled'

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/base/power/wakeup.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 92073ac68473..f0b37c188514 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -400,9 +400,9 @@ void device_wakeup_detach_irq(struct device *dev)
 }
 
 /**
- * device_wakeup_arm_wake_irqs(void)
+ * device_wakeup_arm_wake_irqs -
  *
- * Itereates over the list of device wakeirqs to arm them.
+ * Iterates over the list of device wakeirqs to arm them.
  */
 void device_wakeup_arm_wake_irqs(void)
 {
@@ -416,9 +416,9 @@ void device_wakeup_arm_wake_irqs(void)
 }
 
 /**
- * device_wakeup_disarm_wake_irqs(void)
+ * device_wakeup_disarm_wake_irqs -
  *
- * Itereates over the list of device wakeirqs to disarm them.
+ * Iterates over the list of device wakeirqs to disarm them.
  */
 void device_wakeup_disarm_wake_irqs(void)
 {
@@ -532,6 +532,7 @@ EXPORT_SYMBOL_GPL(device_init_wakeup);
 /**
  * device_set_wakeup_enable - Enable or disable a device to wake up the system.
  * @dev: Device to handle.
+ * @enable: enable/disable flag
  */
 int device_set_wakeup_enable(struct device *dev, bool enable)
 {
@@ -581,7 +582,7 @@ static bool wakeup_source_not_registered(struct wakeup_source *ws)
  */
 
 /**
- * wakup_source_activate - Mark given wakeup source as active.
+ * wakeup_source_activate - Mark given wakeup source as active.
  * @ws: Wakeup source to handle.
  *
  * Update the @ws' statistics and, if @ws has just been activated, notify the PM
@@ -686,7 +687,7 @@ static inline void update_prevent_sleep_time(struct wakeup_source *ws,
 #endif
 
 /**
- * wakup_source_deactivate - Mark given wakeup source as inactive.
+ * wakeup_source_deactivate - Mark given wakeup source as inactive.
  * @ws: Wakeup source to handle.
  *
  * Update the @ws' statistics and notify the PM core that the wakeup source has
@@ -785,7 +786,7 @@ EXPORT_SYMBOL_GPL(pm_relax);
 
 /**
  * pm_wakeup_timer_fn - Delayed finalization of a wakeup event.
- * @data: Address of the wakeup source object associated with the event source.
+ * @t: timer list
  *
  * Call wakeup_source_deactivate() for the wakeup source whose address is stored
  * in @data if it is currently active and its timer has not been canceled and
@@ -1021,7 +1022,7 @@ bool pm_save_wakeup_count(unsigned int count)
 #ifdef CONFIG_PM_AUTOSLEEP
 /**
  * pm_wakep_autosleep_enabled - Modify autosleep_enabled for all wakeup sources.
- * @enabled: Whether to set or to clear the autosleep_enabled flags.
+ * @set: Whether to set or to clear the autosleep_enabled flags.
  */
 void pm_wakep_autosleep_enabled(bool set)
 {
-- 
2.25.1

