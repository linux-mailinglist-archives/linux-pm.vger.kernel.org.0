Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0088A29377D
	for <lists+linux-pm@lfdr.de>; Tue, 20 Oct 2020 11:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730231AbgJTJDM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Oct 2020 05:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730029AbgJTJDL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Oct 2020 05:03:11 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0004C061755;
        Tue, 20 Oct 2020 02:03:11 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id q136so1394354oic.8;
        Tue, 20 Oct 2020 02:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Gxiv9N5I/0koEZElvdg9/A3+iy5K5rnbjK1iEcbGa6w=;
        b=gTWnFQUcx4oDfYYGX7NhU5btKE6deZ7W4mcHkGsZIFyUVPZ7MXpEeIkXcqYCiVlHmt
         1UhX0gZV/uvWhQelB0tNQVz+6ZcUi1ij4LqZDydl3tNT5a0gsL9h3DL87WaMs/PlEJjW
         We8PdAIVl7tF+4vvN4f0PpjZ+V0zp84H7vY+k3BAH+eDyXN2AvL0OeO7539Mq9Upx9vj
         duA2ztsx9s0nLU5a1120UnRJ7eg57/gbcVCQFJhmNxkKIW72obHeaqP66d9e4BxN/S87
         +OA2YDPOxNQEelAr1Hq4KLj+SsyHVg6Fwdbi0sdbXonVsFbuZm3S2aUv81hUzz6jVdGh
         KcHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Gxiv9N5I/0koEZElvdg9/A3+iy5K5rnbjK1iEcbGa6w=;
        b=pI7lvuUXqMJ1crSXZlgI8IfVC+8QcmCFk9VTwOrVbDMnt7uuM2Nwehnqti4F5HGKnI
         RcwNZLAmS1mLonoXguljxi/apO1sOGkmw9iSaimvMRVHE6bEsXljzFb8FVOn3QLznVOA
         XDwXQM9uaMcLYzIod29MIcHaE2NSyryq2FT/TcjAXvUW8DHJY9ejFlgOZUaEhc0BLqDH
         JNSsvOZZ0x9vTHyDYSReb+BDzhcdALJ+YuclXSS4eC742veY7/DHyTjlQ+Ha7r5HjmVd
         4qDObvuUlKdxfNyHMqsLsxCm783bFgUTlg+0+J+5DqstsW4yAAmv29FT1nNuXQYBeUVW
         G14A==
X-Gm-Message-State: AOAM533qCTKp2vbCa0tjUi4/mBE27c+rbHeGcRHXr4SsCX2pFG/ZRIDC
        X2Q5+joRaW+jA9HMpKUOeng3zjY6k/L/vPR61No=
X-Google-Smtp-Source: ABdhPJyYU82Q33GbVTHqUDSRmku/z4g0TgkTPtIKZk+UhIWZK4qKLMOEI7kJfpP70jxfQ0fbewqrBHkXUx+/NmdItnw=
X-Received: by 2002:aca:7541:: with SMTP id q62mr1078293oic.51.1603184591254;
 Tue, 20 Oct 2020 02:03:11 -0700 (PDT)
MIME-Version: 1.0
References: <1600859910-15855-1-git-send-email-gene.chen.richtek@gmail.com> <20201016153823.GA9890@kozik-lap>
In-Reply-To: <20201016153823.GA9890@kozik-lap>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Tue, 20 Oct 2020 17:03:00 +0800
Message-ID: <CAE+NS35gb_KWq3s-M9apxgr7wnNRyn7iPto8J8ZwA-jsgT=paw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: power: Add bindings document for Charger
 support on MT6360 PMIC
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     sre@kernel.org, Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gene Chen <gene_chen@richtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Krzysztof Kozlowski <krzk@kernel.org> =E6=96=BC 2020=E5=B9=B410=E6=9C=8816=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8811:38=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> On Wed, Sep 23, 2020 at 07:18:29PM +0800, Gene Chen wrote:
> > From: Gene Chen <gene_chen@richtek.com>
> >
> > Add bindings document for Charger support on MT6360 PMIC
> >
> > Signed-off-by: Gene Chen <gene_chen@richtek.com>
> > ---
> >  .../bindings/power/supply/mt6360_charger.yaml      | 44 ++++++++++++++=
++++++++
> >  1 file changed, 44 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/supply/mt63=
60_charger.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/power/supply/mt6360_char=
ger.yaml b/Documentation/devicetree/bindings/power/supply/mt6360_charger.ya=
ml
> > new file mode 100644
> > index 0000000..711fc19
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/supply/mt6360_charger.yam=
l
> > @@ -0,0 +1,44 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/power/supply/mt6360_charger.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Battery charger driver for MT6360 PMIC from MediaTek Integrated=
.
> > +
> > +maintainers:
> > +  - Gene Chen <gene_chen@richtek.com>
> > +
> > +description: |
> > +  This module is part of the MT6360 MFD device.
> > +  Provides Battery Charger, Boost for OTG devices and BC1.2 detection.
> > +
> > +properties:
> > +  compatible:
> > +    const: mediatek,mt6360-chg
> > +
> > +  vinovp:
> > +    description:
> > +      Maximum CHGIN regulation voltage.
>
> 1. You need to describe the type.
> 2. Use proper unit suffix (see property-units.txt).
> 3. Is this a custom property? If yes, it misses vendor prefix. If not,
>    most likely there is already such property. Reuse.
>

ACK

> > +
> > +  usb-otg-vbus:
> > +      $ref: /schemas/regulator/regulator.yaml#
>
> 1. Wrong indentation.
> 2. Name should be more or less generic, so maybe
>    "usb-otg-vbus-regulator".
>

ACK

> > +
> > +required:
> > +  - compatible
>
> No address/reg? How does it bind?
>

This module is part of the MT6360 MFD device.
see Documentation/devicetree/bindings/mfd/mt6360.yaml, which is
reviewing by MFD reviewer.

Should I add this to description?

> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    mt6360_chg: chg {
>
> s/chg/charger/
>

ACK

> > +      compatible =3D "mediatek,mt6360-chg";
> > +      vinovp =3D <14500000>;
>
> Empty line break
>

ACK

> Best regards,
> Krzysztof
