Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 275CA108FAF
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2019 15:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbfKYOO4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Nov 2019 09:14:56 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:43167 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbfKYOO4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Nov 2019 09:14:56 -0500
Received: from 79.184.255.91.ipv4.supernova.orange.pl (79.184.255.91) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id cb423cbf1cd249e2; Mon, 25 Nov 2019 15:14:52 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: Help me fix a regression caused by 56b9918490 (PM: sleep: Simplify suspend-to-idle control flow)
Date:   Mon, 25 Nov 2019 15:14:52 +0100
Message-ID: <2977390.9qzeJo7xji@kreacher>
In-Reply-To: <CAJZ5v0ichG5N+yLyyX1BZhNf+Fk_xrvQ+9q4FeP3XVtxKp7yug@mail.gmail.com>
References: <alpine.DEB.2.21.1911211549500.3167@hp-x360n> <alpine.DEB.2.21.1911241929220.16116@hp-x360n> <CAJZ5v0ichG5N+yLyyX1BZhNf+Fk_xrvQ+9q4FeP3XVtxKp7yug@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday, November 25, 2019 2:27:00 PM CET Rafael J. Wysocki wrote:
> On Mon, Nov 25, 2019 at 4:40 AM Kenneth R. Crudup <kenny@panix.com> wrote:
> >
> >
> > Thanks for getting back to me.
> >
> > On Sun, 24 Nov 2019, Rafael J. Wysocki wrote:
> >
> > > > If "sleep_no_lps0" == 1, the machine never goes fully to sleep; the power
> > > > light stays on and the backlight goes off, but if I have external monitors
> > > > connected they're still showing dmesg activity. This is independent of the
> > > > state of "ec_no_wakeup".
> >
> > > Hmm.  The external monitors part is something you have never mentioned.
> >
> > I didn't realize that myself until I'd tried "sleep_no_lps0" testing for this
> > thread and happened to have my Thunderbolt dock connected.
> 
> OK, but with sleep_no_lps0, does it also hang during resume or not?
> 
> > > > If "ec_no_wakeup" == 1, the system *at times* will go to sleep and never return
> >
> > > This is unclear.  What exactly do you mean by "go to sleep"?
> >
> > It appears to do a suspend cycle; the screen goes off, the power light goes out,
> > and the power consumption (as measured at the charge port) (usually) goes to the
> > smallest draw this laptop is capable of in s2idle.
> >
> > > Which part of the behavior does the "at times" phrase apply to?  The
> > > "going to sleep" or coming back?  Or both?
> >
> > The coming back. Many times I'll hit a key on the keyboard (when "ec_no_wakeup"
> > is set) or open the lid or hit the the power button (if it's not set) and nothing
> > happens. IIRC the current draw doesn't increase either, but don't quote me on
> > that (it's easy enough to reproduce, so I'll try it out and report back).
> >
> > > > (i.e. no power light comes on, it's totally unresponsive until I do a hard
> > > > reset with a power-button long-press) whether I'm plugged in or not.
> > > > This is new behavior.
> >
> > > So how did it behave in 5.3.y?
> > ...
> > > > Help! What can I do to return to the behavior of right before the s0 rework?
> > > I guess you mean the 5.3.y behavior.  And what was it?
> > ...
> >
> > Seemed to always work; I don't recall any issues with s2idle in earlier
> > kernels. Sometimes my idle draw would be much higher than it should be, but
> > I have zero clue as to why that is (which is why I'm chasing down bleeding-
> > edge PM commits).
> >
> > > > If "ec_no_wakeup" == 0, the system goes fully to sleep and either of the
> > > > power button, lid opening or hitting a key resumes the laptop, but if I'm
> > > > plugged in and actually charging when I suspend (and I suspect if I plug
> > > > it in during suspend) it never returns, as in the case above.
> >
> > > OK, so ec_no_wakeup doesn't really change the behavior substantially,
> > > it only makes certain things more or less likely to happen.
> > > Does it still hang if you use the keyboard to wake up the system?
> >
> > When "ec_no_wakeup" is set, ONLY the keyboard wakes up the system, and the dead
> > system is unrelated to the method I'm using to wake things up.
> 
> In that case whatever happens in acpi_s2idle_wake() can be ruled out,
> because on your system that function effectively is a NOP with
> ec_no_wakeup.  I don't expect the test below to add anything new to
> what we know already.
> 
> > > > Where in the code could I start looking to try to find out where the machine
> > > > goes dead?
> > >
> > > Well, because you identified 56b991849 as the first bad commit, the
> > > following three lines of code in drivers/acpi/sleep.c are likely to be
> > > the source of the problem:
> > >
> > >         acpi_os_wait_events_complete(); /* synchronize EC GPE processing */
> > >         acpi_ec_flush_work();
> > >         acpi_os_wait_events_complete(); /* synchronize Notify handling */
> > >
> > > Can you please try to comment them out and retest?
> >
> > I'll do that and get back to you.
> >
> > > Note that you most likely won't be able to wake up the system via the
> > > lid/power button without them
> >
> > Yeah, I'm used to that.
> 
> So, as stated above, this test is not likely to be conclusive.
> 
> Now, given that the changes in acpi_s2idle_wake() don't matter, you
> seem to be missing the acpi_s2idle_sync() after
> dpm_noirq_resume_devices(), because dropping it was the only other
> substantial change made by commit 56b991849 AFAICS.
> 
> I'll send you a patch to try for that.

Appended (untested).

---
 drivers/acpi/sleep.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -977,6 +977,13 @@ static int acpi_s2idle_prepare_late(void
 	return 0;
 }
 
+static void acpi_s2idle_sync(void)
+{
+	acpi_os_wait_events_complete(); /* synchronize GPE processing */
+	acpi_ec_flush_work();
+	acpi_os_wait_events_complete(); /* synchronize Notify handling */
+}
+
 static void acpi_s2idle_wake(void)
 {
 	/*
@@ -1005,9 +1012,7 @@ static void acpi_s2idle_wake(void)
 		 * The EC driver uses the system workqueue and an additional
 		 * special one, so those need to be flushed too.
 		 */
-		acpi_os_wait_events_complete(); /* synchronize EC GPE processing */
-		acpi_ec_flush_work();
-		acpi_os_wait_events_complete(); /* synchronize Notify handling */
+		acpi_s2idle_sync();
 
 		rearm_wake_irq(acpi_sci_irq);
 	}
@@ -1024,6 +1029,8 @@ static void acpi_s2idle_restore_early(vo
 
 static void acpi_s2idle_restore(void)
 {
+	acpi_s2idle_sync();
+
 	s2idle_wakeup = false;
 
 	acpi_enable_all_runtime_gpes();




