Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31C14659CE
	for <lists+linux-pm@lfdr.de>; Thu,  2 Dec 2021 00:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244944AbhLAXb0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Dec 2021 18:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240449AbhLAXb0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Dec 2021 18:31:26 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723B1C061574
        for <linux-pm@vger.kernel.org>; Wed,  1 Dec 2021 15:28:04 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id r26so66970959lfn.8
        for <linux-pm@vger.kernel.org>; Wed, 01 Dec 2021 15:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wirenboard-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=LeyEF1zcSCFvkWnHQ8wu4JHy/Zqkfo33MAcKgNTAK/E=;
        b=aVuWwiQyh7ZSoUp8jnZSxwKMrHJDz5nRlYjzLpGtAxPbv7e/Zz3j8CYORWQLxnh/yI
         C9zABzlOJcTqCW78rw0dEOW/9DeIWMWYrN3vk8al+OoyqGmPdppWj0Hi0zc33DNzLA+z
         ZJq6xjMO4E3CL11N0J1ZK+iErbHrMlmuEm4zOaW3C/0LnAzKpz5+oGfMvhmsEbGJ8hkw
         8UAbjLmrLeMwgQT/SMZRXoSWaux3YL6gRJ7LtH9LNgdE/RxZ6z8kX8jDPs7oBztoFftt
         mD7Q8RAXSyXO4scUHLNAk9ea3XH+0nNy78RNgMnY0LD8tX9UqvJVwi3pwlT1FXPB7gpx
         fDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=LeyEF1zcSCFvkWnHQ8wu4JHy/Zqkfo33MAcKgNTAK/E=;
        b=DkcSaUZ+Htmhz5qnG7SNlcQuO5R1YV4IiR8shsFwMEc0uV8cdMHj3MxyLNYtQSXSBg
         bk4sJkimkbnOu1RoJvkasXe8jWRqJpcRrL9YcGCunXP1bTAtG/U1ngwuWJ4adMTeeNM0
         nFfbno4BZB3AVAUeQgRBj+1LcqiYGYvvppZt8/1Rfyr0efn56PE+PQ1PfxvpOFPsynQP
         7buFwDGcM1QigKGc1eXrfJFOXHZ8IfB7UfBi9mL39PsBa4CXexa9Ep2WT8xqyQuHmMas
         H94InVgyHx35HMyZQv4gcxZi619vYrJdyi5k5f1qtXop6v/4Y2J94M8fjSZFy74cpFu6
         rmEw==
X-Gm-Message-State: AOAM530aPRosu89cu+JIy8E1F7thMIKaHY/55TtuzTompxIbe7suUipo
        scxMw1PBVRM5bGlqMhsp3nNsXhZ2wBbOtA==
X-Google-Smtp-Source: ABdhPJxxCsdpj9pYR1QKLPUT8OMOyNtB7lCq6wQZcopIKtYNcV2e0DBUxlD/1ZxYfuXqIhI4XqTieQ==
X-Received: by 2002:a05:6512:3d10:: with SMTP id d16mr8451558lfv.78.1638401282667;
        Wed, 01 Dec 2021 15:28:02 -0800 (PST)
Received: from [192.168.1.213] (81.5.99.121.dhcp.mipt-telecom.ru. [81.5.99.121])
        by smtp.googlemail.com with ESMTPSA id u23sm131850lfo.35.2021.12.01.15.28.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 15:28:02 -0800 (PST)
Subject: Re: [PATCH] power: supply: axp20x_battery: set charging voltage via
 DT
To:     Quentin Schulz <foss@0leil.net>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>,
        Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
References: <20211119175740.405446-1-boger@wirenboard.com>
 <20211201175728.ja7a5iilm23vyblr@fiqs>
From:   Evgeny Boger <boger@wirenboard.com>
Message-ID: <5bb5f0a6-17c5-ea1a-dbed-82c7d1317640@wirenboard.com>
Date:   Thu, 2 Dec 2021 02:28:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211201175728.ja7a5iilm23vyblr@fiqs>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Quentin,
again, thank you for the feedback!

01.12.2021 20:57, Quentin Schulz пишет:
> Hi Evgeny,
>
> On Fri, Nov 19, 2021 at 08:57:40PM +0300, Evgeny Boger wrote:
>> The driver should use maximum constant charge voltage property
>> from battery description provided by power supply core by default
>> instead of fixed 4.2V. This value can be later changed at runtime.
>>
>> The battery description is normally set via device tree, as described
>> in Documentation/devicetree/bindings/power/supply/battery.yaml
>>
>> Signed-off-by: Evgeny Boger <boger@wirenboard.com>
>> ---
>>   drivers/power/supply/axp20x_battery.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
>> index 18a9db0df4b1..83c5ffa24bd1 100644
>> --- a/drivers/power/supply/axp20x_battery.c
>> +++ b/drivers/power/supply/axp20x_battery.c
>> @@ -617,6 +617,12 @@ static int axp20x_power_probe(struct platform_device *pdev)
>>   	if (!power_supply_get_battery_info(axp20x_batt->batt, &info)) {
>>   		int vmin = info.voltage_min_design_uv;
>>   		int ccc = info.constant_charge_current_max_ua;
>> +		int vcv = info.constant_charge_voltage_max_uv;
>> +
>> +		if (vcv > 0 && axp20x_batt->data->set_max_voltage(axp20x_batt,
>> +								  vcv))
>> +			dev_err(&pdev->dev,
>> +				"couldn't set charge constant voltage from DT");
>>   
> The issue here is that only specific values are possible. e.g. for
> axp20x: 4.1 4.15 4.2V, axp22x 4.1 4.2V, there's nothing in-between.
>
> I don't think the battery node should know what the PMIC is capable of
> outputting.
Well, in a sense it should. I mean a hardware designer for sure would 
design a board in a way
that a battery and PMIC are compatible. So it would be strange to 
declare an unsupported charging
voltage in battery node.
>
> Would it make sense to find the closest value to the one appropriate for
> the battery that is supported by the PMIC (lesser or equal to the one
> specified by the battery obviously)?
but yes, I think it makes sense. Probably the same should work for 
userspace too.
By the way, I've just realized that the driver probably uses 
POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN
incorrectly to set charging voltage. I think it should be 
POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE
instead?

>
> Otherwise, I would imagine this function would fail most of the time
> because it's not the exact voltage supported by the PMIC?
>
> Completely off-topic, but I also see that batteries now support
> specifying which technology they use so it should be safe to raise the
> maximum for some technologies above what we currently support in the
> driver. e.g. axp22x supports 4.22 and 4.24V too but they aren't
> selectable at the moment.
well, they are all lithium-ion. Even the ones with 4.35V are 
lithium-ion, just a better quality ones.
And then, on the other hand, at wirenboard we limit the charging voltage 
to 4.1V on perfectly 4.2V-capable battery
to prolong the battery lifetime in exchange for some available capacity.

So I think not supporting voltages higher than 4.2V in PMIC is a bit 
strange. I think it's better not to allow setting
the voltage higher than battery maximum via userspace, but it should be 
allowed to set whatever voltage the board
designer want via the device tree.

>
> Cheers,
> Quentin


-- 
С уважением,
     Евгений Богер / Evgeny Boger
     CTO, Wiren Board Team
     https://wirenboard.com/ru
     +7 495 150 66 19 (# 33)

