Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0BD83325EA
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 13:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhCIM5a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 07:57:30 -0500
Received: from mail-vs1-f49.google.com ([209.85.217.49]:42570 "EHLO
        mail-vs1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhCIM5J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Mar 2021 07:57:09 -0500
Received: by mail-vs1-f49.google.com with SMTP id v123so6708139vsv.9;
        Tue, 09 Mar 2021 04:57:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=px5BYZa22n9NMnXf16F73lQRxJVbRAsWmLe25Nhfm2w=;
        b=LAEc4gqKgaSggUIgWNPTd4rc0heuofE9qEuVFUb9pRI0NUjkK1I/LoffSORyhTG2z5
         omoK3rZSxKsYJQu31htXwJ+ny551tDPDqiRT285CUqKKkPXtPLlZtlBnQ/rPQqmMV2QR
         mhw9veos+aVd/c8rxOVd5YETHGfxI6nXwhuURiJdYKzjz9db/BISvvxRrsm5OYX5se/M
         8lVVOS4Nsf9oKgU13LaEiHlTC3kMhnYvEsYSLnj0HBt/LP3ifvXPqPCara6G7nln4hgy
         rVWVgB3WNYCMaawlEmo1/Rl7z4VrL5ttFdEHaMsRBg60q/i7M0T8ljQ6LJqJdmejYMNQ
         xonQ==
X-Gm-Message-State: AOAM533DqJF53D1UUBs4IyKl3nKIF/c5FLQ7r60fRkESKto11777bLxS
        3o/N3tlrNFS7WrIjylV2RiEE7bGFR4LCXtS7+C4=
X-Google-Smtp-Source: ABdhPJziJnda90WhLZPahYsKdMwM7ZR2lhFiK7H4I+V5Wa/keIAzAlTaNY+FaZDfzFzGTLm9KS7gnXVtC+5fVXkyon8=
X-Received: by 2002:a67:fe90:: with SMTP id b16mr16703554vsr.40.1615294628945;
 Tue, 09 Mar 2021 04:57:08 -0800 (PST)
MIME-Version: 1.0
References: <20210127132840.2019595-1-geert+renesas@glider.be> <20210209192041.GA4168680@robh.at.kernel.org>
In-Reply-To: <20210209192041.GA4168680@robh.at.kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 9 Mar 2021 13:56:57 +0100
Message-ID: <CAMuHMdW+LKEWiygOb40mGDuLBucyF-xLcBgreA=txivGmjzdig@mail.gmail.com>
Subject: Re: [PATCH] [RFC] dt-bindings: power: sysc-remobile: Convert to json-schema
To:     Rob Herring <robh@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rob,

On Tue, Feb 9, 2021 at 8:20 PM Rob Herring <robh@kernel.org> wrote:
> On Wed, Jan 27, 2021 at 02:28:40PM +0100, Geert Uytterhoeven wrote:
> > Convert the Renesas R-Mobile System Controller (SYSC) Device Tree
> > binding documentation to json-schema.
> >
> > Document missing properties.
> > Drop consumer example, as it does not belong here.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Marked RFC, as it does not check deeper levels than the first level of
> > the "pm-domains" subnode.
> >
> > I think the reference in
> >
> >     additionalProperties:
> >       $ref: "#/patternProperties"
> >
> > should become "#/patternProperties/0/additionalProperties", but that
> > gives:
> >
> >     Unresolvable JSON pointer: 'patternProperties/0/additionalProperties'
>
> AFAIK, numbers only work on lists (such as 'allOf' values). So I think
> you'd want '#/patternProperties/^pm-domains$/additionalProperties'.
> However, regex's can have illegal characters. I think URI escaping them
> would work, but that gets too readable and unmaintainable for my tastes.
> The other way to do this is put the schema under a '$defs'. But in your
> case, you have just a fixed string, so there's no need for it to be a
> pattern. Just move it to 'properties'.

Thank you, I've dropped the patternProperties/regex, and moved the
section to properties.

The result fails with:

    Documentation/devicetree/bindings/power/renesas,sysc-rmobile.example.dt.yaml:
system-controller@e6180000: pm-domains:c5:a4s@10: missing phandle tag
in {'reg': [[10]], '#address-cells': [[1]], '#size-cells': [[0]],
'#power-domain-cells': [[0]], 'a3sp@11': {'reg': [[11]],
'#power-domain-cells': [[0]]}}
    From schema:
Documentation/devicetree/bindings/power/renesas,sysc-rmobile.yaml
    Documentation/devicetree/bindings/power/renesas,sysc-rmobile.example.dt.yaml:
system-controller@e6180000: pm-domains:c5:a4su@20: missing phandle tag
in {'reg': [[20]], '#power-domain-cells': [[0]]}
    From schema:
Documentation/devicetree/bindings/power/renesas,sysc-rmobile.yaml

Looking at Documentation/devicetree/bindings/power/renesas,sysc-rmobile.example.dt.yaml
there's indeed no "phandle: [[0x1]]" generated, while there is in
Documentation/devicetree/bindings/power/renesas,rcar-sysc.example.dt.yaml.

Reading other responses from you, that error means that "phandle-array"
should be used instead of "phandle".  The only question is where?

Thanks again!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
