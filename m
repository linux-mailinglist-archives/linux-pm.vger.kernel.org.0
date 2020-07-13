Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0CB21E103
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 21:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgGMTy1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 15:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgGMTy1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 15:54:27 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082BEC061755;
        Mon, 13 Jul 2020 12:54:27 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id 133so7015407ybu.7;
        Mon, 13 Jul 2020 12:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n7fVXyMfmMbpRMdN/Ppent0Q7nDIjWqcj5/R6D4oNfY=;
        b=NhFShpYCTV/2vMelS9zcmSNM7ZRhAT0VVjCKppdD9xqFAIYa3Lcwl9Qky4VXnRG210
         h07x6I+IfZuuJHuIt8q79c7BhdMXCNDspFGDlgzfZDJNgNcK/j2QvpJo78cxDx8vWJW4
         RnkzvI391Yh9E57TGG1raBJhwd8/l+fUGSME2Abwle5l93VLtOfZmWczHqOLUMKJWMHB
         yGm0D6lQ0y0kZvEgqUm6p8c/Sx0K6LWNr3ovQOnUjF3940CRNrxVhApA0ItzVvqvlQ/U
         4H4foJc7sLCZRC4N48d2tjjeEp8NdD51UQnejzBcsJqv70M8No4Vs3mlgqCKigo0PnAg
         9Xmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n7fVXyMfmMbpRMdN/Ppent0Q7nDIjWqcj5/R6D4oNfY=;
        b=fm25CsNg9QZwPqG4rWeim2CLmmXWTcXgp5bYfDH4LcFz4vLpjiQB7FO3JcKBmAshxk
         NqEsQwV89fX+97OArfNz6zlZz5R+zNO4cJQAO+g/tcAjLbSLy/mZgN+42VbSubytDgwa
         /DTfpJMCSJWn4jckWdQroRDYPU5rz3f9O6CX4ZMCMbtRnJsot++ciIynW052x/S7zFed
         bSpsSNlvRKznVqsTuRUfCn3uy+jl5rNLsh6CNZmIA7BCvVYqL6g+O9B/+tap3CGKHscf
         ePHrp4P5Ps7qjlcSFY8NEmO3quNozj2IRGDv4jUymiv3Qjl1yU4mpKc0oGnO2d75RpIG
         BZhQ==
X-Gm-Message-State: AOAM533XD1j4MvIsbI4BoD2jVplr90WLpg/Tgx63STd9VMiye/vcjV3E
        l1Px+npMEw/FhVydACC3J1VaaDYTfWDpvAPwpRNFwauf
X-Google-Smtp-Source: ABdhPJxP8LaiQhqa20ATAHUxpbBHwiIqAVEO8wluGBxFaOJUVZYzDRIOEocus+eUotwuCqWu5Rkk6xsHNthmTWC3Sv8=
X-Received: by 2002:a25:9c06:: with SMTP id c6mr2598745ybo.403.1594670066273;
 Mon, 13 Jul 2020 12:54:26 -0700 (PDT)
MIME-Version: 1.0
References: <2774047.62mrzoXREp@tool> <20200713183635.GA503416@bogus>
In-Reply-To: <20200713183635.GA503416@bogus>
From:   =?UTF-8?Q?Daniel_Gonz=C3=A1lez_Cabanelas?= <dgcbueu@gmail.com>
Date:   Mon, 13 Jul 2020 21:54:15 +0200
Message-ID: <CABwr4_s-x+0h3jM4C7o3s39n=p2ue5fXJ+KQ1Zq31E_jfOZEkQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: power: reset: add yaml bindings for
 LinkStation power off
To:     Rob Herring <robh@kernel.org>
Cc:     linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rob,

El lun., 13 jul. 2020 a las 20:36, Rob Herring (<robh@kernel.org>) escribi=
=C3=B3:
>
> On Sat, Jun 13, 2020 at 12:26:56PM +0200, Daniel Gonz=C3=A1lez Cabanelas =
wrote:
> > Add Linkstation poweroff bindings documentation.
> >
> > Signed-off-by: Daniel Gonz=C3=A1lez Cabanelas <dgcbueu@gmail.com>
> > ---
> > Changes in v3:
> >   - "phy-handle,intn" property deleted. Now autodetection used.
> >   - Cosmetic changes
> > Changes in v2:
> >   - Changed the required properties and description to adjust to the ne=
w
> >     driver now enabling the WoL feature on the device.
> >
> >  .../power/reset/linkstation-poweroff.yaml     | 35 +++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/reset/links=
tation-poweroff.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/power/reset/linkstation-=
poweroff.yaml b/Documentation/devicetree/bindings/power/reset/linkstation-p=
oweroff.yaml
> > new file mode 100644
> > index 0000000000..8845333ca4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/reset/linkstation-powerof=
f.yaml
> > @@ -0,0 +1,35 @@
> > +# SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause)
>
> As I said before:
>
> GPL-2.0-only
Sorry, it was a copy paste error.

>
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/power/reset/linkstation-poweroff.ya=
ml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Buffalo Linkstation poweroff Binding
> > +
> > +maintainers:
> > +  - Daniel Gonz=C3=A1lez Cabanelas <dgcbueu@gmail.com>
> > +
> > +description: |
> > +  Some Buffalo LinkStations (ARM MVEBU boards) use an output pin at th=
e ethernet
> > +  PHY (LED2/INTn) to inform the board if the power off operation must =
be performed
> > +  at restart time. This pin is ORed with the power switch and allows t=
he WOL
> > +  function to be also used.
> > +
> > +  When the power-off handler is called, the ethernet PHY INTn ouptut i=
s set to
> > +  LOW state. If the restart command is executed then the PHY INTn outp=
ut is
> > +  forced to HIGH state.
> > +
> > +properties:
> > +  compatible:
> > +    const: linkstation,power-off
> > +
> > +required:
> > +  - compatible
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    poweroff {
> > +        compatible =3D "linkstation,power-off";
> > +    };
>
> This is not what I was suggesting in the last version. You don't need a
> binding for this. Use the root node compatible string.
>
Then I don't need any binding?, and therefore if I understood
correctly this patch isn't required.

> Your driver initcall needs to check the root compatible and create a
> platform device if it matches.

Are you suggesting to validate the driver only for one specific device?

BTW the driver was already checked by Sebastian Reichel and nothing
wrong was found.

Regards
Daniel

>
> Rob
