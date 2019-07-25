Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37F8975890
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 22:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfGYUC5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jul 2019 16:02:57 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:44985 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfGYUC5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2019 16:02:57 -0400
Received: from 79.184.253.188.ipv4.supernova.orange.pl (79.184.253.188) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 94290446036ec225; Thu, 25 Jul 2019 22:02:55 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Keith Busch <kbusch@kernel.org>
Cc:     "Busch, Keith" <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Regression] Commit "nvme/pci: Use host managed power state for suspend" has problems
Date:   Thu, 25 Jul 2019 22:02:55 +0200
Message-ID: <15043168.halW6uqc8m@kreacher>
In-Reply-To: <20190725195258.GA7307@localhost.localdomain>
References: <2332799.izEFUvJP67@kreacher> <2428826.VBuqOhikiK@kreacher> <20190725195258.GA7307@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday, July 25, 2019 9:52:59 PM CEST Keith Busch wrote:
> On Thu, Jul 25, 2019 at 09:48:57PM +0200, Rafael J. Wysocki wrote:
> > NVME Identify Controller:
> > vid     : 0x1c5c
> > ssvid   : 0x1c5c
> > sn      : MS92N171312902J0N   
> > mn      : PC401 NVMe SK hynix 256GB               
> > fr      : 80007E00
> > rab     : 2
> > ieee    : ace42e
> > cmic    : 0
> > mdts    : 5
> > cntlid  : 1
> > ver     : 10200
> > rtd3r   : 7a120
> > rtd3e   : 1e8480
> > oaes    : 0x200
> > ctratt  : 0
> > oacs    : 0x17
> > acl     : 7
> > aerl    : 3
> > frmw    : 0x14
> > lpa     : 0x2
> > elpe    : 255
> > npss    : 4
> > avscc   : 0x1
> > apsta   : 0x1
> > wctemp  : 352
> > cctemp  : 354
> > mtfa    : 0
> > hmpre   : 0
> > hmmin   : 0
> > tnvmcap : 0
> > unvmcap : 0
> > rpmbs   : 0
> > edstt   : 10
> > dsto    : 0
> > fwug    : 0
> > kas     : 0
> > hctma   : 0
> > mntmt   : 0
> > mxtmt   : 0
> > sanicap : 0
> > hmminds : 0
> > hmmaxd  : 0
> > nsetidmax : 0
> > anatt   : 0
> > anacap  : 0
> > anagrpmax : 0
> > nanagrpid : 0
> > sqes    : 0x66
> > cqes    : 0x44
> > maxcmd  : 0
> > nn      : 1
> > oncs    : 0x1f
> > fuses   : 0x1
> > fna     : 0
> > vwc     : 0x1
> > awun    : 7
> > awupf   : 7
> > nvscc   : 1
> > acwu    : 7
> > sgls    : 0
> > mnan    : 0
> > subnqn  : 
> > ioccsz  : 0
> > iorcsz  : 0
> > icdoff  : 0
> > ctrattr : 0
> > msdbd   : 0
> > ps    0 : mp:6.00W operational enlat:5 exlat:5 rrt:0 rrl:0
> >           rwt:0 rwl:0 idle_power:- active_power:-
> > ps    1 : mp:3.80W operational enlat:30 exlat:30 rrt:1 rrl:1
> >           rwt:1 rwl:1 idle_power:- active_power:-
> > ps    2 : mp:2.40W operational enlat:100 exlat:100 rrt:2 rrl:2
> >           rwt:2 rwl:2 idle_power:- active_power:-
> > ps    3 : mp:0.0700W non-operational enlat:1000 exlat:1000 rrt:3 rrl:3
> >           rwt:3 rwl:3 idle_power:- active_power:-
> > ps    4 : mp:0.0070W non-operational enlat:1000 exlat:5000 rrt:3 rrl:3
> >           rwt:3 rwl:3 idle_power:- active_power:-
> 
> Hm, nothing stands out as something we can use to determine if we should
> skip the nvme specific settings or allow D3. I've no other ideas at the
> moment for what we may check.

Well, do ASPM settings matter here?



