Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C89426ABD0
	for <lists+linux-pm@lfdr.de>; Tue, 15 Sep 2020 20:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgIOS1k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Sep 2020 14:27:40 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53664 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727903AbgIOS1h (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 15 Sep 2020 14:27:37 -0400
Received: from zn.tnic (p200300ec2f0e42009474dca2b756bdd4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:4200:9474:dca2:b756:bdd4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1E8A91EC0246;
        Tue, 15 Sep 2020 20:27:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600194452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0HOksYl7KYGb0/Z/aOYhjWUD/dWuDEx2ok3TnQFcapw=;
        b=GOkFdSk4VlXMHIJ+DBri4YMGuULYonokg+5IB9cp2PJrMzRazhKpCctRJGLsfqYm+xon6S
        wFMLm9SeTSoL9UTf3Tmofk1U1s5ERbMFYdE5q3zQvkxCV047mrq+IMV5ZJYROunEKmBiO3
        WsF/BDtlC4XOlMtOPeIunnfzYywUweE=
Date:   Tue, 15 Sep 2020 20:27:30 +0200
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
Message-ID: <20200915182730.GW14436@zn.tnic>
References: <20200915172658.1432732-1-rkir@google.com>
 <20200915174643.GT14436@zn.tnic>
 <CAOGAQepp_1QXrNAAXbLpW8qrujfdszfU2rMoh804wKK-Ja66Yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOGAQepp_1QXrNAAXbLpW8qrujfdszfU2rMoh804wKK-Ja66Yw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 15, 2020 at 10:57:16AM -0700, Roman Kiryanov wrote:
> I believe the kernel makes a questionable assumption on how clang
> uses registers (gs will not be used if stack protection is disabled).
> Both kernel and clang behaves unfortunate here.

If the kernel is at fault here and this same thing happens with GCC,
sure, but this is a clang-specific fix.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
