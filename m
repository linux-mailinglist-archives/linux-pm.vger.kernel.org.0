Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8E3915FA99
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2020 00:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgBNX2G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Feb 2020 18:28:06 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:3453 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728093AbgBNX2G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Feb 2020 18:28:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1581722885; x=1613258885;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=r7lbs73sfsvJ86GyRkYhd6/aeNxAVZ1wrAJ3MEWq1QM=;
  b=jwuZcxirIEZ26bG1T0DW23l6tUIYdJZ02NsfadzjyuUp3hCnYVL0IdnP
   XXvnqQyk4TMmN/AbGrArBcqwHKIUO6v4my4d7H0gLcXUJ+iCffI+Uf2Mi
   /GYGXSxMqOJFFR3WBHBDEZQcVdtcyHNR0mpziRwpeLDxju/vkhTvGKQLM
   k=;
IronPort-SDR: X/XzvIor/0OFWv03EfXx440JHiYbVRPs0/IdGKwx33/R2EoMJmQ5ptVamF7pjfJBRu2Y5e+cqT
 EI7LVBBlt1ZA==
X-IronPort-AV: E=Sophos;i="5.70,442,1574121600"; 
   d="scan'208";a="16391307"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 14 Feb 2020 23:27:53 +0000
Received: from EX13MTAUWC001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com (Postfix) with ESMTPS id 2E0C8A28F8;
        Fri, 14 Feb 2020 23:27:46 +0000 (UTC)
Received: from EX13D05UWC001.ant.amazon.com (10.43.162.82) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 14 Feb 2020 23:27:29 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D05UWC001.ant.amazon.com (10.43.162.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 14 Feb 2020 23:27:29 +0000
Received: from dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com
 (172.22.96.68) by mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Fri, 14 Feb 2020 23:27:28 +0000
Received: by dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com (Postfix, from userid 4335130)
        id 214814028E; Fri, 14 Feb 2020 23:27:29 +0000 (UTC)
Date:   Fri, 14 Feb 2020 23:27:29 +0000
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
Subject: [RFC PATCH v3 11/12] xen: Update sched clock offset to avoid system
 instability in hibernation
Message-ID: <feefc88bca88e910c2860f6fbcb85097c6528cc7.1581721799.git.anchalag@amazon.com>
References: <cover.1581721799.git.anchalag@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1581721799.git.anchalag@amazon.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Save/restore xen_sched_clock_offset in syscore suspend/resume during PM
hibernation. Commit '867cefb4cb1012: ("xen: Fix x86 sched_clock() interface
for xen")' fixes xen guest time handling during migration. A similar issue
is seen during PM hibernation when system runs CPU intensive workload.
Post resume pvclock resets the value to 0 however, xen sched_clock_offset
is never updated. System instability is seen during resume from hibernation
when system is under heavy CPU load. Since xen_sched_clock_offset is not
updated, system does not see the monotonic clock value and the scheduler
would then think that heavy CPU hog tasks need more time in CPU, causing
the system to freeze

Signed-off-by: Anchal Agarwal <anchalag@amazon.com>
---
 arch/x86/xen/suspend.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/xen/suspend.c b/arch/x86/xen/suspend.c
index dae0f74f5390..7e5275944810 100644
--- a/arch/x86/xen/suspend.c
+++ b/arch/x86/xen/suspend.c
@@ -105,6 +105,8 @@ static int xen_syscore_suspend(void)
 		xen_save_steal_clock(cpu);
 	}
 
+	xen_save_sched_clock_offset();
+
 	xrfp.domid = DOMID_SELF;
 	xrfp.gpfn = __pa(HYPERVISOR_shared_info) >> PAGE_SHIFT;
 
@@ -126,6 +128,12 @@ static void xen_syscore_resume(void)
 
 	pvclock_resume();
 
+	/*
+	 * Restore xen_sched_clock_offset during resume to maintain
+	 * monotonic clock value
+	 */
+	xen_restore_sched_clock_offset();
+
 	/* Nonboot CPUs will be resumed when they're brought up */
 	xen_restore_steal_clock(smp_processor_id());
 
-- 
2.24.1.AMZN

