Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAF01B98EB
	for <lists+linux-pm@lfdr.de>; Mon, 27 Apr 2020 09:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgD0HoN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Apr 2020 03:44:13 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:41589 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbgD0HoN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Apr 2020 03:44:13 -0400
Received: by mail-oo1-f66.google.com with SMTP id t3so3653302oou.8;
        Mon, 27 Apr 2020 00:44:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aUJDPtd94Plupi9zkES8lfiieamV2XcJxXuQDIx8qu4=;
        b=LaA8xE9HQN6CCOu8WU7r9z+uwaF5b992FKIuKd4AKAdE2sDR7Zq+5msm/Y3RF9MeYt
         KIojFPh5aQRm39piXX6ApEwh9LO8M0peVAqQJFJL/xDqpVp5EGPy8312SX+lEW/7YaJv
         O5FpxVJKU97kMSAQdRO6o16B09KHrzNl9ukl0d8CUNW3XG3CDfgKe5S06p4u2HM38m8x
         yZvtc2zrdX55iwxqTzhJzZ4u2d7al2ULzFgIU4HIdCM6h00R9RRIide0XHYR/MStDJoC
         zJDOSv6ovM0nZ9e56ZC3vhEcMWAQ3icWUNgAQL2itIY6mUw2HLo9lM6XIfS1m5irch7q
         L3JA==
X-Gm-Message-State: AGi0PuZrKbHc83BqU3YxiJrHC+Sk2+Kw+tiamDZv4lLUJl1egUqfWN5M
        gBq9n9OdT2D9BDdttWxXXfszVOj6S3dkrTZNE8ZQE+8T
X-Google-Smtp-Source: APiQypIl/TpnOn5p7OBbPvXk/Rw8DS6/P2ZXewhbJXbTzpHODYNJFR3YLZ3Ic8lUBEcmpgBPbPkwhix00waahtWul7Q=
X-Received: by 2002:a4a:d44a:: with SMTP id p10mr11597099oos.11.1587973452397;
 Mon, 27 Apr 2020 00:44:12 -0700 (PDT)
MIME-Version: 1.0
References: <1587678050-23468-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1587678050-23468-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1587678050-23468-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 27 Apr 2020 09:44:00 +0200
Message-ID: <CAMuHMdVkFBjgwL9M4GutgOaf0Avo1Vq1ZUUv9fWsia=Tb6qnmA@mail.gmail.com>
Subject: Re: [PATCH 02/10] dt-bindings: power: rcar-sysc: Add r8a7742 power
 domain index macros
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
>
> Add power domain indices for RZ/G1H (R8A7742) SoC.
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
