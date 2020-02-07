Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 844241554B6
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2020 10:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgBGJbY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Feb 2020 04:31:24 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37642 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgBGJbY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Feb 2020 04:31:24 -0500
Received: by mail-wm1-f66.google.com with SMTP id f129so1916438wmf.2
        for <linux-pm@vger.kernel.org>; Fri, 07 Feb 2020 01:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1iUBzNMidsA87bA3dZRKX5y6urM8a6Elhxwk8/0320E=;
        b=BmEZkG8zulsJCwtECXx7gQ9o597Z+QDoO1RQZYBIpDVeYQL1yj8KuSHQq/iKQgGm3b
         c/0Bdp3okKKoZZ0L0yOvnoTM53uvl3YaM2lq7cTR0S2VjNRkFy2koiOrJbRORRf/Cu/M
         YDzm8/CFz0ILP8vOVwYu8PhBgJs39aPhv2vDDwN8K3wUYHiD7SiJ9zOHbwyCp79dcgqO
         ViGJ4YcIlmDWPWqxrOGhis9Wfbiva1ljGZc2wcpq2EumLGa4r5h7I6sKK+9U4q/Ivpbc
         VC/2JJuuPf9rp38hSyLRgBZRMuZI5a5n4vngJnO51An84Jnw99LZSOzzRBbbR6Id75dI
         idCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=1iUBzNMidsA87bA3dZRKX5y6urM8a6Elhxwk8/0320E=;
        b=BSUn86Ms2aBzTitZ+QaXXwxoHHFleutfXVVCzHPgyZQ+kmuYIZAXs39NyHv/Ok/hds
         41apAY/qTiiM31PQoDeT3A+LNs4rdmrMD4bRMtgh3lanF6r8wXFE5cwxBFl+J34qv7Ms
         zLpTgTodLey05i+fJEjkOh7v+qj93ZNAoyNug3hhRaybDnJsNXM/8A7+nixfZjLEG/qW
         dVuhkQOhYUx2Js2T7e/1ubB9uEpAC6j07o2fIRiQcu8nij+LZaMdTlASoF/UQm4SyUmy
         NYFyetrfsJxldChdipKWprSJW6Lvlr/XEjK9URf6kuP41BQEvfZuAfdv6hrTMPvi0n4U
         xTIw==
X-Gm-Message-State: APjAAAXatP2qwydK/8kHTQmyUNJQxxtz8Cd78lMe+NF6ziuQUoeMCbo+
        NOd5I6fMUyXE5TtKAwp9qj3fng==
X-Google-Smtp-Source: APXvYqz9IRC039rNyH870WEKuoTpjZJ/6rVgLdeJdTVoPnQhGbaodA4Svpxw1D2jz17A4jna4pMWdA==
X-Received: by 2002:a1c:6a15:: with SMTP id f21mr3301225wmc.126.1581067880648;
        Fri, 07 Feb 2020 01:31:20 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:1d4:3aa1:f3b4:32a2? ([2a01:e34:ed2f:f020:1d4:3aa1:f3b4:32a2])
        by smtp.googlemail.com with ESMTPSA id w26sm2598510wmi.8.2020.02.07.01.31.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2020 01:31:20 -0800 (PST)
Subject: Re: [PATCH v8 0/7] add thermal sensor driver for A64, A83T, H3, H5,
 H6, R40
To:     Amit Kucheria <amit.kucheria@verdurent.com>
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?Q?Ond=c5=99ej_Jirman?= <megous@megous.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20191219172823.1652600-1-anarsoul@gmail.com>
 <CAHLCerPWEDqEE8LRUiO5GpeP+BfnestocndBQq6oXAxVN=+3ow@mail.gmail.com>
 <af5383b5-2dd4-92ab-ded2-f1cde48bb21a@linaro.org>
 <CAHLCerPir-7DEpweGZ9qoowm+u3BtDdLyB-B18KibMo9y+Q_DQ@mail.gmail.com>
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
Message-ID: <451416a9-3caa-50d7-832d-9188a53e76ab@linaro.org>
Date:   Fri, 7 Feb 2020 10:31:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAHLCerPir-7DEpweGZ9qoowm+u3BtDdLyB-B18KibMo9y+Q_DQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06/02/2020 20:23, Amit Kucheria wrote:
> On Thu, Feb 6, 2020 at 10:16 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>>
>> Hi Amit,
>>
>> On 06/02/2020 15:13, Amit Kucheria wrote:
>>> Hi Vasily,
>>>
>>> For this entire series, the DTS files don't contain any trip points.
>>> Did I miss some other series?
>>>
>>> At a minimum, you should add some "hot" or "critical" trip points
>>> since then don't require a cooling-map with throttling actions. If you
>>> have "passive" trip points, then you need to provide cooling-maps.
>>
>> Except I'm misunderstanding the bindings, a thermal zone must define
>> these required properties:
>>
>> - polling-delay
>> - polling-delay-passive
>> - thermal-sensors
>> - trips
>> - cooling-maps
> 
> Right, except for the cooling-maps. Those are exempted if there is the
> trip type is not passive. That is my understanding of the existing
> bindings.

