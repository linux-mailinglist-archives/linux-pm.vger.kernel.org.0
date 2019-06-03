Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5AD633209
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2019 16:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbfFCOXc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Jun 2019 10:23:32 -0400
Received: from mga17.intel.com ([192.55.52.151]:31791 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727429AbfFCOXc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 3 Jun 2019 10:23:32 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jun 2019 07:23:32 -0700
X-ExtLoop1: 1
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.36])
  by fmsmga008.fm.intel.com with ESMTP; 03 Jun 2019 07:23:31 -0700
Date:   Mon, 3 Jun 2019 07:23:31 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Jiri Kosina <jikos@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] x86/power: Fix 'nosmt' vs. hibernation triple fault
 during resume
Message-ID: <20190603142330.GA13384@linux.intel.com>
References: <20190531051456.fzkvn62qlkf6wqra@treble>
 <nycvar.YFH.7.76.1905311045240.1962@cbobk.fhfr.pm>
 <5564116.e9OFvgDRbB@kreacher>
 <CALCETrUpseta+NrhVwzzVFTe-BkBHtDUJBO22ci3mAsVR+XOog@mail.gmail.com>
 <nycvar.YFH.7.76.1905311628330.1962@cbobk.fhfr.pm>
 <B7AC83ED-3F11-42B9-8506-C842A5937B50@amacapital.net>
 <nycvar.YFH.7.76.1905311651450.1962@cbobk.fhfr.pm>
 <CALCETrUQzZTRnvmOS09UvRM9UCGEDvSdbJtkeeEa2foMf+hF2w@mail.gmail.com>
 <nycvar.YFH.7.76.1905312251350.1962@cbobk.fhfr.pm>
 <98E57C7E-24E2-4EB8-A14E-FCA80316F812@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98E57C7E-24E2-4EB8-A14E-FCA80316F812@amacapital.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 31, 2019 at 02:22:27PM -0700, Andy Lutomirski wrote:
> 
> > On May 31, 2019, at 2:05 PM, Jiri Kosina <jikos@kernel.org> wrote:
> > 
> >> On Fri, 31 May 2019, Andy Lutomirski wrote:
> >> 
> >> The Intel SDM Vol 3 34.10 says:
> >> 
> >> If the HLT instruction is restarted, the processor will generate a
> >> memory access to fetch the HLT instruction (if it is
> >> not in the internal cache), and execute a HLT bus transaction. This
> >> behavior results in multiple HLT bus transactions
> >> for the same HLT instruction.
> > 
> > Which basically means that both hibernation and kexec have been broken in 
> > this respect for gazillions of years, and seems like noone noticed. Makes 
> > one wonder what the reason for that might be.
> > 
> > Either SDM is not precise and the refetch actually never happens for real 
> > (or is always in these cases satisfied from I$ perhaps?), or ... ?
> > 
> > So my patch basically puts things back where they have been for ages 
> > (while mwait is obviously much worse, as that gets woken up by the write 
> > to the monitored address, which inevitably does happen during resume), but 
> > seems like SDM is suggesting that we've been in a grey zone wrt RSM at 
> > least for all those ages.
> > 
> > So perhaps we really should ditch resume_play_dead() altogether 
> > eventually, and replace it with sending INIT IPI around instead (and then 
> > waking the CPUs properly via INIT INIT START). I'd still like to do that 
> > for 5.3 though, as that'd be slightly bigger surgery, and conservatively 
> > put things basically back to state they have been up to now for 5.2.
> > 
> 
> 
> Seems reasonable to me.  I would guess that it mostly works because SMI isn’t
> all that common and the window where it matters is short.  Or maybe the SDM
> is misleading.

For P6 and later, i.e. all modern CPUs, Intel processors go straight to
halted state and don't fetch/decode the HLT instruction.

P5 actually did a fetch, but from what I can tell that behavior wasn't
carried forward to KNC, unlike other legacy interrupt crud from P5:

[1] https://lkml.kernel.org/r/20190430004504.GH31379@linux.intel.com
