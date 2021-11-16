Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 013BB453451
	for <lists+linux-pm@lfdr.de>; Tue, 16 Nov 2021 15:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237383AbhKPOio (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Nov 2021 09:38:44 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:39016 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237484AbhKPOil (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Nov 2021 09:38:41 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UwuY7op_1637073342;
Received: from 30.39.231.61(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UwuY7op_1637073342)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 16 Nov 2021 22:35:42 +0800
Message-ID: <f1d55a78-8910-cfc2-c086-41443ccfa225@linux.alibaba.com>
Date:   Tue, 16 Nov 2021 22:36:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2] power: supply: core: Use library interpolation
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
References: <20211116003844.2133683-1-linus.walleij@linaro.org>
 <4cf76c42-2357-c000-86d7-13b2abf5dcbb@linux.alibaba.com>
 <CACRpkdbVdU0S+cOZfDczxW+pNVDgc54cB75itFi-V9tjHkq-zA@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CACRpkdbVdU0S+cOZfDczxW+pNVDgc54cB75itFi-V9tjHkq-zA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 2021/11/16 21:34, Linus Walleij wrote:
> On Tue, Nov 16, 2021 at 3:28 AM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
> 
>> Thanks for your patch, and overall looks good to me. But I still think
>> we should not do interpolation if the temperature is larger than the
>> maximum value of the table, we can just return the maximum value of the
>> table instead. Something like below untested code, how do you think?
> 
> You are right, but if I understand correctly
> fixp_linear_interpolate() already does what you want,
> perhaps a bit unintuitively. See include/linux/fixp-arith.h:
> 
> static inline int fixp_linear_interpolate(int x0, int y0, int x1, int y1, int x)
> {
>          if (y0 == y1 || x == x0)
>                  return y0;
>          if (x1 == x0 || x == x1)
>                  return y1;
> 
>          return y0 + ((y1 - y0) * (x - x0) / (x1 - x0));
> }
> 

Sorry for confusing, let me try to make it clear. Suppose we have a 
temperature table as below, and try to get the resistance percent in the 
temp=-20 Celsius.

resistance-temp-table = <20 100>, <10 90>, <0 80>, <(-10) 60>;

With your patch, we will get i=table_len-1, which is 3. Then high=2 and 
low=3.

+	for (i = 0; i < table_len - 1; i++)
  		if (temp > table[i].temp)
  			break;

So in fixp_linear_interpolate(): x0=-10, y0=60, x1=0, y1=80, x=-20, then 
will return 60 + (80-60)*(-20-(-10))/(0-(-10)) = 40.

But actually the -20 Celsius is less than (-10), which is the last 
member in the array, we do not need the interpolation, return 60 
directly if I understand correctly. Which means for any other lower 
temperature points, the resistance of the baterry is always 60% of the 
battery internal resistence in normal temperature.
