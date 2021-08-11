Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82DE53E9984
	for <lists+linux-pm@lfdr.de>; Wed, 11 Aug 2021 22:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbhHKUPL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Aug 2021 16:15:11 -0400
Received: from foss.arm.com ([217.140.110.172]:57884 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232168AbhHKUPJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Aug 2021 16:15:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FF461042;
        Wed, 11 Aug 2021 13:14:45 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E4A5E3F40C;
        Wed, 11 Aug 2021 13:14:43 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v3 2/2] notifier: Remove atomic_notifier_call_chain_robust()
Date:   Wed, 11 Aug 2021 21:14:32 +0100
Message-Id: <20210811201432.1976916-3-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210811201432.1976916-1-valentin.schneider@arm.com>
References: <20210811201432.1976916-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This now has no more users, remove it.

Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 include/linux/notifier.h |  2 --
 kernel/notifier.c        | 19 -------------------
 2 files changed, 21 deletions(-)

diff --git a/include/linux/notifier.h b/include/linux/notifier.h
index 2fb373a5c1ed..87069b8459af 100644
--- a/include/linux/notifier.h
+++ b/include/linux/notifier.h
@@ -168,8 +168,6 @@ extern int raw_notifier_call_chain(struct raw_notifier_head *nh,
 extern int srcu_notifier_call_chain(struct srcu_notifier_head *nh,
 		unsigned long val, void *v);
 
-extern int atomic_notifier_call_chain_robust(struct atomic_notifier_head *nh,
-		unsigned long val_up, unsigned long val_down, void *v);
 extern int blocking_notifier_call_chain_robust(struct blocking_notifier_head *nh,
 		unsigned long val_up, unsigned long val_down, void *v);
 extern int raw_notifier_call_chain_robust(struct raw_notifier_head *nh,
diff --git a/kernel/notifier.c b/kernel/notifier.c
index 1b019cbca594..b8251dc0bc0f 100644
--- a/kernel/notifier.c
+++ b/kernel/notifier.c
@@ -172,25 +172,6 @@ int atomic_notifier_chain_unregister(struct atomic_notifier_head *nh,
 }
 EXPORT_SYMBOL_GPL(atomic_notifier_chain_unregister);
 
-int atomic_notifier_call_chain_robust(struct atomic_notifier_head *nh,
-		unsigned long val_up, unsigned long val_down, void *v)
-{
-	unsigned long flags;
-	int ret;
-
-	/*
-	 * Musn't use RCU; because then the notifier list can
-	 * change between the up and down traversal.
-	 */
-	spin_lock_irqsave(&nh->lock, flags);
-	ret = notifier_call_chain_robust(&nh->head, val_up, val_down, v);
-	spin_unlock_irqrestore(&nh->lock, flags);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(atomic_notifier_call_chain_robust);
-NOKPROBE_SYMBOL(atomic_notifier_call_chain_robust);
-
 /**
  *	atomic_notifier_call_chain - Call functions in an atomic notifier chain
  *	@nh: Pointer to head of the atomic notifier chain
-- 
2.25.1

