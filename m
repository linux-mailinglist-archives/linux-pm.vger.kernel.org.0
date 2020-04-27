Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA341B991A
	for <lists+linux-pm@lfdr.de>; Mon, 27 Apr 2020 09:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgD0H4m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Apr 2020 03:56:42 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46977 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgD0H4m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Apr 2020 03:56:42 -0400
Received: by mail-ot1-f68.google.com with SMTP id z25so24618299otq.13;
        Mon, 27 Apr 2020 00:56:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7UMvg3SgF3Z/vg+y7g9jGGsKrtnmuAla9KXreMTQAhI=;
        b=t9NLlnFJ1OEK7sU6UwFePEt9q6jcE1qLs3bxhgGn0yWYEHifDLwDbpl5mEwXDi2C2C
         KwedROgYEM4g+/nVYSbvZNcWapvVdII3r/GycvE3sZXZrg5CaDNG9NcuNk9rG979l5HV
         ocGmzC+VRkLGhBcdL8OristTZe58zka2acvYsR1x74I1wMRhJHx+YPL+oYGghBJgBHT1
         HlRUbakgFYOSoWDxtYcs9RlYGtfr5+xZ+7Sa/63iufYN6/gaAZIBWTMc6b2eAXDQeeom
         8y+dWWPV3wFg0ExFq/JwfBFkw/t5nvjisec+k6R/ReG1Y+hpjkFY8SvNNjkabbnLsEeK
         a6tg==
X-Gm-Message-State: AGi0Pub7jHX0j95j0gF5mZjokylu2GNWv8NvDKctLdG9SWCVsCVE0LIF
        qEOCe0RAa1WIoiYYBQJta0T/IeC4o/F+Yt5QvJ4=
X-Google-Smtp-Source: APiQypJNiorFwGFtTWNfHeU91mJyq8jOtGMvHi4yXmBXBG6sADUJLDzy6CgqP6gm3Pr5teIV3//DtSwqQxPpDR3DXq8=
X-Received: by 2002:a9d:7990:: with SMTP id h16mr11386571otm.145.1587974201140;
 Mon, 27 Apr 2020 00:56:41 -0700 (PDT)
MIME-Version: 1.0
References: <1587678050-23468-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1587678050-23468-4-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1587678050-23468-4-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 27 Apr 2020 09:56:29 +0200
Message-ID: <CAMuHMdXQdoi07dhYeb2qqCTEuNN4xzVxA9sBgi9F+1tjtaHe6w@mail.gmail.com>
Subject: Re: [PATCH 03/10] soc: renesas: rcar-sysc: add R8A7742 support
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
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
        Linux PM list <linux-pm@vger.kernel.org>,
        Lad Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 23, 2020 at 11:41 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Add support for RZ/G1H (R8A7742) SoC power areas to the R-Car SYSC driver.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.8.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
