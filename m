Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53A9D1272F0
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2019 02:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfLTBnH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 20:43:07 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35661 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbfLTBnH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 20:43:07 -0500
Received: by mail-qk1-f194.google.com with SMTP id z76so6720161qka.2;
        Thu, 19 Dec 2019 17:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=55+iNip2URhocySz64VQuqG36OguCpiyed96RcKt5ho=;
        b=r5LZA7AOLRKLkvbuBJihNIk64F96SbOWmmlqtNBgxoGmS3rjh4kpO3tV1NPTAybWYV
         I+lW49a7cbqqTIoyJOJPlr5sQvuYtX1g2PvwtwYp/aetE4ZkW/snhcf+pwSH3hsHLG4c
         NBbFBCUW5fCBSeAoQtyRbWYYtNRMgrg6dTOaqeYH/1skmVMy3IUReZCvxWg5pjxVp8gD
         qmN5X08nul5Y89XDEwJtUpM6YPask3PfojFKbZp0lbHjL5FIlsTdvJqZdo1z9njnE6E7
         NIoZct5y/C8cin7LUEHDRuEcEo+Ith4lBjRXpdZVkjM6zSc7h73vQ1c5eNT3eJQmi++7
         h5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=55+iNip2URhocySz64VQuqG36OguCpiyed96RcKt5ho=;
        b=Vb6bwwTPTDEGf/x8WwxbgSs7lIL1CxGunCPRpKs5KwP6n3Hc4KQ8hEnXTkusYmGl66
         Wq12Zm26b9hmYqZx9AFT37q9CdcuC6WRAA9gz/8YSCV49cAmyJiUL0WTJD47sgYyaLGJ
         qtER44d5Ee2RQuV8DEUjVWqDkS3O08xSykcd9Qzd1eKIa4mL4tUpTLawhMCwoAeWlLMf
         f+mkBpM0+HBqt3QKB1ccDERCLvmYlO/482NO0tm5bUp3719RFFo9xhW53dWE9pgB/gNl
         l+IvL+77/qHI8R5OZtPOtaHCWmMUv+CNwq5byL6EdNB4ukc8kvldQ4OpwHPPjuCyXyjK
         P4pQ==
X-Gm-Message-State: APjAAAVh6JDj4sN6dkiw0cpPgSApaMsS01xSnz/tNHnSVExZJZR85ivB
        vX13C32nY6NZNcy39QvfhiDGNVtRxQ3g4JHgXUE=
X-Google-Smtp-Source: APXvYqy+UM7zTG8cL8j5MjDRUf2oC8QFIUOP8pOY8xEEdVMyeAzYPcEHG528pUjqLnDMv+TscfGZirIgkBQoVy6TIsQ=
X-Received: by 2002:a05:620a:1298:: with SMTP id w24mr10984911qki.170.1576806186431;
 Thu, 19 Dec 2019 17:43:06 -0800 (PST)
MIME-Version: 1.0
References: <8d5358a67746b2aff5f6995cabd11d0d7c9e579e.1575978484.git.baolin.wang7@gmail.com>
 <20191219201248.GA5109@bogus>
In-Reply-To: <20191219201248.GA5109@bogus>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Fri, 20 Dec 2019 09:42:55 +0800
Message-ID: <CADBw62rf6=PPVw5uooKW2xdsNY4VuWTDus8e1sbRiC4yCBNUFQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: thermal: sprd: Add the Spreadtrum
 thermal documentation
To:     Rob Herring <robh@kernel.org>
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        amit.kucheria@verdurent.com, mark.rutland@arm.com,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>, freeman.liu@unisoc.com,
        Chunyan Zhang <zhang.lyra@gmail.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rob,

On Fri, Dec 20, 2019 at 4:12 AM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Dec 10, 2019 at 08:07:17PM +0800, Baolin Wang wrote:
> > From: Baolin Wang <baolin.wang@unisoc.com>
> >
> > Add the Spreadtrum thermal documentation.
> >
> > Signed-off-by: Baolin Wang <baolin.wang@unisoc.com>
> > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> > ---
> > Changes from v1:
> >  - Change to yaml format.
> > ---
> >  .../devicetree/bindings/thermal/sprd-thermal.yaml  |   97 ++++++++++++++++++++
> >  1 file changed, 97 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml b/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
> > new file mode 100644
> > index 0000000..92d208a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
> > @@ -0,0 +1,97 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/thermal/sprd-thermal.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Spreadtrum thermal sensor controller bindings
> > +
> > +maintainers:
> > +  - Orson Zhai <orsonzhai@gmail.com>
> > +  - Baolin Wang <baolin.wang7@gmail.com>
> > +  - Chunyan Zhang <zhang.lyra@gmail.com>
> > +
> > +properties:
> > +  compatible:
> > +    const: sprd,ums512-thermal
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  clock-names:
> > +    items:
> > +      - const: enable
> > +
> > +  nvmem-cells:
> > +    maxItems: 2
> > +    description:
> > +      Reference to nvmem nodes for the calibration data.
> > +
> > +  nvmem-cells-names:
> > +    maxItems: 2
> > +    items:
> > +      - const: thm_sign_cal
> > +      - const: thm_ratio_cal
> > +
> > +  "#thermal-sensor-cells":
> > +    const: 1
> > +
> > +  child-node:
>
> You need actual child node names. It can be a pattern with
> patternProperties.

Ah, okay, I misunderstood this before.

>
> Make sure 'make dt_binding_check' passes.

Sure.

>
> > +    description: Represent one thermal sensor.
> > +
> > +    properties:
> > +      reg:
> > +        description: Specify the sensor id.
> > +        maxItems: 1
> > +
> > +      nvmem-cells:
> > +        maxItems: 1
> > +        description:
> > +          Reference to an nvmem node for the calibration data.
> > +
> > +      nvmem-cells-names:
> > +        maxItems: 1
> > +        items:
> > +          - const: sen_delta_cal
>
> Can be simplified to
>
> nvmem-cells-names:
>   const: sen_delta_cal

Okay.

>
> > +
> > +    required:
> > +      - reg
> > +      - nvmem-cells
> > +      - nvmem-cells-names
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +  - nvmem-cells
> > +  - nvmem-cells-names
> > +  - "#thermal-sensor-cells"
> > +
> > +examples:
> > +  - |
> > +        ap_thm0: thermal@32200000 {
> > +                compatible = "sprd,ums512-thermal";
> > +                reg = <0 0x32200000 0 0x10000>;
> > +                clock-names = "enable";
> > +                clocks = <&aonapb_gate 32>;
> > +                #thermal-sensor-cells = <1>;
> > +                nvmem-cells = <&thm0_sign>, <&thm0_ratio>;
> > +                nvmem-cell-names = "thm_sign_cal", "thm_ratio_cal";
> > +
> > +                prometheus0-sensor@0 {
> > +                        reg = <0>;
>
> This should fail to build. You need #size-cells and #address-cells in
> the parent.

Yes, will fix in next version. Thanks for your comments.
