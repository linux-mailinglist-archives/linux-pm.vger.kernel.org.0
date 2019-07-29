Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D21579C2F
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 00:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbfG2WF4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 18:05:56 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:42969 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727946AbfG2WF4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jul 2019 18:05:56 -0400
Received: by mail-ot1-f43.google.com with SMTP id l15so64169739otn.9;
        Mon, 29 Jul 2019 15:05:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UEA32fU0I6ytXCKg3XtwmUrMebt1jpdSsOdRBgXgNeM=;
        b=r5YAnYae8I76jCmy1JBClemWy31leSvyCgowlDe6/etH3MB/HnJvKYCK6MW/sstlFi
         OVUgRNza+ZDCBcGcrfBG/fYkDuxSuCS5jWfvwyF6fB+IAtrftPaWI8doqoGxtEitV/pW
         bGmWQPr8YcCcI7/Z+N1uPofiWSMKjVUzb1jr0Ets8h5AYOYsfG711419ep5jHz11vXiq
         upqLSuXHNdZYDKHpLHBhSZIzWOsaTN/FytA8uz4N1x2ovQq0kDXoZ0EMi81SsEY6hn6t
         AiUaoFzpglNUKx8HhTC0NBL8oHyG0Qw7CTXfUZmpioHjI/Www/CE0SANjYO3TPcL997v
         9iig==
X-Gm-Message-State: APjAAAWoviUKCNDAlmo/A2JbVHrZlejhuUdPo5/4V1vCbecKxY/tN8+t
        MrAIcBnj5ip4hRC+4Lpc1iZcnVksZOk621vFgms=
X-Google-Smtp-Source: APXvYqy8Yk4N8UHHzj20KAMpPsb/zsAUKO3D/YBaq2Muo+H6UBXNUPih+VuLQB+hmRT5+c/N3COtIY7CD7gYCLOrrgg=
X-Received: by 2002:a05:6830:8a:: with SMTP id a10mr52930409oto.167.1564437954851;
 Mon, 29 Jul 2019 15:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <2332799.izEFUvJP67@kreacher> <2428826.VBuqOhikiK@kreacher>
 <20190725195258.GA7307@localhost.localdomain> <15043168.halW6uqc8m@kreacher>
 <D33632F4-E119-4833-816C-79084DA03DE4@canonical.com> <CAJZ5v0imsVS-eDB+Lmd5qzAfmb0UpJ5AwV_Vf+v8D21KAtqTOg@mail.gmail.com>
 <868a042a9422463fa1166653982bb985@AUSX13MPC105.AMER.DELL.COM>
In-Reply-To: <868a042a9422463fa1166653982bb985@AUSX13MPC105.AMER.DELL.COM>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 30 Jul 2019 00:05:43 +0200
Message-ID: <CAJZ5v0gibD_oboFt7x7VjUTe4mw+mZxHcOiFEEcWdw8dUZ5RXw@mail.gmail.com>
Subject: Re: [Regression] Commit "nvme/pci: Use host managed power state for
 suspend" has problems
