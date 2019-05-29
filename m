Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB0F2E404
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2019 20:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbfE2SCw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 May 2019 14:02:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:49328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbfE2SCv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 May 2019 14:02:51 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5974524020;
        Wed, 29 May 2019 18:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559152971;
        bh=J1gLsjzvEkY7rS5KobvWe5qx+tH7eR2x9ewus4g2TrM=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=R1xa4dU9ejuliWV5FRLjxgbtuQU06pHSLaRZPEXd4lskPsDwwOR9WDmQRGwvqq973
         n2FcuNBKw1mcHtppG5SjMdyef8q89ki2X14a3EBhF6h7OelgF+uHUrsWoyuQ4xPvKA
         Knso4QgKfDFQL2eJB2p0xzHQCAMXLKr3VP3HD0ms=
Date:   Wed, 29 May 2019 20:02:47 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/power: Fix 'nosmt' vs. hibernation triple fault
 during resume
In-Reply-To: <nycvar.YFH.7.76.1905291921060.1962@cbobk.fhfr.pm>
Message-ID: <nycvar.YFH.7.76.1905292000310.1962@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1905282326360.1962@cbobk.fhfr.pm> <nycvar.YFH.7.76.1905291230130.1962@cbobk.fhfr.pm> <20190529161028.a6kpywzpjazgql5u@treble> <nycvar.YFH.7.76.1905291818470.1962@cbobk.fhfr.pm> <20190529171726.obom7xql72bgbjhc@treble>
 <nycvar.YFH.7.76.1905291921060.1962@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 29 May 2019, Jiri Kosina wrote:

> The target kernel only onlines the CPUs which were online at the time of 
> hibernation (and are therefore in frozen_cpus mask).

Hm, there is a catch though. After resume, the SMT siblings are now in hlt 
instead of mwait.

Which means that the resumed kernel has to do one more online/offline 
cycle for them, to push them to mwait again.

Bah.

I'll send v3 shortly, so please don't apply v2 just yet.

-- 
Jiri Kosina
SUSE Labs

