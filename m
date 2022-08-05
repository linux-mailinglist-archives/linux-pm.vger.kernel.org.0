Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64BAD58B134
	for <lists+linux-pm@lfdr.de>; Fri,  5 Aug 2022 23:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238385AbiHEVjo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Aug 2022 17:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237863AbiHEVjn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Aug 2022 17:39:43 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC6C78210
        for <linux-pm@vger.kernel.org>; Fri,  5 Aug 2022 14:39:42 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id x9so633184ljj.13
        for <linux-pm@vger.kernel.org>; Fri, 05 Aug 2022 14:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Ib6oNoeC1y7DWmUGX1sKZNT4F0DH8JMdm8hi9j96RuE=;
        b=dEwdegAtlsp946F0kCYkkcY24jSOKl3+Nqut8Wt1pdvXqyUYl7/7FfTPIOiIoLjar/
         DYbjlHAYIyNqczQqwxycAnMkcX7157CtSuvG5YrOXLaFAuPs30i0V6VnHZFjm59svJE6
         8XjJ4BFWc3xhN7WHSCCHbdkFK2R2GVrzJ8kqERdvxnU3hvmIi9gQxCJLqDqSBpPD+KKX
         2Xa6r999PQDA+QEH0Cx0+OPdVhDnJ6d6c+5zA6C9QIUKfp37Tfz7zo9mGYfqM3FH6dW7
         jSXKSlgvCcHkFrRQr34NM5Za7WI8zy2RbYQXhDux00NYvRsFBMOzmw3m5RmkO4DNhIt2
         c8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Ib6oNoeC1y7DWmUGX1sKZNT4F0DH8JMdm8hi9j96RuE=;
        b=yYD8ut2hf0AqbRz2jH6UAED+E2N1zDSzFP8jq2Vr4AZy5SBh/3yMQ/mVQ6SOR4IcJI
         S8dWO3gU8W68nLi+jXN/7S0tcJjXSNvawugCrLZHKEnm2lCnqzEiduoxUGY0PYtDV2Sz
         HjdGlz1R2lGdSZn8T0DU1+4sqwHKOtaMfU+P9b1obaD4GYIAs9o6Ztg49HG7vgZHBJIo
         QrBo6T8mSzddBYW5+EAYJbhlwoXbbT2ZT0pvTKXCVGbMAvnEwkyHvkr36F8+dOSJlvd5
         slNSt2P7ioG/k4JqH+rTwKOYUiqIA4XY2GRigXNExlourftyjwrSG7gUhSKmKj9DTxTm
         e4UA==
X-Gm-Message-State: ACgBeo2jJ7s3zu+BnhD2wUQHyuXHS7PZQ9b33FOpaPLMKDVSEpeZymWk
        Uo203jf5U5IJs4IcCy6tKDC7fQ==
X-Google-Smtp-Source: AA6agR7mXVPjX6BpjKrzHQR728WlcEp54YPNDbHE4HL+JwWX1mBqH/QF6PbWCziisye51GE1kIgDhA==
X-Received: by 2002:a2e:2e1a:0:b0:25e:4c40:48f4 with SMTP id u26-20020a2e2e1a000000b0025e4c4048f4mr2388553lju.421.1659735580908;
        Fri, 05 Aug 2022 14:39:40 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id f1-20020a056512360100b0048afe02c925sm584278lfs.219.2022.08.05.14.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 14:39:40 -0700 (PDT)
Message-ID: <9a53b01f-e112-314b-faa1-13f0ed36f595@linaro.org>
Date:   Sat, 6 Aug 2022 00:39:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: PSCI domains without OSI support
Content-Language: en-GB
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vinod.koul@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
References: <CAA8EJpr2S-81+q-vjmk5i+T-JwaadkRpjCr_oGi7fMf7o3iH3A@mail.gmail.com>
 <20220727111410.bglx2u26456ray2u@bogus>
 <CAA8EJprNPJfGjkq2=hexbZn-=t2wKG6ZjSm5Mcbo4JuPQ-sc-A@mail.gmail.com>
 <20220728084012.jjbmycplye3zuaok@bogus>
 <CAPDyKFqT23A_4EdBe=2-+6821BzjPvGzsMositM2=Of692iv3A@mail.gmail.com>
 <20220805160020.fc5s3hv3u5h4gcmv@bogus>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220805160020.fc5s3hv3u5h4gcmv@bogus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05/08/2022 19:00, Sudeep Holla wrote:
