Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C65D168D45
	for <lists+linux-pm@lfdr.de>; Sat, 22 Feb 2020 08:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgBVHjf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 22 Feb 2020 02:39:35 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54877 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgBVHjd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 22 Feb 2020 02:39:33 -0500
Received: by mail-wm1-f67.google.com with SMTP id z12so833816wmi.4
        for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2020 23:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P9t2Wd4NAlaQd0ZmuCGU4S49XeAYAORDzD+LvPV2h6k=;
        b=M80r+PDiPzVXoBoLSf+oTAiKoTnwYn55XiHqhTskfdbe4e86+5EWTS67LqO8HpfpD9
         VhlJkhh2Vd+MgkqpGsitj0zfffPiHrVjyWy6+qoyX09xrO6cHyZoMrlW2g+1KCT++ryi
         mYRU8RFsR1zQtXKMTH2VXrfaOil/oqv3fjbeIlXOSF91l5dbhYT/clpwU3t7e3iQN7kc
         U9YPrrMucrjQT7MxazmwViJu/exLq/HkAZVd3UKy5uTAYU9BwL89Ao11qtI0nUFI1kir
         9x83vDmAWUyfU8H64lVJ4fDCBbPKe9kVRk4aQMy8iCuvqwf2GucjeTWcaqiIS1AL3Zzq
         1sBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=P9t2Wd4NAlaQd0ZmuCGU4S49XeAYAORDzD+LvPV2h6k=;
        b=AJcnMNX/hrJ8BdU6XV/7iXd9TITdnuZ4MfDljQuPQTY31jOX6MB98/dhLGBK86hlM4
         LFEaLm7H7FXlpP8XBbqdmKbArBaWcJ6fp9s8fUc9MaN28YdBYFPLrwzsoMuVrTwLkZkj
         Edv0RrUMhCns4DxyzG1cvpQx4RHVld+S8mFWxVgF/jUOF06N9sSSPrestueLv32L4yMa
         XlHRVtYGcI0GW2SGLdrxXWnjdjMcKFzDdCBBoi8X+WVz8KkvG0bd73D/gKxjqlH3YxJv
         lj5qiepxt5tsYLqQVORrSFnmC4lZIOQP0j/r/bRenFwE2FJj3iXKBmD9OLLpCrmsA7F2
         TCtw==
X-Gm-Message-State: APjAAAVGTCFzC/NKYkKls444atu3TvqAnW8HqYaqvDdzW8dF2Nex88yv
        q4CuIIgc1w/22QADcbNeCK3tQg==
X-Google-Smtp-Source: APXvYqyqNqfvOSii00tp9NMAPL+QpnOgiilbNi4/8kMHXUjMniO+/GbiGuvMG0sgxRwD5iYpaaGP4A==
X-Received: by 2002:a05:600c:248:: with SMTP id 8mr8548174wmj.1.1582357169598;
        Fri, 21 Feb 2020 23:39:29 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:903b:a048:f296:e3ae? ([2a01:e34:ed2f:f020:903b:a048:f296:e3ae])
        by smtp.googlemail.com with ESMTPSA id p5sm7181582wrt.79.2020.02.21.23.39.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 23:39:28 -0800 (PST)
