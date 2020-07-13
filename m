Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D971E21E126
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 22:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgGMUHf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 16:07:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:54114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbgGMUHf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Jul 2020 16:07:35 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B71B20674;
        Mon, 13 Jul 2020 20:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594670854;
        bh=el2TSaA51OBPVLkDDeD8yCGwUzxK15hdRdqHbPo0Gd4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LXzVDn5pkKS0An517v/7JENO250tcmsnGlzb86UWhSRrfQCXjstLe17mYI7qOm5yu
         cgflia2veWjOVbMXxLZlCjgAb7PBslOGFJkeBXhlf9IyonWBxCFWW2p2Q20RwZJ77R
         yOLnMU99wX7+r2gzPKt5D/GGh+y/XDzxL9u6DiGc=
Received: by mail-oi1-f172.google.com with SMTP id j11so12013356oiw.12;
        Mon, 13 Jul 2020 13:07:34 -0700 (PDT)
X-Gm-Message-State: AOAM533sGX6ZzwVMVTRjFpl9iCvOPag3ljbhQxSYN9NBKGSO6U2qzHqr
        PVRid7sRat1Kyu0hGYz8oamsmAhij0kZJ07SQw==
X-Google-Smtp-Source: ABdhPJzUtGDD0HwNcn/1+pNFN3WYRAm3lG5CxSfwC3x1ErEV4o5K6cU2yEixZOuco3cq9VWpgL8u6672rK/xNRyTSDQ=
X-Received: by 2002:aca:30d2:: with SMTP id w201mr963673oiw.147.1594670853845;
 Mon, 13 Jul 2020 13:07:33 -0700 (PDT)
MIME-Version: 1.0
References: <2774047.62mrzoXREp@tool> <20200713183635.GA503416@bogus> <CABwr4_s-x+0h3jM4C7o3s39n=p2ue5fXJ+KQ1Zq31E_jfOZEkQ@mail.gmail.com>
In-Reply-To: <CABwr4_s-x+0h3jM4C7o3s39n=p2ue5fXJ+KQ1Zq31E_jfOZEkQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 13 Jul 2020 14:07:22 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKfmS32hmtR_txmkMR64+XOqGC6UTR-9h3BjuX2Jk4ASg@mail.gmail.com>
Message-ID: <CAL_JsqKfmS32hmtR_txmkMR64+XOqGC6UTR-9h3BjuX2Jk4ASg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: power: reset: add yaml bindings for
 LinkStation power off
To:     =?UTF-8?Q?Daniel_Gonz=C3=A1lez_Cabanelas?= <dgcbueu@gmail.com>
Cc:     "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 13, 2020 at 1:54 PM Daniel Gonz=C3=A1lez Cabanelas
<dgcbueu@gmail.com> wrote:
>
> Hi Rob,
>
> El lun., 13 jul. 2020 a las 20:36, Rob Herring (<robh@kernel.org>) escrib=
i=C3=B3:
> >
> > On Sat, Jun 13, 2020 at 12:26:56PM +0200, Daniel Gonz=C3=A1lez Cabanela=
s wrote:
> > > Add Linkstation poweroff bindings documentation.
> > >
> > > Signed-off-by: Daniel Gonz=C3=A1lez Cabanelas <dgcbueu@gmail.com>
> > > ---
> > > Changes in v3:
> > >   - "phy-handle,intn" property deleted. Now autodetection used.
> > >   - Cosmetic changes
> > > Changes in v2:
> > >   - Changed the required properties and description to adjust to the =
new
> > >     driver now enabling the WoL feature on the device.
> > >
> > >  .../power/reset/linkstation-poweroff.yaml     | 35 +++++++++++++++++=
++
> > >  1 file changed, 35 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/power/reset/lin=
kstation-poweroff.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/power/reset/linkstatio=
n-poweroff.yaml b/Documentation/devicetree/bindings/power/reset/linkstation=
-poweroff.yaml
> > > new file mode 100644
> > > index 0000000000..8845333ca4
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/power/reset/linkstation-power=
off.yaml
> > > @@ -0,0 +1,35 @@
> > > +# SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause)
> >
> > As I said before:
> >
> > GPL-2.0-only
> Sorry, it was a copy paste error.
>
> >
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/power/reset/linkstation-poweroff.=
yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Buffalo Linkstation poweroff Binding
> > > +
> > > +maintainers:
> > > +  - Daniel Gonz=C3=A1lez Cabanelas <dgcbueu@gmail.com>
> > > +
> > > +description: |
> > > +  Some Buffalo LinkStations (ARM MVEBU boards) use an output pin at =
the ethernet
> > > +  PHY (LED2/INTn) to inform the board if the power off operation mus=
t be performed
> > > +  at restart time. This pin is ORed with the power switch and allows=
 the WOL
> > > +  function to be also used.
> > > +
> > > +  When the power-off handler is called, the ethernet PHY INTn ouptut=
 is set to
> > > +  LOW state. If the restart command is executed then the PHY INTn ou=
tput is
> > > +  forced to HIGH state.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: linkstation,power-off
> > > +
> > > +required:
> > > +  - compatible
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    poweroff {
> > > +        compatible =3D "linkstation,power-off";
> > > +    };
> >
> > This is not what I was suggesting in the last version. You don't need a
> > binding for this. Use the root node compatible string.
> >
> Then I don't need any binding?, and therefore if I understood
> correctly this patch isn't required.

Right.

> > Your driver initcall needs to check the root compatible and create a
> > platform device if it matches.
>
> Are you suggesting to validate the driver only for one specific device?

No, you can have a match table with as many entries as you need.

> BTW the driver was already checked by Sebastian Reichel and nothing
> wrong was found.
>
> Regards
> Daniel
>
> >
> > Rob
