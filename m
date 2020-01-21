Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4A6214485D
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2020 00:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgAUXfO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jan 2020 18:35:14 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:43769 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgAUXfN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jan 2020 18:35:13 -0500
Received: from 79.184.255.84.ipv4.supernova.orange.pl (79.184.255.84) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 282784e7c78b0209; Wed, 22 Jan 2020 00:35:11 +0100
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
Date:   Wed, 22 Jan 2020 00:35:11 +0100
Message-ID: <24696489.X8ojiuEZiU@kreacher>
In-Reply-To: <175529881.VBaH80lGUZ@kreacher>
References: <1579568452-27253-1-git-send-email-chanho.min@lge.com> <CAJZ5v0hP4S3+8yNZkbWAUaQof_ikar+w3F8Li6zvPSJcKif3NQ@mail.gmail.com> <175529881.VBaH80lGUZ@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday, January 22, 2020 12:03:16 AM CET Rafael J. Wysocki wrote:
> On Tuesday, January 21, 2020 5:54:58 PM CET Rafael J. Wysocki wrote:
> > On Tue, Jan 21, 2020 at 2:31 AM Chanho Min <chanho.min@lge.com> wrote:
> > >
> > > Some device can be released during suspend (e.g. usb disconnection).
> > > But, Its child device still use dev->parent's lock in dpm_wait().
> > > It can be ocurred use-after-free as bellows. This is happened during
> > > usb resume in practice.
> > 
> > In that case the resume of the child is going to be carried out after
> > its parent has gone away, which is generally incorrect..
> 
> That isn't really a problem in the case at hand, though, because the memory
> taken up by the parent can only be freed when all of its children have been
> unregistered and all of the class, type, bus, driver etc pointers of the
> children are NULL then, so there won't be a resume callback to execute for
> the child.

Well, not really true, because device_del() doesn't clear dev->bus, for
example, AFAICS, so the resume really needs to be explicitly avoided if
the device has been deleted.

[cut]

> > > --
> > 
> > Something a bit more sophisticated is needed here, let me think about that.
> > 
> 
> I've ended up with the patch below.
> 
> The lock prevents the unregistration of dev from completing, if it is acquired
> before device_pm_remove() in device_del(), and that prevents the parent
> reference from being dropped (at the end of the latter) until the lock is held.
> If the lock is acquired after device_pm_remove() has been called for the
> device, there obviously is no need to wait for the parent.
> 

So something like this should work:

---
 drivers/base/power/main.c |   42 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -273,10 +273,38 @@ static void dpm_wait_for_suppliers(struc
 	device_links_read_unlock(idx);
 }
 
-static void dpm_wait_for_superior(struct device *dev, bool async)
+static bool dpm_wait_for_superior(struct device *dev, bool async)
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
+		return false;
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
+
+	/*
+	 * If the parent's callback has deleted the device, it is not correct to
+	 * attempt to resume it, so avoid doing that then.
+	 */
+	return device_pm_initialized(dev);
 }
 
 static void dpm_wait_for_consumers(struct device *dev, bool async)
@@ -621,7 +649,8 @@ static int device_resume_noirq(struct de
 	if (!dev->power.is_noirq_suspended)
 		goto Out;
 
-	dpm_wait_for_superior(dev, async);
+	if (!dpm_wait_for_superior(dev, async))
+		goto Out;
 
 	skip_resume = dev_pm_may_skip_resume(dev);
 
@@ -829,7 +858,8 @@ static int device_resume_early(struct de
 	if (!dev->power.is_late_suspended)
 		goto Out;
 
-	dpm_wait_for_superior(dev, async);
+	if (!dpm_wait_for_superior(dev, async))
+		goto Out;
 
 	callback = dpm_subsys_resume_early_cb(dev, state, &info);
 
@@ -944,7 +974,9 @@ static int device_resume(struct device *
 		goto Complete;
 	}
 
-	dpm_wait_for_superior(dev, async);
+	if (!dpm_wait_for_superior(dev, async))
+		goto Complete;
+
 	dpm_watchdog_set(&wd, dev);
 	device_lock(dev);
 



