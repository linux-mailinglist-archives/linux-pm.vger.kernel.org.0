Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 912F2173ECE
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2020 18:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgB1Rr4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Feb 2020 12:47:56 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41435 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgB1Rrz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Feb 2020 12:47:55 -0500
Received: by mail-pg1-f196.google.com with SMTP id b1so1870647pgm.8;
        Fri, 28 Feb 2020 09:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mbF4XFiS6x/5BZS7mexCEPridbNKUPiWYRQsLCRNJCo=;
        b=f0LxLDIT9xWUUwmWVjj7NAoPKpnD7jNta4pnOvb8zuLmJ7ug/BN1fsEt4Tb1W1QcIx
         2LXz+ekxLiyFG/NuSHPHBd0ypxFgI0FPbBYMesDgvODDWQNhsakGmAmhc9gjOmNVL4R9
         xwnf0IBRo0R+2gZe/p0AQIdUzFsE9sTGp0j0StwPhrwh4bnYdexajmr2m4gIXz1U3t7X
         lnEJJzMjXkNBt65X9dV5kjk6ViNBvd8E9FMDHAT5SVWfqKt5cuCItAES9mcLHCMShxRU
         JRdcr/LAfjoa64JeA9GChMEBHGzeYTA14H2hURszIqDrBhO2Vvfn1NlA3pSO6FaiTXgt
         iuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mbF4XFiS6x/5BZS7mexCEPridbNKUPiWYRQsLCRNJCo=;
        b=XKgPfHSdmgAFiftkIkAoiKmanTGrZqlFhWJYsbMZ+HzMdLPYXc+L4pZjvP/akwbZ2O
         6a6Sw3A05AuNzAy0whbO5eIhCbB2JEhDntTcne5AIvBcabw9zzlXBQ+siTibp9qM6UgZ
         fQTaXTY4yeV3dkOOLAbPQ8D1zTMNwSayb4GqjtrA/+ik2C7o/KEOZAHsVvcmaP38llJ5
         /tzlIx0OkUvextbEo/CH14BDLQShOnN6gW/mtEYE5r1+2mYpBJX2IACQtT2EnhoSphtE
         LtKLXaqWE4otQNWTLfgk8YTyIXYewzWdebaXbZVLrbBLeR9yqvTze/UTyvs95JlmxVf1
         kJSg==
X-Gm-Message-State: APjAAAWJIGkW5hWgY1BV3KR4uaN/t4Vt3uojS42HH30rqIbpgWdkS21o
        ICAW4SItMYaRq58bpZ0fRA==
X-Google-Smtp-Source: APXvYqzpLT3JS4qNYEKWFKVXnrzTHsEGd1zfzZoEsVvoqi+FrVXXK08r8LC4AINXmrpIKnPh/nX2Yg==
X-Received: by 2002:aa7:8ad9:: with SMTP id b25mr5505864pfd.70.1582912074291;
        Fri, 28 Feb 2020 09:47:54 -0800 (PST)
Received: from madhuparna-HP-Notebook.nitk.ac.in ([2402:3a80:55e:f10b:ac46:7428:aa52:2d70])
        by smtp.gmail.com with ESMTPSA id 10sm11599587pfu.132.2020.02.28.09.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 09:47:53 -0800 (PST)
From:   madhuparnabhowmik10@gmail.com
To:     rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com,
        gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, frextrite@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org, paulmck@kernel.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Subject: [PATCH 2/2] drivers: base: power: wakeup.c: Use built-in RCU list checking
Date:   Fri, 28 Feb 2020 23:17:45 +0530
Message-Id: <20200228174745.9308-1-madhuparnabhowmik10@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

Pass cond argument to list_for_each_entry_rcu() to fix the
following false positive lockdep warning and other uses of
list_for_each_entry_rcu() in wakeup.c.

[  331.934648] =============================
[  331.934650] WARNING: suspicious RCU usage
[  331.934653] 5.6.0-rc1+ #5 Not tainted
[  331.934655] -----------------------------
[  331.934657] drivers/base/power/wakeup.c:408 RCU-list traversed in non-reader section!!

[  333.025156] =============================
[  333.025161] WARNING: suspicious RCU usage
[  333.025168] 5.6.0-rc1+ #5 Not tainted
[  333.025173] -----------------------------
[  333.025180] drivers/base/power/wakeup.c:424 RCU-list traversed in non-reader section!!

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
---
 drivers/base/power/wakeup.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 27f3e60608e5..d9fefc65ac34 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -405,7 +405,8 @@ void device_wakeup_arm_wake_irqs(void)
 	int srcuidx;
 
 	srcuidx = srcu_read_lock(&wakeup_srcu);
-	list_for_each_entry_rcu(ws, &wakeup_sources, entry)
+	list_for_each_entry_rcu(ws, &wakeup_sources, entry,
+				srcu_read_lock_held(&wakeup_srcu))
 		dev_pm_arm_wake_irq(ws->wakeirq);
 	srcu_read_unlock(&wakeup_srcu, srcuidx);
 }
@@ -421,7 +422,8 @@ void device_wakeup_disarm_wake_irqs(void)
 	int srcuidx;
 
 	srcuidx = srcu_read_lock(&wakeup_srcu);
-	list_for_each_entry_rcu(ws, &wakeup_sources, entry)
+	list_for_each_entry_rcu(ws, &wakeup_sources, entry,
+				srcu_read_lock_held(&wakeup_srcu))
 		dev_pm_disarm_wake_irq(ws->wakeirq);
 	srcu_read_unlock(&wakeup_srcu, srcuidx);
 }
@@ -874,7 +876,8 @@ void pm_print_active_wakeup_sources(void)
 	struct wakeup_source *last_activity_ws = NULL;
 
 	srcuidx = srcu_read_lock(&wakeup_srcu);
-	list_for_each_entry_rcu(ws, &wakeup_sources, entry) {
+	list_for_each_entry_rcu(ws, &wakeup_sources, entry,
+				srcu_read_lock_held(&wakeup_srcu)) {
 		if (ws->active) {
 			pm_pr_dbg("active wakeup source: %s\n", ws->name);
 			active = 1;
@@ -1025,7 +1028,8 @@ void pm_wakep_autosleep_enabled(bool set)
 	int srcuidx;
 
 	srcuidx = srcu_read_lock(&wakeup_srcu);
-	list_for_each_entry_rcu(ws, &wakeup_sources, entry) {
+	list_for_each_entry_rcu(ws, &wakeup_sources, entry,
+				srcu_read_lock_held(&wakeup_srcu)) {
 		spin_lock_irq(&ws->lock);
 		if (ws->autosleep_enabled != set) {
 			ws->autosleep_enabled = set;
@@ -1104,7 +1108,8 @@ static void *wakeup_sources_stats_seq_start(struct seq_file *m,
 	}
 
 	*srcuidx = srcu_read_lock(&wakeup_srcu);
-	list_for_each_entry_rcu(ws, &wakeup_sources, entry) {
+	list_for_each_entry_rcu(ws, &wakeup_sources, entry,
+				srcu_read_lock_held(&wakeup_srcu)) {
 		if (n-- <= 0)
 			return ws;
 	}
-- 
2.17.1

