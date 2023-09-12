Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F37B79C76C
	for <lists+linux-pm@lfdr.de>; Tue, 12 Sep 2023 09:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjILHBI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Sep 2023 03:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjILHBI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Sep 2023 03:01:08 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A04E75
        for <linux-pm@vger.kernel.org>; Tue, 12 Sep 2023 00:01:04 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9aa2c6f0806so222005666b.3
        for <linux-pm@vger.kernel.org>; Tue, 12 Sep 2023 00:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694502063; x=1695106863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ctIV/w4BG99+4Nc0GESnPYJu8NhdJz0/fF4LjMpIMlA=;
        b=Z6hDaRKhfdclWbzLJfUc9sVZVHbytO1S/hxTfCHqEEnm/MHQ+nNV2jR7nIhxYAJshP
         oPfUi9XagXr2z3gdFMGUHdjYu22ypxw+RdBUBTqYE5oIlO9jDEsVXEdj2QHatbn/rrJ7
         B5dAK7bHEBtt0nG8tKF7gjUMDuAXZ3i0q8stozVsTpZfFur8YgoXGfBQKVtpCidxiuqd
         af1DVNYeNzQowWC926RhbG2UnymwBDUiu+E9uD8x7Fr+0wE69pQa2V8bqNW8xlbmYIgi
         75n8fPqdbKikIhh4ngv2/jX9hMmcD0/u3sJ7gFaO+PIKAgN6uw5IAnDs82cfnzlXvDlK
         Jbew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694502063; x=1695106863;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ctIV/w4BG99+4Nc0GESnPYJu8NhdJz0/fF4LjMpIMlA=;
        b=Q4oQtYfC5rC+NwxPfIkMH9dp+vozQR7gvLZWIluzca96onEzrdpE+k90/8zyr/r7Sh
         hqc2HsA4qzP7HeyPKMH9/006DCpXTmwylUcD94kNDNwWY8LGFz31hQfR08WJo7gG1Qzj
         jEN/OJ1Wo/fsy6xhRCG1JgvZ1a14Mkrp2LPoyHRecLKbPtcfIk7hLuNW1fbPoLg1MwCr
         QQR2SBNWB2eNgcG17dWfRzIlzmp6YFAUhNugPJT7yvDHeZGGwgF0WT/PfDej6uAJHO7X
         mMfEeQb9MJV0AuU6xqor8xhIDf1et+jdXemYUZoxyXqrVXQkcsleUnhhEiWlXec6Ao5w
         EZfw==
X-Gm-Message-State: AOJu0YwAO4qg95zMype3nRHAWWJTk92H5ghwGVegi77JKle23d905GBh
        vn0mGFP0IQkLQpjyNGSM6evsQQ==
X-Google-Smtp-Source: AGHT+IE4NxTfAMRkF8WeMqfzV5pOhN4h5BXKsp26cOVN4IsTNWN1bc4jzc9tBEBAYrudVHhvYAzzyQ==
X-Received: by 2002:a17:906:10c9:b0:9a9:fc74:8d50 with SMTP id v9-20020a17090610c900b009a9fc748d50mr9504187ejv.66.1694502062742;
        Tue, 12 Sep 2023 00:01:02 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id r16-20020a170906351000b0099bd86f9248sm6369287eja.63.2023.09.12.00.01.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 00:01:02 -0700 (PDT)
Message-ID: <9ea20b20-43f8-7619-40a9-710340ea7acf@linaro.org>
Date:   Tue, 12 Sep 2023 09:01:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 1/3] dt-bindings: power: rpmpd: Add MSM8917, MSM8937
 and QM215
Content-Language: en-US
To:     =?UTF-8?Q?Otto_Pfl=c3=bcger?= <otto.pflueger@abscue.de>,
        linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230912050028.4804-1-otto.pflueger@abscue.de>
 <20230912050028.4804-2-otto.pflueger@abscue.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230912050028.4804-2-otto.pflueger@abscue.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/09/2023 07:00, Otto Pflüger wrote:
