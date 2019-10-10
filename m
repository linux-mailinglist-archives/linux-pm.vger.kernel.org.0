Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A498D27E0
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2019 13:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfJJLWZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Oct 2019 07:22:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:37464 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726201AbfJJLWY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 10 Oct 2019 07:22:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 19ED8AEA1;
        Thu, 10 Oct 2019 11:22:22 +0000 (UTC)
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
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH 1/2] Modify cpupower to schedule itself on cores it is reading MSRs from
Date:   Thu, 10 Oct 2019 13:22:21 +0200
Message-ID: <3292474.drSXM59XT9@skinner.arch.suse.de>
In-Reply-To: <f2dc183f-68a5-d98d-7758-bad224578737@amd.com>
References: <20190918163445.129103-1-Janakarajan.Natarajan@amd.com> <1798336.DyNOivuPDK@c100> <f2dc183f-68a5-d98d-7758-bad224578737@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday, October 7, 2019 11:11:30 PM CEST Natarajan, Janakarajan wrote:
> On 10/5/2019 7:40 AM, Thomas Renninger wrote:
> 
...
> >>
> >> APERF/MPERF from CPL > 0) and avoid using the msr module (patch 2).
> > 
> > And this one only exists on latest AMD cpus, right?
> 
> Yes. The RDPRU instruction exists only on AMD cpus.
> >
> >> However, for systems that provide an instruction  to get register values
> >> from userspace, would a command-line parameter be acceptable?
> > 
> > Parameter sounds like a good idea. In fact, there already is such a
> > paramter.
 cpupower monitor --help
> > 
> >         -c
> >         
> >             Schedule  the  process  on every core before starting and
> >             ending
> > 
> > measuring.  This could be needed for the Idle_Stats monitor when no other
> > MSR based monitor (has to be run on the core that is measured) is run in
> > parallel. This is to wake up the processors from deeper sleep states and
> > let the kernel reaccount its cpuidle (C-state) information before reading
> > the cpuidle timings from sysfs.
> >
> > Best is you exchange the order of your patches. The 2nd looks rather
> > straight forward and you can add my reviewed-by.
> 
> The RDPRU instruction reads the APERF/MPERF of the cpu on which it is 
> running. If we do not schedule it on each cpu specifically, it will read the APERF/MPERF
> of the cpu in which it runs/might happen to run on, which will not be the correct behavior.

Got it. And I also didn't fully read -c. I now remember.. For C-states accounting
you want to have each CPU woken up at measure start and end for accurate measuring.

It's a pity that the monitors do the per_cpu calls themselves.
So a general idle-monitor param is not possible or can only done by for example by
adding a flag to the cpuidle_monitor struct:

struct cpuidle_monitor

unsigned int needs_root:1
unsigned int per_cpu_schedule:1

not sure whether a:
struct {
  unsigned int needs_root:1
  unsigned int per_cpu_schedule:1
} flags

should/must be put around in a separate cleanup patch (and needs_root users adjusted).

You (and other monitors for which this might make sense) can then implement
the per_cpu_schedule flag. In AMD case you might want (you have to)
directly set it.

All around a -b/-u (--bind-measure-to-cpu, --unbind-measure-to-cpu)
parameter could be added at some point of time if it matters. And monitors
having this could bind or not.
This possibly could nuke out -c param. Or at least the idle state counter
monitor could do it itself. But don't mind about this.

What do you think?

And you should be able to re-use the bind_cpu function used in -c case?

       Thomas



