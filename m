Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1DE6FB305
	for <lists+linux-pm@lfdr.de>; Mon,  8 May 2023 16:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbjEHOdY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 May 2023 10:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbjEHOdT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 May 2023 10:33:19 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAF92129
        for <linux-pm@vger.kernel.org>; Mon,  8 May 2023 07:32:54 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50bc075d6b2so8804915a12.0
        for <linux-pm@vger.kernel.org>; Mon, 08 May 2023 07:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683556358; x=1686148358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4xEWfojYnTe2mBCOhkIiunpXCwHW6YNXjL9pSeBLbpc=;
        b=rxV/mKMPjy0DiiqJTDPN8RVP70arEldVclwFNTwWTkVUw7VYpyo2OiEdUNjhGvbXyy
         NaL1T4hi9co9TM/BBpDIkOpE+VfO0keDZpV9e+KA8ADqSOGlO1/G3fJxIsFuUVPFR2jM
         7XFSJqSg9/Tnk+yZpodKCTVjLbxFZtbnwel8BqZCL6MRyjyXJaoxU7UT31f34XwT5LE2
         AIYpzsGsGeUwaHZvldVjLSnG+rKfuXoH6jX6PDzJzFEvlZhS5TnY52XOlkvKX0ckUyvD
         X4pOWSbqWn1fHwRBoD2tIDilm3J5D/OfYt1h8hcvuH3GpD3IxanJEyAudHFsSrmqt+c0
         GBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683556358; x=1686148358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xEWfojYnTe2mBCOhkIiunpXCwHW6YNXjL9pSeBLbpc=;
        b=ds5GHbogYDJ1uRYzXJIq5w0X5Ly3noOS1loOEmzRAUGWto0jzUxlREHx1h4GLFOw3t
         ls5v62SDvZhp/go26JVMBJ7ZFn0bI4Dni6sMKWts6NphZWFP5cV92oyeGJJWDVcS4X/F
         EYkmfXeme5fi2t9VoSFVMI/g1DbWStulfSmkAVFOc0HPHgMeHyZ28g+9G0FunwdxrOo0
         jsFqUp085h1JqAtNekGTZR6WbsWJJ4UyghZJXe7PjWoOrTrKeI0t2lG+ktn3cmW8JGga
         v64Xx4zUDXH5Gq+QZEyg95s67b3J4vEhIXFA9OZhEwWMErhT0GW0m9bDPEFrqqy5zGRl
         0+gQ==
X-Gm-Message-State: AC+VfDy+q7BNzqrhq7WWFMWkpEzBnpMrDGNSCqO5gaDBLPjAB1OjDyGW
        jiAk2wd4+Ad9OlCXhqDg91Fsvg==
X-Google-Smtp-Source: ACHHUZ630NocRmqT8GJ7xrFqI6iSlN99j7hzlCF9HNg1E8U+jk1IMJ1q4V4DHoGhfNqYu53An0TGaA==
X-Received: by 2002:a17:907:318b:b0:957:17c5:8705 with SMTP id xe11-20020a170907318b00b0095717c58705mr7900723ejb.51.1683556358140;
        Mon, 08 May 2023 07:32:38 -0700 (PDT)
Received: from krzk-bin ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id ku11-20020a170907788b00b0094f5179540fsm47127ejc.83.2023.05.08.07.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 07:32:37 -0700 (PDT)
Date:   Mon, 8 May 2023 16:32:35 +0200
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
Cc:     sre@kernel.org, Nurettin Bolucu <Nurettin.Bolucu@analog.com>,
        broonie@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com
Subject: Re: [PATCH v3 2/7] dt-bindings: power: supply: max77658: Add ADI
 MAX77654/58/59 Charger
Message-ID: <20230508143235.57c4jojkloqavrpo@krzk-bin>
References: <20230508131045.9399-1-Zeynep.Arslanbenzer@analog.com>
 <20230508131045.9399-3-Zeynep.Arslanbenzer@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230508131045.9399-3-Zeynep.Arslanbenzer@analog.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 08 May 2023 16:10:40 +0300, Zeynep Arslanbenzer wrote:
> Add ADI MAX77654/58/59 power supply devicetree document.
> 
> Signed-off-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>
> Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> ---
>  .../power/supply/adi,max77658-charger.yaml    | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/adi,max77658-charger.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

doc reference errors (make refcheckdocs):
Documentation/devicetree/bindings/power/supply/adi,max77658-charger.yaml: Documentation/devicetree/bindings/mfd/adi,max77658.yaml

See https://patchwork.ozlabs.org/patch/1778407

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.
