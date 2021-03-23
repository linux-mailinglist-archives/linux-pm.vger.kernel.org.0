Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A784234640E
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 16:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbhCWP6Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Mar 2021 11:58:25 -0400
Received: from foss.arm.com ([217.140.110.172]:48432 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232912AbhCWP5z (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Mar 2021 11:57:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8A04D6E;
        Tue, 23 Mar 2021 08:57:54 -0700 (PDT)
Received: from [10.57.6.111] (unknown [10.57.6.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 36A4F3F718;
        Tue, 23 Mar 2021 08:57:52 -0700 (PDT)
Subject: Re: [PATCH] PM / EM: postpone creating the debugfs dir till
 fs_initcall
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rjw@rjwysocki.net, rafael@kernel.org, ionela.voinescu@arm.com,
        Dietmar.Eggemann@arm.com
References: <20210323145608.29832-1-lukasz.luba@arm.com>
 <YFoIjt3E+MIK3yQQ@kroah.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <39cee1e7-c085-88d2-9b3b-e4ffbbee04eb@arm.com>
Date:   Tue, 23 Mar 2021 15:57:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <YFoIjt3E+MIK3yQQ@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 3/23/21 3:26 PM, Greg KH wrote:
> On Tue, Mar 23, 2021 at 02:56:08PM +0000, Lukasz Luba wrote:
>> The debugfs directory '/sys/kernel/debug/energy_model' is needed before
>> the Energy Model registration can happen. With the recent change in
>> debugfs subsystem it's not allowed to create this directory at early stage
>> (core_initcall). Thus creating this directory would fail.
>> Postpone the creation of the EM debug dir to later stage: fs_initcall.
>> It should be safe since all clients: CPUFreq drivers, Devfreq drivers will
>> be initialized in later stages.
>> The custom debug log below prints the time of creation the EM debug dir at
>> fs_initcall and successful registration of EMs at later stages.
>>
>> [    1.505717] energy_model: creating rootdir
>> [    3.698307] cpu cpu0: EM: created perf domain
>> [    3.709022] cpu cpu1: EM: created perf domain
>>
>> fixes: 56348560d495 ("debugfs: do not attempt to create a new file before the filesystem is initalized")
>> Reported-by: Ionela Voinescu <ionela.voinescu@arm.com>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>> Hi Rafael,
>>
>> Please take this patch into your PM v5.12 fixes. The change described in
>> the patch above landed in v5.12-rc1. Some of our EAS/EM tests are failing.
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 

Thank you Greg!

Regards,
Lukasz
