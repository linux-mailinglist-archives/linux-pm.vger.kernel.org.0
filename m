Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7D37F5B2
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2019 13:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731051AbfHBLEX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 2 Aug 2019 07:04:23 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45786 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729311AbfHBLEX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Aug 2019 07:04:23 -0400
Received: by mail-ot1-f68.google.com with SMTP id x21so12226400otq.12;
        Fri, 02 Aug 2019 04:04:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w0DyH4xksTCHeFXBznMTiBORDsUdB4NA4Cc7BNCtCH8=;
        b=Sj/WWVU1rdZoZMfSAETgl2WwKAikqaRZaNpUlyz3VpQhHB2XqWSteGljhCSlYfrKb+
         HnRAm2QrCE02FrIrzcbv2uScIMiA4R4Z1CcC1L+uv+u2mAgU0CcoDYvza3zPBmlvmaku
         fZ71zEopli2QaBk9w8ZNpH3t6Cx/Ip/T3qiIEe0BfdWkwTwXRCf5GDagRlG/T1AFM9Ti
         ybQw/RLPc94xAJDeWtqIaeuVMC3ZL70sR1bbYk8I2XMndO8mlDXL1yBmQjhnIyeZD5RB
         toUnur1C/I5OfMz/5GIUqvjwHvJiF4RgNYnghVrjIpQaNS7r8wprXlQgpQ/8kpyS88Lo
         kjzw==
X-Gm-Message-State: APjAAAX/BJSz9a6OaGE686PBJ3251axVoHuWj3Mdp0QokMde86GG7w+9
        KBHCsop78v6lDYT6vCd9T02rGIvHJa1au3sHlEk=
X-Google-Smtp-Source: APXvYqz/YAfVVpOT1+gorX7uqK+xUCSw3KhSVS8Oct1H0bKTEnpnV/SUZnEVKAT3kOXN9vMIb+xvv7QaWE3Ovjg8g10=
X-Received: by 2002:a05:6830:8a:: with SMTP id a10mr69319291oto.167.1564743861921;
 Fri, 02 Aug 2019 04:04:21 -0700 (PDT)
MIME-Version: 1.0
References: <4323ed84dd07474eab65699b4d007aaf@AUSX13MPC105.AMER.DELL.COM>
 <CAJZ5v0iDQ4=kTUgW94tKGt7oJzA_3uVU_M6HAMbNCRXwp_do8A@mail.gmail.com>
 <47415939.KV5G6iaeJG@kreacher> <20190730144134.GA12844@localhost.localdomain>
 <100ba4aff1c6434a81e47774ab4acddc@AUSX13MPC105.AMER.DELL.COM>
 <8246360B-F7D9-42EB-94FC-82995A769E28@canonical.com> <20190730191934.GD13948@localhost.localdomain>
 <7d3e0b8ba1444194a153c93faa1cabb3@AUSX13MPC105.AMER.DELL.COM>
 <20190730213114.GK13948@localhost.localdomain> <CAJZ5v0gxfeMN8eCNRjcXmUOkReVsdozb3EccaYMpnmSHu3771g@mail.gmail.com>
 <20190731221956.GB15795@localhost.localdomain> <CAJZ5v0hxYGBXau39sb80MQ8jbZZCzH0JU2DYZvn9JOtYT2+30g@mail.gmail.com>
 <70D536BE-8DC7-4CA2-84A9-AFB067BA520E@canonical.com> <CAJZ5v0hFYEv_+vFkrxaCn_pNAbyqmO_cLb5GOLNn_xxRRwjh2g@mail.gmail.com>
 <38d4b4b107154454a932781acde0fa5a@AUSX13MPC105.AMER.DELL.COM>
 <CAJZ5v0jmO4FMOVYs62wkvPrUW81scD2H7cJyRc+tfoj+vODVbQ@mail.gmail.com> <43A8DF53-8463-4314-9E8E-47A7D3C5A709@canonical.com>
