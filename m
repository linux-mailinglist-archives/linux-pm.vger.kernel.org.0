Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAFDB2B5BC0
	for <lists+linux-pm@lfdr.de>; Tue, 17 Nov 2020 10:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgKQJYW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Nov 2020 04:24:22 -0500
Received: from foss.arm.com ([217.140.110.172]:52698 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgKQJYV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 17 Nov 2020 04:24:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A35A1042;
        Tue, 17 Nov 2020 01:24:20 -0800 (PST)
Received: from [10.57.25.49] (unknown [10.57.25.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BDB53F719;
        Tue, 17 Nov 2020 01:24:15 -0800 (PST)
Subject: Re: [PATCH v4 0/4] Clarify abstract scale usage for power values in
 Energy Model, EAS and IPA
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Nayak, Rajendra" <rnayak@codeaurora.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>
References: <20201103090600.29053-1-lukasz.luba@arm.com>
 <9382ea70-cc50-7b78-f5de-716678bdefbf@arm.com>
 <CAJZ5v0iS2jFvqiddjTDFpXq0gcNrrKML6raQOq=S4boZZC_V5Q@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <1685b7c8-e6bb-fc3b-c2ff-5c87c35610f0@arm.com>
Date:   Tue, 17 Nov 2020 09:24:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0iS2jFvqiddjTDFpXq0gcNrrKML6raQOq=S4boZZC_V5Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 11/10/20 7:32 PM, Rafael J. Wysocki wrote:
> On Wed, Nov 4, 2020 at 11:58 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> Hi Rafael,
>>
>> On 11/3/20 9:05 AM, Lukasz Luba wrote:
>>> Hi all,
>>>
>>> The Energy Model supports power values expressed in an abstract scale.
>>> This has an impact on Intelligent Power Allocation (IPA) and should be
>>> documented properly. Kernel sub-systems like EAS, IPA and DTPM
>>> (new comming PowerCap framework) would use the new flag to capture
>>> potential miss-configuration where the devices have registered different
>>> power scales, thus cannot operate together.
>>>
>>> There was a discussion below v2 of this patch series, which might help
>>> you to get context of these changes [2].
>>>
>>> The agreed approach is to have the DT as a source of power values expressed
>>> always in milli-Watts and the only way to submit with abstract scale values
>>> is via the em_dev_register_perf_domain() API.
>>>
>>> Changes:
>>> v4:
>>> - change bool to int type for 'miliwatts' in struct em_perf_domain
>>>     (suggested by Quentin)
>>> - removed one sentence from patch 2/4 in IPA doc power_allocator.rst
>>>     (suggested by Quentin)
>>> - added reviewed-by from Quentin to 1/4, 3/4, 4/4 patches
>>
>> There was no major objections in the v3 and this v4 just addressed
>> minor comments. The important discussions mostly happen in v2.
>>
>> Could you take the patches via your tree, please?
> 
> Applied as 5.11 material, thanks!
> 

Thank you Rafael!

Regards,
Lukasz
