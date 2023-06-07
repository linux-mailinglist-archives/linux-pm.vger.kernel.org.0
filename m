Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F9A725E16
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jun 2023 14:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239640AbjFGMKY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Jun 2023 08:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238619AbjFGMKX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jun 2023 08:10:23 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60E41BEA
        for <linux-pm@vger.kernel.org>; Wed,  7 Jun 2023 05:09:51 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-978863fb00fso77313366b.3
        for <linux-pm@vger.kernel.org>; Wed, 07 Jun 2023 05:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686139785; x=1688731785;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4/+IxNyNuU6c0f4V6AP7AEaoB93kUSv3pNcbejKx5r8=;
        b=R+IjVEHNCaLBIJymjO6VUAHD2U5WC0Dv8rQ9AZCt1WPuNjukgR4G+RMEy41/pDmiJs
         E5CTdNz55yDP8SS1zmzEJbNrB2XLIW5diIdNqh53m5JcitbRlOBHx18tWJ/0l88RXAR2
         mTFKcTT94HDSSPu3IBBz7K+synliASBmuW0zALCWH7ikmNBotjAQVNssRDbD+1WVmerq
         jlvgrpxEb7cLtUhDoD48OP791SdgOhZvcoDbbzg4qEj0NcktQIwUgSRWVKyu+lRKAEmM
         3ADmuVAQ/oOcvSXjz3GOiRKxsQZCpVcmCq6ucRE2J8H6h+fbeG2FwIKzHugRuWquw42I
         Rfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686139785; x=1688731785;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4/+IxNyNuU6c0f4V6AP7AEaoB93kUSv3pNcbejKx5r8=;
        b=K0R3j9+1SRd8yBgNDgcZ8VrvlpzJQtJo2qVSktk1BYAJMzuCXm+AE1W8N/jfjsaCk8
         Emr0oS5PVMVIogmNfB7iU18uJ/0gEDc+mmqmlAYYy5SjdE/cwnvjm4LQN6smWDRMgQP9
         F3oaJWCZ4Bi1X5fagFWj3RDSTlgSpMBoXkDGRBwN76NyTSfXoGA3Y1TJy5RI5ccQFT/b
         oDw4RY4vhdWnkBj4PARasMZHpyV8ycQuAERhXE7a76Wl0wdUJ0XtxSYn5jLzLghd45Ah
         E1bTTL1N05NXJRG1BQmfY59GrxgHmHqhXKlhvIwwFjv+dSzJKFO+4MhW8ZgA4rs3Lm8A
         vMvQ==
X-Gm-Message-State: AC+VfDwkLaUFe4IqvdB2NBoV0FMyNm9ZyIf+pu/ubQnz3QC4ZjmF9vw+
        v+k0YcSNBQ4Kt3Q27UVICIKpEw==
X-Google-Smtp-Source: ACHHUZ5ki1o2WmeeafyorfJJmFHKpCpeAsWgmbSJSI6UO4RVigo7D9c0bUa+PZkwpfJ6rEC+e2sCQQ==
X-Received: by 2002:a17:906:58d4:b0:977:d53e:4055 with SMTP id e20-20020a17090658d400b00977d53e4055mr5923336ejs.58.1686139785374;
        Wed, 07 Jun 2023 05:09:45 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id dx1-20020a170906a84100b0096f7ae359a5sm6858126ejb.30.2023.06.07.05.09.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 05:09:44 -0700 (PDT)
Message-ID: <ef231c75-e35c-6320-ed0e-7fc5e24d6afc@linaro.org>
Date:   Wed, 7 Jun 2023 14:09:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 4/5] dt-bindings: cpufreq: cpufreq-qcom-hw: Add SDX75
 compatible
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        rafael@kernel.org, viresh.kumar@linaro.org, tglx@linutronix.de,
        maz@kernel.org, mani@kernel.org, robimarko@gmail.com
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <1686138469-1464-1-git-send-email-quic_rohiagar@quicinc.com>
 <1686138469-1464-5-git-send-email-quic_rohiagar@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1686138469-1464-5-git-send-email-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07/06/2023 13:47, Rohit Agarwal wrote:
> Add compatible for EPSS CPUFREQ-HW on SDX75.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions. However, there's no need to repost patches *only* to add the
tags. The upstream maintainer will do that for acks received on the
version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

If a tag was not added on purpose, please state why and what changed.

Best regards,
Krzysztof

