Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBDC042656A
	for <lists+linux-pm@lfdr.de>; Fri,  8 Oct 2021 09:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbhJHHwM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Oct 2021 03:52:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:53870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229839AbhJHHwL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 8 Oct 2021 03:52:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36BFD61029;
        Fri,  8 Oct 2021 07:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633679416;
        bh=5Dnw1Sn92vfiwdKQwnNNnTDwu84Q7fYoJ44GzEToAbA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j+kPdrGm20cz+1Vp/TJ/jOwyJ5S0DWWrF6Xvw2vjv5AH5VPE+jGzT5kIOfW9FCu7p
         1iMaMAC8xxLHk0vZfdjPDmyOqV4i43BgLm+Jz76UlO+TMl8JYKhIjGtCLuaV976TRQ
         /3uLqYeOUUtUS1g0ekylMZYOq/oYgYQhYZsE3dYSfDgyAdJ/d4vi5N+Qdiv6A5sY+z
         mOjGp6+NKWKO5dPqT0Nu0VjjeYc+Ry9juu+1c1PoNTAFlCDnkxHCpDG/ezkWavozKj
         oGGnTun4HSl7MhKgwqj1LhA6Orf3mCgpeCLfTCNVHMLJ1eQ466akH9c9Vi3PtAfWFf
         OEn3tmOhIm5iA==
Received: by mail-pj1-f44.google.com with SMTP id q7-20020a17090a2e0700b001a01027dd88so5380245pjd.1;
        Fri, 08 Oct 2021 00:50:16 -0700 (PDT)
X-Gm-Message-State: AOAM5319p8Dh5mCN6dljT4BMy6hn7jiXnHBNlE9nN+qYqCtYvwRE0/Sz
        GUJVQvWmBZJjurtgbRaP6142wy4vCZVcSkUyYAA=
X-Google-Smtp-Source: ABdhPJwJJdHSMEVTR8H83olSVUxlwjiGbt5wjQLfT8kTPM/V6x19UEn+nSFiRarZ7i5SjGmfdmZxAa28ARGqAhsUBL8=
X-Received: by 2002:a17:902:a3c1:b0:13a:47a:1c5a with SMTP id
 q1-20020a170902a3c100b0013a047a1c5amr8199445plb.13.1633679415867; Fri, 08 Oct
 2021 00:50:15 -0700 (PDT)
MIME-Version: 1.0
References: <20211005155923.173399-1-marcan@marcan.st> <20211005155923.173399-3-marcan@marcan.st>
 <CAL_JsqJenHAOw4gApzGpuj-8nZjkYhmBg0qBj-DV+CEJ7zXuVw@mail.gmail.com>
 <f95f6d61-8809-e668-0458-453a8dfbe641@marcan.st> <b5b25e17-d98b-d447-f917-4d728f52a6ff@marcan.st>
In-Reply-To: <b5b25e17-d98b-d447-f917-4d728f52a6ff@marcan.st>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 8 Oct 2021 09:50:03 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfp7oMJ+moizqgXyS7LbPajY-_vbXFX6+5PFrcpUFy2nA@mail.gmail.com>
Message-ID: <CAJKOXPfp7oMJ+moizqgXyS7LbPajY-_vbXFX6+5PFrcpUFy2nA@mail.gmail.com>
Subject: Re: [PATCH 2/7] dt-bindings: power: Add apple,pmgr-pwrstate binding
To:     Hector Martin <marcan@marcan.st>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 6 Oct 2021 at 17:56, Hector Martin <marcan@marcan.st> wrote:
>
> On 07/10/2021 00.52, Hector Martin wrote:
> > I realize this is all kind of "not the way things are usually done", but
> > I don't want to pass up on the opportunity to have one driver last us
> > multiple SoCs if we have the chance, and it's looking like it should :-)
>
> Addendum: just found some prior art for this. See power/pd-samsung.yaml,
> which is another single-PD binding (though in that case they put them in
> the SoC node directly, not under a syscon).

Maybe the design is actually similar. In the Exynos there is a entire
subblock managing power - called Power Management Unit (PMU). It
controls most of power-related parts, except clock gating. For example
it covers registers related to entering deep-sleep modes or power
domains. However we split this into two:
1. Actual PMU driver which controls system-level power (and provides
syscon for other drivers needing to poke its registers... eh, life).
2. Power domain driver which binds multiple devices to a small address
spaces (three registers) inside PMU address space.

The address spaces above overlap, so the (1) PMU driver takes for
example 1004_0000 - 1004_5000 and power domain devices bind to e.g.
1004_4000, 1004_4020, 1004_4040.

Best regards,
Krzysztof
