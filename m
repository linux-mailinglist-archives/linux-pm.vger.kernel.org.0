Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF49BF30C
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2019 14:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbfIZMbh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Sep 2019 08:31:37 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39438 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfIZMbh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Sep 2019 08:31:37 -0400
Received: by mail-ot1-f65.google.com with SMTP id s22so1813463otr.6;
        Thu, 26 Sep 2019 05:31:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FI3A7aAInknT9ZHmm1wVzjamoB1+dc9hps/ZQ8A+OHk=;
        b=Ulrr0NKWbX9lt1f6pX8WnOFiKikST8WSVjo2jDnzI7cKBFi307h+ipQvSRPLhglDOc
         k7USorPDUov/zNb2XEPWFqQsHUM61HQrhk3gK8RRE7wbP1VyhtJZ7ETOi1sQHdtI0WIS
         BfYOejvNCIFkDJjEdAwcCh6bVwN9h28PASiiEVOWzkIrVfAzjMtK6zZUbk1sxZ0vEXWW
         OQMttypOmFjuJGBKL2r3D+iCrs4G+iRScu6wOsbQWH395wyNEfpDPFm8IljSsR/VDUj9
         fL0BU5PZzz84FdhR9wC6xpzq12WGO3FcMaevRTmHnJaA8rm6jMFw+p0+PKRT6TvOT2j1
         aJTw==
X-Gm-Message-State: APjAAAUkiVFa1+YIx6iD7JfrvEtaAMpUwqlJ4hbnt+vwBCkC9L6Nis1z
        zBTbgkiJHhSuvPr/hNhX9QvXjeZGtSnlc9hllUo=
X-Google-Smtp-Source: APXvYqxxQaAPzxTZ8UKUwxlJeKeUOA7K3Y6zgMUWsxgUvHR/Hh/mJ+Axryt8cULzZyVk3FbYRR3AzHCDIo/omfJZ5wo=
X-Received: by 2002:a9d:730d:: with SMTP id e13mr2381516otk.145.1569501094645;
 Thu, 26 Sep 2019 05:31:34 -0700 (PDT)
MIME-Version: 1.0
References: <1569248589-52372-1-git-send-email-biju.das@bp.renesas.com>
In-Reply-To: <1569248589-52372-1-git-send-email-biju.das@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 26 Sep 2019 14:31:23 +0200
Message-ID: <CAMuHMdU7L0ZuoJV=2UXB90qqZ+siXvE7cGfKmwwbd9aB2de4yA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: thermal: rcar-gen3-thermal: Add r8a774b1 support
To:     Biju Das <biju.das@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 23, 2019 at 4:23 PM Biju Das <biju.das@bp.renesas.com> wrote:
> Document RZ/G2N (R8A774B1) SoC bindings.
>
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
