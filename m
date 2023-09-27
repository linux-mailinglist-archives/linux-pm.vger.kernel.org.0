Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261987B0778
	for <lists+linux-pm@lfdr.de>; Wed, 27 Sep 2023 17:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbjI0PA0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Sep 2023 11:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbjI0PA0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Sep 2023 11:00:26 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76522191
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2023 08:00:24 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4063da036c9so37285815e9.3
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2023 08:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695826823; x=1696431623; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NewR8mz3IDKSzbhyhEdNVdjJ713zwUsUtm4gHKiLJro=;
        b=oimuB8CgT98N8oKbqJao/E4cuj5pR1VCQXqSdVjbugHUbApUvSCJFbR2BKOOW5jR1v
         uNOfLNIfxx/t9gLU3u6WrctHo9/KxbJ2+sCMWLYgoyG9cFkeHkhFDvarbOHDkddokYBi
         q7rCfdg5G34/NDlJ8IZyy1mx3bxQv+0HQzbXatQS5hcPku8S+6jGWFR+iny/ZxfjCwD5
         tt99vIspuB2/bWrjPwXtM7qP/tU5hrMibMf1YKtio7tN15kTxUVy8tuUzz9OlDM2w2iF
         zWm+NCeijAkl0mT2WJlnwSOx6XlRcQU4DLE+oo5oYHSMD/GynBQRteZ3dvpozBzCzDU7
         t/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695826823; x=1696431623;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NewR8mz3IDKSzbhyhEdNVdjJ713zwUsUtm4gHKiLJro=;
        b=LczOvGb64jVFUptJwLfObH8sx2lAmj8fxgCW4ST6LIpo4jjf4B5SElIJpw5gGDV6z3
         z4BSgbUGhMTrN4FwkJk9pI9lkOcszfjgaMKZJEno991my4VN40s2zvC6u2eg063UlzhW
         XCg9AAtYYppzdVqOJz5rV9QIQHI0pTN9EHlRPFVHHPIYywfcSq7yHy7p4RxzfVHbEDvh
         1yqF5ScUJ1v5U5Ux8c7zUpXmhgPtr59PKy4ItKyECJPe1BYyLvWV803gT23jHY7FdP16
         KiEIae6twQyT4OWU5wYOFyCYheaNBZHWt0/tjUApzpbnTyPa65OWe7K6POAxx5yVT7w9
         8TWg==
X-Gm-Message-State: AOJu0YyfkGx6f6RDw1wNG5HtgY0gqlswigRZle+gS7B28ro+CxMbYF8a
        fAcTVzluaLnGTLxcsYf7zCiFvQ==
X-Google-Smtp-Source: AGHT+IETTSPE9U+FYpjyRNTB+9sCf6QDVtfDMiQViMJoD01LWgrGCZjwBY+nkwnsQw5TGzj7/1jgUA==
X-Received: by 2002:a7b:c409:0:b0:3ff:ca80:eda3 with SMTP id k9-20020a7bc409000000b003ffca80eda3mr2253169wmi.10.1695826822830;
        Wed, 27 Sep 2023 08:00:22 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id j13-20020adfd20d000000b003232c2109cbsm7453676wrh.7.2023.09.27.08.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 08:00:20 -0700 (PDT)
Message-ID: <3c9f7b7d-a9ca-79ae-4e64-367a82f953bc@linaro.org>
Date:   Wed, 27 Sep 2023 17:00:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 06/13] thermal: gov_fair_share: Rearrange
 get_trip_level()
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <1957441.PYKUYFuaPT@kreacher> <1882755.CQOukoFCf9@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <1882755.CQOukoFCf9@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21/09/2023 19:54, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make get_trip_level() access the thermal zone's trip table directly
> instead of using __thermal_zone_get_trip() which adds overhead related
> to the unnecessary bounds checking and copying the trip point data.
> 
> Also rearrange the code in it to make it somewhat easier to follow.
> 
> The general functionality is not expected to be changed.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/gov_fair_share.c |   22 ++++++++++------------
>   1 file changed, 10 insertions(+), 12 deletions(-)
> 
> Index: linux-pm/drivers/thermal/gov_fair_share.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/gov_fair_share.c
> +++ linux-pm/drivers/thermal/gov_fair_share.c
> @@ -21,23 +21,21 @@
>    */
>   static int get_trip_level(struct thermal_zone_device *tz)
>   {
> -	struct thermal_trip trip;
> -	int count;
> +	const struct thermal_trip *trip = tz->trips;
> +	int i;
>   
> -	for (count = 0; count < tz->num_trips; count++) {
> -		__thermal_zone_get_trip(tz, count, &trip);
> -		if (tz->temperature < trip.temperature)
> +	if (tz->temperature < trip->temperature)
> +		return 0;
> +
> +	for (i = 0; i < tz->num_trips - 1; i++) {
> +		trip++;
> +		if (tz->temperature < trip->temperature)
>   			break;
>   	}

Is it possible to use for_each_thermal_trip() instead ? That would make 
the code more self-encapsulate

> -	/*
> -	 * count > 0 only if temperature is greater than first trip
> -	 * point, in which case, trip_point = count - 1
> -	 */
> -	if (count > 0)
> -		trace_thermal_zone_trip(tz, count - 1, trip.type);
> +	trace_thermal_zone_trip(tz, i, tz->trips[i].type);
>   
> -	return count;
> +	return i;
>   }
>   
>   static long get_target_state(struct thermal_zone_device *tz,
> 
> 
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

