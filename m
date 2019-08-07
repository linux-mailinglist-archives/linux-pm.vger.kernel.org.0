Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28CE284975
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2019 12:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfHGK3H convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 7 Aug 2019 06:29:07 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41546 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729422AbfHGK3H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Aug 2019 06:29:07 -0400
Received: from 79.184.254.29.ipv4.supernova.orange.pl (79.184.254.29) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id 63d9f0ce3a355a2c; Wed, 7 Aug 2019 12:29:02 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Mario Limonciello <Mario.Limonciello@dell.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Keith Busch <kbusch@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>
Subject: Re: [Regression] Commit "nvme/pci: Use host managed power state for suspend" has problems
Date:   Wed, 07 Aug 2019 12:29:02 +0200
Message-ID: <1600168.spi3KQNTFG@kreacher>
In-Reply-To: <CAJZ5v0gBCTyRwg0ePHOD4qQvcSwXzHjb5hkswQ7=Ki=gO_nx0A@mail.gmail.com>
References: <4323ed84dd07474eab65699b4d007aaf@AUSX13MPC105.AMER.DELL.COM> <1d05e26a91f94e5b92eaf5854fa85289@AUSX13MPC105.AMER.DELL.COM> <CAJZ5v0gBCTyRwg0ePHOD4qQvcSwXzHjb5hkswQ7=Ki=gO_nx0A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday, August 6, 2019 5:00:06 PM CEST Rafael J. Wysocki wrote:
> On Tue, Aug 6, 2019 at 4:02 PM <Mario.Limonciello@dell.com> wrote:
> >
> >
> >
> > > -----Original Message-----
> > > From: Rafael J. Wysocki <rafael@kernel.org>
> > > Sent: Monday, August 5, 2019 4:29 PM
> > > To: Kai-Heng Feng
> > > Cc: Rafael J. Wysocki; Limonciello, Mario; Keith Busch; Keith Busch; Christoph
> > > Hellwig; Sagi Grimberg; linux-nvme; Linux PM; Linux Kernel Mailing List; Rajat Jain
> > > Subject: Re: [Regression] Commit "nvme/pci: Use host managed power state for
> > > suspend" has problems
> > >
> > >
> > > [EXTERNAL EMAIL]
> > >
> > > On Mon, Aug 5, 2019 at 9:14 PM Kai-Heng Feng
> > > <kai.heng.feng@canonical.com> wrote:
> > > >
> > > > at 19:04, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > >
> > > > > On Fri, Aug 2, 2019 at 12:55 PM Kai-Heng Feng
> > > > > <kai.heng.feng@canonical.com> wrote:
> > > > >> at 06:26, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > >>
> > > > >>> On Thu, Aug 1, 2019 at 9:05 PM <Mario.Limonciello@dell.com> wrote:
> > > > >>>>> -----Original Message-----
> > > > >>>>> From: Rafael J. Wysocki <rafael@kernel.org>
> > > > >>>>> Sent: Thursday, August 1, 2019 12:30 PM
> > > > >>>>> To: Kai-Heng Feng; Keith Busch; Limonciello, Mario
> > > > >>>>> Cc: Keith Busch; Christoph Hellwig; Sagi Grimberg; linux-nvme; Linux
> > > > >>>>> PM; Linux
> > > > >>>>> Kernel Mailing List; Rajat Jain
> > > > >>>>> Subject: Re: [Regression] Commit "nvme/pci: Use host managed power
> > > > >>>>> state for
> > > > >>>>> suspend" has problems
> > > > >>>>>
> > > > >>>>>
> > > > >>>>> [EXTERNAL EMAIL]
> > > > >>>>>
> > > > >>>>> On Thu, Aug 1, 2019 at 11:06 AM Kai-Heng Feng
> > > > >>>>> <kai.heng.feng@canonical.com> wrote:
> > > > >>>>>> at 06:33, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > >>>>>>
> > > > >>>>>>> On Thu, Aug 1, 2019 at 12:22 AM Keith Busch <kbusch@kernel.org>
> > > > >>>>>>> wrote:
> > > > >>>>>>>> On Wed, Jul 31, 2019 at 11:25:51PM +0200, Rafael J. Wysocki wrote:
> > > > >>>>>>>>> A couple of remarks if you will.
> > > > >>>>>>>>>
> > > > >>>>>>>>> First, we don't know which case is the majority at this point.  For
> > > > >>>>>>>>> now, there is one example of each, but it may very well turn out
> > > > >>>>>>>>> that
> > > > >>>>>>>>> the SK Hynix BC501 above needs to be quirked.
> > > > >>>>>>>>>
> > > > >>>>>>>>> Second, the reference here really is 5.2, so if there are any
> > > > >>>>>>>>> systems
> > > > >>>>>>>>> that are not better off with 5.3-rc than they were with 5.2,
> > > > >>>>>>>>> well, we
> > > > >>>>>>>>> have not made progress.  However, if there are systems that are
> > > > >>>>>>>>> worse
> > > > >>>>>>>>> off with 5.3, that's bad.  In the face of the latest findings the
> > > > >>>>>>>>> only
> > > > >>>>>>>>> way to avoid that is to be backwards compatible with 5.2 and that's
> > > > >>>>>>>>> where my patch is going.  That cannot be achieved by quirking all
> > > > >>>>>>>>> cases that are reported as "bad", because there still may be
> > > > >>>>>>>>> unreported ones.
> > > > >>>>>>>>
> > > > >>>>>>>> I have to agree. I think your proposal may allow PCI D3cold,
> > > > >>>>>>>
> > > > >>>>>>> Yes, it may.
> > > > >>>>>>
> > > > >>>>>> Somehow the 9380 with Toshiba NVMe never hits SLP_S0 with or
> > > without
> > > > >>>>>> Rafael’s patch.
> > > > >>>>>> But the “real” s2idle power consumption does improve with the patch.
> > > > >>>>>
> > > > >>>>> Do you mean this patch:
> > > > >>>>>
> > > > >>>>> https://lore.kernel.org/linux-pm/70D536BE-8DC7-4CA2-84A9-
> > > > >>>>>
> > > AFB067BA520E@canonical.com/T/#m456aa5c69973a3b68f2cdd4713a1ce83be5145
> > > > >>>>> 8f
> > > > >>>>>
> > > > >>>>> or the $subject one without the above?
> > > > >>>>>
> > > > >>>>>> Can we use a DMI based quirk for this platform? It seems like a
> > > > >>>>>> platform
> > > > >>>>>> specific issue.
> > > > >>>>>
> > > > >>>>> We seem to see too many "platform-specific issues" here. :-)
> > > > >>>>>
> > > > >>>>> To me, the status quo (ie. what we have in 5.3-rc2) is not defensible.
> > > > >>>>> Something needs to be done to improve the situation.
> > > > >>>>
> > > > >>>> Rafael, would it be possible to try popping out PC401 from the 9380 and
> > > > >>>> into a 9360 to
> > > > >>>> confirm there actually being a platform impact or not?
> > > > >>>
> > > > >>> Not really, sorry.
> > > > >>>
> > > > >>>> I was hoping to have something useful from Hynix by now before
> > > > >>>> responding, but oh well.
> > > > >>>>
> > > > >>>> In terms of what is the majority, I do know that between folks at Dell,
> > > > >>>> Google, Compal,
> > > > >>>> Wistron, Canonical, Micron, Hynix, Toshiba, LiteOn, and Western Digital
> > > > >>>> we tested a wide
> > > > >>>> variety of SSDs with this patch series.  I would like to think that they
> > > > >>>> are representative of
> > > > >>>> what's being manufactured into machines now.
> > > > >>>
> > > > >>> Well, what about drives already in the field?  My concern is mostly
> > > > >>> about those ones.
> > > > >>>
> > > > >>>> Notably the LiteOn CL1 was tested with the HMB flushing support and
> > > > >>>> and Hynix PC401 was tested with older firmware though.
> > > > >>>>
> > > > >>>>>>>> In which case we do need to reintroduce the HMB handling.
> > > > >>>>>>>
> > > > >>>>>>> Right.
> > > > >>>>>>
> > > > >>>>>> The patch alone doesn’t break HMB Toshiba NVMe I tested. But I think
> > > > >>>>>> it’s
> > > > >>>>>> still safer to do proper HMB handling.
> > > > >>>>>
> > > > >>>>> Well, so can anyone please propose something specific?  Like an
> > > > >>>>> alternative patch?
> > > > >>>>
> > > > >>>> This was proposed a few days ago:
> > > > >>>> http://lists.infradead.org/pipermail/linux-nvme/2019-July/026056.html
> > > > >>>>
> > > > >>>> However we're still not sure why it is needed, and it will take some
> > > > >>>> time to get
> > > > >>>> a proper failure analysis from LiteOn  regarding the CL1.
> > > > >>>
> > > > >>> Thanks for the update, but IMO we still need to do something before
> > > > >>> final 5.3 while the investigation continues.
> > > > >>>
> > > > >>> Honestly, at this point I would vote for going back to the 5.2
> > > > >>> behavior at least by default and only running the new code on the
> > > > >>> drives known to require it (because they will block PC10 otherwise).
> > > > >>>
> > > > >>> Possibly (ideally) with an option for users who can't get beyond PC3
> > > > >>> to test whether or not the new code helps them.
> > > > >>
> > > > >> I just found out that the XPS 9380 at my hand never reaches SLP_S0 but
> > > > >> only
> > > > >> PC10.
> > > > >
> > > > > That's the case for me too.
> > > > >
> > > > >> This happens with or without putting the device to D3.
> > > > >
> > > > > On my system, though, it only can get to PC3 without putting the NVMe
> > > > > into D3 (as reported previously).
> > > >
> > > > I forgot to ask, what BIOS version does the system have?
> > > > I don’t see this issue on BIOS v1.5.0.
> > >
> > > It is 1.5.0 here too.
> >
> > All, regarding the need for the patch proposed by Rafael on PC401, I have some updates
> > to share from Hynix.
> > First off - the firmware changelog is misleading from 80006E00 to 80007E00.
> >
> > The change was made in the firmware specifically because of a change in behavior from
> > Intel KBL to CFL and WHL.  On CFL/WHL the period of time that RefClk was turned on after L1.2
> > was larger than KBL platforms.  So this meant that Hynix couldn't lock up from CLKREQ#
> > to RefClk as quickly on CFL/WHL.  So there is a "larger" fixed delay introduced in their FW.
> >
> > To those that don't know - XPS 9380 is a WHL platform.
> >
> > Second - a hypothesis of what is happening with the patch proposed by Rafael is that the link
> > is only transitioning to L1.0 rather than L1.2.  This may satisfy the PMC but it shouldn't lead to
> > the lowest actual device power state.
> 
> The north complex doesn't get to PC10 without this patch, so this is
> more about the PCIe root complex than the PMC.
> 
> PC3 vs PC10 is a big deal regardless of what the NVMe can achieve.

This has been resolved as I said here:

https://lore.kernel.org/linux-pm/2763495.NmdaWeg79L@kreacher/T/#m2a341a34faeab84ab92d106129d2b946d193e60b