> On Fri, Aug 05, 2022 at 04:12:42PM +0200, Ulf Hansson wrote:
>> On Thu, 28 Jul 2022 at 10:40, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>>
>>> On Wed, Jul 27, 2022 at 04:24:22PM +0300, Dmitry Baryshkov wrote:
>>>> On Wed, 27 Jul 2022 at 14:14, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>>>>
>>>>> On Wed, Jul 27, 2022 at 12:09:27PM +0300, Dmitry Baryshkov wrote:
>>>>>> - Allow DTS forcing the PSCI power domains even if OSI enablement fails?
>>>>>
>>>>> Meaning DTS flag for this ? If OSI enable fails, why would you want to
>>>>> still proceed. It is non-compliant and must be fixed if the firmware
>>>>> supports OSI and expects OSPM to use the same.
>>>>
>>>> I'm not sure at this moment. PSCI firmware reports that OSI mode is
>>>> supported, but then when psci_pd_try_set_osi_mode() tries to switch
>>>> into OSI mode, it gets NOT_SUPPORTED.
>>>
>>> Yikes, fix the damn broken firmware. That is utter non-sense. I don't
>>> understand why would the firmware authors enable some feature before it
>>> is ready.
>>
>> I certainly agree that the FW is broken and should really have been
>> fixed, but that seems unlikely to happen when moving forward.
>>
>> On the other hand, it's quite common that we try to add workarounds at
>> the Linux side to fix FW issues. Of course, it depends on what kind of
>> hacks it means for us to carry.
>>
>> In this particular case, I am of the opinion that it looks like the
>> "hack" may be worth it. Unless I have underestimated the problem, it
>> seems like a new DT property/flag and a simple if-clause in
>> psci_pd_try_set_osi_mode() should do the trick for us.
>>
> 
> I don't like the idea of new property/flag for this for simple reason.
> Once you have that it is impossible to control if downstream new platforms
> are using it and they will expect it to be maintained once they ship the
> product.

According to my quick research the requested issue was present on 
platforms revealed from 2015 (2013?) to 2017. Since sdm845 (December 
2017) the issue is not present. So this is a part of history rather than 
current platforms being in need of this quirk.

> 
>> I wouldn't mind maintaining such small parts, when going forward - and
>> of course I think we should also reject any newer platforms from using
>> it.
>>
> 
> The only way that we can achieve this IMO is to have quirks based on
> platform compatible which needs to be updated and can be rejected for
> newer platforms. New flags means new feature which is expected to be
> supported for long and hard to control newer platforms not using them.

I see your point. However from my point of view, the DT property allows 
more finer-grained control.

Compare the semantics:
- Proprety: assume that the platform is in OSI mode, do not call 
psci_osi_set_mode().

- Platform compat list: If the psci_osi_set_mode() has failed, ignore 
the error. I would not dare to blindly assume that e.g. all msm8996 
devices are in OSI mode.

[skipped]

>> To me, it seems like a pity, if we just decided to leave all those
>> devices out there in the field, lacking support for deeper idle
>> states. Don't you think?
>>
> 
> Sure, but I don't like new flags for handling this for reasons stated
> above. Unless DT maintainers expect to take "new flag/property" for
> some reasons that I am not aware of, I prefer the check on existing
> platform compatible to deal with this problem so that this problem
> doesn't trickle down to newer platforms as well. Thoughts ?
> 
> And please add that we can't add any compatibles that are added later
> than certain date to that list when we are adding this support.

Then we are ruling out existing platforms, which are not yet supported 
by Linux. Hopefully you meant that we can not extend this list with 
platforms developed/announced after certain date (I might be slightly 
wrong here, but I estimate that the end of 2018 as a safe boundary).

Newer platforms (sdm845, 2018, qcs404, 2019, etc) report SET_SUSPEND as 
supported (and return DENIED in attempt to set the PC mode).

-- 
With best wishes
Dmitry
