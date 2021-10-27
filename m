Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F8043CC9D
	for <lists+linux-pm@lfdr.de>; Wed, 27 Oct 2021 16:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhJ0Oqs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Oct 2021 10:46:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:52014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229447AbhJ0Oqr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 27 Oct 2021 10:46:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E01E660F21;
        Wed, 27 Oct 2021 14:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635345862;
        bh=QkaH8i/IP3CIgA/bCVNmnPGWHjIMocsRPHDcPlLjhtw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QBDnQxRc9qXNWz75JROWosZmxmOsmsNEGEaXVE8jUNBYf26QeTA7w36x4CegZq8kX
         3e0PmaUOkOTztgiWGxzYGAYj/nSNZWmPMxeDvJRNfNSw0oxD/r3iFzJByDP+KnpeA+
         iBAnX/vQA3SFskmA1l5OjwZPDJbZBvNjJN0YHq72gfOzoSwt9XZ5vlOJPTMfM0IegE
         cbA7g5Xfx6sZ9kfI7gPh6dqbVEZecZBvFkOg7WBqTT4QChasCZfq81728KLS0xm/Ed
         Nrt8BvohV87fehXxiTjwR+b/GjrRbPnP9ZNdVjNThODvjzLr3955aWuISrUCK8eID2
         tVaxKUDb4Lv+A==
Received: by mail-ed1-f45.google.com with SMTP id m17so10848442edc.12;
        Wed, 27 Oct 2021 07:44:21 -0700 (PDT)
X-Gm-Message-State: AOAM530DRu/A9tEkI609X7JWG0CyjPzvoxt8ZJNdZQoxuJasO69pvzmv
        zHHlxGONvQBJAkSvn5+aeXdqNIr8J6zNWxr4eQ==
X-Google-Smtp-Source: ABdhPJzZb8un3hSlLPdikzo4LyAdNxP2rheUbz80i2Mi4iVmyOfTj91TmAOW+jBpNU7/41eeL8Fqjsu/ZlGUzLGLsIQ=
X-Received: by 2002:a17:906:6a0a:: with SMTP id qw10mr23065885ejc.466.1635345846542;
 Wed, 27 Oct 2021 07:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <20211025144718.157794-1-marcan@marcan.st> <20211025144718.157794-3-marcan@marcan.st>
 <YXhINE00HG6hbQI4@robh.at.kernel.org> <c0f2587c-ab69-8194-e618-ce7919c1aeb1@marcan.st>
In-Reply-To: <c0f2587c-ab69-8194-e618-ce7919c1aeb1@marcan.st>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 27 Oct 2021 09:43:54 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJbVcqy8n0EroV=nFZoJ_WAr+JbrDf-c1jso856NghC2A@mail.gmail.com>
Message-ID: <CAL_JsqJbVcqy8n0EroV=nFZoJ_WAr+JbrDf-c1jso856NghC2A@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] dt-bindings: arm: apple: Add apple,pmgr binding
To:     Hector Martin <marcan@marcan.st>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Mark Kettenis <kettenis@openbsd.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 26, 2021 at 10:38 PM Hector Martin <marcan@marcan.st> wrote:
>
> On 27/10/2021 03.25, Rob Herring wrote:
> > On Mon, Oct 25, 2021 at 11:47:12PM +0900, Hector Martin wrote:
> >> +  compatible:
> >> +    items:
> >> +      - enum:
> >> +          - apple,t8103-pmgr
> >> +          - apple,t8103-minipmgr
> >> +      - const: apple,pmgr
> >> +      - const: syscon
> >> +      - const: simple-mfd
> >
> >
> > 'simple-mfd' means 'there's nothing in this node that any of the child
> > nodes depend on'. You should be somewhat certain as dropping it later
> > creates compatibility issues.
>
> Hmm, I see simple-mfd turns this into a bus which I guess allows child
> nodes to be probed without the parent node doing anything special (then
> we use syscon_node_to_regmap to get the syscon instantiated). Do you
> have a example use case for doing this without simple-mfd?

Drivers calling of_platform_populate or devm_of_platform_populate.

That of course does mean you need a driver. We could probably make the
syscon driver call these if needed.

> At this point I can't think of anything we'd need from the parent node,
> especially if we end up using this syscon strictly for pwrstate subnodes
> (which seems likely at this point). One thing that comes to mind is
> telling the PMP (a coprocessor in charge of power metrics/management)
> about some domains being turned on/off, which is apparently a thing, but
> that wouldn't even be in this node; that'd have to be a phandle property
> in the child nodes referencing a PMP/coprocessor node elsewhere (none of
> which is implemented right now, and which should be backwards compatible
> once it is).
>
> If it turns out we do have a dep of some sort in the end, could we just
> have the child node driver return -EPROBE_DEFER until the parent is
> probed and has made whatever service available? That would allow us to
> keep simple-mfd, right?

That would have saved you, but deferred probe is now a fallback to
fw_devlink and it makes sure parent driver probes first. That works
unless there isn't a parent driver which is often the case for
simple-bus[1]. I think you are okay since 'syscon' means there is a
driver.

> If it works for you, I'll also just squash the two bindings into one
> commit for the next spin, since there is a direct dependency at this
> point and it should make things easier. Otherwise, I can just swap the
> order if you prefer it that way.

Just swapping seems like less work, but either way.

Rob

[1] https://lore.kernel.org/all/CAL_JsqJcsqjJBe8aULYYMkFtx8OTj2wHANZ=83VMMyJ=AEgReg@mail.gmail.com/
