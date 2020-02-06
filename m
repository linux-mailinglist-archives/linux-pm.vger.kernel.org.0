Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7BA91545E2
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2020 15:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgBFOPs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Feb 2020 09:15:48 -0500
Received: from foss.arm.com ([217.140.110.172]:59140 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727481AbgBFOPs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 6 Feb 2020 09:15:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA60E30E;
        Thu,  6 Feb 2020 06:15:47 -0800 (PST)
Received: from [10.37.12.48] (unknown [10.37.12.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B1CF3F52E;
        Thu,  6 Feb 2020 06:15:44 -0800 (PST)
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
 <c54e252d-dc55-5fa3-f97f-643d7efbfdc1@arm.com>
 <CAJKOXPfTjdtNMx=+dPVcQ53RiXx0y-r=KXBRhzA4jS77SHxciQ@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <f304f978-be07-7944-e47e-e5eaac9cb907@arm.com>
Date:   Thu, 6 Feb 2020 14:15:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPfTjdtNMx=+dPVcQ53RiXx0y-r=KXBRhzA4jS77SHxciQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 2/6/20 12:59 PM, Krzysztof Kozlowski wrote:
> On Wed, 5 Feb 2020 at 13:49, Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>> As mentioned in response to patch 1/3. The fist patch would create MC
>>>> domain, something different than Energy Model or EAS. The decisions in
>>>> the scheduler would be different.
>>>>
>>>> I can merge 1/3 and 3/3 if you like, though.
>>>
>>> I understand now that their independent. Still, they are part of one
>>> goal to tune the scheduler for Exynos platform. Splitting these looks
>>> too much, like enabling multiple drivers one after another.
>>>
>>> However if you provide numbers for each of cases (before patches, multi
>>> core scheduler, energy model with DTS), then I see benefit of splitting
>>> it.  Each commit would have its own rationale.  I am not sure if it is
>>> worth such investigation - that's just defconfig... distros might ignore
>>> it anyway.
>>
>> Good point, and I agree that it would require more investigation, for
>> which unfortunately I don't have currently spare cycles.
>>
>> Should I merge patch 1/3 and 3/3 and send the v2 with a cover letter
>> which would have the test results?
> 
> Yes, let's do this way.

Thank you, I will send the v2 then.

Regards,
Lukasz

> 
> Thanks for working on this!
> 
> Best regards,
> Krzysztof
> 
