Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42D931923AD
	for <lists+linux-pm@lfdr.de>; Wed, 25 Mar 2020 10:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgCYJIZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Mar 2020 05:08:25 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38661 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgCYJIZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Mar 2020 05:08:25 -0400
Received: by mail-wm1-f67.google.com with SMTP id l20so1568818wmi.3
        for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2020 02:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MQmDKc2OOuhg0S7JTZ9RlpmduADvX5XBc9//ZGFgkjM=;
        b=TIgoNJ9FGuPxG/N0Uy41SZEGQwAeUDBR8OmesazOg1w6n/YAjYCaPjR11150qJ/l2C
         7zsIkppflblREsB/tjLsFmAhoCuFx+MVpf3RroQL5A0uZLz6RFxS3lMERhvdQVVWmQhF
         P3xMbBrmj4BcUXNsVmSiFkYUX0xdWI/Xf3RVew8hXLXl4e0z4YAedK8gf3fmyPF3ZVXh
         dUGW91LJEaor3NMQ7UkHC075s/qC3khdGJ/VKIBZrw6+hSVIG7/LedWu/7FxBTmRBaiJ
         P/XcZD5+tvh6b/4aZqklsXiztNzlPdr9nQnpWpqRM/hpxBE3fHkcKZmno0Hw0bTZwm/9
         CQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=MQmDKc2OOuhg0S7JTZ9RlpmduADvX5XBc9//ZGFgkjM=;
        b=HfEWlNnKqm60pMufyt7FuTv8T85n5w8G8+x3Ih7hD7rWUMNpyaZU53IrrbJNBU7PTZ
         9/3uFKukj8mR2VhRmiRqnbwhhRXlBs5pB/xfs4sfwKKjih8QqMxAbJIcfdwtwZBcN1Tj
         7vA8P/ZH9TcwPhnYiehXGn6cRbpcIwm1nkG77Q42Ahrw4Dj7U2bMMFIZOANKA77Fwv+k
         5+8v/qpCJcg+8VIxUBZTTzrdVEYDwCHsQiTAkP2QJml8bEiwuzAFNIj6Ygkf2eY3rgRd
         99aW1D1QgCveEw/NYEgBku8oQ3f5knoxozjDSlxGd69v91lqqQH7/4lSj7e2KcxsfsMY
         N8qQ==
X-Gm-Message-State: ANhLgQ0yw4gV12T3agPSsOxRybuYFhasz6lw9cx2KEFFoQW/4sjHSR7g
        pf4QdJxFW3f4YocET8e3e5Cz1g==
X-Google-Smtp-Source: ADFU+vvVkUi2a069a1v80veVzBMVXnrmAlSnfi68i5da7I+cEwgfzSjVKnjls9ZF1K6qDeRHur6YZQ==
X-Received: by 2002:a1c:4805:: with SMTP id v5mr2361057wma.98.1585127301904;
        Wed, 25 Mar 2020 02:08:21 -0700 (PDT)
Received: from [192.168.0.43] (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.googlemail.com with ESMTPSA id t5sm27015429wrr.93.2020.03.25.02.08.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2020 02:08:21 -0700 (PDT)
Subject: Re: [PATCH] dt-bindings: thermal: make cooling-maps property optional
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Yuantian Tang <andy.tang@nxp.com>, Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20200309045411.21859-1-andy.tang@nxp.com>
 <18c58e1b-583c-2308-ee60-a8923c2027ee@linaro.org>
 <CAHLCerPBxe=Az=EexxYQkgvhRO40JT0qEhnAwqnGbeesiU-bnQ@mail.gmail.com>
 <CAHLCerN6ccJ7zbj9uYKGp-b05q1o7HsaUyW_oTZmEJX1EWXWQQ@mail.gmail.com>
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
Message-ID: <a5d398ac-1ec7-487d-cfe6-82698b683237@linaro.org>
Date:   Wed, 25 Mar 2020 10:08:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAHLCerN6ccJ7zbj9uYKGp-b05q1o7HsaUyW_oTZmEJX1EWXWQQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25/03/2020 07:37, Amit Kucheria wrote:
> On Mon, Mar 16, 2020 at 9:43 PM Amit Kucheria <amit.kucheria@linaro.org> wrote:
>>
>> On Mon, Mar 16, 2020 at 8:22 PM Daniel Lezcano
>> <daniel.lezcano@linaro.org> wrote:
>>>
>>> On 09/03/2020 05:54, andy.tang@nxp.com wrote:
>>>> From: Yuantian Tang <andy.tang@nxp.com>
>>>>
>>>> Cooling-maps doesn't have to be a required property because there may
>>>> be no cooling device on system, or there are no enough cooling devices for
>>>> each thermal zone in multiple thermal zone cases since cooling devices
>>>> can't be shared.
>>>> So make this property optional to remove such limitations.
>>>>
>>>> For thermal zones with no cooling-maps, there could be critic trips
>>>> that can trigger CPU reset or shutdown. So they still can take actions.
>>>>
>>>> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
>>
>> Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
>>
>>>
>>> Amit, I'm about to pick this patch, it will collide with the yaml
>>> conversion changes.
>>
>> Thanks for the headsup. I can fixup v3 when I respin.
>>
>> However, I've always interpreted this binding as follows:
>> - cooling-maps should be mandatory for active and passive trip types
>> otherwise there will be no cooling
>> - cooling-maps make no sense for critical trip type since we're
>> invoking system shutdown
>> - cooling-maps are optional for hot trip types.
>>
>> Is this your understanding too?
>>
>> We should be able to enforce this in YAML.
> 
> Rui, Daniel,
> 
> What do you think about the above interpretation of the cooling-maps bindings?

Yes, I agree with the interpretation.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

