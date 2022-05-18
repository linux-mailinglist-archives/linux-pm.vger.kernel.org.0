Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A681552BBDE
	for <lists+linux-pm@lfdr.de>; Wed, 18 May 2022 16:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237378AbiERMsb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 May 2022 08:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237468AbiERMr3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 May 2022 08:47:29 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1703BF82
        for <linux-pm@vger.kernel.org>; Wed, 18 May 2022 05:46:38 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u27so1729389wru.8
        for <linux-pm@vger.kernel.org>; Wed, 18 May 2022 05:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TqvCPF23Ms20FFQ5TlXnBSrzpH8LW6nALjmeWYnhReo=;
        b=DSgUV6ToeN1MSryHL/tltBh6f9mKpkryoPaBlsNHGYMCXLXqkxMktmfdStBq02SZGa
         oygT1vN282zL0iPelZlIx5NuwBLtndPSzLExgCVdiKR89shaWf9sYVBtBvuUp1DqknXJ
         pPajFqfQ96pLqv2TyZ+uEt2IeEKCnKNftr4ufmHYLT5KnUauabiHJ2cHa4w//+GrkOtG
         H88+SZdtpUi/TiR+iopdyL9D2JPRurqfmRI19Xd9otkcGO8QFoc/eqerdmvdRVnf51LJ
         NLgAPIiwXBMKYt7sL6EsK3bd9V2M1JCWOcp4aJbbPCahjwhXCxohuIk0yUrl+2V4bVUV
         VJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TqvCPF23Ms20FFQ5TlXnBSrzpH8LW6nALjmeWYnhReo=;
        b=KRDdrcBDXYhOeYn3tG90BSM/mCso3qIyH5o7bFobVdvFfpCCj1lQYnHG1fZJhrma+Z
         t/0QLY5GYPzuSkIf/ND8LVIBfKKjrEWOB3GzInBlRhxSrGRegPjRG/TjeB0gASm3d7Gi
         fxS+aHZ6CsBjdgtx7R7keMQiuxdb5IghifgeibRAjDdnGTqRDGDC1p+etBaeFR1y/P/s
         CiagNPv00/6wake8NBG+OiLFQrWrel2kjPX2kKX74ZUJ4flIHVLguPEsVw2KFlZHJDt6
         0lgt89Zd1zdUhAIH/Ekrusv32g+DBecOJ+a5ZHt2hegpZcf+sZdHZLtXsUHxl343YEWs
         x99g==
X-Gm-Message-State: AOAM532AUyNUMNaigR1QF7kqyZCBWLfbpROBVr4tVo4DA6viiNsW55dl
        hh+UfMldWn6npTihH1zyEV3uig==
X-Google-Smtp-Source: ABdhPJw9hqTJXrzAyDQDtMUJVh8D+qdxxxXPxX90fAkVu57sAotRgHnTkS6DQrnAhMKsrAUyaL74OA==
X-Received: by 2002:a05:6000:786:b0:20d:6048:71bd with SMTP id bu6-20020a056000078600b0020d604871bdmr7847076wrb.358.1652877996745;
        Wed, 18 May 2022 05:46:36 -0700 (PDT)
Received: from ?IPV6:2a01:e34:ed2f:f020:713a:278c:9b87:86fe? ([2a01:e34:ed2f:f020:713a:278c:9b87:86fe])
        by smtp.googlemail.com with ESMTPSA id f1-20020a1cc901000000b00395b809dfd3sm1676759wmb.12.2022.05.18.05.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 05:46:35 -0700 (PDT)
Message-ID: <916c968b-773d-197d-4e22-2fcca805ceba@linaro.org>
Date:   Wed, 18 May 2022 14:46:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v9 1/2] dt-bindings: thermal: k3-j72xx: Add VTM bindings
 documentation
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Keerthy <j-keerthy@ti.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rui.zhang@intel.com,
        amitk@kernel.org, kristo@kernel.org
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org, vigneshr@ti.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220517172920.10857-1-j-keerthy@ti.com>
 <20220517172920.10857-2-j-keerthy@ti.com>
 <783127cf-79cf-90f2-4200-30db56a1fd7c@linaro.org>
 <9417e665-c1d4-e82c-5c55-a2c5860cc453@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <9417e665-c1d4-e82c-5c55-a2c5860cc453@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18/05/2022 14:42, Krzysztof Kozlowski wrote:
> On 18/05/2022 10:27, Daniel Lezcano wrote:
>>
>> Hi Krzysztof,
>>
>> I would like to pick this series, does the DT bindings have your blessing ?
> 
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks!


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
