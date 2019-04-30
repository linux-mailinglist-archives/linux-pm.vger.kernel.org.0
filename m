Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6972AFF55
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 20:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfD3SFo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Apr 2019 14:05:44 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60846 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbfD3SFm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Apr 2019 14:05:42 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gportay)
        with ESMTPSA id 23F4A282FE4
From:   =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sandy Huang <hjc@rock-chips.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Derek Basehore <dbasehore@chromium.org>,
        Lin Huang <hl@rock-chips.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        kernel@collabora.com
Subject: [RFC 1/4] PM / devfreq: add devfreq_lock/unlock() functions
Date:   Tue, 30 Apr 2019 14:05:21 -0400
Message-Id: <20190430180524.22710-2-gael.portay@collabora.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430180524.22710-1-gael.portay@collabora.com>
References: <20190430180524.22710-1-gael.portay@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds the implementation for lock/unlock functions in the
devfreq framework.

In some situations, changing the clock rate affect other devices, and
the devfreq framework needs a mean to synchronize all the drivers
together.

This locking API allows third-party drivers that use a devfreq device to
have control on whether it can change the rate or not.

Those drivers can lock the devfreq device to prevent it from changing
the rate, and then can release the lock to let it change the rate again.

When a change rate is triggered, and the devfreq device is locked, the
device informs the drivers that hold a lock through a callback that a
change rate is wanted. This change is not applied. It is marked as
pending.

When a pending rate change exists, and all the locks are released, the
devfreq device resumes the rate change that is pending after the last
lock is released.

Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>
---
 drivers/devfreq/devfreq.c | 200 +++++++++++++++++++++++++++++++++++++-
 include/linux/devfreq.h   |  64 ++++++++++++
 2 files changed, 263 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 0ae3de76833b..a655e14a28f6 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -323,6 +323,60 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
 	return err;
 }
 
+static void devfreq_set_target_work(struct work_struct *work)
+{
+	struct devfreq *devfreq = container_of(work, struct devfreq,
+						     set_target_work);
+	struct devfreq_dev_userlock *userlock, *userlock_safe;
+	unsigned long freq, lock_flags;
+	bool deadline = false;
+	ktime_t now;
+	bool locked;
+	u32 flags;
+	int err;
+
+	/* Suspended, skip. */
+	if (atomic_read(&devfreq->suspend_count) > 0)
+		return;
+
+	spin_lock_irqsave(&devfreq->lockers_spinlock, lock_flags);
+	locked = !list_empty(&devfreq->userlocks.locked);
+	/* Not locked, check if deadline of unlockers was not reached. */
+	if (!locked) {
+		now = ktime_get();
+		freq = devfreq->new_freq;
+		flags = devfreq->new_flags;
+
+		list_for_each_entry_safe(userlock, userlock_safe,
+					 &devfreq->userlocks.unlocked,
+					 node) {
+			if (ktime_after(userlock->deadline, now))
+				continue;
+
+			if (!userlock->deadline)
+				continue;
+
+			deadline = true;
+			list_move_tail(&userlock->node,
+				       &devfreq->userlocks.locked);
+		}
+
+		if (!deadline)
+			devfreq->set_target_pending = false;
+	}
+	spin_unlock_irqrestore(&devfreq->lockers_spinlock, lock_flags);
+
+	if (locked || deadline)
+		return;
+
+	mutex_lock(&devfreq->lock);
+	err = devfreq_set_target(devfreq, freq, flags);
+	if (err)
+		dev_err(&devfreq->dev, "failed to set target with (%d) error\n",
+			err);
+	mutex_unlock(&devfreq->lock);
+}
+
 /* Load monitoring helper functions for governors use */
 
 /**
@@ -334,7 +388,9 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
  */
 int update_devfreq(struct devfreq *devfreq)
 {
-	unsigned long freq, min_freq, max_freq;
+	unsigned long freq, min_freq, max_freq, lock_flags;
+	struct devfreq_dev_userlock *userlock;
+	bool locked = false;
 	int err = 0;
 	u32 flags = 0;
 
@@ -370,6 +426,28 @@ int update_devfreq(struct devfreq *devfreq)
 		flags |= DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use LUB */
 	}
 
+	spin_lock_irqsave(&devfreq->lockers_spinlock, lock_flags);
+	locked = !list_empty(&devfreq->userlocks.locked);
+	/* Device is locked, tell lockers that a change rate is wanted */
+	if (locked) {
+		devfreq->set_target_pending = true;
+		devfreq->new_freq = freq;
+		devfreq->new_flags = flags;
+
+		list_for_each_entry(userlock, &devfreq->userlocks.locked,
+				    node) {
+			if (userlock->want_to_change_rate)
+				userlock->want_to_change_rate(userlock,
+							      devfreq);
+		}
+	}
+	spin_unlock_irqrestore(&devfreq->lockers_spinlock, lock_flags);
+
+	if (locked) {
+		dev_warn(&devfreq->dev, "Locked!\n");
+		return 0;
+	}
+
 	return devfreq_set_target(devfreq, freq, flags);
 
 }
