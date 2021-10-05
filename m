Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 425FE4233C0
	for <lists+linux-pm@lfdr.de>; Wed,  6 Oct 2021 00:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236810AbhJEWrz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Oct 2021 18:47:55 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:43901 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbhJEWry (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Oct 2021 18:47:54 -0400
Received: by mail-ot1-f52.google.com with SMTP id x33-20020a9d37a4000000b0054733a85462so788134otb.10;
        Tue, 05 Oct 2021 15:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=rXuuVcqlOPGRQ8KPZYAGmcmEqaRdABG3AyDsI/H0JEo=;
        b=5M97xTMxwA2Hk+SvV7hrgGEpsSeX+QbhQEm4pI4dXQdmZjkrHhb48cwOgvrbMljcN5
         mT6w9CHc1L4nqy2I2BHxHHMsRPfJwfSDLpQVVaZzw0H3xh9t7bxozlp48tC6AjNukiW8
         go1tv3ekdPSW9vpqSGfoiS8ZJwp2RTjpvMsa6eZTS16JnnCGKwd25AhtzeN0Z8tpRQVW
         /gLyPpU7hHFwXx32+jWtEBAQgDEeWJG83+7X98+m4+PeLSZEPAQBuDkamia3JFW04aBm
         MQSDtmnAzBP3ZHPu3S0b74YQirxEdzf3HQG6j9c0xZhmESmXsaXpOoQ+UChrIkrzR49+
         75+w==
X-Gm-Message-State: AOAM531hoKhBHOZ4l1OgT75hV7T6i95li3l+u6VQG3clR4Qp1dJFYWtQ
        rldwlE1BZM/7LdnYr2Ddcg==
X-Google-Smtp-Source: ABdhPJxu1yHXCK7JsFPVWCnV3YwQqmVgBcxLJQObQXFkUx2eUkxTxDAYsMRWCskB3IZu70rdOx5wmA==
X-Received: by 2002:a9d:72d5:: with SMTP id d21mr17442035otk.181.1633473963274;
        Tue, 05 Oct 2021 15:46:03 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id i127sm3627476oia.43.2021.10.05.15.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 15:46:02 -0700 (PDT)
Received: (nullmailer pid 106785 invoked by uid 1000);
        Tue, 05 Oct 2021 22:45:59 -0000
From:   Rob Herring <robh@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Mark Kettenis <mark.kettenis@xs4all.nl>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Marc Zyngier <maz@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
In-Reply-To: <20211005155923.173399-2-marcan@marcan.st>
References: <20211005155923.173399-1-marcan@marcan.st> <20211005155923.173399-2-marcan@marcan.st>
Subject: Re: [PATCH 1/7] dt-bindings: arm: apple: Add apple,pmgr binding
Date:   Tue, 05 Oct 2021 17:45:59 -0500
Message-Id: <1633473959.420655.106783.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 06 Oct 2021 00:59:17 +0900, Hector Martin wrote:
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
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  .../bindings/arm/apple/apple,pmgr.yaml        | 74 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/arm/apple/apple,pmgr.example.dts:30.40-35.15: ERROR (duplicate_node_names): /example-0/soc/power-management@23b700000: Duplicate node name
ERROR: Input tree has errors, aborting (use -f to force output)
make[1]: *** [scripts/Makefile.lib:385: Documentation/devicetree/bindings/arm/apple/apple,pmgr.example.dt.yaml] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1441: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1536742

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

