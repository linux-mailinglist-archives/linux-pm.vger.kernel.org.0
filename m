Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B494A6E2BDA
	for <lists+linux-pm@lfdr.de>; Fri, 14 Apr 2023 23:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjDNVsC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Apr 2023 17:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjDNVsB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Apr 2023 17:48:01 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393C42D6D
        for <linux-pm@vger.kernel.org>; Fri, 14 Apr 2023 14:48:00 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-504eb1155d3so13506870a12.1
        for <linux-pm@vger.kernel.org>; Fri, 14 Apr 2023 14:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681508878; x=1684100878;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3EVZPS7cfZtkMpVcoeHTNj5NWFzlcFiikQhX7e7eo7s=;
        b=oIKjcQ5bA3LZIj+MtHEU4gp7gZWetvnXUBlEDfdBhf7gL5Wvs1HRCG4FPxaBqH8pso
         3zrd/j511kb7/GQPqGXt3D0rqQs66pkRdbbuW/7dg9EMolAo0k2q2HuU3oqzxbdWV1vH
         zQtK1kl2NepczBZdGgiesQcpnBqc03G4wnYMZy54qu3cI59KWI98u+w+tCFH360uBQ+L
         71+vf6AESb5obKm+RLh1gPoDojrdB564W6QtGpu42eRNOmzAoHSSwjFKJ3PwAuBA5+UC
         kdm6pGp14QECBMnHonGDtPmgSX+/YDkKsqDlSZ6sLueUzF9e0e7kzgSbOLBDnzxjUVdH
         R6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681508878; x=1684100878;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3EVZPS7cfZtkMpVcoeHTNj5NWFzlcFiikQhX7e7eo7s=;
        b=PJwABtSCYFodOd3Yb6OhVbahWit0NgZyK165W2wvqOOm5TsuhGxLNIOogQ0N/pOVM+
         1swXtXfIBhF6+WL56ruIFRCYNSsKSd+jdKXpuu/o9X5Eqn7I9ImmbeIrHh3NtKSNEv80
         UasDp/jTumtBnwKvjHJxciSBNr6UUFxblXrRUszMPosU6KEw50LvMfZ2MM6JAErETWuA
         JXWjKy6lEz2UKyxbREYI/99YeRMSOsJbI4aMKnhgPWNHscpOv510uW1Z1+rrAJulynpl
         QsQsHAzbtcvY0aAOjGWjeIIJF9PFguTLnPdIqRtN0hXQIcLKAl2MsFhTR/I/c5rB+GwU
         Tj0Q==
X-Gm-Message-State: AAQBX9dM/5+k6bRBcrJ67zmBfFxH7wcDi3uDeKy1Oy1KNZWabc0aew21
        qE+COHBsPHgIZy5/wK52vHAEyw==
X-Google-Smtp-Source: AKy350Zd7mIwQhRcrPhJL46mGi+B2WmInMBjqPo7ce+h/92m7V5Dbt/VUSCHLDLUeD0k87Zjl8iA/w==
X-Received: by 2002:a05:6402:114e:b0:504:9e79:e86f with SMTP id g14-20020a056402114e00b005049e79e86fmr7272505edw.18.1681508878492;
        Fri, 14 Apr 2023 14:47:58 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ffae:8aab:ae5a:4688? ([2a02:810d:15c0:828:ffae:8aab:ae5a:4688])
        by smtp.gmail.com with ESMTPSA id c18-20020aa7c752000000b00501d73cfc86sm2562459eds.9.2023.04.14.14.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 14:47:58 -0700 (PDT)
Message-ID: <187d51b3-6fec-7a25-e472-3d9020c12db5@linaro.org>
Date:   Fri, 14 Apr 2023 23:47:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 01/10] dt-bindings: thermal: tegra: Document throttle
 temperature
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20230414125721.1043589-1-thierry.reding@gmail.com>
 <20230414125721.1043589-2-thierry.reding@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230414125721.1043589-2-thierry.reding@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14/04/2023 14:57, Thierry Reding wrote:
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
>  .../bindings/thermal/nvidia,tegra124-soctherm.yaml         | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml
> index 4677ad6645a5..37dac851f486 100644
> --- a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml
> +++ b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml

File does not exist in next and no dependency is mentioned, so tricky to
review and figure out context. Without context the comment is:


> @@ -120,6 +120,13 @@ properties:
>                # high (85%, TEGRA_SOCTHERM_THROT_LEVEL_HIGH)
>                - 3
>  
> +          temperature:
> +            $ref: /schemas/types.yaml#/definitions/int32

Use -millicelsius suffix instead:
https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml

> +            minimum: -273000
> +            maximum: 200000
> +            description: The temperature threshold (in millicelsius) that,
> +              when crossed, will trigger the configured automatic throttling.

Don't you want some hysteresis? Or is it already using trips binding?
But in that case you should skip the $ref and maximum - they come from
thermal-zones, don't they?

Best regards,
Krzysztof

