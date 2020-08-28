Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F48256072
	for <lists+linux-pm@lfdr.de>; Fri, 28 Aug 2020 20:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgH1S04 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Aug 2020 14:26:56 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:42402 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbgH1S0z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Aug 2020 14:26:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1598639213; x=1630175213;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=YlXbxw/O9okB0AahvRarA2ldWVFp/ZEo5xO3UByBIcM=;
  b=vOYlFM74MDWVojXBzRaAMsJzXq8viV8GqMjP0GfSqwMQMt4Fsfu5kvyT
   G4sNkn34osHmRQs+u3Djc0Htnh6k60rMHAm4muSyEzGIlN4hNGEhLxAhY
   kjn9nd05R5GyC930LiAs1X2uBI4klZenva+N97hQWye2cK4O0JZOlAish
   M=;
X-IronPort-AV: E=Sophos;i="5.76,364,1592870400"; 
   d="scan'208";a="50648672"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-c6afef2e.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 28 Aug 2020 18:26:50 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-c6afef2e.us-west-2.amazon.com (Postfix) with ESMTPS id C3D3AA2536;
        Fri, 28 Aug 2020 18:26:48 +0000 (UTC)
Received: from EX13D10UWA003.ant.amazon.com (10.43.160.248) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 28 Aug 2020 18:26:40 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D10UWA003.ant.amazon.com (10.43.160.248) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 28 Aug 2020 18:26:40 +0000
Received: from dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com
 (172.22.96.68) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Fri, 28 Aug 2020 18:26:39 +0000
Received: by dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com (Postfix, from userid 4335130)
        id 2E14F4087C; Fri, 28 Aug 2020 18:26:40 +0000 (UTC)
Date:   Fri, 28 Aug 2020 18:26:40 +0000
From:   Anchal Agarwal <anchalag@amazon.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>, <x86@kernel.org>, <boris.ostrovsky@oracle.com>,
        <jgross@suse.com>, <linux-pm@vger.kernel.org>,
        <linux-mm@kvack.org>, <kamatam@amazon.com>,
        <sstabellini@kernel.org>, <konrad.wilk@oracle.com>,
        <roger.pau@citrix.com>, <axboe@kernel.dk>, <davem@davemloft.net>,
        <rjw@rjwysocki.net>, <len.brown@intel.com>, <pavel@ucw.cz>,
        <peterz@infradead.org>, <eduval@amazon.com>, <sblbir@amazon.com>,
        <xen-devel@lists.xenproject.org>, <vkuznets@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>
