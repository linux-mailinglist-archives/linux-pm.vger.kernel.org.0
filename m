Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F877439E49
	for <lists+linux-pm@lfdr.de>; Mon, 25 Oct 2021 20:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbhJYSTX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Oct 2021 14:19:23 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:41825 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbhJYSTW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Oct 2021 14:19:22 -0400
Received: by mail-oi1-f175.google.com with SMTP id bk18so16733754oib.8;
        Mon, 25 Oct 2021 11:16:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=Lyqko9K5CNpuulq5fTWgmejJBlukgz109+8AdIwyZeg=;
        b=6jzV5mlX9wN9CQsejPELhdNvEp3CP+mA1bA/rP6K4CI4bEjibXwDYxdrdMN6G3VeFh
         pIEAXpUJz164ZrXRIjpmxwqlSJNaqagHY8YHInHXgQT4k38TQZACj5yjEj6oDDmiSbbX
         v/WCUGkRlF/XJzapWRWEqNhO24bPHWzIwZEK7uJRt8mxJhGwpJjxzgyWMW2q/AYKhiKI
         RXpzQ/zUfXX2ENWk+qGK4YuBklWPu2ZesaHi/nJRS2eLjSJzqSD3cD+XeYrSN/gkgPyR
         rDn7OfMe5v4o2Bb0ouEiYPQ6zsYsYi4JdZKzS4xAQj0YnypKyI7o/e+IGloQPar3glwx
         Jo1A==
X-Gm-Message-State: AOAM5331U9BG6GGeEUSOgewwfsbrXtmbwZ/LHI5RihORjSMWSzjsJ6LV
        9Ygmdcg3/Kce1OYxGYUVFw==
X-Google-Smtp-Source: ABdhPJzp9OGN83oZTFi2rEzMtuqGmvWeJhBPEhk8aKnuCt6JuQx/pPBCzqmQgVfycWOQJJFtVKypXQ==
X-Received: by 2002:aca:bd08:: with SMTP id n8mr23545547oif.27.1635185819138;
        Mon, 25 Oct 2021 11:16:59 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s5sm4108764ois.55.2021.10.25.11.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 11:16:58 -0700 (PDT)
Received: (nullmailer pid 824868 invoked by uid 1000);
        Mon, 25 Oct 2021 18:16:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Mark Kettenis <kettenis@openbsd.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Arnd Bergmann <arnd@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Hovold <johan@kernel.org>
In-Reply-To: <20211025144718.157794-3-marcan@marcan.st>
References: <20211025144718.157794-1-marcan@marcan.st> <20211025144718.157794-3-marcan@marcan.st>
Subject: Re: [PATCH v2 2/8] dt-bindings: arm: apple: Add apple,pmgr binding
Date:   Mon, 25 Oct 2021 13:16:53 -0500
Message-Id: <1635185813.758208.824867.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 25 Oct 2021 23:47:12 +0900, Hector Martin wrote:
> The PMGR block in Apple Silicon SoCs is responsible for SoC power
> management. There are two PMGRs in T8103, with different register
> layouts but compatible registers. In order to support this as well
> as future SoC generations with backwards-compatible registers, we
> declare these blocks as syscons and bind to individual registers
> in child nodes. Each register controls one SoC device.
> 
> The respective apple compatibles are defined in case device-specific
> quirks are necessary in the future, but currently these nodes are
> expected to be bound by the generic syscon driver.
> 
> Reviewed-by: Mark Kettenis <kettenis@openbsd.org>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  .../bindings/arm/apple/apple,pmgr.yaml        | 149 ++++++++++++++++++
>  1 file changed, 149 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Unknown file referenced: [Errno 2] No such file or directory: '/usr/local/lib/python3.8/dist-packages/dtschema/power/apple,pmgr-pwrstate.yaml'
xargs: dt-doc-validate: exited with status 255; aborting
make[1]: *** Deleting file 'Documentation/devicetree/bindings/arm/apple/apple,pmgr.example.dt.yaml'
Unknown file referenced: [Errno 2] No such file or directory: '/usr/local/lib/python3.8/dist-packages/dtschema/power/apple,pmgr-pwrstate.yaml'
make[1]: *** [scripts/Makefile.lib:385: Documentation/devicetree/bindings/arm/apple/apple,pmgr.example.dt.yaml] Error 255
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1441: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1545799

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

