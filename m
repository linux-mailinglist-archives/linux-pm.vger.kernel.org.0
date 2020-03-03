Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3F1417732C
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 10:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbgCCJ4T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Mar 2020 04:56:19 -0500
Received: from merlin.infradead.org ([205.233.59.134]:47656 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbgCCJ4T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2020 04:56:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xjAYzYZJidsTEHXSs//Oe4SJs+qAxcjB8dKxwUENenQ=; b=zrXbi+1XYsYg1hOUfgotstGR1s
        A/yiklisppTF0E9uRLa0vly9Whs1m5MF6QXAFqbz0RIOZTQ3IBkvmXEsEzAH7H4G/eUNCE9COhaKf
        Jt1sB06ShmrP6pL5etFIXieKzux9rI1PRF59uv6SLpF0G2BI2GBcdWRCspKTvO/2p1jLRtrNUi6Sh
        HA8kSw8UO5dmWtltons0CLJ0nXm+Y659s9TY0lr4a4KSUKIjb7SJaBWwJIkbCrpzdLCOQb8EEI+W+
        eVFHzpAPkRg2pOXnstpM7fhlRyhkazF7U53uvuy8CCxYkEUPSwaZ6iuVSdlA2OHKAJpd7ZHKu3O6I
        dRuWKx+w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j94Gm-0001E5-NN; Tue, 03 Mar 2020 09:55:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8918A30110E;
        Tue,  3 Mar 2020 10:53:16 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 780FD2119B2EB; Tue,  3 Mar 2020 10:55:14 +0100 (CET)
Date:   Tue, 3 Mar 2020 10:55:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Garnier <thgarnie@chromium.org>,
        kernel-hardening@lists.openwall.com, kristen@linux.intel.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
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
        Allison Randal <allison@lohutok.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v11 00/11] x86: PIE support to extend KASLR randomization
Message-ID: <20200303095514.GA2596@hirez.programming.kicks-ass.net>
References: <20200228000105.165012-1-thgarnie@chromium.org>
 <202003022100.54CEEE60F@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202003022100.54CEEE60F@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 02, 2020 at 09:02:15PM -0800, Kees Cook wrote:
> On Thu, Feb 27, 2020 at 04:00:45PM -0800, Thomas Garnier wrote:
> > Minor changes based on feedback and rebase from v10.
> > 
> > Splitting the previous serie in two. This part contains assembly code
> > changes required for PIE but without any direct dependencies with the
> > rest of the patchset.
> > 
> > Note: Using objtool to detect non-compliant PIE relocations is not yet
> > possible as this patchset only includes the simplest PIE changes.
> > Additional changes are needed in kvm, xen and percpu code.
> > 
> > Changes:
> >  - patch v11 (assembly);
> >    - Fix comments on x86/entry/64.
> >    - Remove KASLR PIE explanation on all commits.
> >    - Add note on objtool not being possible at this stage of the patchset.
> 
> This moves us closer to PIE in a clean first step. I think these patches
> look good to go, and unblock the work in kvm, xen, and percpu code. Can
> one of the x86 maintainers pick this series up?

But,... do we still need this in the light of that fine-grained kaslr
stuff?

What is the actual value of this PIE crud in the face of that?
