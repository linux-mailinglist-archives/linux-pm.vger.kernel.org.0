Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6D85E86A
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2019 18:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfGCQJM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jul 2019 12:09:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34212 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfGCQJM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jul 2019 12:09:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id u18so3493746wru.1;
        Wed, 03 Jul 2019 09:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=FghGomYaaEJOMCmNbnyvpr8Ipx9auLq3wlZaxaVMAxg=;
        b=A8hNKHTdRT+S1Z+ArIQZl+P0QBH2pZBM5nT6461O4WtQOE3aIOSUOWQmI64JzssluR
         D6mcK7vwjqoKi1FABzme9tdkrIeTYfhpT79cnu7qtJn/JfySEdeKoxf7Su8DaMHDPMrL
         fUvq1tqgHUFcPd++8wWKr4M0xqpjwzQ22Ao5OOXSwSkUezQcr3vfViN9PXpvrB9i5nEH
         O+vcQ8GYXMGzfBO0/bz8eLLcSLAiDap3n3/ZSudsg8wEGqZShpXL1zh3jonTM8zYYekv
         WfTP+4PmKtkJ6m5uFyzhw5kB0BFqSYFt7ezUhiWaYhXhU20bXh0v9qBLnrqzqEc28Gpr
         Ye0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=FghGomYaaEJOMCmNbnyvpr8Ipx9auLq3wlZaxaVMAxg=;
        b=LytxGLUTJI26PPTjNTIDmAopCunCoRl+QK99fs28hnGyzfqDbooePMUiUWwNAvz4rs
         cOywUFi+P67Qdj7+ewQ/p+SweYwAjYW/+oejDddD1Lh5FAeYh0UbYwtWw1iReO4+abYf
         GWCEduoSlRVH2or3GT0CCBYXTWSyQv4nUCskKHVOYS2EWtYxTYgZ/HMQrLYPsr+E/aMF
         /q7R9j9m2rP5GxcCCK6lQqtyPs4OHM6xoZDTxctVZkX+ses6c7WFznco6DS7CdK9Vzf4
         22phYjRFXWXSWyjLx+fM3ay/kI0XhxOJozn3IimaPksDNbJn9j9p/ERCNQRSGocIEXxx
         99Vw==
X-Gm-Message-State: APjAAAUMCaGYhXIXfzKAWZx4/zn0rYHipbSXrMdiIllA12E/wjb7JDZS
        vBs1V9fwTSzo9e91lvzIhEmFp6zy
X-Google-Smtp-Source: APXvYqzsrCBUZKOblr1ULtQrO8CRaQzDzKrCIpwXueEUhjCPmNLEZ8ckT1gXdDnrelmJLmCO9O9A0Q==
X-Received: by 2002:a5d:4941:: with SMTP id r1mr28533919wrs.225.1562170149695;
        Wed, 03 Jul 2019 09:09:09 -0700 (PDT)
Received: from [172.16.1.192] (host-89-243-246-11.as13285.net. [89.243.246.11])
        by smtp.gmail.com with ESMTPSA id o6sm4567679wra.27.2019.07.03.09.09.08
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 09:09:08 -0700 (PDT)
From:   Alan Jenkins <alan.christopher.jenkins@gmail.com>
Subject: Re: NO_HZ_IDLE causes consistently low cpu "iowait" time (and higher
 cpu "idle" time)
To:     Doug Smythies <dsmythies@telus.net>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <2ff025f1-9a3e-3eae-452b-ef84824009b4@gmail.com>
 <000001d531a8$8931b2a0$9b9517e0$@net>
Message-ID: <bc2f8d97-9462-125f-9fa2-49044c244479@gmail.com>
Date:   Wed, 3 Jul 2019 17:09:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <000001d531a8$8931b2a0$9b9517e0$@net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03/07/2019 15:06, Doug Smythies wrote:
> On 2019.07.01 08:34 Alan Jenkins wrote:
>
>> Hi
> Hi,
>
>> I tried running a simple test:
>>
>>      dd if=testfile iflag=direct bs=1M of=/dev/null
>>
>> With my default settings, `vmstat 10` shows something like 85% idle time
>> to 15% iowait time. I have 4 CPUs, so this is much less than one CPU
>> worth of iowait time.
>>
>> If I boot with "nohz=off", I see idle time fall to 75% or below, and
>> iowait rise to about 25%, equivalent to one CPU.  That is what I had
>> originally expected.
>>
>> (I can also see my expected numbers, if I disable *all* C-states and
>> force polling using `pm_qos_resume_latency_us` in sysfs).
>>
>> The numbers above are from a kernel somewhere around v5.2-rc5.  I saw
>> the "wrong" results on some previous kernels as well.  I just now
>> realized the link to NO_HZ_IDLE.[1]
>>
>> [1]
>> https://unix.stackexchange.com/questions/517757/my-basic-assumption-about-system-iowait-does-not-hold/527836#527836
>>
>> I did not find any information about this high level of inaccuracy. Can
>> anyone explain, is this behaviour expected?
> I'm not commenting on expected behaviour or not, just that it is
> inconsistent.
>
>> I found several patches that mentioned "iowait" and NO_HZ_IDLE. But if
>> they described this problem, it was not clear to me.
>>
>> I thought this might also be affecting the "IO pressure" values from the
>> new "pressure stall information"... but I am too confused already, so I
>> am only asking about iowait at the moment :-).
> Using your workload, I confirm inconsistent behaviour for /proc/stat
> (which vmstat uses) between kernels 4.15, 4.16, and 4.17:
> 4.15 does what you expect, no matter idle states enabled or disabled.
> 4.16 doesn't do what you expect regardless. (although a little erratic.)
>> = 4.17 does what you expect with only idle state 0 enabled, and doesn't otherwise.
> Actual test data vmstat (/proc/stat) (8 CPUs, 12.5% = 1 CPU)):
> Kernel	idle/iowait %	Idle states >= 1
> 4.15		88/12			enabled
> 4.15		88/12			disabled
> 4.16		99/1			enabled
> 4.16		99/1			disabled
> 4.17		98/2			enabled
> 4.17		88/12			disabled
>
> Note 1: I never booted with "nohz=off" because the tick never turns off for
> idle state 0, which is good enough for testing.
>
> Note 2: Myself, I don't use /proc/stat for idle time statistics. I use:
> /sys/devices/system/cpu/cpu*/cpuidle/state*/time
> And they seem to always be consistent at the higher idle percentage number.
>
> Unless someone has some insight, the next step is kernel bisection,
> once for between kernel 4.15 and 4.16, then again between 4.16 and 4.17.
> The second bisection might go faster with knowledge gained from the first.
> Alan: Can you do kernel bisection? I can only do it starting maybe Friday.
>
> ... Doug

Thanks for your help Doug!

I wish I had a faster CPU :-), but I'm familiar with bisection. I have 
started and I'm down to about 8 minute builds, so I can probably be done 
before Friday.

Alan
