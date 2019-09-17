Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA25B4D08
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2019 13:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfIQLhx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Sep 2019 07:37:53 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45365 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfIQLhw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Sep 2019 07:37:52 -0400
Received: by mail-ot1-f65.google.com with SMTP id 41so2675723oti.12;
        Tue, 17 Sep 2019 04:37:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kbKsjH7xGS8HXzvSqPg0MqZ83280SDuHAEJ2fe9NRi0=;
        b=SCIH97QyX3GAwaOE/BDneGQgQRYRISbaiw156R7Bz+d0BnTYwXoDW24hyq9uBZEIht
         N0sfjFFkrq6jISh3+gwRLQJjTLX51BNMRHSiU5fxo9dmWvI7zBq1roBIGQLywnP5PyC4
         hZeN/ggQo29lQew78AhOLmIXFuZ9sdJqefl/sIwXp9lyIGkgf3Ad5HwAkinGA0B1wgQ1
         dHZ0LsFIVPw6r3z90BhoPVklqMoTYPax+pCg7SZ3Cs68OmJUE5FfWUmur2YNGChE7+Z1
         jVzktetTroOLGr2feX9uwSkQH2gQk4G5RMpm2oQu7N7XWo06fxJW4LGsLp43mG8zhiyV
         zqzw==
X-Gm-Message-State: APjAAAWvaNmIIR6/arGVjmbXCqZK4V/6H2BSeUTZ8i7ICVzlS0xYMrXH
        K+IPklPKyZGw7ZM8mMsILhxU+mOhtEsiDLRW5L4=
X-Google-Smtp-Source: APXvYqw1Zk1vy8jKLzKxDLlD6T9Y7BoKwvL+9dsJxs0o8/NwXjPXsWqaRIFfUATF4tJKE5C+QQHeIpSLsKkoD9iH0kw=
X-Received: by 2002:a9d:5784:: with SMTP id q4mr2140655oth.107.1568720271724;
 Tue, 17 Sep 2019 04:37:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190916100717.31472-1-horms+renesas@verge.net.au> <20190917113250.6q4mmyiaa7pdkbeb@verge.net.au>
In-Reply-To: <20190917113250.6q4mmyiaa7pdkbeb@verge.net.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 17 Sep 2019 13:37:39 +0200
Message-ID: <CAMuHMdUDRdWoe8L49kDAwsv_46UzwKPiNz9WfEQyrX-o7XZhwQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: thermal: rcar-thermal: convert bindings to json-schema
To:     Simon Horman <horms@verge.net.au>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Yoshihiro Kaneko <ykaneko0929@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Simon,

On Tue, Sep 17, 2019 at 1:32 PM Simon Horman <horms@verge.net.au> wrote:
> I missread the original bindings document and somehow missed
> warnings emitted by dtbs_check. I now think the compat property should be
> described as:
>
>   compatible:
>     oneOf:
>       - items:
>           - enum:
>               - renesas,thermal-r8a73a4       # R-Mobile APE6
>               - renesas,thermal-r8a7779       # R-Car H1
>           - const: renesas,rcar-thermal       # Without thermal-zone
>
>       - items:
>           - enum:
>               - renesas,thermal-r8a7790       # R-Car H2
>               - renesas,thermal-r8a7791       # R-Car M2-W
>               - renesas,thermal-r8a7792       # R-Car V2H
>               - renesas,thermal-r8a7793       # R-Car M2-N
>           - const: renesas,rcar-gen2-thermal  # With thermal-zone
>           - const: renesas,rcar-thermal       # Without thermal-zone
>
>       - items:
>           - enum:
>               - renesas,thermal-r8a7743       # RZ/G1M
>               - renesas,thermal-r8a7744       # RZ/G1N
>           - const: renesas,rcar-gen2-thermal  # With thermal-zone
>
>       - items:
>           - enum:
>               - renesas,thermal-r8a774c0      # RZ/G2E
>               - renesas,thermal-r8a77970      # R-Car V3M
>               - renesas,thermal-r8a77990      # R-Car E3
>               - renesas,thermal-r8a77995      # R-Car D3

Perhaps we should (try to) get rid of the "Without thermal-zone" legacy?
All R-Car Gen2 DTSes received thermal zones a while ago.
R-Mobile APE6 and R-Car H1 still don't have them described, though.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
