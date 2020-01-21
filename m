Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 508091447FB
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2020 00:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgAUXDU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jan 2020 18:03:20 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:51000 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgAUXDU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jan 2020 18:03:20 -0500
Received: from 79.184.255.84.ipv4.supernova.orange.pl (79.184.255.84) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 674d66d8d2beced4; Wed, 22 Jan 2020 00:03:16 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Chanho Min <chanho.min@lge.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daewoong Kim <daewoong00.kim@lge.com>,
        Seokjoo Lee <seokjoo.lee@lge.com>,
        Lee Gunho <gunho.lee@lge.com>
Subject: Re: [PATCH] PM / sleep: fix use-after-free on async resume
Date:   Wed, 22 Jan 2020 00:03:16 +0100
Message-ID: <175529881.VBaH80lGUZ@kreacher>
In-Reply-To: <CAJZ5v0hP4S3+8yNZkbWAUaQof_ikar+w3F8Li6zvPSJcKif3NQ@mail.gmail.com>
References: <1579568452-27253-1-git-send-email-chanho.min@lge.com> <CAJZ5v0hP4S3+8yNZkbWAUaQof_ikar+w3F8Li6zvPSJcKif3NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday, January 21, 2020 5:54:58 PM CET Rafael J. Wysocki wrote:
> On Tue, Jan 21, 2020 at 2:31 AM Chanho Min <chanho.min@lge.com> wrote:
> >
> > Some device can be released during suspend (e.g. usb disconnection).
> > But, Its child device still use dev->parent's lock in dpm_wait().
> > It can be ocurred use-after-free as bellows. This is happened during
> > usb resume in practice.
> 
> In that case the resume of the child is going to be carried out after
> its parent has gone away, which is generally incorrect..

That isn't really a problem in the case at hand, though, because the memory
taken up by the parent can only be freed when all of its children have been
unregistered and all of the class, type, bus, driver etc pointers of the
children are NULL then, so there won't be a resume callback to execute for
the child.

> > device hierarchy: "1-1" <- "1-1:1.2" <- "ep83"
> >
> > <parent>                <child>
> > device_resume("1-1:1.2")
> > dpm_wait("1-1")
> >                         device_resume("ep_83");
> >                         dpm_wait("1-1:1.2");
> >  usb_disconnect
> >   put_device("1-1:1.2")
> >
> > put_device("1-1:1.2")
> >  usb_release_interface
> >  kfree(intf) <- "1-1:1.2"'s struct device is freed
> >
> >                          wait_for_common
> >                          do {
> >                          ...
> >                          spin_lock_irq(&x->wait.lock); <- "1-1:1-2"'s lock
> >                          } while (!x->done && timeout);
> >
> > This is call stack of the system hang caused by freed lock value in practice.
> >
> > Call trace:
> > [<ffffffc000ef59a8>] _raw_spin_lock_irq+0x38/0x80
> > [<ffffffc000ef2dac>] wait_for_common+0x12c/0x140
> > [<ffffffc000ef2dd4>] wait_for_completion+0x14/0x20
> > [<ffffffc000480c1c>] dpm_wait+0x5c/0xb0
> > [<ffffffc0004813d8>] device_resume+0x78/0x320
> > [<ffffffc000481ed4>] async_resume+0x24/0xe0
> > [<ffffffc0000c671c>] async_run_entry_fn+0x54/0x158
> > [<ffffffc0000bd720>] process_one_work+0x1e8/0x4b0
> > [<ffffffc0000bdb10>] worker_thread+0x128/0x4b8
> > [<ffffffc0000c3a14>] kthread+0x10c/0x110
> > [<ffffffc00008ddd0>] ret_from_fork+0x10/0x40
> >
> > To prevent such use-after-free, dpm_wait_for_parent() keeps parent's reference
> > using get/put_device even if it is disconnected.
> >
> > Signed-off-by: Chanho Min <chanho.min@lge.com>
> > Signed-off-by: Daewoong Kim <daewoong00.kim@lge.com>
> > ---
> >  drivers/base/power/main.c | 22 +++++++++++++++++++---
> >  1 file changed, 19 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > index f946511..95a7499 100644
> > --- a/drivers/base/power/main.c
> > +++ b/drivers/base/power/main.c
> > @@ -234,13 +234,29 @@ static void initcall_debug_report(struct device *dev, ktime_t calltime,
> >   * @dev: Device to wait for.
> >   * @async: If unset, wait only if the device's power.async_suspend flag is set.
> >   */
> > +static void _dpm_wait(struct device *dev, bool async)
> > +{
> > +       if (async || (pm_async_enabled && dev->power.async_suspend))
> > +               wait_for_completion(&dev->power.completion);
> > +}
> > +
> >  static void dpm_wait(struct device *dev, bool async)
> >  {
> >         if (!dev)
> >                 return;
> >
> > -       if (async || (pm_async_enabled && dev->power.async_suspend))
> > -               wait_for_completion(&dev->power.completion);
> > +       _dpm_wait(dev, async);
> > +}
> > +
> > +static void dpm_wait_for_parent(struct device *dev, bool async)
> > +{
> > +       if (dev && dev->parent) {
> > +               struct device *dev_p = dev->parent;
> > +
> 
> This is racy, because the parent may have gone away already before the
> get_device() below.
> 
> > +               get_device(dev_p);
> > +               _dpm_wait(dev_p, async);
> > +               put_device(dev_p);
> > +       }
> >  }
> >
> >  static int dpm_wait_fn(struct device *dev, void *async_ptr)
> > @@ -277,7 +293,7 @@ static void dpm_wait_for_suppliers(struct device *dev, bool async)
> >
> >  static void dpm_wait_for_superior(struct device *dev, bool async)
> >  {
> > -       dpm_wait(dev->parent, async);
> > +       dpm_wait_for_parent(dev, async);
> >         dpm_wait_for_suppliers(dev, async);
> >  }
> >
> > --
> 
> Something a bit more sophisticated is needed here, let me think about that.
> 

I've ended up with the patch below.

The lock prevents the unregistration of dev from completing, if it is acquired
before device_pm_remove() in device_del(), and that prevents the parent
reference from being dropped (at the end of the latter) until the lock is held.
If the lock is acquired after device_pm_remove() has been called for the
device, there obviously is no need to wait for the parent.

---
 drivers/base/power/main.c |   24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -275,7 +275,29 @@ static void dpm_wait_for_suppliers(struc
 
 static void dpm_wait_for_superior(struct device *dev, bool async)
 {
-	dpm_wait(dev->parent, async);
+	struct device *parent;
+
+	/*
+	 * If the device and its parent are both resumed asynchronously and the
+	 * parent's callback deletes both the device and the parent itself, the
+	 * parent object may be freed while this function is running, so avoid
+	 * that by reference counting the parent once more unless the device has
+	 * been deleted already.
+	 */
+	mutex_lock(&dpm_list_mtx);
+
+	if (!device_pm_initialized(dev)) {
+		mutex_unlock(&dpm_list_mtx);
+		return;
+	}
+
+	parent = get_device(dev->parent);
+
+	mutex_unlock(&dpm_list_mtx);
+
+	dpm_wait(parent, async);
+	put_device(parent);
+
 	dpm_wait_for_suppliers(dev, async);
 }
 



