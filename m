Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BA26CB7EA
	for <lists+linux-pm@lfdr.de>; Tue, 28 Mar 2023 09:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjC1HXN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Mar 2023 03:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjC1HXM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Mar 2023 03:23:12 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAB32700
        for <linux-pm@vger.kernel.org>; Tue, 28 Mar 2023 00:23:07 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id ew6so45638708edb.7
        for <linux-pm@vger.kernel.org>; Tue, 28 Mar 2023 00:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679988185;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AkqsIxVTTIjiBmPIxotvlBTlXGF+Biif3BptLCzQrlY=;
        b=V8BxDAkfOfwgiaVyBZn3mOeK06A4eVpH4t7AtvWh7R43KM0N1dLwHJpwvuD5s3Mb6/
         9Cm/4SlDBES2jIcCXARcycv/9Q/52w+qVjWLc+l1vNk/SezGqAOYQOnJ96QGiJTySV98
         hh6JLVrvCOQe7iJ637wzt3NgQ3A7gpSzwbOmJTBLCd+rPPHEiTKgsSPVesD3j3nWaD8G
         v/DNw9AUQUL42DhNydUZeEqTZDM09RUpaFKqoFR3s4bNTLJPsjZybKv4xydVAICDoUiZ
         cyOZqTIpZj7XS23RXN+9ipsV4HQKkBibgQeBW9AEN/p6WLz0PPN0ZCyzffavY59Rdl3v
         Eqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679988185;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AkqsIxVTTIjiBmPIxotvlBTlXGF+Biif3BptLCzQrlY=;
        b=fRYOAtoVmQzlR9bqzOgw2UykvOZ0EYi+8OLPsCtlB34F0275zqaX++feJqHo4VieLK
         8APGVBAlnxuLpij8m14iyEMdEL46/Q94lrUK7E54nckC4KPKRccncWT/MLvSx79ANh6v
         PX5S/hDMmAmmoMk1vjVBfCvHKJVlxSyXnqmCZrQvAVXoIumkVnSVLx+ESSIdt3GoE0GN
         dVqALEH5EkEipSwQ7nZHMIEcjMtyq+ZA64Cshyp1FMR9Z3GHfhaScMWn9+V54mNuQ617
         vPla0hhqEMLeocJ5sxlXLeeHbsz5QhLMiljo3QfaO8vvPQCZw9h9fyAtv1MSZPuT1XNP
         7UNQ==
X-Gm-Message-State: AAQBX9e7tCP5Bq8CHQrldzsAh6RdlDmhZel3GjcnBm/GlXaYIr2SmaBg
        QtzsxeQkRHz0levDZvUzfDTfXA==
X-Google-Smtp-Source: AKy350Yp9ywZm6L6vqH3ajXwBSX6L5U2m5DhAQ39Qax3qPYj/dhPl+8IYDRVa4tlqcfYQPZ5kJ7dxg==
X-Received: by 2002:a17:907:8687:b0:933:499e:62a7 with SMTP id qa7-20020a170907868700b00933499e62a7mr18542069ejc.49.1679988185597;
        Tue, 28 Mar 2023 00:23:05 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9e92:dca6:241d:71b6? ([2a02:810d:15c0:828:9e92:dca6:241d:71b6])
        by smtp.gmail.com with ESMTPSA id s17-20020a170906961100b009316783c92csm15158916ejx.12.2023.03.28.00.23.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 00:23:05 -0700 (PDT)
Message-ID: <787f656a-223d-5eed-e311-9cc7a6c46452@linaro.org>
Date:   Tue, 28 Mar 2023 09:23:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [Patch v4 01/10] dt-bindings: memory: tegra: add bpmp ref in
 tegra234-mc node
Content-Language: en-US
To:     Sumit Gupta <sumitg@nvidia.com>, treding@nvidia.com,
        dmitry.osipenko@collabora.com, viresh.kumar@linaro.org,
        rafael@kernel.org, jonathanh@nvidia.com, robh+dt@kernel.org,
        lpieralisi@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, mmaddireddy@nvidia.com, kw@linux.com,
        bhelgaas@google.com, vidyas@nvidia.com, sanjayc@nvidia.com,
        ksitaraman@nvidia.com, ishah@nvidia.com, bbasu@nvidia.com
References: <20230327161426.32639-1-sumitg@nvidia.com>
 <20230327161426.32639-2-sumitg@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230327161426.32639-2-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
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

On 27/03/2023 18:14, Sumit Gupta wrote:
> For Tegra234, add the "nvidia,bpmp" property within the Memory
> Controller (MC) node to reference BPMP node. This is needed in
> the MC driver to pass the client info to the BPMP-FW when memory
> interconnect support is available.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  .../bindings/memory-controllers/nvidia,tegra186-mc.yaml    | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
> index 935d63d181d9..398d27bb2373 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
> @@ -58,6 +58,10 @@ properties:
>    "#interconnect-cells":
>      const: 1
>  
> +  nvidia,bpmp:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: phandle of the node representing the BPMP

Why do you need this multiple times? Both in parent and all external-mc
children?

> +
>  patternProperties:
>    "^external-memory-controller@[0-9a-f]+$":
>      description:
> @@ -220,6 +224,9 @@ allOf:
>              - const: ch14
>              - const: ch15
>  
> +        nvidia,bpmp:
> +          description: phandle of the node representing the BPMP

I don't understand for what this hunk is. It does not look like in
correct place at all.

Best regards,
Krzysztof

