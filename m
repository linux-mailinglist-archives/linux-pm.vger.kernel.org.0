Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9D2605C65
	for <lists+linux-pm@lfdr.de>; Thu, 20 Oct 2022 12:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiJTKeE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Oct 2022 06:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiJTKeD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Oct 2022 06:34:03 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0482C157F55
        for <linux-pm@vger.kernel.org>; Thu, 20 Oct 2022 03:34:02 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id r22so25718230ljn.10
        for <linux-pm@vger.kernel.org>; Thu, 20 Oct 2022 03:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yWjPN4KXHxPWN4WI4l5tKmALmiP8Slvad4TlEfvcieE=;
        b=l6AhLaMP0llYNqZfo5qGuwvluxb7uJZ8dQVp+TEWGoMkOr0PVxTgLEYCaa+Z0GzRwz
         idiIGKwMVtNKgc/BUlJ7qbIBqGqeEOOpVc4yu92ZsBeXmHJRzqpSFrhJF9s8bCRXA1Rp
         FDmJCR9VF3nyuUlDmFrzBDaxozSnSl16S6ge2yck0ed4HG7t0DG44xTmLyT6nD0SqDcs
         /RNVJ0XhucCCy/3t/y2wOCbJcHf9V0DmzPs+xJNk9IWYw9wHpJPqIpA+WS8D//iKX55B
         Xuthe3TkwTjJknmbgy62/yFLQnPAcYY9avkXYee/MxQB2oFCu5FRj+NLdPjxbRuztkmk
         MCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yWjPN4KXHxPWN4WI4l5tKmALmiP8Slvad4TlEfvcieE=;
        b=Yw3F8eZ1d+a1H8j10rP4THtb803124KqIfOtIJurRQcvZESCQQOOebmOBlP0KdTJhQ
         QOPDVGKtmNrTKtMC7Vt4W01RavP8wnYFJoRCqbQVhEua7Ah6XirSWHMfIX2TIMWfg1kV
         qf0QUBaEdcfHlGf+y+kyZOgUdAaEq9FGqUH0GJlX5XVKPmvzwtVqOyOb92kYqcctdLPU
         nrlRm2qneyVaayoDJYZYqelVt4QhHGAoDmSxmAXq2AwRi0nvNFpTywJE3X1vDEUAjXn7
         /zvjOS3PoRJq9OdVzOAawAv7ZTDfH52ElOQtdhep7Mt89Z958pl5il4ycNZKsUoa7RqN
         v6mg==
X-Gm-Message-State: ACrzQf0vw/CAFW2CnzmfJuM2ZVmA8XX/kTXcFFqF7l7mBbzRjDfyzoWj
        AKwKvQxlE/cBzR+jcMGfVoY9JQ==
X-Google-Smtp-Source: AMsMyM4hm2kOhU2E0xX6eMOwIhvjHKKOb4ioplBvbXHocJEUxxCR5hxB4bbpeeMW+Jneh7LGk+UTkQ==
X-Received: by 2002:a2e:8541:0:b0:261:b44b:1a8b with SMTP id u1-20020a2e8541000000b00261b44b1a8bmr4802602ljj.46.1666262040316;
        Thu, 20 Oct 2022 03:34:00 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id f20-20020a056512229400b0049f53b65790sm2658525lfu.228.2022.10.20.03.33.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 03:33:59 -0700 (PDT)
Message-ID: <ec30d40c-d1d8-84d2-961e-c0a2fde5e341@linaro.org>
Date:   Thu, 20 Oct 2022 13:33:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [RESEND PATCH v2] firmware/psci: Print a warning if PSCI doesn't
 accept PC mode
Content-Language: en-GB
To:     Johan Hovold <johan@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org, soc@kernel.org,
        linux-pm@vger.kernel.org
