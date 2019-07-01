Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE1E5BFE8
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2019 17:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfGAPd4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jul 2019 11:33:56 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41340 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbfGAPd4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jul 2019 11:33:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so14362364wrm.8;
        Mon, 01 Jul 2019 08:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=wpaGBMR0ZnPZyn/D/Sm+4RGXSfbYpu+boXZvyCO/ODI=;
        b=A72xlDkgu71h7IfQmWnshd+7BB2J0hu16RQ587WNfdDxAg/KZJsP+9WO6hoRAWLfal
         xv4KcYpzmwCkzAqAAGXd0ZRSBMEYkJb50Y+zbjlXDrHjuyr/zDY65UHADADQG3HSzLtD
         qiNJlX9302oGNp3j1OihV+UPWXC1jTirZDG0zbTf6lrfRofA/z9rNZ6lM4o5J+gAuB9W
         Aj3V+7vHD9wdCFyNHgIrWdf6u0CrH7rEQ64b0q16QoihxNoY2dtgNrLc/a0ih8CraDPM
         k0Sx+d2dAPPcV2jjxRgVtiwzyT1srA4gRYHAsgpzfErdmtR0xzkl+VDLCowS1vya/ohS
         F2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=wpaGBMR0ZnPZyn/D/Sm+4RGXSfbYpu+boXZvyCO/ODI=;
        b=qmYSFMaMwpw6Pa2JYUJ4nHfZYGuDtk5Wy+Iz6e5tYz426DqMCbSo+JoKjGK9Len+IJ
         UzlpdZGIKQEUaTzn1X1QhHi7ePGY56p1pG0CfY1d/pV/gjdMpM4VellBizRcXQGyrSbO
         K35bl4v1WGlgqOSLlcozi72Ix0n6/xCA5/On7Fd5a+/aCUvr1qLXu1M5tGdjBNZFZtSo
         rN1wbWj1fJtCNKRylJr0meqbawXQGzHu2+MffCOxZpW8gIumloDCzeF5rNPRo/TE/0UB
         2DHlIegUe2ZCQf0Z1xpvG4StKekfisxy5fGzc86qWdSG/pt5ChFanAopdi2sdDTBPYNI
         cKxA==
X-Gm-Message-State: APjAAAXITVgrLFsDIJCPvdoXIlqsDwnC0QBljHLwBo1bUkgbjVyccqKf
        0mASQsCv9FI+5bxAFcaRmEjJyEtV
X-Google-Smtp-Source: APXvYqyuVuGCiK73ZnHWiEMsO7p5DGBpwkr+3ofW91YbXyDRrqVTPsSOz+oahhoYIvkBgMIrZvEaXA==
X-Received: by 2002:adf:da47:: with SMTP id r7mr3707425wrl.56.1561995233880;
        Mon, 01 Jul 2019 08:33:53 -0700 (PDT)
Received: from [172.16.1.192] (host-89-243-246-11.as13285.net. [89.243.246.11])
        by smtp.gmail.com with ESMTPSA id t14sm9268449wrr.33.2019.07.01.08.33.52
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 08:33:52 -0700 (PDT)
From:   Alan Jenkins <alan.christopher.jenkins@gmail.com>
Subject: NO_HZ_IDLE causes consistently low cpu "iowait" time (and higher cpu
 "idle" time)
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <2ff025f1-9a3e-3eae-452b-ef84824009b4@gmail.com>
Date:   Mon, 1 Jul 2019 16:33:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi

I tried running a simple test:

     dd if=testfile iflag=direct bs=1M of=/dev/null

With my default settings, `vmstat 10` shows something like 85% idle time 
to 15% iowait time. I have 4 CPUs, so this is much less than one CPU 
worth of iowait time.

If I boot with "nohz=off", I see idle time fall to 75% or below, and 
iowait rise to about 25%, equivalent to one CPU.  That is what I had 
originally expected.

(I can also see my expected numbers, if I disable *all* C-states and 
force polling using `pm_qos_resume_latency_us` in sysfs).

The numbers above are from a kernel somewhere around v5.2-rc5.  I saw 
the "wrong" results on some previous kernels as well.  I just now 
realized the link to NO_HZ_IDLE.[1]

[1] 
https://unix.stackexchange.com/questions/517757/my-basic-assumption-about-system-iowait-does-not-hold/527836#527836

I did not find any information about this high level of inaccuracy. Can 
anyone explain, is this behaviour expected?

I found several patches that mentioned "iowait" and NO_HZ_IDLE. But if 
they described this problem, it was not clear to me.

I thought this might also be affecting the "IO pressure" values from the 
new "pressure stall information"... but I am too confused already, so I 
am only asking about iowait at the moment :-).[2]

[2] 
https://unix.stackexchange.com/questions/527342/why-does-the-new-linux-pressure-stall-information-for-io-not-show-as-100/527347#527347

I have seen the disclaimers for iowait in 
Documentation/filesystems/proc.txt, and the derived man page. 
Technically, the third disclaimer might cover anything.  But I was 
optimistic; I hoped it was talking about relatively small glitches :-).  
I didn't think it would mean a large systematic undercounting, which 
applied to the vast majority of current systems (which are not tuned for 
realtime use).

|

> - iowait: In a word, iowait stands for waiting for I/O to complete. But there
>  are several problems:
>  1. Cpu will not wait for I/O to complete, iowait is the time that a task is
>     waiting for I/O to complete. When cpu goes into idle state for
>     outstanding task io, another task will be scheduled on this CPU.
>  2. In a multi-core CPU, the task waiting for I/O to complete is not running
>     on any CPU, so the iowait of each CPU is difficult to calculate.
>  3. The value of iowait field in /proc/stat will decrease in certain
>     conditions|


Thanks for all the power-saving code
Alan
