Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C053474D1
	for <lists+linux-pm@lfdr.de>; Wed, 24 Mar 2021 10:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236189AbhCXJje (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Mar 2021 05:39:34 -0400
Received: from foss.arm.com ([217.140.110.172]:59172 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236174AbhCXJjY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 24 Mar 2021 05:39:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADF711FB;
        Wed, 24 Mar 2021 02:39:23 -0700 (PDT)
Received: from [10.57.25.74] (unknown [10.57.25.74])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 52C343F718;
        Wed, 24 Mar 2021 02:39:22 -0700 (PDT)
Subject: Re: [PATCH] PM / EM: postpone creating the debugfs dir till
 fs_initcall
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>
References: <20210323145608.29832-1-lukasz.luba@arm.com>
 <YFoIjt3E+MIK3yQQ@kroah.com> <39cee1e7-c085-88d2-9b3b-e4ffbbee04eb@arm.com>
 <CAJZ5v0hD1qz1RDQpj47fkK4p_q2xSB84kx6bCenj4P6s-n9HsQ@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <e263e10c-f8ba-a4d4-9f84-142bc87da161@arm.com>
Date:   Wed, 24 Mar 2021 09:39:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hD1qz1RDQpj47fkK4p_q2xSB84kx6bCenj4P6s-n9HsQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 3/23/21 6:55 PM, Rafael J. Wysocki wrote:
> On Tue, Mar 23, 2021 at 4:57 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>>
>>
>> On 3/23/21 3:26 PM, Greg KH wrote:
>>> On Tue, Mar 23, 2021 at 02:56:08PM +0000, Lukasz Luba wrote:
>>>> The debugfs directory '/sys/kernel/debug/energy_model' is needed before
>>>> the Energy Model registration can happen. With the recent change in
>>>> debugfs subsystem it's not allowed to create this directory at early stage
>>>> (core_initcall). Thus creating this directory would fail.
>>>> Postpone the creation of the EM debug dir to later stage: fs_initcall.
>>>> It should be safe since all clients: CPUFreq drivers, Devfreq drivers will
>>>> be initialized in later stages.
>>>> The custom debug log below prints the time of creation the EM debug dir at
>>>> fs_initcall and successful registration of EMs at later stages.
>>>>
>>>> [    1.505717] energy_model: creating rootdir
>>>> [    3.698307] cpu cpu0: EM: created perf domain
>>>> [    3.709022] cpu cpu1: EM: created perf domain
>>>>
>>>> fixes: 56348560d495 ("debugfs: do not attempt to create a new file before the filesystem is initalized")
>>>> Reported-by: Ionela Voinescu <ionela.voinescu@arm.com>
>>>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>>>> ---
>>>> Hi Rafael,
>>>>
>>>> Please take this patch into your PM v5.12 fixes. The change described in
>>>> the patch above landed in v5.12-rc1. Some of our EAS/EM tests are failing.
>>>
>>> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>
>>
>> Thank you Greg!
> 
> Applied as 5.12-rc material, thanks!
> 

Thank you Rafael!

Regards,
Lukasz
