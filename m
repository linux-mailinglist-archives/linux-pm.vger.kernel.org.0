Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B49EF2E33F
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2019 19:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfE2R3y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 May 2019 13:29:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:33414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbfE2R3y (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 May 2019 13:29:54 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1821323F98;
        Wed, 29 May 2019 17:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559150994;
        bh=GjeXbG5a4/TCvqedsRpiu3Uwp6Fw3Us0T1y7WfWByvU=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=UF8RXpJDjkY3rMBsElIE5D9QiCUeq99CA5mfV96q7RfqwKoqR0GQ9Kdu5U7CEeXxh
         81NE9muFdMl2wt0cnXbVHV7cQTjKpfxGqOon9bggH/Lye5cIX3pwc1dQVVV59/RXWT
         sgQf0yEYeKB9fQ8ob2UXnlaDVz9vqXEZwI99yWbU=
Date:   Wed, 29 May 2019 19:29:49 +0200 (CEST)
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
In-Reply-To: <20190529171726.obom7xql72bgbjhc@treble>
Message-ID: <nycvar.YFH.7.76.1905291921060.1962@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1905282326360.1962@cbobk.fhfr.pm> <nycvar.YFH.7.76.1905291230130.1962@cbobk.fhfr.pm> <20190529161028.a6kpywzpjazgql5u@treble> <nycvar.YFH.7.76.1905291818470.1962@cbobk.fhfr.pm> <20190529171726.obom7xql72bgbjhc@treble>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 29 May 2019, Josh Poimboeuf wrote:

> I still have the question about whether we could make mwait_play_dead() 
> monitor a fixed address.  If we could get that to work, that seems more 
> robust to me.

Hmm, does it really?

That'd mean the resumer and resumee must have the same fixmap. How are you 
going to guarantee that? Currently the resuming kernel doesn't really have 
to be the same as the one that is being resumed.

> Another question.  With your patch, if booted with nosmt, is SMT still 
> disabled after you resume from hibernation?  

Yup, it is.

> I don't see how SMT would get disabled again.

The target kernel only onlines the CPUs which were online at the time of 
hibernation (and are therefore in frozen_cpus mask).

-- 
Jiri Kosina
SUSE Labs

