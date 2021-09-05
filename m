Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2AF5400EB0
	for <lists+linux-pm@lfdr.de>; Sun,  5 Sep 2021 10:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbhIEI15 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Sep 2021 04:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhIEI14 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 Sep 2021 04:27:56 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF784C061575;
        Sun,  5 Sep 2021 01:26:53 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id f2so5883890ljn.1;
        Sun, 05 Sep 2021 01:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3tvo3J3942E4VsuL9ZJAAqa2AJ6sN7eUZtJ5s5pXznk=;
        b=WaHtF7+LYsp3v41+oS/CX4ibBjTX4fxadTbSttVf2mV4Muv1goqrOERodBjIepnSzd
         ptKBWYQkduNsr5NH/draU0oLGCsF9B1HFwCI/8qu+7kC/0oHyzy0BXN3C9VMEzHgoja2
         nvJ7HhkjeQF4Qz2D+ynyww2PffNjUEWHNVe2VqaYYFHd6+HCA3cKXwGQZwDFEFM5g4WC
         ex4VVy1wiP4v0NO4ZgGmAE/UMdOpeIr51fB1U/JIPCnOP748UQyhCvsa/8BQPXJKzkb/
         wCNASjRWXt0VkfIrhs1b0Y/etHTfG0eH4J0n1S9q6uN7sbOw46Oy3ykM6zkGx1fgH2dd
         9P9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3tvo3J3942E4VsuL9ZJAAqa2AJ6sN7eUZtJ5s5pXznk=;
        b=FjIyzfFyahveHGNf4qe7ziUWj3veOm4EyWtPmKYCwUl/NcuqSfyimBtNjQmqBiX+vY
         caTe3HeY8L6ZLmccvE4vZbnfvb+9mTbpy4yP4aKjZfv1ZdOxNJstL7K7pFJeMhnSl2U7
         6l60vCF3MpuwKE94J2fDlQWkWZDrwW1lmMtENoGrmTts9Hft0BCWuzuu/yokeThpZQcw
         xYetf5J+qKKfNPEESdKBbG6fybe6mDzMaQfJUU58LEljF0Buh3aNvpyfvgCdlCXRk+nn
         HBXUO4xDWrdSwfJhZu60BRpppqfGA2q8K7b3/CTr0zyn5Ldl+bKzZ4q+4ad4VTGsSgvc
         Fd9w==
X-Gm-Message-State: AOAM533NhHDDoaNr0ianUN1BbPVrv/26iNaoxU4ExHigWlkNuvyvL+c1
        gstfDcWpPBhYNaetNHJRLFxHhBU73+Y=
X-Google-Smtp-Source: ABdhPJyFHIxejiLyLxvAbqi462Pi2zvigHths9Bwcv6gBz8tqLSM8JtXg0S0qqLzJoL1ZiqPcPWY5A==
X-Received: by 2002:a2e:6c05:: with SMTP id h5mr6030186ljc.73.1630830411883;
        Sun, 05 Sep 2021 01:26:51 -0700 (PDT)
Received: from [192.168.2.145] (46-138-3-129.dynamic.spd-mgts.ru. [46.138.3.129])
        by smtp.googlemail.com with ESMTPSA id h13sm435979lfv.62.2021.09.05.01.26.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Sep 2021 01:26:51 -0700 (PDT)
Subject: Re: [PATCH 1/3] PM: domains: Drop the performance state vote for a
 device at detach
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210902101634.827187-1-ulf.hansson@linaro.org>
 <20210902101634.827187-2-ulf.hansson@linaro.org>
 <08335cd4-7dc8-3b8b-d63f-374585ffa373@gmail.com>
 <CAPDyKFofrEj2LdqXh-L256b2Tcz=qYQgzTUBVuvx0rOR58SrVg@mail.gmail.com>
 <b597c805-e346-8c23-5014-cbb116e88075@gmail.com>
 <CAPDyKFrWofUKhbhvwTCjiFwJD8-Pzi8UMzU7ZjYLKm2j1HeeBg@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <6603212d-f36c-afff-6222-8125de5b7b79@gmail.com>
Date:   Sun, 5 Sep 2021 11:26:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrWofUKhbhvwTCjiFwJD8-Pzi8UMzU7ZjYLKm2j1HeeBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

03.09.2021 17:03, Ulf Hansson пишет:
> On Fri, 3 Sept 2021 at 11:58, Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> 03.09.2021 11:22, Ulf Hansson пишет:
>>> On Fri, 3 Sept 2021 at 08:01, Dmitry Osipenko <digetx@gmail.com> wrote:
>>>>
>>>> 02.09.2021 13:16, Ulf Hansson пишет:
>>>>> When a device is detached from its genpd, genpd loses track of the device,
>>>>> including its performance state vote that may have been requested for it.
>>>>>
>>>>> Rather than relying on the consumer driver to drop the performance state
>>>>> vote for its device, let's do it internally in genpd when the device is
>>>>> getting detached. In this way, we makes sure that the aggregation of the
>>>>> votes in genpd becomes correct.
>>>>
>>>> This is a dangerous behaviour in a case where performance state
>>>> represents voltage. If hardware is kept active on detachment, say it's
>>>> always-on, then it may be a disaster to drop the voltage for the active
>>>> hardware.
>>>>
>>>> It's safe to drop performance state only if you assume that there is a
>>>> firmware behind kernel which has its own layer of performance management
>>>> and it will prevent the disaster by saying 'nope, I'm not doing this'.
>>>>
>>>> The performance state should be persistent for a device and it should be
>>>> controlled in a conjunction with runtime PM. If platform wants to drop
>>>> performance state to zero on detachment, then this behaviour should be
>>>> specific to that platform.
>>>
>>> I understand your concern, but at this point, genpd can't help to fix this.
>>>
>>> Genpd has no information about the device, unless it's attached to it.
>>> For now and for these always on HWs, we simply need to make sure the
>>> device stays attached, in one way or the other.
>>
>> This indeed requires to redesign GENPD to make it more coupled with a
>> device, but this is not a real problem for any of the current API users
>> AFAIK. Ideally the state should be persistent to make API more universal.
> 
> Right. In fact this has been discussed in the past. In principle, the
> idea was to attach to genpd at device registration, rather than at
> driver probe.
> 
> Although, this is not very easy to implement - and it seems like the
> churns to do, have not been really worth it. At least so far.
> 
>>
>> Since for today we assume that device should be suspended at the time of
>> the detachment (if the default OPP state isn't used), it may be better
>> to add a noisy warning message if pstate!=0, keeping the state untouched
>> if it's not zero.
> 
> That would just be very silly in my opinion.
> 
> When the device is detached (suspended or not), it may cause it's PM
> domain to be powered off - and there is really nothing we can do about
> that from the genpd point of view.
> 
> As stated, the only current short term solution is to avoid detaching
> the device. Anything else, would just be papering of the issue.

What about to re-evaluate the performance state of the domain after
detachment instead of setting the state to zero? This way PD driver may
take an action on detachment if performance isn't zero, before hardware
is crashed, for example it may emit a warning.
