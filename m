Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 851C1F6A8F
	for <lists+linux-pm@lfdr.de>; Sun, 10 Nov 2019 18:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfKJRYH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Nov 2019 12:24:07 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:53730 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbfKJRYG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 Nov 2019 12:24:06 -0500
Received: from 79.184.254.83.ipv4.supernova.orange.pl (79.184.254.83) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 28f6aa7359404610; Sun, 10 Nov 2019 18:24:04 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Doug Smythies <dsmythies@telus.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2] cpuidle: Use nanoseconds as the unit of time
Date:   Sun, 10 Nov 2019 18:24:04 +0100
Message-ID: <6163696.37NBKbymtj@kreacher>
In-Reply-To: <CAJZ5v0gZDJ2=PiiGw2mcCcVKBM2OyM1G9nRvJ+iWLFUQcXqZuw@mail.gmail.com>
References: <10494959.bKODIZ00nm@kreacher> <000a01d59656$99798710$cc6c9530$@net> <CAJZ5v0gZDJ2=PiiGw2mcCcVKBM2OyM1G9nRvJ+iWLFUQcXqZuw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sunday, November 10, 2019 5:48:21 PM CET Rafael J. Wysocki wrote:
> On Fri, Nov 8, 2019 at 6:04 PM Doug Smythies <dsmythies@telus.net> wrote:
> >
> > On 2019.11.08 01:45 Rafael J. Wysocki wrote:
> > > On Fri, Nov 8, 2019 at 9:45 AM Doug Smythies <dsmythies@telus.net> wrote:
> > >
> > ...
> > >> I have been running this v2 today, with both menu and teo
> > >> governors. Acquiring some baseline reference data to compare
> > >> to now. The menu governor response seems different (Supporting
> > >> information/graphs will come later).
> > >
> > > That may be good or bad, depending in what way it is different. :-)
> >
> > My thinking was that the differences should be minimal between
> > the baseline (linux-next as of 2019.11.07) and plus your two patches.
> > Because this was a change of units, but not functionality.
> > Such is the case with the teo governor, but not the menu governor.
> > I have not tried the ladder or haltpoll governors, and don't intend to.
> >
> > Now to attempt to isolate the issue in the code, which might take
> > considerable time.
> 
> Thanks!
> 
> It looks like I have overlooked a unit conversion in menu or done a
> unit conversion twice somewhere.

I have found a bug, which should be addressed by the patch below.

If it still doesn't reduce the discrepancy, we'll need to look further.

---
 drivers/cpuidle/governors/menu.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -516,8 +516,8 @@ static void menu_update(struct cpuidle_d
 	new_factor -= new_factor / DECAY;
 
 	if (data->next_timer_ns > 0 && measured_ns < MAX_INTERESTING)
-		new_factor += RESOLUTION * div64_u64(measured_ns,
-						     data->next_timer_ns);
+		new_factor += div64_u64(RESOLUTION * measured_ns,
+					data->next_timer_ns);
 	else
 		/*
 		 * we were idle so long that we count it as a perfect



