Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5492221BE4B
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 22:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgGJUH2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 16:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgGJUH2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jul 2020 16:07:28 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF18FC08C5DC;
        Fri, 10 Jul 2020 13:07:27 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id b15so5551060edy.7;
        Fri, 10 Jul 2020 13:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=+CqFjCkiMTTrEMmgLJvQC/nHsLPJva/2WbdazGmDbtU=;
        b=KQpUS3RWR6SFYKtDRZ273kbQ9uITMIz9ZdfmBHBz9A0icwaPWk7rAb/sBMBRQFgRBa
         KcX/Rviiz5ftE4zqNG64RB+X8IxFhaTJzdp41VlN3SPm+mT6PbadOSA9pdZ0igaG5g48
         cAldkuDtYAbivpN7t4CSOOgCM/WjRkSUQR3kuxSu6gx0AApsrwaiETEOmG9sjDJmzZPi
         9LwdXaSg11Uh4hcimoIIkTqUCDucnO5ZOeSvzdZNdHvW8+edqZr8vsT68Br1OyAiLjNP
         99TXNTRJ5KlyUUekDdX7milIlXg6GeQmvx12oEUwDDpbX8EMAJt4lTPsEc4peOEjA4+N
         L1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=+CqFjCkiMTTrEMmgLJvQC/nHsLPJva/2WbdazGmDbtU=;
        b=qnbRfxvBdNrNzKpfggnx299ZU+6lUpXpIDsRRPzQF1YZzj65eDpaRbBXCCbXyDhCa8
         UKuaQO600w+tOcSLv7ZF+3l3LaGZzv6f+QkgwmBHKMWd3NcGG/Jnhts5+hNvxvqO7KWo
         nBLPCesIDBMHVqXepsY2MeBvsy3hRoQEKxeQwrC2z8ZwQX6adIP1FTo1TPO6RnadfNlo
         ElzfDDJkugmRx0m8QYxZv2bzGVCnjm9aTsgmYQr06APm0lM1nM49D5SxtUEnzw0ZHKSF
         sXEfNGiokQwONY7H0+JWqRpoJGM0Lr+AQ7F+mXcfizjiWk6Ny1YwP9tL2dpANBWTtPqF
         LxyQ==
X-Gm-Message-State: AOAM530WvtKV+LsBxk1GoZJUQ4G201YHQ1A1QHiz2mvV3e3g9sw2/J6j
        P6HW8o8l954/gGLbkQxpKKc=
X-Google-Smtp-Source: ABdhPJyF2/CZ5X3guxfM+/Uff+qM6LTB72hZnQuiA9xDD+N5C423hmEZj2QKJBP3epqGirgLzA2cqg==
X-Received: by 2002:a50:d55b:: with SMTP id f27mr41864893edj.312.1594411646388;
        Fri, 10 Jul 2020 13:07:26 -0700 (PDT)
Received: from AnsuelXPS (host-87-16-250-164.retail.telecomitalia.it. [87.16.250.164])
        by smtp.gmail.com with ESMTPSA id i2sm5303716edk.30.2020.07.10.13.07.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jul 2020 13:07:25 -0700 (PDT)
From:   <ansuelsmth@gmail.com>
To:     "'Rob Herring'" <robh@kernel.org>
Cc:     "'Amit Kucheria'" <amit.kucheria@linaro.org>,
        "'Andy Gross'" <agross@kernel.org>,
        "'Bjorn Andersson'" <bjorn.andersson@linaro.org>,
        "'Zhang Rui'" <rui.zhang@intel.com>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200709215136.28044-1-ansuelsmth@gmail.com> <20200709215136.28044-4-ansuelsmth@gmail.com> <20200710162657.GB2743639@bogus>
In-Reply-To: <20200710162657.GB2743639@bogus>
Subject: R: [PATCH 3/6] dt-bindings: thermal: tsens: document ipq8064 bindings
Date:   Fri, 10 Jul 2020 22:07:21 +0200
Message-ID: <0ef601d656f5$b9f8e0c0$2deaa240$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKhcWl5bhTF+RXP3lhSldlnX/gq7QKeRUoHAWvA1uGnSreZEA==
Content-Language: it
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



> -----Messaggio originale-----
> Da: Rob Herring <robh@kernel.org>
> Inviato: venerd=EC 10 luglio 2020 18:27
> A: Ansuel Smith <ansuelsmth@gmail.com>
> Cc: Amit Kucheria <amit.kucheria@linaro.org>; Andy Gross
> <agross@kernel.org>; Bjorn Andersson <bjorn.andersson@linaro.org>;
> Zhang Rui <rui.zhang@intel.com>; Daniel Lezcano
> <daniel.lezcano@linaro.org>; linux-pm@vger.kernel.org; linux-arm-
> msm@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Oggetto: Re: [PATCH 3/6] dt-bindings: thermal: tsens: document ipq8064
> bindings
>=20
> On Thu, Jul 09, 2020 at 11:51:33PM +0200, Ansuel Smith wrote:
> > Document the use of regmap phandle for ipq8064 SoCs
> >
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  .../bindings/thermal/qcom-tsens.yaml          | 51 =
++++++++++++++++---
> >  1 file changed, 44 insertions(+), 7 deletions(-)
> >
> > diff --git =
a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> > index d7be931b42d2..5ceb5d720e16 100644
> > --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> > +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> > @@ -24,6 +24,7 @@ properties:
> >            - enum:
> >                - qcom,msm8916-tsens
> >                - qcom,msm8974-tsens
> > +              - qcom,ipq8064-tsens
> >            - const: qcom,tsens-v0_1
> >
> >        - description: v1 of TSENS
> > @@ -47,6 +48,11 @@ properties:
> >        - description: TM registers
> >        - description: SROT registers
> >
> > +  regmap:
> > +    description:
> > +      Phandle to the gcc. On ipq8064 SoCs gcc and tsense share the =
same
> regs.
> > +    $ref: /schemas/types.yaml#/definitions/phandle
>=20
> Can't you make this a child of the gcc and drop this property?
>=20

Make the thermal a child of the gcc would be a little confusing. Anyway
making this
a child of gcc cause the not probing of the thermal driver as it's =
ignored
any child of
gcc. I pushed v2 with the fixed problem.

> > +
> >    interrupts:
> >      minItems: 1
> >      items:
> > @@ -111,17 +117,48 @@ allOf:
> >          interrupt-names:
> >            minItems: 2
> >
> > -required:
> > -  - compatible
> > -  - reg
> > -  - "#qcom,sensors"
> > -  - interrupts
> > -  - interrupt-names
> > -  - "#thermal-sensor-cells"
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - qcom,ipq8064-tsens
> > +    then:
> > +      required:
> > +        - compatible
> > +        - regmap
> > +        - "#qcom,sensors"
> > +        - interrupts
> > +        - interrupt-names
> > +        - "#thermal-sensor-cells"
> > +
> > +    else:
> > +      required:
> > +        - compatible
> > +        - reg
> > +        - "#qcom,sensors"
> > +        - interrupts
> > +        - interrupt-names
> > +        - "#thermal-sensor-cells"
>=20
> Keep all the common required properties and just put reg/regmap in the
> if/then if this ends up staying.
>=20
> Rob

