Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7431527E3A6
	for <lists+linux-pm@lfdr.de>; Wed, 30 Sep 2020 10:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgI3IZ0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Sep 2020 04:25:26 -0400
Received: from foss.arm.com ([217.140.110.172]:59372 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728563AbgI3IZZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 30 Sep 2020 04:25:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 456A2D6E;
        Wed, 30 Sep 2020 01:25:25 -0700 (PDT)
Received: from [10.57.54.5] (unknown [10.57.54.5])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D99613F6CF;
        Wed, 30 Sep 2020 01:25:22 -0700 (PDT)
Subject: Re: [PATCH 1/2] docs: Clarify abstract scale usage for power values
 in Energy Model
To:     Doug Anderson <dianders@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dietmar.Eggemann@arm.com, Quentin Perret <qperret@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rajendra Nayak <rnayak@codeaurora.org>
References: <20200929121610.16060-1-lukasz.luba@arm.com>
 <CAD=FV=UnNkjMiOc0DZE7+OM3-Kr1ZRynxSerdA=ifbyGiRa2Zw@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <a1d1fe2a-485f-a21e-2f91-9b609223aa5a@arm.com>
Date:   Wed, 30 Sep 2020 09:25:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=UnNkjMiOc0DZE7+OM3-Kr1ZRynxSerdA=ifbyGiRa2Zw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Douglas,

On 9/30/20 12:53 AM, Doug Anderson wrote:
> Hi,
> 
> On Tue, Sep 29, 2020 at 5:16 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> The Energy Model (EM) can store power values in milli-Watts or in abstract
>> scale. This might cause issues in the subsystems which use the EM for
>> estimating the device power, such as:
>> - mixing of different scales in a subsystem which uses multiple
>>    (cooling) devices (e.g. thermal Intelligent Power Allocation (IPA))
>> - assuming that energy [milli-Joules] can be derived from the EM power
>>    values which might not be possible since the power scale doesn't have to
>>    be in milli-Watts
>>
>> To avoid misconfiguration add the needed documentation to the EM and
>> related subsystems: EAS and IPA.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   .../driver-api/thermal/power_allocator.rst          |  8 ++++++++
>>   Documentation/power/energy-model.rst                | 13 +++++++++++++
>>   Documentation/scheduler/sched-energy.rst            |  5 +++++
>>   3 files changed, 26 insertions(+)
> 
> I haven't read through these files in massive detail, but the quick
> skim makes me believe that your additions seem sane.  In general, I'm
> happy with documenting reality, thus:
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thank you for the review.

> 
> I will note: you haven't actually updated the device tree bindings.
> Thus, presumably, anyone who is specifying these numbers in the device
> tree is still supposed to specify them in a way that mW can be
> recovered, right?  Said another way: nothing about your patches makes
> it OK to specify numbers in device trees using an "abstract scale",
> right?

For completeness, we are talking here about the binding from:
Documentation/devicetree/bindings/arm/cpus.yaml
which is 'dynamic-power-coefficient'. Yes, it stays untouched, also the
unit (uW/MHz/V^2) which then allows to have mW in the power
values in the EM.

Regards,
Lukasz
