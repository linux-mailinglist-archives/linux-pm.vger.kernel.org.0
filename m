Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F536695B79
	for <lists+linux-pm@lfdr.de>; Tue, 14 Feb 2023 08:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjBNH5h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Feb 2023 02:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjBNH5Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Feb 2023 02:57:25 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E322069C
        for <linux-pm@vger.kernel.org>; Mon, 13 Feb 2023 23:57:23 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id r2so14684821wrv.7
        for <linux-pm@vger.kernel.org>; Mon, 13 Feb 2023 23:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r08Y9PyPMDpyrszLAyVhH3DCk6hbIyWyHI7hIZi6JC8=;
        b=k3iYbHKTZy22RV65FMmoOUYsQvB7jUKc+RFnRdCrNJ0hD0dQCFxxJhvlwXIKnUZ30F
         XoolrOnceiRllR+QctKu3DReXUoJvOlt5lfDnq+t0nnP9r7nkX9KURQqzGWL3UnLDsY+
         b2D4KrkP/hInJrLC2awtrYyPA9qwKauEo0vmwGoBkxvn1od2gGsZ3oUyjXZPXFejjioT
         ci5kbA8EZvUnGed1DQ5mmOaNgTVgCrrfuViZVSksZwxS6nH5NAI5nUxNNiXWGU11mSul
         kqK8dQnDKRH2RUtqGz5y2n4Sk+aWE5EsNkO6pjKOmWKtPCQmrWH7Sb98aFC7Ai18vdaM
         xCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r08Y9PyPMDpyrszLAyVhH3DCk6hbIyWyHI7hIZi6JC8=;
        b=irm5mD+fRni78NlqbiU62INikpv4LyaSs44TFn/4Z61VMP8pvQaML/zldwMN8vBKFi
         4zUsu+LAMYm3VQ6e48I3UnWKV+HknvjSwYiJNP+9kAIJeo+d2tRpHCzrBv96tyMFjcSs
         m/CK67h2FHVAcWmhM5c3smWsBujFjaiut3xBNNnrwftkZJdWv2QrAwINWW4WrMvPspGl
         NA3qsJIHbHSa1FYDun2PA2+SdGXY6jZTV/jtZmnhnWTzxsHqct7bOdRVh4ceh64rb67p
         asUd3h4YVPCWS/Ezcg8QrjCdLioOs063lQkxpYIhT/aSer6tjtrQ30aJ+0v80Fh8svtS
         PiCA==
X-Gm-Message-State: AO0yUKVyYfL9BKs9vu30cADp5+Y9Z7ouLVyCybbqas8OOi6h6LQsZUi5
        wWhMsHT5jpEPZ3uYOJYkajauL72sydQdDO5G
X-Google-Smtp-Source: AK7set9SSOrmFJOMfw/vnUHn1Oe8daTUi3aLoP0X/GtU2m7SEk8hV08UuG8m4jKf4JHzbAA86+NQug==
X-Received: by 2002:a05:6000:124b:b0:2bf:942b:ddc with SMTP id j11-20020a056000124b00b002bf942b0ddcmr1244093wrx.55.1676361443203;
        Mon, 13 Feb 2023 23:57:23 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id v17-20020a5d43d1000000b002c54bf0e9f7sm9538094wrr.117.2023.02.13.23.57.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 23:57:22 -0800 (PST)
Message-ID: <ea71351a-c87f-13f2-e1e8-1d7c5a3838cd@linaro.org>
Date:   Tue, 14 Feb 2023 08:57:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/3] dt-bindings: power: supply: pm8941-coincell: Add
 PM8998 compatible
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230213204950.2100538-1-konrad.dybcio@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230213204950.2100538-1-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8
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

On 13/02/2023 21:49, Konrad Dybcio wrote:
> Add a specific compatible for the coincell charger present on PM8998.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