To:     Mario Limonciello <Mario.Limonciello@dell.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Keith Busch <kbusch@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 29, 2019 at 5:53 PM <Mario.Limonciello@dell.com> wrote:
>
> > -----Original Message-----
> > From: Rafael J. Wysocki <rafael@kernel.org>
> > Sent: Saturday, July 27, 2019 7:55 AM
> > To: Kai-Heng Feng
> > Cc: Rafael J. Wysocki; Keith Busch; Busch, Keith; Christoph Hellwig; Sagi Grimberg;
> > linux-nvme@lists.infradead.org; Limonciello, Mario; Linux PM; LKML
> > Subject: Re: [Regression] Commit "nvme/pci: Use host managed power state for
> > suspend" has problems
> >
> >
> > [EXTERNAL EMAIL]
> >
> > On Fri, Jul 26, 2019 at 4:03 PM Kai-Heng Feng
> > <kai.heng.feng@canonical.com> wrote:
> > >
> > > at 04:02, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > > On Thursday, July 25, 2019 9:52:59 PM CEST Keith Busch wrote:
> > > >> On Thu, Jul 25, 2019 at 09:48:57PM +0200, Rafael J. Wysocki wrote:
> > > >>> NVME Identify Controller:
> > > >>> vid     : 0x1c5c
> > > >>> ssvid   : 0x1c5c
> > > >>> sn      : MS92N171312902J0N
> > > >>> mn      : PC401 NVMe SK hynix 256GB
> > > >>> fr      : 80007E00
> > > >>> rab     : 2
> > > >>> ieee    : ace42e
> > > >>> cmic    : 0
> > > >>> mdts    : 5
> > > >>> cntlid  : 1
> > > >>> ver     : 10200
> > > >>> rtd3r   : 7a120
> > > >>> rtd3e   : 1e8480
> > > >>> oaes    : 0x200
> > > >>> ctratt  : 0
> > > >>> oacs    : 0x17
> > > >>> acl     : 7
> > > >>> aerl    : 3
> > > >>> frmw    : 0x14
> > > >>> lpa     : 0x2
> > > >>> elpe    : 255
> > > >>> npss    : 4
> > > >>> avscc   : 0x1
> > > >>> apsta   : 0x1
> > > >>> wctemp  : 352
> > > >>> cctemp  : 354
> > > >>> mtfa    : 0
> > > >>> hmpre   : 0
> > > >>> hmmin   : 0
> > > >>> tnvmcap : 0
> > > >>> unvmcap : 0
> > > >>> rpmbs   : 0
> > > >>> edstt   : 10
> > > >>> dsto    : 0
> > > >>> fwug    : 0
> > > >>> kas     : 0
> > > >>> hctma   : 0
> > > >>> mntmt   : 0
> > > >>> mxtmt   : 0
> > > >>> sanicap : 0
> > > >>> hmminds : 0
> > > >>> hmmaxd  : 0
> > > >>> nsetidmax : 0
> > > >>> anatt   : 0
> > > >>> anacap  : 0
> > > >>> anagrpmax : 0
> > > >>> nanagrpid : 0
> > > >>> sqes    : 0x66
> > > >>> cqes    : 0x44
> > > >>> maxcmd  : 0
> > > >>> nn      : 1
> > > >>> oncs    : 0x1f
> > > >>> fuses   : 0x1
> > > >>> fna     : 0
> > > >>> vwc     : 0x1
> > > >>> awun    : 7
> > > >>> awupf   : 7
> > > >>> nvscc   : 1
> > > >>> acwu    : 7
> > > >>> sgls    : 0
> > > >>> mnan    : 0
> > > >>> subnqn  :
> > > >>> ioccsz  : 0
> > > >>> iorcsz  : 0
> > > >>> icdoff  : 0
> > > >>> ctrattr : 0
> > > >>> msdbd   : 0
> > > >>> ps    0 : mp:6.00W operational enlat:5 exlat:5 rrt:0 rrl:0
> > > >>>           rwt:0 rwl:0 idle_power:- active_power:-
> > > >>> ps    1 : mp:3.80W operational enlat:30 exlat:30 rrt:1 rrl:1
> > > >>>           rwt:1 rwl:1 idle_power:- active_power:-
> > > >>> ps    2 : mp:2.40W operational enlat:100 exlat:100 rrt:2 rrl:2
> > > >>>           rwt:2 rwl:2 idle_power:- active_power:-
> > > >>> ps    3 : mp:0.0700W non-operational enlat:1000 exlat:1000 rrt:3 rrl:3
> > > >>>           rwt:3 rwl:3 idle_power:- active_power:-
> > > >>> ps    4 : mp:0.0070W non-operational enlat:1000 exlat:5000 rrt:3 rrl:3
> > > >>>           rwt:3 rwl:3 idle_power:- active_power:-
> > > >>
> > > >> Hm, nothing stands out as something we can use to determine if we should
> > > >> skip the nvme specific settings or allow D3. I've no other ideas at the
> > > >> moment for what we may check.
> > > >
> > > > Well, do ASPM settings matter here?
> > >
> > > Seems like it's a regression in the firmware.
> > >
> > > The issue happens in version 80007E00 but not version 80006E00.
> >
> > So you mean the NVMe firmware, to be entirely precise.
>
> Yes.
>
> >
> > > I am not sure how to downgrade it under Linux though.
> >
> > Me neither.
>
> I'll ask the storage team to ask Hynix to make both these FW available on LVFS.
> Fwupd can upgrade and downgrade firmware when the binaries are made available.
>
> They could potentially be pulled directly out of the Windows executables too, but I don't
> know how to identify them myself.

Well, thanks, but I'm not quite convinced that the NVMe is the reason
why my 9380 cannot reach SLP_S0 and this is my production system, so
I'd rather not do NVMe firmware downgrade experiments on it. :-)



>
> >
> > > The firmware changelog [1] is very interesting:
> > > - Improves the performance of the solid-state drive (SSD) by distributing
> > > power into the SSD efficiently according to the power state of the system.
> > >
> > > [1]
> > >
> > https://www.dell.com/support/home/us/en/04/drivers/driversdetails?driverid=m
> > cxm8
> >
> > Huh.
> >
> > It looks like something else prevents the PCH on my 9380 from reaching
> > the right state for S0ix, though.  I still need to find out what it
> > is.
