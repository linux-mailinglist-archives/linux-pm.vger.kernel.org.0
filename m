Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6FC3D50DB
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jul 2021 03:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbhGZAgN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Jul 2021 20:36:13 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:7979 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhGZAgN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Jul 2021 20:36:13 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.1]) by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee560fe0cd2f1f-8179d; Mon, 26 Jul 2021 09:16:02 +0800 (CST)
X-RM-TRANSID: 2ee560fe0cd2f1f-8179d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [192.168.26.114] (unknown[10.42.68.12])
        by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee160fe0cc2ed1-07f73;
        Mon, 26 Jul 2021 09:16:02 +0800 (CST)
X-RM-TRANSID: 2ee160fe0cc2ed1-07f73
Subject: Re: [PATCH] power: supply: qcom_smbb: Remove superfluous errormessage
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     agross@kernel.org, sre@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
References: <20210720141539.7716-1-tangbin@cmss.chinamobile.com>
 <YPbxS4KV+Fx01p7G@yoga>
From:   tangbin <tangbin@cmss.chinamobile.com>
Message-ID: <f6a40fef-deac-e898-7cac-d9d246c84a24@cmss.chinamobile.com>
Date:   Mon, 26 Jul 2021 09:16:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <YPbxS4KV+Fx01p7G@yoga>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi, Bjorn Andersson:

On 2021/7/20 23:52, Bjorn Andersson wrote:
> On Tue 20 Jul 09:15 CDT 2021, Tang Bin wrote:
>
>> In the probe function, when get irq failed, the function
>> platform_get_irq_byname() logs an error message, so remove
>> redundant message here.
>>
>> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
>> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> This says "Zhang certified this patch's origin, then you took the patch
> and you certified it's origin" - per Documentation/process/submitting-patches.rst
>
> But you, Tang, is the author or the patch, so how can Zhang have touched
> it before you wrote it?
>
> Perhaps you worked on it together? In which case you should include a
> Co-developed-by to indicate this.

I am sorry for the late reply to your email due to some reasons. The 
correct way to write it should be as follows:

     Co-developed-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>

     Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>

     Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>

>
>
> Both commit message and patch looks good though!
>
whether should I send v2 for this patch？

Thanks

Tang Bin

>> ---
>>   drivers/power/supply/qcom_smbb.c | 5 +----
>>   1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/drivers/power/supply/qcom_smbb.c b/drivers/power/supply/qcom_smbb.c
>> index c890e1cec..84cc9fba0 100644
>> --- a/drivers/power/supply/qcom_smbb.c
>> +++ b/drivers/power/supply/qcom_smbb.c
>> @@ -929,11 +929,8 @@ static int smbb_charger_probe(struct platform_device *pdev)
>>   		int irq;
>>   
>>   		irq = platform_get_irq_byname(pdev, smbb_charger_irqs[i].name);
>> -		if (irq < 0) {
>> -			dev_err(&pdev->dev, "failed to get irq '%s'\n",
>> -				smbb_charger_irqs[i].name);
>> +		if (irq < 0)
>>   			return irq;
>> -		}
>>   
>>   		smbb_charger_irqs[i].handler(irq, chg);
>>   
>> -- 
>> 2.20.1.windows.1
>>
>>
>>


