Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 883F086237
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2019 14:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732524AbfHHMs2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 08:48:28 -0400
Received: from foss.arm.com ([217.140.110.172]:32848 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727522AbfHHMs2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Aug 2019 08:48:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BE6115A2;
        Thu,  8 Aug 2019 05:48:27 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E029C3F694;
        Thu,  8 Aug 2019 05:48:25 -0700 (PDT)
Subject: Re: [PATCH v2 3/9] soc: samsung: Add Exynos Adaptive Supply Voltage
 driver
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     devicetree@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-pm@vger.kernel.org,
        pankaj.dubey@samsung.com,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        robh+dt@kernel.org, kgene@kernel.org, vireshk@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <CGME20190718143130eucas1p26f2058f47eb2f4020e1ddbf1619d1ac8@eucas1p2.samsung.com>
 <20190718143044.25066-1-s.nawrocki@samsung.com>
 <20190718143044.25066-4-s.nawrocki@samsung.com>
 <CAJKOXPeOfDHjqSotxVwVuy+6r9X3Q8ZXLit1_=gGd7bOwkHupA@mail.gmail.com>
 <a56fe2d8-1f26-b462-1564-f23902f7dbb5@samsung.com>
 <CAJKOXPc8iFo=2JAGEZSC46N3sZae4+JcZYBCjpKysb6PFPzyaQ@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <669c6b25-eb7e-ed3a-72a2-ee155a568363@arm.com>
Date:   Thu, 8 Aug 2019 13:48:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAJKOXPc8iFo=2JAGEZSC46N3sZae4+JcZYBCjpKysb6PFPzyaQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08/08/2019 13:31, Krzysztof Kozlowski wrote:
> On Thu, 8 Aug 2019 at 14:07, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
>>>> +static unsigned int exynos5422_asv_parse_table(struct exynos_asv *asv,
>>>> +                                     unsigned int pkg_id)
>>>> +{
>>>> +       return (pkg_id >> EXYNOS5422_TABLE_OFFSET) & EXYNOS5422_TABLE_MASK;
>>>> +}
>>>> +
>>>> +static bool exynos5422_asv_parse_bin2(struct exynos_asv *asv,
>>>> +                                    unsigned int pkg_id)
>>>> +{
>>>> +       return (pkg_id >> EXYNOS5422_BIN2_OFFSET) & EXYNOS5422_BIN2_MASK;
>>>
>>> return !!() for converting to boolean.
>>
>> I'm not convinced it is needed, the return type of the function is bool
>> and value of the expression will be implicitly converted to that type.
>> Is there any compiler warning related to that?
> 
> Yeah, but bool is int so there will be no implicit conversion... I
> guess it is a convention. In theory !! is the proper conversion to
> bool but if bool==int then it's essentially conversion to 1. I am not
> sure what's the benefit, maybe for some wrong code which would do
> comparisons on result like if (exynos5422_asv_parse_bin2() == TRUE)...

Not so - since we use "-std=gnu89", we have C99-like _Bool, which our 
bool is a typedef of. Conversions, either implicit or explicit, are 
well-defined:

"6.3.1.2 Boolean type

When any scalar value is converted to _Bool, the result is 0 if the 
value compares equal
to 0; otherwise, the result is 1."

This is even called out in Documentation/process/coding-style.rst:

"When using bool types the !! construction is not needed, which 
eliminates a class of bugs."

Robin.
