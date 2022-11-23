Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91522636508
	for <lists+linux-pm@lfdr.de>; Wed, 23 Nov 2022 16:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238864AbiKWP4q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Nov 2022 10:56:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239015AbiKWP4R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Nov 2022 10:56:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C6658008
        for <linux-pm@vger.kernel.org>; Wed, 23 Nov 2022 07:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669218896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NKN0MLsksCCqIP5KT53Fp7WFaXDe8oqfVKQvl/+1F5k=;
        b=YMq+pkKXX5mpIwZnAKx1tMW85yjpFG/+Kfun5b/JQ38S8GrattqGfoagPA0MnOCsLIpYsK
        0ICNFG7p5eYk6yP2I1P7pfRK+EoQ1gQD76XLcSi1lo7eNfG6cW7p63S+DAH2QC91KPHKEg
        QKn1aJLZnG13MkzFlb1q1lRL74clkfA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-127-znHjdXE-MziMfdYMcAiIqQ-1; Wed, 23 Nov 2022 10:54:54 -0500
X-MC-Unique: znHjdXE-MziMfdYMcAiIqQ-1
Received: by mail-ej1-f72.google.com with SMTP id dn14-20020a17090794ce00b007ae5d040ca8so10212164ejc.17
        for <linux-pm@vger.kernel.org>; Wed, 23 Nov 2022 07:54:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NKN0MLsksCCqIP5KT53Fp7WFaXDe8oqfVKQvl/+1F5k=;
        b=T5TNYVSfywmg96BiB4Bl7OkuMrcYC3d4iJd6ZHJ9SPskbzRc1nucZHOk381nmqke3m
         8xOskM9AvIODv+vB1seua4PLM4yRts7ItFonpVjtxNegVgVj3aA7EyBc0SHh5NfUOrkS
         bm8+gzjmCHTeD5j/dIErVsqC5I5H7TQ635DDEWHeMk/K5PHKu6+8rr14geRorGMyx9s5
         lVTrHxSzxi6fM05j5FfAtXcHJorUVmTmy/I9JgW++N+TMteWYuZDonzxdAf/b5RxqvMj
         mPVnJVA0/GoFAIr3+lzbFiyextrEI3UxxiDvM8m8FfHsVsTz2XceIBhKzcBzYoLNjkQA
         upgw==
X-Gm-Message-State: ANoB5plf3X62Em0pzoeLywDytDWfG+u2cJBcySAvKWhhTGmpZDdJkGDo
        LpIkCpG2wsBqVdn/Jex75p3LNOLcanAw7CxayU7jy3L5oETjyyHYKmN/Gt1mBF6waxPw9GViwJU
        EhDp67CtXqXvWhezd3hs=
X-Received: by 2002:a17:906:708d:b0:7ad:b45c:dbe7 with SMTP id b13-20020a170906708d00b007adb45cdbe7mr23860926ejk.617.1669218893488;
        Wed, 23 Nov 2022 07:54:53 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4LK1NplGnNEY91T3+qiA6I2zQbm0g206Oe0B8qIw3K8Q6/ttMKXUUiPNn782ljfRMIXRj7ag==
X-Received: by 2002:a17:906:708d:b0:7ad:b45c:dbe7 with SMTP id b13-20020a170906708d00b007adb45cdbe7mr23860909ejk.617.1669218893200;
        Wed, 23 Nov 2022 07:54:53 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:2625:d256:70bd:577e? (2001-1c00-0c1e-bf00-2625-d256-70bd-577e.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:2625:d256:70bd:577e])
        by smtp.gmail.com with ESMTPSA id s22-20020a1709067b9600b0077205dd15basm7275766ejo.66.2022.11.23.07.54.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 07:54:52 -0800 (PST)
Message-ID: <ee34cb44-9782-9c91-3ec8-3b9d37353b10@redhat.com>
Date:   Wed, 23 Nov 2022 16:54:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH resend] platform/x86: intel-uncore-freq: add Emerald
 Rapids support
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Artem Bityutskiy <dedekind1@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux PM Mailing List <linux-pm@vger.kernel.org>
References: <20221122070014.3639277-1-dedekind1@gmail.com>
 <0b867f52-5fe8-f0e8-3f05-746b1db0059e@redhat.com>
 <635d481206b8945db751ea036cf789fe13b9698e.camel@gmail.com>
 <01c732b1-7211-8298-61da-0a6892988743@redhat.com>
 <CAJZ5v0gqmZNRQ61LiG-HKVLLciC9=7MPUB9di0LhuUe_tjHJGg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0gqmZNRQ61LiG-HKVLLciC9=7MPUB9di0LhuUe_tjHJGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

