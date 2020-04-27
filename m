Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 751E21B9F90
	for <lists+linux-pm@lfdr.de>; Mon, 27 Apr 2020 11:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgD0JQ7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Apr 2020 05:16:59 -0400
Received: from mail-oo1-f68.google.com ([209.85.161.68]:42251 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbgD0JQ6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Apr 2020 05:16:58 -0400
Received: by mail-oo1-f68.google.com with SMTP id e18so3701406oot.9;
        Mon, 27 Apr 2020 02:16:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R1QrTa/K0bMQ+b9dlA4C9LjJ8AunxEcf6O025vwbEug=;
        b=OEftM6hzuJM+4Rn28Kfir2LnsXa7WUBlrLODjIzssnA12dA0lOXDWUNu5Vo5dOG9BC
         Q1YYesO8qHVS1pqAlmKIG2pQwRm+rJQUC3kH1l3Dl6M4LWPMOsb2ucuaTh1JHum7s7Pv
         RfVQKgUxapOIZ/eL/xm1c1DxNR0vHDU6c5s9Pfix7uizWZ1qpbjsAT0ymtkKfuQxXTQ3
         Csv49/gHkm6qsBFgJlJ4x25gJgUee4+Za0SXcCjTs8uaEGOg/QetC7tVko3zaIYnXXJJ
         MgyUzmjpefOqyN9CYY2xgeeHB14EFwsbAxIc9NdW9t74lUBT/rgpEGnUsgFNayN5rRqa
         7Xxg==
X-Gm-Message-State: AGi0Pub2e7bvzl2gmjY2k0gBqXzqBl0UecZ/lewDACBoN/uA9xNpAIOk
        ZeO7KNL68XnMzOlyraK33gmFMFWKIsCxAvJSBu8=
X-Google-Smtp-Source: APiQypIJzSvNvEo1tYanaXMvgtTGblhKVBrP3rfeg0g85mtYT3VODWtMnFtSr9Hn+6l6aAPSGDtmk70AKFPX4WR0Z1o=
X-Received: by 2002:a4a:d44a:: with SMTP id p10mr11810739oos.11.1587979017681;
 Mon, 27 Apr 2020 02:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <1587678050-23468-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1587678050-23468-10-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1587678050-23468-10-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 27 Apr 2020 11:16:46 +0200
Message-ID: <CAMuHMdXyE+y00HCqS-2SnmVgeaeVQ2f6cKLKrm2njSi=V85+Nw@mail.gmail.com>
Subject: Re: [PATCH 09/10] ARM: shmobile: r8a7742: Basic SoC support
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
> Add minimal support for the RZ/G1H (R8A7742) SoC.
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
