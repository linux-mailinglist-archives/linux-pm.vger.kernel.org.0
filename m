Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A722BE7EBB
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 04:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731202AbfJ2DJM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Oct 2019 23:09:12 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58184 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730831AbfJ2DJL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 28 Oct 2019 23:09:11 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BFB39DF489B2BDBFAD2F;
        Tue, 29 Oct 2019 11:09:08 +0800 (CST)
Received: from [127.0.0.1] (10.133.219.218) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Tue, 29 Oct 2019
 11:09:07 +0800
Message-ID: <5DB7AD52.7090104@huawei.com>
Date:   Tue, 29 Oct 2019 11:09:06 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Sebastian Reichel <sre@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] power: supply: cpcap-charger: Make cpcap_charger_voltage_to_regval
 static
References: <1571672407-58950-1-git-send-email-zhongjiang@huawei.com> <5DB71465.6050203@huawei.com> <20191028215615.3efezzsc5gji722q@earth.universe>
In-Reply-To: <20191028215615.3efezzsc5gji722q@earth.universe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.219.218]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sorry,  I forget that.

Thanks,
zhogn jiang
On 2019/10/29 5:56, Sebastian Reichel wrote:
> Hi,
>
> https://lkml.org/lkml/2019/10/21/1018
>
> That's e3da2ce04e12 to be specific.
>
> -- Sebastian
>
> On Tue, Oct 29, 2019 at 12:16:37AM +0800, zhong jiang wrote:
>> ping.
>>
>> On 2019/10/21 23:40, zhong jiang wrote:
>>> The GCC complains the following case when compiling kernel.
>>>
>>> drivers/power/supply/cpcap-charger.c:563:5: warning: symbol 'cpcap_charger_voltage_to_regval' was not declared. Should it be static?
>>>
>>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>>> ---
>>>  drivers/power/supply/cpcap-charger.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
>>> index 40d96b8..c0d452e 100644
>>> --- a/drivers/power/supply/cpcap-charger.c
>>> +++ b/drivers/power/supply/cpcap-charger.c
>>> @@ -560,7 +560,7 @@ static void cpcap_charger_update_state(struct cpcap_charger_ddata *ddata,
>>>  	dev_dbg(ddata->dev, "state: %s\n", status);
>>>  }
>>>  
>>> -int cpcap_charger_voltage_to_regval(int voltage)
>>> +static int cpcap_charger_voltage_to_regval(int voltage)
>>>  {
>>>  	int offset;
>>>  
>>


