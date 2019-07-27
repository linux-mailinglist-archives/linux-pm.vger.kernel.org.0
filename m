Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23170778CB
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2019 14:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387514AbfG0MzT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 27 Jul 2019 08:55:19 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:36120 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728431AbfG0MzT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 27 Jul 2019 08:55:19 -0400
Received: by mail-ot1-f48.google.com with SMTP id r6so58068477oti.3;
        Sat, 27 Jul 2019 05:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mYB+RjZcYLykoUihvv7WfT1+n77aCY+3wlgKPlvm/4U=;
        b=uClwzkIszIFQRkpjsjt2XbY2wNaLx1mYdvIRyBRK5BzE30eK8yZ+m6oS6+UoydfFP6
         H5Cd1jgtirUhLqJU07AKVrrXhGt0UDz6PGoMzoa6NBmYEmN0To1+wUQCuehqLiUpIdZ+
         2Iw4/Iw5NrnPi+/VbflSZa9nqWGaNjym6DXlcuLcP9iBnol2eLAbluBTeChF59+7bnZw
         WxsJn6eZF/HoKePN41fHg47ABu75y/e5AFgarjQZS+1UMNQxXwiFowcCPpcfPa89UHRM
         GccdWljEd7w9TZUYXsK99m8mmj3zq77vfqOMgYfeqJcDsENuKAWaRo5v/W1P1atoCKBZ
         2ipQ==
X-Gm-Message-State: APjAAAWX1gnnJ5Q2L1ZQWPHkMrQ1btMgNCOhI53nITPb89OWH0IszJ7B
        rlkrIrlO29Sd7T1ELN86lViHgbf9bD+8+wJAQQM=
X-Google-Smtp-Source: APXvYqyeCupN68o5IDANCONQioST/jWzm+ZCSqIdammMjKTD8zYEU4lf98oZYMw1Wj54n2rFP2reNc+PRrSsy2fUGXc=
X-Received: by 2002:a05:6830:1516:: with SMTP id k22mr68774265otp.189.1564232117536;
 Sat, 27 Jul 2019 05:55:17 -0700 (PDT)
MIME-Version: 1.0
References: <2332799.izEFUvJP67@kreacher> <2428826.VBuqOhikiK@kreacher>
 <20190725195258.GA7307@localhost.localdomain> <15043168.halW6uqc8m@kreacher> <D33632F4-E119-4833-816C-79084DA03DE4@canonical.com>
In-Reply-To: <D33632F4-E119-4833-816C-79084DA03DE4@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 27 Jul 2019 14:55:05 +0200
Message-ID: <CAJZ5v0imsVS-eDB+Lmd5qzAfmb0UpJ5AwV_Vf+v8D21KAtqTOg@mail.gmail.com>
Subject: Re: [Regression] Commit "nvme/pci: Use host managed power state for
 suspend" has problems
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Keith Busch <kbusch@kernel.org>,
        "Busch, Keith" <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 26, 2019 at 4:03 PM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> at 04:02, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> > On Thursday, July 25, 2019 9:52:59 PM CEST Keith Busch wrote:
> >> On Thu, Jul 25, 2019 at 09:48:57PM +0200, Rafael J. Wysocki wrote:
> >>> NVME Identify Controller:
> >>> vid     : 0x1c5c
> >>> ssvid   : 0x1c5c
> >>> sn      : MS92N171312902J0N
> >>> mn      : PC401 NVMe SK hynix 256GB
> >>> fr      : 80007E00
> >>> rab     : 2
> >>> ieee    : ace42e
> >>> cmic    : 0
> >>> mdts    : 5
> >>> cntlid  : 1
> >>> ver     : 10200
> >>> rtd3r   : 7a120
> >>> rtd3e   : 1e8480
> >>> oaes    : 0x200
> >>> ctratt  : 0
> >>> oacs    : 0x17
> >>> acl     : 7
> >>> aerl    : 3
> >>> frmw    : 0x14
> >>> lpa     : 0x2
> >>> elpe    : 255
> >>> npss    : 4
> >>> avscc   : 0x1
> >>> apsta   : 0x1
> >>> wctemp  : 352
> >>> cctemp  : 354
> >>> mtfa    : 0
> >>> hmpre   : 0
> >>> hmmin   : 0
> >>> tnvmcap : 0
> >>> unvmcap : 0
> >>> rpmbs   : 0
> >>> edstt   : 10
> >>> dsto    : 0
> >>> fwug    : 0
> >>> kas     : 0
> >>> hctma   : 0
> >>> mntmt   : 0
> >>> mxtmt   : 0
> >>> sanicap : 0
> >>> hmminds : 0
> >>> hmmaxd  : 0
> >>> nsetidmax : 0
> >>> anatt   : 0
> >>> anacap  : 0
> >>> anagrpmax : 0
> >>> nanagrpid : 0
> >>> sqes    : 0x66
> >>> cqes    : 0x44
> >>> maxcmd  : 0
> >>> nn      : 1
> >>> oncs    : 0x1f
> >>> fuses   : 0x1
> >>> fna     : 0
> >>> vwc     : 0x1
> >>> awun    : 7
> >>> awupf   : 7
> >>> nvscc   : 1
> >>> acwu    : 7
> >>> sgls    : 0
> >>> mnan    : 0
> >>> subnqn  :
> >>> ioccsz  : 0
> >>> iorcsz  : 0
> >>> icdoff  : 0
> >>> ctrattr : 0
> >>> msdbd   : 0
> >>> ps    0 : mp:6.00W operational enlat:5 exlat:5 rrt:0 rrl:0
> >>>           rwt:0 rwl:0 idle_power:- active_power:-
> >>> ps    1 : mp:3.80W operational enlat:30 exlat:30 rrt:1 rrl:1
> >>>           rwt:1 rwl:1 idle_power:- active_power:-
> >>> ps    2 : mp:2.40W operational enlat:100 exlat:100 rrt:2 rrl:2
> >>>           rwt:2 rwl:2 idle_power:- active_power:-
> >>> ps    3 : mp:0.0700W non-operational enlat:1000 exlat:1000 rrt:3 rrl:3
> >>>           rwt:3 rwl:3 idle_power:- active_power:-
> >>> ps    4 : mp:0.0070W non-operational enlat:1000 exlat:5000 rrt:3 rrl:3
> >>>           rwt:3 rwl:3 idle_power:- active_power:-
> >>
> >> Hm, nothing stands out as something we can use to determine if we should
> >> skip the nvme specific settings or allow D3. I've no other ideas at the
> >> moment for what we may check.
> >
> > Well, do ASPM settings matter here?
>
> Seems like it's a regression in the firmware.
>
> The issue happens in version 80007E00 but not version 80006E00.

So you mean the NVMe firmware, to be entirely precise.

> I am not sure how to downgrade it under Linux though.

Me neither.

> The firmware changelog [1] is very interesting:
> - Improves the performance of the solid-state drive (SSD) by distributing
> power into the SSD efficiently according to the power state of the system.
>
> [1]
> https://www.dell.com/support/home/us/en/04/drivers/driversdetails?driverid=mcxm8

Huh.

It looks like something else prevents the PCH on my 9380 from reaching
the right state for S0ix, though.  I still need to find out what it
is.
