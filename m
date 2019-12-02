Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA52810EA20
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2019 13:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfLBMfA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Dec 2019 07:35:00 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35021 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbfLBMe7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Dec 2019 07:34:59 -0500
Received: by mail-wm1-f67.google.com with SMTP id u8so7549928wmu.0
        for <linux-pm@vger.kernel.org>; Mon, 02 Dec 2019 04:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jbvb+H/ELpTFGiSdMhfPOCT+fsPs9G73dvvWwMWt6g8=;
        b=yJEARPs2sGArp+C+8BMxMQcYjf7RGU32TcbfOiP92CUmXpPFy5tt06ZYG5sf/FJE64
         TKkCoj8uExEzkSaibB2Tyo6uQwS+tuA/AXec5/aIHT2WkWxo+21PNQpSe59RgCT4gnbZ
         EyCB32P3OBpvCrjzViEfUWOkT828M2Vpb7bDTK8tdYdrn1/peACbbxtlA+CdM+bmJr9Z
         o3L8l9ZgwFaO+loFVRB5W6FfA5Wei3LGgoIs6+3N9cH/s9niHcj8eOMIt/1sNCaqDizg
         23KhtVyhfSoidMvUmlcpJUWYJK+YtHL9yRzS2bxNViavKeiHThEs8ZjqCCLbJkUJs8Ku
         GLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jbvb+H/ELpTFGiSdMhfPOCT+fsPs9G73dvvWwMWt6g8=;
        b=ZL80xxwVUm2T1z+GNpWfQkei7bUeT41ahvWn/LEYA0h182kgAi/FyeGhwNT+hLekNw
         ihpdV4vWQeGx3tBsBuSYpfjvR0HdwczJV41/FpHhkDmjzEfvax/r4qZMPhihhugtgf9e
         Y2bs8CYjsDKFaFgSQr3vkzrfwwb1cnznUdPStz6DvPNn9BgCHiyIT+AZhzO7nySsoYoc
         b5hQ+b1Kzb4dJNfekwqZVwWrbopJSsFvuaH13/9jia9xuPJQQ9PmIXYnox0bAfImnErq
         vS9aZkCjffUv1vrghn+7YwUMY8N8FwyhDztT/lFbF0JelkIY5hZ1h/lpFDwGMboI8y+L
         9VoQ==
X-Gm-Message-State: APjAAAX/WFnE+UIvzm9HUDaQMfQl3vr11HcLKg9k4Yk6HZ2vbufeOCSQ
        jRYS9igUIUlLqoG2bGGTtDTtaA==
X-Google-Smtp-Source: APXvYqyAbf6IQOpyY+9M8jCzjDxpk1y6oxJ65nIoS+kUic3cvv+i9/6yVzJ2N6pG8FNZW+KgFEaZwA==
X-Received: by 2002:a7b:c632:: with SMTP id p18mr19200640wmk.175.1575290095912;
        Mon, 02 Dec 2019 04:34:55 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:d4a3:d62f:a6b4:eab9? ([2a01:e34:ed2f:f020:d4a3:d62f:a6b4:eab9])
        by smtp.googlemail.com with ESMTPSA id n1sm11965170wrw.52.2019.12.02.04.34.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2019 04:34:55 -0800 (PST)
Subject: Re: [PATCH 3/3] thermal/drivers/cpu_cooling: Introduce the cpu idle
 cooling driver
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, edubezval@gmail.com, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, amit.kucheria@linaro.org,
        linux-kernel@vger.kernel.org
References: <20191113084042.5707-1-daniel.lezcano@linaro.org>
 <20191113084042.5707-3-daniel.lezcano@linaro.org>
 <20191126080315.zc5rllbsc5utuhzq@vireshk-i7>
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
Message-ID: <2aa22bd4-8337-4356-e7fd-3ae5678c1b6f@linaro.org>
Date:   Mon, 2 Dec 2019 13:34:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191126080315.zc5rllbsc5utuhzq@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Viresh,

thanks for the review

