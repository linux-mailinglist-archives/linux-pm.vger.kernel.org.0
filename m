Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2FA1BA0F0
	for <lists+linux-pm@lfdr.de>; Mon, 27 Apr 2020 12:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgD0KUm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Apr 2020 06:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726485AbgD0KUl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Apr 2020 06:20:41 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD28C0610D5;
        Mon, 27 Apr 2020 03:20:41 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id m13so25199090otf.6;
        Mon, 27 Apr 2020 03:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gUcWSkbxyPvJ0+ERW/qepkDLsiLjdEGghyciw3XnsT4=;
        b=uNy2SXjrR2mbQALDHVMHlcFBkpzgy8HTawiU3KEQzSt++Gk5NabhVh9Ye4tWjoYCKl
         pUmPFhRGG+Ecfi4QF7T7Fml1Ft31cm1aCR9QLNusoV6LIdEu/4gPNnbynP6ZUU2FTzfG
         hvYSUHt9mYQVUl3PiZTKwiJvhWG4wXKqhdzTE9gtGfyM/Gbi4rWevwH8BBo1xQ6vBwZW
         scW9/eXN/w6qmx9mT3YHcZrtoP/vO+RK54L0D48d7Y1ZrXPvsOkY7ib53eTwWszwsLEU
         Xfhw5+HfEMIlhQNWef8RoTmymqqsrKfa2YJn2skuiblTh7MqWRbwBUsSNBKhtNJWhqia
         w26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gUcWSkbxyPvJ0+ERW/qepkDLsiLjdEGghyciw3XnsT4=;
        b=kfjEpdVRYc4xfn/8vOJ4wZKBawGDVepIVQlAj2+FKXkgaThRBcCQPbcAddWn3cA6+L
         W5GVIQWrXtV5rFVX55Ew6nQUB6JzLv+IXfMOuq/8juBMclUBpvvAOMXw3jbXzVHuNDM9
         F2nzd/Kae/Wg/BV3S/v381FyTL9D5tGxkvsXeY5QPwGbTtEw9xFz38phl1Lm58tS0Fo7
         JgdiuAONWQkU/LNthiuGdo7RckNsPHY3pHlK7ygYOYkQdqn3qNEVX/cVqps8FkKDb7xA
         J415qmnRWYfJutF/++/Yx99PmMaw8pcDffvCQ3GgC9w7+lPhM7/tyeYSdNMazDGoK3RO
         ne+w==
X-Gm-Message-State: AGi0PuY00hti2oD7+Yex5/hJKDwOEuyA9ETMpFbqoEZjQyUEJLopIosO
        F4S7s5eYVE1MRM7kjHdRtQd9DOA4CC73uvhbMNo=
X-Google-Smtp-Source: APiQypIeuwTOWNRaduLVrl8FnkbpT7m1ncyU5dpdVc0UJFZpGKzatZMZ/wGFpQdBgCzzzKU46eV7y4UpS9+lDJyUvmw=
X-Received: by 2002:aca:b783:: with SMTP id h125mr3049635oif.62.1587982840882;
 Mon, 27 Apr 2020 03:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <1587678050-23468-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1587678050-23468-11-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdV6J-_gBkzhUXtA8OrxhJVzyrAqjA8oeGJGBp86X-C3Nw@mail.gmail.com> <20200427092408.g2vpc6j2c6it4x2i@vireshk-i7>
In-Reply-To: <20200427092408.g2vpc6j2c6it4x2i@vireshk-i7>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 27 Apr 2020 11:20:14 +0100
Message-ID: <CA+V-a8vwF=u53dZ_U4vX3oAUHrBh5uVUBeOTiDqTZJfV8UUeCA@mail.gmail.com>
Subject: Re: [PATCH 10/10] cpufreq: dt: Add support for r8a7742
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
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

Hi Viresh,

On Mon, Apr 27, 2020 at 10:24 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 27-04-20, 11:22, Geert Uytterhoeven wrote:
> > Hi Prabhakar,
> >
> > This patch should be merged through Viresh's cpufreq tree (CCed).
> >
> > On Thu, Apr 23, 2020 at 11:41 PM Lad Prabhakar
> > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > Add the compatible strings for supporting the generic cpufreq driver on
> > > the Renesas RZ/G1H (R8A7742) SoC.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> >
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Prabhakar,
>
> Please resend the patch with all dependencies to me so I can apply it.
>
This is the only patch which is needed for R8A7742 SoC which needs to
be applied for drivers/cpufreq. Shall I still repost it or you are
happy to pick this one up ?

Cheers,
--Prabhakar

> --
> viresh
