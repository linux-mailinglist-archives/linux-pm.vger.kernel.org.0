Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E0C1B98C2
	for <lists+linux-pm@lfdr.de>; Mon, 27 Apr 2020 09:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgD0HkI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Apr 2020 03:40:08 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46106 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgD0HkH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Apr 2020 03:40:07 -0400
Received: by mail-ot1-f65.google.com with SMTP id z25so24554936otq.13;
        Mon, 27 Apr 2020 00:40:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wek6tBW+YiNXLDCAullGByq6Df5JS2eLcCF9PYMe2Os=;
        b=ND7POKYuoI6rTC3LmAxQ+pwr5LFZ2G+NpUewCsRadwFbXudr6Os8Oc/SY9/bViRZOr
         bwIODOsjZ2hzF0mdxNFlEGkjk27Ep5yBKH4Ka6AR1hT7PHDU0YKtoXip9qm9dM56h62v
         pAbIInZHuWYZFJx+uhFZ5hetvbBtaSfiYMwbLaCMeyrntJPp61f0tbzHiK1b3Yt/2Ajw
         9PyJD7h2uBk9iZSgQBzKEEI5004uonphP48F2YFX2WSmW3J8mYguMvRvZzsS7tdbs144
         K0zj9wRL+Q0J7VJyZJ0AgctXFJHnpGVPkZ7OIPLkDt8PVkIsOn1/BKp0JGk1kJwUh6rE
         IxIQ==
X-Gm-Message-State: AGi0PuYEieeMzv/ehL2yvJvjdg8bJ6Rvd5erFJ/PuuVNc4EPTGuWQlRJ
        /cfpzc6PQlGRc7+o/U+B/PUm+S5vOegjP41dfqk=
X-Google-Smtp-Source: APiQypJsr17J2GPmA+VqMopmvfDZIJGNi04BuJZW9HgLZVc+RHHoovs3TupqRwUjD9U4Un5Q+0yM9r1PgNT/e3hjXEI=
X-Received: by 2002:aca:895:: with SMTP id 143mr14265203oii.153.1587973206830;
 Mon, 27 Apr 2020 00:40:06 -0700 (PDT)
MIME-Version: 1.0
References: <1587678050-23468-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1587678050-23468-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1587678050-23468-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 27 Apr 2020 09:39:55 +0200
Message-ID: <CAMuHMdUWwvLeuTY=DVwE3GK233dC0NNPPeeihSQX9TXKrhbA4A@mail.gmail.com>
Subject: Re: [PATCH 01/10] dt-bindings: power: rcar-sysc: Document r8a7742
 SYSC binding
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
> Add binding documentation for the RZ/G1H (R8A7742) SYSC block.
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
