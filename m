Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B69B6626E
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2019 01:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbfGKXo5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Jul 2019 19:44:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33374 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730474AbfGKXo1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jul 2019 19:44:27 -0400
Received: by mail-pf1-f193.google.com with SMTP id g2so3474271pfq.0
        for <linux-pm@vger.kernel.org>; Thu, 11 Jul 2019 16:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DxaBT1tnbAEQu4unrE+ZIdJanB1uVhDn4/7rfKQHrQ8=;
        b=ZR89dJ0gCvmFd48H56kuCm2XzQpnVhPx64wtgiHyZvxa33ANSu0oXUTttSIxFI0x9Z
         fHKlA+45Bqn3L3g08DQds8w60ml29tD/QN8R/vX0Ix2Z2Akl/LzUSDrgZDI4Q/+otrRY
         I+DBueCyfUEugUlr0uSGpkRYwIAjZJZdHOtgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DxaBT1tnbAEQu4unrE+ZIdJanB1uVhDn4/7rfKQHrQ8=;
        b=i5huq7T8Hv6Vzx7tNB0ZKbz2r9lRxuAzv1wKNsabGNd47Y3Szg5YxsHOkOEbEwD4fW
         hMqvBbBkQ+eImjMACBy9fxQw8U0GYSjqlb6RRodTVXW15VwUmHf+DXnEQ9/o8KLWqVAd
         d+D7hTAu+VOwZzNU2TxbH6tJM9QqswLWr9uzP+lqRD7jUHMuBFDE1SxXye/Bdlu2X8FT
         rLAmcb9cZ6Hwe9du4Lmr+3br2poR9yjxaCoNohM7LE/qJQNFfJzGYau1A27Z8zkSMXz7
         X7pIg960krI9uSm5UkRc6OgN1k743svSEzKkxn9rsBilM5apEkm6BT1GTeYry5CFzxRI
         cPHw==
X-Gm-Message-State: APjAAAUptknlz+WoF6XigG+w6zL6R9usJqaUz/t1fBcAGQsB0M6F/kSi
        Sc/dq9ac9iFeuEzs3KjN9LU=
X-Google-Smtp-Source: APXvYqzUKLrrGWpDYD2bC1yFQhR2A3bxbRxsjgXB3UX8GkC2wLperL0TYvgWXgyR72s0kBdwkN7Ihw==
X-Received: by 2002:a63:5212:: with SMTP id g18mr2790151pgb.387.1562888666095;
        Thu, 11 Jul 2019 16:44:26 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id t10sm6163450pjr.13.2019.07.11.16.44.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 16:44:25 -0700 (PDT)
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
        Josh Triplett <josh@joshtriplett.org>, keescook@chromium.org,
        kernel-hardening@lists.openwall.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neilb@suse.com, netdev@vger.kernel.org, oleg@redhat.com,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Pavel Machek <pavel@ucw.cz>, peterz@infradead.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [PATCH v1 3/6] driver/core: Convert to use built-in RCU list checking
Date:   Thu, 11 Jul 2019 19:43:58 -0400
Message-Id: <20190711234401.220336-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190711234401.220336-1-joel@joelfernandes.org>
References: <20190711234401.220336-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

list_for_each_entry_rcu has built-in RCU and lock checking. Make use of
it in driver core.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 drivers/base/base.h          |  1 +
 drivers/base/core.c          | 10 ++++++++++
 drivers/base/power/runtime.c | 15 ++++++++++-----
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index b405436ee28e..0d32544b6f91 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -165,6 +165,7 @@ static inline int devtmpfs_init(void) { return 0; }
 /* Device links support */
 extern int device_links_read_lock(void);
 extern void device_links_read_unlock(int idx);
+extern int device_links_read_lock_held(void);
 extern int device_links_check_suppliers(struct device *dev);
 extern void device_links_driver_bound(struct device *dev);
 extern void device_links_driver_cleanup(struct device *dev);
diff --git a/drivers/base/core.c b/drivers/base/core.c
index fd7511e04e62..6c5ca9685647 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -68,6 +68,11 @@ void device_links_read_unlock(int idx)
 {
 	srcu_read_unlock(&device_links_srcu, idx);
 }
+
+int device_links_read_lock_held(void)
+{
+	return srcu_read_lock_held(&device_links_srcu);
+}
 #else /* !CONFIG_SRCU */
 static DECLARE_RWSEM(device_links_lock);
 
@@ -91,6 +96,11 @@ void device_links_read_unlock(int not_used)
 {
 	up_read(&device_links_lock);
 }
+
+int device_links_read_lock_held(void)
+{
+	return lock_is_held(&device_links_lock);
+}
 #endif /* !CONFIG_SRCU */
 
 /**
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 952a1e7057c7..7a10e8379a70 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -287,7 +287,8 @@ static int rpm_get_suppliers(struct device *dev)
 {
 	struct device_link *link;
 
-	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node) {
+	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
+				device_links_read_lock_held()) {
 		int retval;
 
 		if (!(link->flags & DL_FLAG_PM_RUNTIME) ||
@@ -309,7 +310,8 @@ static void rpm_put_suppliers(struct device *dev)
 {
 	struct device_link *link;
 
-	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node) {
+	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
+				device_links_read_lock_held()) {
 		if (READ_ONCE(link->status) == DL_STATE_SUPPLIER_UNBIND)
 			continue;
 
@@ -1640,7 +1642,8 @@ void pm_runtime_clean_up_links(struct device *dev)
 
 	idx = device_links_read_lock();
 
-	list_for_each_entry_rcu(link, &dev->links.consumers, s_node) {
+	list_for_each_entry_rcu(link, &dev->links.consumers, s_node,
+				device_links_read_lock_held()) {
 		if (link->flags & DL_FLAG_STATELESS)
 			continue;
 
@@ -1662,7 +1665,8 @@ void pm_runtime_get_suppliers(struct device *dev)
 
 	idx = device_links_read_lock();
 
-	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node)
+	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
+				device_links_read_lock_held())
 		if (link->flags & DL_FLAG_PM_RUNTIME) {
 			link->supplier_preactivated = true;
 			refcount_inc(&link->rpm_active);
@@ -1683,7 +1687,8 @@ void pm_runtime_put_suppliers(struct device *dev)
 
 	idx = device_links_read_lock();
 
-	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node)
+	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
+				device_links_read_lock_held())
 		if (link->supplier_preactivated) {
 			link->supplier_preactivated = false;
 			if (refcount_dec_not_one(&link->rpm_active))
-- 
2.22.0.410.gd8fdbe21b5-goog

