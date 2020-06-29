Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6ED20E21D
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jun 2020 00:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731159AbgF2VCk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jun 2020 17:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731158AbgF2TMt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jun 2020 15:12:49 -0400
X-Greylist: delayed 347 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 29 Jun 2020 05:15:27 PDT
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [IPv6:2a00:da80:fff0:2::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C788C00E3F6;
        Mon, 29 Jun 2020 05:15:27 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 2FC371C0C89; Mon, 29 Jun 2020 14:09:39 +0200 (CEST)
Date:   Mon, 29 Jun 2020 14:09:38 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        rjw@rjwysocki.net, viresh.kumar@linaro.org, lenb@kernel.org,
        dsmythies@telus.net, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org, jic23@cam.ac.uk,
        keescook@chromium.org, akpm@linux-foundation.org
Subject: Re: [PATCH] lib: Extend kstrtobool() to accept "true"/"false"
Message-ID: <20200629120938.GC1319@bug>
References: <20200625224931.1468150-1-srinivas.pandruvada@linux.intel.com>
 <20200626084903.GA27151@zn.tnic>
 <20200626102255.GZ4817@hirez.programming.kicks-ass.net>
 <20200626104442.GF117543@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626104442.GF117543@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi!

> > > This is too lax - it will be enabled for any !0 value. Please accept
> > > only 0 and 1.
> > 
> > kstrtobool() ftw
> 
> And looking at that, I find it really strange it does not in fact accept
> "true" / "false", so how about this?
> 
> ---
> Subject: lib: Extend kstrtobool() to accept "true"/"false"
> 
> Extend the strings recognised by kstrtobool() to cover:
> 
>   - 1/0
>   - y/n
>   - yes/no	(new)
>   - t/f		(new)
>   - true/false  (new)
>   - on/off

Is it good idea to add more values there? It is easy to do, but... we don't want
people to use this by hand, and ideally everyone would just use 1/0...

I also see potential for confusion... as in echo off > enable_off_mode (ok, this is
with existing code, but...)

Plus, if programs learn to do "echo true > ..." they will stop working on older kernels.

Plus, this really should be documented somewhere, as it is kernel ABI.

IMO this does not need changing.

NAK.

Best regards,
									Pavel

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
