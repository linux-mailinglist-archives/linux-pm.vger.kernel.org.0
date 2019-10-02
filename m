Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0576C4A72
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 11:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbfJBJUZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Oct 2019 05:20:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42686 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfJBJUZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Oct 2019 05:20:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id n14so18733900wrw.9;
        Wed, 02 Oct 2019 02:20:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/LNwLMp43Cx4RXv6+JFT5wsgANeYSc59zzeLQnD1VHM=;
        b=n+A1k7hvXYK2zo3ZO6Z36E3hZflMnyjRjiJNJgRMneTmtYW/ZqSdWwIVT5TOKgUnsB
         yDD679nMHcLD9R8Galc6qtzg60xkVZequoUGj+cQyL0I5pnXvHDoI58fPbvKpUtMPqDh
         hymSR/8AMX0MKOiOfE8sj4FUcpOEC0KgEtnAYWsmTRsziea390hvXLwE1Wyei4e14Vo7
         L2iE1DdkmuMW1UsM9NHINOUQwb11NWJb6vmo6dFduomaQy50uX353BZnhyETc3zKfgMk
         FCoS2GHqkF/Y0cQiLgHnyHe0GcgXy8Cq3lysg/EFArsG/+uxJXsVfHKjhiqLtmc5vlG2
         RJMg==
X-Gm-Message-State: APjAAAUDolAmLNbTTheTh+uhgHV6oPAaxK4KWUZ6sQ2ldcUj+DpPTTq/
        nOrISVvW8fAIoyLlUXNiO2w=
X-Google-Smtp-Source: APXvYqwbyAHos9+Zn4wxA2bvS9JMTWnOqnIj0D+jL+AREPyLlLj8ldJJnHV6LEFDbhGkpKgmtaXndg==
X-Received: by 2002:adf:ce05:: with SMTP id p5mr1906030wrn.48.1570008022113;
        Wed, 02 Oct 2019 02:20:22 -0700 (PDT)
Received: from pi3 ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id v11sm5445038wml.30.2019.10.02.02.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 02:20:21 -0700 (PDT)
Date:   Wed, 2 Oct 2019 11:20:19 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [RFC 2/2] dt-bindings: power: Convert Samsung Exynos Power
 Domain bindings to json-schema
Message-ID: <20191002092019.GA9952@pi3>
References: <20190908152813.20646-1-krzk@kernel.org>
 <20190908152813.20646-2-krzk@kernel.org>
 <20190930140600.GA18975@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190930140600.GA18975@bogus>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 30, 2019 at 09:06:00AM -0500, Rob Herring wrote:
> On Sun, Sep 08, 2019 at 05:28:13PM +0200, Krzysztof Kozlowski wrote:
> > Convert Samsung Exynos Soc Power Domain bindings to DT schema format using
> > json-schema.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  .../devicetree/bindings/power/pd-samsung.txt  | 45 ------------
> >  .../devicetree/bindings/power/pd-samsung.yaml | 70 +++++++++++++++++++
> >  2 files changed, 70 insertions(+), 45 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/power/pd-samsung.txt
> >  create mode 100644 Documentation/devicetree/bindings/power/pd-samsung.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/power/pd-samsung.txt b/Documentation/devicetree/bindings/power/pd-samsung.txt
> > deleted file mode 100644
> > index 92ef355e8f64..000000000000
> > --- a/Documentation/devicetree/bindings/power/pd-samsung.txt
> > +++ /dev/null
> > @@ -1,45 +0,0 @@
> > -* Samsung Exynos Power Domains
> > -
> > -Exynos processors include support for multiple power domains which are used
> > -to gate power to one or more peripherals on the processor.
> > -
> > -Required Properties:
> > -- compatible: should be one of the following.
> > -    * samsung,exynos4210-pd - for exynos4210 type power domain.
> > -    * samsung,exynos5433-pd - for exynos5433 type power domain.
> > -- reg: physical base address of the controller and length of memory mapped
> > -    region.
> > -- #power-domain-cells: number of cells in power domain specifier;
> > -    must be 0.
> > -
> > -Optional Properties:
> > -- label: Human readable string with domain name. Will be visible in userspace
> > -	to let user to distinguish between multiple domains in SoC.
> > -- power-domains: phandle pointing to the parent power domain, for more details
> > -		 see Documentation/devicetree/bindings/power/power_domain.txt
> > -
> > -Deprecated Properties:
> > -- clocks
> > -- clock-names
> > -
> > -Node of a device using power domains must have a power-domains property
> > -defined with a phandle to respective power domain.
> > -
> > -Example:
> > -
> > -	lcd0: power-domain-lcd0 {
> > -		compatible = "samsung,exynos4210-pd";
> > -		reg = <0x10023C00 0x10>;
> > -		#power-domain-cells = <0>;
> > -		label = "LCD0";
> > -	};
> > -
> > -	mfc_pd: power-domain@10044060 {
> > -		compatible = "samsung,exynos4210-pd";
> > -		reg = <0x10044060 0x20>;
> > -		#power-domain-cells = <0>;
> > -		label = "MFC";
> > -	};
> > -
> > -See Documentation/devicetree/bindings/power/power_domain.txt for description
> > -of consumer-side bindings.
> > diff --git a/Documentation/devicetree/bindings/power/pd-samsung.yaml b/Documentation/devicetree/bindings/power/pd-samsung.yaml
> > new file mode 100644
> > index 000000000000..0fc012734a79
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/pd-samsung.yaml
> > @@ -0,0 +1,70 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/power/pd-samsung.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Samsung Exynos SoC Power Domains
> > +
> > +maintainers:
> > +  - Krzysztof Kozlowski <krzk@kernel.org>
> > +
> > +description: |+
> > +  Exynos processors include support for multiple power domains which are used
> > +  to gate power to one or more peripherals on the processor.
> > +
> > +allOf:
> > +  - $ref: power-domain.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - samsung,exynos4210-pd
> > +      - samsung,exynos5433-pd
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    deprecated: true
> > +    maxItems: 1
> > +
> > +  clock-names:
> > +    deprecated: true
> > +    maxItems: 1
> > +
> > +  label:
> > +    $ref: /schemas/types.yaml#/definitions/string
> 
> label already has a type.
> 
> Is there a defined set of values?

No, many Exynos SoCs have similar values but newer designs are bringing
new names.

> 
> > +    description:
> > +      Human readable string with domain name. Will be visible in userspace
> > +      to let user to distinguish between multiple domains in SoC.
> > +
> > +  "#power-domain-cells":
> > +    const: 0
> > +
> > +  power-domains:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> 
> Already has a type.
> 
> maxItems: 1

OK

> 
> > +    description:
> > +      Phandle pointing to the parent power domain, for more details
> > +      see power-domain-consumers.yaml.
> 
> Unless there's something specific about this device to say, drop this.

Sure.

Best regards,
Krzysztof

> 
> > +
> > +required:
> > +  - compatible
> > +  - "#power-domain-cells"
> > +  - reg
> > +
> > +examples:
> > +  - |
> > +    lcd0: power-domain-lcd0 {
> > +      compatible = "samsung,exynos4210-pd";
> > +      reg = <0x10023C00 0x10>;
> > +      #power-domain-cells = <0>;
> > +      label = "LCD0";
> > +    };
> > +
> > +    mfc_pd: power-domain@10044060 {
> > +      compatible = "samsung,exynos4210-pd";
> > +      reg = <0x10044060 0x20>;
> > +      #power-domain-cells = <0>;
> > +      label = "MFC";
> > +    };
> > -- 
> > 2.17.1
> > 
