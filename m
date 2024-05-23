Return-Path: <linux-pm+bounces-8077-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA798CD466
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2024 15:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 993C11F21544
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2024 13:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFF014B954;
	Thu, 23 May 2024 13:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="koZB+EFR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC02714B945
	for <linux-pm@vger.kernel.org>; Thu, 23 May 2024 13:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470647; cv=none; b=VLUIjJasgb32IwQoOCMmjHLzJxtALEMRabdaM71HknIa8XyqMSY+3UGm3ICE8vvHi8GMhoyPChNktSrLX0cxcoHCqx18efiaXjqXwU98bB2SPDwCP39obtEc1/9Rgt6avsoio+KBKwpWIUKAleEr4BAiYzMySlf5sJlB2Xr09QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470647; c=relaxed/simple;
	bh=NGwPr7Z67/7znzHkXoOkccT+OKYhRJioZ0H0WNeR2Ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YDkOqnmKtVNUodcwOxyyv44CICBO3vlhe1rYvzXP9pQFuG8eGrfJeMT0nSRzRP6EDgdzHMBOYw2tdZT2ZF2avel7kELAjVVdOTvMeh0TCGtOQRnowbScRLImeLUWr6XieqPUIQ73olfe5phLcT35DaTevM/oVW/3znA+DNfdMEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=koZB+EFR; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-420180b59b7so18527075e9.0
        for <linux-pm@vger.kernel.org>; Thu, 23 May 2024 06:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716470642; x=1717075442; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b1bEXVq0kjirSToKmi5rGdt49BYr5FRGBXpMPxi+kOw=;
        b=koZB+EFRxprRe2NIqCCrwEOknZ5xyjogeACJw1ehjDsv17i/PEKbNVHQ9Nns/xroMk
         M/h0DLqBGYVZQAo4PvW75UoA+clsqiWHgQcKg/K4vvMaNbbWx3Lm9foKTbwLf14PIDPb
         XnhUQON2mHK0aDQpWaK94BXLFRTdRO0Oqlt8rcv0cOkYZYDFAZPsGn71KLAYh+WieP8H
         e/K520HIGaxzTjELu8USDH3BfojE/3HImDdyuKKtJJf0xvE+v7pn6ZL15yS2OkEJ+50h
         idv5OXhpU1J09LZ+TjbC5lXBOwMAOzMVj2YDbNg6gq6IeqaEqdkiKfYmztoz8DjNw2ic
         nKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716470642; x=1717075442;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b1bEXVq0kjirSToKmi5rGdt49BYr5FRGBXpMPxi+kOw=;
        b=a3ISFtrXcpRtzIAX38ZmwVBgAfL1LboEKuMbjUOa5y5OrD5Wm1hd0z19F5FmlNm5Pt
         mJwrw6HR8aDD2kXlb6FhHtdlmzbH3mUdtubfRXq4PjGl5Xf5Ts9ePTperGZ8CDxiBiso
         8/LqX+w/PJsC40wgA8sxvuUzb667MYuALTgMsiDR5qsT+VMi3tn6WlVayQ3GTnLPPZdg
         wVXX6BSxbQ3wUwVsj7WOIuEA3jw8tpItQfrGLIK5x01qBPjmyy99UPbokDHLdAkyUxxh
         XaGR/D0iTj7qkcU9KUfS9SBuUeARpJbis35kQCTQVQTT7w6+VR1WxBxi+Bg9m9aQfOAU
         bwlA==
X-Forwarded-Encrypted: i=1; AJvYcCXS1vSL8bZbkT8gzeviCpcLBgTh8Y8t3E9Kx2X2TJAkC1VORNvW/P+yoVUA9/chk8Ep+Y5LlFBS+hgTmTLReqK4O57VITbDxVU=
X-Gm-Message-State: AOJu0YwVWCbqEIlTDBvmBO6niZw+Lq+2ohUbxWo7DcIv5hkrwnXXsAEB
	UZBSxkFoRx0xd/Q2uXEMGbD6MLmrJwhqV+ep1YG8D1b6HCVq5nkRb7hwYlCUYXo=
