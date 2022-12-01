Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E212163F8A0
	for <lists+linux-pm@lfdr.de>; Thu,  1 Dec 2022 20:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiLATy7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Dec 2022 14:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbiLATy5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Dec 2022 14:54:57 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F7ABA616
        for <linux-pm@vger.kernel.org>; Thu,  1 Dec 2022 11:54:53 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id j16so4128745lfe.12
        for <linux-pm@vger.kernel.org>; Thu, 01 Dec 2022 11:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OGig0j87TfPUBjEzV2O5bgbpVQ79iR8UjUhrIXzIKPE=;
        b=MA73zwlsy0FYvPwpcf4ysOfjDfkrADv8s2v3gyglmKUYAXMhhR2n46V6vr+elDNupc
         EBd9cnPMxjA/mcXwJlNmc4nE760c3551+hS+/iVFbojEKhICUYejhlNYefkeFYO3l0xc
         ZQejn0DtDLZYuvZETgdhYO7SzzBgL2c3//unuOBxqIRCHqq3CFRYUlFYLaDHHjeXnU/a
         cBwQlUZKl/ZFO6H8in4pnPv/AEWsj2hTOpFFq8mvIid9DpmohI4OWvjguvF1cjOIn6f8
         wRcGvTDNO/1WHqj902PHUCsmbr6u5fjQ34URQrt05ThnG6lP5bFGVFhyL+JM95JFD6Yx
         gRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OGig0j87TfPUBjEzV2O5bgbpVQ79iR8UjUhrIXzIKPE=;
        b=EG5nVGlZ81CcazQEHVMLcylbbCf3FcDDptG94b3Jb48O7Pm2qiIC0+rOwDH0Jo4n1s
         WoW87U2oUSLUkdaJldHEkkI6CWN4miAn4BaIEljriNNTp3vHF3QaTMRo0D/Z+6meH8Bv
         UzSB2GZYzh/wQQCKEN7bjNY+ytG9nuit9dym2YYPY9iHemOlnSiVSO+dL/ChnAccJkX1
         AW45ROtOm+eWEhdEfPHlBWTGUFLXy/xrV14uPdByxH+S7Xkc6HaFNTER0nfBTlRPdsRf
         giwhlXr18XT1Z5PjTUVCkldvZYzsZYX4arRx9NXdwMDaDxs4W/utHcNIGR99ZszRxVqk
         xa4A==
X-Gm-Message-State: ANoB5pln7I1hjjcVRlPU+48/Lx6YABiw7o8ub3kiwrCY/Cuam9ILoWza
        zivGOwmVV0hpjq/9GhBp1sD0Qw==
X-Google-Smtp-Source: AA0mqf5ku+EWJ6b5KPQcvTvxQ1Dz0O0+WykmdO2w66c7UgoB4xHtoQxQBKEk3ZN1g+TpW/1iBeNQsw==
X-Received: by 2002:ac2:5e2c:0:b0:4a2:243a:ef6e with SMTP id o12-20020ac25e2c000000b004a2243aef6emr18652028lfg.454.1669924491618;
        Thu, 01 Dec 2022 11:54:51 -0800 (PST)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id z6-20020ac25de6000000b004b1a5086485sm757030lfq.2.2022.12.01.11.54.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 11:54:51 -0800 (PST)
Message-ID: <19e78a06-2f3d-92af-1988-b22dc3ffc84e@linaro.org>
Date:   Thu, 1 Dec 2022 21:54:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 01/12] dt-bindings: display: msm: Rename mdss node name
 in example
Content-Language: en-GB
To:     Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20221130200950.144618-1-a39.skl@gmail.com>
 <20221130200950.144618-2-a39.skl@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221130200950.144618-2-a39.skl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30/11/2022 22:09, Adam Skladowski wrote:
> Follow other YAMLs and replace mdss name into display-subystem.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

We will pick this into msm-fixes during the next cycle.

> ---
>   .../devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml      | 2 +-
>   .../devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml       | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
> index d6f043a4b08d..4795e13c7b59 100644
> --- a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
> @@ -72,7 +72,7 @@ examples:
>       #include <dt-bindings/interconnect/qcom,qcm2290.h>
>       #include <dt-bindings/power/qcom-rpmpd.h>
>   
> -    mdss@5e00000 {
> +    display-subsystem@5e00000 {
>           #address-cells = <1>;
>           #size-cells = <1>;
>           compatible = "qcom,qcm2290-mdss";
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml
> index a86d7f53fa84..886858ef6700 100644
> --- a/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml
> @@ -62,7 +62,7 @@ examples:
>       #include <dt-bindings/interrupt-controller/arm-gic.h>
>       #include <dt-bindings/power/qcom-rpmpd.h>
>   
> -    mdss@5e00000 {
> +    display-subsystem@5e00000 {
>           #address-cells = <1>;
>           #size-cells = <1>;
>           compatible = "qcom,sm6115-mdss";

-- 
With best wishes
Dmitry

