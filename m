Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8507C60C4A2
	for <lists+linux-pm@lfdr.de>; Tue, 25 Oct 2022 09:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbiJYHCb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Oct 2022 03:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiJYHC3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Oct 2022 03:02:29 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C072B1BAF
        for <linux-pm@vger.kernel.org>; Tue, 25 Oct 2022 00:02:27 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id y14so10141711ejd.9
        for <linux-pm@vger.kernel.org>; Tue, 25 Oct 2022 00:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oTZ9XSXY51LXE4jSLx8/7Y425Go53KxTtpmQE436jms=;
        b=Vrn50l/7KcIqk45mCOD0jXO0febPcbWtWGjEe0hfU9wx/ioohNIusCONFG1//hwvtb
         EhyTDGnaChULuE+Q6+b0DNlqwwvx31dxnYOabBzMd4gQwDxJZXs8WqEKV7BGjVaJB9yU
         L+cRUFr+J2JzZiigkzHUgfekEjodEdDdMtk48mYzc4ehTa8l0Xh7kSyTsOJnjWea42hE
         yHYs37mFLnU9X+U5WhV2hQvY2KAT+DbjP2pIOqQIZcaWTkYWCKMkrqyEFKJdlV5VN0he
         LkyEiQEadIWtKwXEW/ppUtc5svDYsTgipmeLyOrr7qjWZq1191o60l/3NFvKMhwFRkdy
         vYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oTZ9XSXY51LXE4jSLx8/7Y425Go53KxTtpmQE436jms=;
        b=R/1d+ZlZVYeEatFd+6Cqo+gXmBjxCTd0i2knyCOTkEvURSqstSCxKACF1r9FuEkVK1
         3ObEDZjbE5gb2sptgKY4+oaA2zHkF1JpDdEzezg6v003c4bojoIVZct7wAWhjHU3pUdz
         9kg1DvnacAXZyFyXQyEs5vUURkfCw80aeWwvphjZ6WB7atNxdSeM3FNVQPb1Vm3f2NbU
         wkLuH1SHMW4R+APDynm89M5sW3IwcDMOiLvyxxJACsGuEHOzvKP1MR97ycfRo1SOU/FT
         icpLfld6sY+Fdugnm224O4Wi4CJF7Ugv26/qqyc9YYA9VJnjzRi3RMzIzOA4GJE1eUY8
         eMTw==
X-Gm-Message-State: ACrzQf0Mm94OiROSG0prRKrrdqWVQIFMvdfDme/741UkTmUMEFvPud8P
        fGLh1EoBu9edQO5i5unedbVp5w==
X-Google-Smtp-Source: AMsMyM4tNlC0ScUTYnXvwt3Ls+S3XvBHssRegDia1ErDnteViPsVrAmp6mDxo/TVUt7rRc1QFOBK2w==
X-Received: by 2002:a17:907:3f94:b0:78d:9d2f:3002 with SMTP id hr20-20020a1709073f9400b0078d9d2f3002mr30783518ejc.40.1666681346111;
        Tue, 25 Oct 2022 00:02:26 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:8219:f4b9:b78d:7de7? ([2a05:6e02:1041:c10:8219:f4b9:b78d:7de7])
        by smtp.googlemail.com with ESMTPSA id ca28-20020aa7cd7c000000b004618e343149sm1052055edb.19.2022.10.25.00.02.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 00:02:25 -0700 (PDT)
Message-ID: <cb44e8f7-92f6-0756-a622-1128d830291c@linaro.org>
Date:   Tue, 25 Oct 2022 09:02:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] thermal/drivers/mellanox: Use generic
 thermal_zone_get_trip() function
Content-Language: en-US
To:     Ido Schimmel <idosch@nvidia.com>, vadimp@nvidia.com
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Petr Machata <petrm@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "open list:MELLANOX ETHERNET SWITCH DRIVERS" <netdev@vger.kernel.org>
References: <20221014073253.3719911-1-daniel.lezcano@linaro.org>
 <20221014073253.3719911-2-daniel.lezcano@linaro.org>
 <Y05Hmmz1jKzk3dfk@shredder>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <Y05Hmmz1jKzk3dfk@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Ido,

On 18/10/2022 08:28, Ido Schimmel wrote:
> + Vadim
> 
> On Fri, Oct 14, 2022 at 09:32:51AM +0200, Daniel Lezcano wrote:
>> The thermal framework gives the possibility to register the trip
>> points with the thermal zone. When that is done, no get_trip_* ops are
>> needed and they can be removed.
>>
>> Convert ops content logic into generic trip points and register them with the
>> thermal zone.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> Vadim, can you please review and test?
> 
> Daniel, I saw that you wrote to Kalle that you want to take it via the
> thermal tree. Any reason not to take it via net-next? I'm asking because
> it will be the second release in a row where we need to try to avoid
> conflicts in this file.

Because I hope I can remove the ops->get_trip_ ops from thermal_ops 
structure before the end of this cycle.

May be you can consider moving the thermal driver into drivers/thermal?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
