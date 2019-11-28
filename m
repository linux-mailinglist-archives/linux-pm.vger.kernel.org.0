Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D61D510CB74
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 16:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfK1POH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Nov 2019 10:14:07 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38236 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbfK1POG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Nov 2019 10:14:06 -0500
Received: by mail-ot1-f65.google.com with SMTP id z25so22470945oti.5;
        Thu, 28 Nov 2019 07:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HtuUzrcYCx4FDKvEYRGNCE7CBoyzQfGcKVK/4Fc5Xdo=;
        b=U7H/vMgHKUQfGCWIqsAc2hDHGYhdMRtA9d/x76Mk5bgXtAUHQYEQezz4KCmwjzRW3Q
         +hsmclBS9eH14K21262FlXFPBytrKVmtqE6z5p3Mhr0hBRSz6Z0pzVEFti39PLc/XAxR
         zhD+DjtkdgHLUyMGBNkFnUDJXEDRhysdooejFjchqAbk1nkr7MKaHCVY0WU/efzuvrsy
         f7sb0aw+V9v5w/zyksxHwYqHPfyNJvAnODn4HLzBofYH0/kjvpWUixCFUvHR0Kn2JOBg
         AJvdKW3wjpEhw10cyE8N83V/fU3TEDHS51QKDX7k+/MRSvBF6VZIQ9wkkGDnU6m7vv3p
         18+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HtuUzrcYCx4FDKvEYRGNCE7CBoyzQfGcKVK/4Fc5Xdo=;
        b=uXDEK99CBKoKMznmkMemSpWODYPBfqA9C7TAj3uo13oa0cnETkMP4GeNbPK7z8vv0P
         0viMPthldYPnFxEKHUKgYpqFDWjGUMyztXcynZfqCRFuQulhrKsSz23PQXY38iAQO5Or
         TcnSSk2ZPap0X8wyyOCERj86/S6ZrFPrHB2RfvxmNwtGIOohMQT6Oq8/tj38pdsP6PDF
         S5OyT+BBDTqzUjysyj8S7ExeWg24tupUvGbUYSZax8asraIMo9KLMNMFft8brNUxjupk
         yzioJC087Z3g6x0thcaVmFCC/HRdzPB9DrrvUnXHeQadv6x/GA6CdT5JWPVWelKwz8pS
         9q0w==
X-Gm-Message-State: APjAAAX0BuTn6Oaiz0LdBoQ15nT8dgLS0BlPlbDY9VPrC5xDe4ZlUEAQ
        BAmikxcFCZ2VUqVi2r9RsPg=
X-Google-Smtp-Source: APXvYqwID9RssdR2nPQiWYVEbA9lQFH3JA3ZSSEgHgyZrAY109cux/TszBuuQeKLk9wPhsrCNT+FyQ==
X-Received: by 2002:a05:6830:46:: with SMTP id d6mr8123426otp.7.1574954045573;
        Thu, 28 Nov 2019 07:14:05 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l73sm2613001oib.0.2019.11.28.07.14.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Nov 2019 07:14:04 -0800 (PST)
Subject: Re: [PATCH v2 7/8] nvme: hwmon: switch to use <linux/temperature.h>
 helpers
To:     Akinobu Mita <akinobu.mita@gmail.com>,
        linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sujith Thomas <sujith.thomas@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Jean Delvare <jdelvare@suse.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
References: <1574952879-7200-1-git-send-email-akinobu.mita@gmail.com>
 <1574952879-7200-8-git-send-email-akinobu.mita@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <479c99fe-51c6-910f-4471-4883de4cfd21@roeck-us.net>
Date:   Thu, 28 Nov 2019 07:14:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1574952879-7200-8-git-send-email-akinobu.mita@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/28/19 6:54 AM, Akinobu Mita wrote:
> This switches the nvme driver to use kelvin_to_millicelsius() and
> millicelsius_to_kelvin() in <linux/temperature.h>.
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
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> * v2
> - add Reviewed-by tag
> 
>   drivers/nvme/host/hwmon.c | 13 +++++--------
>   1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
> index a5af21f..14720c1 100644
> --- a/drivers/nvme/host/hwmon.c
> +++ b/drivers/nvme/host/hwmon.c
> @@ -5,14 +5,11 @@
>    */
>   
>   #include <linux/hwmon.h>
> +#include <linux/temperature.h>
>   #include <asm/unaligned.h>
>   
>   #include "nvme.h"
>   
> -/* These macros should be moved to linux/temperature.h */
> -#define MILLICELSIUS_TO_KELVIN(t) DIV_ROUND_CLOSEST((t) + 273150, 1000)
> -#define KELVIN_TO_MILLICELSIUS(t) ((t) * 1000L - 273150)
> -
>   struct nvme_hwmon_data {
>   	struct nvme_ctrl *ctrl;
>   	struct nvme_smart_log log;
> @@ -35,7 +32,7 @@ static int nvme_get_temp_thresh(struct nvme_ctrl *ctrl, int sensor, bool under,
>   		return -EIO;
>   	if (ret < 0)
>   		return ret;
> -	*temp = KELVIN_TO_MILLICELSIUS(status & NVME_TEMP_THRESH_MASK);
> +	*temp = kelvin_to_millicelsius(status & NVME_TEMP_THRESH_MASK);
>   
>   	return 0;
>   }
> @@ -46,7 +43,7 @@ static int nvme_set_temp_thresh(struct nvme_ctrl *ctrl, int sensor, bool under,
>   	unsigned int threshold = sensor << NVME_TEMP_THRESH_SELECT_SHIFT;
>   	int ret;
>   
> -	temp = MILLICELSIUS_TO_KELVIN(temp);
> +	temp = millicelsius_to_kelvin(temp);
>   	threshold |= clamp_val(temp, 0, NVME_TEMP_THRESH_MASK);
>   
>   	if (under)
> @@ -88,7 +85,7 @@ static int nvme_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
>   	case hwmon_temp_min:
>   		return nvme_get_temp_thresh(data->ctrl, channel, true, val);
>   	case hwmon_temp_crit:
> -		*val = KELVIN_TO_MILLICELSIUS(data->ctrl->cctemp);
> +		*val = kelvin_to_millicelsius(data->ctrl->cctemp);
>   		return 0;
>   	default:
>   		break;
> @@ -105,7 +102,7 @@ static int nvme_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
>   			temp = get_unaligned_le16(log->temperature);
>   		else
>   			temp = le16_to_cpu(log->temp_sensor[channel - 1]);
> -		*val = KELVIN_TO_MILLICELSIUS(temp);
> +		*val = kelvin_to_millicelsius(temp);
>   		break;
>   	case hwmon_temp_alarm:
>   		*val = !!(log->critical_warning & NVME_SMART_CRIT_TEMPERATURE);
> 

