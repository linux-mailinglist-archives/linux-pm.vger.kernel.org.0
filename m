Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C143FFBC0
	for <lists+linux-pm@lfdr.de>; Fri,  3 Sep 2021 10:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348258AbhICISz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Sep 2021 04:18:55 -0400
Received: from first.geanix.com ([116.203.34.67]:37292 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348240AbhICISy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 3 Sep 2021 04:18:54 -0400
Received: from skn-laptop (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id BB3D2440FA9;
        Fri,  3 Sep 2021 08:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1630657072; bh=YAAirGmlsOW0wiWdoathwqmAEWUQMpo7sW6Iif354yU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=SyOPOvfoa5pBOBA5e3O6DVmobu0uxgrr9IoH4E9OsOQNrUaK+5hMeVgit4U5VJlWd
         lGjDbnjSIaTLvcueAe2dWbQCaO6n1LHV0gxTTWXMFV++dqIyVyAWut1f3o/LJh+zFL
         3SwXSVROG8vxu9Z+iuItHLzIEBxyv8xbxZ3RauP0qhGIoR9wURX9rqW+NrSiNNYgF2
         kthDlQIJmp49FVLKAI80USo6TSeDsaMA1hFg0m8LP7GvqHTkYHmdfjaK4sR4maMcOv
         28hHTYgsMeH/MwKn7AyRZ4NzEFTEnrrdKaxVoGOg/vgq4ka0UFAekKVVgEsral6FNg
         BYwmsLTH8cAfg==
Date:   Fri, 3 Sep 2021 10:17:51 +0200
From:   Sean Nyekjaer <sean@geanix.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Richard Weinberger <richard@nod.at>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>, linux-mtd@lists.infradead.org
Subject: Re: [PATCH] PM / suspend: move userspace freeze before disk sync
Message-ID: <20210903081751.3qq36nrksucqthss@skn-laptop>
References: <20210901083442.210230-1-sean@geanix.com>
 <CAJZ5v0j5dMDSDjhuXaZd=_J5JOP4Z09WUXfjWX_iCcT4RDisCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j5dMDSDjhuXaZd=_J5JOP4Z09WUXfjWX_iCcT4RDisCg@mail.gmail.com>
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on 13e2a5895688
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 02, 2021 at 06:28:14PM +0200, Rafael J. Wysocki wrote:
> On Wed, Sep 1, 2021 at 10:35 AM Sean Nyekjaer <sean@geanix.com> wrote:
> >
> > This fixes an issue where data remains unwritten before suspend.
> 
> Well, it doesn't make the issue go away, it just hides it for you and
> it may very well expose it for someone else.

OK

> 
> In particular, note that you can compile the kernel with
> CONFIG_SUSPEND_SKIP_SYNC set which makes it not sync at all during
> system-wide suspend and this is a valid case expected to work.  It
> looks like this case doesn't work for you.
> 
> > UBI tried to write data, before the mtd device had been unsuspended.
> 
> Well, that's the real problem and it can happen regardless of whether
> or not this patch is there.

How to fix it then?
We can't live with devices that bricks on unsuspend :/

/Sean

> 
> > Seen on an iMX6ULL board fitted with rawnand flash.
> >
> > Before:
> > PM: suspend entry (deep)
> > Filesystems sync: 0.088 seconds
> > Freezing user space processes ... (elapsed 0.000 seconds) done.
> > OOM killer disabled.
> > Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> > printk: Suspending console(s) (use no_console_suspend to debug)
> > PM: suspend devices took 0.030 seconds
> > Disabling non-boot CPUs ...
> > ubi0 error: ubi_io_write: error -16 while writing 4096 bytes to PEB 1762:94208, written 0 bytes
> >
> > After:
> > PM: suspend entry (deep)
> > Freezing user space processes ... (elapsed 0.001 seconds) done.
> > OOM killer disabled.
> > Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> > Filesystems sync: 0.060 seconds
> > printk: Suspending console(s) (use no_console_suspend to debug)
> > PM: suspend devices took 0.040 seconds
> > Disabling non-boot CPUs ...
> > PM: resume devices took 0.100 seconds
> >
> > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