References: <20220926110249.666813-1-dmitry.baryshkov@linaro.org>
 <Y1AGLPXWFOmjfdd0@hovoldconsulting.com>
 <CAPDyKFr9MraGWz7hbHyGtFsk7V2_GBUqvWBG5yM40zV6utwXOQ@mail.gmail.com>
 <CAA8EJpoHSHqsqok1hhVhF-24O5dwjA46fmdjsUg1aHjuiy266w@mail.gmail.com>
 <Y1DxfjExuzfKLWDs@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <Y1DxfjExuzfKLWDs@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20/10/2022 09:58, Johan Hovold wrote:
> On Wed, Oct 19, 2022 at 06:02:37PM +0300, Dmitry Baryshkov wrote:
>> On Wed, 19 Oct 2022 at 17:37, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> On Wed, 19 Oct 2022 at 16:14, Johan Hovold <johan@kernel.org> wrote:
>>>> On Mon, Sep 26, 2022 at 02:02:49PM +0300, Dmitry Baryshkov wrote:
>>>>> The function psci_pd_try_set_osi_mode() will print an error if enabling
>>>>> OSI mode fails. To ease debugging PSCI issues print corresponding
>>>>> message if switching to PC mode fails too.
>>>>>
>>>>> Acked-by: Mark Rutland <mark.rutland@arm.com>
>>>>> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
>>>>> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>>>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
>>>>> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
>>>>> index 9fdcb6bff403..42cae0ba10e2 100644
>>>>> --- a/drivers/firmware/psci/psci.c
>>>>> +++ b/drivers/firmware/psci/psci.c
>>>>> @@ -164,6 +164,8 @@ int psci_set_osi_mode(bool enable)
>>>>>                        PSCI_1_0_SUSPEND_MODE_PC;
>>>>>
>>>>>        err = invoke_psci_fn(PSCI_1_0_FN_SET_SUSPEND_MODE, suspend_mode, 0, 0);
>>>>> +     if (err < 0)
>>>>> +             pr_warn("failed to set %s mode: %d\n", enable ? "OSI" : "PC", err);
>>>>>        return psci_to_linux_errno(err);
>>>>>   }
>>>>
>>>> When booting 6.1-rc1 I now see:
>>>>
>>>>          [    0.000000] psci: OSI mode supported.
>>>>          [    0.000000] psci: failed to set PC mode: -3
>>>>
>>>> on every boot with sc8280xp, while later enabling OSI mode still works:
>>>>
>>>>          [    0.227358] CPUidle PSCI: psci_pd_try_set_osi_mode - success
>>>>          [    0.227599] CPUidle PSCI: Initialized CPU PM domain topology
>>>>
>>>> Judging from Sudeep's comment on v1:
>>>>
>>>>          The platform must boot in PC mode, so even if it fails we ignore
>>>>          so not sure if the logging is of much help here IMO.
>>>>
>>>> perhaps logging this as an error is not a good idea?
>>
>> As far as I understand, some of the Qualcomm platforms booted in the
>> OSI mode, no matter what the spec says. I'm not sure about the
>> sc8280xp, but it definitely was the case previously. This was the
>> primary reason for adding a log here.
>>
>>> I think it's useful to get information that the FW doesn't fully
>>> conform to the spec (it should support PC mode), but that doesn't
>>> really mean that it can't work.
>>>
>>> To me, it sounds like we should move the logging to the debug level!?
>>
>> I'd say, either ignore the error, or move the warning to the info or
>> debug level.
> 
> "Ignore the error" as in removing the warning or as in telling every
> owner of an X13s Thinkpad to ignore it?
> 
> If there's nothing that can be done about it and this is nothing to
> worry about, then moving to debug level would seem like the right thing
> to do here. At least for the PC case.

Feel free to send the patch. I'd maybe use dev_info rather than dev_dbg, 
to let the user have a chance of seeing the warning.

Regarding telling every user to ignore the warning. This is not 
something new. E.g. each time I boot my ThinkPad, I see two or three 
warning messages related to TPM, despite having 'quiet' in kernel boot args.

> 
> Johan

-- 
With best wishes
Dmitry

