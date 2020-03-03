Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32FD317833D
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 20:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgCCTlp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Mar 2020 14:41:45 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:33209 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730939AbgCCTlp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2020 14:41:45 -0500
Received: by mail-pj1-f67.google.com with SMTP id o21so52639pjs.0;
        Tue, 03 Mar 2020 11:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nELp/JsIU8Whx16SjmYjwVpYKQX+kqJ7/7LVzOVJkmo=;
        b=vZPrj14uv3brvCc5Zu4zoCn5pF7y85BGE0/vRBHEKsRUwrqxCy77nkHfvV66kJ4vpo
         yF7PHSNtCOlkU4XQcyRIgXI2BiZzQexki5PUHzjuXl9gF78LwYLC1AcNS0qaAffcLuMD
         lakqLTcF7mnyMDz8mEfRyeZ2/tZ8PICJlzM9oYSeYjJ0ZdtgZN+CbGgQxDtPm2I08V+3
         8XGPl7OkBY5u8QnnrHTXDwYMadY7nKaSLLhIE7zmrJH+j0+K5cl1rcLkP8iWz/oSmzQ9
         9CzwFdLxwC16gQKYIRyFPb90uC21gVPa1tsxnWdMav0cKE/MfXRSvZK4mZlgdULptVnA
         xCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nELp/JsIU8Whx16SjmYjwVpYKQX+kqJ7/7LVzOVJkmo=;
        b=nTpbEJjDQ6+Uc9XS01GzfP2c2Cn9KDsjhP+pVez9K0I5dV+/60tsY9ruakjZXCH6Kh
         dOe1htDUyehFOXSQjI/xm5eh2FFnve+4dkcsTkFeZF5tT1iAHtnNxFXCkWQODOlDp63Q
         KxWjxGR+30q//+gFZU/Ugfj/IJN5rWGZrMOYiy/bYy1yYw5KINOa8YR9GMt2QX04ZQRU
         hCy/KWfFFcMRke3k0Zkpez//ELP+ohc4gauE4UC8kTEG9cXQmmGBJgOqPMr7SyKgJajz
         lO8/wVNZU7ZKjospUdDzZ+gLcwkIXhcchbLer32gfaopwy5j76BbbkPRtqvABxK+f6AY
         Mrtw==
X-Gm-Message-State: ANhLgQ1k7w3DibQRDxEuXsSei+GELGENJNIy5bEZ0/zB1tJGMWm7fY2y
        +YdLIYnL/KqVxUmfN7jJ6jMwoMM=
X-Google-Smtp-Source: ADFU+vssPo5v9dRFhOkIA1Dbts1aFq2on91LBCVkSuAiPbQX5egOR8N8CD0FO2dxqsABmXgPcfi+2g==
X-Received: by 2002:a17:90a:eb0b:: with SMTP id j11mr127353pjz.145.1583264504055;
        Tue, 03 Mar 2020 11:41:44 -0800 (PST)
Received: from madhuparna-HP-Notebook.nitk.ac.in ([2402:3a80:1ee0:eafa:280b:b5cb:5e89:a52d])
        by smtp.gmail.com with ESMTPSA id w2sm25279628pfw.43.2020.03.03.11.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 11:41:42 -0800 (PST)
From:   madhuparnabhowmik10@gmail.com
To:     rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com,
        gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, frextrite@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org, paulmck@kernel.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Subject: [PATCH 1/2] drivers: base: power: main.c: Use built-in RCU list checking
Date:   Wed,  4 Mar 2020 01:11:30 +0530
Message-Id: <20200303194130.24617-1-madhuparnabhowmik10@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

This patch passes the cond argument to list_for_each_entry_rcu()
to fix the following false-positive lockdep warnings:
(with CONFIG_PROVE_RCU_LIST = y)

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
index 0e99a760aebd..6d1dee7051eb 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -40,6 +40,10 @@
 
 typedef int (*pm_callback_t)(struct device *);
 
+#define list_for_each_entry_rcu_locked(pos, head, member) \
+	list_for_each_entry_rcu(pos, head, member, \
+			device_links_read_lock_held())
+
 /*
  * The entries in the dpm_list list are in a depth first order, simply
  * because children are guaranteed to be discovered after parents, and
@@ -266,7 +270,7 @@ static void dpm_wait_for_suppliers(struct device *dev, bool async)
 	 * callbacks freeing the link objects for the links in the list we're
 	 * walking.
 	 */
-	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node)
+	list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node)
 		if (READ_ONCE(link->status) != DL_STATE_DORMANT)
 			dpm_wait(link->supplier, async);
 
@@ -323,7 +327,7 @@ static void dpm_wait_for_consumers(struct device *dev, bool async)
 	 * continue instead of trying to continue in parallel with its
 	 * unregistration).
 	 */
-	list_for_each_entry_rcu(link, &dev->links.consumers, s_node)
+	list_for_each_entry_rcu_locked(link, &dev->links.consumers, s_node)
 		if (READ_ONCE(link->status) != DL_STATE_DORMANT)
 			dpm_wait(link->consumer, async);
 
@@ -1235,7 +1239,7 @@ static void dpm_superior_set_must_resume(struct device *dev)
 
 	idx = device_links_read_lock();
 
-	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node)
+	list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node)
 		link->supplier->power.must_resume = true;
 
 	device_links_read_unlock(idx);
@@ -1695,7 +1699,7 @@ static void dpm_clear_superiors_direct_complete(struct device *dev)
 
 	idx = device_links_read_lock();
 
-	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node) {
+	list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node) {
 		spin_lock_irq(&link->supplier->power.lock);
 		link->supplier->power.direct_complete = false;
 		spin_unlock_irq(&link->supplier->power.lock);
-- 
2.17.1

