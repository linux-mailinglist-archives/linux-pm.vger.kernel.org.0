Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0715439E45
	for <lists+linux-pm@lfdr.de>; Mon, 25 Oct 2021 20:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbhJYSTV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Oct 2021 14:19:21 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:46960 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbhJYSTV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Oct 2021 14:19:21 -0400
Received: by mail-oi1-f180.google.com with SMTP id o204so16731923oih.13;
        Mon, 25 Oct 2021 11:16:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=c8iDrdrscM2c58XhHr9hAeNjE08nH97DcHB6REi5ScM=;
        b=MVMb4je/U+cCTo504rqWYnOqCy1cqJD+pgleJIqmP7nhjJ8YxrBp4+fXXe6FcXnBhl
         eJyBZoRgu6/2TOsL4tiHghjT/qxTJ/Isx06iwalEn96k++a6vFjvr12Mpkkfud775rNR
         J0tzTCqppreRmWpGt9IRh4ZirYb5OSiE6EskrTIyxMcG6S5GOwogXFYsFFzRh0Cdwr1J
         XpMKUM4xy5mwjLsMhc8F1eSlRGlJtfGCfhPVJNc0E90+hx+OqZrTbxeilM9Qxy0cRaVV
         a0mzk/q5g+g9+/SCKYNR45lm0cSs26UYaZpB/p2QVBbcZMPhBT5LwUygrFiMxi4n24UH
         BDWA==
X-Gm-Message-State: AOAM5327t8cYkBEgpQimh6rHO9guNz6Pumh60zwfayQo6IhT8vNaNri8
        mXXx5o5/OPn+X6ckz01+fA==
X-Google-Smtp-Source: ABdhPJzt9UxcoWWAoSw1waWa4o7cP/4BdO3Lt0f7+VkpxhBaAKmqzO61CJbl9tB6ZxiVOi2kQsPn2g==
X-Received: by 2002:a05:6808:158c:: with SMTP id t12mr23688907oiw.74.1635185817319;
        Mon, 25 Oct 2021 11:16:57 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id z8sm3050765oof.47.2021.10.25.11.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 11:16:56 -0700 (PDT)
Received: (nullmailer pid 824870 invoked by uid 1000);
        Mon, 25 Oct 2021 18:16:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Johan Hovold <johan@kernel.org>
In-Reply-To: <20211025144718.157794-4-marcan@marcan.st>
References: <20211025144718.157794-1-marcan@marcan.st> <20211025144718.157794-4-marcan@marcan.st>
Subject: Re: [PATCH v2 3/8] dt-bindings: power: Add apple,pmgr-pwrstate binding
Date:   Mon, 25 Oct 2021 13:16:53 -0500
Message-Id: <1635185813.771483.824869.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 25 Oct 2021 23:47:13 +0900, Hector Martin wrote:
> This syscon child node represents a single SoC device controlled by the
> PMGR block. This layout allows us to declare all device power state
> controls (power/clock gating and reset) in the device tree, including
> dependencies, instead of hardcoding it into the driver. The register
> layout is uniform.
> 
> Each pmgr-pwrstate node provides genpd and reset features, to be
> consumed by downstream device nodes.
> 
> Future SoCs are expected to use backwards compatible registers, and the
> "apple,pmgr-pwrstate" represents any such interfaces (possibly with
> additional features gated by the more specific compatible), allowing
> them to be bound without driver updates. If a backwards incompatible
> change is introduced in future SoCs, it will require a new compatible,
> such as "apple,pmgr-pwrstate-v2".
> 
> Reviewed-by: Mark Kettenis <kettenis@openbsd.org>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  .../bindings/power/apple,pmgr-pwrstate.yaml   | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):
Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml: Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml

See https://patchwork.ozlabs.org/patch/1545800

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

