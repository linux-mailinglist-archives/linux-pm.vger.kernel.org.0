Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2418519ACFC
	for <lists+linux-pm@lfdr.de>; Wed,  1 Apr 2020 15:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732537AbgDANi1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Apr 2020 09:38:27 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:35901 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732234AbgDANi1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Apr 2020 09:38:27 -0400
Received: by mail-vk1-f196.google.com with SMTP id m131so6701836vkh.3
        for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2020 06:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tdGCqc9X95oHSJMV+qy+8plsVCVI++tvDUGtwBmzzE0=;
        b=iJgSy+ppUkCv23YRcokF5MvB1CtI9Q9oPoqYsxGBvu9wQipZSozOMMaBt5dk8Z64Pw
         pTqrH4QMYPH1T/fOh6ky2k1mwgCWG7thPsK0HAJKY+KXigsZcFA+vVdLs/+lh9GW4g30
         qbRMR59VqZieEJeHPKCmGXfF7UbjExFTSoH7GkWcm0/jwTeKIVdLWDpubhtHxQnMbAgz
         Ghv9x6l9K3/76kloSSkSjPNzkOp95zWBlJehfWWaBtJv76JVFxFIa+/Ygzb9Esu3jKuQ
         0hsOys1sDLjt4KEaEehzyUyS3F73eRnw2Mfvv0aRNpK0bNEezRK7eWIi7O8gknxzWU0R
         Eexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tdGCqc9X95oHSJMV+qy+8plsVCVI++tvDUGtwBmzzE0=;
        b=iq+l3lCFZJEKYtlS7BIwGVhhMifrTlu6wJ3Pmnm9sZG1xDqEGd8gQxVoAJVOsrM6Dn
         t/30SMg0VbVKgIWk7trTEhRXk+MmhKXkxEHR2CPQm8MxvqPt5Q7GrKeyx782G7xzzG5L
         RAhzFmDX44aO+DZu+Z88bxiFSuM7lAS47moNiU9GVsXYhMN/4OhfVYZLB9MRohDRqF0L
         XOkvbqr0TV9Ybkx1kAzICajX+ozxkFcL7hDgaxgfeU9NfuCwjx58RLPWJ2Y4n8W4E5pG
         +M3OzDgyszI+S6td7UY+RYLwfWuEagq32pRArPS+dTz6/BduCW7/OMeBRrRy2RuotTf5
         b7RA==
X-Gm-Message-State: AGi0Pub8PRWGZs95o2+BWsi0wmprWSqnI2GkM9L6mNFShnImqynsof9/
        MaunySfer6afjUvkv/mM/x/dqhcOW2sNArkfPbZrgQ==
X-Google-Smtp-Source: APiQypK82L+3ASqFUwhZ41FJdoIyKv5f4kEy867p4zztojbVdS++g9Yx4zgyKPjtA8Vk65/Js9wTmlxCm8JpqJ5m7bo=
X-Received: by 2002:a1f:ee05:: with SMTP id m5mr16812468vkh.9.1585748305004;
 Wed, 01 Apr 2020 06:38:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585738725.git.amit.kucheria@linaro.org>
 <146b5dfebf23321c1eed8190ada957e2264ffe65.1585738725.git.amit.kucheria@linaro.org>
 <da9860cf-0c2e-b7ff-47c2-19c79b06ad55@arm.com>
In-Reply-To: <da9860cf-0c2e-b7ff-47c2-19c79b06ad55@arm.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 1 Apr 2020 19:08:13 +0530
Message-ID: <CAHLCerMvwfBEGO6O9kHMg14AfJ1bEO7ZP4i=SH3XO6HCKucVKQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: thermal: Add yaml bindings for
 thermal sensors
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 1, 2020 at 6:10 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 4/1/20 12:15 PM, Amit Kucheria wrote:
> > As part of moving the thermal bindings to YAML, split it up into 3
> > bindings: thermal sensors, cooling devices and thermal zones.
> >
> > The property #thermal-sensor-cells is required in each device that acts
> > as a thermal sensor. It is used to uniquely identify the instance of the
> > thermal sensor inside the system.
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >   .../bindings/thermal/thermal-sensor.yaml      | 72 +++++++++++++++++++
> >   1 file changed, 72 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/thermal/thermal-sensor.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/thermal/thermal-sensor.yaml b/Documentation/devicetree/bindings/thermal/thermal-sensor.yaml
> > new file mode 100644
> > index 0000000000000..920ee7667591d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/thermal/thermal-sensor.yaml
> > @@ -0,0 +1,72 @@
> > +# SPDX-License-Identifier: (GPL-2.0)
> > +# Copyright 2020 Linaro Ltd.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/thermal/thermal-sensor.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Thermal sensor binding
> > +
> > +maintainers:
> > +  - Amit Kucheria <amitk@kernel.org>
> > +
> > +description: |
> > +  Thermal management is achieved in devicetree by describing the sensor hardware
> > +  and the software abstraction of thermal zones required to take appropriate
> > +  action to mitigate thermal overloads.
> > +
> > +  The following node types are used to completely describe a thermal management
> > +  system in devicetree:
> > +   - thermal-sensor: device that measures temperature, has SoC-specific bindings
> > +   - cooling-device: device used to dissipate heat either passively or artively
>
> s/artively/actively
>
> > +   - thermal-zones: a container of the following node types used to describe all
> > +     thermal data for the platform
> > +
> > +  This binding describes the thermal-sensor.
> > +
> > +  Thermal sensor devices provide temperature sensing capabilities on thermal
> > +  zones. Typical devices are I2C ADC converters and bandgaps. Thermal sensor
> > +  devices may control one or more internal sensors.
> > +
> > +properties:
> > +  "#thermal-sensor-cells":
> > +    description:
> > +      Used to uniquely identify a thermal sensor instance within an IC. Will be
> > +      0 on sensor nodes with only a single sensor and at least 1 on nodes
> > +      containing several internal sensors.
> > +    enum: [0, 1]
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    // Example 1: SDM845 TSENS
> > +    soc: soc@0 {
> > +            #address-cells = <2>;
> > +            #size-cells = <2>;
> > +
> > +            /* ... */
> > +
> > +            tsens0: thermal-sensor@c263000 {
> > +                    compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
> > +                    reg = <0 0x0c263000 0 0x1ff>, /* TM */
> > +                          <0 0x0c222000 0 0x1ff>; /* SROT */
> > +                    #qcom,sensors = <13>;
> > +                    interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>,
> > +                                 <GIC_SPI 508 IRQ_TYPE_LEVEL_HIGH>;
> > +                    interrupt-names = "uplow", "critical";
> > +                    #thermal-sensor-cells = <1>;
> > +            };
> > +
> > +            tsens1: thermal-sensor@c265000 {
> > +                    compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
> > +                    reg = <0 0x0c265000 0 0x1ff>, /* TM */
> > +                          <0 0x0c223000 0 0x1ff>; /* SROT */
> > +                    #qcom,sensors = <8>;
> > +                    interrupts = <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH>,
> > +                                 <GIC_SPI 509 IRQ_TYPE_LEVEL_HIGH>;
> > +                    interrupt-names = "uplow", "critical";
> > +                    #thermal-sensor-cells = <1>;
> > +            };
> > +    };
> > +...
> >
>
> Apart from the above, looks good.
>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Thanks for the review. Will spin a v5 with those trivial fixes.
