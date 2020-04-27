Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5841F1B994B
	for <lists+linux-pm@lfdr.de>; Mon, 27 Apr 2020 10:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgD0IEH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Apr 2020 04:04:07 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35669 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgD0IEG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Apr 2020 04:04:06 -0400
Received: by mail-ot1-f65.google.com with SMTP id e26so24752088otr.2;
        Mon, 27 Apr 2020 01:04:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yp9HgL6YXH1Mrs7/xb1a0hjYzru62kco8NbdEX0q47w=;
        b=fqf2apN6rMLx+bj9WGC0vXQnzxwveZ3ahvm450ePwDSnEHZcdxPaPSr7K7Pc3mvcBO
         e0dCwnt1oE/748jia21S+QBQaSMeSy0+TbKHw8eKGEWYBboW5CpkqZJ15j2Ik7PlwKMV
         wo7FXsWj9vBEzlGrojdmY+/2KY97+4j+W/+4q//gv8btJtdcZ665O1uix35th7eB82zT
         VNNN2SJTpvAwAPOQUYmTjVNgAdIIqSpzzdvgOrf0mYRZkKxR61eb5z4FuB+Y21p6DWcM
         ozXbyoaxVLuDb/MzThOx+KxyD23Kdtl0qKjb3zIDQY3gQ47X8fpRAx+2ow+cP+VGYazo
         847g==
X-Gm-Message-State: AGi0Pubo0I9AvwMRJ3PgvuQgaWmhUv+DIp3TxjZZIxeV2EeJ1y1nBb/1
        6z8VQ85jsJup41aqcJhyxM3dCnbkA8o5QDSMiDY=
X-Google-Smtp-Source: APiQypL9L0sStSs9sZCJMMiE2Zg4MITGkAayddwxMKwHPKdmjS62MIWjUuR1BBUAExNprGCWXUObgfMmOo6mye5Vn6w=
X-Received: by 2002:a9d:7d85:: with SMTP id j5mr16411444otn.107.1587974644288;
 Mon, 27 Apr 2020 01:04:04 -0700 (PDT)
MIME-Version: 1.0
References: <1587678050-23468-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1587678050-23468-7-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1587678050-23468-7-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 27 Apr 2020 10:03:52 +0200
Message-ID: <CAMuHMdWiQd1x7+_qJnFzNbz27CwCW9yO431pUfYATE=0rM8J-Q@mail.gmail.com>
Subject: Re: [PATCH 06/10] dt-bindings: clock: renesas: cpg-mssr: Document
 r8a7742 binding
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
> Add binding documentation for the RZ/G1H (R8A7742) Clock Pulse Generator
> driver.
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