@@ -646,6 +724,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	devfreq->last_status.current_frequency = profile->initial_freq;
 	devfreq->data = data;
 	devfreq->nb.notifier_call = devfreq_notifier_call;
+	INIT_WORK(&devfreq->set_target_work, devfreq_set_target_work);
+	INIT_LIST_HEAD(&devfreq->userlocks.locked);
+	INIT_LIST_HEAD(&devfreq->userlocks.unlocked);
 
 	if (!devfreq->profile->max_state && !devfreq->profile->freq_table) {
 		mutex_unlock(&devfreq->lock);
@@ -1682,3 +1763,120 @@ void devm_devfreq_unregister_notifier(struct device *dev,
 			       devm_devfreq_dev_match, devfreq));
 }
 EXPORT_SYMBOL(devm_devfreq_unregister_notifier);
+
+/**
+ * devfreq_register_dev_user_lock() - Helper function to register a user lock
+ *				      to devfreq
+ * @userlock:	The devfreq dev user lock object.
+ * @devfreq:	The devfreq object.
+ *
+ * Helper function to register the @userlock to the @devfreq device.
+ *
+ * The function moves the @userlock to the list of unlockers.
+ *
+ * Return: 0 on success or -EINVAL if arguments are invalid.
+ */
+int devfreq_register_dev_user_lock(struct devfreq_dev_userlock *userlock,
+				   struct devfreq *devfreq)
+{
+	unsigned long flags;
+
+	if (!devfreq || !userlock)
+		return -EINVAL;
+
+	spin_lock_irqsave(&devfreq->lockers_spinlock, flags);
+	userlock->deadline = 0;
+	list_add_tail(&userlock->node, &devfreq->userlocks.unlocked);
+	spin_unlock_irqrestore(&devfreq->lockers_spinlock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL(devfreq_register_dev_user_lock);
+
+/**
+ * devfreq_unregister_dev_user_lock() - Helper function to unregister a user
+ *					lock
+ * @userlock:	The devfreq dev user lock object.
+ * @devfreq:	The devfreq object.
+ *
+ * Helper function to unregister the @userlock from the @devfreq device.
+ *
+ * The function removes the @userlock.
+ */
+void devfreq_unregister_dev_user_lock(struct devfreq_dev_userlock *userlock,
+				      struct devfreq *devfreq)
+{
+	unsigned long flags;
+
+	if (!devfreq || !userlock)
+		return;
+
+	spin_lock_irqsave(&devfreq->lockers_spinlock, flags);
+	list_del(&userlock->node);
+	spin_unlock_irqrestore(&devfreq->lockers_spinlock, flags);
+}
+EXPORT_SYMBOL(devfreq_unregister_dev_user_lock);
+
+/**
+ * devfreq_lock_device() - Helper function to lock devfreq
+ * @devfreq:	The devfreq object.
+ * @userlock:	The devfreq dev user lock object.
+ *
+ * Helper function to lock the @devfreq device from changing the frequency rate.
+ * The function moves the @userlock to the list of lockers.
+ *
+ * The @userlock should be registered.
+ *
+ * Return: 0 on success or -EINVAL if arguments are invalid.
+ */
+int devfreq_lock_device(struct devfreq *devfreq,
+			struct devfreq_dev_userlock *userlock)
+{
+	unsigned long flags;
+
+	if (!devfreq || !userlock)
+		return -EINVAL;
+
+	spin_lock_irqsave(&devfreq->lockers_spinlock, flags);
+	list_move_tail(&userlock->node, &devfreq->userlocks.locked);
+	spin_unlock_irqrestore(&devfreq->lockers_spinlock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL(devfreq_lock_device);
+
+/**
+ * devfreq_unlock_device() - Helper function to unlock devfreq
+ * @devfreq:	The devfreq object.
+ * @userlock:	The devfreq dev user lock object.
+ * @deadline:	The deadline.
+ *
+ * Helper function to unlock the @devfreq device. The function moves the
+ * @userlock to the list of unlockers.
+ *
+ * If @devfreq device has no more lockers in its list, it triggers the pending
+ * rate change.
+ *
+ * The @userlock should be registered.
+ */
+void devfreq_unlock_device(struct devfreq *devfreq,
+			   struct devfreq_dev_userlock *userlock,
+			   ktime_t deadline)
+{
+	unsigned long flags;
+
+	if (!devfreq || !userlock)
+		return;
+
+	if (atomic_read(&devfreq->suspend_count) > 0)
+		return;
+
+	spin_lock_irqsave(&devfreq->lockers_spinlock, flags);
+	userlock->deadline = deadline;
+	list_move_tail(&userlock->node, &devfreq->userlocks.unlocked);
+	if (list_empty(&devfreq->userlocks.locked) &&
+		       devfreq->set_target_pending)
+		queue_work(system_highpri_wq, &devfreq->set_target_work);
+	spin_unlock_irqrestore(&devfreq->lockers_spinlock, flags);
+}
+EXPORT_SYMBOL(devfreq_unlock_device);
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index fbffa74bfc1b..0a577a776235 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -35,6 +35,7 @@
 
 struct devfreq;
 struct devfreq_governor;
+struct devfreq_dev_userlock;
 
 /**
  * struct devfreq_dev_status - Data given from devfreq user device to
@@ -109,6 +110,21 @@ struct devfreq_dev_profile {
 	unsigned int max_state;
 };
 
+/**
+ * struct devfreq_dev_userlock - Devfreq's user device lock
+ * @node:	list node - contains the userlocks that have been locked or
+ *		unlocked.
+ * @deadline:	The timestamp while the unlock is valid.
+ * @want_to_change_rate:	The callback that is called for every lockers,
+ *				when devfreq wants to change the frequency rate.
+ */
+struct devfreq_dev_userlock {
+	struct list_head node;
+	ktime_t deadline;
+	void (*want_to_change_rate)(struct devfreq_dev_userlock *user,
+				    struct devfreq *devfreq);
+};
+
 /**
  * struct devfreq - Device devfreq structure
  * @node:	list node - contains the devices with devfreq that have been
@@ -138,6 +154,12 @@ struct devfreq_dev_profile {
  * @trans_table:	Statistics of devfreq transitions
  * @time_in_state:	Statistics of devfreq states
  * @last_stat_updated:	The last time stat updated
+ * @new_freq:		the last frequency change before lock.
+ * @new_flags:		the last flag change before lock.
+ * @set_target_pending:	is a set target pending.
+ * @set_target_work:	work for resuming set target.
+ * @userlocks:		the lists of user locks (unlocked and locked).
+ * @lock_spinlock:	a spinlock to protect accessing to lock attributes.
  * @transition_notifier_list: list head of DEVFREQ_TRANSITION_NOTIFIER notifier
  *
  * This structure stores the devfreq information for a give device.
@@ -180,6 +202,16 @@ struct devfreq {
 	unsigned long *time_in_state;
 	unsigned long last_stat_updated;
 
+	unsigned long new_freq;
+	u32 new_flags;
+	bool set_target_pending;
+	struct work_struct set_target_work;
+	struct {
+		struct list_head unlocked;
+		struct list_head locked;
+	} userlocks;
+	spinlock_t lockers_spinlock;
+
 	struct srcu_notifier_head transition_notifier_list;
 };
 
@@ -243,6 +275,15 @@ extern void devm_devfreq_unregister_notifier(struct device *dev,
 				unsigned int list);
 extern struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev,
 						int index);
+extern int devfreq_register_dev_user_lock(
+	       struct devfreq_dev_userlock *userlock, struct devfreq *devfreq);
+extern void devfreq_unregister_dev_user_lock(
+	       struct devfreq_dev_userlock *userlock, struct devfreq *devfreq);
+extern int devfreq_lock_device(struct devfreq *devfreq,
+			       struct devfreq_dev_userlock *userlock);
+extern void devfreq_unlock_device(struct devfreq *devfreq,
+				  struct devfreq_dev_userlock *userlock,
+				  ktime_t deadline);
 
 #if IS_ENABLED(CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND)
 /**
@@ -405,6 +446,29 @@ static inline int devfreq_update_stats(struct devfreq *df)
 {
 	return -EINVAL;
 }
+
+static inline int devfreq_register_dev_user_lock(
+		 struct devfreq_dev_userlock *userlock, struct devfreq *devfreq)
+{
+	return -EINVAL;
+}
+
+static inline void devfreq_unregister_dev_user_unlock(
+		 struct devfreq_dev_userlock *userlock, struct devfreq *devfreq)
+{
+}
+
+static inline int devfreq_lock_device(struct devfreq *devfreq,
+				      struct devfreq_dev_userlock *userlock)
+{
+	return -EINVAL;
+}
+
+static inline void devfreq_unlock_device(struct devfreq *devfreq,
+					 struct devfreq_dev_userlock *userlock,
+					 ktime_t deadline)
+{
+}
 #endif /* CONFIG_PM_DEVFREQ */
 
 #endif /* __LINUX_DEVFREQ_H__ */
-- 
2.21.0

