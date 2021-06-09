Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6CDD3A1C95
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jun 2021 20:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhFISRZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Jun 2021 14:17:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229472AbhFISRZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 9 Jun 2021 14:17:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 15FC961359;
        Wed,  9 Jun 2021 18:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623262530;
        bh=cjLVaSchDMh+dthRkEOBI316hd6b15Ap00Z20Z6XFCg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KJZi1AksjM1+zAgJ2itPFNOrcKJMIhk3mG6D/iX584O9TIpdnm00zCoqrA7nBc5v0
         NtlDWmckG5itz83ShFqskfinr+SLwEbCOtHEg25vkTnahrFUMU1OGbDjk1tmZzegwU
         rSqieQW2pY7mvD6uoaeeOfw+4ucvuUkXZNNZIFD9t3/lT9QIp/+4iQyLCsdzi1zK8k
         53diODz1OhiVqDtskfJWtcjsKXbelaZDWnNDJlI99k7HJB9VMmcNPoBnKzhLmbWXLp
         lCC5+Ebt/5wG4XTkeztFsNQdtpVkUUb9J6EKo52dXpaE8XDCo5sV2DFVgcQCagxT1q
         E0o9GMTBvXlJw==
Subject: Re: [PATCH v2] thermal: devfreq_cooling: Fix kernel-doc
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Yang Li <yang.lee@linux.alibaba.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, amitk@kernel.org,
        linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <1623223350-128104-1-git-send-email-yang.lee@linux.alibaba.com>
 <CAKwvOdmBmsvmkm3LNXgvkaa=u1WYkJMvcALMAuhFFFNbfov3YA@mail.gmail.com>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <9c3519a8-f379-ccfa-7ff7-3710cb993e43@kernel.org>
Date:   Wed, 9 Jun 2021 11:15:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdmBmsvmkm3LNXgvkaa=u1WYkJMvcALMAuhFFFNbfov3YA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 6/9/2021 11:02 AM, Nick Desaulniers wrote:
> On Wed, Jun 9, 2021 at 12:22 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>>
>> Fix function name in devfreq_cooling.c comment to remove a
>> warning found by kernel-doc.
>>
>> drivers/thermal/devfreq_cooling.c:479: warning: expecting prototype for
>> devfreq_cooling_em_register_power(). Prototype was for
>> devfreq_cooling_em_register() instead.
>>
>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
>> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> 
> I'm ok with leaving my reviewed by on _this_ patch because it's so simple but...
> 
> In general, when sending a follow up version of a patch, it's _not_ ok
> to add a reviewed by tag when a reviewer has not explicitly responded
> with "Reviewed-by: ...".  That provides a false sense that a patch has
> been thoroughly reviewed.  Responding to a patch does not constitute a
> "Reviewed-by:" tag.
> 
> And I might be fine with _this_ patch, but that says nothing about
> Nathan, whom you've also falsely attributed a reviewed by tag here.
> 
> For such a trivial patch, it's not a big deal, but in the future
> please do not do that again.  It's ok to send v2, v3, etc, but wait
> for reviewers to explicitly state such reviewed by tag. The maintainer
> will collect those responses (and can be done so in an automated
> fashion via a tool like b4 (https://pypi.org/project/b4/)) when
> applying patches.

+1 with all that was said above. Tags should be explicitly given, except 
for maybe the "Reported-by" and "Suggested-by" tags if the report or 
suggestion was done in the public forum but it is still polite to ask if 
it is okay to add.

For the record, my reviewed-by tag can stand:

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

>> ---
>>
>> Change in v2:
>> --replaced s/clang(make W=1 LLVM=1)/kernel-doc/ in commit.
>> https://lore.kernel.org/patchwork/patch/1442639/
>>
>>   drivers/thermal/devfreq_cooling.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
>> index 3a788ac..5a86cff 100644
>> --- a/drivers/thermal/devfreq_cooling.c
>> +++ b/drivers/thermal/devfreq_cooling.c
>> @@ -458,7 +458,7 @@ struct thermal_cooling_device *devfreq_cooling_register(struct devfreq *df)
>>   EXPORT_SYMBOL_GPL(devfreq_cooling_register);
>>
>>   /**
>> - * devfreq_cooling_em_register_power() - Register devfreq cooling device with
>> + * devfreq_cooling_em_register() - Register devfreq cooling device with
>>    *             power information and automatically register Energy Model (EM)
>>    * @df:                Pointer to devfreq device.
>>    * @dfc_power: Pointer to devfreq_cooling_power.
>> --
>> 1.8.3.1
>>
> 
> 
