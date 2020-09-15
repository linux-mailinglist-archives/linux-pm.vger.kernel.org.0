Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4FED26B3FF
	for <lists+linux-pm@lfdr.de>; Wed, 16 Sep 2020 01:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbgIOXOK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Sep 2020 19:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbgIOXOF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2020 19:14:05 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B4CC06174A
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 16:14:04 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id r24so4311243ljm.3
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 16:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wWPdcIDLtJ7LpTWBvPoQIT2Pez3rTuG9TAsy2cgKb+Y=;
        b=iEej3Anqe1TNYnCY6SoQhzVoj12Efq+0iitVZNjRe2V/oX9dBXnrU98qiAJ3b21H/g
         IWJq8vgSBSY7hKLQlj3BK9Mm/ts0k0LqZfLyRETb5n9BtmFImcfTpg1LCgJdKcTaAI12
         uewZBlEwMfZmOln/dMAvC363Jbx58tb8z1YxE/CK0V3PFhlL7IsveAzeaXi6HK3M/Ypd
         nXL1ELIHGVZfXZYYbdHsUqlKYBe+ioWwAoMQLSlyWtIg/N0WeAj8KPDONE4s6NJLGXKe
         raGZUrQ5oCb0EQn3azO2I646Jt+q00ZUJddEPUj49y3BRNn3O3kBKNZ7DerdU62ddusk
         UUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wWPdcIDLtJ7LpTWBvPoQIT2Pez3rTuG9TAsy2cgKb+Y=;
        b=TwRmZRNHGlBjqcrUOrDSjW0L3XPtiVJL0jv6RI4nERy/8sDVCChTA6MD2n6L0YjiZE
         kUnM0mNTER6Tah5BuVsxGDfdOIs9bY+3iOuWLSnbyI22muZ8MqfoT5RLgAkKU/Ty4y3m
         avTau044cY26pgRec9xtoZqbe3G9GJZdMdo3b5/pf2Xq3OBRUtfuFOx61h0EWbt+5LdN
         PCb0i6gX8izid0SwXp7vzLSju/NRrXQXMiVy0v4vfwu1foiK4UyrR9ap4d4/Q0gX1Jrq
         NyiUebVTkKivqRVT9V0Dy0OI9QbUuh3mp6JNuO/FCPuHe+YLwoZ3/+BvHRIijEfgmrsL
         blWA==
X-Gm-Message-State: AOAM530NwDvmQrcPG/f+2TFTHm8dPUaZmhhDrT6MnTIA6JJX97l9vubs
        Xxpq//9bomXUnwr9E4/qnUSJELssAAsNk3elYjQF+A==
X-Google-Smtp-Source: ABdhPJzi/o1Jx5nWQj4o+xgdegJDJF+4QeqW+XOoEXI464R8qzRaFNN6XK2QZE9ROKxoXVt1JQNL/j0q+FBJInWY+Rg=
X-Received: by 2002:a05:651c:130b:: with SMTP id u11mr6921629lja.17.1600211642532;
 Tue, 15 Sep 2020 16:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200915172658.1432732-1-rkir@google.com> <20200915221708.GA26453@duo.ucw.cz>
In-Reply-To: <20200915221708.GA26453@duo.ucw.cz>
From:   Roman Kiryanov <rkir@google.com>
Date:   Tue, 15 Sep 2020 16:13:51 -0700
Message-ID: <CAOGAQeow_EU-vhtBSXofdmj7Ys-=HcCBEkQ8riySk2MosNQyxA@mail.gmail.com>
Subject: Re: [PATCH] arch: x86: power: cpu: init %gs before
 __restore_processor_state (clang)
To:     Pavel Machek <pavel@denx.de>
Cc:     rjw@rjwysocki.net, Thomas Gleixner <tglx@linutronix.de>,
        mingo@redhat.com, x86@kernel.org, linux-pm@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alistair Delva <adelva@google.com>,
        Haitao Shan <hshan@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 15, 2020 at 3:17 PM Pavel Machek <pavel@denx.de> wrote:
> > When load_TR_desc and load_mm_ldt are inlined into
> > fix_processor_context due to LTO, they cause
> > fix_processor_context (or in this case __restore_processor_state,
> > as fix_processor_context was inlined into __restore_processor_state)
> > to access the stack canary through %gs, but before
> > __restore_processor_state has restored the previous value
> > of %gs properly. LLVM appears to be inlining functions with stack
> > protectors into functions compiled with -fno-stack-protector,
> > which is likely a bug in LLVM's inliner that needs to be fixed.
>
> That's rather ugly.
>
> Would it be easier to simply mark those functions as noinline or
> something like that?

Hi Pavel, thank you for looking.

Let's put it another way. Is it correct to assume %gs will not be
ever used by the compiler for its internal business if stack protection
is disabled? If this assumption is correct we should just fix the
compiler.

Regards,
Roman.
