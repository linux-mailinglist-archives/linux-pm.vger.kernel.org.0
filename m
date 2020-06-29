Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08AA20D144
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jun 2020 20:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgF2Sj5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jun 2020 14:39:57 -0400
Received: from foss.arm.com ([217.140.110.172]:35140 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726607AbgF2Sj4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 29 Jun 2020 14:39:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C49F142F;
        Mon, 29 Jun 2020 04:34:26 -0700 (PDT)
Received: from [10.37.12.67] (unknown [10.37.12.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 40DA23F73C;
        Mon, 29 Jun 2020 04:34:22 -0700 (PDT)
Subject: Re: brocken devfreq simple_ondemand for Odroid XU3/4?
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Kamil Konieczny <k.konieczny@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Willy Wolff <willy.mh.wolff.ml@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200623164733.qbhua7b6cg2umafj@macmini.local>
 <CAJKOXPeLuq81NC2xZh3y32EB-_APbDAchZD4OW_eCgQKKO+p8w@mail.gmail.com>
 <20200623191129.GA4171@kozik-lap>
 <CGME20200624103308eucas1p188a5fe3cee1916d9430c9971c2dab3a3@eucas1p1.samsung.com>
 <85f5a8c0-7d48-f2cd-3385-c56d662f2c88@arm.com>
 <ef5184ed-00ff-4226-5ece-b0fc8eb16fb6@samsung.com>
 <4a72fcab-e8da-8323-1fbe-98a6a4b3e0f1@arm.com>
 <4c3b01af-2337-1eba-4675-6488105144c8@samsung.com>
 <6f8b1119-62b1-942d-cfde-6f1e9a28c40c@arm.com>
 <ee2e4acb-3986-3227-da1f-177d2756d194@samsung.com>
 <ad4e1a73-6de3-68ee-e3b3-b30bc315bd31@samsung.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <ea7d70e2-3306-07a0-c741-3dc3558efbaf@arm.com>
Date:   Mon, 29 Jun 2020 12:34:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ad4e1a73-6de3-68ee-e3b3-b30bc315bd31@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 6/26/20 12:22 PM, Bartlomiej Zolnierkiewicz wrote:
> 
> On 6/25/20 2:12 PM, Kamil Konieczny wrote:
>> On 25.06.2020 14:02, Lukasz Luba wrote:
>>>
>>>
>>> On 6/25/20 12:30 PM, Kamil Konieczny wrote:

[snip]

>>>
>>> Kamil do you have plans to refresh and push your next version of the
>>> workqueue solution?
>>
>> I do not, as Bartek takes over my work,
>> +CC Bartek
> 
> Hi Lukasz,

Hi Bartek,

> 
> As you remember in January Chanwoo has proposed another idea (to allow
> selecting workqueue type by devfreq device driver):
> 
> "I'm developing the RFC patch and then I'll send it as soon as possible."
> (https://lore.kernel.org/linux-pm/6107fa2b-81ad-060d-89a2-d8941ac4d17e@samsung.com/)
> 
> "After posting my suggestion, we can discuss it"
> (https://lore.kernel.org/linux-pm/f5c5cd64-b72c-2802-f6ea-ab3d28483260@samsung.com/)
> 
> so we have been waiting on the patch to be posted..
> 
> Similarly we have been waiting on (any) feedback for exynos-bus/nocp
> fixes for Exynos5422 support (which have been posted by Kamil also in
> January):
> 
> https://lore.kernel.org/linux-pm/8f82d8d5-927b-afb4-272f-45c16b5a23b9@samsung.com/
> 
> Considering the above and how hard it has been to push the changes
> through review/merge process last year we are near giving up when it
> comes to upstream devfreq contributions. Sylwester is still working on
> exynos-bus & interconnect integration (continuation of Artur Swigon's
> work from last year) & related issues (IRQ support for PPMU)  but
> I'm seriously considering putting it all on-hold..

Thank you for detailed explanation and update. I see. Anyway, if you or
Sylwester need some help with this devfreq workqueue, I offer my time
as a reviewer&tester.

The more generic solution you propose, the better for all platforms.

Regards,
Lukasz

> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 
