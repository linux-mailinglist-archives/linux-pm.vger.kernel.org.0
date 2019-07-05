Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA05A606AA
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2019 15:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfGENhu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jul 2019 09:37:50 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:53805 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbfGENht (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jul 2019 09:37:49 -0400
Received: by mail-wm1-f42.google.com with SMTP id x15so8904353wmj.3;
        Fri, 05 Jul 2019 06:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=3zwEJgoSUmVe32byVQps8G3aTPiQXc6LZjBXABq8q44=;
        b=STNcuqyr8wjN732QQ0JivchA5zRC+5J+onxTxiBuN7J+QzTvHanCgqQMz7SL4ebKBJ
         nW+FcY4gANgnOt2uyCG2gpmNyaPMmKlcEaYQKdL8DCiBt/E56gISV9uj/9lhBzogXBdX
         vP28nHvBi8ZZWpDn5VSVR+SbQ90gxCuDbBciGz0+Jxe2FL5V4SC6xADlE1qZvFtflqAD
         ZrzFJ2d19yWB1BuhliMAgvgvyM8I9YOjNQx/5qejTZ39xb1FtjOSZKdu0L8DOo/bDPNR
         3u6uVJPIOKPdonFoxLggidgGcwryaw0ZA9XmZwZLIs9Bobfm/6g4vfytqYor/ZGLUASC
         +OJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3zwEJgoSUmVe32byVQps8G3aTPiQXc6LZjBXABq8q44=;
        b=WXZA4F3I6a1BUpcT5rwlHe1h6NsVWLkRlkK2vBZvz6LfeZwcIOzLxsApjJJ5tSJ13Y
         ZIpJJ4Ab8aec+bweiqe9R8dkLGe8o8Jh1svtvX7NuBa8Qt2VS9f/4DMVUQCBcnm4eGgI
         B+RyRRj4ZwaqKJIw87iUc8ZDO7MEv4m0zHt2NR1md/v96iTPnnp43joX7OSQPC8PDgwE
         u2GcCLBTOIzx2DDhkJcWAtYIVu13gLi+CLlBl+GnvyYEYY1MTngXybBwgx6FNVCD17aG
         ++qOyCvD+oPScEKaMjD9FJRvR+C0XcSyTqjGunKwNE+jT6D0aHxa6hhoqkcOg9I/ZZF+
         eLow==
X-Gm-Message-State: APjAAAVrlxNgFH0NdVqCI/1dPyDqWOd7b2KKAalJOiTXIe4MtF3opKGe
        sLbyOYPd0MoD59dnWZE6MZPv9knc
X-Google-Smtp-Source: APXvYqxwPvjEjuUDkC6y/r7CpVN0m1xZdHiGATz+YFalWzlBkPKAZZPnQEe4s/ybG6e4VkQaIHNfMA==
X-Received: by 2002:a1c:2314:: with SMTP id j20mr3610354wmj.152.1562333867056;
        Fri, 05 Jul 2019 06:37:47 -0700 (PDT)
Received: from [172.16.8.139] (host-89-243-246-11.as13285.net. [89.243.246.11])
        by smtp.gmail.com with ESMTPSA id z25sm9958744wmf.38.2019.07.05.06.37.45
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jul 2019 06:37:45 -0700 (PDT)
Subject: Re: iowait v.s. idle accounting is "inconsistent" - iowait is too low
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Doug Smythies <dsmythies@telus.net>, linux-pm@vger.kernel.org
References: <2ff025f1-9a3e-3eae-452b-ef84824009b4@gmail.com>
 <000001d531a8$8931b2a0$9b9517e0$@net>
 <e82b9d7c-81e5-dd80-b9c0-f5f065344e2f@gmail.com>
 <20190705113806.GP3402@hirez.programming.kicks-ass.net>
From:   Alan Jenkins <alan.christopher.jenkins@gmail.com>
Message-ID: <26e7faef-7223-3ef8-d09c-e382223ce4fa@gmail.com>
Date:   Fri, 5 Jul 2019 14:37:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190705113806.GP3402@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05/07/2019 12:38, Peter Zijlstra wrote:
> On Fri, Jul 05, 2019 at 12:25:46PM +0100, Alan Jenkins wrote:
>> Hi, scheduler experts!
>>
>> My cpu "iowait" time appears to be reported incorrectly.  Do you know why
>> this could happen?
> Because iowait is a magic random number that has no sane meaning.
> Personally I'd prefer to just delete the whole thing, except ABI :/
>
> Also see the comment near nr_iowait():
>
> /*
>   * IO-wait accounting, and how its mostly bollocks (on SMP).
>   *
>   * The idea behind IO-wait account is to account the idle time that we could
>   * have spend running if it were not for IO. That is, if we were to improve the
>   * storage performance, we'd have a proportional reduction in IO-wait time.
>   *
>   * This all works nicely on UP, where, when a task blocks on IO, we account
>   * idle time as IO-wait, because if the storage were faster, it could've been
>   * running and we'd not be idle.
>   *
>   * This has been extended to SMP, by doing the same for each CPU. This however
>   * is broken.
>   *
>   * Imagine for instance the case where two tasks block on one CPU, only the one
>   * CPU will have IO-wait accounted, while the other has regular idle. Even
>   * though, if the storage were faster, both could've ran at the same time,
>   * utilising both CPUs.
>   *
>   * This means, that when looking globally, the current IO-wait accounting on
>   * SMP is a lower bound, by reason of under accounting.
>   *
>   * Worse, since the numbers are provided per CPU, they are sometimes
>   * interpreted per CPU, and that is nonsensical. A blocked task isn't strictly
>   * associated with any one particular CPU, it can wake to another CPU than it
>   * blocked on. This means the per CPU IO-wait number is meaningless.
>   *
>   * Task CPU affinities can make all that even more 'interesting'.
>   */

Thanks. I take those as being different problems, but you mean there is 
not much demand (or point) to "fix" my issue.

>  (2) Compare running "dd" with "taskset -c 1":
>
> %Cpu1  :  0.3 us,  3.0 sy,  0.0 ni, 83.7 id, 12.6 wa,  0.0 hi,  0.3 si,  0.0 st 

                                       ^ non-zero idle time for Cpu1, despite the pinned IO hog.


The block layer recently decided they could break "disk busy%" reporting 
for slow devices (mechanical HDD), in order to reduce overheads for fast 
devices.  This means the summary view in "atop" now lacks any reliable 
indicator.

I suppose I need to look in "iotop".

The new /proc/pressure/io seems to have caveats related to the iowait 
issues... it seems even more complex to interpret for this case, and it 
does not seem to work how I think it does.[1]

Regards
Alan

[1] 
https://unix.stackexchange.com/questions/527342/why-does-the-new-linux-pressure-stall-information-for-io-not-show-as-100/
