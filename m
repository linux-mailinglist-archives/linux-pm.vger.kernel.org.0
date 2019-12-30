Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 778A912D394
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2019 19:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfL3Swb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Dec 2019 13:52:31 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45638 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfL3Swb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Dec 2019 13:52:31 -0500
Received: by mail-ot1-f68.google.com with SMTP id 59so47303431otp.12
        for <linux-pm@vger.kernel.org>; Mon, 30 Dec 2019 10:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2PU80e06dVsLEFBPoBP15a3a0bqTWpgCtffJm4G5PGU=;
        b=bHZS9r+DC7xoeD6cxpH4i3xpSJ/gq50CwlupX1697alL9zoV2RniiOpeS0fzfamIQa
         WxQ7cCBNSANfXeX4NY4r/hZFK4P1w1JlyzXv9TnOkQRK0d1M4ZscNJljNFAQFM5GFlOM
         35xcjwPPMRp352B/JuDt4EKyWZZ4Uo+a1Db+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2PU80e06dVsLEFBPoBP15a3a0bqTWpgCtffJm4G5PGU=;
        b=d4N0MGxUZd5OyCjE8x9Z8jX5l+f564T4NcAAlKzLSvrJTeaaOrbuSRzQcWig1Zy4F3
         tdpUkf+Gb5Vlxmge3ZnCj5SW0OnHp/zB1Pv8cmXeTv1XDfM/AJRJNmvrB0yypexG4V+T
         0Ie78vMlfdKcmM+sKRczLwV4U0YhfJhfm/KnOnl4rj4WwxbdlTdNnfPBA2+WgGq0wA6H
         CAU2OaaZ+rXxpL4k9cqFZMEIq+M0QGt9AKdWp314MCiosulaScWJp9vL3hM703NiNCyX
         CIRlZ6YIQ7ErlcULkPM4yJ4nQEOEpHm6Jofg9nQNuUiyodriHB5AQGDit1uiYpuEPWjU
         rIOg==
X-Gm-Message-State: APjAAAVtcbNH/2vZ+9ZUziHBor6oEp8jq/9cxT+3Cb27gvnSTUC/FwCi
        qyPdc4898+gW12ZsppovWsN8Mw==
X-Google-Smtp-Source: APXvYqyRXCmINU65Y6yuKMiO/XiDPdUu64Vn+VoIxbx6ttD2OgkwUiThd7nh2RnWqHJyh6C1czL/mQ==
X-Received: by 2002:a9d:748d:: with SMTP id t13mr73212089otk.181.1577731950592;
        Mon, 30 Dec 2019 10:52:30 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r13sm13994800oic.52.2019.12.30.10.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 10:52:29 -0800 (PST)
Date:   Mon, 30 Dec 2019 10:52:28 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Garnier <thgarnie@chromium.org>,
        kernel-hardening@lists.openwall.com, kristen@linux.intel.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
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
Message-ID: <201912301052.16438D6@keescook>
References: <20191205000957.112719-1-thgarnie@chromium.org>
 <20191224130310.GE21017@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191224130310.GE21017@zn.tnic>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 24, 2019 at 02:03:10PM +0100, Borislav Petkov wrote:
> On Wed, Dec 04, 2019 at 04:09:37PM -0800, Thomas Garnier wrote:
> > Minor changes based on feedback and rebase from v9.
> > 
> > Splitting the previous serie in two. This part contains assembly code
> > changes required for PIE but without any direct dependencies with the
> > rest of the patchset.
> 
> Ok, modulo the minor commit message and comments fixup, this looks ok
> and passes testing here.
> 
> I'm going to queue patches 2-11 of the next version unless someone
> complains.

Great! Thanks very much for the reviews. :)

-- 
Kees Cook
