Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC942A1A54
	for <lists+linux-pm@lfdr.de>; Sat, 31 Oct 2020 20:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgJaTxV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 31 Oct 2020 15:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbgJaTxV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 31 Oct 2020 15:53:21 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C58C0617A6;
        Sat, 31 Oct 2020 12:53:19 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 126so12221941lfi.8;
        Sat, 31 Oct 2020 12:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qpW1o+C0PRJ741Jc61rIE1EzSh2oPyJa/Lhh/MjTIEo=;
        b=kCemvOV/aVgs6jzTk5xs0VLzBdyFrvm75owovIK/xkL6tbC05uav9344WusR7z8ETN
         suCnr8DigbChM6vHGGn+ppIjhVtviHN4bAvhea/cXJkagsVr2CxVaF7odhorhnb4Q36B
         BQjYm6NjAl0I3ZEkyhkpo4MYmDrHFMDYkvYCWd9sER/94ftd4VgEuRS46AYN3HdHFO+S
         tqwd1bRl/QJaUMrXp2RZMaBXFtO58oWvlSmrkAm4mVfuuIrzLF3LU9oY2B2u3YHr/FhD
         oWbALHqgegg27LIAs7xx8Zb1oYanYNM0St1C8i32EAUAtm0fDKovMHgoNLH2CZESUMyu
         k7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qpW1o+C0PRJ741Jc61rIE1EzSh2oPyJa/Lhh/MjTIEo=;
        b=OBpTo1F4fiutnakq4kV8BTm6ap60B/4IlIyhg6pYlqj1M8npMXOcIc78l4YuO1GL3I
         V3KXtMaptWsOnm8aGQ++cOGIqcu5gKveJZrw7fm5KGX659dK+IHMwVx9vd7nYZTY5CqW
         6jST3T7jkihzHJ8hKBlnT/36zngsrPF1JTO46rhTKpLcFQaE5PLsCvG0ZB7GTyUyJpUc
         AINP4STM8GsTx+4wqilPaWl1Lx/hCUEDOOfydgJnCCTQPR5InfPyeRPaDIJcLowPO+TE
         8RcfUFpiwSYHAnm1b3010wPcEUM2FQo4x5v9E60/PJnklt25EhFOBArSMAtdCTH+GWrS
         ae0w==
X-Gm-Message-State: AOAM530ZA0WyOqiwW4FJ10KM1p6eL0GRyYb0QwmqM9JUCvfvsSAKxe4B
        L9A4584lwalozM/zfE7wMaJW2WiiQ0c=
X-Google-Smtp-Source: ABdhPJx51n5KkA8mPRxesb87WniYbQs0YGofYfpwH6xFE7VSriWHy/j/UxCjN08agE3mbG5oAIkFaw==
X-Received: by 2002:a19:7009:: with SMTP id h9mr3365454lfc.201.1604173997919;
        Sat, 31 Oct 2020 12:53:17 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-177.dynamic.spd-mgts.ru. [109.252.193.177])
        by smtp.googlemail.com with ESMTPSA id d16sm926813lfm.55.2020.10.31.12.53.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2020 12:53:17 -0700 (PDT)
Subject: Re: [PATCH v6 08/52] dt-bindings: memory: tegra20: emc: Document
 mfd-simple compatible and statistics sub-device
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-9-digetx@gmail.com> <20201027090212.GG4244@kozik-lap>
 <1cce314a-1eab-61c9-099d-54f987b03761@gmail.com>
 <20201027194457.GD140636@kozik-lap>
 <ae06bd70-93f5-abe8-64d9-e5e991cd8ff8@gmail.com>
 <20201028152632.GA4051913@bogus>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a2e7109c-1a31-2b5d-fd1b-b572c654ba82@gmail.com>
Date:   Sat, 31 Oct 2020 22:53:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201028152632.GA4051913@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

28.10.2020 18:26, Rob Herring пишет:
> On Tue, Oct 27, 2020 at 11:18:34PM +0300, Dmitry Osipenko wrote:
>> 27.10.2020 22:44, Krzysztof Kozlowski пишет:
>>> On Tue, Oct 27, 2020 at 10:22:19PM +0300, Dmitry Osipenko wrote:
>>>> 27.10.2020 12:02, Krzysztof Kozlowski пишет:
>>>>>> @@ -31,17 +32,34 @@ Example:
>>>>>>  		...
>>>>>>  	};
>>>>>>  
>>>>>> +	emc_bw_dfs_opp_table: emc_opp_table1 {
>>>>> Hyphens for node name.
>>>>
>>>> We already use underscores for the Tegra CPU OPP table.
>>>>
>>>> https://elixir.bootlin.com/linux/v5.10-rc1/source/arch/arm/boot/dts/tegra20-cpu-opp.dtsi#L4
>>>>
>>>> What makes you think that hyphens will be a better choice? Is it a
>>>> documented naming convention?
>>>
>>> Unfortunately that's the source of confusion also for me because
>>> Devicetree spec mentions both of them (and does not specify preferences).
>>>
>>> The choice of dashes/hyphens comes now explicitly from all dtschema
>>> files.  Previously, the documentation were emails from Rob. :)
>>
>> Okay, I'll change it in v7. So far I haven't seen warnings about it from
>> the schema-checker.
> 
> dtc with W=2 will warn.
> 
> The bigger issue is the name should be generic.

Indeed, thanks. I'll correct the name.
