Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4758F46683F
	for <lists+linux-pm@lfdr.de>; Thu,  2 Dec 2021 17:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbhLBQcR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Dec 2021 11:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359796AbhLBQaL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Dec 2021 11:30:11 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6BBC0613B6
        for <linux-pm@vger.kernel.org>; Thu,  2 Dec 2021 08:25:40 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id c4so60782398wrd.9
        for <linux-pm@vger.kernel.org>; Thu, 02 Dec 2021 08:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Dck2lwFSLhQLrhBOrhKJjMNBm/lp2IsFyQtzJ5VV7Lg=;
        b=QPrXpePnyOD1NPMFHEWdXN/AEWUijVa8HyzApRvK4LLPVoNv4bqaOmqpqW6VbBygmP
         8eOigf8Oatpjjil9IzEkPEewgf8biy5MvO4vumU2FuzI/lxFlULhzOhy9CxaauA/g6jB
         3DVwe0y1XcJdFp4e82vsuy/Qt2oJjhjpQOFGMBa0IJ7oiPW2dS3bkIJ5W+vvxNmOU1l9
         rsZkbyhvfCp0WexCi+PBzKJW/K6dttAqNltyFvMz7cZuaL59seO8aRWqfGHFfPUk4U9G
         UFBWUqh7ob0552UHnNtyxNLP16na3rPekSP/7/4FpiaokSvoEck3l9PR/fbC7E6FxBr4
         V1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dck2lwFSLhQLrhBOrhKJjMNBm/lp2IsFyQtzJ5VV7Lg=;
        b=Xplq8Dz4d24QdoHlZZAjRWJD0hKIJQdYN14bsFq4eV7RoZlSpaDauerGeMgFXGTp6F
         zflxIK1iV20oAO1VLSJ71xH4BFRdVI8ATSkk3vRZ2k3NVHNROohNhejWMkA4sp2IBNyE
         nrqrir794wO/lt6J9N642qwO0Y/iA6/7FxG6MsjzoCp/tftGX8Lyh7wk/fNIhKhZqgI3
         jFcFXqQycsPL/Je6iiTVv+Dm6UUOyokwtfCEt0KmIC0JyAPkTauqQwa8BF8yvXlCByZ+
         Plwx+k5nEKslrfSgTAG734YKZtrCh38AfUzAmNZihsOFj2C2pR0jmy06YjX70/6PVVfc
         Vj1A==
X-Gm-Message-State: AOAM5329TDl3vmFA8YpCofsQ06C3Iy4Tca3YO27pFib1U20eRRG42FyC
        F2AY1yE7TJD0/UQc5+1bWJMACqyxL7O9yQ==
X-Google-Smtp-Source: ABdhPJyavQrSgE40jYGWY7I5BEv4Rp6rZvt5fRUZpVzX4iYCEZGNq+XG2KGj5905HGU233jJaTGIbA==
X-Received: by 2002:adf:d18f:: with SMTP id v15mr14784411wrc.447.1638462339011;
        Thu, 02 Dec 2021 08:25:39 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:b56f:eb59:b51f:d674? ([2a01:e34:ed2f:f020:b56f:eb59:b51f:d674])
        by smtp.googlemail.com with ESMTPSA id l8sm3011069wmc.40.2021.12.02.08.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 08:25:38 -0800 (PST)
Subject: Re: [PATCH v3 1/5] dt-bindings: Powerzone new bindings
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     robh@kernel.org, arnd@linaro.org, heiko@sntech.de,
        rjw@rjwysocki.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>
References: <20211201163856.41419-1-daniel.lezcano@linaro.org>
 <CAPDyKFor=OCOYqY2K9WyOa5FrM+tCE8KR8CuBOxHdz-ch9Tzkg@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <ab3b53c0-a765-ad4b-2017-e4a42e73fe42@linaro.org>
Date:   Thu, 2 Dec 2021 17:25:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFor=OCOYqY2K9WyOa5FrM+tCE8KR8CuBOxHdz-ch9Tzkg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02/12/2021 15:42, Ulf Hansson wrote:
> On Wed, 1 Dec 2021 at 17:41, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> The proposed bindings are describing a set of powerzones.
>>
>> A power zone is the logical name for a component which is capable of
>> power capping and where we can measure the power consumption.
>>
>> A power zone can aggregate several power zones in terms of power
>> measurement and power limitations. That allows to apply power
>> constraint to a group of components and let the system balance the
>> allocated power in order to comply with the constraint.
>>
>> The ARM System Control and Management Interface (SCMI) can provide a
>> power zone description.
>>
>> The powerzone semantic is also found on the Intel platform with the
>> RAPL register.
>>
>> The Linux kernel powercap framework deals with the powerzones:
>>
>> https://www.kernel.org/doc/html/latest/power/powercap/powercap.html
>>
>> The powerzone can also represent a group of children powerzones, hence
>> the description can result on a hierarchy. Such hierarchy already
>> exists with the hardware or can be represented and computed from the
>> kernel.
>>
>> The hierarchical description was initially proposed but not desired
>> given there are other descriptions like the power domain proposing
>> almost the same description.
>>
>> https://lore.kernel.org/all/CAL_JsqLuLcHj7525tTUmh7pLqe7T2j6UcznyhV7joS8ipyb_VQ@mail.gmail.com/
>>
>> The description gives the power constraint dependencies to apply on a
>> specific group of logically or physically aggregated devices. They do
>> not represent the physical location or the power domains of the SoC
>> even if the description could be similar.
>>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> This looks good to me, feel free to add:
> 
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks Ulf for your time to review these bindings



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
