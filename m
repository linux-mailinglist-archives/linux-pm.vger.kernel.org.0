Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3AD7CAAED
	for <lists+linux-pm@lfdr.de>; Mon, 16 Oct 2023 16:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbjJPODd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Oct 2023 10:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233695AbjJPODU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Oct 2023 10:03:20 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945751AC;
        Mon, 16 Oct 2023 07:02:52 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6c64a3c4912so3236411a34.3;
        Mon, 16 Oct 2023 07:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697464971; x=1698069771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPwOcKolA5h59LfiwhDD2NsiWDiYTaeF64Ez9uATyPQ=;
        b=RonnbeL+twCYiA6d79iP+7XIaQC0Hn0CNAMI1GIvR0bTCMeoN1hldlyjNV9YumgPIQ
         XTWhCQrnD15vxNwOkCkuDaY93zj0cnua8cLzbYw0E3aDMnNaJNWqLdtsCrG8YmugD0h+
         a+4cHXkF3xI2lShe1vjqf9h0d3bd3wMEW9YCroHGDGYSwDkuWUty6vA148fSTxDhRHct
         4T6L2YlgHkbEpHA1HD8MzJogUYJiQt/6eSKho9Ja3dsN7JV4hVicsUrk+KVLQHi03+7b
         1IrjY19CvkiqcxBrVV/wV+6e75p8lAMhZe8w5BnyLB5euiytrCIdhpkOvw6KPuT7nuVj
         BLbQ==
X-Gm-Message-State: AOJu0YwDH3DzPTFzhioWbdsEdSNsz0ZC05eyQqAZa9npotInM/yo3gyO
        NagfO/Ss3ONIjNLcKIjVWw==
X-Google-Smtp-Source: AGHT+IGtFSHkWAYs7Rmg3ynupfWgMC2K0w58JDQY6Ll10QBud020o2yHbCZ3OrASx4vDGZ+riEGT+A==
X-Received: by 2002:a05:6870:7d12:b0:1ea:3746:b7d6 with SMTP id os18-20020a0568707d1200b001ea3746b7d6mr4026697oab.28.1697464971594;
        Mon, 16 Oct 2023 07:02:51 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id gk24-20020a0568703c1800b001dcde628a6fsm2016544oab.42.2023.10.16.07.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 07:02:50 -0700 (PDT)
Received: (nullmailer pid 2677955 invoked by uid 1000);
        Mon, 16 Oct 2023 14:02:49 -0000
Date:   Mon, 16 Oct 2023 09:02:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 02/13] dt-bindings: thermal: tegra: Document throttle
 temperature
Message-ID: <20231016140249.GA2655027-robh@kernel.org>
References: <20231012175836.3408077-1-thierry.reding@gmail.com>
 <20231012175836.3408077-3-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012175836.3408077-3-thierry.reding@gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 12, 2023 at 07:58:23PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Each throttling configuration needs to specify the temperature threshold
> at which it should start throttling. Previously this was tied to a given
> trip point as a cooling device and used the temperature specified for
> that trip point. This doesn't work well because the throttling mechanism
> is not a cooling device in the traditional sense.
> 
> Instead, allow device trees to specify the throttle temperature in the
> throttle configuration directly so that the throttle doesn't need to be
> exposed as a cooling device.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v2:
> - rename temperature to temperature-millicelsius and drop $ref
> - add hysteresis-millicelsius property
> 
>  .../bindings/thermal/nvidia,tegra124-soctherm.yaml | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml
> index 04a2ba1aa946..0eb6277082fe 100644
> --- a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml
> +++ b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml
> @@ -121,6 +121,20 @@ properties:
>                # high (85%, TEGRA_SOCTHERM_THROT_LEVEL_HIGH)
>                - 3
>  
> +          temperature-millicelsius:

'temperature' is redundant since we have units. Perhaps 
'throttle-millicelsius' or 'auto-throttle-millicelsius' instead to say 
what the temperature is for.

> +            minimum: -273000
> +            maximum: 200000

Quite impressive operating range.

> +            description: The temperature threshold (in millicelsius) that,
> +              when crossed, will trigger the configured automatic throttling.
> +
> +          hysteresis-millicelsius:
> +            description: An unsigned integer expressing the hysteresis delta
> +              (in millicelsius) with respect to the threshold temperature
> +              property above. Throttling will be initiated when the
> +              temperature falls below (temperature - hysteresis). This avoids
> +              situations where throttling is repeatedly initiated and stopped
> +              because of minor temperature variations.
> +
>            # optional
>            # Tegra210 specific and valid only for OCx throttle events
>            nvidia,count-threshold:
> -- 
> 2.42.0
> 
