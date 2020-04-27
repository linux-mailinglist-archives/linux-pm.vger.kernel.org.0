Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486481BA158
	for <lists+linux-pm@lfdr.de>; Mon, 27 Apr 2020 12:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgD0Kd2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Apr 2020 06:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726504AbgD0Kd1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Apr 2020 06:33:27 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7512EC0610D5;
        Mon, 27 Apr 2020 03:33:27 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 72so25313361otu.1;
        Mon, 27 Apr 2020 03:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RHfKISSDuem09HNmnqJrvLsee+Kd/nK6TGgV01HIek4=;
        b=u871Cc3aU+fj9E/6ltaMi4DRumGoRfm36hLggOksBcwUIQlOn+/VZR5G8ZmZ+MSjOs
         R0ahBZlobrZWEonpeSZVJbZqyUJHfuSEK6LwjXbKKL33b8U/lX+aPIj3cXjM58nwR8cg
         zk5FfOFxVWl4st/r6DjbI3ohzYmy3Sufzui6R0MtC0h6ZGAMOUS7xYRliSOv31QY5qi3
         ZR9CpoLvcvWwSt2Cdh85uBHqMky7C1e7mbWk3Fj+rQZo/s8dJ1z5Y2wZEnGQFx7xTKnA
         Xs6wOq3xj+V2SetBWAnFdlGiPrTvXuDcPVqqxzrMCw+VcxhmfIxoIglQs2ecwrMsEbHu
         U+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RHfKISSDuem09HNmnqJrvLsee+Kd/nK6TGgV01HIek4=;
        b=pcGAv1dhy3K5ZPzlvpGtqubhhQ/V5/ee1xBTK6UgOdsPrvhOZLA95qFmzIFMf3eUDm
         z5ylLzMch5j+XG8yGt+VZE7R8l0o0FjZQy6IZ7SauxJ5in+NLnO35+lUdWqhTIxdC114
         vcDwDp4H+A1NYEvCftmOGNExnwDg71v6356kaUrdmCUXLMLp2fHEUMI/KhT7S+tdjU7g
         llrJUElqcdKHM6r4I5pMbdT5bmbBUBusEPMO1jy2E2O0JvJk9gEMsFQsxXPkZdOJDGuq
         +CLogL0CebRyaW4St8gSB1hHxbr/Um26Yo1/OS2rrccnv6ziRBrs+Gx7cVZ57GGCqMrc
         CPNA==
X-Gm-Message-State: AGi0Pua6BxSDXYuCeotJLr+dDDFewhpCmKek9fWPHAPKVeiUKcc9c8IM
        cyiL9SRUA4lUl+pwKTuPTi1CheT6xm5jiadQHf4=
X-Google-Smtp-Source: APiQypJYWrI2wW3qHn8idUgkhu1PgaumpBUm2i/d7Fy3/icjCxWW32db6tol3+HUkjrAEJvFcar5dI/Knt8Yve0JLgM=
X-Received: by 2002:a9d:7390:: with SMTP id j16mr16472029otk.43.1587983606923;
 Mon, 27 Apr 2020 03:33:26 -0700 (PDT)
MIME-Version: 1.0
References: <1587678050-23468-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1587678050-23468-11-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdV6J-_gBkzhUXtA8OrxhJVzyrAqjA8oeGJGBp86X-C3Nw@mail.gmail.com>
 <20200427092408.g2vpc6j2c6it4x2i@vireshk-i7> <CA+V-a8vwF=u53dZ_U4vX3oAUHrBh5uVUBeOTiDqTZJfV8UUeCA@mail.gmail.com>
 <20200427102240.jsskbskczvctvcwv@vireshk-i7>
In-Reply-To: <20200427102240.jsskbskczvctvcwv@vireshk-i7>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 27 Apr 2020 11:33:00 +0100
Message-ID: <CA+V-a8u46NZ8Y9dAQRHpsVQ2h4fevmRVxnCMLL5mJ2uewRUm8A@mail.gmail.com>
Subject: Re: [PATCH 10/10] cpufreq: dt: Add support for r8a7742
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Marian-Cristian Rotariu 
        <marian-cristian.rotariu.rb@bp.renesas.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Apr 27, 2020 at 11:22 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 27-04-20, 11:20, Lad, Prabhakar wrote:
> > Hi Viresh,
> >
> > On Mon, Apr 27, 2020 at 10:24 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 27-04-20, 11:22, Geert Uytterhoeven wrote:
> > > > Hi Prabhakar,
> > > >
> > > > This patch should be merged through Viresh's cpufreq tree (CCed).
> > > >
> > > > On Thu, Apr 23, 2020 at 11:41 PM Lad Prabhakar
> > > > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > > > Add the compatible strings for supporting the generic cpufreq driver on
> > > > > the Renesas RZ/G1H (R8A7742) SoC.
> > > > >
> > > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> > > >
> > > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > >
> > > Prabhakar,
> > >
> > > Please resend the patch with all dependencies to me so I can apply it.
> > >
> > This is the only patch which is needed for R8A7742 SoC which needs to
> > be applied for drivers/cpufreq. Shall I still repost it or you are
> > happy to pick this one up ?
>
> would be easier for me if you repost it. I don't have it in my
> mailbox.
>
Sure will post that in a bit.

Cheers,
--Prabhakar

> --
> viresh
