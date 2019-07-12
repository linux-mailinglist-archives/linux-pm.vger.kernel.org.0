Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8F8E673B0
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2019 19:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfGLRAn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Jul 2019 13:00:43 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38455 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbfGLRAn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Jul 2019 13:00:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id y15so4564212pfn.5
        for <linux-pm@vger.kernel.org>; Fri, 12 Jul 2019 10:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N6UUFo31dJU7i/TY8ZbCVicJDw2+WbPa1M5E7BmWDCc=;
        b=QmzQnvFCpnnURvJ3i1kGlgC/mbxaBbaDQHHGSMI654dMso+5TuM3kKX/ZlYDX7gpte
         MNQrhOSc7NwlgV3l6P5R0r6u2oDqvnlYWxxhmwD1H1ms9D7IAGa9Er0myKsjoYJ+Qxgl
         9w0wukZt3X+fvhzBrGOcObP7dPa8ok+/6a9+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N6UUFo31dJU7i/TY8ZbCVicJDw2+WbPa1M5E7BmWDCc=;
        b=FCN/9CSvoopuajTDZSwDM/x9ZPEClU1joI3upc9jOvuA79SRAUbpGKlp7DtYkRUDPk
         2w5TYx5y38reyAGeu0vfu5533toGE0RLI98+ewFYtm40rB9ugM2S1m7eTafc5AhDRdtq
         UhSxYsoRACt8LyHyPBtHI6mgt0jkBgYP8VgTKGNfOSRFYUg4cpLhu18XObTHFptutHhR
         Ek240hbO7RIQ4WEqslfgHGE9q/1eHo34Cs6P+6e8mupO9ltVTOfQ+4UjMUyZSVHcfgOT
         IWnjUUVQpB3+eHUEnKNelOrh4Amp9txdjAp3uaNEGthGhg2yd2HYYtQ27PXq0yvMY1TR
         c9ow==
X-Gm-Message-State: APjAAAWh1MSUAV6OJtOYRUbVnGVARa63ANN24bS6CSW+aTI8PlGGrzU0
        iixO76BdR0eK5WYCuvYsp6U=
X-Google-Smtp-Source: APXvYqyiiuS0wRYavDuZi49BUv6+XcbUQiNlyObHgTxrpEYMkvdKLXHPO91F4Czqw54uCNVE0428Tg==
X-Received: by 2002:a65:6406:: with SMTP id a6mr11576363pgv.393.1562950842022;
        Fri, 12 Jul 2019 10:00:42 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id a15sm7127385pgw.3.2019.07.12.10.00.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 10:00:41 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Borislav Petkov <bp@alien8.de>, c0d1n61at3@gmail.com,
        "David S. Miller" <davem@davemloft.net>, edumazet@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>, keescook@chromium.org,
        kernel-hardening@lists.openwall.com, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neilb@suse.com, netdev@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Pavel Machek <pavel@ucw.cz>, peterz@infradead.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [PATCH v2 2/9] rcu: Add support for consolidated-RCU reader checking
Date:   Fri, 12 Jul 2019 13:00:17 -0400
Message-Id: <20190712170024.111093-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
In-Reply-To: <20190712170024.111093-1-joel@joelfernandes.org>
References: <20190712170024.111093-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds support for checking RCU reader sections in list
traversal macros. Optionally, if the list macro is called under SRCU or
other lock/mutex protection, then appropriate lockdep expressions can be
passed to make the checks pass.

Existing list_for_each_entry_rcu() invocations don't need to pass the
optional fourth argument (cond) unless they are under some non-RCU
protection and needs to make lockdep check pass.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/rculist.h  | 28 +++++++++++++++++++++++-----
 include/linux/rcupdate.h |  7 +++++++
 kernel/rcu/Kconfig.debug | 11 +++++++++++
 kernel/rcu/update.c      | 14 ++++++++++++++
 4 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index e91ec9ddcd30..1048160625bb 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -40,6 +40,20 @@ static inline void INIT_LIST_HEAD_RCU(struct list_head *list)
  */
 #define list_next_rcu(list)	(*((struct list_head __rcu **)(&(list)->next)))
 