X-Google-Smtp-Source: AGHT+IEmASdfZKnXNv6IGUCEuEhwh0HO1qVFlUYCx6ZCIO7fIrZ4lZuzh8+txvcQCC9JRq0nnaNXoA==
X-Received: by 2002:a1c:4c10:0:b0:420:1585:7a99 with SMTP id 5b1f17b1804b1-420fd384c7emr39170205e9.38.1716470642181;
        Thu, 23 May 2024 06:24:02 -0700 (PDT)
Received: from ?IPV6:2a04:cec2:21:7ed1:cc40:dfff:5a22:b06a? ([2a04:cec2:21:7ed1:cc40:dfff:5a22:b06a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100fb7fe1sm25098895e9.45.2024.05.23.06.24.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 06:24:00 -0700 (PDT)
Message-ID: <dfb5a14d-bd35-4271-9ded-888eb5c0cff3@baylibre.com>
Date: Thu, 23 May 2024 15:23:59 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] thermal: Add support of multi sensors to
 thermal_core
To: Pin-yen Lin <treapking@chromium.org>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, rui.zhang@intel.com,
 lukasz.luba@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Hsin-Te Yuan <yuanhsinte@chromium.org>
References: <20240119110842.772606-1-abailon@baylibre.com>
 <20240119110842.772606-3-abailon@baylibre.com>
 <CAEXTbpeJ=3kxeKy4rXUfNEO==XYQ2DQx+ex2nLNkur_X6p1VVQ@mail.gmail.com>
Content-Language: en-US
From: Alexandre Bailon <abailon@baylibre.com>
In-Reply-To: <CAEXTbpeJ=3kxeKy4rXUfNEO==XYQ2DQx+ex2nLNkur_X6p1VVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Pin-yen,

> Hi Alexandre,
> 
> On Thu, Apr 11, 2024 at 4:34 PM Alexandre Bailon <abailon@baylibre.com> wrote:
>>
>> This adds support of multi sensors to thermal.
>> Currently, this only support the get_temp operation.
>> This returns an average temperature of all the sensors.
>> If defined, a coefficient is applied to the value read from the sensor
>> before computing the average.
>>
>> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
>> ---
>>   drivers/thermal/Makefile        |   1 +
>>   drivers/thermal/thermal_core.h  |   7 ++
>>   drivers/thermal/thermal_multi.c | 178 ++++++++++++++++++++++++++++++++
>>   3 files changed, 186 insertions(+)
>>   create mode 100644 drivers/thermal/thermal_multi.c
>>
>> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
>> index c934cab309ae..757289a406f7 100644
>> --- a/drivers/thermal/Makefile
>> +++ b/drivers/thermal/Makefile
>> @@ -6,6 +6,7 @@ CFLAGS_thermal_core.o           := -I$(src)
>>   obj-$(CONFIG_THERMAL)          += thermal_sys.o
>>   thermal_sys-y                  += thermal_core.o thermal_sysfs.o
>>   thermal_sys-y                  += thermal_trip.o thermal_helpers.o
>> +thermal_sys-y                  += thermal_multi.o
>>
>>   # netlink interface to manage the thermal framework
>>   thermal_sys-$(CONFIG_THERMAL_NETLINK)          += thermal_netlink.o
>> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
>> index 0a3b3ec5120b..26e83a5c8298 100644
>> --- a/drivers/thermal/thermal_core.h
>> +++ b/drivers/thermal/thermal_core.h
>> @@ -138,6 +138,13 @@ ssize_t weight_show(struct device *, struct device_attribute *, char *);
>>   ssize_t weight_store(struct device *, struct device_attribute *, const char *,
>>                       size_t);
>>
>> +/* Multi sensors */
>> +int thermal_multi_sensor_validate_coeff(int *coeff, int count, int offset);
>> +int thermal_multi_sensor_register(const char *name,
>> +       struct thermal_zone_device *sensor_tz, int coeff);
>> +void thermal_multi_sensor_unregister(struct thermal_zone_device *sensor_tz);
>> +
>> +
>>   #ifdef CONFIG_THERMAL_STATISTICS
>>   void thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
>>                                           unsigned long new_state);
>> diff --git a/drivers/thermal/thermal_multi.c b/drivers/thermal/thermal_multi.c
>> new file mode 100644
>> index 000000000000..a5a4f1f2d594
>> --- /dev/null
>> +++ b/drivers/thermal/thermal_multi.c
>> @@ -0,0 +1,178 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <linux/err.h>
>> +#include <linux/export.h>
>> +#include <linux/of.h>
>> +#include <linux/slab.h>
>> +#include <linux/thermal.h>
>> +#include <linux/types.h>
>> +#include <linux/string.h>
>> +
>> +#include "thermal_core.h"
>> +
>> +struct sensor_interface {
>> +       struct thermal_zone_device *tz;
>> +       int coeff;
>> +
>> +       struct list_head node;
>> +};
>> +
>> +struct multi_sensor_thermal_zone {
>> +       struct thermal_zone_device *tz;
>> +       struct mutex sensors_lock;
>> +       struct list_head sensors;
>> +
>> +       struct list_head node;
>> +};
>> +
>> +static DEFINE_MUTEX(multi_tz_mutex);
>> +static LIST_HEAD(multi_tz_list);
>> +
>> +#define TJ_MAX 120000
>> +
>> +static int multi_sensor_get_temp(struct thermal_zone_device *tz, int *temp)
>> +{
>> +       struct multi_sensor_thermal_zone *multi_tz = tz->devdata;
>> +       struct sensor_interface *sensor;
>> +       int accumulated_temp = 0;
>> +       u32 accumulated_coeff;
> 
> Should we initialize accumulated_coeff to 0 as well?
Yes, indeed, I will fix it.
> 
>> +       int ret;
>> +
>> +       mutex_lock(&multi_tz->sensors_lock);
>> +
>> +       if (list_empty(&multi_tz->sensors)) {
>> +               mutex_unlock(&multi_tz->sensors_lock);
>> +               return -ENODEV;
>> +       }
>> +
>> +       list_for_each_entry(sensor, &multi_tz->sensors, node) {
>> +               ret = thermal_zone_get_temp(sensor->tz, temp);
>> +               if (ret) {
>> +                       mutex_unlock(&multi_tz->sensors_lock);
>> +                       return ret;
>> +               }
>> +
>> +               accumulated_temp += *temp * sensor->coeff;
>> +               accumulated_coeff += sensor->coeff;
>> +       }
>> +
>> +       mutex_unlock(&multi_tz->sensors_lock);
>> +
>> +       *temp = accumulated_temp / accumulated_coeff;
>> +       return ret;
>> +}
>> +
>> +struct thermal_zone_device_ops multi_sensor_ops = {
>> +       .get_temp = multi_sensor_get_temp,
>> +};
>> +
>> +int thermal_multi_sensor_validate_coeff(int *coeff, int count, int offset)
>> +{
>> +       int max_accumulated_temp = 0;
>> +       int i;
>> +
>> +       for (i = 0; i < count; i++) {
>> +               max_accumulated_temp += TJ_MAX * coeff[i];
>> +               if (max_accumulated_temp < 0)
>> +                       return -EOVERFLOW;
>> +       }
>> +
>> +       max_accumulated_temp += offset;
>> +       return max_accumulated_temp < 0 ? -EOVERFLOW : 0;
>> +}
>> +
>> +static struct thermal_zone_device *multi_sensor_tz_alloc(const char *name)
>> +{
>> +       struct thermal_zone_device *tz;
>> +       struct thermal_zone_params tzp = {};
>> +       struct multi_sensor_thermal_zone *multi_tz;
>> +
>> +       tz = thermal_zone_get_zone_by_name(name);
>> +       if (!IS_ERR(tz)) {
>> +               mutex_unlock(&multi_tz_mutex);
>> +               return tz;
>> +       }
>> +
>> +       multi_tz = kzalloc(sizeof(*multi_tz), GFP_KERNEL);
>> +       if (!multi_tz)
>> +               return ERR_PTR(-ENOMEM);
>> +       mutex_init(&multi_tz->sensors_lock);
>> +       INIT_LIST_HEAD(&multi_tz->sensors);
>> +
>> +       tzp.no_hwmon = true;
>> +       tzp.slope = 1;
>> +       tzp.offset = 0;
>> +
>> +       tz = thermal_tripless_zone_device_register(name, multi_tz,
>> +                                                  &multi_sensor_ops, &tzp);
>> +       if (IS_ERR(tz)) {
>> +               kfree(multi_tz);
>> +       } else {
>> +               multi_tz->tz = tz;
>> +               list_add(&multi_tz->node, &multi_tz_list);
>> +       }
>> +
>> +       return tz;
>> +}
>> +
>> +int thermal_multi_sensor_register(const char *name,
>> +       struct thermal_zone_device *sensor_tz, int coeff)
>> +{
>> +       struct thermal_zone_device *tz;
>> +       struct multi_sensor_thermal_zone *multi_tz;
>> +       struct sensor_interface *sensor;
>> +
>> +       mutex_lock(&multi_tz_mutex);
>> +
>> +       tz = multi_sensor_tz_alloc(name);
>> +       if (IS_ERR(tz)) {
>> +               mutex_unlock(&multi_tz_mutex);
>> +               return PTR_ERR(tz);
>> +       }
>> +       multi_tz =  tz->devdata;
>> +
>> +       sensor = kzalloc(sizeof(*sensor), GFP_KERNEL);
>> +       if (!sensor) {
>> +               mutex_unlock(&multi_tz_mutex);
>> +               return -ENOMEM;
>> +       }
>> +
>> +       sensor->tz = sensor_tz;
>> +       sensor->coeff = coeff;
>> +       mutex_lock(&multi_tz->sensors_lock);
>> +       list_add(&sensor->node, &multi_tz->sensors);
>> +       mutex_unlock(&multi_tz->sensors_lock);
>> +
>> +       thermal_zone_device_enable(tz);
>> +
>> +       mutex_unlock(&multi_tz_mutex);
>> +
>> +       return 0;
>> +}
>> +
>> +void thermal_multi_sensor_unregister(struct thermal_zone_device *sensor_tz)
>> +{
>> +       struct multi_sensor_thermal_zone *multi_tz;
>> +       struct sensor_interface *sensor, *tmp;
>> +
>> +       mutex_lock(&multi_tz_mutex);
>> +       list_for_each_entry(multi_tz, &multi_tz_list, node) {
>> +               mutex_lock(&multi_tz->sensors_lock);
>> +               list_for_each_entry_safe(sensor, tmp, &multi_tz->sensors, node) {
>> +                       if (sensor->tz == sensor_tz) {
>> +                               list_del(&sensor->node);
>> +                               kfree(sensor);
>> +                               break;
>> +                       }
>> +               }
>> +
>> +               if (list_empty(&multi_tz->sensors)) {
>> +                       thermal_zone_device_unregister(multi_tz->tz);
>> +                       mutex_unlock(&multi_tz->sensors_lock);
>> +                       kfree(multi_tz);
>> +               } else {
>> +                       mutex_unlock(&multi_tz->sensors_lock);
>> +               }
>> +       }
>> +       mutex_unlock(&multi_tz_mutex);
>> +}
>> --
>> 2.41.0
>>
> 
> By the way, may I know why min/max aggregation is dropped in this
> version? I thought that checking max temperature is the most direct
> approach to protect the hardware and the users from high temperature.
You are right. The main reason was device tree bindings.
I was expecting getting this accepted first before adding max and min.

Thanks,
Alexandre
> 
> Best regards,
> Pin-yen