The binding is ambiguous.

For me it states the cooling maps must be defined as it is a required
node of the thermal zone.

We may not have an active or passive cooling device for the thermal
zone, thus we can not comply with the dt binding and strictly speaking
we shouldn't add this thermal zone.

But the logic of having a 'hot' or a 'critical' trip point without a
cooling device is correct.

As we move this binding to a schema, we shall clarify the cooling-maps
is required if there are active or passive trip points otherwise it is
optional.


> Trip type critical triggers a shutdown and trip type hot only triggers
> a notification - see thermal_core.c:handle_critical_trips(). So we
> only need cooling maps for passive trip types.
> 
>>> Since this series has been merged, could you please follow up with a
>>> fixup series to add the trip points?
>>>
>>> Regards,
>>> Amit
>>> p.s. We should catch all this automatically, I'll send out yaml
>>> bindings for the thermal framework soon that should catch this stuff.
>>
>> +1
>>
>> There was a small discussion about converting the binding to a schema:
>>
>> https://www.spinics.net/lists/devicetree/msg332424.html
> 
> 
> Aah, I missed that. I started working on something last week that
> looks similar to your discussion. Pushed a WIP branch here[1], it
> looks like I had a similar idea on how to split the bindings. Hope to
> finish this up tomorrow for an RFC.

Great, thanks for taking care of that.


> [1] https://github.com/idlethread/linux/commits/up/thermal/yaml-conversion-v1
> 
>>> On Thu, Dec 19, 2019 at 10:58 PM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>>>>
>>>> This patchset adds driver for thermal sensor in A64, A83T, H3, H5,
>>>> H6 and R40 SoCs.
>>>>
>>>> v8:
>>>>         - [vasily] Address more Maxime's comments for dt-schema
>>>>         - [vasily] Add myself to MAINTAINERS for the driver and schema
>>>>         - [vasily] Round calibration data size to word boundary for H6 and A64
>>>>         - [vasily] Change offset for A64 since it reports too low temp otherwise.
>>>>                    Likely conversion formula in user manual is not correct.
>>>>
>>>> v7:
>>>>         - [vasily] Address Maxime's comments for dt-schema
>>>>         - [vasily] Move common part of H3 and H5 dts into sunxi-h3-h5.dtsi
>>>>         - [vasily] Add Maxime's a-b to the driver patch
>>>>
>>>> v6:
>>>>         - [ondrej, vasily] Squash all driver related changes into a
>>>>                            single patch
>>>>         - [ondrej] Rename calib -> calibration
>>>>         - [ondrej] Fix thermal zone registration check
>>>>         - [ondrej] Lower rate of sensor data interrupts to 4/sec/sensor
>>>>         - [ondrej] Rework scale/offset values, H6 calibration
>>>>         - [ondrej] Explicitly set mod clock to 24 MHz
>>>>         - [ondrej] Set undocumented bits in CTRL0 for H6
>>>>         - [ondrej] Add support for A83T
>>>>         - [ondrej] Add dts changes for A83T, H3, H5, H6
>>>>         - [vasily] Add dts changes for A64
>>>>         - [vasily] Address Maxime's comments for YAML scheme
>>>>         - [vasily] Make .calc_temp callback mandatory
>>>>         - [vasily] Set .max_register in regmap config, so regs can be
>>>>                    inspected using debugfs
>>>>
>>>> Ondrej Jirman (4):
>>>>   ARM: dts: sun8i-a83t: Add thermal sensor and thermal zones
>>>>   ARM: dts: sun8i-h3: Add thermal sensor and thermal zones
>>>>   arm64: dts: allwinner: h5: Add thermal sensor and thermal zones
>>>>   arm64: dts: allwinner: h6: Add thermal sensor and thermal zones
>>>>
>>>> Vasily Khoruzhick (1):
>>>>   arm64: dts: allwinner: a64: Add thermal sensors and thermal zones
>>>>
>>>> Yangtao Li (2):
>>>>   thermal: sun8i: add thermal driver for H6/H5/H3/A64/A83T/R40
>>>>   dt-bindings: thermal: add YAML schema for sun8i-thermal driver
>>>>     bindings
>>>>
>>>>  .../thermal/allwinner,sun8i-a83t-ths.yaml     | 160 +++++
>>>>  MAINTAINERS                                   |   8 +
>>>>  arch/arm/boot/dts/sun8i-a83t.dtsi             |  36 +
>>>>  arch/arm/boot/dts/sun8i-h3.dtsi               |  20 +
>>>>  arch/arm/boot/dts/sunxi-h3-h5.dtsi            |   6 +
>>>>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  42 ++
>>>>  arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi  |  26 +
>>>>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  33 +
>>>>  drivers/thermal/Kconfig                       |  14 +
>>>>  drivers/thermal/Makefile                      |   1 +
>>>>  drivers/thermal/sun8i_thermal.c               | 639 ++++++++++++++++++
>>>>  11 files changed, 985 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
>>>>  create mode 100644 drivers/thermal/sun8i_thermal.c
>>>>
>>>> --
>>>> 2.24.1
>>>>
>>
>>
>> --
>>  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog
>>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

