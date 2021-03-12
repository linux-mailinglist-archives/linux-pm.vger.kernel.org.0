Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0EC2338FD6
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 15:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhCLOXw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 09:23:52 -0500
Received: from mail-il1-f177.google.com ([209.85.166.177]:38919 "EHLO
        mail-il1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbhCLOXe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 09:23:34 -0500
Received: by mail-il1-f177.google.com with SMTP id d5so2709781iln.6;
        Fri, 12 Mar 2021 06:23:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=XxHhsjwJy7g25WZK0LUSCqs3RaOKr506xmdEiRVWi2k=;
        b=qOsJ5EcJkWeZs/Yxxh+gFrzJ36XPfB/zJefPVOW7TQBDOYW0XvBD62YJz4FcMXaup7
         wjKIwOBPWHDzcBKyiDWvzL7LbqWMPNLKwmkCCByncjFp6RNqT/pgJGXP3APGexf/UmwK
         jeBLrZJ8y7qtMdvU1YhISrwtITLgiV2M3ym6NdB8VYVMTeGwf2LO+7ANVK4z17xGmEE5
         rPOFgAaO9jV6e+ki4yXALvrlbYWC9nnxo8cPUomVw2pzYz7wVVZVafV9/P8NAUEBOiI0
         R3VEM0fHElNltwsZOq/SwOXSD3DowMmd6mTPeVjnt2SXbwcRclZHkDjESQyPumuHukBj
         igNQ==
X-Gm-Message-State: AOAM531X4htN1b2DBFwQPpnMVTaBBO6EUvBGcBwaasXzCsJhYRi2Eze1
        ygB2zeuYKzKR7yx4UQ3I1NRie/B6UQ==
X-Google-Smtp-Source: ABdhPJxJpjz2GBDwmGLUkq6ApU5syUA42rdXTaVJFTACslbCnbG7UUeYEm+3qBCpJUXwA+woWTYoXw==
X-Received: by 2002:a92:194b:: with SMTP id e11mr2925546ilm.184.1615559013695;
        Fri, 12 Mar 2021 06:23:33 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id 23sm3162088iog.45.2021.03.12.06.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 06:23:32 -0800 (PST)
Received: (nullmailer pid 2976050 invoked by uid 1000);
        Fri, 12 Mar 2021 14:23:29 -0000
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>, linux-tegra@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?b?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Paul Fertser <fercerpav@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
In-Reply-To: <20210311231208.18180-4-digetx@gmail.com>
References: <20210311231208.18180-1-digetx@gmail.com> <20210311231208.18180-4-digetx@gmail.com>
Subject: Re: [PATCH v3 3/6] dt-bindings: power: tegra: Add binding for core power domain
Date:   Fri, 12 Mar 2021 07:23:29 -0700
Message-Id: <1615559009.777144.2976049.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 12 Mar 2021 02:12:05 +0300, Dmitry Osipenko wrote:
> All NVIDIA Tegra SoCs have a core power domain where majority of hardware
> blocks reside. Add binding for the core power domain.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../power/nvidia,tegra20-core-domain.yaml     | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/nvidia,tegra20-core-domain.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/nvidia,tegra20-core-domain.yaml: properties:power-supply: '$ref' is not one of ['description', 'deprecated']
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/nvidia,tegra20-core-domain.yaml: ignoring, error in schema: properties: power-supply
warning: no schema found in file: ./Documentation/devicetree/bindings/power/nvidia,tegra20-core-domain.yaml

See https://patchwork.ozlabs.org/patch/1451596

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

