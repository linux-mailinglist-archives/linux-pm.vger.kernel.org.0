Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33C6865B70
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2019 18:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbfGKQYY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Jul 2019 12:24:24 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43518 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728557AbfGKQYY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jul 2019 12:24:24 -0400
Received: by mail-lj1-f193.google.com with SMTP id 16so6387039ljv.10;
        Thu, 11 Jul 2019 09:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YaiSKf6jDXBQ+iwpdhNZ3NvL5ZW2kQBel0XIiJfpy58=;
        b=raL9/O8actXIAtr2ISPnJSkPiSZ24FqLHsxKSGBjJMPSeBoFnAs/baQyy1DVgxmknl
         ifISmJiMRyMQ99voC+Fz1TxMPJc9HqgpCcTWNwAWHcgO4LBJKPKKPJmGEQ9ShLHE3c0L
         eY8Znu+S/K3pU7BOy8qaBQx663dlnb2IGauVsDI7svc85KoeQz9BnL9UWqfpBTCfaHL+
         7DM6IMuxqjio4oXFo5g55JU/bj+HnfUMs4PeYObDr4J1PqjBKNiyv2Di8yjGlZexu0OV
         J8N1EQ31Dcw9EKBSQvylBnv3/Ye5PFyjutcbnmzccbnhuK0cJ/+1p4Fc1r6Dt/pef2fI
         6Vlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YaiSKf6jDXBQ+iwpdhNZ3NvL5ZW2kQBel0XIiJfpy58=;
        b=Z3W9JMyrd7ntYZVZ/JmiStiycmZPC+9qaM2rJKI9TqllPfEc2DFIaFX/UjV2CNkU+C
         SWe1aZOVf2zNd84BlaDzw1ppQXfHugAj7kN/l1uC9UtQthmRmiHsnNgRWUSySLwTqIzk
         cdD9oCEWvJC7pzfetqXlB0SZE2Z/iSfkAzUp8mcEr9HTP0o1eYTKxh/KldGSGj9evfut
         q6Xz5Hr+2J6B0bvrJBV5h1uQ9jaTghZqrLkAA6Isoq6zl63heVscCzzzcfKBnacZjK7E
         LLBptZtaDqAmGwYygkroebdS8yM+nQsDLMBACnRoDFOYR3XZQ9MG+3NE5LQzMLdpokPe
         9qpA==
X-Gm-Message-State: APjAAAXl/LjpJHGMi4SN6Hlmz/ySYoeEh/uFPEGnl/oDeGHmyDB9d82T
        qQv0x6gBYzgbCaD97U+BGQ1w79j04rE=
X-Google-Smtp-Source: APXvYqzUqVs+CdvzaNdAMH6CNbgc5EGXRl/6Kuv1ha+1OnFCJ0qeWtpPDdULOmV8HgckbES7e2W5Lw==
X-Received: by 2002:a2e:8816:: with SMTP id x22mr3159361ljh.131.1562862262079;
        Thu, 11 Jul 2019 09:24:22 -0700 (PDT)
Received: from [84.217.172.154] (c-74afd954.51034-0-757473696b74.bbcust.telenor.se. [84.217.172.154])
        by smtp.gmail.com with ESMTPSA id o8sm266932lfi.15.2019.07.11.09.24.21
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 09:24:21 -0700 (PDT)
Subject: Re: The tick is active on idle adaptive-tick CPUs when
 /dev/cpu_dma_latency is used
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>
References: <79b247b3-e056-610e-9a07-e685dfdaa6c9@gmail.com>
 <7332404.L1nL2KBT3s@kreacher>
 <6ef6b96e-1772-6e80-60cf-eb57af618e99@gmail.com>
 <312565511.gEFFlSTcEG@kreacher>
From:   Thomas Lindroth <thomas.lindroth@gmail.com>
Message-ID: <2828f202-ae04-7069-c75f-328f52a8d938@gmail.com>
Date:   Thu, 11 Jul 2019 18:24:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <312565511.gEFFlSTcEG@kreacher>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/10/19 12:22 PM, Rafael J. Wysocki wrote:
> On Saturday, July 6, 2019 3:02:11 PM CEST Thomas Lindroth wrote:
>> On 7/6/19 1:06 PM, Rafael J. Wysocki wrote:
>>> The patch is below, but note that it adds the tick stopping overhead to the idle loop
>>> for CPUs that are not adaptive-tick and when PM QoS latency constraints are used
>>> which is not desirable in general.
>>>
>>> Please test it, but as I said above, the real solution appears to be to treat adaptive-tick
>>> CPUs in a special way in the idle loop.
>>>
>>> ---
>>>    drivers/cpuidle/governors/menu.c |   16 +++++-----------
>>>    1 file changed, 5 insertions(+), 11 deletions(-)
>>>
>>> Index: linux-pm/drivers/cpuidle/governors/menu.c
>>> ===================================================================
>>> --- linux-pm.orig/drivers/cpuidle/governors/menu.c
>>> +++ linux-pm/drivers/cpuidle/governors/menu.c
>>> @@ -302,9 +302,10 @@ static int menu_select(struct cpuidle_dr
>>>    	     !drv->states[0].disabled && !dev->states_usage[0].disable)) {
>>>    		/*
>>>    		 * In this case state[0] will be used no matter what, so return
>>> -		 * it right away and keep the tick running.
>>> +		 * it right away and keep the tick running if state[0] is a
>>> +		 * polling one.
>>>    		 */
>>> -		*stop_tick = false;
>>> +		*stop_tick = !!(drv->states[0].flags & CPUIDLE_FLAG_POLLING);
>>>    		return 0;
>>>    	}
>>>    
>>> @@ -395,16 +396,9 @@ static int menu_select(struct cpuidle_dr
>>>    
>>>    			return idx;
>>>    		}
>>> -		if (s->exit_latency > latency_req) {
>>> -			/*
>>> -			 * If we break out of the loop for latency reasons, use
>>> -			 * the target residency of the selected state as the
>>> -			 * expected idle duration so that the tick is retained
>>> -			 * as long as that target residency is low enough.
>>> -			 */
>>> -			predicted_us = drv->states[idx].target_residency;
>>> +		if (s->exit_latency > latency_req)
>>>    			break;
>>> -		}
>>> +
>>>    		idx = i;
>>>    	}
>>
>> I tested the patch and it appears to work. Idle CPUs now have ticks disabled even
>> when /dev/cpu_dma_latency is used.
> 
> OK, thanks, but as I said previously, you'd see the problem again with the PM QoS
> latency constraint set to 0, which is somewhat inconsistent.  Also, this fix is
> specific to the menu governor and the behavior should not depend on the
> governor here IMO, so I have another patch to try (appended).
> 
> Please test it (instead of the previous one) and report back.
> 
> ---
>   kernel/sched/idle.c |    3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Index: linux-pm/kernel/sched/idle.c
> ===================================================================
> --- linux-pm.orig/kernel/sched/idle.c
> +++ linux-pm/kernel/sched/idle.c
> @@ -191,7 +191,8 @@ static void cpuidle_idle_call(void)
>   		 */
>   		next_state = cpuidle_select(drv, dev, &stop_tick);
>   
> -		if (stop_tick || tick_nohz_tick_stopped())
> +		if (stop_tick || tick_nohz_tick_stopped() ||
> +		    !housekeeping_cpu(dev->cpu, HK_FLAG_TICK))
>   			tick_nohz_idle_stop_tick();
>   		else
>   			tick_nohz_idle_retain_tick();
> 

I tested this patch and it seems to work fine using the menu governor
and PM QoS latency constraints matching each C-state including 0.
I didn't test the TEO governor.
