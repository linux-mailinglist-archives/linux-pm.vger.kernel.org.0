Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F65D108408
	for <lists+linux-pm@lfdr.de>; Sun, 24 Nov 2019 16:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfKXPRu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 24 Nov 2019 10:17:50 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34414 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbfKXPRu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 24 Nov 2019 10:17:50 -0500
Received: by mail-oi1-f195.google.com with SMTP id l202so10883253oig.1;
        Sun, 24 Nov 2019 07:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5C9fcZplZbhqVRMPmr2V23XeMRp4oEU3og0P7QEerd4=;
        b=Jpx1440YYqzexRpdjA3SiAXYclFcRW+1AfgPguF0jIkyAvx6JHX8y+wllMlbcSgDco
         eK2aFQg70ozNQNHxITEOvlqPDYLnndXq9eeXtS4Oi1Z8oBPuAZMLjB4TEa+V3ptHcNG6
         e0hCF5JuyilIJRpYC8aMsh4Lf5ExTN3ISK1ulc9fzIgZ7F/HQITN2iDR6i933R4h6llG
         7oMm6hcdle9fL/RUJhFwLps0dU5tvK4Nh9N5kFbRk1wOnr2ebRLzeTyVJugqrWcGYdVY
         Vkx3FdnZaoBHvR4vkWkyksMbdAHh+QJApDTek7WBJxQHySdHoVoXT37KH6PJSmMgAosL
         jqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5C9fcZplZbhqVRMPmr2V23XeMRp4oEU3og0P7QEerd4=;
        b=NHOtDzD9m3Yvlf1mbg8XkWJ60DWU3j81MWYXs1LdDil3E4RB0YXX5WapBJLpo3F07n
         P4KFVjlZUGDv7hzJUsW8SPzcH55/fHnZlp9j8tQ5i/HC1Kpv3g4dyUYP1J0nL9pL3qt5
         0xjK8CFXVH4whjIJ608Y+k0GklPuIo+rRFbQ+uoz82hABVuuyXT9SN4Lyp6NkvQSFWkr
         Ta9lEHyfNw9ha83txkUMBnzQXvaYbfv/G8vJHQjf/0ObabaKtJOos2AKxg7XwM+M8cuQ
         5oc1oeX0jtwJjdK9Z5gIB1BH1o/CrrNKAaHv3zRkjz4AKHX7ADUFEGA/ZBzOGJ5Bdw/F
         l0MA==
X-Gm-Message-State: APjAAAVGV89M1f2I3NV71rNGcbM6ftsUJDGbNTMNovHYrSs6wtTFAE7a
        ofnSiLtr1xSoVCJBZFUbtxIB5NVN
X-Google-Smtp-Source: APXvYqyo788a2sh7C+EcGrnmfMQbs2nuTW/CVkvqD52t1x6QsdY3JKPC2qKdW9qWYn5up2z8JtTfBw==
X-Received: by 2002:aca:d78a:: with SMTP id o132mr20032815oig.79.1574608669287;
        Sun, 24 Nov 2019 07:17:49 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v7sm1548686oie.51.2019.11.24.07.17.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Nov 2019 07:17:48 -0800 (PST)
Subject: Re: [PATCH 2/8] ACPI: thermal: switch to use <linux/temperature.h>
 helpers
To:     Akinobu Mita <akinobu.mita@gmail.com>,
        linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sujith Thomas <sujith.thomas@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Jean Delvare <jdelvare@suse.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
References: <1574604530-9024-1-git-send-email-akinobu.mita@gmail.com>
 <1574604530-9024-3-git-send-email-akinobu.mita@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <00fff683-d0e2-67ae-83e3-c472fdbe9e1d@roeck-us.net>
Date:   Sun, 24 Nov 2019 07:17:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1574604530-9024-3-git-send-email-akinobu.mita@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/24/19 6:08 AM, Akinobu Mita wrote:
> This switches the ACPI thermal zone driver to use celsius_to_deci_kelvin()
> and deci_kelvin_to_celsius() in <linux/temperature.h> instead of helpers
> in <linux/thermal.h>.
> 
> This is preparation for centralizing the kelvin to/from Celsius conversion
> helpers in <linux/temprature.h>.
> 
s/temprature/temperature/

Looks like this applies to all patches.

> Cc: Sujith Thomas <sujith.thomas@intel.com>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Andy Shevchenko <andy@infradead.org>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
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
>   drivers/acpi/thermal.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index d831a61..bd9b6eb 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -297,7 +297,9 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
>   			if (crt == -1) {
>   				tz->trips.critical.flags.valid = 0;
>   			} else if (crt > 0) {
> -				unsigned long crt_k = CELSIUS_TO_DECI_KELVIN(crt);
> +				unsigned long crt_k =
> +					celsius_to_deci_kelvin(crt);
> +

>   				/*
>   				 * Allow override critical threshold
>   				 */
> @@ -333,7 +335,7 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
>   		if (psv == -1) {
>   			status = AE_SUPPORT;
>   		} else if (psv > 0) {
> -			tmp = CELSIUS_TO_DECI_KELVIN(psv);
> +			tmp = celsius_to_deci_kelvin(psv);
>   			status = AE_OK;
>   		} else {
>   			status = acpi_evaluate_integer(tz->device->handle,
> @@ -413,7 +415,7 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
>   					break;
>   				if (i == 1)
>   					tz->trips.active[0].temperature =
> -						CELSIUS_TO_DECI_KELVIN(act);
> +						celsius_to_deci_kelvin(act);
>   				else
>   					/*
>   					 * Don't allow override higher than
> @@ -421,9 +423,9 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
>   					 */
>   					tz->trips.active[i - 1].temperature =
>   						(tz->trips.active[i - 2].temperature <
> -						CELSIUS_TO_DECI_KELVIN(act) ?
> +						celsius_to_deci_kelvin(act) ?
>   						tz->trips.active[i - 2].temperature :
> -						CELSIUS_TO_DECI_KELVIN(act));
> +						celsius_to_deci_kelvin(act));
>   				break;
>   			} else {
>   				tz->trips.active[i].temperature = tmp;
> @@ -1087,7 +1089,8 @@ static int acpi_thermal_add(struct acpi_device *device)
>   	INIT_WORK(&tz->thermal_check_work, acpi_thermal_check_fn);
>   
>   	pr_info(PREFIX "%s [%s] (%ld C)\n", acpi_device_name(device),
> -		acpi_device_bid(device), DECI_KELVIN_TO_CELSIUS(tz->temperature));
> +		acpi_device_bid(device),
> +		deci_kelvin_to_celsius(tz->temperature));
>   	goto end;
>   
>   free_memory:
> 

