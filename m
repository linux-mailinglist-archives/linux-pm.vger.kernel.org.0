Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E61FF90F8B
	for <lists+linux-pm@lfdr.de>; Sat, 17 Aug 2019 10:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbfHQIn3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 17 Aug 2019 04:43:29 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44116 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbfHQIn3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 17 Aug 2019 04:43:29 -0400
Received: from zn.tnic (p200300EC2F1E02002895015C0089AD52.dip0.t-ipconnect.de [IPv6:2003:ec:2f1e:200:2895:15c:89:ad52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F35FA1EC0586;
        Sat, 17 Aug 2019 10:43:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1566031408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Ffjx5moF1mWmOC52ipHNM0qufnLdVS38TkGLGqe1n6A=;
        b=NkHcNC28vgj6t6YfvF1uwIobFlzrwQuK4frQKMchRM+0negFx0yqnJHdMUYAXteNwONXiJ
        ka0oL0i9nkUlSzgGd0Y5bzfzczZVPKKU22T1t5U3ROOSOCRh6bzNFpBdSP3PoIvn9BySbF
        P4oU0NtTTL2LZQRHpXdGNzeKIUQhkGo=
Date:   Sat, 17 Aug 2019 10:44:10 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Chen Yu <yu.c.chen@intel.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] x86/CPU/AMD: Clear RDRAND CPUID bit on AMD family 15h/16h
Message-ID: <20190817084410.GA15364@zn.tnic>
References: <776cb5c2d33e7fd0d2893904724c0e52b394f24a.1565817448.git.thomas.lendacky@amd.com>
 <a24a2c7d-cfab-a049-37e8-7260a9063a7c@citrix.com>
 <20190815210547.GL15313@zn.tnic>
 <312b307b-19cc-84f8-97e6-07dbdf07dd12@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <312b307b-19cc-84f8-97e6-07dbdf07dd12@citrix.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 15, 2019 at 10:25:24PM +0100, Andrew Cooper wrote:
> I'm afraid that a number of hypervisors do write-discard, given the
> propensity of OSes (certainly traditionally) to go poking at bits like
> this without wrmsr_safe().
> 
> You either need to read the MSR back and observe that the bit has really
> changed, or in this case as Thomas suggests, look at CPUID again (which
> will likely be the faster option for the non-virtualised case).

One thing I didn't think of when we talked about this: this happens only
after you resume the hypervisor. And the words "resume the hypervisor"
already means an improbable use case. Yeah, yeah, one can close the
laptop lid of her/his F15h or F16h machine while guests are running and
when the HV resumes, those guests won't get randomness but I can't seem
to find it in myself to say, uuh, that's an important use case...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
