Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29C9B310A2
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2019 16:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfEaOyZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 May 2019 10:54:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbfEaOyZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 31 May 2019 10:54:25 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78D9326B11;
        Fri, 31 May 2019 14:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559314464;
        bh=ut6HGUXoVdKpKxWkBmLKfiQdl1KWbFSfImiaNPxTLes=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=dtMoYgEbe/Pum8dAabX3qtFT9mAjn3HZSFuHy0mwILYh9Ui1Y+W/JhgzAE4Nfq2ku
         YOvaYRm/5M9b6O9Is8whzrh2+SS0zwG6yLEfcalSeD/TRsG11SNpvMlN8vsuoAVFPZ
         g4pOv/CJ07M/7HJItd7xbthrqoy0BCAmv7KHlC7Q=
Date:   Fri, 31 May 2019 16:54:20 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Andy Lutomirski <luto@amacapital.net>
cc:     Andy Lutomirski <luto@kernel.org>,
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
In-Reply-To: <B7AC83ED-3F11-42B9-8506-C842A5937B50@amacapital.net>
Message-ID: <nycvar.YFH.7.76.1905311651450.1962@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1905282326360.1962@cbobk.fhfr.pm> <20190531051456.fzkvn62qlkf6wqra@treble> <nycvar.YFH.7.76.1905311045240.1962@cbobk.fhfr.pm> <5564116.e9OFvgDRbB@kreacher> <CALCETrUpseta+NrhVwzzVFTe-BkBHtDUJBO22ci3mAsVR+XOog@mail.gmail.com>
 <nycvar.YFH.7.76.1905311628330.1962@cbobk.fhfr.pm> <B7AC83ED-3F11-42B9-8506-C842A5937B50@amacapital.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 31 May 2019, Andy Lutomirski wrote:

> For that matter, what actually happens if we get an SMI while halted?  
> Does RSM go directly to sleep or does it re-fetch the HLT?

Our mails just crossed, I replied to Josh's mwait() proposal patch a 
minute ago.

HLT is guaranteed to be re-entered if SMM interrupted it, while MWAIT is 
not.

So as a short-term fix for 5.2, I still believe in v4 of my patch that 
does the mwait->hlt->mwait transition across hibernate/resume, and for 5.3 
I can look into forcing it to wait-for-SIPI proper.

-- 
Jiri Kosina
SUSE Labs

