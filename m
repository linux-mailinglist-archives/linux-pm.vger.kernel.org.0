Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE6057E57D
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jul 2022 19:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbiGVRZa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jul 2022 13:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234699AbiGVRZ3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jul 2022 13:25:29 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FF7D56
        for <linux-pm@vger.kernel.org>; Fri, 22 Jul 2022 10:25:28 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h8so7414096wrw.1
        for <linux-pm@vger.kernel.org>; Fri, 22 Jul 2022 10:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=a7n2hZtI80KPmTpPLk+WQcqOlcrME3gGtY6A0hs9KEo=;
        b=V5hEqOIlZxHKDmz32ugfWunkvK8ZlLXJUZKjM/p4irElAaKfmltUCmW3rTF5A0eHA7
         DUHm9jKpIFs4ac+5rA58wAJPbxXaLUb7sBPodI6PqvIJHp7/Q4nYPCmtImtfoytEJoS1
         vDTxGZi24zyo4szSL1/J+mA6p6761y0QM/KkkTyN+OD8gg/g2hI94EcaynvDlVBWJ1nJ
         9ohLbwyBT8SyLhwQ9jE41Ty8WbjFfWcLY4rTRyz+XwIdjesyCmTUFHx1Wl7hZqiCmjQj
         6p1PFJS+F0RxHYHPoUmaEWnm9VmVtvMvqQKW+yxz65dCEffhITziGBTvtHPTFl6lE+54
         xlcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=a7n2hZtI80KPmTpPLk+WQcqOlcrME3gGtY6A0hs9KEo=;
        b=csr6p83McF1j1D0KofrPKNMt2JEcqNERzfnvwOUvXd9NRD2GyoOFJcBd33sOOmwXM7
         vl7y/jDQtY8N1CDgK+JKphUlm5yJIOEK0eLNOcdoD2Ux7qLJwh1KdwkolKFRIeuxdkur
         CcWGtwJvgCIfB+SsIxPP2M9E/x6wa1apX+++Mpm9T1BLo5+cpFtPQ0CzEA5lBpUXuVGj
         Ipn+z/jF1B4m++VCSRy7avVOGpCGjPipSrEIuJxL/SD5At7mgFwuDILCCUGW+Mlj0OLu
         n9WNa/177vW65gqmEogqMNt3zLhND650w+xleV5QYn5cne5Xj3Xgebq7DVn37E48+sdZ
         9q3g==
X-Gm-Message-State: AJIora+3vRcVLhzzKOIfjkGFhTSBqxCn0L9mQxwaCjlr6qki5IgI/ipH
        m8vCMeRAX1xA7kpArjMG2DFVSQ==
X-Google-Smtp-Source: AGRyM1uMVxRjbcOSC5DkF7Jt31dYw/fySGaz4NxzMjasgsmDE7QgZggpovXYSL40Y0/FvKS8jOngQQ==
X-Received: by 2002:a5d:5742:0:b0:21e:503b:a368 with SMTP id q2-20020a5d5742000000b0021e503ba368mr630742wrw.366.1658510726516;
        Fri, 22 Jul 2022 10:25:26 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:957f:d36d:87f9:5c17? ([2a05:6e02:1041:c10:957f:d36d:87f9:5c17])
        by smtp.googlemail.com with ESMTPSA id u24-20020a05600c211800b003a2e655f2e6sm5495374wml.21.2022.07.22.10.25.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 10:25:26 -0700 (PDT)
Message-ID: <0d962fa0-4ecb-f0d6-3b93-fbf33daab49a@linaro.org>
Date:   Fri, 22 Jul 2022 19:25:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 11/12] thermal/of: Use thermal trips stored in the
 thermal zone
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linexp.org>
Cc:     "Zhang, Rui" <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Amit Kucheria <amitk@kernel.org>
References: <20220710123512.1714714-1-daniel.lezcano@linexp.org>
 <20220710123512.1714714-13-daniel.lezcano@linexp.org>
 <CAJZ5v0hTQBXbKNurR0p8_MWmcW-EtezUg1oSNLVEYEAdzpeyBA@mail.gmail.com>
 <5e9f6d35-08ff-4949-67b0-a2feaab79814@linexp.org>
 <CAJZ5v0hA-JzYbdfoNfXhdNoeL1VLWk3umS=wxEmER=PtMUw17w@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0hA-JzYbdfoNfXhdNoeL1VLWk3umS=wxEmER=PtMUw17w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22/07/2022 18:50, Rafael J. Wysocki wrote:
> On Thu, Jul 21, 2022 at 11:29 PM Daniel Lezcano
> <daniel.lezcano@linexp.org> wrote:
>>
>> On 19/07/2022 20:26, Rafael J. Wysocki wrote:
>>> On Sun, Jul 10, 2022 at 2:35 PM Daniel Lezcano
>>> <daniel.lezcano@linexp.org> wrote:
>>>> Now that we have the thermal trip stored in the thermal zone in a
>>>> generic way, we can rely on them and remove one indirection we found
>>>> in the thermal_of code and do one more step forward the removal of the
>>>> duplicated structures.
>>>>
>>>> Cc: Alexandre Bailon <abailon@baylibre.com>
>>>> Cc: Kevin Hilman <khilman@baylibre.com>
>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
>>>> ---
>>>>    drivers/thermal/thermal_of.c | 53 +++++++++++-------------------------
>>>>    1 file changed, 16 insertions(+), 37 deletions(-)
>>>>
>>>> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
>>>> index e187461dd396..601552c55d0b 100644
>>>> --- a/drivers/thermal/thermal_of.c
>>>> +++ b/drivers/thermal/thermal_of.c
>>>> @@ -118,12 +118,7 @@ static int of_thermal_set_trips(struct thermal_zone_device *tz,
>>>>     */
>>>>    int of_thermal_get_ntrips(struct thermal_zone_device *tz)
>>>>    {
>>>> -       struct __thermal_zone *data = tz->devdata;
>>>> -
>>>> -       if (!data || IS_ERR(data))
>>>> -               return -ENODEV;
>>>> -
>>>> -       return data->ntrips;
>>>> +       return tz->ntrips;
>>> Hasn't this been renamed to num_trips?
>>
>> Right, it is changed in patch 12/12
> 
> Well, what about combining them, then?

Yes, absolutely

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
