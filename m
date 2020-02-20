Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 155EE166835
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 21:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgBTUSb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 15:18:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:53028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728926AbgBTUSa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 20 Feb 2020 15:18:30 -0500
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59E40207FD;
        Thu, 20 Feb 2020 20:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582229909;
        bh=s1/TPUdBApa71vaEJPTwTeeRDZqGyvtTwEBOQX2mj6c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Tl2/KuwzcdwvHwEuHhtPEOrVLMq2fv4e3n6xy+CMbn1J/2WjlMaTRKfSIvEc1Cuh/
         tSfoDvNuvmF7mUPOhM8yiuf6MKCet2yX9osYL9U1yynDTUntBnG1Dkt5IlT1jorlrA
         3/1PWnxFFWe+mwojrAI4urjXm2E2z/CwSTqmH3lc=
Received: by mail-qk1-f182.google.com with SMTP id c188so4845291qkg.4;
        Thu, 20 Feb 2020 12:18:29 -0800 (PST)
X-Gm-Message-State: APjAAAUCkKIzgrP8fdTn9EFoosv1RdjekUkRu1w9RdHGX3jvL+kJDMi1
        qPwlznTylb7H1C3oQKeI1YJvydwfet4PTP0WVw==
X-Google-Smtp-Source: APXvYqxypaIMUuCJA4zkqasOIffScqM+2gfXBCIGVlOvEh0RIy4M77g7dlLGgQzkHsLVhgfZKlhkyp1Eh8QF21M0QbA=
X-Received: by 2002:a05:620a:1237:: with SMTP id v23mr13600919qkj.223.1582229908428;
 Thu, 20 Feb 2020 12:18:28 -0800 (PST)
MIME-Version: 1.0
References: <cover.1581597365.git.matti.vaittinen@fi.rohmeurope.com>
 <104b5ef63c2ad4771503d9e6618bf427721042c3.1581597365.git.matti.vaittinen@fi.rohmeurope.com>
 <20200218202122.GA599@bogus> <1da3415507c216d09eb72c30ad915bc139d2ff3d.camel@fi.rohmeurope.com>
In-Reply-To: <1da3415507c216d09eb72c30ad915bc139d2ff3d.camel@fi.rohmeurope.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 20 Feb 2020 14:18:17 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+x+5RCT0L5HGocdSOuve2qm5JvqSYXAwDbJ4qP9wr9TA@mail.gmail.com>
Message-ID: <CAL_Jsq+x+5RCT0L5HGocdSOuve2qm5JvqSYXAwDbJ4qP9wr9TA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/5] dt_bindings: ROHM BD99954 Charger
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>,
        "sre@kernel.org" <sre@kernel.org>,
        "Laine, Markus" <Markus.Laine@fi.rohmeurope.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Feb 19, 2020 at 2:05 AM Vaittinen, Matti
<Matti.Vaittinen@fi.rohmeurope.com> wrote:
>
> Morning Rob,
>
> On Tue, 2020-02-18 at 14:21 -0600, Rob Herring wrote:
> > On Fri, 14 Feb 2020 09:36:47 +0200, Matti Vaittinen wrote:
> > > The ROHM BD99954 is a Battery Management LSI for 1-4 cell Lithium-
> > > Ion
> > > secondary battery. Intended to be used in space-constraint
> > > equipment such
> > > as Low profile Notebook PC, Tablets and other applications. BD99954
> > > provides a Dual-source Battery Charger, two port BC1.2 detection
> > > and a
> > > Battery Monitor.
> > >
> > > Document the DT bindings for BD99954
> > >
> > > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > > ---
> > >
> > > It would probably be nice if the charger DT binding yaml could
> > > somehow
> > > be listing and evaluating properties that it can use from static
> > > battery
> > > nodes - and perhaps some warning could be emitted if unsupported
> > > properties are given from battery nodes(?) Just some thinking here.
> > > What if the charger ignores for example the current limits from
> > > battery
> > > node (I am not sure but I think a few may ignore) - I guess it
> > > would be
> > > nice to give a nudge to a person who added those properties in his
> > > DT
> > > if they won't have any impact? Any thoughts?
> > >
> > >  .../bindings/power/supply/rohm,bd9995x.yaml   | 167
> > > ++++++++++++++++++
> > >  1 file changed, 167 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/power/supply/rohm,bd9995x.yaml
> > >
> >
> > My bot found errors running 'make dt_binding_check' on your patch:
>
> Ouch ... sorry. There is some leftover block from another text based
> binding document which I used as an example while writing out the
> battery parameters BD99954 uses.
>
> There's two other hiccups when I try running make dt_binding_check. I
> assume they are false positives.
>
> <SIDE NOTE>
> Although... Back in my Nokia days I joined in a trainer-training. I had
> excellent British coach - Graham if I remember correctly - who told us
> never to assume. He explained where word ass-u-me comes from. I can
> still hear his very British accent: "It makes an ass out of u and me".
> I still do so though. I'm not learning easily it seems.
> </SIDE NOTE>
>
> 1. It seems to me the multipleOf: is not recognized. I guess it
> should(?) I will comment it out in v3 though until I get confirmation
> it should work.

Yes, it should work. I reworked allowed keywords recently. Is dtschema
up to date?

>
> 2. schema validation for:
>
>   rohm,vsys-regulation-microvolt:
>     description: system specific lower limit for system voltage.
>     minimum: 2560000
>     maximum: 19200000
>     #multipleOf: 64000
>
> fails. But when I change this to
>   rohm,vsys-regulation-microvolts: (plural)
> it seems to be passing the validation. A git grep under
> Documentation/devicetree/bindings reveals that both plural and singular
> are used - but the singular seems to be far more popular than plural.

Only in one case that got it wrong.

> It also looks like the 'core bindings' like regulators use singular.
> Hence I'll leave this to singular for v3 even though it fails the
> validation - please let me know if this was wrong choice or if you spot
> any other oddities there. I can't see what else it could be but for
> some reason I still find this yaml terribly hard :(
>
> Hmm.. I wonder if I have some old checker tools installed and used on
> my PC? I also get validation failures for the example schemas :/

You do have to stay up to date.

> > warning: no schema found in file:
> > Documentation/devicetree/bindings/power/supply/rohm,bd9995x.yaml
> > /builds/robherring/linux-dt-
> > review/Documentation/devicetree/bindings/power/supply/rohm,bd9995x.ya
> > ml: ignoring, error parsing file
> > Documentation/devicetree/bindings/display/simple-
> > framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root):
> > /example-0/chosen: chosen node must be at root node
> > Documentation/devicetree/bindings/power/supply/rohm,bd9995x.yaml:  wh
> > ile scanning a simple key
> >   in "<unicode string>", line 29, column 3
> > could not find expected ':'
> >   in "<unicode string>", line 30, column 1

Though this is just incorrect YAML and the tool version shouldn't matter.

Rob