Subject: Re: [PATCH V15 RESEND 3/5] thermal: imx_sc: add i.MX system
 controller thermal support
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        Andy Duan <fugang.duan@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "marcin.juszkiewicz@linaro.org" <marcin.juszkiewicz@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
References: <1582161028-2844-1-git-send-email-Anson.Huang@nxp.com>
 <1582161028-2844-3-git-send-email-Anson.Huang@nxp.com>
 <20200221125300.GB10516@linaro.org>
 <DB3PR0402MB3916CCBD8F36161B6F9EA45FF5120@DB3PR0402MB3916.eurprd04.prod.outlook.com>
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
Message-ID: <aed6c4ab-59e2-ebcb-be91-4b7e909419d9@linaro.org>
Date:   Sat, 22 Feb 2020 08:39:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <DB3PR0402MB3916CCBD8F36161B6F9EA45FF5120@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22/02/2020 00:46, Anson Huang wrote:
> Hi, Daniel
> 
>> Subject: Re: [PATCH V15 RESEND 3/5] thermal: imx_sc: add i.MX system
>> controller thermal support
>>
>> Hi Anson,
>>
>> sorry for the delay with this review, hopefully the upstreaming will be now a
>> bit more smooth.
> 
> Thanks very much for review😊
> 
>>
>> Apart the comments below, the driver looks good to me.
>>
>> On Thu, Feb 20, 2020 at 09:10:26AM +0800, Anson Huang wrote:
>>> i.MX8QXP is an ARMv8 SoC which has a Cortex-M4 system controller
>>> inside, the system controller is in charge of controlling power, clock
>>> and thermal sensors etc..
>>>
>>> This patch adds i.MX system controller thermal driver support, Linux
>>> kernel has to communicate with system controller via MU (message unit)
>>> IPC to get each thermal sensor's temperature, it supports multiple
>>> sensors which are passed from device tree, please see the binding doc
>>> for details.
>>>
>>> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
>>> ---
>>> No change.
>>> ---
>>>  drivers/thermal/Kconfig          |  11 +++
>>>  drivers/thermal/Makefile         |   1 +
>>>  drivers/thermal/imx_sc_thermal.c | 142
>>> +++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 154 insertions(+)
>>>  create mode 100644 drivers/thermal/imx_sc_thermal.c
>>>
>>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig index
>>> 5a05db5..d1cb8dc 100644
>>> --- a/drivers/thermal/Kconfig
>>> +++ b/drivers/thermal/Kconfig
>>> @@ -251,6 +251,17 @@ config IMX_THERMAL
>>>  	  cpufreq is used as the cooling device to throttle CPUs when the
>>>  	  passive trip is crossed.
>>>
>>> +config IMX_SC_THERMAL
>>> +	tristate "Temperature sensor driver for NXP i.MX SoCs with System
>> Controller"
>>> +	depends on ARCH_MXC && IMX_SCU
>>
>> IMX_SCU depends on IMX_MBOX which depends on ARCH_MXC. This
>> dependency could be simplified.
>>
>> Also add the COMPILE_TEST option to improve compilation test coverage.
> 
> Will make it depends on IMX_SCU and COMPILE_TEST
> 
>>
>>> +	depends on OF
>>> +	help
>>> +	  Support for Temperature Monitor (TEMPMON) found on NXP i.MX
>> SoCs with
>>> +	  system controller inside, Linux kernel has to communicate with
>> system
>>> +	  controller via MU (message unit) IPC to get temperature from
>> thermal
>>> +	  sensor. It supports one critical trip point and one
>>> +	  passive trip point for each thermal sensor.
>>> +
>>>  config MAX77620_THERMAL
>>>  	tristate "Temperature sensor driver for Maxim MAX77620 PMIC"
>>>  	depends on MFD_MAX77620
>>> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile index
>>> 9fb88e2..a11a6d8 100644
>>> --- a/drivers/thermal/Makefile
>>> +++ b/drivers/thermal/Makefile
>>> @@ -43,6 +43,7 @@ obj-$(CONFIG_DB8500_THERMAL)	+=
>> db8500_thermal.o
>>>  obj-$(CONFIG_ARMADA_THERMAL)	+= armada_thermal.o
>>>  obj-$(CONFIG_TANGO_THERMAL)	+= tango_thermal.o
>>>  obj-$(CONFIG_IMX_THERMAL)	+= imx_thermal.o
>>> +obj-$(CONFIG_IMX_SC_THERMAL)	+= imx_sc_thermal.o
>>>  obj-$(CONFIG_MAX77620_THERMAL)	+= max77620_thermal.o
>>>  obj-$(CONFIG_QORIQ_THERMAL)	+= qoriq_thermal.o
>>>  obj-$(CONFIG_DA9062_THERMAL)	+= da9062-thermal.o
>>> diff --git a/drivers/thermal/imx_sc_thermal.c
>>> b/drivers/thermal/imx_sc_thermal.c
>>> new file mode 100644
>>> index 0000000..d406ecb
>>> --- /dev/null
>>> +++ b/drivers/thermal/imx_sc_thermal.c
>>> @@ -0,0 +1,142 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +/*
>>> + * Copyright 2018-2019 NXP.
>>
>> *sigh* 2020 now ...
> 
> Yes, should be 2018-2020
> 
>>
>> [ ... ]
>>
>>> +static int imx_sc_thermal_get_temp(void *data, int *temp) {
>>> +	struct imx_sc_msg_misc_get_temp msg;
>>> +	struct imx_sc_rpc_msg *hdr = &msg.hdr;
>>> +	struct imx_sc_sensor *sensor = data;
>>> +	int ret;
>>> +
>>> +	msg.data.req.resource_id = sensor->resource_id;
>>> +	msg.data.req.type = IMX_SC_C_TEMP;
>>> +
>>> +	hdr->ver = IMX_SC_RPC_VERSION;
>>> +	hdr->svc = IMX_SC_RPC_SVC_MISC;
>>> +	hdr->func = IMX_SC_MISC_FUNC_GET_TEMP;
>>> +	hdr->size = 2;
>>
>> Can you explain this 'size' value?
> 
> The size means the SCU message size, including the header and the data, its unit
> is word(4 bytes), in thermal get temperature message, the header takes 1 word and
> the data takes another 1, so it is 2, we all pass the size in this way to SCU in i.MX8
> SoCs, the SCU know how long message it will need to receive from AP.

Thanks for the clarification.

>> [ ... ]
>>
>>> +MODULE_DEVICE_TABLE(of, imx_sc_thermal_table);
>>> +
>>> +static struct platform_driver imx_sc_thermal_driver = {
>>> +		.probe = imx_sc_thermal_probe,
>>
>> The driver can be compiled as module but there is no 'remove' callback
> 
> As there is nothing needs to be done in .remove callback, so I skip it. But
> I think I can add a blank .remove callback to make it more complete.

Ah, right. Everything is handled by "devm_"


>>> +		.driver = {
>>> +			.name = "imx-sc-thermal",
>>> +			.of_match_table = imx_sc_thermal_table,
>>> +		},
>>> +};
>>> +module_platform_driver(imx_sc_thermal_driver);
>>> +
>>> +MODULE_AUTHOR("Anson Huang <Anson.Huang@nxp.com>");
>>> +MODULE_DESCRIPTION("Thermal driver for NXP i.MX SoCs with system
>>> +controller"); MODULE_LICENSE("GPL v2");
>

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

