Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06D9C7C096
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 13:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbfGaL6k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 07:58:40 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:45169 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfGaL6k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 07:58:40 -0400
Received: from 79.184.255.110.ipv4.supernova.orange.pl (79.184.255.110) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id 68670c7d12d42acd; Wed, 31 Jul 2019 13:58:36 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Tri Vo <trong@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v5] PM / wakeup: show wakeup sources stats in sysfs
Date:   Wed, 31 Jul 2019 13:58:36 +0200
Message-ID: <3963324.N1Qi0Ay72S@kreacher>
In-Reply-To: <CAJZ5v0hj-GpiYN7nwPJvKJag71MG6zEFbJ6BNwzDidD+7fNFWw@mail.gmail.com>
References: <20190730024309.233728-1-trong@android.com> <5d40d5b3.1c69fb81.6047f.1cc3@mx.google.com> <CAJZ5v0hj-GpiYN7nwPJvKJag71MG6zEFbJ6BNwzDidD+7fNFWw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday, July 31, 2019 10:34:11 AM CEST Rafael J. Wysocki wrote:
> On Wed, Jul 31, 2019 at 1:41 AM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Rafael J. Wysocki (2019-07-30 16:05:55)
> > > On Wed, Jul 31, 2019 at 12:26 AM Stephen Boyd <swboyd@chromium.org> wrote:
> > > >
> > > > Quoting Rafael J. Wysocki (2019-07-30 15:17:55)
> > > > > On Tuesday, July 30, 2019 8:48:09 PM CEST Stephen Boyd wrote:
> > > > > >
> > > > > > Using the same prefix for the class and the device name is quite common.
> > > > > > For example, see the input, regulator, tty, tpm, remoteproc, hwmon,
> > > > > > extcon classes. I'd prefer it was left as /sys/class/wakeup/wakeupN. The
> > > > > > class name could be changed to wakeup_source perhaps (i.e.
> > > > > > /sys/class/wakeup_source/wakeupN)?
> > > > >
> > > > > Alternatively /sys/class/wakeup/wsN
> > > > >
> > > >
> > > > Or /sys/class/wakeup/eventN? It's your bikeshed to paint.
> > >
> > > So actually the underlying problem here is that device_wakeup_enable()
> > > tries to register a wakeup source and then attach it to the device to
> > > avoid calling possibly sleeping functions under a spinlock.
> >
> > Agreed, that is one problem.
> >
> > >
> > > However, it should be possible to call wakeup_source_create(name)
> > > first, then attach the wakeup source to the device (after checking for
> > > presence), and then invoke wakeup_source_add() (after dropping the
> > > lock).  If the wakeup source virtual device registration is done in
> > > wakeup_source_add(), that should avoid the problem altogether without
> > > having to introduce extra complexity.
> >
> > While reordering the code to do what you describe will fix this specific
> > duplicate name problem, it won't fix the general problem with reusing
> > device names from one bus on a different bus/class.
> 
> Fair enough.
> 
> > We can run into the same problem when two buses name their devices the
> > same name and then we attempt to attach a wakeup source to those two
> > devices. Or we can have a problem where a virtual wakeup is made with
> > the same name, and again we'll try to make a duplicate named device.
> > Using something like 'event' or 'wakeup' or 'ws' as the prefix avoids this
> > problem and keeps things clean.
> 
> Or suffix, like "<devname-wakeup>.
> 
> But if prefixes are used by an existing convention, I would prefer
> "ws-" as it is concise enough and should not be confusing.
> 
> > We should probably avoid letting the same virtual wakeup source be made
> > with the same name anyway, because userspace will be confused about what
> > virtual wakeup it is otherwise. I concede that using the name of the
> > wakeup source catches this problem without adding extra code.
> >
> > Either way, I'd like to see what you outline implemented so that we
> > don't need to do more work than is necessary when userspace writes to
> > the file.
> 
> Since we agree here, let's make this change first.  I can cut a patch
> for that in a reasonable time frame I think if no one else beats me to
> that.

So maybe something like the patch below (untested).

---
 drivers/base/power/wakeup.c |   82 +++++++++++++++++---------------------------
 1 file changed, 33 insertions(+), 49 deletions(-)

