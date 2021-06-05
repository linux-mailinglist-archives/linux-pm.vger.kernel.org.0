Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C31039C4A0
	for <lists+linux-pm@lfdr.de>; Sat,  5 Jun 2021 02:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhFEAuN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Jun 2021 20:50:13 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3431 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhFEAuN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Jun 2021 20:50:13 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FxgsJ1q7fz6tnc;
        Sat,  5 Jun 2021 08:45:24 +0800 (CST)
Received: from dggemi762-chm.china.huawei.com (10.1.198.148) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 5 Jun 2021 08:48:24 +0800
Received: from [10.174.178.208] (10.174.178.208) by
 dggemi762-chm.china.huawei.com (10.1.198.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sat, 5 Jun 2021 08:48:23 +0800
Subject: Re: [PATCH -next] power: reset/supply: add missing
 MODULE_DEVICE_TABLE
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1620896701-53542-1-git-send-email-zou_wei@huawei.com>
 <20210604110221.ykclr6yxlw3nflug@earth.universe>
From:   Samuel Zou <zou_wei@huawei.com>
Message-ID: <527f34eb-364f-ac4c-a918-610d8f2cd190@huawei.com>
Date:   Sat, 5 Jun 2021 08:48:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20210604110221.ykclr6yxlw3nflug@earth.universe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.208]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggemi762-chm.china.huawei.com (10.1.198.148)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Sebastian,

Thanks for your review, I will split the patch into three and resend soon.
On 2021/6/4 19:02, Sebastian Reichel wrote:
> Hi,
> 
> On Thu, May 13, 2021 at 05:05:01PM +0800, Zou Wei wrote:
>> This patch adds missing MODULE_DEVICE_TABLE definition which generates
>> correct modalias for automatic loading of this driver when it is built
>> as an external module.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Zou Wei <zou_wei@huawei.com>
>> ---
> 
> Does not apply anymore. Also please split this into three patches,
> one for regulator-poweroff, one for ab8500 and one for
> charger-manager.
> 
> Thanks,
> 
> -- Sebastian
> 
>>   drivers/power/reset/regulator-poweroff.c | 1 +
>>   drivers/power/supply/ab8500_btemp.c      | 1 +
>>   drivers/power/supply/ab8500_charger.c    | 1 +
>>   drivers/power/supply/ab8500_fg.c         | 1 +
>>   drivers/power/supply/charger-manager.c   | 1 +
>>   5 files changed, 5 insertions(+)
>>
