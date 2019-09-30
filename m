Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF1F3C22A5
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2019 16:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731502AbfI3OGD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Sep 2019 10:06:03 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37357 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731501AbfI3OGC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Sep 2019 10:06:02 -0400
Received: by mail-oi1-f193.google.com with SMTP id i16so11207307oie.4;
        Mon, 30 Sep 2019 07:06:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mVZFJxHttL2B19AWqpFmvyJIuVcYITz9xNJC6dB+uU0=;
        b=aOMWjKXz67FJWPm5qDcQe1RmT5zwbM8jj9vC/ZhGZ1+ytjgoHtiaAP/94YLwyidx4/
         wm73IIDX8Tcpwhglfr2rFCCOWOBbslGJL5TZA8hf0LiyraQI1EZd18UGfjXRgVPIoIkx
         pPgneATq9HyInO9YVNcUkMG+IwYsU7ZDWBJd1WyGtpUgfYLZVGA64dp+nzfx97JN9O8S
         75wV2+6qPv7HJXeQzUCgzo9NjWLnrzRllFq3NGvCkxL0Gxzu7+GZzbJfspfuNLz3lCO5
         h5BX/qK6mWu30OJRGM2fl95oIMkfpC29rqv+OVIkbvujYaY50UeQOuQk9uR2vfXYE1EX
         TBIg==
X-Gm-Message-State: APjAAAVw6GTwoqQK/DBkQ1Lqp6IqzwfNyfJRgmkTmGYF1Rfj3ly6XJH/
        l5/Z/72ASMObz2yUWl2w5A==
X-Google-Smtp-Source: APXvYqys4eWGnpVCUQDoc/OoTnUmAYr5V48ZfBnYT4s8tn4QWIu0pd0tCTYQqbR+pKYuXtwU/SdAtg==
X-Received: by 2002:aca:dbd5:: with SMTP id s204mr17425614oig.55.1569852361369;
        Mon, 30 Sep 2019 07:06:01 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k19sm4031422oiw.31.2019.09.30.07.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 07:06:00 -0700 (PDT)
Date:   Mon, 30 Sep 2019 09:06:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [RFC 2/2] dt-bindings: power: Convert Samsung Exynos Power
 Domain bindings to json-schema
Message-ID: <20190930140600.GA18975@bogus>
References: <20190908152813.20646-1-krzk@kernel.org>
 <20190908152813.20646-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190908152813.20646-2-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Sep 08, 2019 at 05:28:13PM +0200, Krzysztof Kozlowski wrote:
> Convert Samsung Exynos Soc Power Domain bindings to DT schema format using
> json-schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../devicetree/bindings/power/pd-samsung.txt  | 45 ------------
>  .../devicetree/bindings/power/pd-samsung.yaml | 70 +++++++++++++++++++
>  2 files changed, 70 insertions(+), 45 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/pd-samsung.txt
>  create mode 100644 Documentation/devicetree/bindings/power/pd-samsung.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/pd-samsung.txt b/Documentation/devicetree/bindings/power/pd-samsung.txt
> deleted file mode 100644
> index 92ef355e8f64..000000000000
> --- a/Documentation/devicetree/bindings/power/pd-samsung.txt
> +++ /dev/null
> @@ -1,45 +0,0 @@
> -* Samsung Exynos Power Domains
> -
> -Exynos processors include support for multiple power domains which are used
> -to gate power to one or more peripherals on the processor.
> -
> -Required Properties:
> -- compatible: should be one of the following.
> -    * samsung,exynos4210-pd - for exynos4210 type power domain.
> -    * samsung,exynos5433-pd - for exynos5433 type power domain.
> -- reg: physical base address of the controller and length of memory mapped
> -    region.
> -- #power-domain-cells: number of cells in power domain specifier;
> -    must be 0.
> -
> -Optional Properties:
> -- label: Human readable string with domain name. Will be visible in userspace
> -	to let user to distinguish between multiple domains in SoC.
> -- power-domains: phandle pointing to the parent power domain, for more details
> -		 see Documentation/devicetree/bindings/power/power_domain.txt
> -
> -Deprecated Properties:
> -- clocks
> -- clock-names
> -
> -Node of a device using power domains must have a power-domains property
> -defined with a phandle to respective power domain.
> -
> -Example:
> -
> -	lcd0: power-domain-lcd0 {
> -		compatible = "samsung,exynos4210-pd";
> -		reg = <0x10023C00 0x10>;
> -		#power-domain-cells = <0>;
> -		label = "LCD0";
> -	};
> -
> -	mfc_pd: power-domain@10044060 {
> -		compatible = "samsung,exynos4210-pd";
> -		reg = <0x10044060 0x20>;
> -		#power-domain-cells = <0>;
> -		label = "MFC";
> -	};
> -
> -See Documentation/devicetree/bindings/power/power_domain.txt for description
> -of consumer-side bindings.
> diff --git a/Documentation/devicetree/bindings/power/pd-samsung.yaml b/Documentation/devicetree/bindings/power/pd-samsung.yaml
> new file mode 100644
> index 000000000000..0fc012734a79
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/pd-samsung.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/pd-samsung.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung Exynos SoC Power Domains
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzk@kernel.org>
> +
> +description: |+
> +  Exynos processors include support for multiple power domains which are used
> +  to gate power to one or more peripherals on the processor.
> +
> +allOf:
> +  - $ref: power-domain.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - samsung,exynos4210-pd
> +      - samsung,exynos5433-pd
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    deprecated: true
> +    maxItems: 1
> +
> +  clock-names:
> +    deprecated: true
> +    maxItems: 1
> +
> +  label:
> +    $ref: /schemas/types.yaml#/definitions/string

label already has a type.

Is there a defined set of values?

> +    description:
> +      Human readable string with domain name. Will be visible in userspace
> +      to let user to distinguish between multiple domains in SoC.
> +
> +  "#power-domain-cells":
> +    const: 0
> +
> +  power-domains:
> +    $ref: /schemas/types.yaml#/definitions/phandle

Already has a type.

maxItems: 1

> +    description:
> +      Phandle pointing to the parent power domain, for more details
> +      see power-domain-consumers.yaml.

Unless there's something specific about this device to say, drop this.

> +
> +required:
> +  - compatible
> +  - "#power-domain-cells"
> +  - reg
> +
> +examples:
> +  - |
> +    lcd0: power-domain-lcd0 {
> +      compatible = "samsung,exynos4210-pd";
> +      reg = <0x10023C00 0x10>;
> +      #power-domain-cells = <0>;
> +      label = "LCD0";
> +    };
> +
> +    mfc_pd: power-domain@10044060 {
> +      compatible = "samsung,exynos4210-pd";
> +      reg = <0x10044060 0x20>;
> +      #power-domain-cells = <0>;
> +      label = "MFC";
> +    };
> -- 
> 2.17.1
> 