+/*
+ * Check during list traversal that we are within an RCU reader
+ */
+
+#ifdef CONFIG_PROVE_RCU_LIST
+#define __list_check_rcu(dummy, cond, ...)				\
+	({								\
+	RCU_LOCKDEP_WARN(!cond && !rcu_read_lock_any_held(),		\
+			 "RCU-list traversed in non-reader section!");	\
+	 })
+#else
+#define __list_check_rcu(dummy, cond, ...) ({})
+#endif
+
 /*
  * Insert a new entry between two known consecutive entries.
  *
@@ -343,14 +357,16 @@ static inline void list_splice_tail_init_rcu(struct list_head *list,
  * @pos:	the type * to use as a loop cursor.
  * @head:	the head for your list.
  * @member:	the name of the list_head within the struct.
+ * @cond:	optional lockdep expression if called from non-RCU protection.
  *
  * This list-traversal primitive may safely run concurrently with
  * the _rcu list-mutation primitives such as list_add_rcu()
  * as long as the traversal is guarded by rcu_read_lock().
  */
-#define list_for_each_entry_rcu(pos, head, member) \
-	for (pos = list_entry_rcu((head)->next, typeof(*pos), member); \
-		&pos->member != (head); \
+#define list_for_each_entry_rcu(pos, head, member, cond...)		\
+	for (__list_check_rcu(dummy, ## cond, 0),			\
+	     pos = list_entry_rcu((head)->next, typeof(*pos), member);	\
+		&pos->member != (head);					\
 		pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
 
 /**
@@ -616,13 +632,15 @@ static inline void hlist_add_behind_rcu(struct hlist_node *n,
  * @pos:	the type * to use as a loop cursor.
  * @head:	the head for your list.
  * @member:	the name of the hlist_node within the struct.
+ * @cond:	optional lockdep expression if called from non-RCU protection.
  *
  * This list-traversal primitive may safely run concurrently with
  * the _rcu list-mutation primitives such as hlist_add_head_rcu()
  * as long as the traversal is guarded by rcu_read_lock().
  */
-#define hlist_for_each_entry_rcu(pos, head, member)			\
-	for (pos = hlist_entry_safe (rcu_dereference_raw(hlist_first_rcu(head)),\
+#define hlist_for_each_entry_rcu(pos, head, member, cond...)		\
+	for (__list_check_rcu(dummy, ## cond, 0),			\
+	     pos = hlist_entry_safe (rcu_dereference_raw(hlist_first_rcu(head)),\
 			typeof(*(pos)), member);			\
 		pos;							\
 		pos = hlist_entry_safe(rcu_dereference_raw(hlist_next_rcu(\
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 922bb6848813..712b464ab960 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -223,6 +223,7 @@ int debug_lockdep_rcu_enabled(void);
 int rcu_read_lock_held(void);
 int rcu_read_lock_bh_held(void);
 int rcu_read_lock_sched_held(void);
+int rcu_read_lock_any_held(void);
 
 #else /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
@@ -243,6 +244,12 @@ static inline int rcu_read_lock_sched_held(void)
 {
 	return !preemptible();
 }
+
+static inline int rcu_read_lock_any_held(void)
+{
+	return !preemptible();
+}
+
 #endif /* #else #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
 #ifdef CONFIG_PROVE_RCU
diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index 0ec7d1d33a14..b20d0e2903d1 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -7,6 +7,17 @@ menu "RCU Debugging"
 config PROVE_RCU
 	def_bool PROVE_LOCKING
 
+config PROVE_RCU_LIST
+	bool "RCU list lockdep debugging"
+	depends on PROVE_RCU
+	default n
+	help
+	  Enable RCU lockdep checking for list usages. By default it is
+	  turned off since there are several list RCU users that still
+	  need to be converted to pass a lockdep expression. To prevent
+	  false-positive splats, we keep it default disabled but once all
+	  users are converted, we can remove this config option.
+
 config TORTURE_TEST
 	tristate
 	default n
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index bb961cd89e76..0cc7be0fb6b5 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -294,6 +294,20 @@ int rcu_read_lock_bh_held(void)
 }
 EXPORT_SYMBOL_GPL(rcu_read_lock_bh_held);
 
+int rcu_read_lock_any_held(void)
+{
+	if (!debug_lockdep_rcu_enabled())
+		return 1;
+	if (!rcu_is_watching())
+		return 0;
+	if (!rcu_lockdep_current_cpu_online())
+		return 0;
+	if (lock_is_held(&rcu_lock_map) || lock_is_held(&rcu_sched_lock_map))
+		return 1;
+	return !preemptible();
+}
+EXPORT_SYMBOL_GPL(rcu_read_lock_any_held);
+
 #endif /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
 /**
-- 
2.22.0.510.g264f2c817a-goog

