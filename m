Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAE06AB65D
	for <lists+linux-pm@lfdr.de>; Mon,  6 Mar 2023 07:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjCFGgg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Mar 2023 01:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjCFGgf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Mar 2023 01:36:35 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7F010258
        for <linux-pm@vger.kernel.org>; Sun,  5 Mar 2023 22:36:33 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id j11so14549119edq.4
        for <linux-pm@vger.kernel.org>; Sun, 05 Mar 2023 22:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678084592;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tiatu8BflCMTPWpOTvwGq34iFc0RbmfIKdTTYpadMuw=;
        b=Jx+XD3Dy7pA2r/y34unPO6+Yl+MtMSk4bO8W04pJ2qHGdhjMgXxW+JDIC6Pp8GGl/y
         3dQ7TfVvLMQPR1n7wRdlhfDUUWRSsgzlIVmgrUInMM2wdPqxWUfq6HVD7jmOI9VmftfI
         rHxmSXg+G3f2Ymk9fyKR3prW3Gz9JzeDHS+IYN24dXuFrzkJaYjNirpjnrECx/IBQtdg
         5Ezh9nfeHLHSfp9wpylsM72RXMZnD2n4kXIkv9a1/IYxRHJ49XwviwDWidZRny7Fz2td
         un7xZE+C4nJZ9VSub79qwnAhr6sWZnAcQcqImVZMdl8NQKqr1VlEri0hkGjFLye+YuJU
         ZmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678084592;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tiatu8BflCMTPWpOTvwGq34iFc0RbmfIKdTTYpadMuw=;
        b=doh7vMDmc3AhVireP8vdU6EHa1yl6yfrFN46iGUKBy3onJgIEfWqWdhS6vDyoPGpHb
         09jcRqmYvCVKVstz4q49/EynKbe2oTK4wspQPUZJdsObMzG7po+jip8SigV98EfyOPIx
         2/49ddDg3mC3B5qrV/dhY7+6OTFBUQRUhdsU66+8wAAhxWq4CKD8kx6pIRfsptkXlYZ3
         +SBTiwISHavsmbsoS9box70y0FMyM85T824gaco+QFHoKknbL/+A/MQO8z1QRGUR+p3v
         wqE9tBEqmcrVEDfcv37h+ka6BlcS15qecgW9DtSTreKYmrtXK8ZzpWJYghaITfWtFhsW
         a8UA==
X-Gm-Message-State: AO0yUKUZWAQGA5Flmmu7l4Z7jCZMzYfmYQ2jdZeVOYCHAQNP7tQv6ROE
        WDce/YquqMyEYIyKhCc1/vKu+g==
X-Google-Smtp-Source: AK7set+KvTLNJOsq+Ksb2yKc17YGC7Pxuj0GWXcvebF/KsJoXRhR1+1O+rn6v8qu56mm0bxIpJXYSA==
X-Received: by 2002:a17:907:d093:b0:8f7:60c8:269c with SMTP id vc19-20020a170907d09300b008f760c8269cmr10974615ejc.29.1678084591704;
        Sun, 05 Mar 2023 22:36:31 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:d85d:5a4b:9830:fcfe? ([2a02:810d:15c0:828:d85d:5a4b:9830:fcfe])
        by smtp.gmail.com with ESMTPSA id q18-20020a170906771200b008cc920469b5sm4191177ejm.18.2023.03.05.22.36.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 22:36:31 -0800 (PST)
Message-ID: <ee0bdc34-b2bf-b6db-b41c-a9529760a4b0@linaro.org>
Date:   Mon, 6 Mar 2023 07:36:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/6] dt-bindings: crypto: fsl-dcp: add imx6sl and imx6ull
 compatible
Content-Language: en-US
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     linux-imx@nxp.com, Marek Vasut <marex@denx.de>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-crypto@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230305225901.7119-1-stefan.wahren@i2se.com>
 <20230305225901.7119-2-stefan.wahren@i2se.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230305225901.7119-2-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05/03/2023 23:58, Stefan Wahren wrote:
> Currently the dtbs_check for imx6 generates warnings like this:
> 
> 'fsl,imx6sl-dcp' is not one of ['fsl,imx23-dcp', 'fsl,imx28-dcp']
> ['fsl,imx6sl-dcp', 'fsl,imx28-dcp'] is too long
> 
> or
> 
> 'fsl,imx6ull-dcp' is not one of ['fsl,imx23-dcp', 'fsl,imx28-dcp']
> ['fsl,imx6ull-dcp', 'fsl,imx28-dcp'] is too long
> 
> So add them to the devicetree binding.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  Documentation/devicetree/bindings/crypto/fsl-dcp.yaml | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/crypto/fsl-dcp.yaml b/Documentation/devicetree/bindings/crypto/fsl-dcp.yaml
> index 99be01539fcd..1695c4c58dc8 100644
> --- a/Documentation/devicetree/bindings/crypto/fsl-dcp.yaml
> +++ b/Documentation/devicetree/bindings/crypto/fsl-dcp.yaml
> @@ -11,9 +11,14 @@ maintainers:
>  
>  properties:
>    compatible:
> -    enum:
> -      - fsl,imx23-dcp
> -      - fsl,imx28-dcp
> +    oneOf:
> +      - const: fsl,imx23-dcp
> +      - const: fsl,imx28-dcp

Keep these two as enum (so just indent under oneOf).

> +      - items:
> +          - enum:
> +              - fsl,imx6sl-dcp
> +              - fsl,imx6ull-dcp
> +          - const: fsl,imx28-dcp
>  
>    reg:
>      maxItems: 1

Best regards,
Krzysztof

