Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82C8115FA4C
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2020 00:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgBNXVs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Feb 2020 18:21:48 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:54557 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbgBNXVs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Feb 2020 18:21:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1581722508; x=1613258508;
  h=date:from:to:subject:message-id:mime-version;
  bh=1fLOsGyjydnuCdMIlSr0tRhTDRsX7ZRCLdT+L++drvk=;
  b=HzGynpHx3sdhV0Bx1uOB8r4cgMQLaZJ4H9o0jHzwXvEKJw5spptBLxWR
   Zdl81tPVzPYAQ36aX1ntyL1Z9aLVCT0LhL6BVzeGdSJ26NpD0Thvui3kv
   5Y24jyo0nx7eofba97HYsbHCivVgOkf+XqMDRn0fpnfON7LcCLOXRMZJc
   E=;
IronPort-SDR: alGkphRrlsws2hadl8S9c/eZyCGO7Z01dk4t0uMbaNcrIZgDXf7iizySPNmo2aoN60Pt/CeZH3
 cqsJr0cy5oHg==
X-IronPort-AV: E=Sophos;i="5.70,442,1574121600"; 
   d="scan'208";a="17277260"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 14 Feb 2020 23:21:34 +0000
Received: from EX13MTAUEB002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com (Postfix) with ESMTPS id 455CEA0719;
        Fri, 14 Feb 2020 23:21:32 +0000 (UTC)
Received: from EX13D08UEB001.ant.amazon.com (10.43.60.245) by
 EX13MTAUEB002.ant.amazon.com (10.43.60.12) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 14 Feb 2020 23:21:20 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13D08UEB001.ant.amazon.com (10.43.60.245) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 14 Feb 2020 23:21:20 +0000
Received: from dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com
 (172.22.96.68) by mail-relay.amazon.com (10.43.60.234) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Fri, 14 Feb 2020 23:21:20 +0000
Received: by dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com (Postfix, from userid 4335130)
        id 003184028E; Fri, 14 Feb 2020 23:21:19 +0000 (UTC)
Date:   Fri, 14 Feb 2020 23:21:19 +0000
From:   Anchal Agarwal <anchalag@amazon.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>, <x86@kernel.org>, <boris.ostrovsky@oracle.com>,
        <jgross@suse.com>, <linux-pm@vger.kernel.org>,
        <linux-mm@kvack.org>, <kamatam@amazon.com>,
        <sstabellini@kernel.org>, <konrad.wilk@oracle.com>,
        <roger.pau@citrix.com>, <axboe@kernel.dk>, <davem@davemloft.net>,
        <rjw@rjwysocki.net>, <len.brown@intel.com>, <pavel@ucw.cz>,
        <peterz@infradead.org>, <eduval@amazon.com>, <sblbir@amazon.com>,
        <anchalag@amazon.com>, <xen-devel@lists.xenproject.org>,
        <vkuznets@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dwmw@amazon.co.uk>,
        <fllinden@amaozn.com>, <benh@kernel.crashing.org>
Subject: [RFC RESEND PATCH v3 00/12] Enable PM hibernation on guest VMs
Message-ID: <cover.1581721799.git.anchalag@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Resending this in a more threaded format.
  
Hello,
I am sending out a v3 version of series of patches that implements guest
PM hibernation.
These guests are running on xen hypervisor. The patches had been tested
against mainstream kernel. EC2 instance hibernation feature is provided
to the AWS EC2 customers. PM hibernation uses swap space carved out within
the guest[or can be a separate partition], where hibernation image is
stored and restored from.

Doing guest hibernation does not involve any support from hypervisor and
this way guest has complete control over its state. Infrastructure
restrictions for saving up guest state can be overcome by guest initiated
hibernation.

This series includes some improvements over RFC series sent last year:
https://lists.xenproject.org/archives/html/xen-devel/2018-06/msg00823.html

