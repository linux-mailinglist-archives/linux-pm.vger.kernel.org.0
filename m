Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0086243CCC0
	for <lists+linux-pm@lfdr.de>; Wed, 27 Oct 2021 16:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236668AbhJ0Oye (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Oct 2021 10:54:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233522AbhJ0Oyd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 27 Oct 2021 10:54:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1643260F9B;
        Wed, 27 Oct 2021 14:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635346328;
        bh=jCF7zHosdvzzC3lK9XpQpm6nByjYxKG8ydJZgwi1wco=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=O6ahoHt2O+AEoJfwdvKe3gL8uEyj5ijIr7l1ydbt4ERVOJm8wFkIi5syTc6qFMIP0
         loIrPzC7lAzNjNwXWODmTZx/4zNI9Dv24RbmyTCG4VbqO93IwcM607M3A3v9Negzck
         NqxFDxeqRVMci/65trYn68BPryHtPycJ8kFUpa76pKmH+SKA7YyO1fs66+Fs25OMCe
         ZXbc4ODQ3EqdOvIp66M1+TzsA5hsOtU/RuPwpqFw7O5w+nG0kTk2v8SRJGji1jS7sQ
         sUulN27H8C9pdPRDuznqr8R+IwZRkbTUmHS1VyVmiBjKXh0OcTl0cyUvTSfte6efiM
         IyLGyfhVK4DZg==
Received: by mail-pl1-f182.google.com with SMTP id t21so2169915plr.6;
        Wed, 27 Oct 2021 07:52:08 -0700 (PDT)
X-Gm-Message-State: AOAM530bk9da1SDeQjGkS+DJ8JaTcviAT5MedWZdAU5wXHVEPRpobVlM
        vW8GMa01zWljThk5UwUmgE8K31gPTWXFR9T6sUc=
X-Google-Smtp-Source: ABdhPJyR9QS5NFHNCKidSwQc01bWPNUjQpXYWQZE5lYJBuHqjoD2gS8qKMmvGbUYMzRhRQ5V7HBAJ5A261AtA79TRC4=
X-Received: by 2002:a17:902:d508:b0:140:42ce:c7b1 with SMTP id
 b8-20020a170902d50800b0014042cec7b1mr21910801plg.89.1635346327562; Wed, 27
 Oct 2021 07:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <20211025144718.157794-1-marcan@marcan.st> <20211025144718.157794-3-marcan@marcan.st>
 <YXhINE00HG6hbQI4@robh.at.kernel.org> <c0f2587c-ab69-8194-e618-ce7919c1aeb1@marcan.st>
 <CAL_JsqJbVcqy8n0EroV=nFZoJ_WAr+JbrDf-c1jso856NghC2A@mail.gmail.com>
In-Reply-To: <CAL_JsqJbVcqy8n0EroV=nFZoJ_WAr+JbrDf-c1jso856NghC2A@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 27 Oct 2021 16:51:56 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfDAnECHzGDTisuujT-rGvUqVp4a5WTOQ196yTqwLKHuA@mail.gmail.com>
Message-ID: <CAJKOXPfDAnECHzGDTisuujT-rGvUqVp4a5WTOQ196yTqwLKHuA@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] dt-bindings: arm: apple: Add apple,pmgr binding
To:     Hector Martin <marcan@marcan.st>
Cc:     Rob Herring <robh@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
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

On Wed, 27 Oct 2021 at 16:44, Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Oct 26, 2021 at 10:38 PM Hector Martin <marcan@marcan.st> wrote:
> >
> > On 27/10/2021 03.25, Rob Herring wrote:
> > > On Mon, Oct 25, 2021 at 11:47:12PM +0900, Hector Martin wrote:
> > >> +  compatible:
> > >> +    items:
> > >> +      - enum:
> > >> +          - apple,t8103-pmgr
> > >> +          - apple,t8103-minipmgr
> > >> +      - const: apple,pmgr
> > >> +      - const: syscon
> > >> +      - const: simple-mfd
> > >
> > >
> > > 'simple-mfd' means 'there's nothing in this node that any of the child
> > > nodes depend on'. You should be somewhat certain as dropping it later
> > > creates compatibility issues.
> >
> > Hmm, I see simple-mfd turns this into a bus which I guess allows child
> > nodes to be probed without the parent node doing anything special (then
> > we use syscon_node_to_regmap to get the syscon instantiated). Do you
> > have a example use case for doing this without simple-mfd?
>
> Drivers calling of_platform_populate or devm_of_platform_populate.
>
> That of course does mean you need a driver. We could probably make the
> syscon driver call these if needed.
>

Hi Hector,

I thought I mentioned this with your v1, maybe the comment got lost.
We have it for Exynos PMU:
drivers/soc/samsung/exynos-pmu.c
arch/arm/boot/dts/exynos-syscon-restart.dtsi (extending node from
arch/arm/boot/dts/exynos5420.dtsi)
Maybe you can base on that.

Best regards,
Krzysztof
