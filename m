Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4D6512A190
	for <lists+linux-pm@lfdr.de>; Tue, 24 Dec 2019 14:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfLXNDY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Dec 2019 08:03:24 -0500
Received: from mail.skyhub.de ([5.9.137.197]:35750 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbfLXNDX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 24 Dec 2019 08:03:23 -0500
Received: from zn.tnic (p200300EC2F0ED600C09669CD883F0A9D.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:d600:c096:69cd:883f:a9d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 395AF1EC0AE5;
        Tue, 24 Dec 2019 14:03:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1577192598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=RPmKXDdfeilER4Cgaeoi2HiLWA8B3GNUxDgJuxdBXfU=;
        b=reF83Q8gQU8d8BbbxQtuMbOFtz4tNW0TWem/vVoR96GaFFqKuP34eCfMKbkHGHhpKGdri3
        pyPpxWQoCT/9pskvQWyrWoFHiWRqJx3nXMkEvHac9OE4eXfjVFUgDyv9Abz9tEzv8ew26N
        WtLUvAmpJ1NPS+Gi5gUtfB2R8Ui/FNQ=
Date:   Tue, 24 Dec 2019 14:03:10 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Garnier <thgarnie@chromium.org>
Cc:     kernel-hardening@lists.openwall.com, kristen@linux.intel.com,
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
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v10 00/11] x86: PIE support to extend KASLR randomization
Message-ID: <20191224130310.GE21017@zn.tnic>
References: <20191205000957.112719-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191205000957.112719-1-thgarnie@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 04, 2019 at 04:09:37PM -0800, Thomas Garnier wrote:
> Minor changes based on feedback and rebase from v9.
> 
> Splitting the previous serie in two. This part contains assembly code
> changes required for PIE but without any direct dependencies with the
> rest of the patchset.

Ok, modulo the minor commit message and comments fixup, this looks ok
and passes testing here.

I'm going to queue patches 2-11 of the next version unless someone
complains.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
