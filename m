Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E847E503F1
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2019 09:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfFXHpr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Jun 2019 03:45:47 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37158 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbfFXHpq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jun 2019 03:45:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id v14so12740693wrr.4
        for <linux-pm@vger.kernel.org>; Mon, 24 Jun 2019 00:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UF0IauyLL9qObMd2T6RxV5zEC/V6smP92cxcZGdpZ3w=;
        b=J+vBE3A6gh6S+hYQQ2rYCFbFxuPvuzHPoL0Ur+YYH8OE0ANqQJtk2/iiTvE/Ac9Eg5
         4sFD5W7GNnUyLX3eGW6EZRBCek+sFwH0dmOIogS6IeYuEN05O383eOOkqEJpq4WTzD9t
         o80/lu01mB2tC7SOmxrtIkCTYmiUuYLVA9CiC7Kk4/s1fkBD/z0Kuo+qJZTxOOW9CAjs
         Ne6q6gkfcvmG8MzdOMBuFQ3r6FQgLEwx/eH2+njE0WDSFxIyu22/JWcqOJjg2Wi39BH+
         pMYPnWzIbT3nXYrVoAm9fh93oe0DSHHqz6p89WT+UE9AUbNNh475CquD6isPrWBwA7m/
         l8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=UF0IauyLL9qObMd2T6RxV5zEC/V6smP92cxcZGdpZ3w=;
        b=pMDWO7z4MYGTMBo8uvDiq4dQzmgPyQ/sN6ewflzxHPxLZpK5w1nZDfefu14VEIxLeV
         RdRmdIwHfCTQmoqLUqrkqPPUAm00SSlSum3v5MkcIOWnxNFMWXbXcfcph76wdF5aPuqE
         2QfXs7jsieRdpVm+Y1oZbI5V5+IXiB+8p9Mb0/LXnY7T3amvPyTs8jZpTqGy+eR0yYuu
         RgVePZl5fUQ4G1EzUit/5Pjux1/noUqEBaOhIrqY8Rs0iqXQVqiTWyea5ivFFJT/r50/
         1zh3dIr9lVQiujn5wgxoxMgHbXjvQ130NXY4mofQzgwekyouAfmmq81ufszmlAt9Lx3u
         Wtmg==
X-Gm-Message-State: APjAAAX2+vDMBYWNar9MN8bEofT/wiIaDgbEJfd6IubotFAnRKfG8QGJ
        kzkIgsN3vXjMZF0G8VAI8fuL1A==
X-Google-Smtp-Source: APXvYqyte1PaGMAuWJR5FnsvyEniUnMhVNbJuK8yXMSXWtbM10BtQ74Mlu9Wl1xILSu7a8SJm5xJ2A==
X-Received: by 2002:adf:d4c1:: with SMTP id w1mr44719826wrk.229.1561362343350;
        Mon, 24 Jun 2019 00:45:43 -0700 (PDT)
Received: from [192.168.0.41] (209.94.129.77.rev.sfr.net. [77.129.94.209])
        by smtp.googlemail.com with ESMTPSA id s3sm18631617wmh.27.2019.06.24.00.45.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 00:45:42 -0700 (PDT)
Subject: Re: [PATCH 2/6] thermal/drivers/cpu_cooling: Unregister with the
 policy
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     edubezval@gmail.com, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Keerthy <j-keerthy@ti.com>,
        "open list:CPU FREQUENCY DRIVERS - ARM BIG LITTLE" 
        <linux-pm@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:TI BANDGAP AND THERMAL DRIVER" 
        <linux-omap@vger.kernel.org>
References: <20190621132302.30414-1-daniel.lezcano@linaro.org>
 <20190621132302.30414-2-daniel.lezcano@linaro.org>
 <20190624060334.kak2mjuou4napi4x@vireshk-i7>
 <3f324189-aa1e-ae78-1d69-61e00c5d033a@linaro.org>
 <20190624073747.hf7jd6ulkmebbxtm@vireshk-i7>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d31f65c8-53df-ae59-5f6f-211c0ddcff3f@linaro.org>
Date:   Mon, 24 Jun 2019 09:45:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190624073747.hf7jd6ulkmebbxtm@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24/06/2019 09:37, Viresh Kumar wrote:
> On 24-06-19, 09:30, Daniel Lezcano wrote:
>> On 24/06/2019 08:03, Viresh Kumar wrote:
>>> On 21-06-19, 15:22, Daniel Lezcano wrote:
>>>> Currently the function cpufreq_cooling_register() returns a cooling
>>>> device pointer which is used back as a pointer to call the function
>>>> cpufreq_cooling_unregister(). Even if it is correct, it would make
>>>> sense to not leak the structure inside a cpufreq driver and keep the
>>>> code thermal code self-encapsulate. Moreover, that forces to add an
>>>> extra variable in each driver using this function.
>>>>
>>>> Instead of passing the cooling device to unregister, pass the policy.
>>>>
>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>> ---
>>>>  drivers/cpufreq/arm_big_little.c               |  2 +-
>>>>  drivers/cpufreq/cpufreq.c                      |  2 +-
>>>>  drivers/thermal/cpu_cooling.c                  | 18 ++++++++++--------
>>>>  drivers/thermal/imx_thermal.c                  |  4 ++--
>>>>  .../thermal/ti-soc-thermal/ti-thermal-common.c |  2 +-
>>>>  include/linux/cpu_cooling.h                    |  6 +++---
>>>>  6 files changed, 18 insertions(+), 16 deletions(-)
>>>
>>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>>
>> Just a side note, does it make sense to have the function called from
>> imx_thermal.c and ti-thermal-common.c? Sounds like also a leakage from
>> cpufreq to thermal drivers, no?
> 
> I am not sure what you are proposing here :)

Actually I'm asking your opinion :)

The structure in drivers/thermal/imx_thermal.c

struct imx_thermal_data {
        struct cpufreq_policy *policy; <<<< in the thermal data ?!
	[ ... ]
};

And then:

#ifdef CONFIG_CPU_FREQ
/*
 * Create cooling device in case no #cooling-cells property is available in
 * CPU node
 */
static int imx_thermal_register_legacy_cooling(struct imx_thermal_data
*data)
{
        struct device_node *np;
        int ret;

        data->policy = cpufreq_cpu_get(0);
        if (!data->policy) {
                pr_debug("%s: CPUFreq policy not found\n", __func__);
                return -EPROBE_DEFER;
        }

        np = of_get_cpu_node(data->policy->cpu, NULL);

        if (!np || !of_find_property(np, "#cooling-cells", NULL)) {
                data->cdev = cpufreq_cooling_register(data->policy);
                if (IS_ERR(data->cdev)) {
                        ret = PTR_ERR(data->cdev);
                        cpufreq_cpu_put(data->policy);
                        return ret;
                }
        }

        return 0;
}

[ ... ]

Shouldn't this be move in the drivers/cpufreq/<whatever driver> ?

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

