Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A303B3FFCE8
	for <lists+linux-pm@lfdr.de>; Fri,  3 Sep 2021 11:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbhICJS7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 3 Sep 2021 05:18:59 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:33049 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348714AbhICJS7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Sep 2021 05:18:59 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id BC5AC20005;
        Fri,  3 Sep 2021 09:17:56 +0000 (UTC)
Date:   Fri, 3 Sep 2021 11:17:55 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Richard Weinberger <richard@nod.at>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>, linux-mtd@lists.infradead.org
Subject: Re: [PATCH] PM / suspend: move userspace freeze before disk sync
Message-ID: <20210903111755.0972850d@xps13>
In-Reply-To: <20210903081751.3qq36nrksucqthss@skn-laptop>
References: <20210901083442.210230-1-sean@geanix.com>
        <CAJZ5v0j5dMDSDjhuXaZd=_J5JOP4Z09WUXfjWX_iCcT4RDisCg@mail.gmail.com>
        <20210903081751.3qq36nrksucqthss@skn-laptop>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sean,

sean@geanix.com wrote on Fri, 3 Sep 2021 10:17:51 +0200:

> On Thu, Sep 02, 2021 at 06:28:14PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Sep 1, 2021 at 10:35 AM Sean Nyekjaer <sean@geanix.com> wrote:  
> > >
> > > This fixes an issue where data remains unwritten before suspend.  
> > 
> > Well, it doesn't make the issue go away, it just hides it for you and
> > it may very well expose it for someone else.  
> 
> OK
> 
> > 
> > In particular, note that you can compile the kernel with
> > CONFIG_SUSPEND_SKIP_SYNC set which makes it not sync at all during
> > system-wide suspend and this is a valid case expected to work.  It
> > looks like this case doesn't work for you.
> >   
> > > UBI tried to write data, before the mtd device had been unsuspended.  
> > 
> > Well, that's the real problem and it can happen regardless of whether
> > or not this patch is there.  
> 
> How to fix it then?
> We can't live with devices that bricks on unsuspend :/

We then need to focus on UBI/UBIFS implementation (Richard is currently
off), maybe there is more logic than just a basic retry to implement.

Thanks,
Miquèl
