Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89C57CC9F8
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2019 14:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbfJEMkl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 5 Oct 2019 08:40:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:37808 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727322AbfJEMkl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 5 Oct 2019 08:40:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9A173AE40;
        Sat,  5 Oct 2019 12:40:39 +0000 (UTC)
From:   Thomas Renninger <trenn@suse.de>
To:     "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Pu Wen <puwen@hygon.com>, Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Renninger <trenn@suse.com>, Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH 1/2] Modify cpupower to schedule itself on cores it is reading MSRs from
Date:   Sat, 05 Oct 2019 14:40:57 +0200
Message-ID: <1798336.DyNOivuPDK@c100>
In-Reply-To: <64022abd-a798-c679-1c1d-eec9b18c4fb2@amd.com>
References: <20190918163445.129103-1-Janakarajan.Natarajan@amd.com> <4340017.MFpoU6RDpq@c100> <64022abd-a798-c679-1c1d-eec9b18c4fb2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Wednesday, October 2, 2019 4:45:03 PM CEST Natarajan, Janakarajan wrote:
> On 9/27/19 4:48 PM, Thomas Renninger wrote:
> 
> > On Friday, September 27, 2019 6:07:56 PM CEST  Natarajan, Janakarajan 
> > wrote:
> 
> >> On 9/18/2019 11:34 AM, Natarajan, Janakarajan wrote:
 
> On a 256 logical-cpu Rome system we see C0 value from cpupower output go 
> from 0.01 to ~(0.1 to 1.00)
> 
> for all cpus with the 1st patch.
> 
> However, this goes down to ~0.01 when we use the RDPRU instruction 
> (which can be used to get
> 
> APERF/MPERF from CPL > 0) and avoid using the msr module (patch 2).

And this one only exists on latest AMD cpus, right?

> However, for systems that provide an instruction  to get register values 
> from userspace, would a command-line parameter be acceptable?

Parameter sounds like a good idea. In fact, there already is such a paramter.
cpupower monitor --help
       -c
           Schedule  the  process  on every core before starting and ending 
measuring.  This could be needed for the Idle_Stats monitor when no other MSR 
based monitor (has to be run on the core that is measured) is run in parallel.  
This is to wake up the processors from deeper sleep states and let the kernel 
reaccount its cpuidle (C-state) information before reading the cpuidle timings 
from sysfs.

Best is you exchange the order of your patches. The 2nd looks rather straight
forward and you can add my reviewed-by.

If you still need adjustings with -c param, they can be discussed separately.
It would also be nice to mention in which case it makes sense to use it in the 
manpage or advantages/drawbacks if you don't.

Thanks!

    Thomas 



