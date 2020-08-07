Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A98223F03C
	for <lists+linux-pm@lfdr.de>; Fri,  7 Aug 2020 17:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgHGPyr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Aug 2020 11:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgHGPyq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Aug 2020 11:54:46 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA9EC061756
        for <linux-pm@vger.kernel.org>; Fri,  7 Aug 2020 08:54:45 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id z14so2746487ljm.1
        for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2020 08:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xOQvVQqkh0nIyyp2B3PI0JXNJza+PnzRNp2yCtr3Mkw=;
        b=NWZK2PIgQcGaLlGhXQiIZ/ii/pVqfoT2UR8kSA9UcJdxQNWMw1+rjix7K1SduAqoSD
         gi5P8s3ejXFub/LB9x7qhaCMCiCdHcPBEcoCqQEuvpdDJkWLn4nm5A7A6LSc5cjDeWJB
         mc342Scak5zLyQFEd3zBQbJMDms7jfoYsoA5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xOQvVQqkh0nIyyp2B3PI0JXNJza+PnzRNp2yCtr3Mkw=;
        b=dFaW9CQwmaW6popzECiENb6fIBPhNvBqM4v9wsHrSko+Ao9JiWxgxZ+MIH0P5CjJ0a
         VwtFmGhQpTEg8+4U5nXheethM1gVNk1doOXI91fje+SL+PWtt0rFPczWJ/zoo6x/hNGd
         Bi8w+kxA+wjPKWvh0UloXq9ML9KyQUibMcW74/A5OVS5PDQEh2i68OPFOFXQjDfDPuPj
         x2NMD9TzymjHb8t+WhxcizuAW05loeoDzpWJPuoa0cO+UfctAquTw1E/HQOnwGrw2VYe
         xpEQ6+ueIeLc42sKaVUgpOj2bGWjDCQ6Zy9dKFTSnj1UlvGu+QV0HSiEwW53gVackQhe
         08Nw==
X-Gm-Message-State: AOAM531yZa5XdEFP4v4xbcubwfz2yuavo11f0b3L6QjVvio4MEHOtg82
        hQYh/wHCDWuTSjrb5UoLc0ih0Uvfx58=
X-Google-Smtp-Source: ABdhPJyxj4HpAedMWndzyyT3cEX1hW1/zOO+kb3qxOfrTDJvLx8SGO7cj6ROMTQHS3e2+s5Y/9gYTA==
X-Received: by 2002:a2e:3518:: with SMTP id z24mr6681697ljz.360.1596815682926;
        Fri, 07 Aug 2020 08:54:42 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id u6sm3982062ljg.105.2020.08.07.08.54.41
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2020 08:54:41 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id t6so2702785ljk.9
        for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2020 08:54:41 -0700 (PDT)
X-Received: by 2002:a2e:92d0:: with SMTP id k16mr1055600ljh.70.1596815680797;
 Fri, 07 Aug 2020 08:54:40 -0700 (PDT)
MIME-Version: 1.0
References: <db1dc155-0c7c-f4eb-7fa6-047a78829a82@linaro.org>
 <CAHk-=wgLt61owJ_eKwy43bBujxy3-s=xQXwsSi6VHME7SiAgiA@mail.gmail.com> <b903cdd8-cbb5-1a6a-3943-9bb019f1eed7@linaro.org>
In-Reply-To: <b903cdd8-cbb5-1a6a-3943-9bb019f1eed7@linaro.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Aug 2020 08:54:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgSJwbghhQYCoAVq6ewGKZ+rZvxeKvxb-o_gMt7d7-Nbw@mail.gmail.com>
Message-ID: <CAHk-=wgSJwbghhQYCoAVq6ewGKZ+rZvxeKvxb-o_gMt7d7-Nbw@mail.gmail.com>
Subject: Re: [GIT PULL] RESEND: thermal for v5.9-rc1
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Colin King <colin.king@canonical.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Lukasz Luba <Lukasz.Luba@arm.com>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Henry Yen <henry.yen@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Marian-Cristian Rotariu 
        <marian-cristian.rotariu.rb@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Aug 7, 2020 at 2:40 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> It defaults to 'y' because the previous (but unused) implementation was
> unconditionally compiled-in and because of the thermal users needs.
>
> Is default=y wrong given this history?

One million percent wrong.

The fact that the old implementation was never used just shows that
it's not so important, and it shouldn't be default 'y'. Not having it
doesn't break anything.

And the new implementation presumably isn't even compatible with the
old format also means that it shouldn't be default 'y'. Building it in
wouldn't help anyway.

And the fact that _some_ users might want it does not mean that it
should be default 'y', because those users presumably _know_ they want
it.

IOW, defaulting to 'y' is just wrong in every possible way. This is
not some kind of "to maintain compatibility and not break existing
users we should enable this" kind of thing.

And it's not some kind of "everybody should have it" thing either,
since presumably nobody has the user-space support for it anyway.

It's something that a new distro would enable _if_ they actually end
up supporting the user space. Not something the kernel should enable
"just because".

Really: "default y" is _wrong_. Every developer thinks that _their_
code is so magical and special that everybody should run it.

And every developer is almost always wrong. Unless you have a "not
having this will break existing users", you don't do it.

                 Linus
