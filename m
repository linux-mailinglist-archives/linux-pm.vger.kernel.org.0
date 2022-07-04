Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574265655D5
	for <lists+linux-pm@lfdr.de>; Mon,  4 Jul 2022 14:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbiGDMrT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Jul 2022 08:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbiGDMrS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Jul 2022 08:47:18 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C41EE18
        for <linux-pm@vger.kernel.org>; Mon,  4 Jul 2022 05:47:16 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id r9so10937595ljp.9
        for <linux-pm@vger.kernel.org>; Mon, 04 Jul 2022 05:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=THzt6BhNLj+K3ylG9NiSnvnjg5kgz87iMbtt+viJvKA=;
        b=YoRUkMT0qU8v/sUbrKNwDKGjpCa1ByFemhty0d93QKqiI95hsJ/Ll2G/Hj4p17VYzh
         uMJ8H4PAzuD+LumVUwC7G42RWxPz8W4Yugp57AvObyoAHmgwTNxHnzzdO/wqNwTBIdGR
         SAyHMkQUcgfZBJbw8RJPP1vM8FhPPjeerkBpXWD920Mbwq5KMZ1ji8IszOvkfTGBWj0B
         k+Nc6Gk3E+hBO8UuLXwX+EdP3wXHxpk73QlrA2Eyyf/TlIl1PAIoqcqz3wt1VlXDI+Qr
         ondyXGaTre58D5KU/XcE/hfvY7wGRExos0uAUZElj3pFqPkMfQ/LivWjP7fvBCQdYRhx
         7/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=THzt6BhNLj+K3ylG9NiSnvnjg5kgz87iMbtt+viJvKA=;
        b=iuTvQA5TuWhEhp+IegFcY7LecBqhC2qEXuMwVpMwgXkxrG2Q5vL8Tlig4XiWGjY2Xn
         pgRBYcC+JXXZdz5Msddgk9cZvHr2Ns3Wg9UEoMmFg67dSj4+IyIm7mElCZLWlmh+jOJO
         YshVE1aULg3IwfSqv3uZCm8ICKti4ZqGz+4ztI6tRhE5j0MaTkhxFw0AaJ+1qT6Qy8yH
         2IUkuU+vQSh+i7iZOdX5wKFRXk98K6LS84Ex5MRkXaAlj042DixlCdGjg/0D7yHrFTQd
         oynOsSpEyGDcZed+rS73Un+SdKyidMx751Do2xi/GzFvKnTx6ds9irkMaltfewa9nQi0
         hujw==
X-Gm-Message-State: AJIora/8h5EihSUSl5Ym2+89v6X8qpT2AqMddzuJDTBE6HXetDBmnU0e
        Ye0hGBfyqP8Ott2K5Xkq+AK3HA==
X-Google-Smtp-Source: AGRyM1vkbCQGZD5CX/NhFWNqOECy3qyQsiVGYHWoiM1yhwb2AbT1K/Yyqem3I6GfwwQAMjm00e+baw==
X-Received: by 2002:a2e:a4cc:0:b0:25a:7c00:618f with SMTP id p12-20020a2ea4cc000000b0025a7c00618fmr17123354ljm.82.1656938835332;
        Mon, 04 Jul 2022 05:47:15 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id v23-20020a056512349700b0047f774bb512sm5113887lfr.306.2022.07.04.05.47.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 05:47:14 -0700 (PDT)
Message-ID: <18f1ee4a-5787-40d7-2eb5-50a43298845d@linaro.org>
Date:   Mon, 4 Jul 2022 14:47:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 1/5] dt-bindings: interconnect: Update property for
 icc-rpm path tag
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20220704093029.1126609-1-leo.yan@linaro.org>
 <20220704093029.1126609-2-leo.yan@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220704093029.1126609-2-leo.yan@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04/07/2022 11:30, Leo Yan wrote:
> To support path tag in icc-rpm driver, the "#interconnect-cells"
> property is updated as enumerate values: 1 or 2.  Setting to 1 means
> it is compatible with old DT binding that interconnect path only
> contains node id; if set to 2 for "#interconnect-cells" property, then
> the second specifier is used as a tag (e.g. vote for which buckets).
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  .../devicetree/bindings/interconnect/qcom,rpm.yaml         | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
> index 8a676fef8c1d..cdfe419e7339 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
> @@ -45,7 +45,12 @@ properties:
>        - qcom,sdm660-snoc
>  
>    '#interconnect-cells':
> -    const: 1
> +    description: |
> +      Number of interconnect specifier. Value: <1> is one cell in a
> +      interconnect specifier for the interconnect node id, <2> requires
> +      the interconnect node id and an extra path tag.
> +    $ref: /schemas/types.yaml#/definitions/uint32

Ah, too fast.  No ack. This ref is also pointless and not explained in
commit msg.

> +    enum: [ 1, 2 ]
>  
>    clocks:
>      minItems: 2


Best regards,
Krzysztof
