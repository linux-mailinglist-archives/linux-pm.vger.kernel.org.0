Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766A541A48B
	for <lists+linux-pm@lfdr.de>; Tue, 28 Sep 2021 03:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238396AbhI1BXU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Sep 2021 21:23:20 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:44206 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234467AbhI1BXU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Sep 2021 21:23:20 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.17]) by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee161526e0e567-e5277; Tue, 28 Sep 2021 09:21:19 +0800 (CST)
X-RM-TRANSID: 2ee161526e0e567-e5277
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [192.168.26.114] (unknown[10.42.68.12])
        by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee961526e0e458-409f4;
        Tue, 28 Sep 2021 09:21:19 +0800 (CST)
X-RM-TRANSID: 2ee961526e0e458-409f4
Subject: Re: [PATCH] power: supply: cpcap-battery: remove redundant check
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>
References: <20210819121137.11928-1-tangbin@cmss.chinamobile.com>
 <20210927154658.mjrmbtu455cbprun@earth.universe>
From:   tangbin <tangbin@cmss.chinamobile.com>
Message-ID: <a102d4e0-f142-4c4f-4d9d-812075c0214f@cmss.chinamobile.com>
Date:   Tue, 28 Sep 2021 09:21:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20210927154658.mjrmbtu455cbprun@earth.universe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi, Reichel

On 2021/9/27 23:46, Sebastian Reichel wrote:
> NAK. Instead replace the complate of_match_device() part. The driver
> only needs the data object and there is of_device_get_match_data()
> for this. Also - even better - there is a non-DT specific variant
> which is device_get_match_data(). Please use that:
>
>
> const struct cpcap_battery_config *cfg = device_get_match_data(&pdev->dev);
> if (!cfg)
>      return -ENODEV;
>
> memcpy(&ddata->config, cfg, sizeof(ddata->config));
>
Got it. Before this patch, I thought it would be better to use 
of_device_get_match_data()

to simplify for this place, but your email made me learn it again. I 
will send patch v2 for

you.

Thanks

Tang Bin

>
>>   drivers/power/supply/cpcap-battery.c | 6 ------
>>   1 file changed, 6 deletions(-)
>>
>> diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
>> index 8d62d4241..a3866826b 100644
>> --- a/drivers/power/supply/cpcap-battery.c
>> +++ b/drivers/power/supply/cpcap-battery.c
>> @@ -1035,12 +1035,6 @@ static int cpcap_battery_probe(struct platform_device *pdev)
>>   	if (!match)
>>   		return -EINVAL;
>>   
>> -	if (!match->data) {
>> -		dev_err(&pdev->dev, "no configuration data found\n");
>> -
>> -		return -ENODEV;
>> -	}
>> -
>>   	ddata = devm_kzalloc(&pdev->dev, sizeof(*ddata), GFP_KERNEL);
>>   	if (!ddata)
>>   		return -ENOMEM;
>> -- 
>> 2.20.1.windows.1
>>
>>
>>


