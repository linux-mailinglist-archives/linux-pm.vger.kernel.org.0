Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA05835BB
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2019 17:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733251AbfHFPvc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Aug 2019 11:51:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58694 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732048AbfHFPvb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Aug 2019 11:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SncjWrmoRC5b495lasgofj0Rqb2mQTyyh5dUq+5um6c=; b=omsCdPaWcnXHcWz6QUOPsZ1pH
        m4nhZmOCV5hlYYIM86PIwoYv97n1noOSx61nqdD5Rvo9OhGQQJ+ZPRQzx7OSmkV0g38j23wJVV0Wu
        OA6nibDOjqa3aQAvytDJ1hR4rA9LfBGjXdSQASh7g9TEaQ8ZQXZk5SLvA35tGtSk8QSRL8vagnuRA
        grsvsDLfqhl+NiT+Dqly9Tn8qDyLmrA6YcWPBssLEypNK8woJHz1tPHv/fxvUgbTsilr6PrnL7CMY
        86FQfGDuo3nB2UVQvSwY6mHsHIHy7t5NB7g5s7yo2yQLb4vLc/RxZQGZgFdwDXYBYoVrN3i/SKjrc
        dsPnU77wA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hv1ji-0001tD-Q5; Tue, 06 Aug 2019 15:50:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 55E2F3077A6;
        Tue,  6 Aug 2019 17:50:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B8089201B3F8E; Tue,  6 Aug 2019 17:50:34 +0200 (CEST)
Date:   Tue, 6 Aug 2019 17:50:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Garnier <thgarnie@chromium.org>,
        kernel-hardening@lists.openwall.com, kristen@linux.intel.com,
        keescook@chromium.org, Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Nadav Amit <namit@vmware.com>, Jann Horn <jannh@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Maran Wilson <maran.wilson@oracle.com>,
        Enrico Weigelt <info@metux.net>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v9 00/11] x86: PIE support to extend KASLR randomization
Message-ID: <20190806155034.GP2349@hirez.programming.kicks-ass.net>
References: <20190730191303.206365-1-thgarnie@chromium.org>
 <20190806154347.GD25897@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806154347.GD25897@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 06, 2019 at 05:43:47PM +0200, Borislav Petkov wrote:
> On Tue, Jul 30, 2019 at 12:12:44PM -0700, Thomas Garnier wrote:
> > These patches make some of the changes necessary to build the kernel as
> > Position Independent Executable (PIE) on x86_64. Another patchset will
> > add the PIE option and larger architecture changes.
> 
> Yeah, about this: do we have a longer writeup about the actual benefits
> of all this and why we should take this all? After all, after looking
> at the first couple of asm patches, it is posing restrictions to how
> we deal with virtual addresses in asm (only RIP-relative addressing in
> 64-bit mode, MOVs with 64-bit immediates, etc, for example) and I'm
> willing to bet money that some future unrelated change will break PIE
> sooner or later.

Possibly objtool can help here; it should be possible to teach it about
these rules, and then it will yell when violated. That should avoid
regressions.

