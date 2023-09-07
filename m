Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32B97974CF
	for <lists+linux-pm@lfdr.de>; Thu,  7 Sep 2023 17:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbjIGPlO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Sep 2023 11:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245224AbjIGPcI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Sep 2023 11:32:08 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F18319C
        for <linux-pm@vger.kernel.org>; Thu,  7 Sep 2023 08:31:42 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31c5c06e8bbso1074324f8f.1
        for <linux-pm@vger.kernel.org>; Thu, 07 Sep 2023 08:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694100652; x=1694705452; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KGhxv+wLkUlJTnXgtlH4J46AYd9o45ySTLmRTKlekWI=;
        b=ThgKY/4PvULhrkYaFzlTxp+8aTc/JOpz36vJZr8pWZ38GeFO7GQWumwe930LNJ9YF4
         44vsEwgPsATb7I8WeymexAmTKYrFERykuxNXo+4ENKHv3/nv7ektH2dxqGpwkaBeJQCQ
         9k8UgpQ9cT/IAoHzAy6oivDs6kXrauMv0m2+DGjgQvKb1Q6Wsio0fVR/a4+MtsqOl71U
         MUg4ixhx42HXzEBjurNwxp0FACO1u0LEH1MoPdVDzR42P8t5AAvWFoRQj3cOskjsB5vk
         O6n9DKmhaTh7DSnp6eS6SpNRn9cO3mJMa7Kb7wPHQjncgvtU63bU2WVI/O9D/1rKIugy
         mvhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694100652; x=1694705452;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KGhxv+wLkUlJTnXgtlH4J46AYd9o45ySTLmRTKlekWI=;
        b=OB1UqvTlbmHOYhE+hSVTMLQqYdAibpGPrwhjoxhNxJ+fbQ9JWMhCKsPD+uyxrE/Ymj
         Y+vtXYx2hkVhJWsujgV5BPeq1Q6caU6/tqJvtc+50jh3OwmmqggFWFj1GA/cyBzLHA4H
         UaebSDjXxmGOW+D0+fa4v0Iz9FVm8/rRGEvJExrZnLZhS+AlZ0wyyI4faNX6hZ57MggO
         0Ak9fbFil8uUpqrNiM4aTbYYO1ymanmpm2cN+/fQLx8bSDFS/w+9ERfTijdSseF2K0Oc
         tN5KOXDrNKr5efLgDBG7iEbhKTbkMDqm483lN1kF0PUAB5zICqPtuVH7OcmbHw1DBBl1
         yfbQ==
X-Gm-Message-State: AOJu0YzG59ThHH9xvREIAcxjzXLrW0o5IcscOAAAuntorJbUfjHGzHeE
        zifH0qC9XlfkYplYGsHrYbHqQl/+lfYlVYZtB7Y=
X-Google-Smtp-Source: AGHT+IHgZdZSiR//XinTA9Y8E8bS2xBu6CE90k9cVQP1rRMZIv9GSOKD+LJS0NcyLh090bkwtAQy+Q==
X-Received: by 2002:a17:906:19:b0:9a1:ec3d:8ffe with SMTP id 25-20020a170906001900b009a1ec3d8ffemr4567309eja.18.1694066647510;
        Wed, 06 Sep 2023 23:04:07 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id qx12-20020a170906fccc00b0099bd86f9248sm9922585ejb.63.2023.09.06.23.04.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 23:04:07 -0700 (PDT)
Message-ID: <2de8953c-f1c5-3c17-5c95-973ef550bc32@linaro.org>
Date:   Thu, 7 Sep 2023 08:04:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v1 08/10] dt-bindings: cpufreq: qcom-cpufreq-nvmem:
 document IPQ9574
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>,
        ilia.lin@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        quic_kathirav@quicinc.com, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <cover.1693996662.git.quic_varada@quicinc.com>
 <e0f54a4b249f24b10d3dc21a0224718e46ebd158.1693996662.git.quic_varada@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e0f54a4b249f24b10d3dc21a0224718e46ebd158.1693996662.git.quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07/09/2023 07:21, Varadarajan Narayanan wrote:
> Document IPQ9574 compatible for Qcom NVMEM CPUFreq driver.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml | 1 +
>  1 file changed, 1 insertion(+)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

