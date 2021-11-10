Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B540A44CAC5
	for <lists+linux-pm@lfdr.de>; Wed, 10 Nov 2021 21:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbhKJUxI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Nov 2021 15:53:08 -0500
Received: from foss.arm.com ([217.140.110.172]:51208 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232859AbhKJUxF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Nov 2021 15:53:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47978101E;
        Wed, 10 Nov 2021 12:50:17 -0800 (PST)
Received: from [10.57.28.25] (unknown [10.57.28.25])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 162243F5A1;
        Wed, 10 Nov 2021 12:50:15 -0800 (PST)
Subject: Re: [PATCH 1/2] Documentation: power: Add description about new
 callback for EM registration
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>
References: <20211102180144.1647-1-lukasz.luba@arm.com>
 <22bdfc88-983d-fc86-0abb-404eedf03274@arm.com>
 <CAJZ5v0hf-ZG9RTpoyYhzZSLhy3HxcHDGgvfibPnb3oubx4cfNQ@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <eb15338c-f27b-d552-1780-93a846d6495e@arm.com>
Date:   Wed, 10 Nov 2021 20:50:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hf-ZG9RTpoyYhzZSLhy3HxcHDGgvfibPnb3oubx4cfNQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 11/10/21 8:28 PM, Rafael J. Wysocki wrote:
> On Tue, Nov 9, 2021 at 11:38 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> Hi Rafael,
>>
>>
>> On 11/2/21 6:01 PM, Lukasz Luba wrote:
>>> The Energy Model (EM) registration for CPUs should now be done using
>>> a dedicated callback added recently into CPUFreq framework and drivers.
>>>
>>> Commit c17495b01b72 ("cpufreq: Add callback to register with energy model")
>>>
>>> The callback guaranties that the EM registration is called at the right
>>> time during driver setup. To avoid mistakes update the documentation
>>> to align with the existing code implementation.
>>>
>>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>>> ---
>>>    Documentation/power/energy-model.rst | 31 ++++++++++++++--------------
>>>    1 file changed, 16 insertions(+), 15 deletions(-)
>>>
>>
>>
>> Gentle ping. Could you have a look at these documentation
>> two patches and maybe pick them, please?
>> They are trying to solve some confusion discussed with our partners
>> recently.
> 
> Both applied as 5.16-rc material now, thanks!
> 

Thank you Rafael!