On 11/23/22 15:59, Rafael J. Wysocki wrote:
> On Wed, Nov 23, 2022 at 3:37 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 11/23/22 09:45, Artem Bityutskiy wrote:
>>> Hello Hans,
>>>
>>> On Tue, 2022-11-22 at 16:30 +0100, Hans de Goede wrote:
>>> There are 3 different issues with this patch, next time please
>>> check your patch a bit more thorough before submitting it:
>>>
>>> 1. This is the first time I see this, or that the
>>> platform-driver-x86@vger.kernel.org
>>> list sees this. Next time please make sure you address the patch to the right
>>> people the first time you send it:
>>>
>>> sure, thanks.
>>>
>>> 2. This has checkpatch warnings which are easily fixable:
>>>
>>> [hans@shalem platform-drivers-x86]$ scripts/checkpatch.pl 0001-platform-x86-
>>> intel-uncore-freq-add-Emerald-Rapids-su.patch
>>> WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per
>>> line)
>>>
>>> OK.
>>>
>>> 3. This fails to build on top of:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=for-next
>>>
>>> OK, thanks for the pointer. I'd need platfrom-drivers-x86 git tree to include
>>> this upstream commit:
>>>
>>> 7beade0dd41d x86/cpu: Add several Intel server CPU model numbers
>>>
>>> Would you please consider updating?
>>
>> Ugh, no, *NO*! I really expect Intel to do better here!
>>
>> As I repeated explained with the
>>
>> "platform/x86/intel: pmc/core: Add Raptor Lake support to pmc core driver"
>>
>> patch I cannot just go and cherry-pick random patches merged through other trees
>> because that may cause conflicts and will cause the merge to look really
>> funky.
> 
> I don't think this is about requesting a cherry-pick though.
> 
>> There are proper ways to do this and this is not it!
>>
>> This is something which Intel really *must* do correctly next time because
>> having this discussion over and over again is becoming very tiresome!
>>
>> So the proper way to do starts with realizing *beforehand* that things
>> will not build on top of pdx86/for-next. By like actually doing
>> a build-test based on top of pdx86/for-next instead of this nonsense of
>> repeatedly sending me broken patches.
> 
> This patch is based on the mainline.  The requisite commit has been
> included into the Linus' tree since at least 6.1-rc4 AFAICS and I
> suppose that it has been tested on top of that.

Ah, I did not know that; and that is typically info which I would
have expected to be explicitly mentioned in the non-existing cover-letter
for this patch.

> 
> You could in principle create a temporary branch based on 6.1-rc4 (or
> a later -rc), apply the patch on top of it, merge your current branch
> on top of that and merge it back into your current branch (that should
> result in a fast-forward merge, so the temporary branch can be deleted
> after it).

Yes I could merge rc4 into my for-next, but I'm not really a big fan
of back-merges like this. I try to keep my for-next history linear
based on the last rc1, because I find seeing what is going on
a lot easier that way. But if this happens more often I guess
I may need to get used to doing back-merges more often then
just after rc1 is out.

What I don't understand is why this patch was not send as a part of
the series starting which also had the
"7beade0dd41d x86/cpu: Add several Intel server CPU model numbers"
patch. That patch just adds a couple #define-s presumably there
were more patches in that series actually using those defines.

Things would have been cleaner / easier if this patch had simply
been a part of that series and if it was merged in one go with
that series...

Btw this new CPU ID is also missing from:
drivers/platform/x86/intel/pmc/core.c
drivers/platform/x86/intel/ifs/core.c

At least I assume it will need to be added there too, although
I guess it might not be as simple as only adding the CPU-id
match there ?

> Alternatively, if you'd rather not do that, I can merge the Artem's
> patch through the PM tree (it is PM-related after all).

If you can do that, that would be great, thank you.

> I suppose that your ACK would be applicable for that too?

Yes.

Regards,

Hans


