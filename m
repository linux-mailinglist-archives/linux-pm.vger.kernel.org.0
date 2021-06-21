Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA9D3AF6F4
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 22:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbhFUUrz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Jun 2021 16:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbhFUUry (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jun 2021 16:47:54 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07C0C061574;
        Mon, 21 Jun 2021 13:45:39 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id d2so27107726ljj.11;
        Mon, 21 Jun 2021 13:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0iM1rcn8Jisd8pKDl/vHL/liKFppMqrlx8DH3/0iSFE=;
        b=NQYaIRIpU3xVFXMHRegz7Ogy61wDaesDskEoy9xhcp8ASnjwfnGlKRUNFgShXMPepU
         +Dx1GIWPkua8mvOWzH7+6POD35BnEC3UrjoHfE0Ge0Tbh94IoNIwWTNJFZXg2rW49kSA
         AxOXH86fwmPfc1tMvtoCiYO3eJYnAi20tCCkoOE14AVfi2dqnsI7cc5vLxi/E0XnyIDP
         DmjyYSEVrHVMFFptly/r8qILzhJgw//5JScwHngy+yNrxOWACENQbI/51ydYBIbZBr7z
         fKPcDzemqODVO2w2ZDBsFiFn8PXH8jL9nu0GrexuQlqUkSuggAIG5sEOH7iNRJP1S4N7
         wguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0iM1rcn8Jisd8pKDl/vHL/liKFppMqrlx8DH3/0iSFE=;
        b=MD17CSJAg9qHhO3aa6HijPguiCspiEe94lpzpiNBQvEP1V081oQot0VLeciTnTJi0H
         idFt284ZwqQRB+5B7XAOxAaPqWKhiNNB7KcELz9L7++k8Dh5zqozHDMvqsT5hHXnH/ds
         mDoSxidbjXPZT9q/9vjT0GBVDDX4n9ydgvCJ/379vjQNqirHovMoFqwCAJacQ0C4PIX+
         p1Ea3Ah6xCOxek5EbXYyNX3ZEQDCHuZlAz3DQNFPUhB0fmbgkY9bKHv6b0B59BQ39yT8
         KPjYPuW3/u+uxPqeK4q1ffZG8ZYT0xaw+WhZZxngS6PmUUAXhrI1BSq0Ux8CfulVriAG
         UFkw==
X-Gm-Message-State: AOAM530Txa0uR62y0l/2Ysn0F3qv0uZvn74/0j3szTFgRNDs1V8o9nRX
        jyFB9v9I5S7JVDFK8DkS3ovW94Ck7sQ=
X-Google-Smtp-Source: ABdhPJyEpCz5QJdXKSLI99NZmSbwn8fnV7uSLmIJCbcoogDF1r7MamhETzRZRPnZ6bHCoBq8deODfA==
X-Received: by 2002:a05:651c:283:: with SMTP id b3mr99060ljo.12.1624308337970;
        Mon, 21 Jun 2021 13:45:37 -0700 (PDT)
Received: from [192.168.2.145] (94-29-29-31.dynamic.spd-mgts.ru. [94.29.29.31])
        by smtp.googlemail.com with ESMTPSA id y5sm1978428lfa.148.2021.06.21.13.45.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 13:45:37 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] hwmon: Support set_trips() of thermal device ops
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20210621184058.4110-1-digetx@gmail.com>
 <20210621184058.4110-3-digetx@gmail.com>
 <20210621203044.GA631670@roeck-us.net>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f3ea4b2d-ee84-6e28-5136-276163369497@gmail.com>
Date:   Mon, 21 Jun 2021 23:45:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210621203044.GA631670@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

21.06.2021 23:30, Guenter Roeck пишет:
> On Mon, Jun 21, 2021 at 09:40:58PM +0300, Dmitry Osipenko wrote:
>> Support set_trips() callback of thermal device ops. This allows HWMON
>> device to operatively notify thermal core about temperature changes, which
>> is very handy to have in a case where HWMON sensor is used by CPU thermal
>> zone that performs passive cooling and emergency shutdown on overheat.
>> Thermal core will be able to react faster to temperature changes.
>>
> 
> I think that warrants an explanation why it doesn't matter if the
> code doesn't really set any trip points.

I'll extend the commit message.

>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/hwmon/hwmon.c | 32 ++++++++++++++++++++++++++++++++
>>  1 file changed, 32 insertions(+)
>>
>> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
>> index fd47ab4e6892..e74dc81e650d 100644
>> --- a/drivers/hwmon/hwmon.c
>> +++ b/drivers/hwmon/hwmon.c
>> @@ -153,8 +153,40 @@ static int hwmon_thermal_get_temp(void *data, int *temp)
>>  	return 0;
>>  }
>>  
>> +static int hwmon_thermal_set_trips(void *data, int low, int high)
>> +{
>> +	struct hwmon_thermal_data *tdata = data;
>> +	struct hwmon_device *hwdev = to_hwmon_device(tdata->dev);
>> +	const struct hwmon_chip_info *chip = hwdev->chip;
>> +	const struct hwmon_channel_info **info = chip->info;
>> +	unsigned int i;
>> +
>> +	if (!chip->ops->write)
>> +		return 0;
>> +
>> +	for (i = 1; info[i] && info[i]->type != hwmon_temp; i++)
>> +		continue;
> 
> Why start with index 1 ? While index 0 is commonly used for chip data,
> that is not mandatory.

This is borrowed from hwmon_thermal_register_sensors().

>> +
>> +	if (info[i] && info[i]->config[tdata->index] & HWMON_T_MIN) {
>> +		int err = chip->ops->write(tdata->dev, hwmon_temp,
>> +					   hwmon_temp_min, tdata->index, low);
> 
> checkpatch will complain here because it expects an empty line after a
> declaration. Since err is used in multiple conditionals, I would suggest
> to declare it once in the function header.

Okay, although checkpatch is happy.

./scripts/checkpatch.pl --strict v3*
---------------------------------------------------------------
v3-0001-hwmon-lm90-Prevent-integer-underflows-of-temperat.patch
---------------------------------------------------------------
total: 0 errors, 0 warnings, 0 checks, 27 lines checked

v3-0001-hwmon-lm90-Prevent-integer-underflows-of-temperat.patch has no
obvious style problems and is ready for submission.
-----------------------------------------------------------
v3-0002-hwmon-Support-set_trips-of-thermal-device-ops.patch
-----------------------------------------------------------
total: 0 errors, 0 warnings, 0 checks, 40 lines checked

>> +		if (err < 0 && err != -EOPNOTSUPP)
> 
> "< 0" is unnecessary.
> 
>> +			return err;
>> +	}
>> +
>> +	if (info[i] && info[i]->config[tdata->index] & HWMON_T_MAX) {
>> +		int err = chip->ops->write(tdata->dev, hwmon_temp,
>> +					   hwmon_temp_max, tdata->index, high);
>> +		if (err < 0 && err != -EOPNOTSUPP)
> 
> "< 0" is unnecessary.

I'll remove it in v4.
