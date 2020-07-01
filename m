Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A406C21021C
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jul 2020 04:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgGACi1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jun 2020 22:38:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:38050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbgGACi0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 30 Jun 2020 22:38:26 -0400
Received: from X1 (071-093-078-081.res.spectrum.com [71.93.78.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31E6820760;
        Wed,  1 Jul 2020 02:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593571106;
        bh=GEiK1+77q24k/sE1oRjHZdAvnTTQIOOBJWufGVZhzQg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W36DHd6R59I88/gLgygiLVE68Q0pfkS/2UV5+MLwHe/e+soIC1UPzFHyHgjiSPB7T
         zUqosIuwj/1k4LSklHxu5uB/HLfTJXHnW0xNEowQNdtbihTrKutpf5AA0MYVdHQ+T2
         ypr9O3aYlcu+sOAo32JvQ6C59aG5ajCYuIWOIMQM=
Date:   Tue, 30 Jun 2020 19:38:23 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        rjw@rjwysocki.net, viresh.kumar@linaro.org, lenb@kernel.org,
        dsmythies@telus.net, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org, jic23@cam.ac.uk,
        keescook@chromium.org
Subject: Re: [PATCH] lib: Extend kstrtobool() to accept "true"/"false"
Message-Id: <20200630193823.62573c0142ddda1f2bf92cf3@linux-foundation.org>
In-Reply-To: <20200629120938.GC1319@bug>
References: <20200625224931.1468150-1-srinivas.pandruvada@linux.intel.com>
        <20200626084903.GA27151@zn.tnic>
        <20200626102255.GZ4817@hirez.programming.kicks-ass.net>
        <20200626104442.GF117543@hirez.programming.kicks-ass.net>
        <20200629120938.GC1319@bug>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 29 Jun 2020 14:09:38 +0200 Pavel Machek <pavel@ucw.cz> wrote:

> > Extend the strings recognised by kstrtobool() to cover:
> > 
> >   - 1/0
> >   - y/n
> >   - yes/no	(new)
> >   - t/f		(new)
> >   - true/false  (new)
> >   - on/off
> 
> Is it good idea to add more values there? It is easy to do, but... we don't want
> people to use this by hand, and ideally everyone would just use 1/0...
> 
> I also see potential for confusion... as in echo off > enable_off_mode (ok, this is
> with existing code, but...)
> 
> Plus, if programs learn to do "echo true > ..." they will stop working on older kernels.

I'm inclined to agree with this, It is indeed an invitation to write
non-back-compatible userspace and it simply makes the kernel interface
more complex.