> The MSM8917, MSM8937 and QM215 SoCs have VDDCX and VDDMX power domains
> controlled in voltage level mode. Define the MSM8937 and QM215 power
> domains as aliases because these SoCs are similar to MSM8917 and may
> share some parts of the device tree.
> 
> Also add the compatibles for these SoCs to the documentation, with
> qcom,msm8937-rpmpd using qcom,msm8917-rpmpd as a fallback compatible
> because there are no known differences. QM215 is not compatible with
> these because it uses different regulators.
> 
> Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
> ---
>  .../devicetree/bindings/power/qcom,rpmpd.yaml | 79 ++++++++++---------
>  include/dt-bindings/power/qcom-rpmpd.h        | 21 +++++
>  2 files changed, 64 insertions(+), 36 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
> index 9b03c41d3604..d4dac8b54045 100644
> --- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
> +++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
> @@ -15,42 +15,49 @@ description:
>  
>  properties:
>    compatible:
> -    enum:
> -      - qcom,mdm9607-rpmpd
> -      - qcom,msm8226-rpmpd
> -      - qcom,msm8909-rpmpd
> -      - qcom,msm8916-rpmpd
> -      - qcom,msm8939-rpmpd
> -      - qcom,msm8953-rpmpd
> -      - qcom,msm8976-rpmpd
> -      - qcom,msm8994-rpmpd
> -      - qcom,msm8996-rpmpd
> -      - qcom,msm8998-rpmpd
> -      - qcom,qcm2290-rpmpd
> -      - qcom,qcs404-rpmpd
> -      - qcom,qdu1000-rpmhpd
> -      - qcom,sa8155p-rpmhpd
> -      - qcom,sa8540p-rpmhpd
> -      - qcom,sa8775p-rpmhpd
> -      - qcom,sdm660-rpmpd
> -      - qcom,sc7180-rpmhpd
> -      - qcom,sc7280-rpmhpd
> -      - qcom,sc8180x-rpmhpd
> -      - qcom,sc8280xp-rpmhpd
> -      - qcom,sdm670-rpmhpd
> -      - qcom,sdm845-rpmhpd
> -      - qcom,sdx55-rpmhpd
> -      - qcom,sdx65-rpmhpd
> -      - qcom,sdx75-rpmhpd
> -      - qcom,sm6115-rpmpd
> -      - qcom,sm6125-rpmpd
> -      - qcom,sm6350-rpmhpd
> -      - qcom,sm6375-rpmpd
> -      - qcom,sm8150-rpmhpd
> -      - qcom,sm8250-rpmhpd
> -      - qcom,sm8350-rpmhpd
> -      - qcom,sm8450-rpmhpd
> -      - qcom,sm8550-rpmhpd
> +    oneOf:
> +      - enum:
> +          - qcom,mdm9607-rpmpd
> +          - qcom,msm8226-rpmpd
> +          - qcom,msm8909-rpmpd
> +          - qcom,msm8916-rpmpd
> +          - qcom,msm8917-rpmpd
> +          - qcom,msm8939-rpmpd
> +          - qcom,msm8953-rpmpd
> +          - qcom,msm8976-rpmpd
> +          - qcom,msm8994-rpmpd
> +          - qcom,msm8996-rpmpd
> +          - qcom,msm8998-rpmpd
> +          - qcom,qcm2290-rpmpd
> +          - qcom,qcs404-rpmpd
> +          - qcom,qdu1000-rpmhpd
> +          - qcom,qm215-rpmpd
> +          - qcom,sa8155p-rpmhpd
> +          - qcom,sa8540p-rpmhpd
> +          - qcom,sa8775p-rpmhpd
> +          - qcom,sdm660-rpmpd

Move it down to sort, while you are changing it.


With above (and assumption if you ever need to rebase the patch you will
be extra careful and re-check all entries):

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

