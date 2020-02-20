Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFE4D166751
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 20:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbgBTTlC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 14:41:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:41910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728248AbgBTTlC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 20 Feb 2020 14:41:02 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69AC8206F4;
        Thu, 20 Feb 2020 19:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582227661;
        bh=0wre2PhbpSA1aEnoeMZ1bcwtIXAHkDXm1zKnDVREcMk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=onGUmZ4W5YgNq6a6cohwh4PcfU3bSROgWlTISRwk6Tu4qja+yGJdoTcfTIuItS4X0
         6/noPkMXCG2AWjgYUOGkW9pJOBQCNtOmEfYnV9poABQ5qG7X3jEsN2ArrSIhZNy2U4
         fDOntJCGfiV/LN5jbMQQCuHJNcVw1mjFRCTOtOpM=
Received: by mail-qt1-f178.google.com with SMTP id t13so3761767qto.3;
        Thu, 20 Feb 2020 11:41:01 -0800 (PST)
X-Gm-Message-State: APjAAAU/a8+ebsvRPsXIsIQ8/vMtJYEadx2WXuwrthzMCQ/j91qIkw8j
        W+zjOIFPQlu1AZ0cXJ/ms/mizOIeWLpdQmEg2g==
X-Google-Smtp-Source: APXvYqzDn8h46fe/CUa7KJYYUBSmCXArXpHfC06sW0cJBJhvkkTyV8xOPINS5zIjiic0Sfqc+1Sca27kEmFwAHiwRwU=
X-Received: by 2002:ac8:6747:: with SMTP id n7mr28142441qtp.224.1582227660541;
 Thu, 20 Feb 2020 11:41:00 -0800 (PST)
MIME-Version: 1.0
References: <20200219074314.22829-1-j-keerthy@ti.com> <20200219074314.22829-2-j-keerthy@ti.com>
 <20200219145227.GA1317@bogus> <55b68963-b931-bf67-482e-146e42af4298@ti.com>
In-Reply-To: <55b68963-b931-bf67-482e-146e42af4298@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 20 Feb 2020 13:40:49 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJAdCT-xpqxYxkZO+JBHCcewhzb2ebiNJvPzSUyCcmP9g@mail.gmail.com>
Message-ID: <CAL_JsqJAdCT-xpqxYxkZO+JBHCcewhzb2ebiNJvPzSUyCcmP9g@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: thermal: k3: Add VTM bindings documentation
To:     Keerthy <j-keerthy@ti.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Tero Kristo <t-kristo@ti.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Feb 19, 2020 at 10:13 PM Keerthy <j-keerthy@ti.com> wrote:
>
>
>
> On 19/02/20 8:22 pm, Rob Herring wrote:
> > On Wed, Feb 19, 2020 at 01:13:11PM +0530, Keerthy wrote:
> >> Add VTM bindings documentation. In the Voltage Thermal
> >> Management Module(VTM), K3 AM654 supplies a voltage
> >> reference and a temperature sensor feature that are gathered in the band
> >> gap voltage and temperature sensor (VBGAPTS) module. The band
> >> gap provides current and voltage reference for its internal
> >> circuits and other analog IP blocks. The analog-to-digital
> >> converter (ADC) produces an output value that is proportional
> >> to the silicon temperature.
> >>
> >> Signed-off-by: Keerthy <j-keerthy@ti.com>
> >> ---
> >>
> >> Changes in v3:
> >>
> >>    * Fixed errors seen with:
> >>      dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml
> >>
> >>   .../bindings/thermal/ti,am654-thermal.yaml    | 57 +++++++++++++++++++
> >>   1 file changed, 57 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml b/Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml
> >> new file mode 100644
> >> index 000000000000..b6dc95c3acab
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml
> >> @@ -0,0 +1,57 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/thermal/ti,am654-thermal.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Texas Instruments AM654 VTM (DTS) binding
> >> +
> >> +maintainers:
> >> +  - Keerthy <j-keerthy@ti.com>
> >> +
> >> +properties:
> >> +  compatible:
> >> +    const: ti,am654-vtm
> >> +
> >> +  reg:
> >> +    maxItems: 1
> >> +
> >> +  power-domains:
> >> +    maxItems: 1
> >> +    description: phandle to the associated power domain
> >
> > No need to redefine a standard property description.
>
> Okay.
>
> >
> >> +
> >> +  "#thermal-sensor-cells":
> >> +    const: 1
> >> +
> >> +required:
> >> +  - "#thermal-sensor-cells"
> >> +  - compatible
> >> +  - reg
> >> +  - power-domains
> >> +
> >> +additionalProperties: false
> >> +
> >> +examples:
> >> +  - |
> >> +    #include <dt-bindings/soc/ti,sci_pm_domain.h>
> >> +    vtm: wkup_vtm0@42050000 {
> >
> > thermal-sensor@...
> >
> > Use generic node names and don't use '_' in node names
>
> vtm stands for voltage thermal manager and comprises of multiple
> sensors. This is similar to omap bandgap. Should i replace vtm with more
> generic name like thermal? as used in:

'vtm' is a label and source construct only (until you do overlays), so
I don't care what you put really.

Rob
