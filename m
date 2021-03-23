Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2197346D8C
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 23:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233915AbhCWWsf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Mar 2021 18:48:35 -0400
Received: from mail-il1-f179.google.com ([209.85.166.179]:45955 "EHLO
        mail-il1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbhCWWsb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Mar 2021 18:48:31 -0400
Received: by mail-il1-f179.google.com with SMTP id v3so19683639ilj.12;
        Tue, 23 Mar 2021 15:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TsbOqS3D7H1UC+Tnkk8G7bx2IsHza5mWPnO8GsklWKo=;
        b=WmHsLHq3V7meRsMqzLtBMuAZ5ZaIr0jazB8/86xRGctggNbeNAXHqy2dxWqc87mUTt
         WcH00ScRtNPk+0xS5YBVS5H4y28r9kpqRKJ96zoPkXtooaUFDfgDK0xAbBsw95vsA4k5
         YxkboJ9DjjqqTfYoEkJEMiBMdemIRwZyBW6t5qSh9qqNwtACkQRSsXnv7KzQZPgAPS40
         18e63mJDJ98IyvpKRSjQ+jWW7YRJQqt2KzKuJii68kYspWT/m/66hng4I/ZObo3ek86j
         Mh6/RihsiEoLwHc75rhIaj0hKxY7kPkPjNhLc9ghsW2iNsAn5jzy14O65p1t3ajhuWfY
         8edw==
X-Gm-Message-State: AOAM532HF0u6dO+rbakpJJ0ZoO2lda0v8tt5zBGkRriYHqQptkVioNCB
        92f2d2Ilq0lint0gpgPqZg==
X-Google-Smtp-Source: ABdhPJwubxZghVsAD0xrIx2feJaWN7kwLC3Dd7y7fDoh64uTD98wo3ioNm0A2TFtyHQkmDvD+tfisw==
X-Received: by 2002:a05:6e02:2182:: with SMTP id j2mr392128ila.89.1616539710781;
        Tue, 23 Mar 2021 15:48:30 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id g16sm130553iln.29.2021.03.23.15.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 15:48:29 -0700 (PDT)
Received: (nullmailer pid 1492587 invoked by uid 1000);
        Tue, 23 Mar 2021 22:48:27 -0000
Date:   Tue, 23 Mar 2021 16:48:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Paul Fertser <fercerpav@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/6] dt-bindings: power: tegra: Add binding for core
 power domain
Message-ID: <20210323224826.GA1490612@robh.at.kernel.org>
References: <20210314164810.26317-1-digetx@gmail.com>
 <20210314164810.26317-4-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210314164810.26317-4-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Mar 14, 2021 at 07:48:07PM +0300, Dmitry Osipenko wrote:
> All NVIDIA Tegra SoCs have a core power domain where majority of hardware
> blocks reside. Add binding for the core power domain.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../power/nvidia,tegra20-core-domain.yaml     | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/nvidia,tegra20-core-domain.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/nvidia,tegra20-core-domain.yaml b/Documentation/devicetree/bindings/power/nvidia,tegra20-core-domain.yaml
> new file mode 100644
> index 000000000000..4692489d780a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/nvidia,tegra20-core-domain.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/nvidia,tegra20-core-domain.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NVIDIA Tegra Core Power Domain
> +
> +maintainers:
> +  - Dmitry Osipenko <digetx@gmail.com>
> +  - Jon Hunter <jonathanh@nvidia.com>
> +  - Thierry Reding <thierry.reding@gmail.com>
> +
> +allOf:
> +  - $ref: power-domain.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nvidia,tegra20-core-domain
> +      - nvidia,tegra30-core-domain
> +
> +  operating-points-v2:
> +    description:
> +      Should contain level, voltages and opp-supported-hw property.
> +      The supported-hw is a bitfield indicating SoC speedo or process
> +      ID mask.
> +
> +  "#power-domain-cells":
> +    const: 0
> +
> +  power-supply:
> +    description:
> +      Phandle to voltage regulator connected to the SoC Core power rail.
> +
> +required:
> +  - compatible
> +  - operating-points-v2
> +  - "#power-domain-cells"
> +  - power-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    power-domain {
> +        compatible = "nvidia,tegra20-core-domain";
> +        operating-points-v2 = <&opp_table>;
> +        power-supply = <&regulator>;
> +        #power-domain-cells = <0>;

AFAICT, there's no way to access this 'hardware'?

> +    };
> -- 
> 2.30.2
> 
