Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5522334B8
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2019 18:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfFCQSS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Jun 2019 12:18:18 -0400
Received: from mga02.intel.com ([134.134.136.20]:31738 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbfFCQSS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 3 Jun 2019 12:18:18 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jun 2019 09:18:18 -0700
X-ExtLoop1: 1
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.36])
  by orsmga006.jf.intel.com with ESMTP; 03 Jun 2019 09:18:17 -0700
Date:   Mon, 3 Jun 2019 09:18:17 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
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
Message-ID: <20190603161817.GD13384@linux.intel.com>
References: <5564116.e9OFvgDRbB@kreacher>
 <CALCETrUpseta+NrhVwzzVFTe-BkBHtDUJBO22ci3mAsVR+XOog@mail.gmail.com>
 <nycvar.YFH.7.76.1905311628330.1962@cbobk.fhfr.pm>
 <B7AC83ED-3F11-42B9-8506-C842A5937B50@amacapital.net>
 <nycvar.YFH.7.76.1905311651450.1962@cbobk.fhfr.pm>
 <CALCETrUQzZTRnvmOS09UvRM9UCGEDvSdbJtkeeEa2foMf+hF2w@mail.gmail.com>
 <nycvar.YFH.7.76.1905312251350.1962@cbobk.fhfr.pm>
 <98E57C7E-24E2-4EB8-A14E-FCA80316F812@amacapital.net>
 <20190603142330.GA13384@linux.intel.com>
 <nycvar.YFH.7.76.1906031722380.1962@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1906031722380.1962@cbobk.fhfr.pm>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 03, 2019 at 05:24:26PM +0200, Jiri Kosina wrote:
> On Mon, 3 Jun 2019, Sean Christopherson wrote:
> 
> > For P6 and later, i.e. all modern CPUs, Intel processors go straight to
> > halted state and don't fetch/decode the HLT instruction.
> 
> That'd be a rather relieving fact actually. Do you happen to know if this 
> is stated in some Intel documentation and we've just overlooked it, or 
> whether it's rather an information that's being carried over from 
> generation to generation by whispering through grapevine?

I highly doubt it's officially stated anywhere.  Intel's approach to this
type of micro-architecture specific behavior is (usually) to word the SDM
in such a way that both approaches are legal.  E.g. a 1993 version of the
SDM says "Returns to interrupted HLT instruction", whereas in 1995, which
just so happens to coincide with the introduction of the P6 architecture,
the SDM started saying "Returns to HALT state" and added the blurb about
"will generate a memory access to fetch the HLT instruction (if it is not
in the internal cache)" so that the old behavior is still legal.

All that being said, the "straight to HALT" behavior is now the de facto
standard since lots of people will yell loudly if it changes.
