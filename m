Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 967E05F6A5
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2019 12:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfGDKb2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Jul 2019 06:31:28 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:47330 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbfGDKb1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Jul 2019 06:31:27 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 8f56e755e5c9ce7d; Thu, 4 Jul 2019 12:31:25 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Tri Vo <trong@android.com>, viresh.kumar@linaro.org,
        rafael@kernel.org, hridya@google.com, sspatil@google.com,
        kaleshsingh@google.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2] PM / wakeup: show wakeup sources stats in sysfs
Date:   Thu, 04 Jul 2019 12:31:24 +0200
Message-ID: <3451189.hAX5mKGt1u@kreacher>
In-Reply-To: <20190628151040.GA14074@kroah.com>
References: <20190627000412.GA527@kroah.com> <20190627225335.72107-1-trong@android.com> <20190628151040.GA14074@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Friday, June 28, 2019 5:10:40 PM CEST Greg KH wrote:
> On Thu, Jun 27, 2019 at 03:53:35PM -0700, Tri Vo wrote:
> > Userspace can use wakeup_sources debugfs node to plot history of suspend
> > blocking wakeup sources over device's boot cycle. This information can
> > then be used (1) for power-specific bug reporting and (2) towards
> > attributing battery consumption to specific processes over a period of
> > time.
> > 
> > However, debugfs doesn't have stable ABI. For this reason, expose wakeup
> > sources statistics in sysfs under /sys/power/wakeup_sources/<name>/
> > 
> > Embedding a struct kobject into struct wakeup_source changes lifetime
> > requirements on the latter. To that end, change deallocation of struct
> > wakeup_source using kfree to kobject_put().
> > 
> > Change struct wakelock's wakeup_source member to a pointer to decouple
> > lifetimes of struct wakelock and struct wakeup_source for above reason.
> > 
> > Introduce CONFIG_PM_SLEEP_STATS that enables/disables showing wakeup
> > source statistics in sysfs.
> > 
> > Signed-off-by: Tri Vo <trong@android.com>
> 
> Ok, this looks much better, but I don't like the use of a "raw" kobject
> here.  It is much simpler, and less code, to use 'struct device'
> instead.
> 
> As proof, I reworked the patch to do just that, and it saves over 50
> lines of .c code, which is always nice :)

Thanks for taking the time to do that!

> Attached below is the reworked code, along with the updated
> documentation file.  It creates devices in a virtual class, and you can
> easily iterate over them all by looking in /sys/class/wakeup/.

That actually is nice - no need to add anything under /sys/power/.

> Note, I'm note quite sure you need all of the changes you made in
> kernel/power/wakelock.c when you make the structure contain a pointer to
> the wakeup source and not the structure itself, but I just went with it
> and got it all to build properly.

I'm not really sure about it either.

> Also note, I've not actually tested this at all, only built it, so I
> _strongly_ suggest that you test this to make sure it really works :)
> 
> What do you think?

I agree with the direction. :-)

Cheers!



