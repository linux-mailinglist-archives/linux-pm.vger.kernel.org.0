Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEA7D178340
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 20:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbgCCTmU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Mar 2020 14:42:20 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33196 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730501AbgCCTmU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2020 14:42:20 -0500
Received: by mail-pg1-f194.google.com with SMTP id m5so2035613pgg.0;
        Tue, 03 Mar 2020 11:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=h8tgpVg/WfkWXXsiT8gGieydhGIhOktjnYkunJLTkFE=;
        b=TeHtPEkldUQWf/PJsAtcT4UKWLar2Eif6QpmqiA7ZBzu8z8t9N0sV1KcoHYSSDR3uE
         zeYClIONCtKoqETptiKgDam11vqgHkqS1sqMquDOGA9L8BGuGvl8LmRC/OOJ0UY4ZuGf
         VudfxiBsJNTc4FiNhuVD1g6vHWypvmro5M9okhyISWYUlaNEm49AIQ0qjMt7rSsOI31n
         pbUZZlv2NX7MO1CUNd9gr6n2vWE8cMag/fjD6Cnw3NbhyUpWhLYVwoZ3tt1tJnO0hvE4
         yXyCkLDkZNrwV6txnJ9dyeSHlMGlh+2trsGJJoYL1c2qUtbhoE71aQ6vmEmqKzV5kOVO
         V9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=h8tgpVg/WfkWXXsiT8gGieydhGIhOktjnYkunJLTkFE=;
        b=CDgNb/EMMin8Y2lY5HAziuR9Gi64sYzlLhzq5FSqPyS8uHyKl/Y7YeNyl22orcnV7p
         Hap/25c13z0GEg+RO7dQWDCSAiezCLA3iAoh4kmcPpbMXnlgz4/1gYzKfc8APfFXbYbU
         8vSmRpjvBYQD1U4Ch9kyTCDa0yzc4zUu/7GzfdWxYokTofaJeOJ/11KcSCYF4GyqwLWO
         j5rI8i131dE9r4JY6PnrGZ3LRk3uQ0qq5cQC3xtKKz23TUIqHPT+CYZcgoaHf9klIoLP
         t3NfvYFpGS17adGzsOV4RYPdgq5iCHbHpfA/3BrEM1PkCje7ScCprJm4JEiXJ+CblWph
         mmmA==
X-Gm-Message-State: ANhLgQ3bHg3ouFzrK0K6to9GbfKNZdWhkd1hbA/jSYz5eDSasCQhB3PK
        sOcRWKIZp5LmJAl7XqH+7g==
X-Google-Smtp-Source: ADFU+vsIKjRLmDIQjJnuD8KDsJHg1Wjco2HXTvq6p5IDaeqCtmTHOBvLcd0q5Mu3WaP3xJoG+TiSiA==
X-Received: by 2002:a62:aa14:: with SMTP id e20mr5529174pff.178.1583264539508;
        Tue, 03 Mar 2020 11:42:19 -0800 (PST)
Received: from madhuparna-HP-Notebook.nitk.ac.in ([2402:3a80:1ee0:eafa:280b:b5cb:5e89:a52d])
        by smtp.gmail.com with ESMTPSA id r9sm13737565pfq.72.2020.03.03.11.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 11:42:18 -0800 (PST)
From:   madhuparnabhowmik10@gmail.com
To:     rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com,
        gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, frextrite@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org, paulmck@kernel.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Subject: [PATCH 2/2] drivers: base: power: wakeup.c: Use built-in RCU list checking
Date:   Wed,  4 Mar 2020 01:12:09 +0530
Message-Id: <20200303194209.24685-1-madhuparnabhowmik10@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

Pass cond argument to list_for_each_entry_rcu() to fix the
following false positive lockdep warning and other uses of
list_for_each_entry_rcu() in wakeup.c.
(CONFIG_PROVE_RCU_LIST = y)

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
 drivers/base/power/wakeup.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 27f3e60608e5..7e33a8d829dc 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -24,6 +24,9 @@ suspend_state_t pm_suspend_target_state;
 #define pm_suspend_target_state	(PM_SUSPEND_ON)
 #endif
 
+#define list_for_each_entry_rcu_locked(pos, head, member) \
+	list_for_each_entry_rcu(pos, head, member, \
+		srcu_read_lock_held(&wakeup_srcu))
 /*
  * If set, the suspend/hibernate code will abort transitions to a sleep state
  * if wakeup events are registered during or immediately before the transition.
@@ -405,7 +408,7 @@ void device_wakeup_arm_wake_irqs(void)
 	int srcuidx;
 
 	srcuidx = srcu_read_lock(&wakeup_srcu);
-	list_for_each_entry_rcu(ws, &wakeup_sources, entry)
+	list_for_each_entry_rcu_locked(ws, &wakeup_sources, entry)
 		dev_pm_arm_wake_irq(ws->wakeirq);
 	srcu_read_unlock(&wakeup_srcu, srcuidx);
 }
@@ -421,7 +424,7 @@ void device_wakeup_disarm_wake_irqs(void)
 	int srcuidx;
 
 	srcuidx = srcu_read_lock(&wakeup_srcu);
-	list_for_each_entry_rcu(ws, &wakeup_sources, entry)
+	list_for_each_entry_rcu_locked(ws, &wakeup_sources, entry)
 		dev_pm_disarm_wake_irq(ws->wakeirq);
 	srcu_read_unlock(&wakeup_srcu, srcuidx);
 }
@@ -874,7 +877,7 @@ void pm_print_active_wakeup_sources(void)
 	struct wakeup_source *last_activity_ws = NULL;
 
 	srcuidx = srcu_read_lock(&wakeup_srcu);
-	list_for_each_entry_rcu(ws, &wakeup_sources, entry) {
+	list_for_each_entry_rcu_locked(ws, &wakeup_sources, entry) {
 		if (ws->active) {
 			pm_pr_dbg("active wakeup source: %s\n", ws->name);
 			active = 1;
@@ -1025,7 +1028,7 @@ void pm_wakep_autosleep_enabled(bool set)
 	int srcuidx;
 
 	srcuidx = srcu_read_lock(&wakeup_srcu);
-	list_for_each_entry_rcu(ws, &wakeup_sources, entry) {
+	list_for_each_entry_rcu_locked(ws, &wakeup_sources, entry) {
 		spin_lock_irq(&ws->lock);
 		if (ws->autosleep_enabled != set) {
 			ws->autosleep_enabled = set;
@@ -1104,7 +1107,7 @@ static void *wakeup_sources_stats_seq_start(struct seq_file *m,
 	}
 
 	*srcuidx = srcu_read_lock(&wakeup_srcu);
-	list_for_each_entry_rcu(ws, &wakeup_sources, entry) {
+	list_for_each_entry_rcu_locked(ws, &wakeup_sources, entry) {
 		if (n-- <= 0)
 			return ws;
 	}
-- 
2.17.1

