Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF57D375A2
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2019 15:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfFFNso (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Jun 2019 09:48:44 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58364 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfFFNso (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Jun 2019 09:48:44 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id D902728471A
Subject: Re: [PATCH 1/2] PM / devfreq: Fix governor module load failure
To:     Ezequiel Garcia <ezequiel@collabora.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>, kernel@collabora.com,
        Linux PM list <linux-pm@vger.kernel.org>
References: <20190605190053.19177-1-ezequiel@collabora.com>
 <CAFqH_52c42_SD9VLwnGXtP2V0ZCpmynTMqgHgA2JUmK_jdMcVw@mail.gmail.com>
 <8d2362309dee4ac066086033996a40da45d92fed.camel@collabora.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <63e8ede6-1589-e69c-1510-0575d1c47fbd@collabora.com>
Date:   Thu, 6 Jun 2019 15:48:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <8d2362309dee4ac066086033996a40da45d92fed.camel@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 6/6/19 15:42, Ezequiel Garcia wrote:
> On Wed, 2019-06-05 at 23:46 +0200, Enric Balletbo Serra wrote:
>> Hi Ezequiel,
>>
>> Missatge de Ezequiel Garcia <ezequiel@collabora.com> del dia dc., 5 de
>> juny 2019 a les 21:06:
>>> A bit unexpectedly (but still documented), request_module may
>>> return a positive value, in case of a modprobe error.
>>> This is currently causing issues in the devfreq framework.
>>>
>>> When a request_module exits with a positive value, we currently
>>> return that via ERR_PTR. However, because the value is positive,
>>> it's not a ERR_VALUE proper, and is therefore treated as a
>>> valid struct devfreq_governor pointer, leading to a kernel oops.
>>>
>>> The right way to fix this is hinted in __request_module documentation:
>>>
>>> """
>>> [snip] The function returns
>>> zero on success or a negative errno code or positive exit code from
>>> "modprobe" on failure. Note that a successful module load does not mean
>>> the module did not then unload and exit on an error of its own. Callers
>>> must check that the service they requested is now available not blindly
>>> invoke it.
>>> """
>>>
>>> Therefore, drop the return value check, which is not useful, and instead
>>> just re-try to find the (hopefully now loaded) governor.
>>>
>>> Fixes: 23c7b54ca1cd1 ("PM / devfreq: Fix devfreq_add_device() when drivers are built as modules.")
>>
>> I think that what you really fixed is a bug introduced by:
>>
>> b53b0128052ff ("PM / devfreq: Fix static checker warning in
>> try_then_request_governor")
>>
>> not the above commit.
>>
> 
> Oh, you are right of course. I looked for the commit introducing the
> request_module usage, and thought it was the culprit.
> 
>>> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
>>> ---
>>>  drivers/devfreq/devfreq.c | 8 ++------
>>>  1 file changed, 2 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>> index 6b6991f0e873..8868ad9472d2 100644
>>> --- a/drivers/devfreq/devfreq.c
>>> +++ b/drivers/devfreq/devfreq.c
>>> @@ -236,7 +236,6 @@ static struct devfreq_governor *find_devfreq_governor(const char *name)
>>>  static struct devfreq_governor *try_then_request_governor(const char *name)
>>>  {
>>>         struct devfreq_governor *governor;
>>> -       int err = 0;
>>>
>>>         if (IS_ERR_OR_NULL(name)) {
>>>                 pr_err("DEVFREQ: %s: Invalid parameters\n", __func__);
>>> @@ -251,13 +250,10 @@ static struct devfreq_governor *try_then_request_governor(const char *name)
>>>
>>>                 if (!strncmp(name, DEVFREQ_GOV_SIMPLE_ONDEMAND,
>>>                              DEVFREQ_NAME_LEN))
>>> -                       err = request_module("governor_%s", "simpleondemand");
>>> +                       request_module("governor_%s", "simpleondemand");
>>>                 else
>>> -                       err = request_module("governor_%s", name);
>>> -               /* Restore previous state before return */
>>> +                       request_module("governor_%s", name);
>>>                 mutex_lock(&devfreq_list_lock);
>>> -               if (err)
>>
>> If you remove this check you'll iterate always over the full devfreq
>> list of governors, I know should be quick and is not too long but ...
>>
> 
> Keep in mind that when the request_module succeeds, we need
> to iterate anyways to find the governor.
> 

Well, the error path will be a micro-bit faster :-)

>>> -                       return ERR_PTR(err);
>>
>> The fix can be simply:
>>
>> return ERR_PTR(-EINVAL);
>>
>> I don't think overlap the real error is a problem here.
>>
> 
> Yeah, I also thought about this, but somehow thought this
> was simpler.
> 
> I don't have a strong opinion, so whatever you prefer is fine.
> 

Me neither, I think is more up to the maintainer :-)

BTW, with the Fixes tag fixed

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> Thanks,
> Eze
> 
>> Thanks,
>>  Enric
>>
>>>                 governor = find_devfreq_governor(name);
>>>         }
>>> --
>>> 2.20.1
>>>
> 
> 
