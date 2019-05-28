Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 087F12C187
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2019 10:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfE1ImD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 May 2019 04:42:03 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43152 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfE1ImC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 May 2019 04:42:02 -0400
Received: by mail-lj1-f196.google.com with SMTP id z5so16854211lji.10;
        Tue, 28 May 2019 01:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ygkFSrOUs2wAQrj519Ns5GvdxA1S7D4YiKeP8FBGjUc=;
        b=io1OvXIkx7t+fFIgPEQR1LWZpcHU//FxMoIA1CHkmrvMyfCuy+Dd8qNCTP6K6VQsbq
         Xnegy97eNHvCjNEoN5fa3JWkdKUODIhUVnKB8JDr1V4bo+e9c57B7kGi2wJ5gRuzO4Hl
         8dl3reJTRBm81ahfZNlJxkqi6xe3uhKwpEyjPonwx8SizWtZxeptMX1G9jeXq8j+wDxM
         KlkFzD2YAKUldahDdilc9W2cauTFJyM1cSX4d3IPRLuCYjFcnyhenHDsW9KT+FHS12S0
         nBTx2qeSnsu2YlRLxD1k03OQ67xtOubPudB3g7CQZNSjQdA5RNh63XWVC8UOu1jMuD54
         Bd/A==
X-Gm-Message-State: APjAAAVJQ/+bjo6yRObS1AHTop4Ia82G3DIVmR2JXv9dtkKdmk16y/eR
        MoKxN+V193ChPb04ydkGbZYn50CKk2hvrjhpqR4=
X-Google-Smtp-Source: APXvYqzZOuoB7xeUwboMimv2YSMlSWfGHoyt2S/rx8pW4inWIs7Uyh9nphOHLevt3f4ts4P2YOKp0CLg7C99oF1gcQ4=
X-Received: by 2002:a05:651c:150:: with SMTP id c16mr64013182ljd.65.1559032920568;
 Tue, 28 May 2019 01:42:00 -0700 (PDT)
MIME-Version: 1.0
References: <5cec74e8.1c69fb81.37335.9d7b@mx.google.com> <0edab48f-06e5-9ed8-09be-7c9976ae1afb@collabora.com>
 <CAMuHMdUF1Csi1ZMccOj=kurijMLcA6G+TP_spsE+fnMvZR71Vw@mail.gmail.com> <de92e3bd-70e8-fcba-3c88-c04170704e7b@collabora.com>
In-Reply-To: <de92e3bd-70e8-fcba-3c88-c04170704e7b@collabora.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 28 May 2019 10:41:48 +0200
Message-ID: <CAMuHMdW9Rz=ZQ=wWg=vGJAzzM85+UnN1otKfJzVvbkTkPQ2g2g@mail.gmail.com>
Subject: Re: linusw/for-next boot bisection: v5.2-rc1-8-g73a790c68d7e on rk3288-veyron-jaq
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Matt Hart <matthew.hart@linaro.org>, mgalka@collabora.com,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Guillaume,

On Tue, May 28, 2019 at 10:36 AM Guillaume Tucker
<guillaume.tucker@collabora.com> wrote:
> On 28/05/2019 08:45, Geert Uytterhoeven wrote:
> > On Tue, May 28, 2019 at 9:13 AM Guillaume Tucker
> > <guillaume.tucker@collabora.com> wrote:
> >> This commit has now been reverted in mainline.  Would it be OK
> >> for you to rebase your for-next branch on v5.2-rc2 or cherry-pick
> >> the revert to avoid recurring bisections?
> >>
> >> Ideally this should have been fixed or reverted in mainline
> >> before v5.2-rc1 was released, or even earlier when this was first
> >> found in -next on 13th May.  Unfortunately it was overlooked and
> >> then spread to other branches like yours.
> >
> > I'm afraid it's gonna spread to even more for-next branches, as most
> > subsystem maintainers base their for-next branch on the previous rc1
> > release.  Typically maintainers do not rebase their for-next branches,
> > and do not cherry-pick fixes, unless they are critical for their
> > subsystem.  So you can expect this to show up in e.g. the m68k for-next
> > branch soon...
>
> That is what I feared, thanks for confirming.
>
> > Can't you mark this as a known issue, to prevent spending cycles on the
> > same bisection, and sending out more bisection reports for the same
> > issue?
>
> Not really, so I've disabled bisections in the linux-gpio tree
> and a few other maintainers' trees for now.  I'll see if we can
> come up with a more systematic way of suppressing bisections in
> similar cases (i.e. the issue has been fixed in mainline later
> than the base commit for the branch being tested).

Having a systematic way would be good, else you will have to disable
most other maintainers' trees soon, severely limiting test coverage,
or fall back to linux-next testing only, as linux-next will always include\
latest mainline.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
