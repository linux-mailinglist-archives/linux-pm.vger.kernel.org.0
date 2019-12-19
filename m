Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAB81263A2
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 14:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfLSNf6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 08:35:58 -0500
Received: from merlin.infradead.org ([205.233.59.134]:46990 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfLSNf6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 08:35:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YSWZcOq3c4tDpa7LmbcYDgqZaDKNh9WKgBSxITrGWH0=; b=VMU3axBiD4FRvBTUAvat9++sh
        QduzMQrNMhpyhtVc5RAWKPuxaPWfFYkdKhazG/Ft7Rb2DcgDwcNM6GB1Y+LXthA2qM1qd2DA1S3Go
        pBDLF+l0FeQ8QKOt6JpebPmTPqCHKQVdfGynuJOJRihcWND6FmluJqXwRRlAxAJXBJtDpV7B3vIIQ
        HyjLGsUezYfLMMJT6ecEqBRXmLtrO3r6tw9kZGnggFfNCAPXD0vvnCbm/e2tWk2lwkSdLuHxAXKNC
        MzM0SeXj8f6KIEsepVLCK4CRpfDa490tRRci4kujDYCTdi9wAoiKDa4FtyDHyFb1Au2y4UcUyqPt5
        itF3fF1fw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihvxC-0000aR-0J; Thu, 19 Dec 2019 13:34:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B60D3304D00;
        Thu, 19 Dec 2019 14:33:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4501F2B3E168F; Thu, 19 Dec 2019 14:34:52 +0100 (CET)
Date:   Thu, 19 Dec 2019 14:34:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Garnier <thgarnie@chromium.org>
Cc:     kernel-hardening@lists.openwall.com, kristen@linux.intel.com,
        keescook@chromium.org, Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
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
Message-ID: <20191219133452.GM2827@hirez.programming.kicks-ass.net>
References: <20191205000957.112719-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

ISTR suggestion you add an objtool pass that verifies there are no
absolute text references left. Otherwise we'll forever be chasing that
last one..
