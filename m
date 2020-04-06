Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 508551A000B
	for <lists+linux-pm@lfdr.de>; Mon,  6 Apr 2020 23:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbgDFVR2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Apr 2020 17:17:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37598 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgDFVR2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Apr 2020 17:17:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so1282471wrm.4
        for <linux-pm@vger.kernel.org>; Mon, 06 Apr 2020 14:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dd6BqHd1u7xbQgsrts2ztR8U4QU0nrn833OxpCYuajE=;
        b=gdF534ddiA7swSSZ0lK+MkQ8WFIBr/tTboA6TxrJ1xqcPgc18lNxDyq+CH7jO6Cdvy
         DlTf0wpWphvPAvwTEklSa5E+yNZrjiDVMm/crLJpWCyP8QPzCOIQimJtYMXHv76Feb5v
         tvvMaqRpNX6DfSO+Iy9K2z8YC3JMP48i4ZzzhI/a9BHbwCU7DkKqsU37Hp4vw3ENd7F2
         hpRkwZz+ulO9Zghh4AtHzQDTCK/Ks0SmIy5Cc+Du5YPwO5WOzuKH7qz7FcHkNdDJ/Sf+
         xgIjhwpXbKBztpqTmioR8ll9JUVnZ7z4E/gdyNK0qV03ge2vpxm+DX1u7kfzZ9n0NpwV
         bdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=dd6BqHd1u7xbQgsrts2ztR8U4QU0nrn833OxpCYuajE=;
        b=e6ABfAw8qnVsgMDurlndJKDdAf3tRQ/zZbppfUC7xOIj4Rw9f+ewi6xNOi5zgPvIES
         ijJRpypFU1XZ7sZu+G5XmmFz9dUrFTzVZ1fDpJHkdiSvfrzTRstOGnfU3aUSpEHm33ou
         cbEBcZ1v6os2b562vfXUNo1xaOwPvc8PKH56R4LgNgiWe909UtWYYqA5j5XwOrqXd4+9
         XSA0d0g6chLsVvxIdEbkpzc4Ouhni+x/VzabvqcKJSHUHKhaWghv9zD53HxLKDMH3EEQ
         S/FlYvLZ5RVkTgd/wY00HuYX9Dw1zA41lIOxeqy5IVikNgcIyLjJQIgN66p04xBdpxSy
         Yygg==
X-Gm-Message-State: AGi0PuazJkeOQ4l261ZoQOohOjmft5JTRy4wiciRaoNTNxLNVglSXW/3
        G+ETNdiH3Yjlf0Pikwrr3Gp0zg==
X-Google-Smtp-Source: APiQypI8eUAb2yFVFjfZBDxJtENyxrtQ3mA79hFrt6jqDkB7Rx6yGyMvlLNKGRgdGVUbMKGFF+XPWQ==
X-Received: by 2002:a5d:604a:: with SMTP id j10mr1242279wrt.126.1586207845347;
        Mon, 06 Apr 2020 14:17:25 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:b51c:42dc:1499:2880? ([2a01:e34:ed2f:f020:b51c:42dc:1499:2880])
        by smtp.googlemail.com with ESMTPSA id d6sm28140465wrw.10.2020.04.06.14.17.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 14:17:24 -0700 (PDT)
Subject: Re: [PATCH v5 1/5] PM / EM: add devices to Energy Model
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-imx@nxp.com
Cc:     Morten.Rasmussen@arm.com, Dietmar.Eggemann@arm.com,
        javi.merino@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, rjw@rjwysocki.net, sudeep.holla@arm.com,
        viresh.kumar@linaro.org, nm@ti.com, sboyd@kernel.org,
        rui.zhang@intel.com, amit.kucheria@verdurent.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        qperret@google.com, bsegall@google.com, mgorman@suse.de,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        kernel@pengutronix.de, khilman@kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, robh@kernel.org,
        matthias.bgg@gmail.com, steven.price@arm.com,
        tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com,
        airlied@linux.ie, daniel@ffwll.ch, liviu.dudau@arm.com,
        lorenzo.pieralisi@arm.com, patrick.bellasi@matbug.net,
        orjan.eide@arm.com, rdunlap@infradead.org, mka@chromium.org
