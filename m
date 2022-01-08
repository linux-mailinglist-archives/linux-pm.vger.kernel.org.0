Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34744885CB
	for <lists+linux-pm@lfdr.de>; Sat,  8 Jan 2022 21:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbiAHUKp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 8 Jan 2022 15:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiAHUKp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 8 Jan 2022 15:10:45 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7356C06173F
        for <linux-pm@vger.kernel.org>; Sat,  8 Jan 2022 12:10:44 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 30so34715997edv.3
        for <linux-pm@vger.kernel.org>; Sat, 08 Jan 2022 12:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iD4a6uEwkGzhV9ZR3rAuaktGDkUY36sehuvaU03nU68=;
        b=J70dfVCkP/UVwSADaOG5pn4SSuDU7kItk7Cqr9eOGU9m+lL+cf5Qr2M0YZghxqCW2X
         rWU11Dg45fCALxmXodChTlsQ+/F/d2Ojhy0FXgXd2eBh4ASKNF14wrPxDJFpEKbkxpc0
         rNE49ua/InyqlBx/ml5LyWO1hbjLd7i4czvbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iD4a6uEwkGzhV9ZR3rAuaktGDkUY36sehuvaU03nU68=;
        b=F33IvwivQj8VBOJLQFzTU3PoU3UNewOrWDKUDA5s99HbNDLEG3FF/fKPG8ie+AGGW/
         DtFs86ghI8CbXUmGWljSg4yHGTWEhFjJFj37y6PyXiyUzR4YMzbcwI8qeXxYHC0hkYW7
         RZgDiE7hH+FZR5Pj9ucog91JMTd+z1hw+7KpN0omI87hbfWnB2hMFJhbk705eJmy8ofz
         8xLzpY/GX+8OODYz2B3ZR9UaflQpw7ZDEtFPpJOAL9+b9zYg6+XWBMC3rNaDFaIaaROZ
         1ylmRMW+5r18LFZh+zoDuQcbbS1Indx8f/dpH+qoKqFSpwwxHS2vXsZYXI40SRy1scJF
         hOmQ==
X-Gm-Message-State: AOAM531t1zm9cdQP/Mx2reTfTW6C/hXlEZ7ldX0RkyFbqvVkw30ygt+r
        41LtKso3oPSzPhGXy1cRxsZQ5zVhFHofi7/7
X-Google-Smtp-Source: ABdhPJz4xXyuWH0FF9PHu8fV0oG8to6ZS/PZrtsUWe4i4fTpGk29dc816MKIyCPym9eDOogg5pzXzw==
X-Received: by 2002:a05:6402:26c8:: with SMTP id x8mr69112781edd.149.1641672643055;
        Sat, 08 Jan 2022 12:10:43 -0800 (PST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id i9sm97932ejw.88.2022.01.08.12.10.42
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Jan 2022 12:10:42 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id q8so18233192wra.12
        for <linux-pm@vger.kernel.org>; Sat, 08 Jan 2022 12:10:42 -0800 (PST)
X-Received: by 2002:adf:eeca:: with SMTP id a10mr14312457wrp.274.1641672642052;
 Sat, 08 Jan 2022 12:10:42 -0800 (PST)
MIME-Version: 1.0
References: <20220108112229.v3d7enmuibypa5tm@earth.universe>
In-Reply-To: <20220108112229.v3d7enmuibypa5tm@earth.universe>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 8 Jan 2022 12:10:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh55h__rC6+RTH7pLLTbnBuuOXPNzGGswVDGN7C6NW1pQ@mail.gmail.com>
Message-ID: <CAHk-=wh55h__rC6+RTH7pLLTbnBuuOXPNzGGswVDGN7C6NW1pQ@mail.gmail.com>
Subject: Re: [GIT PULL] power-supply fixes for 5.16
To:     Sebastian Reichel <sre@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jan 8, 2022 at 3:22 AM Sebastian Reichel <sre@kernel.org> wrote:
>
> 2. Replace 1E6L with NSEC_PER_MSEC to avoid floating point calculation
>    in LLVM resulting in a build failure

So I think the patch is obviously the right thing to do regardless,
but that still makes me go "WTF?"

Those uses of 1E6L were perhaps strange, but they were only used in
constant compile-time expressions that were cast to 'unsigned long' in
the end, so how the heck did llvm end up with any floating point in
there?

In this case there was really no excuse not to just use a better
constant, but there are other situations where it might well be quite
reasonable to use floating point calculations to create an integer
constant (eg maybe some spec describes an algorithm in FP, but the
implementation uses fixed-point arithmetic and has initializers that
do the conversion).

Imagine for a moment that you want to do fixed-point math (perhaps
because you have a microcontroller without an FP unit - it's not
limited to just "the kernel doesn't do FP"). Further imagine just for
a moment that you still want some fundamental constants like PI in
that fixed-point format.

The sane way to generate said constants is to do something like

      #define FIXPT_1 (1u << FIXPT_SHIFT)
      #define FIXPT_FP(x) ((fixpt_t) (((x)*FIXPT_1)+0.5))
      #define FIXPT_PI FIXPT_FP(3.14159265)

rather than have to do something incredibly stupid and illogical and
unreadable like

    #define FIXPT_PI 205887

So honestly, this seems to be just llvm being completely stupid. The
fact that you don't want to generate floating point code has *NOTHING*
to do with floating point literals for constant expressions.

In fact, even if you don't want to generate floating point code -
again, maybe you don't have a FP unit - doesn't mean that you might
not want to generate normal floating point constants. You may end up
having explicit software floating point, and doing things like passing
the floating point values around manually, ie

        union fp {
            uint64_t val;
            double fp_val;
       };

and having code like

        static const union fp sqrt2 = { .fp_val = 1.4142.... };

and then doing all the math in 'uint64_t' just because you wrote a
couple of math routines yourself:

        fp_mul(&res,  sqrt2.val, x);

again, there's no floating point *code* generated, but that doesn't
mean that the compiler shouldn't allow users to use floating point
*values*.

Sadly, I see in the LLVM discussions that the llvm people seem to be
completely out to lunch and in denial, and claim "maybe this is a gcc
bug".

No. Gcc just isn't being stupid.

Nathan, Nick, please talk some sense into the llvm people. The two
examples above are very much not about the Linux kernel (although I
think we actually have a couple of places that do things exactly like
that) they are about generic coding issues.

              Linus