Subject: Re: [PATCH v3 00/11] Fix PM hibernation in Xen guests
Message-ID: <20200828182640.GA20719@dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com>
References: <cover.1598042152.git.anchalag@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1598042152.git.anchalag@amazon.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Aug 21, 2020 at 10:22:43PM +0000, Anchal Agarwal wrote:
> Hello,
> This series fixes PM hibernation for hvm guests running on xen hypervisor.
> The running guest could now be hibernated and resumed successfully at a
> later time. The fixes for PM hibernation are added to block and
> network device drivers i.e xen-blkfront and xen-netfront. Any other driver
> that needs to add S4 support if not already, can follow same method of
> introducing freeze/thaw/restore callbacks.
> The patches had been tested against upstream kernel and xen4.11. Large
> scale testing is also done on Xen based Amazon EC2 instances. All this testing
> involved running memory exhausting workload in the background.
>   
> Doing guest hibernation does not involve any support from hypervisor and
> this way guest has complete control over its state. Infrastructure
> restrictions for saving up guest state can be overcome by guest initiated
> hibernation.
>   
> These patches were send out as RFC before and all the feedback had been
> incorporated in the patches. The last v1 & v2 could be found here:
>   
> [v1]: https://lkml.org/lkml/2020/5/19/1312
> [v2]: https://lkml.org/lkml/2020/7/2/995
> All comments and feedback from v2 had been incorporated in v3 series.
> 
> Known issues:
> 1.KASLR causes intermittent hibernation failures. VM fails to resumes and
> has to be restarted. I will investigate this issue separately and shouldn't
> be a blocker for this patch series.
> 2. During hibernation, I observed sometimes that freezing of tasks fails due
> to busy XFS workqueuei[xfs-cil/xfs-sync]. This is also intermittent may be 1
> out of 200 runs and hibernation is aborted in this case. Re-trying hibernation
> may work. Also, this is a known issue with hibernation and some
> filesystems like XFS has been discussed by the community for years with not an
> effectve resolution at this point.
> 
> Testing How to:
> ---------------
> 1. Setup xen hypervisor on a physical machine[ I used Ubuntu 16.04 +upstream
> xen-4.11]
> 2. Bring up a HVM guest w/t kernel compiled with hibernation patches
> [I used ubuntu18.04 netboot bionic images and also Amazon Linux on-prem images].
> 3. Create a swap file size=RAM size
> 4. Update grub parameters and reboot
> 5. Trigger pm-hibernation from within the VM
> 
> Example:
> Set up a file-backed swap space. Swap file size>=Total memory on the system
> sudo dd if=/dev/zero of=/swap bs=$(( 1024 * 1024 )) count=4096 # 4096MiB
> sudo chmod 600 /swap
> sudo mkswap /swap
> sudo swapon /swap
> 
> Update resume device/resume offset in grub if using swap file:
> resume=/dev/xvda1 resume_offset=200704 no_console_suspend=1
> 
> Execute:
> --------
> sudo pm-hibernate
> OR
> echo disk > /sys/power/state && echo reboot > /sys/power/disk
> 
> Compute resume offset code:
> "
> #!/usr/bin/env python
> import sys
> import array
> import fcntl
> 
> #swap file
> f = open(sys.argv[1], 'r')
> buf = array.array('L', [0])
> 
> #FIBMAP
> ret = fcntl.ioctl(f.fileno(), 0x01, buf)
> print buf[0]
> "
> 
> Aleksei Besogonov (1):
>   PM / hibernate: update the resume offset on SNAPSHOT_SET_SWAP_AREA
> 
> Anchal Agarwal (4):
>   x86/xen: Introduce new function to map HYPERVISOR_shared_info on
>     Resume
>   x86/xen: save and restore steal clock during PM hibernation
>   xen: Introduce wrapper for save/restore sched clock offset
>   xen: Update sched clock offset to avoid system instability in
>     hibernation
> 
> Munehisa Kamata (5):
>   xen/manage: keep track of the on-going suspend mode
>   xenbus: add freeze/thaw/restore callbacks support
>   x86/xen: add system core suspend and resume callbacks
>   xen-blkfront: add callbacks for PM suspend and hibernation
>   xen-netfront: add callbacks for PM suspend and hibernation
> 
> Thomas Gleixner (1):
>   genirq: Shutdown irq chips in suspend/resume during hibernation
> 
>  arch/x86/xen/enlighten_hvm.c      |   7 +++
>  arch/x86/xen/suspend.c            |  63 ++++++++++++++++++++
>  arch/x86/xen/time.c               |  15 ++++-
>  arch/x86/xen/xen-ops.h            |   3 +
>  drivers/block/xen-blkfront.c      | 122 ++++++++++++++++++++++++++++++++++++--
>  drivers/net/xen-netfront.c        |  96 +++++++++++++++++++++++++++++-
>  drivers/xen/events/events_base.c  |   1 +
>  drivers/xen/manage.c              |  46 ++++++++++++++
>  drivers/xen/xenbus/xenbus_probe.c |  96 +++++++++++++++++++++++++-----
>  include/linux/irq.h               |   2 +
>  include/xen/xen-ops.h             |   3 +
>  include/xen/xenbus.h              |   3 +
>  kernel/irq/chip.c                 |   2 +-
>  kernel/irq/internals.h            |   1 +
>  kernel/irq/pm.c                   |  31 +++++++---
>  kernel/power/user.c               |   7 ++-
>  16 files changed, 464 insertions(+), 34 deletions(-)
> 
> -- 
> 2.16.6
>
A gentle ping on the series in case there is any more feedback or can we plan to
merge this? I can then send the series with minor fixes pointed by tglx@

Thanks,
Anchal
