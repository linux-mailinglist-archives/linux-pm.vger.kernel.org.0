Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECA8449815
	for <lists+linux-pm@lfdr.de>; Mon,  8 Nov 2021 16:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238998AbhKHPZc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Nov 2021 10:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbhKHPZ3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Nov 2021 10:25:29 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0387C061714
        for <linux-pm@vger.kernel.org>; Mon,  8 Nov 2021 07:22:44 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id n66so4480820oia.9
        for <linux-pm@vger.kernel.org>; Mon, 08 Nov 2021 07:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=g/Jzi4/bsCpORi3XVmLRvQb2/I7DBGZkp7KCpuyf5T4=;
        b=mwH7FrqfQHnXKY5/RCDBKF2ggnIJcEyODdypMgivJ6eQLdASF6Hwkjw3j5vZk9kv0j
         EGZnIsoaH/xgkRkINylGmDaZMfPtv07Jq6XIvgIctnr/nRWCHbl2sUHKp/7FYlI+/cF+
         P2V07ztnCG2SdGzcI26Gd24RsTx8znOcyNBH/jePoOI5JDZPAXFDs+PfgixGFeCt70o7
         98mL+hZWz4UGgFtzGH9I8ZXm9vivkR1XFZcuQ7ZDu/lw3rRiQdKVurksZ7gzDlynnSts
         alGl5qGDn8/MyKSfW+/q4YxhmzspH2JzpAyaLSkEDyjgPGPt7LtlxCW9Xr9l8UGlYZRc
         PEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=g/Jzi4/bsCpORi3XVmLRvQb2/I7DBGZkp7KCpuyf5T4=;
        b=2vj9OjZULvI+9Q+DIImhRV6sTyErl6S0/NCVKspeblN4OsiVNpet4tlzM557SSLswR
         46JYMHk+NNqIbdY+bwYaTGpjAIlF0LMorx5jImAsaUk5ENwdiLtzcJaiZinpl+EsRbg9
         PyOIU2BlWNwtVL/PvMPu2S1/lr8p8GV/1XLKJDaHuJDPF/8gzkL/x3wQcPe/eRIWzk8b
         2cNvsOJdPgbDhT3HOTqXD7ODTKLn6oDilPPoGxM0Rt3/3pJOcAk0WbXHEYWDJtbNTxMB
         asZBFAvh3I4MDUTFgE/sLrkv+0xQprWNrol4sbV5XoydlLoW0yFh7rVx8WBM8YkVtgwR
         bHwA==
X-Gm-Message-State: AOAM530z6wvRDLZQ04y5ItMO32gy7CA4DdtYVPEB2WeNsTpvo07GhQ7R
        LmVoR2b28m+89QrkDR2QaljtvQ==
X-Google-Smtp-Source: ABdhPJyA6CRh1gldV9oc+Y86Ziq8FBRBvK1+8E1GkBSCwavEQvBLlT9jJop8RTiuLa1QL65Gd4rWOA==
X-Received: by 2002:a05:6808:d53:: with SMTP id w19mr23526832oik.19.1636384964280;
        Mon, 08 Nov 2021 07:22:44 -0800 (PST)
Received: from [192.168.11.48] (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id e2sm5524291ooh.40.2021.11.08.07.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Nov 2021 07:22:43 -0800 (PST)
Message-ID: <eac00041-a1b8-0780-931d-52249d538800@kali.org>
Date:   Mon, 8 Nov 2021 09:22:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH v3 0/5] Refactor thermal pressure update to avoid code
 duplication
Content-Language: en-US
To:     Thara Gopinath <thara.gopinath@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, sudeep.holla@arm.com,
        will@kernel.org, catalin.marinas@arm.com, linux@armlinux.org.uk,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        viresh.kumar@linaro.org, amitk@kernel.org,
        daniel.lezcano@linaro.org, amit.kachhap@gmail.com,
        bjorn.andersson@linaro.org, agross@kernel.org
References: <20211103161020.26714-1-lukasz.luba@arm.com>
 <c7b526f0-2c26-0cfc-910b-3521c6a6ef51@kali.org>
 <3cba148a-7077-7b6b-f131-dc65045aa348@arm.com>
 <9d533b6e-a81c-e823-fa6f-61fdea92fa65@kali.org>
 <74ea027b-b213-42b8-0f7d-275f3b84712e@linaro.org>
 <74603569-2ff1-999e-9618-79261fdb0ee4@kali.org>
 <b7e76c2a-ceac-500a-ff75-535a3f0d51d6@linaro.org>
 <f955a2aa-f788-00db-1ed8-dc9c7a1b2572@kali.org>
 <59054c90-c1cd-85bf-406e-579df668d7b4@linaro.org>
From:   Steev Klimaszewski <steev@kali.org>
In-Reply-To: <59054c90-c1cd-85bf-406e-579df668d7b4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


> Hi Steev,
>
> So this depends on the cpufreq governor you are using. By-default arm 
> systems have sched-util governor enabled. This means you will scale up 
> to boost depending on cpu load and not always. If you want to ensure 
> you are always hitting boost frequency, you should enable performance 
> governor for cpufreq and try.
>
> Also since the defconfig has by default CPU_FREQ_STAT enabled, you 
> should be able to get statistics out of cpufreq to see the time spent 
> by a cpu in each frequency. I think cpufreq-info -s should give you 
> this info. If not, you can explicitly get it for each cpu from
>
> cat /sys/devices/system/cpu/cpu<X>/cpufreq/stats/time_in_state
>
> Regarding temperature, if you have applied all the patches in the 
> sdm845 LMh series and have LMh enabled, cpu throttling starts around 
> 95 degree C.
>
Hi Thara,

Indeed, I ended up finding the time_in_state when I was doing more 
digging after my last mail.  I do have the sdm845 LMh series and LMh 
enabled, however I don't think I've ever seen my system go above 90C here.

So a quick look, and... we are simply almost never getting the 2.95GHz 
at all, regardless of workload.  I saw Lukasz response as well about the 
math possibly being wrong, but I haven't had a chance.

Regarding the time in state - I went with policy4 instead of per cpu 
(for brevity sake) and it's here:

c630:~$ cat /sys/devices/system/cpu/cpufreq/policy4/stats/time_in_state
825600 225037
902400 92
979200 205
1056000 96
1209600 902
1286400 386
1363200 396
1459200 217
1536000 101
1612800 75
1689600 95
1766400 130
1843200 255
1920000 318
1996800 92
2092800 87
2169600 66
2246400 60
2323200 58
2400000 54
2476800 47
2553600 50
2649600 69
2745600 58
2841600 54619
2956800 5

So we spend *very* little time in 2.96GHz and this is after almost 14 
hours of uptime on the C630.  By comparison, on a Pinebook Pro where 
I've added in 2GHz as a boost frequency :

pinebook-pro:~$ cat 
/sys/devices/system/cpu/cpufreq/policy4/stats/time_in_state
408000 16084466
600000 27212
816000 32487
1008000 11331
1200000 13268
1416000 75078
1608000 18392
1800000 207266
2016000 648612

With the Pinebook Pro, which doesn't even come close to getting to 95C, 
we spend a lot more time in 2GHz.

-- steev

