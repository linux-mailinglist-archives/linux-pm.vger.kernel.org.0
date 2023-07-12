Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C45750558
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jul 2023 13:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjGLLBu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Jul 2023 07:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbjGLLBn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jul 2023 07:01:43 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F26110CB
        for <linux-pm@vger.kernel.org>; Wed, 12 Jul 2023 04:01:41 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742eso73319535e9.3
        for <linux-pm@vger.kernel.org>; Wed, 12 Jul 2023 04:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689159700; x=1691751700;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7DNU8Zn50hcJTkclEiZBzPiQhwUIF44em/ljan3WFiM=;
        b=orP/q4/hs+BBuXOs5oeiSKZukEHPsu0OxKuwvA22Ir/DkD+IIEPlMsT6jmEv0ElXtk
         uyNLjWjYf4Vr55Ak5eIuUbmnh1yuWGJzkycrE7I/oIRO+/T56BPlRSlFS6tyIEdsxU9Y
         y9XC62NHfZTYl/cVX6zstlz0u5MphBQV7q0aj7Dj9TJD0gn70uJ33qb8p2SRSkDzmIG7
         mN9EwyniyeXXQUlAudIkjmbyHGXDqXUU9mRTZwOwYm3dk+A6mdjptbkYxCdUNnv3VyMt
         zwfE7y22mDtnLZpq1ddweuAuKO+t9MkQXVASUMnerc+MLE9K95luBHmp5Pg7rOYNZa9m
         3Puw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689159700; x=1691751700;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7DNU8Zn50hcJTkclEiZBzPiQhwUIF44em/ljan3WFiM=;
        b=KZjxzaZl089hqgIFNQ9Hm+sRnVvt277wfXEXkXzihl2b2ly/8djs+cKzGCrDZyWTbY
         Hmcu1wT6u+70FcfeLJ0tgEMrx1SDJmDpu7loKl/O2CKf6iDGFTf3Sks0Cj78U+h3N7Oo
         kHFk6ELVlr/RbXxtvoRewpwhA8qQhE5hvRYPTIS/J5gy3VbsRTYZ14iNDzvlwz+Ra2Pn
         UeqvwMzkqtaSiZ4ro9JiLDxWVObuA/WAOtQzc1aDHd9hwAREhmQ/NkMfsr0usKIptz9P
         lffCALztATH9mry4u0u8Rq9hs34u/oyzXMnn9oJijWFtMvQ1mmK+biPmY5SrW0PUMcxO
         g1+w==
X-Gm-Message-State: ABy/qLYNdcGfOEK+34PNBrSWdjDVuTbJyuJQGF0RGLM36SEmoii90cwz
        MWVHXQuLHIgX7RnJlxl6Qj/EZg==
X-Google-Smtp-Source: APBJJlG4iPShxpzN3vxIT+IuZ/OMSBFfI9cIxYxLVNyDnz8Vb3ca/YvQGYO3ppTHTSVQNxItjAN6fQ==
X-Received: by 2002:adf:e341:0:b0:314:5535:8366 with SMTP id n1-20020adfe341000000b0031455358366mr16249852wrj.43.1689159699787;
        Wed, 12 Jul 2023 04:01:39 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id c17-20020a056000105100b0031433d8af0dsm4793893wrx.18.2023.07.12.04.01.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 04:01:39 -0700 (PDT)
Message-ID: <881ed565-bab7-5c2d-2255-900fbfffae28@linaro.org>
Date:   Wed, 12 Jul 2023 13:01:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 00/10] thermal: tegra: Do not register cooling device
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20230414125721.1043589-1-thierry.reding@gmail.com>
 <fa218582-0ac1-ea8e-fcaf-222bdcf2bc6a@linaro.org> <ZK14edZUih1kH_sZ@orome>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <ZK14edZUih1kH_sZ@orome>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/07/2023 17:42, Thierry Reding wrote:
> On Tue, Jul 11, 2023 at 10:25:16AM +0200, Daniel Lezcano wrote:
>> Hi Thierry,
>>
>> do you have an update for this series?
> 
> Yeah, I've been working on this on and off for a while since I ran into
> some complications with this version. I need to find a block of spare
> time to go over the latest version again and do some testing. Hopefully
> I can get around to that within this week or next.

That is great, thanks !


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

