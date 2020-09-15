Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B454226ABC5
	for <lists+linux-pm@lfdr.de>; Tue, 15 Sep 2020 20:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgIOS0B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Sep 2020 14:26:01 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53334 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728022AbgIOSZw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 15 Sep 2020 14:25:52 -0400
Received: from zn.tnic (p200300ec2f0e42009474dca2b756bdd4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:4200:9474:dca2:b756:bdd4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4DAAF1EC0246;
        Tue, 15 Sep 2020 20:25:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600194337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0x/Qhri6rzs/dXcOby1rrn8kTnVB3dg9hCrfpRFNkv8=;
        b=MGAqa30IMQ/24P9kU6GiT/l/JTkOXbLonNO5nTnacrIUkJWbQPYBZlK7Cv36YxyqPIWdZO
        OgCvo+w8R2A7vhJk2bYSpa+pguM7gqmFkYLmhu3A+n5DM4kA752ui6+FvVeWzAbL4fyZkt
        qlAhEPtaty9TGDRJP/91+fuM7Un3rIA=
Date:   Tue, 15 Sep 2020 20:25:30 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Roman Kiryanov <rkir@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-pm@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Alistair Delva <adelva@google.com>,
        Haitao Shan <hshan@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] arch: x86: power: cpu: init %gs before
 __restore_processor_state (clang)
Message-ID: <20200915182530.GV14436@zn.tnic>
References: <20200915172658.1432732-1-rkir@google.com>
 <20200915174643.GT14436@zn.tnic>
 <CAKwvOdm9bQmL=gZypkosH0MG=S28=jJ6wZiTMCNP6=Z+NfN1AA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdm9bQmL=gZypkosH0MG=S28=jJ6wZiTMCNP6=Z+NfN1AA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 15, 2020 at 11:00:30AM -0700, Nick Desaulniers wrote:
> This is exactly the same code from __restore_processor_state. 

No, this patch is adding 

#ifdef __clang__

and I don't like the sprinkling around of those compiler-specific
workarounds which we have to carry forward forever or at least until
that compiler version is deprecated. We already carry fixes for broken
hardware, broken BIOSes, broken peripherals,... can you follow the
progression? :)

So your argument about testing unreleased compilers in the other thread
makes a lot of sense so that stuff like that can be fixed in time, and
in the compiler, where it belongs (that is, *if* it belongs there).

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
