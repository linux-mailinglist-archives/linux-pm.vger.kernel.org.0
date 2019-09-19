Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB0ECB740C
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 09:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732034AbfISH2c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 03:28:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:41150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728850AbfISH2b (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Sep 2019 03:28:31 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35E3121A49;
        Thu, 19 Sep 2019 07:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568878110;
        bh=4pZybG6ie1wq7kPEzXnAIhWrkHP0YAIy7EvNqXIs0nk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Hpi/Z6J0YAAbOxVs8ZaWgVSCqvrnR8B7P+/GUdLyupwWwixlPgAcGD61FvCiaJp8C
         al+551ZPFPd3WOzm1y60AcTOlN8g0hc+qUf41kMC2I+ez+w5cUzQJhwDK2kKA3L993
         YZahqK7xDgB73pcopGFoZRnJm9SuxVvlD7F/bxOA=
Received: by mail-oi1-f182.google.com with SMTP id w6so1832859oie.11;
        Thu, 19 Sep 2019 00:28:30 -0700 (PDT)
X-Gm-Message-State: APjAAAVGMTNa52RjONtZZXyXp0fHnuYltVR83OxsBDG2TwOWhqcfNYRf
        JMiUck6PtypxEMyQyI76VTK4LhKhbMmpuDorg8s=
X-Google-Smtp-Source: APXvYqxcWCabkIkAYweLFABw3mTwh5ueZcYmaLJriDnmtFR+Tcfb38WjBVsL3eNPszwXlF4vNOXyKPu8g8TjuXaQDIc=
X-Received: by 2002:aca:cf51:: with SMTP id f78mr1302933oig.8.1568878109494;
 Thu, 19 Sep 2019 00:28:29 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190916100719eucas1p206fe95982b774840b5d6e62ba9c42c79@eucas1p2.samsung.com>
 <20190916100704.26692-1-l.luba@partner.samsung.com> <20190916100704.26692-4-l.luba@partner.samsung.com>
 <CAJKOXPcxG-mMKy5u-b0+xj_sOmrq5yq5-LYJx0Ds6_+yo_=JbA@mail.gmail.com> <4a0d1d2c-cd1d-5df4-d4b1-f2dd1ef3bb72@partner.samsung.com>
In-Reply-To: <4a0d1d2c-cd1d-5df4-d4b1-f2dd1ef3bb72@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 19 Sep 2019 09:28:18 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfBueaf2UVik8x2L_D_PTxdkvRukuWL3xh_jDiLKtt7pQ@mail.gmail.com>
Message-ID: <CAJKOXPfBueaf2UVik8x2L_D_PTxdkvRukuWL3xh_jDiLKtt7pQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: ddr: Add bindings for Samsung LPDDR3 memories
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        willy.mh.wolff.ml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 19 Sep 2019 at 08:49, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> Hi Krzysztof,
>
> On 9/18/19 8:51 PM, Krzysztof Kozlowski wrote:
> > On Mon, 16 Sep 2019 at 12:07, Lukasz Luba <l.luba@partner.samsung.com> wrote:
> >>
> >> Add compatible for Samsung k3qf2f20db LPDDR3 memory bindings.
> >> Introduce minor fixes in the old documentation.
> >>
> >> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> >> ---
> >>   Documentation/devicetree/bindings/ddr/lpddr3.txt | 9 ++++++---
> >>   1 file changed, 6 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/ddr/lpddr3.txt b/Documentation/devicetree/bindings/ddr/lpddr3.txt
> >> index 3b2485b84b3f..49afe794daaa 100644
> >> --- a/Documentation/devicetree/bindings/ddr/lpddr3.txt
> >> +++ b/Documentation/devicetree/bindings/ddr/lpddr3.txt
> >> @@ -1,7 +1,9 @@
> >>   * LPDDR3 SDRAM memories compliant to JEDEC JESD209-3C
> >>
> >>   Required properties:
> >> -- compatible : Should be  - "jedec,lpddr3"
> >> +- compatible : should be one of the following:
> >> +       Generic default - "jedec,lpddr3".
> >
> > The convention is first compatible, then description. I gave you the
> > example to base on - at25. Why making it different?
>
> I have checked at25 that you pointed me to and also checked at24, which
> has a bit longer "compatible" section.
>
> I found that there are many "jedec,spi-nor" compatible devices, which I
> thought would be a better example for my "jedec,lpddr3".
> For example, two configurations, where you have a single labels or dual
> (with specific device)
> arch/arm/boot/dts/imx6dl-rex-basic.dts:
> compatible = "sst,sst25vf016b", "jedec,spi-nor";
> arch/arm/boot/dts/imx6q-ba16.dtsi:
> compatible = "jedec,spi-nor";
>
> The 'compatible' in documentation for the "jedec,spi-nor" is slightly
> different (similar to at24).
> Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
> It has a long explanation, which is also OK. So I thought that it is
> quite flexible what you put in there.

It is flexible but I see clear pattern in existing sources:
  jedec,spi-nor.txt
  compatible : May include a device-specific ..
  ...
  Supported chip names:
    at25df321a
    ...

  at25.txt:
  - compatible : Should be "<vendor>,<type>", and generic value "atmel,at25".
    Example "<vendor>,<type>" values:
      "anvo,anv32e61w"
      "microchip,25lc040"

In these cases the doc says that "compatible should be" and then you
have the list of values. Your example says that the compatible should
be "Generic default" or "For Samsung 542x SoC"... :) The difference is
slight but putting the value first is a simple and elegant solution.
In your case one has to go to the end of sentence to find the most
important information - the compatible value.

> I have also checked Cadance QSPI controller.
> Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
> The controller might be built-in into different vendor SoC's
> and the "compatible" is ready to reflect it in similar fashion but
> with a short explanation in this section.

I see. I do not find this pattern as much readable as jedec-spi-nor or
at25 therefore I mentioned them as an example to base on ("Exactly the
same as AT24 or AT25 EEPROM bindings."). We can avoid also this entire
discussion with YAML (which also follows approach of at25 - value
first).

> Therefore, what you see in the patch draw heavily on Cadence's qspi,
> with a bit of inspiration from jedec,spi-nor usage.
>
> Should I change it to at25 "compatible" style and send next patch?

Yes, please. Or go to YAML and make entire discussion obsolete.

Best regards,
Krzysztof
