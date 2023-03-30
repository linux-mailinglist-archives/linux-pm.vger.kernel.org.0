Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F556CFCC4
	for <lists+linux-pm@lfdr.de>; Thu, 30 Mar 2023 09:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjC3HbQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Mar 2023 03:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjC3HbE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Mar 2023 03:31:04 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F014C448D
        for <linux-pm@vger.kernel.org>; Thu, 30 Mar 2023 00:31:01 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id t17-20020a05600c451100b003edc906aeeaso2830193wmo.1
        for <linux-pm@vger.kernel.org>; Thu, 30 Mar 2023 00:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680161460;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QUX3Tzegj17UnE0hZyGQmi2GdvNc02HxGqTB2+a5Gz8=;
        b=Qlwd5HPPBFd213yHc2eI14pWMFFCVwFZBZZRHl/qI+nuV2wE56C883LJ+eQdquNWn/
         uQSG/tPF9cfZUiAUc6usBGPbC9+DaCq/6Zt3Eqtm5ODakJ/yRlmBFcducl1veB/tUlvv
         1NM5zbmHWnC/arMlvuwksYmdOrq3AVDXtcsBYk5bhoiFj+o/45i+994Z/gQJdsX2FdmM
         OhIWTZi4yy/krinSWcB68OA25K1lVzYdsAkjKjZSLcku4BxdwfO1ZhWoyy/iy4ESzgd+
         20jsMAJlSHWp7e0nGNvjAnUZp7dxGk3oGmKbRyDTgYFOqYJavbT/RE3w5UXt5LChDZdf
         7CUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680161460;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUX3Tzegj17UnE0hZyGQmi2GdvNc02HxGqTB2+a5Gz8=;
        b=4IEp+PFBD5yCW60ihXOoYlF3jOzO694i4h7S/vUWwkzi3EAHB4PnyGvvg7YtGK3r4S
         GJMVUi4fAUAnx6fbilK0h50FihvdU+HPysAYjgSHzaR2gLZUk4+jzluTAee6UkUWX3re
         24uZB94ZWW3iBXF42dQMi0fUTPPppHjM2O7YPA3U2QkygvGoLtklsVLx/1zhXqBrtWSV
         rJukztbvfJSxLzSu6FJMgSw5ONJPdqFzr27BzdD7duipvmsK6v5KZXASdgBGP1REls0A
         P71ONzA+f1PM+zkmiA6GaT5AAF/sdYR9vjcZSdZfXrOqxfi5fyrawLHZ0eogKuUvuYr0
         X4jg==
X-Gm-Message-State: AAQBX9dSNVvl6i2YxV3ZEMYs71bIEHv8m1khn884VEgMt1X+bxMNiAZ4
        31FQybFc0Y4PmxMAiF5LMqzEhw==
X-Google-Smtp-Source: AKy350bjotFP/XBk1/qhgZLh89YarXni2rWhsdlu+qdqyUFwYUWVCR65iK9O9umE+5xSwPXg3FjJyw==
X-Received: by 2002:a05:600c:b49:b0:3ef:5fe3:c57c with SMTP id k9-20020a05600c0b4900b003ef5fe3c57cmr15371251wmr.23.1680161460354;
        Thu, 30 Mar 2023 00:31:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:fe8e:8291:fc25:6c8f? ([2a01:e0a:982:cbb0:fe8e:8291:fc25:6c8f])
        by smtp.gmail.com with ESMTPSA id q3-20020a05600c46c300b003ebf73acf9asm10933201wmo.3.2023.03.30.00.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 00:31:00 -0700 (PDT)
Message-ID: <ffd680c3-f0b9-7e8a-1328-b858ecedf04a@linaro.org>
Date:   Thu, 30 Mar 2023 09:30:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] dt-bindings: thermal: Drop unneeded quotes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Guillaume La Roque <glaroque@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230327170233.4109156-1-robh@kernel.org>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20230327170233.4109156-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27/03/2023 19:02, Rob Herring wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   .../devicetree/bindings/thermal/amlogic,thermal.yaml          | 2 +-

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

>   Documentation/devicetree/bindings/thermal/imx-thermal.yaml    | 4 ++--
>   Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml  | 4 ++--
>   3 files changed, 5 insertions(+), 5 deletions(-)
> 

<snip>

