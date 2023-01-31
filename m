Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965606822D9
	for <lists+linux-pm@lfdr.de>; Tue, 31 Jan 2023 04:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjAaDbr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Jan 2023 22:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjAaDbq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Jan 2023 22:31:46 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999FB1CAD8
        for <linux-pm@vger.kernel.org>; Mon, 30 Jan 2023 19:31:45 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id j5so12994218pjn.5
        for <linux-pm@vger.kernel.org>; Mon, 30 Jan 2023 19:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iDi6IM/MaPJ/3n0t/k9AegJIGfm9vzz6t4MiBeVwT9A=;
        b=NkPYUsYiLUOZlIG9EyWyy1qJsJQ0dtFO2oALntKqx5o32aklVgo3idQTfkuLsG3hAd
         jeDEAuGbZA8nj/vCCmVof27GomGGQLFyu45IR/MWwqV3yctcAXJHAkJCGd/rptdKN16y
         /dskoEbuflEPnkl7QgrIeGRfmzyEmQlwIJqocmO4Uu+0fbbCZffQbdMY2m3Ilj4FlNGe
         GrnEWVcfI4uU1oWhAE4qd+qlLopmdDMN3dMW4Z1WgT9gfujhmglsXrsF95eDn8u8HHsA
         L2MW+EPtRhmI30Kq3z6LV04RqZlCxuLpXBrVmEHw7cz7nNzEGmWWlXcPJRTrVlf7VoK/
         Hqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDi6IM/MaPJ/3n0t/k9AegJIGfm9vzz6t4MiBeVwT9A=;
        b=ZRxTG/1Unti2gLoB4OirVyvNR5ei4s5oiLGhe/4R7pjNDzuevQqglTG6qikucGQohm
         lrlU9YydrrZa6BuTm1vlWTy3aFl+HFHjOU1km2PAn+c7nN0wAxmmzQfJvsWIcRUvQ3K8
         TEJIxAl5sQtWmHvjGObS7pQ+p6dqaN2C8XF6bHqi2F0e9XM9+eAogTCUSNgXLkplHZu2
         O2He0gIURFtwIs4yBjeBUJXd1hnhIZ+2wvrK2JqaruAexiRrUYY0JNlxpNZb6Wqk1xEj
         miiiBsRd5FCaPbsDQsLRKfU6e+taDj69eD5YtIcGKiRXXFgEdc4aLN5lnWTCBCZvL2Kg
         i8sw==
X-Gm-Message-State: AO0yUKVy03LqOGsDNzDpK/sIUC78Mn0RZaUxHRoPpF9nDWMv/0hq3o7N
        dxNyouFk7Idop6LsSTrkypg1PQ==
X-Google-Smtp-Source: AK7set8Paapy/h78JoHz48aSDiy+HfPZsFgLg5+P131bwxrtUytlBCWxTII/Ts7bbR26BqvEwL7v9g==
X-Received: by 2002:a05:6a20:5484:b0:bc:244a:c43e with SMTP id i4-20020a056a20548400b000bc244ac43emr19530680pzk.55.1675135905090;
        Mon, 30 Jan 2023 19:31:45 -0800 (PST)
Received: from localhost ([122.172.83.155])
        by smtp.gmail.com with ESMTPSA id b17-20020a639311000000b00478c48cf73csm7528002pge.82.2023.01.30.19.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 19:31:44 -0800 (PST)
Date:   Tue, 31 Jan 2023 09:01:42 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: cpufreq: cpufreq-qcom-hw: Add SM8550
 compatible
Message-ID: <20230131033142.oykyybqia32lwi6r@vireshk-i7>
References: <20230130123046.3229654-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130123046.3229654-1-abel.vesa@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30-01-23, 14:30, Abel Vesa wrote:
> Add compatible for EPSS CPUFREQ-HW on SM8550.
> Also document the interrupts.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 
> The v1 is here:
> https://lore.kernel.org/all/20221116115046.2687244-1-abel.vesa@linaro.org/
> 
> Changes since v1:
>  * dropped the interrupts related properties as they are already there.
> 
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> index 2494e90a2fda..e4aa8c67d532 100644
> --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> @@ -32,6 +32,7 @@ properties:
>                - qcom,sm8250-cpufreq-epss
>                - qcom,sm8350-cpufreq-epss
>                - qcom,sm8450-cpufreq-epss
> +              - qcom,sm8550-cpufreq-epss
>            - const: qcom,cpufreq-epss
>  
>    reg:

Applied. Thanks.

-- 
viresh
