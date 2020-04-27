Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F3A1B993B
	for <lists+linux-pm@lfdr.de>; Mon, 27 Apr 2020 10:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgD0ICr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Apr 2020 04:02:47 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33017 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgD0ICq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Apr 2020 04:02:46 -0400
Received: by mail-ot1-f68.google.com with SMTP id j26so24706831ots.0;
        Mon, 27 Apr 2020 01:02:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f5Ebv09fgLvXhH+xtkwAAFGfajOYbV6HYFuo3teIizk=;
        b=QTkL3YMzkqnqMkZrqk/TMJH2TD6ExovnSuqTTBbRZVe03vr/RZmD2sg16/ZaAb8IUo
         xXsY+NMzKSzqwgN6W+YDnPgNhDq4wARefLVjYZT2NhqPUFxrcVl7eer5pp4XFu3VMYjd
         VgujztadAXZdVsWazCjbEfY3acuL8CFyglWR/vPw3RUb9ISliO+ovwkEKQ8Pu/EvuLCU
         PnsOLAxZEtcbVvVmS9rXWEZk4NICS0TfFM7xR57BuClXN7L2PkS1xpQ21z7kcZybk6pv
         QEsKVimTeKWV+P335ZD2ENa9C0+R3eFET5Ds924fFUpBancotQzrRfJF1XENrABS0Tpz
         ZBxQ==
X-Gm-Message-State: AGi0PuaVcHkozk4E6bQt1BTsv0TTiw7wIAhJ/aW8JUfqg8PtXLGsYAfR
        zpK+cIVRlDz5VY3jtsXr2aNAR54snMzhi7wI6JM=
X-Google-Smtp-Source: APiQypIckWSRUFUfZAWUBejtBhO2NfwPOP9jI9vNGdXY4ftuZTnLKOuMb4y3ZUy6caTNdp7h21vQCdF9p5aUhAKKMC8=
X-Received: by 2002:aca:895:: with SMTP id 143mr14299678oii.153.1587974565833;
 Mon, 27 Apr 2020 01:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <1587678050-23468-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1587678050-23468-6-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1587678050-23468-6-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 27 Apr 2020 10:02:34 +0200
Message-ID: <CAMuHMdWGJ6cDcbt7RJr1Wa+Sqbnxackg6JC4b+=HqvmDx8L0ww@mail.gmail.com>
Subject: Re: [PATCH 05/10] soc: renesas: rcar-rst: Add support for RZ/G1H
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
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
> Add support for RZ/G1H (R8A7742) to the R-Car RST driver.
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
