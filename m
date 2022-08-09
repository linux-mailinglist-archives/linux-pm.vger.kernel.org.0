Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0955458E204
	for <lists+linux-pm@lfdr.de>; Tue,  9 Aug 2022 23:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiHIVqE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Aug 2022 17:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiHIVpv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Aug 2022 17:45:51 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863B34B0DF
        for <linux-pm@vger.kernel.org>; Tue,  9 Aug 2022 14:45:49 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id z16so15651374wrh.12
        for <linux-pm@vger.kernel.org>; Tue, 09 Aug 2022 14:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=5geUTWjaaOcBVhWxz5YB+FFbf6115VxYj5loGEcSOU8=;
        b=x4fQxmWEZCRBZn3qEbFM/+uOtmYZ2uAh11sMqgrnKo/G/Ulw+RAwW6WAnfR/oqPPGG
         oLU/z1i/dN4JbEZENr/AyLI1zM5YMv4kCyUl3WVqtL6/sUGK6HkMltPF5mo3r9nGBpm4
         Dp2BGyd4UI1+HC/EUPIppso+nWPufJnE+OmkXmQ3J3uudHzP4KYI6L9vdN/07FPhEOjl
         NlcohzxolgNyRL0PMhaPJ0AJj5aaBYx99HzNfnYzAYIXmhQ4PRioxOLLZXygGjxFa5NO
         +Z9xbQ4dJRRlbmKBeHdnac9TVo3DH/++tYfeiAnJFlkEfSm2nHUGLHj3p/nb8vMMtiKF
         qQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=5geUTWjaaOcBVhWxz5YB+FFbf6115VxYj5loGEcSOU8=;
        b=rgVB+iTNRKe5zWyudHp/VvzakOT/Y5iDXbmZ9U/cDv9n/P9YqM2sHUu6oRw3NVIa8i
         N1NECw6tujYqjx3J66qmgvs+oFOSR47mRA723MdUoaWz4zk2GYBgpVkUwkeAOOxcmLmq
         qQWvnw+nuCTGRChzu50BR6e4f8Sg1PSTu9h7kEBTSZTpHUEZfNtBOs+x2ES5mJvi/QE6
         NrzdW124cfZzLRc8fXDSHwx+Seo07zyDl9rj+sk8+xjENuG9xvEEUTwHuh7Dtc1wO1UW
         7BYG5psxs5Y9aR6OUZKEFhSv0mNo4RrYZmmdFOrKkslXW04J8yZUV5Q5aqFIqA7Cvqpi
         4XDQ==
X-Gm-Message-State: ACgBeo3haql+7X7rIrtDeTXfbcJa/VnhzDDlVFLY6yV+nva0Eg4nHZsn
        kVdww0KC7FZdlI7LX7RtRKCIiA==
X-Google-Smtp-Source: AA6agR6OYLekP1zwiTGxrgEF3gblfROb0Z0rtoZ9bUCWDXigJhZIB445MsB04r1kNXnyAdrIUUYbGw==
X-Received: by 2002:a05:6000:1a89:b0:222:c186:ca8a with SMTP id f9-20020a0560001a8900b00222c186ca8amr9723969wry.333.1660081548061;
        Tue, 09 Aug 2022 14:45:48 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id z19-20020a05600c0a1300b003a539792542sm227280wmp.7.2022.08.09.14.45.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 14:45:47 -0700 (PDT)
Message-ID: <1ef26db5-6e2b-ce27-f9ad-34ff8f4055cb@linaro.org>
Date:   Tue, 9 Aug 2022 23:45:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 23/26] thermal/drivers/acerhdf: Use generic
 thermal_zone_get_trip() function
Content-Language: en-US
To:     =?UTF-8?Q?Peter_K=c3=a4stle?= <peter@piie.net>, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        "open list:ACER ASPIRE ONE TEMPERATURE AND FAN DRIVER" 
        <platform-driver-x86@vger.kernel.org>
References: <20220805145729.2491611-1-daniel.lezcano@linaro.org>
 <20220805145729.2491611-24-daniel.lezcano@linaro.org>
 <fdaba367-c657-0d85-7244-918b99569337@piie.net>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <fdaba367-c657-0d85-7244-918b99569337@piie.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08/08/2022 21:34, Peter Kästle wrote:
> Hello,
> 
> some comments.  Please merge if those are considered.  Thanks.
> 
> 
> On 05.08.22 16:57, Daniel Lezcano wrote:
>> The thermal framework gives the possibility to register the trip
>> points with the thermal zone. When that is done, no get_trip_* ops are
>> needed and they can be removed.
>>
>> Convert ops content logic into generic trip points and register them 
>> with the
>> thermal zone.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> Acked-by: Peter Kästle <peter@piie.net>

Thanks for reviewing the patch

[ ... ]

>>       if (kernelmode && prev_interval != interval) {
>>           if (interval > ACERHDF_MAX_INTERVAL) {
>>               pr_err("interval too high, set to %d\n",
> 
> I don't know the current behavior of the thermal layer well enough.
> Is it ensured, that those new trips[0].temperature / trips[0].hysteresis 
> values are taken into account?

I don't have this platform so it is hard to test. All the device tree 
based sensors are using now those generic trip points and that works.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
