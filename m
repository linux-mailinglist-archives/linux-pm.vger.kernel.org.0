Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D62E6190688
	for <lists+linux-pm@lfdr.de>; Tue, 24 Mar 2020 08:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgCXHpQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Mar 2020 03:45:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39325 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgCXHpQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Mar 2020 03:45:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id p10so7736876wrt.6;
        Tue, 24 Mar 2020 00:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qci9XDXfWr/HtNuJb/URwHsIBl1KAyOcw5r2EEPe4OA=;
        b=I3k6E4kTXlpEyCG4zZax4of4JG0UshTfnuN0hOhs9x2tVgT294w7YwJRMn17L8INL7
         YgCAdR7Nfhp8wHsxc5z2PP6Z8/T5E5WFKoWSxgprrh/D+g3B56t8OVoXqJKYWBvshMtY
         3jfIV75jC9FZBMLXBYFgqH06uFGA6FcqO3R1PWaxfKt/rCIWiIbE2Pg8V9r6csuAwhOm
         24z3LD5bzaOmXqYGEeau9zekMiZf06Ig1Mz1qZXTLzjGRqe3NNNGn9NldYcCKXPsTVYh
         7fCJZNTtPctupBnkQsCZTp9p6HoWZncj4jcWLb1uFG4lm5gnjEEffEQGactchwNTNfoq
         DK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qci9XDXfWr/HtNuJb/URwHsIBl1KAyOcw5r2EEPe4OA=;
        b=lX0UPMt3xvvsFi7gKv3GQmEripuhonMZsYL1Bc+dc3azn4gsz+lFhbyAQQMIqC/USj
         4tNP2RhsH+RotpMqh1+SPLwQ5aTqc3tDix41vgB17y5uBTlgx8VaUe9NZVETsgk9KQaz
         T/jbpKV7xFEEK6loWEMlA0jRs03+VkVgXmAcVotOM6M9aTTKn8s5eztheO7exGEfMLf3
         Y6GLmHLUR3sPnmdSYweSopse5RMtyLSsCF60fU9EvSbDJzE+4MdZT5KZyWadxaNlDeRR
         8uZ9DoZLCuJ3593fwXnsCJrmqK21X5tfAGEw+Gm3ooy9sVkNL4ciyct1WvBlLcZNU6df
         K73g==
X-Gm-Message-State: ANhLgQ3FYHaWKx8/6KDm2qfIG5UmJHiNUrsnp+bb/Caa6m5VblYAmy3v
        okexZsMHLYvSaJeu1cST+LL/ObZF
X-Google-Smtp-Source: ADFU+vuf7kJDz9bLjRXO6tfvufZAxHskal0rnkpg5yX5WMWq9CUG50AtkiQT21qDpvbo3C0DYAsUPQ==
X-Received: by 2002:adf:fc4c:: with SMTP id e12mr31792310wrs.265.1585035913925;
        Tue, 24 Mar 2020 00:45:13 -0700 (PDT)
Received: from macbook-pro.local (181.4.199.77.rev.sfr.net. [77.199.4.181])
        by smtp.gmail.com with ESMTPSA id z19sm6456766wrg.28.2020.03.24.00.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 00:45:13 -0700 (PDT)
Date:   Tue, 24 Mar 2020 07:45:12 +0000
From:   Willy Wolff <willy.mh.wolff.ml@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J.Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] thermal/drivers/cpufreq_cooling: Fix return of
 cpufreq_set_cur_state
Message-ID: <20200324074512.toikwgebhwbfo5xs@macbook-pro.local>
References: <20200321092740.7vvwfxsebcrznydh@macmini.local>
 <CAHLCerOFg30GEaQgV=4ccgA1fG6P3OTgaG33pw-3YCtuD5mSmA@mail.gmail.com>
 <b30a2e5b-5fa6-9761-efe1-d3b5396ceaaa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b30a2e5b-5fa6-9761-efe1-d3b5396ceaaa@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Many thanks.

On Mon, Mar 23, 2020 at 10:08:38PM +0100, Daniel Lezcano wrote:
>On 23/03/2020 22:05, Amit Kucheria wrote:
>> Hi Willy,
>>
>> On Sat, Mar 21, 2020 at 2:57 PM Willy Wolff <willy.mh.wolff.ml@gmail.com> wrote:
>>>
>>> The function freq_qos_update_request returns 0 or 1 describing update
>>> effectiveness, and a negative error code on failure. However,
>>> cpufreq_set_cur_state returns 0 on success or an error code otherwise.
>>>
>>
>> Please improve the commit message with context from your earlier bug
>> report thread and a summary of how the problem shows up.
>
>I've improved the commit message when applied:
>
>https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/commit/?h=testing&id=ff44f672d74178b3be19d41a169b98b3e391d4ce
>
>>> Signed-off-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>
>>> ---
>>>  drivers/thermal/cpufreq_cooling.c | 6 ++++--
>>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
>>> index fe83d7a210d4..af55ac08e1bd 100644
>>> --- a/drivers/thermal/cpufreq_cooling.c
>>> +++ b/drivers/thermal/cpufreq_cooling.c
>>> @@ -431,6 +431,7 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
>>>                                  unsigned long state)
>>>  {
>>>         struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
>>> +       int ret;
>>>
>>>         /* Request state should be less than max_level */
>>>         if (WARN_ON(state > cpufreq_cdev->max_level))
>>> @@ -442,8 +443,9 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
>>>
>>>         cpufreq_cdev->cpufreq_state = state;
>>>
>>> -       return freq_qos_update_request(&cpufreq_cdev->qos_req,
>>> -                               get_state_freq(cpufreq_cdev, state));
>>> +       ret = freq_qos_update_request(&cpufreq_cdev->qos_req,
>>> +                                     get_state_freq(cpufreq_cdev, state));
>>> +       return ret < 0 ? ret : 0;
>>>  }
>>>
>>>  /* Bind cpufreq callbacks to thermal cooling device ops */
>>> --
>>> 2.20.1
>>>
>
>
>-- 
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>
>Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
><http://twitter.com/#!/linaroorg> Twitter |
><http://www.linaro.org/linaro-blog/> Blog
>
