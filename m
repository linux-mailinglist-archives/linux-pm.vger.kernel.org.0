Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C44F71155BE
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2019 17:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfLFQtY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Dec 2019 11:49:24 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34138 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfLFQtX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Dec 2019 11:49:23 -0500
Received: by mail-wr1-f68.google.com with SMTP id t2so8543158wrr.1
        for <linux-pm@vger.kernel.org>; Fri, 06 Dec 2019 08:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OTF6Cg0prcz8+RTmSVeRQ9PYxVz7NpbprXoE0oIXG0Y=;
        b=sn6b+hwOQzOpIbPQvg0Y2Hu0lgz7RLkeXlXWNbvB0m4BEnFBM+wGurrPdDlb/Odbbp
         3CX9HQ3C+zYyxBcg/8BkHFB5GoXR//p2Lzde6CpwiJ19heMCrTcFOqucBiZ5HOr91hEX
         KPJXdKTsMgYGxcLeLqa2lkBgUJTCFRpdNOKeXVXc1KvejV1uhqVaYwNEKi9c4Y/kae6k
         chwLCcXrfNrLVIQUTFWHzj81d6Angn/sZVWDrVzSD7RtSyiRM47GBiiWwvtWGJCWUfno
         E2vypUCJ9QNHxZAnXuBIacLq0v0HdBHwW6PwDJ2OA9EAWBnaDVx8+BA/4E8NA5LDDI1u
         mhFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=OTF6Cg0prcz8+RTmSVeRQ9PYxVz7NpbprXoE0oIXG0Y=;
        b=IA5JkQ5OpK8q/axJPo/RFl/v1/LHyOKS4MIUIEtnxNdYZgcGsO7RWGUJmDg2foCUYw
         NJ2AbfR2TN4RJZOjPdN5tSURTCjwAebhv0HQefFtMHWGSQZSqZYJMchBJbvGkZ0UGWB1
         a3Ki5pPNFwLdaLLtQ1mo3yAcjDXP5FMWmgjbZTl/WP13XxHZjuqv6jrWvhMj2hmYmuBY
         izjL5Xm7oR3APWZNndGH6cskdQHLt9CJE8L3ZZV/nzaH8yMzbcqrMJ6sLWC9Iujn1f04
         Ml2ALNMKA1ni2lVf0XFCrHVmDf3oxv12qXbpskyb6D2Vc2ihSNz417CuFpsCEMtsZgcw
         rtUg==
X-Gm-Message-State: APjAAAWcXbsIzg54hXf34BNltHLjrT/0Rl6dHdRH8pjT2VwFAzysuPq4
        D7Kv55j5JJ7XFWuOlw9OrTlzvQ==
X-Google-Smtp-Source: APXvYqwbpJbC67Y7EAlRYhifJjx+/B5AXYZRvN2tKQs7kiAl9UjXrnRLWNivJ2bPKSOUYYiE9U+MLg==
X-Received: by 2002:adf:ea0f:: with SMTP id q15mr16138851wrm.324.1575650960120;
        Fri, 06 Dec 2019 08:49:20 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:143f:da10:4344:50a6? ([2a01:e34:ed2f:f020:143f:da10:4344:50a6])
        by smtp.googlemail.com with ESMTPSA id a20sm4063590wmd.19.2019.12.06.08.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2019 08:49:19 -0800 (PST)
Subject: Re: [PATCH v2 1/8] add header file for kelvin to/from Celsius
 conversion helpers
To:     Akinobu Mita <akinobu.mita@gmail.com>,
        linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sujith Thomas <sujith.thomas@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
References: <1574952879-7200-1-git-send-email-akinobu.mita@gmail.com>
 <1574952879-7200-2-git-send-email-akinobu.mita@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <5f85f65c-78b6-0b63-f975-a216f9823985@linaro.org>
Date:   Fri, 6 Dec 2019 17:49:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <1574952879-7200-2-git-send-email-akinobu.mita@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28/11/2019 15:54, Akinobu Mita wrote:
> There are several helper macros to convert kelvin to/from Celsius in
> <linux/thermal.h> for thermal drivers.  These are useful for any other
> drivers or subsystems, but it's odd to include <linux/thermal.h> just for
> the helpers.
> 
> This adds a new <linux/temperature.h> that provides the equivalent inline
> functions for any drivers or subsystems.  It is intended to replace the
> helpers in <linux/thermal.h>.
> 
> Cc: Sujith Thomas <sujith.thomas@intel.com>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Andy Shevchenko <andy@infradead.org>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Amit Kucheria <amit.kucheria@verdurent.com>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Jens Axboe <axboe@fb.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> ---
> * v2
> - add deci_kelvin_to_millicelsius_with_offset() in linux/temperature.h
> - stop including linux/temperature.h from linux/thermal.h
> 
>  include/linux/temperature.h | 51 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 include/linux/temperature.h
> 
> diff --git a/include/linux/temperature.h b/include/linux/temperature.h
> new file mode 100644
> index 0000000..679e70a
> --- /dev/null
> +++ b/include/linux/temperature.h
> @@ -0,0 +1,51 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_TEMPERATURE_H
> +#define _LINUX_TEMPERATURE_H

