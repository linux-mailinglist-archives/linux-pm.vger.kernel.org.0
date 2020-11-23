Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C052C054A
	for <lists+linux-pm@lfdr.de>; Mon, 23 Nov 2020 13:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbgKWMOI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Nov 2020 07:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbgKWMOI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Nov 2020 07:14:08 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C88FC0613CF;
        Mon, 23 Nov 2020 04:14:08 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id p12so17684453ljc.9;
        Mon, 23 Nov 2020 04:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XsZCv5023Mu/1oSh+AEapg1m34NXeyOJ1unD1eIBZQw=;
        b=aB1KYaV7QqWCZox3C1Jd1sqfwbSLXAQ3jPNeKgOhMUvcnvNB+7Eikk716UJZZdPigW
         qnMeYDdM9c69XWEjLShh/Zve5JmHKWUaj5ItrO7NfeBpUVAEWQXflrAGCFTu8LO7ab22
         RSB5f4WCpXTvazXHF4RBQKjRPiJu0EUP1gkgxeEhUWNhg5RBZb/aXAxnqD/JzL2wlTfM
         alizEIHllaRJbhLpzXPaIJ/t39ndcERuS8RRSt+5Z8Ayd088t7ICseCenMYJzmaIGcHN
         JQdsd2RXj/bbn/JMKwi0+GCi8X4j+3Xfet8lNvmwvwLixlz4aWxFEXr+moKrY9mOaJTg
         JT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XsZCv5023Mu/1oSh+AEapg1m34NXeyOJ1unD1eIBZQw=;
        b=C3F/Gq0pCZEUoEzaqLgCC/SqRy2e6QuUfMNmkAv1e27kup266IB6pCcqgobYV977xc
         hgA2Q1MIgZtuVZymCsff2JVV0++9GtRnSvknOE9Q9Rsl6ildA9zdgJ3fMfzwXHheV/oh
         xks0EFIilvJED8g5nnkOSwdA43gc7pVhyczI2fZxbDBYqcMwLdhwRcTo2+3ZpgwjQZ0+
         ts/ViGBYh7gzToXHiLATe9xwiMqwsx8Sbz+Yay4OiXn7Fdd4ZLXKY24OwPrWFZ3Gwmyi
         bjvkUKLiJf+cGycQczsAbGdyjulK60GYNpIYPsmaJ3fOd3ZXHX4KLzLYTaL+/ISFCmf+
         O21Q==
X-Gm-Message-State: AOAM532flJeyDgdP0Q+9jz4CQ661kmVQSM5HRC+zNt09KZDNRjdmxBcz
        SZrbUxLfdf7wfnup0I0SCBA=
X-Google-Smtp-Source: ABdhPJx4k5t4//jZKRi/ta0kUpQyFAiLJpsAYAJoaM9b+pEwu73ZR0cHXPiCx8Ola24KDGwrKRvL8w==
X-Received: by 2002:a05:651c:299:: with SMTP id b25mr13588973ljo.16.1606133646185;
        Mon, 23 Nov 2020 04:14:06 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.googlemail.com with ESMTPSA id o3sm1368332lfo.217.2020.11.23.04.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2020 04:14:05 -0800 (PST)
Subject: Re: [PATCH v10 03/19] memory: tegra30: Support interconnect framework
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
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
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20201123002723.28463-1-digetx@gmail.com>
 <20201123002723.28463-4-digetx@gmail.com>
 <109bc617-f7d9-8635-3db1-3f4869b32f4d@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <cd22b4ce-b2c1-9893-5007-5dd7dc49404f@gmail.com>
Date:   Mon, 23 Nov 2020 15:14:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <109bc617-f7d9-8635-3db1-3f4869b32f4d@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

23.11.2020 09:32, Georgi Djakov пишет:
> Hi Dmitry,
> 
> On 23.11.20 2:27, Dmitry Osipenko wrote:
>> Now Internal and External memory controllers are memory interconnection
>> providers. This allows us to use interconnect API for tuning of memory
>> configuration. EMC driver now supports OPPs and DVFS. MC driver now
>> supports tuning of memory arbitration latency, which needs to be done
>> for ISO memory clients, like a Display client for example.
>>
>> Tested-by: Peter Geis <pgwipeout@gmail.com>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> 
> Acked-by: Georgi Djakov <georgi.djakov@linaro.org>
> 
> Thank you for the continuous work on this patchset!

Hello Georgi,

Thank you for reviewing the patches!
