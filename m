Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62A5E178DA4
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2020 10:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbgCDJl5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 4 Mar 2020 04:41:57 -0500
Received: from terminus.zytor.com ([198.137.202.136]:57959 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729126AbgCDJl5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 4 Mar 2020 04:41:57 -0500
Received: from [IPv6:2601:646:8600:3281:d841:929b:f37:3a31] ([IPv6:2601:646:8600:3281:d841:929b:f37:3a31])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 0249eM5n306088
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Wed, 4 Mar 2020 01:40:22 -0800
Authentication-Results: mail.zytor.com; dkim=permerror (bad message/signature format)
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-Id: <202003040940.0249eM5n306088@mail.zytor.com>
Date:   Wed, 04 Mar 2020 01:40:15 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <202003031314.1AFFC0E@keescook>
References: <20200228000105.165012-1-thgarnie@chromium.org> <202003022100.54CEEE60F@keescook> <20200303095514.GA2596@hirez.programming.kicks-ass.net> <CAJcbSZH1oON2VC2U8HjfC-6=M-xn5eU+JxHG2575iMpVoheKdA@mail.gmail.com> <6e7e4191612460ba96567c16b4171f2d2f91b296.camel@linux.intel.com> <202003031314.1AFFC0E@keescook>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v11 00/11] x86: PIE support to extend KASLR randomization
To:     Kees Cook <keescook@chromium.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>
CC:     Thomas Garnier <thgarnie@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Allison Randal <allison@lohutok.net>, Linux.Crypto@zytor.com
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Mailing List <linux-crypto@vger.kernel.org>,LKML <linux-kernel@vger.kernel.org>,virtualization@lists.linux-foundation.org,Linux PM list <linux-pm@vger.kernel.org>
From: hpa@zytor.com
Message-ID: <F35C8DBD-9AC3-46F2-9043-6CB9A4FDDDC9@zytor.com>

On March 3, 2020 1:19:22 PM PST, Kees Cook <keescook@chromium.org> wrote:
>On Tue, Mar 03, 2020 at 01:01:26PM -0800, Kristen Carlson Accardi
>wrote:
>> On Tue, 2020-03-03 at 07:43 -0800, Thomas Garnier wrote:
>> > On Tue, Mar 3, 2020 at 1:55 AM Peter Zijlstra
><peterz@infradead.org>
>> > wrote:
>> > > On Mon, Mar 02, 2020 at 09:02:15PM -0800, Kees Cook wrote:
>> > > > On Thu, Feb 27, 2020 at 04:00:45PM -0800, Thomas Garnier wrote:
>> > > > > Minor changes based on feedback and rebase from v10.
>> > > > > 
>> > > > > Splitting the previous serie in two. This part contains
>> > > > > assembly code
>> > > > > changes required for PIE but without any direct dependencies
>> > > > > with the
>> > > > > rest of the patchset.
>> > > > > 
>> > > > > Note: Using objtool to detect non-compliant PIE relocations
>is
>> > > > > not yet
>> > > > > possible as this patchset only includes the simplest PIE
>> > > > > changes.
>> > > > > Additional changes are needed in kvm, xen and percpu code.
>> > > > > 
>> > > > > Changes:
>> > > > >  - patch v11 (assembly);
>> > > > >    - Fix comments on x86/entry/64.
>> > > > >    - Remove KASLR PIE explanation on all commits.
>> > > > >    - Add note on objtool not being possible at this stage of
>> > > > > the patchset.
>> > > > 
>> > > > This moves us closer to PIE in a clean first step. I think
>these
>> > > > patches
>> > > > look good to go, and unblock the work in kvm, xen, and percpu
>> > > > code. Can
>> > > > one of the x86 maintainers pick this series up?
>> > > 
>> > > But,... do we still need this in the light of that fine-grained
>> > > kaslr
>> > > stuff?
>> > > 
>> > > What is the actual value of this PIE crud in the face of that?
>> > 
>> > If I remember well, it makes it easier/better but I haven't seen a
>> > recent update on that. Is that accurate Kees?
>> 
>> I believe this patchset is valuable if people are trying to brute
>force
>> guess the kernel location, but not so awesome in the event of
>> infoleaks. In the case of the current fgkaslr implementation, we only
>> randomize within the existing text segment memory area - so with PIE
>> the text segment base can move around more, but within that it
>wouldn't
>> strengthen anything. So, if you have an infoleak, you learn the base
>> instantly, and are just left with the same extra protection you get
>> without PIE.
>
>Right -- PIE improves both non- and fg- KASLR similarly, in the sense
>that the possible entropy for base offset is expanded. It also opens
>the
>door to doing even more crazy things. (e.g. why keep the kernel text
>all
>in one contiguous chunk?)
>
>And generally speaking, it seems a nice improvement to me, as it gives
>the kernel greater addressing flexibility.

The difference in entropy between fgkaslr and extending the kernel to the PIC memory model (which is the real thing this is doing) is immense:

The current kASLR has maybe 9 bits of entropy. PIC-model could extend that by at most 16 bits at considerable cost in performance and complexity. Fgkaslr would provide many kilobits worth of entropy; the limiting factor would be the random number source used! With a valid RNG, no two boots across all the computers in the world across all time would have an infinitesimal probability of ever being the same; never mind the infoleak issue.

In addition to the combinatorics, fgkaslr pushes randomization right as well as left, so even for the address of any one individual function you get a gain of 15-17 bits.

"More is better" is a truism, but so is Amdahl's Law.


-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