It sounds strange to create a temperature file just for a few conversion
functions. Why not create an units.h file, so some more conversions
could be added later (not necessarily related to temperature) ?

> +#include <linux/kernel.h>
> +
> +#define ABSOLUTE_ZERO_MILLICELSIUS -273150
> +
> +static inline long kelvin_to_millicelsius(long t)

Why 'long' ?

> +{
> +	return t * 1000 + ABSOLUTE_ZERO_MILLICELSIUS;
> +}
> +
> +static inline long millicelsius_to_kelvin(long t)
> +{
> +	return DIV_ROUND_CLOSEST(t - ABSOLUTE_ZERO_MILLICELSIUS, 1000);

Please don't duplicate these operations, just do the conversion to the
right unit and then call a single function.

Replace the constant by macros like what we find in time64.h.

eg.
#define MILLICELSIUS_PER_CELCIUS 1000

So you can really do the cleanup in all the drivers, like removing:

drivers/iio/adc/qcom-vadc-common.h:#define KELVINMIL_CELSIUSMIL
        273150
drivers/iio/pressure/st_pressure_core.c:#define MCELSIUS_PER_CELSIUS
                1000
drivers/hwmon/xgene-hwmon.c:#define CELSIUS_TO_mCELSIUS(x)
((x) * 1000)
drivers/net/wireless/intel/iwlegacy/common.h:#define
KELVIN_TO_CELSIUS(x) ((x)-273)
drivers/net/wireless/intel/iwlegacy/common.h:#define
CELSIUS_TO_KELVIN(x) ((x)+273)
drivers/net/wireless/intel/iwlwifi/dvm/dev.h:#define
KELVIN_TO_CELSIUS(x) ((x)-273)
drivers/net/wireless/intel/iwlwifi/dvm/dev.h:#define
CELSIUS_TO_KELVIN(x) ((x)+273)
drivers/power/supply/sbs-battery.c:#define TEMP_KELVIN_TO_CELSIUS
        2731
drivers/thermal/armada_thermal.c:#define TO_MCELSIUS(c)
((c) * 1000)
drivers/thermal/rcar_gen3_thermal.c:#define MCELSIUS(temp)      ((temp)
* 1000)
drivers/thermal/rcar_thermal.c:#define MCELSIUS(temp)
((temp) * 1000)
drivers/thermal/samsung/exynos_tmu.c:#define MCELSIUS   1000
drivers/thermal/samsung/exynos_tmu.c:                   temp /= MCELSIUS;
drivers/thermal/samsung/exynos_tmu.c:                   hyst /= MCELSIUS;
drivers/thermal/samsung/exynos_tmu.c:   ref = trips[0].temperature /
MCELSIUS;
drivers/thermal/samsung/exynos_tmu.c:           *temp =
code_to_temp(data, value) * MCELSIUS;
drivers/thermal/samsung/exynos_tmu.c:           temp /= MCELSIUS;


> +}
> +
> +static inline long deci_kelvin_to_celsius(long t)
> +{
> +	return DIV_ROUND_CLOSEST(t * 100 + ABSOLUTE_ZERO_MILLICELSIUS, 1000);
> +}
> +
> +static inline long celsius_to_deci_kelvin(long t)
> +{
> +	return t * 10 - DIV_ROUND_CLOSEST(ABSOLUTE_ZERO_MILLICELSIUS, 100);
> +}
> +
> +/**
> + * deci_kelvin_to_millicelsius_with_offset - convert Kelvin to Celsius
> + * @t: temperature value in decidegrees Kelvin
> + * @offset: difference between Kelvin and Celsius in millidegrees
> + *
> + * Return: temperature value in millidegrees Celsius
> + */
> +static inline long deci_kelvin_to_millicelsius_with_offset(long t, long offset)
> +{
> +	return t * 100 - offset;
> +}
> +
> +static inline long deci_kelvin_to_millicelsius(long t)
> +{
> +	return t * 100 + ABSOLUTE_ZERO_MILLICELSIUS;
> +}
> +
> +static inline long millicelsius_to_deci_kelvin(long t)
> +{
> +	return DIV_ROUND_CLOSEST(t - ABSOLUTE_ZERO_MILLICELSIUS, 100);
> +}
> +
> +#endif /* _LINUX_TEMPERATURE_H */
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

