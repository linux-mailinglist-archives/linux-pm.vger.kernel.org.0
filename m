Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1882B5FEC75
	for <lists+linux-pm@lfdr.de>; Fri, 14 Oct 2022 12:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiJNKVQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Oct 2022 06:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiJNKVP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Oct 2022 06:21:15 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19DC1B94E5
        for <linux-pm@vger.kernel.org>; Fri, 14 Oct 2022 03:21:13 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id y10so2819706wma.0
        for <linux-pm@vger.kernel.org>; Fri, 14 Oct 2022 03:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dDU1EHry5n+XrvnahgNgah2Rjg065mq9PJm7gjM4LqY=;
        b=weBpi7OT8CMZrlbpSnhba0XK7AN7li0KVaeNIC9WLH5il+FoUOWOHgPjMa3T2BLRFU
         2JGX09gQtSGRZX5Mi1lO6g5KAuDbwwH1Atfg4qdGPoerf8g2ACU3nnJRIRdfWqY2C2aT
         mMk08B6uAB4oYiaVBZEf4KgHaZfe+3XwOzVkCIpGq9W+uE2qVmcA6U2xajbUhH4K+z5v
         FA/qF6pJbowGLw3i3s90YdZHizscizbVuMwnF/pJxMjzygUWSekeWhH8uR5ViLxfcvw6
         I54tnjAKsZwvUVnfljwK5CoAHvHkZKmI9y1G8BGBxIQU3CnYVSuCBJHJ+R+DSLRaQ2u+
         nILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dDU1EHry5n+XrvnahgNgah2Rjg065mq9PJm7gjM4LqY=;
        b=Ct7H98G5quQeOzHk65PTERdwsnCt20xhk6b68B8nwWHJ8kDHnD4cZMku4RClyItVmK
         H5snEGu564nxYN+zSLFNmydAhLh+f45nP6Bxzf4cDOOwXjzZyH9yR3GTjne0ZQF2fGSU
         fSDL/96/qVAlDyDrdAI7XCOJezuLp2PKOKUl0OyMVS/7E8BLy5+gyuRp7fZ2+as0B9Hn
         UaSr+PFLGEe9RQ3gWQP8juup144rGzVR0ai/e5yYfWuA/SRJf3WzSgAnR2HnQ/ob+3ZE
         LVDd9EWZ4e0xCL3FSjxTAa3bEqOu8Pbxf0SNmp3XY6FDGq9kxw8JQ1ScGgupZ8qIvgzT
         r5oQ==
X-Gm-Message-State: ACrzQf1WaBuoraLecfJZ8ciB/YH8SyVD1QUGettFpu3bj48oYdiURreM
        wSZFqmHCmvgRZydWpk/r0V8T1g==
X-Google-Smtp-Source: AMsMyM4hwqGQBIpE+BIeCKNhNjdJTVXdfNcXvl3ImrKVug9wu7yYYNOc/LK8urWEJtHZ5ZgSMDmCoA==
X-Received: by 2002:a1c:f008:0:b0:3b4:fd2e:3ede with SMTP id a8-20020a1cf008000000b003b4fd2e3edemr9737880wmb.133.1665742872213;
        Fri, 14 Oct 2022 03:21:12 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:b460:17f0:186d:9d2e? ([2a05:6e02:1041:c10:b460:17f0:186d:9d2e])
        by smtp.googlemail.com with ESMTPSA id n17-20020a05600c465100b003c65c9a36dfsm1633633wmo.48.2022.10.14.03.21.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 03:21:11 -0700 (PDT)
Message-ID: <f327dfc4-cd67-930c-a011-8cc2c58d7668@linaro.org>
Date:   Fri, 14 Oct 2022 12:21:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] thermal/drivers/iwlwifi: Use generic
 thermal_zone_get_trip() function
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Nathan Errera <nathan.errera@intel.com>,
        "open list:INTEL WIRELESS WIFI LINK (iwlwifi)" 
        <linux-wireless@vger.kernel.org>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>
References: <20221014073253.3719911-1-daniel.lezcano@linaro.org>
 <87mt9yn22w.fsf@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <87mt9yn22w.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14/10/2022 12:15, Kalle Valo wrote:
> Daniel Lezcano <daniel.lezcano@linaro.org> writes:
> 
>> The thermal framework gives the possibility to register the trip
>> points with the thermal zone. When that is done, no get_trip_* ops are
>> needed and they can be removed.
>>
>> The get_trip_temp, get_trip_hyst and get_trip_type are handled by the
>> get_trip_point().
>>
>> The set_trip_temp() generic function does some checks which are no
>> longer needed in the set_trip_point() ops.
>>
>> Convert ops content logic into generic trip points and register them
>> with the thermal zone.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   drivers/net/wireless/intel/iwlwifi/mvm/mvm.h |  2 +-
>>   drivers/net/wireless/intel/iwlwifi/mvm/tt.c  | 71 ++++----------------
>>   2 files changed, 13 insertions(+), 60 deletions(-)
> 
> The subject should begin with "wifi: iwlwifi: ".
> 
> I don't see patch 2. Via which tree is the plan for this patch?

patch 2 are similar changes but related to the mellanox driver.

This is the continuation of the trip point rework:

https://lore.kernel.org/netdev/20221003092602.1323944-22-daniel.lezcano@linaro.org/t/

This patch is planned to go through the thermal tree

Sorry I should have mentioned that.

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
