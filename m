Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5133C108400
	for <lists+linux-pm@lfdr.de>; Sun, 24 Nov 2019 16:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfKXPPc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 24 Nov 2019 10:15:32 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46750 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfKXPPb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 24 Nov 2019 10:15:31 -0500
Received: by mail-ot1-f67.google.com with SMTP id n23so10336439otr.13;
        Sun, 24 Nov 2019 07:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Qzs3qOs+XveSh8n886wzuYL0vjKGt4gRKMHsUcIFuF8=;
        b=SRYABA2Tum5SuAFt4WXZp4belYwreF4wclr+XhQfpmQeUO5x92Ow2l0Bf2Xo3ywhkT
         +JyxiwhYfzFh0QqushVwjUtpeNLz3imZqfnPeyJdqK1l3ojw2jc/Lf2Jof79vU51NhlY
         xEGMIDFzQT7pTgI8rY7t29tbaqEPP0mk3QG+svqyaHGcrwLKXPuloISVKXCmvbv+Le4c
         j+m5ur5dguI05sEpcNsNUoHsNZXyvL1xxDpkaRmppgeRnLZ8PbBEGR5fgOPZAifu0cYj
         uFYFSzMm1ThFcyzwiR3dd7jrYxgUx0Ss0jMbhzFwSfuQ/NZ2Q3y67Kb2jq7BVFrNlJqZ
         YMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qzs3qOs+XveSh8n886wzuYL0vjKGt4gRKMHsUcIFuF8=;
        b=QtmzZJfDAkbMpEfp3dTkTjMqXDB0FHywR6BHVesqPz1qXu54/u1nJ5ecIpxIiYiwzh
         eVM061/sY29u7S4uexBJXHFY9jIVnxTF5bs6RCIq/I7ynt7+Mph7RscHa80e7YInkKKu
         4FProLk0jd+7unr0YoKBNHlU5xiUa+g01EMRnELjjMAdYP7lHYNdS+gle6HT9TgDPFsA
         sAVN10elHYpsxl9gtnnI/HZOizKfEyQV4rHr1/Og62+qZ61Z5f7nuAvaQOsC7gO1mM2L
         Qk9IvZvcfGZDUbZlqKb7XrIPsotibRtPjxaxtKVFKwWJNqp8qFLQ2P1HmMj2S3kChKa8
         wKxA==
X-Gm-Message-State: APjAAAWFN9eR/1+2IXHhenbk/8RSYUaJbsUGRPQOLSktA+2T59WT58EJ
        eqtvYTAk0AZQ/Q5YzibF2ME=
X-Google-Smtp-Source: APXvYqzHGMAySx3hPPd9TqvWHgDWXT68moog0lS8Xa31CZB53JBT53NiCkR51iDhIbjJdckycY0t3Q==
X-Received: by 2002:a05:6830:4a2:: with SMTP id l2mr17478845otd.192.1574608530753;
        Sun, 24 Nov 2019 07:15:30 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p3sm1394479oti.22.2019.11.24.07.15.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Nov 2019 07:15:29 -0800 (PST)
Subject: Re: [PATCH 6/8] thermal: intel_pch: switch to use
 <linux/temperature.h> helpers
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
 <1574604530-9024-7-git-send-email-akinobu.mita@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <39b228c3-90c0-5895-9a36-a92747fa7a4c@roeck-us.net>
Date:   Sun, 24 Nov 2019 07:15:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1574604530-9024-7-git-send-email-akinobu.mita@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/24/19 6:08 AM, Akinobu Mita wrote:
> This switches the intel pch thermal driver to use
> deci_kelvin_to_millicelsius() in <linux/temperature.h> instead of helpers
> in <linux/thermal.h>.
> 
> This is preparation for centralizing the kelvin to/from Celsius conversion
> helpers in <linux/temprature.h>.
> 
s/temprature/temperature/

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
>   drivers/thermal/intel/intel_pch_thermal.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/intel/intel_pch_thermal.c
> index 4f0bb8f..3cce310 100644
> --- a/drivers/thermal/intel/intel_pch_thermal.c
> +++ b/drivers/thermal/intel/intel_pch_thermal.c
> @@ -92,7 +92,7 @@ static void pch_wpt_add_acpi_psv_trip(struct pch_thermal_device *ptd,
>   		if (ACPI_SUCCESS(status)) {
>   			unsigned long trip_temp;
>   
> -			trip_temp = DECI_KELVIN_TO_MILLICELSIUS(r);
> +			trip_temp = deci_kelvin_to_millicelsius(r);
>   			if (trip_temp) {
>   				ptd->psv_temp = trip_temp;
>   				ptd->psv_trip_id = *nr_trips;
> 

