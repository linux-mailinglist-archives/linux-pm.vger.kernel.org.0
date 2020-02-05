Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D899153110
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2020 13:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgBEMt5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Feb 2020 07:49:57 -0500
Received: from foss.arm.com ([217.140.110.172]:46778 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbgBEMt4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Feb 2020 07:49:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 057631FB;
        Wed,  5 Feb 2020 04:49:56 -0800 (PST)
Received: from [10.37.12.130] (unknown [10.37.12.130])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DB2D3F52E;
        Wed,  5 Feb 2020 04:49:34 -0800 (PST)
Subject: Re: [PATCH 3/3] ARM: exynos_defconfig: Enable Energy Model framework
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kgene@kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        Chanwoo Choi <cw00.choi@samsung.com>, robh+dt@kernel.org,
        mark.rutland@arm.com,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>, dietmar.eggemann@arm.com
References: <20200127215453.15144-1-lukasz.luba@arm.com>
 <20200127215453.15144-4-lukasz.luba@arm.com>
 <CAJKOXPeA=_3zPx6Aq3CAUi7JsXr9AigWGWCTNWo_jkm=oVWe_g@mail.gmail.com>
 <db3f2554-288d-81ab-2373-1447367ba673@arm.com>
 <20200131204118.GA27284@kozik-lap>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <c54e252d-dc55-5fa3-f97f-643d7efbfdc1@arm.com>
Date:   Wed, 5 Feb 2020 12:49:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200131204118.GA27284@kozik-lap>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof,

On 1/31/20 8:41 PM, Krzysztof Kozlowski wrote:
> On Fri, Jan 31, 2020 at 05:30:46PM +0000, Lukasz Luba wrote:
>   
>>>
>>>>                   |-----------------------------------------------|---------------
>>>>                   | performance   | SchedUtil     | SchedUtil     | performance
>>>>                   | governor      | governor      | governor      | governor
>>>>                   |               | w/o EAS       | w/ EAS        |
>>>> ----------------|---------------|---------------|---------------|---------------
>>>> hackbench w/ PL | 12.7s         | 11.7s         | 12.0s         | 13.0s - 12.2s
>>>> hackbench w/o PL| 9.2s          | 8.1s          | 8.2s          | 9.2s - 8.4s
>>>
>>> Why does the performance different before and after this patch?
>>
>> Probably due to better locality and cache utilization. I can see that
>> there is ~700k context switches vs ~450k and ~160k migrations vs ~50k.
>> If you need to communicate two threads in different clusters, it will go
>> through CCI.
> 
> Mhmm... I was not specific - I mean, "performance governor". All this
> you mentioned should not differ between performance governor before and
> after. However once you have 12.7, then 13.0 - 12.2. Unless multi-core
> scheduler affects it... but then these numbers here are not showing
> only this change, but also the SCHED_MC effect.  In such case each of
> commits should be coming with their own numbers.

Agree, I should have not put 'this patch set' in the commit
msg. It should go into the cover letter and avoid this confusion.
You are right with ' Unless multi-core scheduler affects it...',
that's why when the SCHED_MC is missing, the decisions about task
placing might cause this variation and delay '13.0 - 12.2' seconds.

> 
>> As mentioned in response to patch 1/3. The fist patch would create MC
>> domain, something different than Energy Model or EAS. The decisions in
>> the scheduler would be different.
>>
>> I can merge 1/3 and 3/3 if you like, though.
> 
> I understand now that their independent. Still, they are part of one
> goal to tune the scheduler for Exynos platform. Splitting these looks
> too much, like enabling multiple drivers one after another.
> 
> However if you provide numbers for each of cases (before patches, multi
> core scheduler, energy model with DTS), then I see benefit of splitting
> it.  Each commit would have its own rationale.  I am not sure if it is
> worth such investigation - that's just defconfig... distros might ignore
> it anyway.

Good point, and I agree that it would require more investigation, for
which unfortunately I don't have currently spare cycles.

Should I merge patch 1/3 and 3/3 and send the v2 with a cover letter
which would have the test results?

Regards,
Lukasz

