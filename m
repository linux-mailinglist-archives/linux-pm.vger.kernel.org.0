Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0488EF66
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2019 17:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730049AbfHOPeG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Aug 2019 11:34:06 -0400
Received: from mail.skyhub.de ([5.9.137.197]:43036 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728728AbfHOPeG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 15 Aug 2019 11:34:06 -0400
Received: from zn.tnic (p200300EC2F0B52001DDC45CCE62FC494.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:5200:1ddc:45cc:e62f:c494])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7627B1EC074B;
        Thu, 15 Aug 2019 17:34:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565883244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6ea0+0I7fYBanPI40B3Ad6TnGdmO71uK0qGfHM+0Bo4=;
        b=ixw2ad5rraIJ95A28jqAg/FczeVEcYhxQFEzLrDlcL+fFOZ9Gc1GDa6MUF2M8s0AdfC+Bz
        S77CYzbLrz7CLJC3Tv9lWuQRXOz97162qtRh/TmVGCmoYewt7C5uv5G64Zsn2XNbg6BB/R
        IDkIkwuGBgKSfBHUmJCbTXH/Ll8qt5s=
Date:   Thu, 15 Aug 2019 17:34:47 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Chen Yu <yu.c.chen@intel.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] x86/CPU/AMD: Clear RDRAND CPUID bit on AMD family 15h/16h
Message-ID: <20190815153447.GH15313@zn.tnic>
References: <776cb5c2d33e7fd0d2893904724c0e52b394f24a.1565817448.git.thomas.lendacky@amd.com>
 <20190815071940.GB15313@zn.tnic>
 <768aa720-1db1-81ca-4d0d-adf31f4d134b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <768aa720-1db1-81ca-4d0d-adf31f4d134b@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 15, 2019 at 01:47:24PM +0000, Lendacky, Thomas wrote:
> Sure, I can do that. Do we want to tie this into the nordrand option and
> add rdrand=off or keep that separate?

Yeah, I was looking at that this morning and I'd say keep 'em separate
because if you have to tie, you need to export functions and then
there's

	setup_clear_cpu_cap(X86_FEATURE_RDSEED);

in the nordrand callback but then F15h and F16h don't have RDSEED and
people would wonder, why clear RDSEED on AMD, blabla... so keeping them
separate saves us all that.

> I think this is a clearer indication that the action has taken place.

Yeah, but what does that bring us? You wanna know this now, while
testing. Once that whole effort is done, it is a useless printing of
info which you have in cpuinfo already.

> Not sure what you mean. We can't use the DMI stuff for this. So now, with
> the x86 family checks, if anyone adds some DMI stuff or x86 family stuff
> in the future that matches both the DMI and x86 family checks, this will
> be called more than once and so you need to copy any previous settings and
> add the new ones.

I had a suspicion that it was something like that. Ok, this is not a
big structure currently so I guess it is fine but if it keeps growing,
it would need a proper redesign like making it a list and callbacks
doing list_add_tail() for MSRs which get added. It would avoid that
kmalloc and copying which is silly. Please put a comment ontop why we're
copying.

> Except that X86_FEATURE_RDRAND isn't set anymore. I could create a new
> software feature that is set when the CPUID bit is cleared if that's
> preferred.

Nah, let's leave it like you had it.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
