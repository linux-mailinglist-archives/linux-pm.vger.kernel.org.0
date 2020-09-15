Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0921026AC91
	for <lists+linux-pm@lfdr.de>; Tue, 15 Sep 2020 20:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbgIOSwY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Sep 2020 14:52:24 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57524 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727729AbgIOSwT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 15 Sep 2020 14:52:19 -0400
Received: from zn.tnic (p200300ec2f0e42009474dca2b756bdd4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:4200:9474:dca2:b756:bdd4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 460DC1EC00F4;
        Tue, 15 Sep 2020 20:52:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600195936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=cKYB52P8O6386b7hXIPyVtrVyn81imJhI74svwiZIl0=;
        b=RSy11l4ReWGZA+4hyM6z75EeGcglgNjRATmOcpgFHQ1ChMBtfSiIHPLtokKTom54+W5hku
        p70V3gwFqLNKIzTzQ+2Cw2mKOEtweNedhnnQBqdO7I0fJFwcyA37AzboylBtxT5yv2oBHE
        LpzQV6KsoU7oe/MSv05T1uwENZyROcA=
Date:   Tue, 15 Sep 2020 20:52:10 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Roman Kiryanov <rkir@google.com>
Cc:     rjw@rjwysocki.net, pavel@ucw.cz,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        x86@kernel.org, linux-pm@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alistair Delva <adelva@google.com>,
        Haitao Shan <hshan@google.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arch: x86: power: cpu: init %gs before
 __restore_processor_state (clang)
Message-ID: <20200915185210.GY14436@zn.tnic>
References: <20200915172658.1432732-1-rkir@google.com>
 <20200915174643.GT14436@zn.tnic>
 <CAOGAQepp_1QXrNAAXbLpW8qrujfdszfU2rMoh804wKK-Ja66Yw@mail.gmail.com>
 <20200915182730.GW14436@zn.tnic>
 <CAOGAQeqhKS48Kd8W4y13ATT3m+nJSksF_U1SJ=SBrOZFrDq9Nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOGAQeqhKS48Kd8W4y13ATT3m+nJSksF_U1SJ=SBrOZFrDq9Nw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 15, 2020 at 11:36:13AM -0700, Roman Kiryanov wrote:
> This is fair. Unfortunately I am not an x86 asm expert. I expect the proper
> fix should land into arch/x86/kernel/acpi/wakeup_64.S to init %gs
> (maybe some more registers) before "jmp restore_processor_state".

... because "LLVM appears to be inlining functions with stack protectors
into functions compiled with -fno-stack-protector" and now the *kernel*
needs to init %gs?

How about LLVM stops doing those wrong inlining decisions?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