Index: linux-pm/drivers/base/power/wakeup.c
===================================================================
--- linux-pm.orig/drivers/base/power/wakeup.c
+++ linux-pm/drivers/base/power/wakeup.c
@@ -228,27 +228,6 @@ void wakeup_source_unregister(struct wak
 EXPORT_SYMBOL_GPL(wakeup_source_unregister);
 
 /**
- * device_wakeup_attach - Attach a wakeup source object to a device object.
- * @dev: Device to handle.
- * @ws: Wakeup source object to attach to @dev.
- *
- * This causes @dev to be treated as a wakeup device.
- */
-static int device_wakeup_attach(struct device *dev, struct wakeup_source *ws)
-{
-	spin_lock_irq(&dev->power.lock);
-	if (dev->power.wakeup) {
-		spin_unlock_irq(&dev->power.lock);
-		return -EEXIST;
-	}
-	dev->power.wakeup = ws;
-	if (dev->power.wakeirq)
-		device_wakeup_attach_irq(dev, dev->power.wakeirq);
-	spin_unlock_irq(&dev->power.lock);
-	return 0;
-}
-
-/**
  * device_wakeup_enable - Enable given device to be a wakeup source.
  * @dev: Device to handle.
  *
@@ -265,15 +244,29 @@ int device_wakeup_enable(struct device *
 	if (pm_suspend_target_state != PM_SUSPEND_ON)
 		dev_dbg(dev, "Suspicious %s() during system transition!\n", __func__);
 
+	spin_lock_irq(&dev->power.lock);
+
+	if (dev->power.wakeup) {
+		spin_unlock_irq(&dev->power.lock);
+		return -EEXIST;
+	}
+	dev->power.wakeup = ERR_PTR(-EBUSY);
+
+	spin_unlock_irq(&dev->power.lock);
+
 	ws = wakeup_source_register(dev_name(dev));
 	if (!ws)
 		return -ENOMEM;
 
-	ret = device_wakeup_attach(dev, ws);
-	if (ret)
-		wakeup_source_unregister(ws);
+	spin_lock_irq(&dev->power.lock);
 
-	return ret;
+	dev->power.wakeup = ws;
+	if (dev->power.wakeirq)
+		device_wakeup_attach_irq(dev, dev->power.wakeirq);
+
+	spin_unlock_irq(&dev->power.lock);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(device_wakeup_enable);
 
@@ -294,7 +287,7 @@ void device_wakeup_attach_irq(struct dev
 	struct wakeup_source *ws;
 
 	ws = dev->power.wakeup;
-	if (!ws)
+	if (IS_ERR_OR_NULL(ws))
 		return;
 
 	if (ws->wakeirq)
@@ -316,7 +309,7 @@ void device_wakeup_detach_irq(struct dev
 	struct wakeup_source *ws;
 
 	ws = dev->power.wakeup;
-	if (ws)
+	if (!IS_ERR_OR_NULL(ws))
 		ws->wakeirq = NULL;
 }
 
@@ -353,23 +346,6 @@ void device_wakeup_disarm_wake_irqs(void
 }
 
 /**
- * device_wakeup_detach - Detach a device's wakeup source object from it.
- * @dev: Device to detach the wakeup source object from.
- *
- * After it returns, @dev will not be treated as a wakeup device any more.
- */
-static struct wakeup_source *device_wakeup_detach(struct device *dev)
-{
-	struct wakeup_source *ws;
-
-	spin_lock_irq(&dev->power.lock);
-	ws = dev->power.wakeup;
-	dev->power.wakeup = NULL;
-	spin_unlock_irq(&dev->power.lock);
-	return ws;
-}
-
-/**
  * device_wakeup_disable - Do not regard a device as a wakeup source any more.
  * @dev: Device to handle.
  *
@@ -383,8 +359,16 @@ int device_wakeup_disable(struct device
 	if (!dev || !dev->power.can_wakeup)
 		return -EINVAL;
 
-	ws = device_wakeup_detach(dev);
-	wakeup_source_unregister(ws);
+	spin_lock_irq(&dev->power.lock);
+
+	ws = dev->power.wakeup;
+	dev->power.wakeup = NULL;
+
+	spin_unlock_irq(&dev->power.lock);
+
+	if (!IS_ERR(ws))
+		wakeup_source_unregister(ws);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(device_wakeup_disable);
@@ -558,7 +542,7 @@ void __pm_stay_awake(struct wakeup_sourc
 {
 	unsigned long flags;
 
-	if (!ws)
+	if (IS_ERR_OR_NULL(ws))
 		return;
 
 	spin_lock_irqsave(&ws->lock, flags);
@@ -675,7 +659,7 @@ void __pm_relax(struct wakeup_source *ws
 {
 	unsigned long flags;
 
-	if (!ws)
+	if (IS_ERR_OR_NULL(ws))
 		return;
 
 	spin_lock_irqsave(&ws->lock, flags);
@@ -746,7 +730,7 @@ void pm_wakeup_ws_event(struct wakeup_so
 	unsigned long flags;
 	unsigned long expires;
 
-	if (!ws)
+	if (IS_ERR_OR_NULL(ws))
 		return;
 
 	spin_lock_irqsave(&ws->lock, flags);