References: <20200318114548.19916-1-lukasz.luba@arm.com>
 <20200318114548.19916-2-lukasz.luba@arm.com>
 <09b680a5-a118-8c6e-0ae1-03ab5f10c573@linaro.org>
 <cb7f670a-a04f-ba6f-1486-0421f3cce2e9@arm.com>
 <6b980e2a-c15c-0718-14b8-e8aa7510c832@linaro.org>
 <2a70b4ed-f18f-c1e6-1e8c-e4747807f276@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 xsFNBFv/yykBEADDdW8RZu7iZILSf3zxq5y8YdaeyZjI/MaqgnvG/c3WjFaunoTMspeusiFE
 sXvtg3ehTOoyD0oFjKkHaia1Zpa1m/gnNdT/WvTveLfGA1gH+yGes2Sr53Ht8hWYZFYMZc8V
 2pbSKh8wepq4g8r5YI1XUy9YbcTdj5mVrTklyGWA49NOeJz2QbfytMT3DJmk40LqwK6CCSU0
 9Ed8n0a+vevmQoRZJEd3Y1qXn2XHys0F6OHCC+VLENqNNZXdZE9E+b3FFW0lk49oLTzLRNIq
 0wHeR1H54RffhLQAor2+4kSSu8mW5qB0n5Eb/zXJZZ/bRiXmT8kNg85UdYhvf03ZAsp3qxcr
 xMfMsC7m3+ADOtW90rNNLZnRvjhsYNrGIKH8Ub0UKXFXibHbafSuq7RqyRQzt01Ud8CAtq+w
 P9EftUysLtovGpLSpGDO5zQ++4ZGVygdYFr318aGDqCljKAKZ9hYgRimPBToDedho1S1uE6F
 6YiBFnI3ry9+/KUnEP6L8Sfezwy7fp2JUNkUr41QF76nz43tl7oersrLxHzj2dYfWUAZWXva
 wW4IKF5sOPFMMgxoOJovSWqwh1b7hqI+nDlD3mmVMd20VyE9W7AgTIsvDxWUnMPvww5iExlY
 eIC0Wj9K4UqSYBOHcUPrVOKTcsBVPQA6SAMJlt82/v5l4J0pSQARAQABzSpEYW5pZWwgTGV6
 Y2FubyA8ZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZz7Cwa4EEwEIAEECGwEFCwkIBwIGFQoJ
 CAsCBBYCAwECHgECF4ACGQEWIQQk1ibyU76eh+bOW/SP9LjScWdVJwUCXAkeagUJDRnjhwAh
 CRCP9LjScWdVJxYhBCTWJvJTvp6H5s5b9I/0uNJxZ1Un69gQAJK0ODuKzYl0TvHPU8W7uOeu
 U7OghN/DTkG6uAkyqW+iIVi320R5QyXN1Tb6vRx6+yZ6mpJRW5S9fO03wcD8Sna9xyZacJfO
 UTnpfUArs9FF1pB3VIr95WwlVoptBOuKLTCNuzoBTW6jQt0sg0uPDAi2dDzf+21t/UuF7I3z
 KSeVyHuOfofonYD85FkQJN8lsbh5xWvsASbgD8bmfI87gEbt0wq2ND5yuX+lJK7FX4lMO6gR
 ZQ75g4KWDprOO/w6ebRxDjrH0lG1qHBiZd0hcPo2wkeYwb1sqZUjQjujlDhcvnZfpDGR4yLz
 5WG+pdciQhl6LNl7lctNhS8Uct17HNdfN7QvAumYw5sUuJ+POIlCws/aVbA5+DpmIfzPx5Ak
 UHxthNIyqZ9O6UHrVg7SaF3rvqrXtjtnu7eZ3cIsfuuHrXBTWDsVwub2nm1ddZZoC530BraS
 d7Y7eyKs7T4mGwpsi3Pd33Je5aC/rDeF44gXRv3UnKtjq2PPjaG/KPG0fLBGvhx0ARBrZLsd
 5CTDjwFA4bo+pD13cVhTfim3dYUnX1UDmqoCISOpzg3S4+QLv1bfbIsZ3KDQQR7y/RSGzcLE
 z164aDfuSvl+6Myb5qQy1HUQ0hOj5Qh+CzF3CMEPmU1v9Qah1ThC8+KkH/HHjPPulLn7aMaK
 Z8t6h7uaAYnGzjMEXZLIEhYJKwYBBAHaRw8BAQdAGdRDglTydmxI03SYiVg95SoLOKT5zZW1
 7Kpt/5zcvt3CwhsEGAEIACAWIQQk1ibyU76eh+bOW/SP9LjScWdVJwUCXZLIEgIbAgCvCRCP
 9LjScWdVJ40gBBkWCAAdFiEEbinX+DPdhovb6oob3uarTi9/eqYFAl2SyBIAIQkQ3uarTi9/
 eqYWIQRuKdf4M92Gi9vqihve5qtOL396pnZGAP0c3VRaj3RBEOUGKxHzcu17ZUnIoJLjpHdk
 NfBnWU9+UgD/bwTxE56Wd8kQZ2e2UTy4BM8907FsJgAQLL4tD2YZggwWIQQk1ibyU76eh+bO
 W/SP9LjScWdVJ5CaD/0YQyfUzjpR1GnCSkbaLYTEUsyaHuWPI/uSpKTtcbttpYv+QmYsIwD9
 8CeH3zwY0Xl/1fE9Hy59z6Vxv9YVapLx0nPDOA1zDVNq2MnutxHb8t+Imjz4ERCxysqtfYrv
 gao3E/h0c8SEeh+bh5MkjwmU8CwZ3doWyiVdULKESe7/Gs5OuhFzaDVPCpWdsKdCAGyUuP/+
 qRWwKGVpWP0Rrt6MTK24Ibeu3xEZO8c3XOEXH5d9nf6YRqBEIizAecoCr00E9c+6BlRS0AqR
 OQC3/Mm7rWtco3+WOridqVXkko9AcZ8AiM5nu0F8AqYGKg0y7vkL2LOP8us85L0p57MqIR1u
 gDnITlTY0x4RYRWJ9+k7led5WsnWlyv84KNzbDqQExTm8itzeZYW9RvbTS63r/+FlcTa9Cz1
 5fW3Qm0BsyECvpAD3IPLvX9jDIR0IkF/BQI4T98LQAkYX1M/UWkMpMYsL8tLObiNOWUl4ahb
 PYi5Yd8zVNYuidXHcwPAUXqGt3Cs+FIhihH30/Oe4jL0/2ZoEnWGOexIFVFpue0jdqJNiIvA
 F5Wpx+UiT5G8CWYYge5DtHI3m5qAP9UgPuck3N8xCihbsXKX4l8bdHfziaJuowief7igeQs/
 WyY9FnZb0tl29dSa7PdDKFWu+B+ZnuIzsO5vWMoN6hMThTl1DxS+jc7ATQRb/8z6AQgAvSkg
 5w7dVCSbpP6nXc+i8OBz59aq8kuL3YpxT9RXE/y45IFUVuSc2kuUj683rEEgyD7XCf4QKzOw
 +XgnJcKFQiACpYAowhF/XNkMPQFspPNM1ChnIL5KWJdTp0DhW+WBeCnyCQ2pzeCzQlS/qfs3
 dMLzzm9qCDrrDh/aEegMMZFO+reIgPZnInAcbHj3xUhz8p2dkExRMTnLry8XXkiMu9WpchHy
 XXWYxXbMnHkSRuT00lUfZAkYpMP7La2UudC/Uw9WqGuAQzTqhvE1kSQe0e11Uc+PqceLRHA2
 bq/wz0cGriUrcCrnkzRmzYLoGXQHqRuZazMZn2/pSIMZdDxLbwARAQABwsGNBBgBCAAgFiEE
 JNYm8lO+nofmzlv0j/S40nFnVScFAlv/zPoCGwwAIQkQj/S40nFnVScWIQQk1ibyU76eh+bO
 W/SP9LjScWdVJ/g6EACFYk+OBS7pV9KZXncBQYjKqk7Kc+9JoygYnOE2wN41QN9Xl0Rk3wri
 qO7PYJM28YjK3gMT8glu1qy+Ll1bjBYWXzlsXrF4szSqkJpm1cCxTmDOne5Pu6376dM9hb4K
 l9giUinI4jNUCbDutlt+Cwh3YuPuDXBAKO8YfDX2arzn/CISJlk0d4lDca4Cv+4yiJpEGd/r
 BVx2lRMUxeWQTz+1gc9ZtbRgpwoXAne4iw3FlR7pyg3NicvR30YrZ+QOiop8psWM2Fb1PKB9
 4vZCGT3j2MwZC50VLfOXC833DBVoLSIoL8PfTcOJOcHRYU9PwKW0wBlJtDVYRZ/CrGFjbp2L
 eT2mP5fcF86YMv0YGWdFNKDCOqOrOkZVmxai65N9d31k8/O9h1QGuVMqCiOTULy/h+FKpv5q
 t35tlzA2nxPOX8Qj3KDDqVgQBMYJRghZyj5+N6EKAbUVa9Zq8xT6Ms2zz/y7CPW74G1GlYWP
 i6D9VoMMi6ICko/CXUZ77OgLtMsy3JtzTRbn/wRySOY2AsMgg0Sw6yJ0wfrVk6XAMoLGjaVt
 X4iPTvwocEhjvrO4eXCicRBocsIB2qZaIj3mlhk2u4AkSpkKm9cN0KWYFUxlENF4/NKWMK+g
 fGfsCsS3cXXiZpufZFGr+GoHwiELqfLEAQ9AhlrHGCKcgVgTOI6NHg==
