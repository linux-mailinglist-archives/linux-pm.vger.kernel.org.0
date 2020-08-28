Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8945255683
	for <lists+linux-pm@lfdr.de>; Fri, 28 Aug 2020 10:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgH1Iab (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Aug 2020 04:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728269AbgH1Ia3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Aug 2020 04:30:29 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BB5C061264;
        Fri, 28 Aug 2020 01:30:28 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id j15so276766lfg.7;
        Fri, 28 Aug 2020 01:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LflMgJmibSpFeOHc4WL2YJ+POCyG0pEvbGVH5SBOv0E=;
        b=sdCwCAI9GltezF0rEB2fLfVxKx/8qRdfoKbbiRoFKxvVCYIkR3/N1t+zeTEEbig46m
         +Kyj/BDTYw6OGVtSPlqNjGOO+fv9AYhJPWBogZ4zZlmC2yxHp+dH2Ko7FVvt1wfQtAEJ
         C3EGMetrjmTC/sV3gobl9IyF5UkoeKSYqq3m2hVHVbaEPYOGuzFFd5jgWMxslMdgQGer
         9+UFDbyhkm+yhdM7yCy9ywuHycOSmJv+CRYhHhUfXf/FoN7mgRZ9eqL8dvW5VmgrW/Oe
         mvL9YOYm9HUrthueMnVNdX9U8x9oc0gEqLz7mTAFACitArMxyd1dGhLSQEfC89ew0Qql
         tX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LflMgJmibSpFeOHc4WL2YJ+POCyG0pEvbGVH5SBOv0E=;
        b=gCsHhKqohe0/MSCkH+0iFeWo2ANHY2pdneE5uK8GqO9Tbsr3R8wef5psDc4g5nwfjw
         iWBRHA0dxxQ1wJjYX+iQ6MTPpz767pDdzSQJ5D6FA3wteboI8Y6GCoPQ8BRuLBmG0q1J
         XEZABPxA14rT9Hx9lYY4EmV8HTtIyRd586HXQ+xv9FvGe46S7m6e8SPPXUsmAnJBKIXt
         9bXGSt5Xxqu1oevArpUghSGEPU6lL1a5iq3sepx3G4bnsDEjzD6klEcpDjkPziULV1MC
         /743Z72sx6etFDifID3tr4yBCdhkfFn2zTLxMLhjBbRDXYv0sOr84aD9nWSMXx0VyCku
         Wyzw==
X-Gm-Message-State: AOAM532+vJoP3yOfEk5DfzLdFC45gD4DMO8c6Xhh2QkH5Az26l5Qfts9
        P/cM65bHlEosFoK17lVAsoKjO+Z91co=
X-Google-Smtp-Source: ABdhPJzLnvqVFe/sNW/j+lmpEBM4x5/CZ5x6tV+zcsDznlhemeqh60v+eDDBRVDdroYZaI53iNUCkA==
X-Received: by 2002:a19:24c2:: with SMTP id k185mr276673lfk.120.1598603426636;
        Fri, 28 Aug 2020 01:30:26 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id h6sm130676lfc.84.2020.08.28.01.30.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2020 01:30:25 -0700 (PDT)
Subject: Re: [PATCH v5 13/36] PM / devfreq: tegra30: Use MC timings for
 building OPP table
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
References: <20200814000621.8415-1-digetx@gmail.com>
 <CGME20200814000944epcas1p3dfd0104c5fa640695dfcd4949f6b1818@epcas1p3.samsung.com>
 <20200814000621.8415-14-digetx@gmail.com>
 <1b0d75fe-79af-70eb-8450-999a3bc72bac@samsung.com>
 <1de8aa41-8001-cf46-026c-b00f8df0b9a3@gmail.com>
 <2a255211-5426-d78f-d266-cdb958f4c658@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a11d60af-3a67-6a76-57ae-7cb9bad13bed@gmail.com>
Date:   Fri, 28 Aug 2020 11:30:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2a255211-5426-d78f-d266-cdb958f4c658@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

28.08.2020 04:47, Chanwoo Choi пишет:
> Hi,
...
>> Hence the NULL-checking is unnecessary.
>>
>> When I first encountered the of_device_get_match_data(), I was also
>> thinking that adding the NULL-checks is a good idea, but later on
>> somebody pointed out to me (maybe Thierry) that it's unnecessary to do.
> 
> OK. Thanks.
> 
>>
>>>> +
>>>> +	mc = tegra_get_memory_controller(soc_data->mc_compatible);
>>>> +	if (IS_ERR(mc))
>>>> +		return PTR_ERR(mc);
>>>
>>> You better to add error log.
>>
>> In practice we should get only -EPROBE_DEFER here ever. I'll consider
>> adding the message in the next revision, at least just for consistency.
> 
> In order to handle -EPROBE_DEFER, recommend the using of dev_err_probe().

Hello, Chanwoo!

Thank you for the suggestion! I wasn't aware about the dev_err_probe()
until recently and will use this new helper in the v6!

Thanks!
