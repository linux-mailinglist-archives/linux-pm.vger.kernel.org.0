Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23E25B984F
	for <lists+linux-pm@lfdr.de>; Thu, 15 Sep 2022 11:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbiIOJzs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Sep 2022 05:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbiIOJyi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Sep 2022 05:54:38 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2FB9C1E7
        for <linux-pm@vger.kernel.org>; Thu, 15 Sep 2022 02:51:28 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id u15-20020a05600c19cf00b003b4acef34b1so842593wmq.4
        for <linux-pm@vger.kernel.org>; Thu, 15 Sep 2022 02:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=wjD3Rda5b0oR4mJqCQK7HYHWqvwSAKNkgLt/eJ3V0/U=;
        b=BGVWdbev+6iSQl6A8jyRQ3AY4iJda+FLNqE/QSyTXnMSd/IzDYBzxfY7KRJb3I8AiZ
         NKtbYXRVjlY58IB+e9x/Ngsn/z+4wp/Ny2k2l7Eeii3lJ1jZAF9fUY2oZBRdEWSjWQ9Z
         XNUsUX497/OD1DIGGlV5nImLSDTiEz7nkLQUW5zi1CaCaI4jALgnk6RK/nB7D4AoHWwU
         4fFOtBfRA17eKntdX0Y+vl8w7My1rhWYy4bNYbvkErlWHaucIiIOJoLfTLzuRU+dOZHN
         tT636NqwcQIuTcQzwxZPKoyvgwnhvIUWAKYVn9uKaOll7OrissiHeFAt+dO55SQ7G/65
         AITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=wjD3Rda5b0oR4mJqCQK7HYHWqvwSAKNkgLt/eJ3V0/U=;
        b=Uh3B33ilCKx5B3radK3FVETw51ZXSv9m2rRUnLP5QqtZ0a0gWTXrTkXlmY8xrbvwZV
         +bbHGHq0xQFVOqjdMNGMZ+RzWHz97nx+m8krle87xlnjxDTYnSAjfiXT7iijp+0O9Cv+
         Xvfz4m0wW3bXdYYXDflf9okwLQEdfHDx2uNy5MWmscMRBCTkgeErat7gUaljvJMzDEqz
         dBY0YltrrcGZxX/iQPr2OrS+qMFdismy9PecEXkrmR3TjrAY2b4W7fD2MggvblvYu1fq
         IYhKNtkuTYgyUnU3FyWfTHjKJqbCIEaP8bL5IZiVrdP+muf48NkYsyO6sVihPUoBbwmH
         7N6A==
X-Gm-Message-State: ACgBeo2xeSoEYKxnZlKtJ3j9ds2TePg5BLR4EX7byJGF0fErPny5cyS5
        UxFqsExDYFaJkmQQUfcr9KS1Zw==
X-Google-Smtp-Source: AA6agR4DH9zplXQIZi6cCraYB02fxzCPyryWneL2J0OFL4KuChOQ+g+Yd/wMITPSdeNkEUfShn+iiw==
X-Received: by 2002:a05:600c:4fce:b0:3b4:935f:b952 with SMTP id o14-20020a05600c4fce00b003b4935fb952mr5995633wmq.197.1663235483265;
        Thu, 15 Sep 2022 02:51:23 -0700 (PDT)
Received: from krzk-bin ([89.101.193.73])
        by smtp.gmail.com with ESMTPSA id k22-20020a05600c1c9600b003a3442f1229sm2313343wms.29.2022.09.15.02.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 02:51:22 -0700 (PDT)
Date:   Thu, 15 Sep 2022 10:51:21 +0100
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     sre@kernel.org, alina_yu@richtek.com, alinayu829@gmail.com,
        linux-pm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        cy_huang@richtek.com, mazziesaccount@gmail.com, robh+dt@kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: power: supply: Add Richtek RT9471
 battery charger
Message-ID: <20220915095121.lh5c5gbn53qedtgw@krzk-bin>
References: <1663173015-7934-1-git-send-email-u0084500@gmail.com>
 <1663173015-7934-2-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1663173015-7934-2-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 15 Sep 2022 00:30:13 +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add bindings for the Richtek RT9471 I2C controlled battery charger.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Co-developed-by: Alina Yu <alina_yu@richtek.com>
> Signed-off-by: Alina Yu <alina_yu@richtek.com>
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
> Since v3
> - Move unevaluatedProperties line after $ref for binding patch.
> - Add Reviewed-by tag for binding patch.
> 
> Since v2
> - Remove the properties for interrupt controller things in the binding documentation.
> - Fix dtc error for typo, it's 'regulator-name', not 'regulator-compatible'.
> - Add regulator min/max microamp to allow otg vbus current adjustable in example.
> - Specify the active-level for charge-enable-gpios in binding example.
> 
> ---
>  .../bindings/power/supply/richtek,rt9471.yaml      | 73 ++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt9471.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.example.dtb: dma-router@a0: dma-masters:0: [4294967295, 4294967295] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.example.dtb: dma-router@a0: dma-masters:0: [4294967295, 4294967295] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/dma-router.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/st,stm32-dmamux.example.dtb: dma-router@40020800: dma-masters:0: [4294967295, 4294967295] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/dma-router.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/st,stm32-dmamux.example.dtb: dma-router@40020800: dma-masters:0: [4294967295, 4294967295] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/st,stm32-dmamux.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/st,stm32-dmamux.example.dtb: dma-router@40020800: Unevaluated properties are not allowed ('dma-channels', 'dma-masters', 'dma-requests' were unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/st,stm32-dmamux.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.
