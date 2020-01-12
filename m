Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE8C31387ED
	for <lists+linux-pm@lfdr.de>; Sun, 12 Jan 2020 20:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733180AbgALTbn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Jan 2020 14:31:43 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43515 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733107AbgALTbn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Jan 2020 14:31:43 -0500
Received: by mail-wr1-f67.google.com with SMTP id d16so6504003wre.10
        for <linux-pm@vger.kernel.org>; Sun, 12 Jan 2020 11:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GqMHULzJdxKle3bDEyMcjsTBusdrbyyrQdBFfLUOVxs=;
        b=cvVLRUoGdp5sFBb2jkkzpnjoN50S5tNkoDw/hmE8RyO125b1tWdtHabbQzBDxNA+Hw
         Npkz/uE+urzuyBhiP7lff4/YuPUDMwsxaYkr517+rN7pV+XHdusnhfUkMjyOCLlh2BVG
         Ed47KCxTW0poLuDDGsMGi6uObcJzVEh91hnbCnexk05Vy91vhI/wql8zrgh2c9BvxK07
         KK0vtKryRB8q5CZWeIMfduOTzJbYCSudu/8sj/Bi+mClVnNOjR87F7vItUFtwz5EraX6
         pHfqIBOSzJ80GCGDRy19CeuCgfnkdTnNKIBfMDHG19LeRcSwiwxnyHjwVtjX4jW0Rdn1
         4TTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=GqMHULzJdxKle3bDEyMcjsTBusdrbyyrQdBFfLUOVxs=;
        b=kfjaYQNI8xOIceSopM4T/UfMgzlgiJYIUCi+stZuxjb45pD/r5oh9E6Bc6q7nSz7tn
         O4/dBkxYb6YEKtiXSp2TUv7dH66doFzDX4hwIFOI2nE0ph7edebdYE+PTMDowFFRr21f
         hrIhYQEv4kGkdJl6eEblOwcJ9qM0kztJAhxpd0Q0cYXIi/01niWDIk1bnGCwyMq0G6SH
         l3EihC/BhNHowYmhpp5ufUCLs6KMdTs8OIm5kmsW99w683AAxWSkYqs1YGwihXb9PmoG
         D0W543bUSDfFaoLkd9ZPSglaAq7coT4l4co0YIK4JAKwDxN6XLFfdLhvaF2Oojs0eKkk
         5sdw==
X-Gm-Message-State: APjAAAWezdCKwm+6F0rjiUtERLE+tYIFl58HM2K6Ht+4F6d/k/Ze20Yi
        tFIatbdzflQXUgEZvaufvWyIKA==
X-Google-Smtp-Source: APXvYqyCfQeYTZBrLXI4Yc2tydrcjNsBxeMIsrBB8ft3sogDwKWWOcu9tTBe2e+U7gx5/0TkUaGHRA==
X-Received: by 2002:adf:ea51:: with SMTP id j17mr14662236wrn.83.1578857500473;
        Sun, 12 Jan 2020 11:31:40 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:5d47:bb17:fc0:dfcb? ([2a01:e34:ed2f:f020:5d47:bb17:fc0:dfcb])
        by smtp.googlemail.com with ESMTPSA id t131sm11588306wmb.13.2020.01.12.11.31.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jan 2020 11:31:39 -0800 (PST)
Subject: Re: [PATCH] thermal: sun8i: Add hwmon support
To:     Frank Lee <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@csie.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Maxime Ripard <mripard@kernel.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20191228171904.24618-1-tiny.windzz@gmail.com>
 <CAGb2v67YPLy_qFuLKKMFytPEdFRUazoNfsQ1tYj8z3WVSRqC3Q@mail.gmail.com>
 <CAEExFWtkPBhqT-wteE0_bC=QqaTyuvAcj_4SMOLjYAdc6p4tkg@mail.gmail.com>
 <CAGb2v673PM_3QazNWBKYd=4pumyyyE3XFmwa4LY7qFt2=QwEVQ@mail.gmail.com>
 <CAEExFWtaeiX0bq6VO5294w8vCtnnNDDB0HA_nvR19adg=KFANQ@mail.gmail.com>
 <CAEExFWsGZD=Hm3OWmTLmKu82VDfG31y3ENJz7CfRHENqT8jJUw@mail.gmail.com>
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
Message-ID: <cae12779-ec49-db47-0b36-7f2b41c3c774@linaro.org>
Date:   Sun, 12 Jan 2020 20:31:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAEExFWsGZD=Hm3OWmTLmKu82VDfG31y3ENJz7CfRHENqT8jJUw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/01/2020 19:12, Frank Lee wrote:
> HI Daniel:
> 
> On Sun, Jan 12, 2020 at 2:08 AM Frank Lee <tiny.windzz@gmail.com> wrote:
>>
>> On Tue, Jan 7, 2020 at 11:15 AM Chen-Yu Tsai <wens@csie.org> wrote:
>>>
>>> On Tue, Jan 7, 2020 at 12:14 AM Frank Lee <tiny.windzz@gmail.com> wrote:
>>>>
>>>> HI Chen-Yu.
>>>>
>>>> On Mon, Jan 6, 2020 at 12:32 PM Chen-Yu Tsai <wens@csie.org> wrote:
>>>>>
>>>>> On Sun, Dec 29, 2019 at 1:19 AM Yangtao Li <tiny.windzz@gmail.com> wrote:
>>>>>>
>>>>>> Expose sun8i thermal as a HWMON device.
>>>>>>
>>>>>> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
>>>>>> ---
>>>>>>  drivers/thermal/sun8i_thermal.c | 6 ++++++
>>>>>>  1 file changed, 6 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
>>>>>> index 23a5f4aa4be4..619e75cb41b0 100644
>>>>>> --- a/drivers/thermal/sun8i_thermal.c
>>>>>> +++ b/drivers/thermal/sun8i_thermal.c
>>>>>> @@ -20,6 +20,8 @@
>>>>>>  #include <linux/slab.h>
>>>>>>  #include <linux/thermal.h>
>>>>>>
>>>>>> +#include "thermal_hwmon.h"
>>>>>> +
>>>>>>  #define MAX_SENSOR_NUM 4
>>>>>>
>>>>>>  #define FT_TEMP_MASK                           GENMASK(11, 0)
>>>>>> @@ -477,6 +479,10 @@ static int sun8i_ths_register(struct ths_device *tmdev)
>>>>>>                                                              &ths_ops);
>>>>>>                 if (IS_ERR(tmdev->sensor[i].tzd))
>>>>>>                         return PTR_ERR(tmdev->sensor[i].tzd);
>>>>>> +
>>>>>> +               if (devm_thermal_add_hwmon_sysfs(tmdev->sensor[i].tzd))
>>>>>> +                       dev_warn(tmdev->dev,
>>>>>> +                                "Failed to add hwmon sysfs attributes\n");
>>>>>
>>>>> Maybe you want a hard failure instead?
>>>>
>>>> I don't quite understand what you mean.
>>>> What do you think should be done?
>>>
>>> Return an error instead of just printing a warning.
>>
>> Sometimes, even if hwmon fails to add, it can still work as a thermal driver.
>> At this time, I don't really want to interrupt the registration of the
>> thermal driver.
>>
>> Anyone else's opinion here?
>>
> 
> What's your point? Can you choose this patch?

Applied, thanks


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

