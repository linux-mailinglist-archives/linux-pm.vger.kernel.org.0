Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552707851FC
	for <lists+linux-pm@lfdr.de>; Wed, 23 Aug 2023 09:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbjHWHu4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Aug 2023 03:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbjHWHuz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Aug 2023 03:50:55 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F88CF1
        for <linux-pm@vger.kernel.org>; Wed, 23 Aug 2023 00:50:53 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fe32016bc8so49699715e9.1
        for <linux-pm@vger.kernel.org>; Wed, 23 Aug 2023 00:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692777052; x=1693381852;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P+2FN7G3eyYYkhDUmvsMFL/gLA2nmLv/bVLmgPvX5x8=;
        b=WCF47nydVfAWb+ufLmnZ8/s5gIespS2nG1nk8bJRxgB1/wlf+lHUeg5vcGZMVedVYS
         2fR0xUagE+ECrVqpxjHIwyYzgIskHwhvqBW39A+OXfkOHB/+9K+r0/GHkNyppJxOjGPV
         qDGm5FXj8zO+kIBIhznp4cSjN5WQPpN0ynXRHWJW6I+6v3ecoA6W0T4PryfKwAu+6baV
         JKU0l8OKHm+M8fTwk2wb1m0+v+q6bl4aDtXajdOC8XJ99UUVIyS+IertDwcoNjSuaf1Y
         PLixayZC6aXPpMsE1d00Fs32rOGhTnUtSL2Ngl0KM4UXUq0o6Jlr1Y5BPVgPctwlr/Jx
         AwpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692777052; x=1693381852;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P+2FN7G3eyYYkhDUmvsMFL/gLA2nmLv/bVLmgPvX5x8=;
        b=PYlkyDdKTALf/1PAoVSkFF9Jg/Isp/xpAHaI0QIvbr0sVCaGb2hlKOkPUsi0BfgRXY
         jEb4adnNCrCGnCvYVGVZ9DBI9emI1rfQn3xVpZC5AmRElDer4u5M7rIvw0r1xwXIlVKZ
         frg53tebr0YTNnnJ4U/c7CkBG7GcimSaRvdvfC9Fy/IdUapUDHqsfCNXH4TZLBXaUL2S
         Eo+4cpgcbAUw3CqUI7I2O5VlR8f1BTYEBKPWKr2bt/9XGUXhUvtYBvUv5JG4XsejSjeB
         XDYqT2fnHgW1qGOI/Hf+azp9mGeou0xHTRfxjFS9RXUKinZvhQ7GFMYlP1IKBDgEXoTS
         LCCg==
X-Gm-Message-State: AOJu0Yz+55GBv1r1TI4KgiB/FxMt5avjDvTYhHNY7j81XU2LGscQvtgQ
        MxbYoIEb/pX6vmOCdRXYp8uHNQ==
X-Google-Smtp-Source: AGHT+IHliTw/1uQuYtcsGVJC8NunfbGQTeq0qoFKdTLFBz2buL2gFvFX+Kn9wTjsUTs5zvK0H2IG5w==
X-Received: by 2002:a7b:cb89:0:b0:3fe:fe71:14df with SMTP id m9-20020a7bcb89000000b003fefe7114dfmr2022507wmi.35.1692777051936;
        Wed, 23 Aug 2023 00:50:51 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 1-20020a05600c020100b003ffca80edb8sm648850wmi.15.2023.08.23.00.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 00:50:51 -0700 (PDT)
Message-ID: <e299d921-1609-70fa-33f6-97e51fe0b646@linaro.org>
Date:   Wed, 23 Aug 2023 09:50:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] thermal: tegra-bpmp: Check if BPMP supports trip points
Content-Language: en-US
To:     Mikko Perttunen <cyndis@kapsi.fi>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20221129153914.2699041-1-cyndis@kapsi.fi>
 <Y9KTrO+WqJJwuEDf@orome> <a08355e1-c393-2b2e-4a44-360e08607bb9@linaro.org>
 <Y9KfcSwYt7utbcg5@orome> <e716eda4-edfc-5946-4e6f-42aab5f73b0f@linaro.org>
 <d7435a96-3480-280e-d996-73fea690c373@nvidia.com>
 <2c37a786-0ae5-273e-f82b-4f9c82663053@linaro.org>
 <7c342b0c-9657-ffd1-6fad-ef6433ddc793@kapsi.fi>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <7c342b0c-9657-ffd1-6fad-ef6433ddc793@kapsi.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21/08/2023 12:08, Mikko Perttunen wrote:
> On 4/3/23 13:26, Daniel Lezcano wrote:
>> On 03/04/2023 12:22, Jon Hunter wrote:
>>> Hi Daniel,
>>>
>>> On 26/01/2023 16:07, Daniel Lezcano wrote:
>>>> On 26/01/2023 16:42, Thierry Reding wrote:
>>>>> On Thu, Jan 26, 2023 at 04:08:03PM +0100, Daniel Lezcano wrote:
>>>>>>
>>>>>> Hi Thierry,
>>>>>>
>>>>>> On 26/01/2023 15:52, Thierry Reding wrote:
>>>>>>> On Tue, Nov 29, 2022 at 05:39:14PM +0200, Mikko Perttunen wrote:
>>>>>>>> From: Mikko Perttunen <mperttunen@nvidia.com>
>>>>>>>>
>>>>>>>> Check if BPMP supports thermal trip points, and if not,
>>>>>>>> do not expose the .set_trips callback to the thermal core
>>>>>>>> framework. This can happen in virtualized environments
>>>>>>>> where asynchronous communication with VM BPMP drivers is not
>>>>>>>> available.
>>>>>>>>
>>>>>>>> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
>>>>>>>> ---

Thanks for the head up, that should be fixed now.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

