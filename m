Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A0A1B9A1D
	for <lists+linux-pm@lfdr.de>; Mon, 27 Apr 2020 10:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgD0I0u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Apr 2020 04:26:50 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45521 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgD0I0t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Apr 2020 04:26:49 -0400
Received: by mail-ot1-f68.google.com with SMTP id e20so24776350otk.12;
        Mon, 27 Apr 2020 01:26:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ihiMp4vbxc5oIwvcnHb0LN0vARvd9Ooni0RPVOQhxkc=;
        b=ldHTcSiV/BP3++8pNFeavcbIN0lXV8KYO+c7ytorF4KsAfRYv/r6lNmKX0jI7+IjK+
         nn9nE7/GAUjlQ8wJjWKSLtKmKq7foaAO7oETquo/fQZEamu+SfTyCNNTElw0Te0+XTRv
         yNF+2r7X6yAstmD1RtTc0gnvVvtIgizSCXPKPdio4VCfdJtT6b7hafXABZ6WHvKmvb3S
         THW9CBG67+w4k3zCA/vd1vgSDsOfcCFYzHAtz8wMEMSFKLRrKS/P2k1d7U5M55vZqGkr
         ps5Ew98sgqH46sv32IUs38rfzxehtoowWCKln2UlM00UrwJFeCcUdibEif9Mjw59L7lS
         FpXg==
X-Gm-Message-State: AGi0PuYX549If7yKaEjNXnMY0bLkyTydEFcKICbRG/HFZ1oPnnghN2Uf
        Nt/cKL5MTiQvARKgVpn2VWwf1+LbUbkEdEygnMg=
X-Google-Smtp-Source: APiQypLscqMbwKnZqMSsnfb4EiQfW0ot85GIYgb9GEJ+7ISJ7utlbyc9JuuZHDQUSrdVZSbs1WF5JQsxiBr4ZA0cGCs=
X-Received: by 2002:a9d:564:: with SMTP id 91mr17457118otw.250.1587976008856;
 Mon, 27 Apr 2020 01:26:48 -0700 (PDT)
MIME-Version: 1.0
References: <1587678050-23468-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1587678050-23468-8-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1587678050-23468-8-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 27 Apr 2020 10:26:37 +0200
Message-ID: <CAMuHMdUTAxaPE1WRJJOPr4_O9f_Yw7zVrgm6wkwjHiExSNu+yg@mail.gmail.com>
Subject: Re: [PATCH 07/10] clk: renesas: Add r8a7742 CPG Core Clock Definitions
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
> Add all RZ/G1H Clock Pulse Generator Core Clock Outputs, as listed in
> Table 7.2a ("List of Clocks [RZ/G1H]") of the RZ/G1 Hardware User's
> Manual.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in clk-renesas-for-v5.8.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
