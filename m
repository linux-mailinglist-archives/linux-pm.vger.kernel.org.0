Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294A1683343
	for <lists+linux-pm@lfdr.de>; Tue, 31 Jan 2023 18:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjAaRDS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Jan 2023 12:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbjAaRDR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Jan 2023 12:03:17 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6962DE6C
        for <linux-pm@vger.kernel.org>; Tue, 31 Jan 2023 09:03:16 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id c10-20020a05600c0a4a00b003db0636ff84so11166844wmq.0
        for <linux-pm@vger.kernel.org>; Tue, 31 Jan 2023 09:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ca1x6vxaNt3844rh9R8eGAp9Q2Pmfkwy4ktaauXt+qE=;
        b=SFuPnbKqjBa69MSbnwa5YvI8I1qpd/WuhJrGENnNKBfxwA1kS82h4PwZqaVoNnvUyc
         6yuHCSOCxrHGNToj0EBNfpVB7wkcGrfx0sw5+zM3lfcz/S2bzx3Npa11c/Dgy/vKCLoc
         7mzA5SFsNpSw1I/G0DVm8OiU03PhkQNogPNxXdS6avskHPpqbXRDc8Dm41UGhsNeeoiM
         5nKcF114rKensIlbqf4J+bQwjnquyWc0IeoNq3uWe8Qrd8UieRyn5RObA85WiXcft2ga
         45PK66r8/Z8RbAoNDH78w4DrWHyXJ/L3Xf9uz2Hrvdme3gdD3rTNGmyMvlNpz8JE/hfT
         uTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ca1x6vxaNt3844rh9R8eGAp9Q2Pmfkwy4ktaauXt+qE=;
        b=Uybv70E1nkg4sBf9Axwyob/byR6jNGHwI95SSAWZLhg5XZsL8YMoisPl0zTH+AVn4r
         gxGMzaNP2zplU7+oHuPINvqlYr6jbVgFjgq5U/hkFsCGGCyZEIcPTpvoVyT3oywEaXHc
         oW2vSHIZcnFUz/pgtmukd9GaXOVn+uvdsL/A6U2wNQpxHQtrBaDkpPOyoY/r9y78cS60
         W+Tn74tftPIPxG5Pe3qMOKbdlfkWok+OI2VxKcjB7slSFIAXG2pCTSa9IMxwf3VZ5aoJ
         5SdbXrRSIFv8Lvj6ocoZtQHW725nzvb7ZFq7UQR4GfjP3hPV1Sri5ijiezUctUY4gwML
         c+vQ==
X-Gm-Message-State: AFqh2krQCYF8We7TK3SJ6umAnJs0BN9tkK0uI6ypkMxBC9RvnQm7g3PV
        aKIxoxZREUpbT13HVhXKHeAlSQ==
X-Google-Smtp-Source: AMrXdXtgr459GIk/FoaoNNcMEKcD/XBMlB9KBFrPM2pDN1IWYCvvGnv1rPaXIf6qqk9WtmFZnjSkSQ==
X-Received: by 2002:a05:600c:1912:b0:3db:f0a:8707 with SMTP id j18-20020a05600c191200b003db0f0a8707mr51702996wmq.40.1675184594797;
        Tue, 31 Jan 2023 09:03:14 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id e5-20020a05600c254500b003dc47fb33dasm11975360wma.18.2023.01.31.09.03.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 09:03:14 -0800 (PST)
Message-ID: <beb367d8-dad7-87d9-7872-b81a4d3492ae@linaro.org>
Date:   Tue, 31 Jan 2023 18:03:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/3] thermal/drivers/intel: Use generic trip points for
 intel_soc_dts_iosf
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Amit Kucheria <amitk@kernel.org>
References: <20230118181622.33335-1-daniel.lezcano@linaro.org>
 <20230118181622.33335-3-daniel.lezcano@linaro.org>
 <CAJZ5v0jbHR03UyJBMmBBYnSsZmGG0OXqLJvMfXxXKVn4Np4Egw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0jbHR03UyJBMmBBYnSsZmGG0OXqLJvMfXxXKVn4Np4Egw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Rafael,


On 26/01/2023 17:47, Rafael J. Wysocki wrote:
> On Wed, Jan 18, 2023 at 7:16 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> From: Daniel Lezcano <daniel.lezcano@kernel.org>
>>
>> The thermal framework gives the possibility to register the trip
>> points with the thermal zone. When that is done, no get_trip_* ops are
>> needed and they can be removed.
>>
>> Convert ops content logic into generic trip points and register them with the
>> thermal zone.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---

[ ... ]

>> @@ -173,8 +166,13 @@ static int update_trip_temp(struct intel_soc_dts_sensor_entry *dts,
>>          if (status)
>>                  goto err_restore_te_out;
>>
>> -       dts->trip_types[thres_index] = trip_type;
>> -
>> +       status = get_trip_temp(sensors, thres_index, &temp);
>> +       if (status)
>> +               goto err_restore_te_out;
>> +
>> +       dts->trips[thres_index].type = trip_type;
>> +       dts->trips[thres_index].temperature = temp;
> 
> This change doesn't look correct to me, because this function takes
> temp as an argument and it is used to populate the trip with it at
> least in some cases.
> 
> Why should temp be overwritten here?

You are correct. This is wrong.

I think we should call get_trip_temp() before calling update_trip_temp() 
instead of passing a zero temperature parameter


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

