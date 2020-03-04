Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A19B178D4E
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2020 10:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725283AbgCDJWT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Mar 2020 04:22:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52224 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387644AbgCDJWT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Mar 2020 04:22:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Xz1gqS8mHQf0FeXfh5Zn6ODmAjqLlTi3e7QpQPXzA9Q=; b=LDG8TcPSz6KerDK5RXGKXHL0+s
        nd+daixZ03zWZPBsZex2W0SE2BU+bLdvHBFIbasjYsjLE9O6AcvIE4aklaE3c2rh36+IES5zOiJKo
        CZHk/ZIgcOCzatmD7F0LvmIA2106SZonTNmKrjs8DuOvT6kzu3GSWHE0zWKaxMKARsPaQGewBXixa
        ItobUKdK8g+0ymqN8mZ30rSgQf5HEI0PdCrTHBXpOW9woanZqUxWXgFDIr91oXYH//OaNr2XpNsGu
        Foq59USFJcUjcKrB2RUG0sl7wBvbaaaFVwnCCFfz9rz8IvgRMTSRUVdUbDAj+EcyeoS8xmPTFub7+
        KssVL8pg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9QDl-0008ML-Jr; Wed, 04 Mar 2020 09:21:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CDE6B30066E;
        Wed,  4 Mar 2020 10:19:37 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 407052011CA98; Wed,  4 Mar 2020 10:21:36 +0100 (CET)
Date:   Wed, 4 Mar 2020 10:21:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        Thomas Garnier <thgarnie@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "H. Peter Anvin" <hpa@zytor.com>,
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
        Allison Randal <allison@lohutok.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v11 00/11] x86: PIE support to extend KASLR randomization
Message-ID: <20200304092136.GI2596@hirez.programming.kicks-ass.net>
References: <20200228000105.165012-1-thgarnie@chromium.org>
 <202003022100.54CEEE60F@keescook>
 <20200303095514.GA2596@hirez.programming.kicks-ass.net>
 <CAJcbSZH1oON2VC2U8HjfC-6=M-xn5eU+JxHG2575iMpVoheKdA@mail.gmail.com>
 <6e7e4191612460ba96567c16b4171f2d2f91b296.camel@linux.intel.com>
 <202003031314.1AFFC0E@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202003031314.1AFFC0E@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 03, 2020 at 01:19:22PM -0800, Kees Cook wrote:
> On Tue, Mar 03, 2020 at 01:01:26PM -0800, Kristen Carlson Accardi wrote:
> > On Tue, 2020-03-03 at 07:43 -0800, Thomas Garnier wrote:
> > > On Tue, Mar 3, 2020 at 1:55 AM Peter Zijlstra <peterz@infradead.org>

> > > > But,... do we still need this in the light of that fine-grained
> > > > kaslr
> > > > stuff?
> > > > 
> > > > What is the actual value of this PIE crud in the face of that?
> > > 
> > > If I remember well, it makes it easier/better but I haven't seen a
> > > recent update on that. Is that accurate Kees?
> > 
> > I believe this patchset is valuable if people are trying to brute force
> > guess the kernel location, but not so awesome in the event of
> > infoleaks. In the case of the current fgkaslr implementation, we only
> > randomize within the existing text segment memory area - so with PIE
> > the text segment base can move around more, but within that it wouldn't
> > strengthen anything. So, if you have an infoleak, you learn the base
> > instantly, and are just left with the same extra protection you get
> > without PIE.
> 
> Right -- PIE improves both non- and fg- KASLR similarly, in the sense
> that the possible entropy for base offset is expanded. It also opens the
> door to doing even more crazy things. 

So I'm really confused. I see it increases the aslr range, but I'm still
not sure why we care in the face of fgkaslr. Current kaslr is completely
broken because the hardware leaks more bits than we currently have, even
without the kernel itself leaking an address.

But leaking a single address is not a problem with fgkaslr.

> (e.g. why keep the kernel text all
> in one contiguous chunk?)

Dear gawd, please no. Also, we're limited to 2G text, that's just not a
lot of room. I'm really going to object when people propose we introduce
direct PLT for x86.

> And generally speaking, it seems a nice improvement to me, as it gives
> the kernel greater addressing flexibility.

But at what cost; it does unspeakable ugly to the asm. And didn't a
kernel compiled with the extended PIE range produce a measurably slower
kernel due to all the ugly?

So maybe I'm slow, but please spell out the benefit, because I'm not
seeing it.
