Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D244006C8
	for <lists+linux-pm@lfdr.de>; Fri,  3 Sep 2021 22:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236839AbhICUm1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Sep 2021 16:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbhICUm1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Sep 2021 16:42:27 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30399C061757
        for <linux-pm@vger.kernel.org>; Fri,  3 Sep 2021 13:41:27 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so338351pjr.1
        for <linux-pm@vger.kernel.org>; Fri, 03 Sep 2021 13:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=dkiYCFVjwmJybf5JwViF3SzBrvupFdjsBCuydcFWyT8=;
        b=vgK43H1zn6Xvy5dwhpNC/VIfid81C34dA7jP6x0dx4VWZVYxTAsw1irYJkp+WF/sK8
         yq3JZRiFW3C+LGeziU41xfq1Cwd2PAI/npDO62tX1B2ptn9NEsMw9qO7HbWrddX6e8Ok
         x/9FisOn8rKwPKPe3xmsAoJ2LCRe3KFJ1fV9Fuip3SpssZ5abF9FbNzzIl3QIbg688BI
         CdQ3u6MOTnqIENG/Oe8AELp8NvkyNl4ZiFQVH9dyK3XzhDm+ljnZZmch0wQxspQAPxjz
         dCqsNDUYxpqvh0/bG1Y6Y0P3r+wCyRmzGibchEAkUkTcZK3Ocw6G8vDz5SlEoeSZenBZ
         YFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dkiYCFVjwmJybf5JwViF3SzBrvupFdjsBCuydcFWyT8=;
        b=EkKNnprS1IxCdqJ+jcucmoTkByqdjuFl5WAPbWXgDNtVkXpQMdY07VXaK/VC+SZZNV
         4R0MFnjpmeJ2jL5Dum/G3c1Py4Camsz1DGS5typvVNTbAiQW02KKvRrtsfcIFQXB/EHP
         SUyPeO/tkbCUo1MzUyb8ci2T1o0rQo3c/BdXpMHScHSftA8PugF+zfg5aLiaqn0OgByv
         8FQnyg8uvS+oLqvdcLOSb9tC3CniHp/96wJknPW1FRtsSrLtEzosnUlObzGiKGw7VjSK
         2Riip7cS8IJqksbGHg+UyV19AHhQGFUuzr/HW+2NmKvKjtAyPJ16ibRFUuoM5Jh10TAo
         3fYw==
X-Gm-Message-State: AOAM533dY2qg6NVgi02NfNSseA4PofKoEDOWFHGy5pcGkKlBpKmYGQLz
        OfMGFNmDzxR3+s+caOJSn1yYliu5OI9Xdobs
X-Google-Smtp-Source: ABdhPJzOOBaBftmLG3TgPcPUZNEjVQbPQAW4pR5s9MLa9p52tQlyZwiCWH7JEtNWCFCR3DMPX5Aypg==
X-Received: by 2002:a17:90b:116:: with SMTP id p22mr687216pjz.67.1630701686473;
        Fri, 03 Sep 2021 13:41:26 -0700 (PDT)
Received: from ?IPv6:2600:380:7567:4da9:ea68:953f:1224:2896? ([2600:380:7567:4da9:ea68:953f:1224:2896])
        by smtp.gmail.com with ESMTPSA id b5sm247811pfr.26.2021.09.03.13.41.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 13:41:25 -0700 (PDT)
Subject: Re: Bug: d0e936adbd22 crashes at boot
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
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <903f2e71-983f-39b8-dd0b-d697616ab63e@kernel.dk>
Date:   Fri, 3 Sep 2021 14:41:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d6bf08cbfd9f29ddb8cf29f522d68efc5c676624.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/3/21 12:00 PM, Srinivas Pandruvada wrote:
> Hi Axobe,
> 
> On Fri, 2021-09-03 at 09:00 -0600, Jens Axboe wrote:
>> On 9/3/21 8:38 AM, Srinivas Pandruvada wrote:
>>> On Fri, 2021-09-03 at 08:15 -0600, Jens Axboe wrote:
>>>> On 9/3/21 8:13 AM, Srinivas Pandruvada wrote:
>>>>> Hi Axboe,
>>>>>
>>>>> Thanks for reporting.
>>>>> On Fri, 2021-09-03 at 07:36 -0600, Jens Axboe wrote:
>>>>>> Hi,
>>>>>>
>>>>>> Booting Linus's tree causes a crash on my laptop, an x1 gen9.
>>>>>> This
>>>>>> was
>>>>>> a bit
>>>>>> difficult to pin down as it crashes before the display is up,
>>>>>> but I
>>>>>> managed
>>>>>> to narrow it down to:
>>>>>>
>>>>>> commit d0e936adbd2250cb03f2e840c6651d18edc22ace
>>>>>> Author: Srinivas Pandruvada < 
>>>>>> srinivas.pandruvada@linux.intel.com>
>>>>>> Date:   Thu Aug 19 19:40:06 2021 -0700
>>>>>>
>>>>>>     cpufreq: intel_pstate: Process HWP Guaranteed change
>>>>>> notification
>>>>>>
>>>>>> which crashes with a NULL pointer deref in
>>>>>> notify_hwp_interrupt() -
>>>>>>>
>>>>>> queue_delayed_work_on().
>>>>>>
>>>>>> Reverting this change makes the laptop boot fine again.
>>>>>>
>>>>> Does this change fixes your issue?
>>>>
>>>> I would assume so, as it's crashing on cpudata == NULL :-)
>>>>
>>>> But why is it NULL? Happy to test patches, but the below doesn't
>>>> look
>>>> like
>>>> a real fix and more of a work-around.
>>>
> 
> Please try the attached.

I'll give it a test spin right now. Please do add a Reported-by tag,
though. That's always prudent.

-- 
Jens Axboe

