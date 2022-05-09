Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCC351F9FC
	for <lists+linux-pm@lfdr.de>; Mon,  9 May 2022 12:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbiEIKfm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 May 2022 06:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbiEIKe5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 May 2022 06:34:57 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCA73E0D4
        for <linux-pm@vger.kernel.org>; Mon,  9 May 2022 03:30:50 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id i5-20020a1c3b05000000b003946c466c17so106755wma.4
        for <linux-pm@vger.kernel.org>; Mon, 09 May 2022 03:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Qgkx9ZC8YGJJeK5iTMZYlOqvFF3Oqattg27UJCiRY1Q=;
        b=Pi3Xgsw+zt4lcSvgy01HxAxeKPFRomrVRyzr1Mh7iUX24+iKZGe77eE/XeZokDgUK8
         yUpbrar1CwEtSqJpt1JaYJ+Vcm4ESYQMY5t8/5jvPYr9NRz6jW/7mcM8vSfHXYhoZvrS
         28hHPFW/5ec+50Fces0xUNsRNMNMrSqjjieqIR28jeszSVFYacK7MUZ8Xrq/JzblklgI
         CjGsMLz3dVfBZ6g1SBY8xywboRbMcVIVPCGx9vV800o7TB3nMkShpEkkIIVxlKWahg2s
         8YECUEGbCuReXVLhhsK8RcgUFWbViaxNg31dPs8Ms/zPhjMxtuXBn0Ir46i/rGa4KNzQ
         wxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Qgkx9ZC8YGJJeK5iTMZYlOqvFF3Oqattg27UJCiRY1Q=;
        b=SD3gE2TiQPhBiYXvTk8eBNe/9NRco92Mj9M7pXKDyvH3bMWcQWlWOpuaOfE1njjQgI
         c4mDd83nj5ia1NFahzrvhJnqf4+2OmQnQnxwjk+eANL/UYXR4V4jVhaEzDRVh9iCnUx9
         pRkTtLAHJrBGxn/a3bvtSGNMcAUmAmJTPNI8L0IuxUCfe+xeFJWn5t2Sgu4p8W/Egp3q
         jeAqvRm+s1/ndCyEGE32FS7/OR/9ZHJ9Cajy/Y9rutH73fwrKJyubkjTRnWBV9bxu3jm
         aeh9ycfSNDoHjJjCkdAy4Je/JUygccMfR3OysO5ocXm/jTYZteebX7/4iaKq7cq6D+43
         ywXA==
X-Gm-Message-State: AOAM533ActOcwDn4We+ycliTYdL9A1nOs6d644Z9CzMF12b8IFZP03Kc
        s/AkehOu/ZYDRTUZRm82mDzc5nRmFImziQ==
X-Google-Smtp-Source: ABdhPJwIftT/UsBQmfVV48i+Vgca7Yqe2sTYcpBIUm433z+geRhMUia1x9txLA/Oj+TL2SMmKfKeXQ==
X-Received: by 2002:a05:600c:190b:b0:394:96d3:5780 with SMTP id j11-20020a05600c190b00b0039496d35780mr1627274wmq.82.1652090567943;
        Mon, 09 May 2022 03:02:47 -0700 (PDT)
Received: from [192.168.1.41] (176-182-171-101.abo.bbox.fr. [176.182.171.101])
        by smtp.googlemail.com with ESMTPSA id n11-20020a056000170b00b0020c5253d8c7sm10283350wrc.19.2022.05.09.03.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 03:02:47 -0700 (PDT)
Message-ID: <bb05dd4b-3114-73bc-0bd8-81e30dac1497@linaro.org>
Date:   Mon, 9 May 2022 12:02:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] thermal/drivers/qcom/lmh: Add sc8180x compatible
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220502164504.3972938-1-bjorn.andersson@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220502164504.3972938-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02/05/2022 18:45, Bjorn Andersson wrote:
> The LMh instances in the Qualcomm SC8180X platform looks to behave
> similar to those in SM8150, add additional compatibles to allow
> platform specific behavior to be added if needed.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
