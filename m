Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 274682B3C7
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2019 14:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbfE0MAX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 May 2019 08:00:23 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39050 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726063AbfE0MAX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 May 2019 08:00:23 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 36F511BECEA50A9CBE6B;
        Mon, 27 May 2019 20:00:18 +0800 (CST)
Received: from [127.0.0.1] (10.177.19.180) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Mon, 27 May 2019
 20:00:13 +0800
Subject: Re: [PATCH] drivers: base: power: Use of_clk_get_parent_count()
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190525120155.108948-1-wangkefeng.wang@huawei.com>
 <CAMuHMdX=o+gT6fbpZcj8jQbHi9LJci9CX72DG5j+DKYxuSkYvQ@mail.gmail.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <e4918582-2a66-98d1-54ff-13c0a16292b7@huawei.com>
Date:   Mon, 27 May 2019 19:57:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdX=o+gT6fbpZcj8jQbHi9LJci9CX72DG5j+DKYxuSkYvQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.177.19.180]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 2019/5/27 19:08, Geert Uytterhoeven wrote:
> Hi Kefeng,
>
> On Sat, May 25, 2019 at 1:54 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>> Use of_clk_get_parent_count() instead of open coding.
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Thanks for your patch!
>
>> --- a/drivers/base/power/clock_ops.c
>> +++ b/drivers/base/power/clock_ops.c
>> @@ -195,8 +195,7 @@ int of_pm_clk_add_clks(struct device *dev)
>>         if (!dev || !dev->of_node)
>>                 return -EINVAL;
>>
>> -       count = of_count_phandle_with_args(dev->of_node, "clocks",
>> -                                          "#clock-cells");
>> +       count = of_clk_get_parent_count(dev->of_node);
>>         if (count <= 0)
>>                 return -ENODEV;
>
> Given of_clk_get_parent_count() is provided by <linux/of_clk.h>, I think
> you should add an include for that.
Thanks for your kind suggestion, v2 has been sent with the head and your reviewed-by.
>
> With the above fixed:
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Gr{oetje,eeting}s,
>
>                         Geert
>