Changelog v3:
1. Feedback from V2
2. Introduced 2 new patches for xen sched clock offset fix
3. Fixed pirq shutdown/restore in generic irq subsystem
4. Split save/restore steal clock patches into 2 for better readability

Changelog v2:
1. Removed timeout/request present on the ring in xen-blkfront during blkfront freeze
2. Fixed restoring of PIRQs which was apparently working for 4.9 kernels but not for
newer kernel. [Legacy irqs were no longer restored after hibernation introduced with
this commit "020db9d3c1dc0"]
3. Merged couple of related patches to make the code more coherent and readable
4. Code refactoring
5. Sched clock fix when hibernating guest is under heavy CPU load
Note: Under very rare circumstances we see resume failures with KASLR enabled only
on xen instances.  We are roughly seeing 3% failures [>1000 runs] when testing with
various instance sizes and some workload running on each instance. I am currently
investigating the issue as to confirm if its a xen issue or kernel issue.
However, it should not hold back anyone from reviewing/accepting these patches.

Testing done:
All testing is done for multiple hibernation cycle for 5.4 kernel on EC2.

Testing How to:
---------------
Example:
Set up a file-backed swap space. Swap file size>=Total memory on the system
sudo dd if=/dev/zero of=/swap bs=$(( 1024 * 1024 )) count=4096 # 4096MiB
sudo chmod 600 /swap
sudo mkswap /swap
sudo swapon /swap

Update resume device/resume offset in grub if using swap file:
resume=/dev/xvda1 resume_offset=200704

Execute:
--------
sudo pm-hibernate
OR
echo disk > /sys/power/state && echo reboot > /sys/power/disk

Compute resume offset code:
"
#!/usr/bin/env python
import sys
import array
import fcntl

#swap file
f = open(sys.argv[1], 'r')
buf = array.array('L', [0])

#FIBMAP
ret = fcntl.ioctl(f.fileno(), 0x01, buf)
print buf[0]
"

Aleksei Besogonov (1):
  PM / hibernate: update the resume offset on SNAPSHOT_SET_SWAP_AREA

Anchal Agarwal (4):
  x86/xen: Introduce new function to map HYPERVISOR_shared_info on
    Resume
  genirq: Shutdown irq chips in suspend/resume during hibernation
  xen: Introduce wrapper for save/restore sched clock offset
  xen: Update sched clock offset to avoid system instability in
    hibernation

Munehisa Kamata (7):
  xen/manage: keep track of the on-going suspend mode
  xenbus: add freeze/thaw/restore callbacks support
  x86/xen: add system core suspend and resume callbacks
  xen-netfront: add callbacks for PM suspend and hibernation support
  xen-blkfront: add callbacks for PM suspend and hibernation
  xen/time: introduce xen_{save,restore}_steal_clock
  x86/xen: save and restore steal clock

 arch/x86/xen/enlighten_hvm.c      |   8 ++
 arch/x86/xen/suspend.c            |  72 ++++++++++++++++++
 arch/x86/xen/time.c               |  18 ++++-
 arch/x86/xen/xen-ops.h            |   3 +
 drivers/block/xen-blkfront.c      | 119 ++++++++++++++++++++++++++++--
 drivers/net/xen-netfront.c        |  98 +++++++++++++++++++++++-
 drivers/xen/events/events_base.c  |   1 +
 drivers/xen/manage.c              |  73 ++++++++++++++++++
 drivers/xen/time.c                |  29 +++++++-
 drivers/xen/xenbus/xenbus_probe.c |  99 ++++++++++++++++++++-----
 include/linux/irq.h               |   2 +
 include/xen/xen-ops.h             |   8 ++
 include/xen/xenbus.h              |   3 +
 kernel/irq/chip.c                 |   2 +-
 kernel/irq/internals.h            |   1 +
 kernel/irq/pm.c                   |  31 +++++---
 kernel/power/user.c               |   6 +-
 17 files changed, 533 insertions(+), 40 deletions(-)

-- 
2.24.1.AMZN

