Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF39C40072E
	for <lists+linux-pm@lfdr.de>; Fri,  3 Sep 2021 22:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350498AbhICU6b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Sep 2021 16:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350482AbhICU63 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Sep 2021 16:58:29 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C2AC061757
        for <linux-pm@vger.kernel.org>; Fri,  3 Sep 2021 13:57:27 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id q68so255571pga.9
        for <linux-pm@vger.kernel.org>; Fri, 03 Sep 2021 13:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=sxwuAxrtYJDjTWSV7OCCFJWZjU0Ifgp/ql+JDp+Z75E=;
        b=A578Fpol/RIHGMSTJHydtH7gUYnUCOgG/F7IruWJOGuZXz4hbwYoXRgqhuxfNwI1YL
         ENTUX7tBHoikw4wQW+6RVzFsqOpPdpWe0XVX7+rvURsCHqdWpIZ1NtpKiThAnBRMwbtR
         ijiXWLqJRghzTjxhDAhsHto+UjCY/wEBdRSW+A/sObq8DhS8nSZlSkSP+CUTJIdujMZg
         kipS6FXRAJSPGIIPX4Qrewn2R0/1xik1Vb+s9zBvd7LZy2zblMfiJ1p+xvmSxPqBbQ3A
         RrQVf2rzp0mQJZTkQPU8zikCJFz2w+xG0H2+ZO/MMTMVw/ANOZDcBcQkBUwnhPfTkJ4P
         ifOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sxwuAxrtYJDjTWSV7OCCFJWZjU0Ifgp/ql+JDp+Z75E=;
        b=a7cfpsY8cO0VbsmGZLUXuSzQACJd9vjIvkpKBGJWo8zcs+DaEbY/axwrTIjf5JEMh8
         tucWORQ9BL5ke2e32DlQJ4sP62fOaCgBKP7y9LF9TL0Jy4hUFwGzWJ4n0u9+X+m7fNJ8
         zsEzgd1v2+S3M7rXSFbMcsGi/zkKLJY+SWaspIFdVm4dbdowbD5d1zz+DVr3H8o2+lDp
         uc1zxnzLaDSXYfUzXqYTFzMYqgZde/VuWPbMZe9XyrCLZmHtZ7wJnb79exBfJ69e6dzz
         gSPkCMCuRVNKlSb29MjVuBWWAs9nGPudNlQrA0l9ULMzhN5kgt2WvE/VTgX6vNUABWLH
         teeQ==
X-Gm-Message-State: AOAM533oX2JuR7cu8CEsZ/rPHIlE4yQGhPsprRL2ltYB0I2YRAks+P73
        Uqubs4OwGQK9MBYi1GFA3bRdNzx5Lks24JgH
X-Google-Smtp-Source: ABdhPJykLVv6cszHvpqvclZtdskHuEsGCPbZnEmzQKojtCl9mb5oGxxDNlMWc0DgEXKcs2kYuZstWw==
X-Received: by 2002:a63:4c0e:: with SMTP id z14mr768854pga.427.1630702647104;
        Fri, 03 Sep 2021 13:57:27 -0700 (PDT)
Received: from ?IPv6:2600:380:7567:4da9:6143:c77c:a7ba:674d? ([2600:380:7567:4da9:6143:c77c:a7ba:674d])
        by smtp.gmail.com with ESMTPSA id p2sm256672pgd.84.2021.09.03.13.57.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 13:57:26 -0700 (PDT)
Subject: Re: Bug: d0e936adbd22 crashes at boot
From:   Jens Axboe <axboe@kernel.dk>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org
References: <942f4041-e4e7-1b08-3301-008ab37ff5b8@kernel.dk>
 <c56cde110210bec6537fe69b495334c6c70c814e.camel@linux.intel.com>
 <3ac87893-55ba-f2d4-bb1e-382868f12d4c@kernel.dk>
 <7f115f0476618d34b24ddec772acbbd7c0c4a572.camel@linux.intel.com>
 <767fe00f-bf31-1eb0-09cc-1be91c633bb4@kernel.dk>
 <d6bf08cbfd9f29ddb8cf29f522d68efc5c676624.camel@linux.intel.com>
 <903f2e71-983f-39b8-dd0b-d697616ab63e@kernel.dk>
Message-ID: <a6041178-e7d6-4ad9-b96a-91b4702d0305@kernel.dk>
Date:   Fri, 3 Sep 2021 14:57:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <903f2e71-983f-39b8-dd0b-d697616ab63e@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/3/21 2:41 PM, Jens Axboe wrote:
> On 9/3/21 12:00 PM, Srinivas Pandruvada wrote:
>> Hi Axobe,
>>
>> On Fri, 2021-09-03 at 09:00 -0600, Jens Axboe wrote:
>>> On 9/3/21 8:38 AM, Srinivas Pandruvada wrote:
>>>> On Fri, 2021-09-03 at 08:15 -0600, Jens Axboe wrote:
>>>>> On 9/3/21 8:13 AM, Srinivas Pandruvada wrote:
>>>>>> Hi Axboe,
>>>>>>
>>>>>> Thanks for reporting.
>>>>>> On Fri, 2021-09-03 at 07:36 -0600, Jens Axboe wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> Booting Linus's tree causes a crash on my laptop, an x1 gen9.
>>>>>>> This
>>>>>>> was
>>>>>>> a bit
>>>>>>> difficult to pin down as it crashes before the display is up,
>>>>>>> but I
>>>>>>> managed
>>>>>>> to narrow it down to:
>>>>>>>
>>>>>>> commit d0e936adbd2250cb03f2e840c6651d18edc22ace
>>>>>>> Author: Srinivas Pandruvada < 
>>>>>>> srinivas.pandruvada@linux.intel.com>
>>>>>>> Date:   Thu Aug 19 19:40:06 2021 -0700
>>>>>>>
>>>>>>>     cpufreq: intel_pstate: Process HWP Guaranteed change
>>>>>>> notification
>>>>>>>
>>>>>>> which crashes with a NULL pointer deref in
>>>>>>> notify_hwp_interrupt() -
>>>>>>>>
>>>>>>> queue_delayed_work_on().
>>>>>>>
>>>>>>> Reverting this change makes the laptop boot fine again.
>>>>>>>
>>>>>> Does this change fixes your issue?
>>>>>
>>>>> I would assume so, as it's crashing on cpudata == NULL :-)
>>>>>
>>>>> But why is it NULL? Happy to test patches, but the below doesn't
>>>>> look
>>>>> like
>>>>> a real fix and more of a work-around.
>>>>
>>
>> Please try the attached.
> 
> I'll give it a test spin right now. Please do add a Reported-by tag,
> though. That's always prudent.

And you can add Tested-by as well, it works for me.

-- 
Jens Axboe

