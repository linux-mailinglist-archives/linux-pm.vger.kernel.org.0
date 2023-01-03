Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7947665BCB7
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jan 2023 10:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237116AbjACJEO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Jan 2023 04:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbjACJEI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Jan 2023 04:04:08 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2202668
        for <linux-pm@vger.kernel.org>; Tue,  3 Jan 2023 01:04:07 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id e13so28605459ljn.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Jan 2023 01:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2CnuJg6PcG9eSntjZdCPCEpHazcrLwunMlFBYGxvq3k=;
        b=hy6C4bC/7KW/GVy9+q0pONRAPQ689eTOyzGuhm25lQhZLK1XldclsG98wgh7YfBvSk
         XiW+1mHjtUi0zHFrJsUj8kHMjBiSOtgvFiuhND6o83294KGgIOlm2EJCkurmz3nTvCn2
         X/Tp26u9Kkm2U4o8xZI0rBLQXlDcLe4mEAGZJ4jp1T1fZddsfL0w2hkIHdgd3XNCTvE5
         /fnv+cnTOmptpbBuVb8TwAj8kZI5B72pWTP9NbOxQ7jbB6KKwt2rNu0MYBF0YE04j5lr
         w1419kfGbmeqEdiZGF7QDejl8mRBCrvvRyBGKylmzI2Ad/Xn7xEdXAOtmZISeBeLF8+g
         gA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2CnuJg6PcG9eSntjZdCPCEpHazcrLwunMlFBYGxvq3k=;
        b=fBcyKR77diehLMCYVVmFkWPOg+UrHE626x/RBLlOj5VLiQ0WHUydvhJ/517KqBTVi/
         xpfZG/6bh885s7OxonYN0KEujQcgQov+0KFMsuJq5hFiN1/CzgoispCspVhEJ+kMAIKT
         hEq20PoRt1DhUCtuxcqYPshOGAemcsSsxNZMzBvujPXfG2y9iY8MifDtZWzT7REuy4ea
         ehTdLcvFhi6106pWnKJRY97868GHl8/BhhzIvmL4zkX71lcZUOjwMlET1x+zQFql4TBD
         SDNbzf6eu7J2Jh5SFyq2KH3iBevgR26Yko1nRpQXWGvtdwzQfnxyxENYAt+vfw3rMPjy
         TUTg==
X-Gm-Message-State: AFqh2krmMutmBaIOEZKr+j3bnyggDKm+lwEkj0535KG68DyhE4NOeK/B
        JzT5wiFVHuk35BHe7uOnVOKK+Q==
X-Google-Smtp-Source: AMrXdXtV1AheRQylTsYPIvzF82CpBQ1N+RgXseNboqHfm1TK1EDfigZDotzJeTNEdnigCCF1sGkFZA==
X-Received: by 2002:a2e:8894:0:b0:27f:b41d:56c4 with SMTP id k20-20020a2e8894000000b0027fb41d56c4mr9296573lji.42.1672736645454;
        Tue, 03 Jan 2023 01:04:05 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id be35-20020a05651c172300b0027fafca7addsm3271439ljb.112.2023.01.03.01.04.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 01:04:04 -0800 (PST)
Message-ID: <d32ae163-ed9f-7b15-0565-f20e0c59550d@linaro.org>
Date:   Tue, 3 Jan 2023 10:04:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 2/7] dt-bindings: arm: qcom: Document MSM8939 SoC
 binding
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, djakov@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        benl@squareup.com, shawn.guo@linaro.org, fabien.parent@linaro.org,
        leo.yan@linaro.org, dmitry.baryshkov@linaro.org
References: <20230103010904.3201835-1-bryan.odonoghue@linaro.org>
 <20230103010904.3201835-3-bryan.odonoghue@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230103010904.3201835-3-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03/01/2023 02:08, Bryan O'Donoghue wrote:
> Document the MSM8939 and supported boards in upstream Sony "Tulip" M4 Aqua
> and Square APQ8039 T2.
> 
> MSM8939 is one of the older SoCs so we need to expand the list of
> qcom,board-ids to allow for the bootloader DTS board-id matching
> dependency.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

