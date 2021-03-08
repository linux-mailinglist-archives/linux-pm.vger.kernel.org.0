Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4B153317D5
	for <lists+linux-pm@lfdr.de>; Mon,  8 Mar 2021 20:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbhCHTzb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Mar 2021 14:55:31 -0500
Received: from foss.arm.com ([217.140.110.172]:42952 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231544AbhCHTzZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Mar 2021 14:55:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77E6131B;
        Mon,  8 Mar 2021 11:55:24 -0800 (PST)
Received: from [10.57.19.192] (unknown [10.57.19.192])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E60E3F73C;
        Mon,  8 Mar 2021 11:55:23 -0800 (PST)
Subject: Re: [PATCH 1/5] powercap/drivers/dtpm: Encapsulate even more the code
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20210301212149.22877-1-daniel.lezcano@linaro.org>
 <f5a4be4d-b003-2751-7758-ef2c58e3fbbc@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <2d5e7eff-ae9d-2c67-3f49-89cb006b4a1b@arm.com>
Date:   Mon, 8 Mar 2021 19:55:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <f5a4be4d-b003-2751-7758-ef2c58e3fbbc@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

On 3/8/21 7:31 PM, Daniel Lezcano wrote:
> 
> On 01/03/2021 22:21, Daniel Lezcano wrote:
>> In order to increase the self-encapsulation of the dtpm generic code,
>> the following changes are adding a power update ops to the dtpm
>> ops. That allows the generic code to call directly the dtpm backend
>> function to update the power values.
>>
>> The power update function does compute the power characteristics when
>> the function is invoked. In the case of the CPUs, the power
>> consumption depends on the number of online CPUs. The online CPUs mask
>> is not up to date at CPUHP_AP_ONLINE_DYN state in the tear down
>> callback. That is the reason why the online / offline are at separate
>> state. As there is already an existing state for DTPM, this one is
>> only moved to the DEAD state, so there is no addition of new state
>> with these changes.
>>
>> That simplifies the code for the next changes and results in a more
>> self-encapsulated code.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> Is there any comment on this series ?

If you can wait 1 day, I will review it tomorrow...
I was quite busy recently and put it at the end of my list.

Regards,
Lukasz
