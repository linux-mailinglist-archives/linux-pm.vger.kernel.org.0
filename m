Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4D924FCA8
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 13:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgHXLfY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 07:35:24 -0400
Received: from foss.arm.com ([217.140.110.172]:60190 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727114AbgHXLeN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 24 Aug 2020 07:34:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ECC4E1063;
        Mon, 24 Aug 2020 04:34:12 -0700 (PDT)
Received: from [10.37.12.65] (unknown [10.37.12.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D50583F66B;
        Mon, 24 Aug 2020 04:34:09 -0700 (PDT)
Subject: Re: [PATCH 2/2] ARM: dts: exynos: Remove interrupts from DMC
 controller in Exynos5422
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, willy.mh.wolff.ml@gmail.com,
        k.konieczny@samsung.com, Chanwoo Choi <cw00.choi@samsung.com>,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        s.nawrocki@samsung.com, kgene@kernel.org
References: <20200708153420.29484-1-lukasz.luba@arm.com>
 <20200708153420.29484-3-lukasz.luba@arm.com>
 <20200817155021.GC15887@kozik-lap>
 <2099aea9-5a63-6e5b-d7f9-4e6476584461@arm.com>
 <CAJKOXPc063m_YcouAO2Q9piJ_GV1Fh9XeS3ZZ3KR=ZyMxPKZ5w@mail.gmail.com>
 <CAJKOXPcfo+1UY2wmy0WhyNRo_KqS7sGb9d8bDskDTOehFZoN5Q@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <7a531591-83e5-2c93-ef61-4154635f761e@arm.com>
Date:   Mon, 24 Aug 2020 12:34:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPcfo+1UY2wmy0WhyNRo_KqS7sGb9d8bDskDTOehFZoN5Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 8/21/20 7:32 AM, Krzysztof Kozlowski wrote:
> On Fri, 21 Aug 2020 at 08:31, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On Mon, 17 Aug 2020 at 19:17, Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>
>>> Hi Krzysztof,
>>>
>>> On 8/17/20 4:50 PM, Krzysztof Kozlowski wrote:
>>>> On Wed, Jul 08, 2020 at 04:34:20PM +0100, Lukasz Luba wrote:
>>>>> The interrupts in Dynamic Memory Controller in Exynos5422 and Odroid
>>>>> XU3-family boards are no longer needed. They have been used in order
>>>>> to workaround some issues in scheduled work in devfreq. Now when the
>>>>> devfreq framework design is improved, remove the interrupt driven
>>>>> approach and rely on devfreq monitoring mechanism with fixed intervals.
>>>>>
>>>>> Reported-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>
>>>>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>>>>> ---
>>>>>    arch/arm/boot/dts/exynos5420.dtsi | 3 ---
>>>>>    1 file changed, 3 deletions(-)
>>>>
>>>> I think the dependencies were merged so this can be safely applied
>>>> without bisectability problems?
>>>
>>> I have created v2 of that fix and it got merged
>>> via Chanwoo's tree, the commit 4fc9a0470d2dc37028
>>> https://lkml.org/lkml/2020/7/10/1048
>>>
>>> That commit switched the driver default mode from 'irq driven' to
>>> new devfreq monitoring mechanism. Furthermore, when the driver is
>>> built as a module, you can try to use the 'irq mode', but for this
>>> you would need the DT IRQs description (this $subject tries to remove).
>>>
>>> I would like to keep this IRQ mode for experimentation, as I
>>> described in answers to Bartek's questions:
>>> https://lkml.org/lkml/2020/7/14/315
>>>
>>> Unfortunately, I am quite busy and won't make any progress before the
>>> LPC.
>>
>> None of these were the actual answer to my question, unless by "v2 of
>> that fix and it got merged" means the dependencies?
>>
>> I'll drop it from the queue. Please resend if it is valid.
> 
> Agh, not drop, I mean postpone for the next cycle (this is v5.11).
> 

Fair enough

Regards,
Lukasz
