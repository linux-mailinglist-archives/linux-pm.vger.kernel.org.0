Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29FE11A7B17
	for <lists+linux-pm@lfdr.de>; Tue, 14 Apr 2020 14:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502196AbgDNMpw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Apr 2020 08:45:52 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2372 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2502186AbgDNMo1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 14 Apr 2020 08:44:27 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 58616FD388CDC3E825D6;
        Tue, 14 Apr 2020 20:43:56 +0800 (CST)
Received: from [127.0.0.1] (10.74.173.6) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Tue, 14 Apr 2020
 20:43:55 +0800
Subject: Re: [PATCH V2 2/2] MAINTAINERS: Add maintainers for kunpeng thermal
To:     Amit Kucheria <amit.kucheria@verdurent.com>
References: <1584363301-15858-1-git-send-email-shenyang39@huawei.com>
 <1584363301-15858-3-git-send-email-shenyang39@huawei.com>
 <CAHLCerPJGdb8dx_8UMAricfL6LwEW4zYJdg-R11V=ggvZo10vw@mail.gmail.com>
CC:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>
From:   "shenyang (M)" <shenyang39@huawei.com>
Message-ID: <a8563450-c922-eea4-67cc-314183b8ee8d@huawei.com>
Date:   Tue, 14 Apr 2020 20:43:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CAHLCerPJGdb8dx_8UMAricfL6LwEW4zYJdg-R11V=ggvZo10vw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.74.173.6]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 2020/4/7 18:08, Amit Kucheria wrote:
> On Mon, Mar 16, 2020 at 6:25 PM Yang Shen <shenyang39@huawei.com> wrote:
>>
>> Add Yang Shen and Zhou Wang as maintainers for kunpeng thermal
>>
>> Signed-off-by: Yang Shen <shenyang39@huawei.com>
>> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
>
> Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
>

Okay, thanks!

>> ---
>>  MAINTAINERS | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index cc1d18c..b7d4af4 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -7602,6 +7602,13 @@ F:       drivers/crypto/hisilicon/sgl.c
>>  F:     drivers/crypto/hisilicon/zip/
>>  F:     Documentation/ABI/testing/debugfs-hisi-zip
>>
>> +HISILICON KUNPENG TSENSOR DRIVER
>> +M:     Yang Shen <shenyang39@huawei.com>
>> +M:     Zhou Wang <wangzhou1@hisilicon.com>
>> +L:     linux-pm@vger.kernel.org
>> +S:     Maintained
>> +F:     drivers/thermal/kunpeng_thermal.c
>> +
>>  HMM - Heterogeneous Memory Management
>>  M:     Jérôme Glisse <jglisse@redhat.com>
>>  L:     linux-mm@kvack.org
>> --
>> 2.7.4
>>
>
>