Message-ID: <4cee98ce-62a6-7448-a99c-3a1af6c87cf4@linaro.org>
Date:   Mon, 6 Apr 2020 23:17:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <2a70b4ed-f18f-c1e6-1e8c-e4747807f276@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06/04/2020 18:07, Lukasz Luba wrote:
> 
> 
> On 4/6/20 3:58 PM, Daniel Lezcano wrote:
>>
>> Hi Lukasz,
>>
>>
>> On 06/04/2020 15:29, Lukasz Luba wrote:
>>> Hi Daniel,
>>>
>>> Thank you for the review.
>>>
>>> On 4/3/20 5:05 PM, Daniel Lezcano wrote:
>>>>
>>>> Hi Lukasz,
>>>>
>>>>
>>>> On 18/03/2020 12:45, Lukasz Luba wrote:
>>>>> Add support of other devices into the Energy Model framework not only
>>>>> the
>>>>> CPUs. Change the interface to be more unified which can handle other
>>>>> devices as well.
>>>>
>>>> thanks for taking care of that. Overall I like the changes in this
>>>> patch
>>>> but it hard to review in details because the patch is too big :/
>>>>
>>>> Could you split this patch into smaller ones?
>>>>
>>>> eg. (at your convenience)
>>>>
>>>>    - One patch renaming s/cap/perf/
>>>>
>>>>    - One patch adding a new function:
>>>>
>>>>       em_dev_register_perf_domain(struct device *dev,
>>>>                  unsigned int nr_states,
>>>>                  struct em_data_callback *cb);
>>>>
>>>>      (+ EXPORT_SYMBOL_GPL)
>>>>
>>>>       And em_register_perf_domain() using it.
>>>>
>>>>    - One converting the em_register_perf_domain() user to
>>>>      em_dev_register_perf_domain
>>>>
>>>>    - One adding the different new 'em' functions
>>>>
>>>>    - And finally one removing em_register_perf_domain().
>>>
>>> I agree and will do the split. I could also break the dependencies
>>> for future easier merge.
>>>
>>>>
>>>>
>>>>> Acked-by: Quentin Perret <qperret@google.com>
>>>>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>>>>> ---
>>>>
>>>> [ ... ]
>>>>
>>>>>    2. Core APIs
>>>>> @@ -70,14 +72,16 @@ CONFIG_ENERGY_MODEL must be enabled to use the EM
>>>>> framework.
>>>>>    Drivers are expected to register performance domains into the EM
>>>>> framework by
>>>>>    calling the following API::
>>>>>    -  int em_register_perf_domain(cpumask_t *span, unsigned int
>>>>> nr_states,
>>>>> -                  struct em_data_callback *cb);
>>>>> +  int em_register_perf_domain(struct device *dev, unsigned int
>>>>> nr_states,
>>>>> +        struct em_data_callback *cb, cpumask_t *cpus);
>>>>
>>>> Isn't possible to get rid of this cpumask by using
>>>> cpufreq_cpu_get() which returns the cpufreq's policy and from their get
>>>> the related cpus ?
>>>
>>> We had similar thoughts with Quentin and I've checked this.
>>
>> Yeah, I suspected you already think about that :)
>>
>>> Unfortunately, if the policy is a 'new policy' [1] it gets
>>> allocated and passed into cpufreq driver ->init(policy) [2].
>>> Then that policy is set into per_cpu pointer for each related_cpu [3]:
>>>
>>> for_each_cpu(j, policy->related_cpus)
>>>      per_cpu(cpufreq_cpu_data, j) = policy;
>>>
>>>   Thus, any calls of functions (i.e. cpufreq_cpu_get()) which try to
>>> take this ptr before [3] won't work.
>>>
>>> We are trying to register EM from cpufreq_driver->init(policy) and the
>>> per_cpu policy is likely to be not populated at that phase.
>>
>> What is the problem of registering at the end of the cpufreq_online ?
> 
> We want to enable driver developers to choose one of two options for the
> registration of Energy Model:
> 1. a simple one via dev_pm_opp_of_register_em(), which uses default
>    callback function calculating power based on: voltage, freq
>    and DT entry 'dynamic-power-coefficient' for each OPP
> 2. a more sophisticated, when driver provides callback function, which
>   will be called from EM for each OPP to ask for related power;
>   This interface could also be used by devices which relay not only
>   on one source of 'voltage', i.e. manipulate body bias or have
>   other controlling voltage for gates in the new 3D transistors. They
>   might provide custom callback function in their cpufreq driver.
>   This is used i.e. in cpufreq drivers which use firmware to get power,
>   like scmi-cpufreq.c;
> 
> To meet this requirement the registration of EM is moved into cpufreq
> drivers, not in the framework i.e cpufreq_online(). If we could limit
> the support for only option 1. then we could move the registration
> call into cpufreq framework and clean the cpufreq drivers.

I'm not sure to get your point but I think a series setting the scene by
moving the dev_pm_opp_of_register_em() to cpufreq_online() and remove
the cpumask may make sense.

Can you send the split version of patch 1/5 as a series without the
other changes ? So we can focus on first ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