In-Reply-To: <43A8DF53-8463-4314-9E8E-47A7D3C5A709@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 2 Aug 2019 13:04:09 +0200
Message-ID: <CAJZ5v0ipG-MJjERBL9fjx29QktaYEKSmMCbWiEGPHsbF=Xfxtw@mail.gmail.com>
Subject: Re: [Regression] Commit "nvme/pci: Use host managed power state for
 suspend" has problems
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Keith Busch <kbusch@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Aug 2, 2019 at 12:55 PM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> at 06:26, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> > On Thu, Aug 1, 2019 at 9:05 PM <Mario.Limonciello@dell.com> wrote:
> >>> -----Original Message-----
> >>> From: Rafael J. Wysocki <rafael@kernel.org>
> >>> Sent: Thursday, August 1, 2019 12:30 PM
> >>> To: Kai-Heng Feng; Keith Busch; Limonciello, Mario
> >>> Cc: Keith Busch; Christoph Hellwig; Sagi Grimberg; linux-nvme; Linux
> >>> PM; Linux
> >>> Kernel Mailing List; Rajat Jain
> >>> Subject: Re: [Regression] Commit "nvme/pci: Use host managed power
> >>> state for
> >>> suspend" has problems
> >>>
> >>>
> >>> [EXTERNAL EMAIL]
> >>>
> >>> On Thu, Aug 1, 2019 at 11:06 AM Kai-Heng Feng
> >>> <kai.heng.feng@canonical.com> wrote:
> >>>> at 06:33, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >>>>
> >>>>> On Thu, Aug 1, 2019 at 12:22 AM Keith Busch <kbusch@kernel.org> wrote:
> >>>>>> On Wed, Jul 31, 2019 at 11:25:51PM +0200, Rafael J. Wysocki wrote:
> >>>>>>> A couple of remarks if you will.
> >>>>>>>
> >>>>>>> First, we don't know which case is the majority at this point.  For
> >>>>>>> now, there is one example of each, but it may very well turn out that
> >>>>>>> the SK Hynix BC501 above needs to be quirked.
> >>>>>>>
> >>>>>>> Second, the reference here really is 5.2, so if there are any systems
> >>>>>>> that are not better off with 5.3-rc than they were with 5.2, well, we
> >>>>>>> have not made progress.  However, if there are systems that are worse
> >>>>>>> off with 5.3, that's bad.  In the face of the latest findings the
> >>>>>>> only
> >>>>>>> way to avoid that is to be backwards compatible with 5.2 and that's
> >>>>>>> where my patch is going.  That cannot be achieved by quirking all
> >>>>>>> cases that are reported as "bad", because there still may be
> >>>>>>> unreported ones.
> >>>>>>
> >>>>>> I have to agree. I think your proposal may allow PCI D3cold,
> >>>>>
> >>>>> Yes, it may.
> >>>>
> >>>> Somehow the 9380 with Toshiba NVMe never hits SLP_S0 with or without
> >>>> Rafael’s patch.
> >>>> But the “real” s2idle power consumption does improve with the patch.
> >>>
> >>> Do you mean this patch:
> >>>
> >>> https://lore.kernel.org/linux-pm/70D536BE-8DC7-4CA2-84A9-
> >>> AFB067BA520E@canonical.com/T/#m456aa5c69973a3b68f2cdd4713a1ce83be5145
> >>> 8f
> >>>
> >>> or the $subject one without the above?
> >>>
> >>>> Can we use a DMI based quirk for this platform? It seems like a platform
> >>>> specific issue.
> >>>
> >>> We seem to see too many "platform-specific issues" here. :-)
> >>>
> >>> To me, the status quo (ie. what we have in 5.3-rc2) is not defensible.
> >>> Something needs to be done to improve the situation.
> >>
> >> Rafael, would it be possible to try popping out PC401 from the 9380 and
> >> into a 9360 to
> >> confirm there actually being a platform impact or not?
> >
> > Not really, sorry.
> >
> >> I was hoping to have something useful from Hynix by now before
> >> responding, but oh well.
> >>
> >> In terms of what is the majority, I do know that between folks at Dell,
> >> Google, Compal,
> >> Wistron, Canonical, Micron, Hynix, Toshiba, LiteOn, and Western Digital
> >> we tested a wide
> >> variety of SSDs with this patch series.  I would like to think that they
> >> are representative of
> >> what's being manufactured into machines now.
> >
> > Well, what about drives already in the field?  My concern is mostly
> > about those ones.
> >
> >> Notably the LiteOn CL1 was tested with the HMB flushing support and
> >> and Hynix PC401 was tested with older firmware though.
> >>
> >>>>>> In which case we do need to reintroduce the HMB handling.
> >>>>>
> >>>>> Right.
> >>>>
> >>>> The patch alone doesn’t break HMB Toshiba NVMe I tested. But I think
> >>>> it’s
> >>>> still safer to do proper HMB handling.
> >>>
> >>> Well, so can anyone please propose something specific?  Like an
> >>> alternative patch?
> >>
> >> This was proposed a few days ago:
> >> http://lists.infradead.org/pipermail/linux-nvme/2019-July/026056.html
> >>
> >> However we're still not sure why it is needed, and it will take some
> >> time to get
> >> a proper failure analysis from LiteOn  regarding the CL1.
> >
> > Thanks for the update, but IMO we still need to do something before
> > final 5.3 while the investigation continues.
> >
> > Honestly, at this point I would vote for going back to the 5.2
> > behavior at least by default and only running the new code on the
> > drives known to require it (because they will block PC10 otherwise).
> >
> > Possibly (ideally) with an option for users who can't get beyond PC3
> > to test whether or not the new code helps them.
>
> I just found out that the XPS 9380 at my hand never reaches SLP_S0 but only
> PC10.

That's the case for me too.

> This happens with or without putting the device to D3.

On my system, though, it only can get to PC3 without putting the NVMe
into D3 (as reported previously).
