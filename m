Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7A5656816
	for <lists+linux-pm@lfdr.de>; Tue, 27 Dec 2022 08:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiL0H7i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Dec 2022 02:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiL0H7h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Dec 2022 02:59:37 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E7763B0
        for <linux-pm@vger.kernel.org>; Mon, 26 Dec 2022 23:59:35 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id x37so6157809ljq.1
        for <linux-pm@vger.kernel.org>; Mon, 26 Dec 2022 23:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jNkfjEICeM7PbhM37J2f+PuUg/PwpxFMIPMIoac4to8=;
        b=eLOiqNg1HnXzDAAU4zFmnkTbsq02Ukr/RajUs7jEv+R0R/o7xQtUrwqODLJBtwtu1N
         uqN0XfOUAH48mNcdQGQlChkJjreCLLc1oFAeexzfYCHA6zfEHHGWYDrRGK1gjOJFoAwg
         d8dVROH+78lWrPfZUQhmKda9p4gDcYhg7qNmTizgcYGy4WbHuoQif7WIHvzNbegiRx8X
         GoeLJ0ir9UnzcgUzxGg5QiB/YVPXxISSwpOpcR7wkpF9OfF0NGyjpxrdwkm226HEdgxp
         1cLPYo4Wx9QM6JPfaHiKHP660AoIiU10eWD6S0RfzBmMufNVPw3NR04hWW4PUujDn6mD
         O0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jNkfjEICeM7PbhM37J2f+PuUg/PwpxFMIPMIoac4to8=;
        b=i8pR2IG06onflvvVwDDw9WuaLm91FfyWAVJGjvJZfJYifQ1C2lhmGr2kBvuBT7Dg7E
         +kvtPibHrIEZoG9FFq5GK8bH/wBsSKFm0dcdhUAWmWaxPoDuFFryj7s8QEdcUcFR7dYz
         ts3K7GEDaU7mRllqUz9tV2xc332qPAQQd0SxDHweLUkZDRF1rhWQQrYN5zB6ZyY9c9pT
         EQGPU3vd6KGhzT03zCeJH6+lzZdwf/Ah8rioUg0gs8YbzLxMJSoZ0wIV4igDIlqA3PRE
         h30KpbuIvDdgwcmwHFNmzAFujR7avfIPYJWyqm4hOCpJAEmTjKmDRv03wb36Qj/n9rf9
         aTCg==
X-Gm-Message-State: AFqh2kq2Y7IZwo9Q1+IESTg9gcQ4wr3QZ6KE1LP/wwOKf/H4cFQbb0AK
        gdpBgh7CgC+lz+ar/Iz0wSK/Eg==
X-Google-Smtp-Source: AMrXdXvRSwMGnIBHRfxosdlVq8JTa7MkayGC6tu+7KVrj+jnN+lEDMSZ2lV/DFNMQ3n+isMk1ojfZw==
X-Received: by 2002:a2e:9186:0:b0:27a:3afd:de6d with SMTP id f6-20020a2e9186000000b0027a3afdde6dmr6549276ljg.48.1672127973845;
        Mon, 26 Dec 2022 23:59:33 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id k21-20020a2e8895000000b00277025ddc9esm1540641lji.54.2022.12.26.23.59.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Dec 2022 23:59:33 -0800 (PST)
Message-ID: <7fd3c28c-993b-bd90-738d-17793dcfe96f@linaro.org>
Date:   Tue, 27 Dec 2022 08:59:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/4] dt-bindings: interconnect: add sdm670 interconnects
Content-Language: en-US
To:     Richard Acayan <mailingradian@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Odelu Kukatla <quic_okukatla@quicinc.com>,
        Luca Weiss <luca@z3ntu.xyz>
References: <20221226224944.37242-1-mailingradian@gmail.com>
 <20221226224944.37242-2-mailingradian@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221226224944.37242-2-mailingradian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26/12/2022 23:49, Richard Acayan wrote:
> There are controllable interconnects on Snapdragon 670. Add the
> compatible strings to the documentation and interconnect ID definitions.
> 
> The device tree header was generated by
> linux-interconnect-driver-generator and the copyright year was changed.
> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---
>  .../bindings/interconnect/qcom,rpmh.yaml      |   8 ++
>  .../dt-bindings/interconnect/qcom,sdm670.h    | 136 ++++++++++++++++++
>  2 files changed, 144 insertions(+)
>  create mode 100644 include/dt-bindings/interconnect/qcom,sdm670.h
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> index a429a1ed1006..db1e93583554 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> @@ -75,6 +75,14 @@ properties:
>        - qcom,sc8280xp-nspa-noc
>        - qcom,sc8280xp-nspb-noc
>        - qcom,sc8280xp-system-noc
> +      - qcom,sdm670-aggre1-noc
> +      - qcom,sdm670-aggre2-noc
> +      - qcom,sdm670-config-noc
> +      - qcom,sdm670-dc-noc
> +      - qcom,sdm670-gladiator-noc
> +      - qcom,sdm670-mem-noc
> +      - qcom,sdm670-mmss-noc
> +      - qcom,sdm670-system-noc
>        - qcom,sdm845-aggre1-noc
>        - qcom,sdm845-aggre2-noc
>        - qcom,sdm845-config-noc
> diff --git a/include/dt-bindings/interconnect/qcom,sdm670.h b/include/dt-bindings/interconnect/qcom,sdm670.h
> new file mode 100644
> index 000000000000..d26dedb9deb7
> --- /dev/null
> +++ b/include/dt-bindings/interconnect/qcom,sdm670.h

Let's follow new convention, so: qcom,sdm670-rpmh.h


Best regards,
Krzysztof

