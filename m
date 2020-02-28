Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE0F173EC5
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2020 18:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725769AbgB1RrX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Feb 2020 12:47:23 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:35802 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgB1RrX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Feb 2020 12:47:23 -0500
Received: by mail-pj1-f67.google.com with SMTP id q39so1595387pjc.0;
        Fri, 28 Feb 2020 09:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/ePEVzu9e29X32t3wuKx/BpiwqdFAtZzo2j4Ye/PyAI=;
        b=LJm/yUMM8qY9Sd7VgQAu2efugQyMRzQkJf2M7pKJfKSeC7+Y3MqFWqPOePjptFMcX4
         0BjwICO4gfEeGTmNXsuBua+5tT9yIn8mLlbKmw9lv+vfxShZRV3rYB3PZ4I+bNXGLFUd
         mI/gsu14IHvA3EP8rggSh67w//AI91K/Y7ygE7i1upuVdQztAVcL5s5kJE41nPWpn8wI
         MroZov9GYjLvOlW1i3mFuFQn8/IFT8Y/S1wlaDgl4etydLwrrDu448tCcvlAWUpiloKf
         79UQzRAQ2ZaFQxJY2W3r1fLlF/fii7qXwpJ6NcmHbNeGLGGpCajUuzSMu9NduI8gtw1W
         BHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/ePEVzu9e29X32t3wuKx/BpiwqdFAtZzo2j4Ye/PyAI=;
        b=MursuXD8KJno2mF/HqKzwLn3pSMEGiKtNBY19qEWnv2OFYzwVHbij4CZ0QPZQsFZ19
         KkWQwqC0C/jfe2msuG1Ro61MnHbQcQ3YBvqMRQHgWI6YWY5L0j7wJO7dwB2owRTHNcA5
         o/Xwy2Lovj6zCsFPDR6iFko95k49nUsfSdIH2Yi99dMcf6X4HNyqFYwetGamlI5ZjxhK
         ijEtoZ/OdDfC+eBPD16pwzTCwQA5BvMqt4VpqHmXlgpxSG5c/Bvu5iD+Fl1kIRliX5GH
         qegAHiZF79V8lyBSjGButJ7JfbHkd4IeYdPgFieaREAOYuQ27Ap50+nBAREr8riIB6zf
         WEvA==
X-Gm-Message-State: APjAAAXyy9+NJCNe+OkkPewrARTT1QNN3GdYmriLzs+fei+8lXH3OC7i
        Q9H73vdhYmm49TFwVHHMSQ==
X-Google-Smtp-Source: APXvYqx7VY1S5VZYqBM44Swe2WbZnQNZrK1WgQqQMKKWRP0e7OmJ4tiGUUnHgIfsmoPTjpkOwsYoWA==
X-Received: by 2002:a17:90a:cf11:: with SMTP id h17mr5967943pju.103.1582912041716;
        Fri, 28 Feb 2020 09:47:21 -0800 (PST)
Received: from madhuparna-HP-Notebook.nitk.ac.in ([2402:3a80:55e:f10b:ac46:7428:aa52:2d70])
        by smtp.gmail.com with ESMTPSA id y15sm10679874pgj.78.2020.02.28.09.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 09:47:21 -0800 (PST)
From:   madhuparnabhowmik10@gmail.com
To:     rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com,
        gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, frextrite@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org, paulmck@kernel.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Subject: [PATCH 1/2] drivers: base: power: main: Use built-in RCU list checking
Date:   Fri, 28 Feb 2020 23:16:30 +0530
Message-Id: <20200228174630.8989-1-madhuparnabhowmik10@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

This patch passes the cond argument to list_for_each_entry_rcu()
to fix the following false-positive lockdep warnings:

[  330.302784] =============================
[  330.302789] WARNING: suspicious RCU usage
[  330.302796] 5.6.0-rc1+ #5 Not tainted
[  330.302801] -----------------------------
[  330.302808] drivers/base/power/main.c:326 RCU-list traversed in non-reader section!!

[  330.303303] =============================
[  330.303307] WARNING: suspicious RCU usage
[  330.303311] 5.6.0-rc1+ #5 Not tainted
[  330.303315] -----------------------------
[  330.303319] drivers/base/power/main.c:1698 RCU-list traversed in non-reader section!!

[  331.934969] =============================
[  331.934971] WARNING: suspicious RCU usage
[  331.934973] 5.6.0-rc1+ #5 Not tainted
[  331.934975] -----------------------------
[  331.934977] drivers/base/power/main.c:1238 RCU-list traversed in non-reader section!!

[  332.467772] WARNING: suspicious RCU usage
[  332.467775] 5.6.0-rc1+ #5 Not tainted
[  332.467775] -----------------------------
[  332.467778] drivers/base/power/main.c:269 RCU-list traversed in non-reader section!!

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
---
 drivers/base/power/main.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 0e99a760aebd..742c05f3c1e7 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -266,7 +266,8 @@ static void dpm_wait_for_suppliers(struct device *dev, bool async)
 	 * callbacks freeing the link objects for the links in the list we're
 	 * walking.
 	 */
-	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node)
+	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
+				device_links_read_lock_held())
 		if (READ_ONCE(link->status) != DL_STATE_DORMANT)
 			dpm_wait(link->supplier, async);
 
@@ -323,7 +324,8 @@ static void dpm_wait_for_consumers(struct device *dev, bool async)
 	 * continue instead of trying to continue in parallel with its
 	 * unregistration).
 	 */
-	list_for_each_entry_rcu(link, &dev->links.consumers, s_node)
+	list_for_each_entry_rcu(link, &dev->links.consumers, s_node,
+				 device_links_read_lock_held())
 		if (READ_ONCE(link->status) != DL_STATE_DORMANT)
 			dpm_wait(link->consumer, async);
 
@@ -1235,7 +1237,8 @@ static void dpm_superior_set_must_resume(struct device *dev)
 
 	idx = device_links_read_lock();
 
-	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node)
+	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
+				 device_links_read_lock_held())
 		link->supplier->power.must_resume = true;
 
 	device_links_read_unlock(idx);
@@ -1695,7 +1698,8 @@ static void dpm_clear_superiors_direct_complete(struct device *dev)
 
 	idx = device_links_read_lock();
 
-	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node) {
+	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
+				 device_links_read_lock_held()) {
 		spin_lock_irq(&link->supplier->power.lock);
 		link->supplier->power.direct_complete = false;
 		spin_unlock_irq(&link->supplier->power.lock);
-- 
2.17.1

