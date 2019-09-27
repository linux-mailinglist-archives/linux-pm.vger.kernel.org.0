Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74CD4C0D99
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2019 23:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbfI0VsF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Sep 2019 17:48:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:55570 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725815AbfI0VsF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 27 Sep 2019 17:48:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 36BC2ADFE;
        Fri, 27 Sep 2019 21:48:02 +0000 (UTC)
From:   Thomas Renninger <trenn@suse.de>
To:     " Natarajan, Janakarajan " <Janakarajan.Natarajan@amd.com>
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
Date:   Fri, 27 Sep 2019 23:48:16 +0200
Message-ID: <4340017.MFpoU6RDpq@c100>
In-Reply-To: <9f94bb60-4be2-4303-54de-f50bdd7cb3e6@amd.com>
References: <20190918163445.129103-1-Janakarajan.Natarajan@amd.com> <9f94bb60-4be2-4303-54de-f50bdd7cb3e6@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Friday, September 27, 2019 6:07:56 PM CEST  Natarajan, Janakarajan  wrote:
> On 9/18/2019 11:34 AM, Natarajan, Janakarajan wrote:

> > This is advantageous because an IPI is not generated when a read_msr() is
> > executed on the local logical CPU thereby reducing the chance of having
> > APERF and MPERF being out of sync.
> > +	if (sched_setaffinity(getpid(), sizeof(set), &set) == -1) {
> > +		dprint("Could not migrate to cpu: %d\n", cpu);
> > +		return 1;

On a 80 core cpu the process would be pushed around through the
system quite a lot. 
This might affect what you are measuring or the other measure values?
Otherwise it's the kernel's MSR read only, not the whole cpupower process,
right? No idea about the exact overhead, though. Others in CC list should
know.

Afaik msr reads through msr module should be avoided anyway?
Those which are worth it are abstracted through sysfs nowadays?

For aperf/mperf it might make sense to define a sysfs file where you
can read both, as this is what you always need?

It would take a while, but could be a longterm solution which is also
usable in secure boot or without msr module case.

      Thomas



