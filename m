Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB02833370
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2019 17:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfFCPYc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Jun 2019 11:24:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:38970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726806AbfFCPYb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 3 Jun 2019 11:24:31 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F31827212;
        Mon,  3 Jun 2019 15:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559575470;
        bh=a3ZkqBR9ntiyTwcVktdqZT3z2YhgAzl95hFO2PmfLyY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=2uk8OK+RF7L77lIHwLQ/aOEgO0LH1vB3pqhLZz7u4gmHVKjpluOchGU2crqeR/Ci2
         rO1hbIP2NusUfgTXGU1QM0UhGJEtf/Kz42/qpzJ4ofnbGmTN96UPT8+gKQHpeU7T0Q
         /UwkAVzaR7i2Z5MY3hz6kfH2nVUlkKg9j3QwIeaU=
Date:   Mon, 3 Jun 2019 17:24:26 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
cc:     Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] x86/power: Fix 'nosmt' vs. hibernation triple fault
 during resume
In-Reply-To: <20190603142330.GA13384@linux.intel.com>
Message-ID: <nycvar.YFH.7.76.1906031722380.1962@cbobk.fhfr.pm>
References: <20190531051456.fzkvn62qlkf6wqra@treble> <nycvar.YFH.7.76.1905311045240.1962@cbobk.fhfr.pm> <5564116.e9OFvgDRbB@kreacher> <CALCETrUpseta+NrhVwzzVFTe-BkBHtDUJBO22ci3mAsVR+XOog@mail.gmail.com> <nycvar.YFH.7.76.1905311628330.1962@cbobk.fhfr.pm>
 <B7AC83ED-3F11-42B9-8506-C842A5937B50@amacapital.net> <nycvar.YFH.7.76.1905311651450.1962@cbobk.fhfr.pm> <CALCETrUQzZTRnvmOS09UvRM9UCGEDvSdbJtkeeEa2foMf+hF2w@mail.gmail.com> <nycvar.YFH.7.76.1905312251350.1962@cbobk.fhfr.pm> <98E57C7E-24E2-4EB8-A14E-FCA80316F812@amacapital.net>
 <20190603142330.GA13384@linux.intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 3 Jun 2019, Sean Christopherson wrote:

> For P6 and later, i.e. all modern CPUs, Intel processors go straight to
> halted state and don't fetch/decode the HLT instruction.

That'd be a rather relieving fact actually. Do you happen to know if this 
is stated in some Intel documentation and we've just overlooked it, or 
whether it's rather an information that's being carried over from 
generation to generation by whispering through grapevine?

Thanks,

-- 
Jiri Kosina
SUSE Labs

