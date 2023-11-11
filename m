Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B007E8CF9
	for <lists+linux-pm@lfdr.de>; Sat, 11 Nov 2023 23:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjKKWFg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 11 Nov 2023 17:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjKKWFg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 11 Nov 2023 17:05:36 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18F13272
        for <linux-pm@vger.kernel.org>; Sat, 11 Nov 2023 14:05:32 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c501bd6ff1so43943311fa.3
        for <linux-pm@vger.kernel.org>; Sat, 11 Nov 2023 14:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1699740331; x=1700345131; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=liBhiUPvtybBWQPiBr5O6IhXB1tudfuPt//EzYM9ydg=;
        b=DPIbqWKaxE2d40e8GCD1n2LfCcLKaLfThbbY6yLbDH37IrLqBp1vIFjAj3dZFS5cX9
         n6ocUTZMscljVTZqrQR0LQV0IDNQbfgu+zJ1MlOd+2Sw+sNkaKGJGW5l+F/xv3QSem2C
         EdOqNlbzevayZV4mDFqHBr8c4o97MehvOl3+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699740331; x=1700345131;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=liBhiUPvtybBWQPiBr5O6IhXB1tudfuPt//EzYM9ydg=;
        b=Zz0IbXI40Zp01fkZzPnIuzIyro/s6DIwWwBcT2M7QZFlHBo2b+lzsRSxQkYyj6VWL/
         BM6K+Vpq6DMGy0tL9Era9jVy+tvwXDrmunbRGXZ933Y0rP/xS/ov07z8xOn7lcgokGT/
         H6An/WFS2wOYBtuioVbe4MlKWxADragoM/HdXmR/x37ssgXtyPecgsAWSLs0EAfHC3JZ
         n9RJCZbVWb/81r13AGLyx5eInhPNzyILpbEJY3E+LiJDMQWUo0gqZYg3M8evA5rfp9rv
         LHFanIRnmQL6xRp8TjvRQr9U8x1dIAMZ0Q4+ZqU5npPu8Ar4g+r8r2scVcPxV/v3qil0
         wcBw==
X-Gm-Message-State: AOJu0YwjEpTR1cMdt0/g2ZEXHw3m+/aJRE0TOLUQ0rpKV/ki8FNrkfjW
        6D6MQtEmn2hokkjQrnn5M4GfIBRAI1b3Mf2Iv1Efzw==
X-Google-Smtp-Source: AGHT+IFlHCwfILxS0T9XRfQjIsKHcn+/7a+twMaXt7pe03BVuMTRU77TDQw0SY2B34gUuDPL5uQurw==
X-Received: by 2002:a2e:b0f8:0:b0:2c5:2d16:6d94 with SMTP id h24-20020a2eb0f8000000b002c52d166d94mr2134005ljl.47.1699740330886;
        Sat, 11 Nov 2023 14:05:30 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id s16-20020a05651c049000b002b95eb96ab7sm382086ljc.18.2023.11.11.14.05.30
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Nov 2023 14:05:30 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-507b96095abso4299482e87.3
        for <linux-pm@vger.kernel.org>; Sat, 11 Nov 2023 14:05:30 -0800 (PST)
X-Received: by 2002:ac2:5185:0:b0:509:ffe4:e3d2 with SMTP id
 u5-20020ac25185000000b00509ffe4e3d2mr1696442lfi.6.1699740329607; Sat, 11 Nov
 2023 14:05:29 -0800 (PST)
MIME-Version: 1.0
References: <CAJvTdKn-xtmin9OjnzHg8wy4PM8Lc3Per=3y3UWORhjdroYP3w@mail.gmail.com>
 <CAHk-=wjvJ44a9Z=tkR2o-heQ4XLp0sgynDOhe6JH2fgg=MMMXA@mail.gmail.com> <CAJvTdK=OSTgYkut=-r95nAYOvVfUt3Cah92qudifeQW4ZJHT7Q@mail.gmail.com>
In-Reply-To: <CAJvTdK=OSTgYkut=-r95nAYOvVfUt3Cah92qudifeQW4ZJHT7Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 11 Nov 2023 14:05:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi9OoiKaH11uKD6s6f+jYAoUnXhAqv5Kq8iZWfaZ2Jnow@mail.gmail.com>
Message-ID: <CAHk-=wi9OoiKaH11uKD6s6f+jYAoUnXhAqv5Kq8iZWfaZ2Jnow@mail.gmail.com>
Subject: Re: [GIT PULL] turbostat for Linux-6.7 (with signed tag)
To:     Len Brown <lenb@kernel.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 10 Nov 2023 at 19:39, Len Brown <lenb@kernel.org> wrote:
>
> (Same code as previous pull request, with addition of a signed tag.
>  Hopefully it verifies okay at your end.)

There's no actual signed tag there...

You're still pointing at the same head:

>   git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat

and when I then did a "git ls-remote" to see if there's a tag that you
just didn't point at, I get nothing.

Forgot to push out?

I really would like to see signed tags only, because since v6.3, all
my pulls have been signed tags.

(Ok, I do have three merges that aren't signed, but they are my own
local branches that I merged. I feel like I don't need to verify my
own signature - I sign the resulting releases, and people can verify
that it's me that way in the end instead).

              Linus