On 26/11/2019 09:03, Viresh Kumar wrote:
> On 13-11-19, 09:40, Daniel Lezcano wrote:
>> The cpu idle cooling device offers a new method to cool down a CPU by
>> injecting idle cycles at runtime.
>>
>> It has some similarities with the intel power clamp driver but it is
>> actually designed to be more generic and relying on the idle injection
>> powercap framework.
>>
>> The idle injection cycle is fixed while the running cycle is variable. That
>> allows to have control on the device reactivity for the user experience.
>>
>> An idle state powering down the CPU or the cluster will allow to drop
>> the static leakage, thus restoring the heat capacity of the SoC. It
>> can be set with a trip point between the hot and the critical points,
>> giving the opportunity to prevent a hard reset of the system when the
>> cpufreq cooling fails to cool down the CPU.
>>
>> With more sophisticated boards having a per core sensor, the idle
>> cooling device allows to cool down a single core without throttling
>> the compute capacity of several cpus belonging to the same clock line,
>> so it could be used in collaboration with the cpufreq cooling device.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  drivers/thermal/Kconfig           |   7 +
>>  drivers/thermal/Makefile          |   1 +
>>  drivers/thermal/cpuidle_cooling.c | 233 ++++++++++++++++++++++++++++++
>>  include/linux/cpu_cooling.h       |  22 +++
>>  4 files changed, 263 insertions(+)
>>  create mode 100644 drivers/thermal/cpuidle_cooling.c
>>
>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> index 2b82c4861091..00d69906c508 100644
>> --- a/drivers/thermal/Kconfig
>> +++ b/drivers/thermal/Kconfig
>> @@ -168,6 +168,13 @@ config CPU_FREQ_THERMAL
>>  	  This will be useful for platforms using the generic thermal interface
>>  	  and not the ACPI interface.
>>  
>> +config CPU_IDLE_THERMAL
>> +	bool "CPU idle cooling device"
>> +	depends on IDLE_INJECT
>> +	help
>> +	  This implements the CPU cooling mechanism through
>> +	  idle injection. This will throttle the CPU by injecting
>> +	  idle cycle.
>>  endif
>>  
>>  config CLOCK_THERMAL
>> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
>> index d3b01cc96981..9c8aa2d4bd28 100644
>> --- a/drivers/thermal/Makefile
>> +++ b/drivers/thermal/Makefile
>> @@ -20,6 +20,7 @@ thermal_sys-$(CONFIG_THERMAL_GOV_POWER_ALLOCATOR)	+= power_allocator.o
>>  
>>  # cpufreq cooling
>>  thermal_sys-$(CONFIG_CPU_FREQ_THERMAL)	+= cpu_cooling.o
> 
> We should really rename this as cpufreq_cooling now :)

Ok, will do on top of this series.

>> +thermal_sys-$(CONFIG_CPU_IDLE_THERMAL)	+= cpuidle_cooling.o
>>  
>>  # clock cooling
>>  thermal_sys-$(CONFIG_CLOCK_THERMAL)	+= clock_cooling.o
>> diff --git a/drivers/thermal/cpuidle_cooling.c b/drivers/thermal/cpuidle_cooling.c
>> new file mode 100644
>> index 000000000000..6e911fa87c47
>> --- /dev/null
>> +++ b/drivers/thermal/cpuidle_cooling.c
>> @@ -0,0 +1,233 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + *  Copyright (C) 2019 Linaro Limited.
>> + *
>> + *  Author: Daniel Lezcano <daniel.lezcano@linaro.org>
>> + *
>> + */
>> +#include <linux/cpu_cooling.h>
>> +#include <linux/cpuidle.h>
>> +#include <linux/err.h>
>> +#include <linux/idle_inject.h>
>> +#include <linux/idr.h>
>> +#include <linux/slab.h>
>> +#include <linux/thermal.h>
>> +
>> +/**
>> + * struct cpuidle_cooling_device - data for the idle cooling device
>> + * @ii_dev: an atomic to keep track of the last task exiting the idle cycle
>> + * @idle_duration_us: an integer defining the duration of the idle injection
>> + * @state: an normalized integer giving the state of the cooling device
>> + */
>> +struct cpuidle_cooling_device {
>> +	struct idle_inject_device *ii_dev;
>> +	unsigned int idle_duration_us;
> 
> This field is set with TICK_USEC and nothing else. Why not just use TICK_USEC
> instead at all the places and remove this field?

Actually the idle duration value is platform dependent and even it is
now TICK_USEC, we want to be able to change it (at boot or runtime).

I'll add a function to change the value.

[ ... ]

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

