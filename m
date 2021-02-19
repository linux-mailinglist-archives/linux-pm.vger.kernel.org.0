Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D86E31F5C5
	for <lists+linux-pm@lfdr.de>; Fri, 19 Feb 2021 09:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhBSIVU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Feb 2021 03:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhBSIVS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Feb 2021 03:21:18 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71963C061574;
        Fri, 19 Feb 2021 00:20:38 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id o7so3341270pgl.1;
        Fri, 19 Feb 2021 00:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=70Qa5qu8viWhbYhSFeFN5ri6nlE2GDV9Vz/0GH/LwDI=;
        b=nrt+Y2WsvVO0D7cEhHYbFVm0q+96VOptxWKQwqyw4svU8f973uAX31MK9onlwcdO9v
         RqjDxQ6FTcJoaIBVV9lakZRhmpVL+ihOnc9pBq4CuAtqZlk7NXzTZ6fW1lnhh3iajsah
         dCeNg73G9FESua4DIA7pmDP7uS1xM1fbBVH7ebdRWCaDRRZxPhbQqeeJb06nISnfceeU
         bAuW44hyx+0oPC54nwn/RHi7gjhAZOsdUMCfSZ1jDgsU34jN7waEDww54W7gJu3y/5N9
         z8h7yMki2Tv/G0SjumM2swR5n38nLQY2wlb9ngZs5kyRcf9OhvI5N8Jk0AQLA6bWIn/S
         eUyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=70Qa5qu8viWhbYhSFeFN5ri6nlE2GDV9Vz/0GH/LwDI=;
        b=sqRGFXnDXtXLEhPw0gBMRyPTcUbn3051unrbAiwZ1k4wEDWmCd1S4nIhzOOH8IbqOM
         i0Av+vjusnqE9ghQ64KjvGIaZ+sZMDCxj1fnbs4sNBurVIbgt/O5VWE64RpxWx0GmWM3
         mKIII/R5NIOOk1eUPlonvFL4R+MYeL6JIEhoTIMt52vnAOOK/hkp7NS5e6ZtObXdN65q
         AIzZSp4Mt08+GqDqTQaUeooLJFkRAGCZHsRw1vpKRQtoaQmqqZdTUi51yBgmdhVz12Cy
         CwMghUoNc74x+pJW5AoD2nYoEanVygOADnfATOaA+UVyfgT5vWbyeMelcC0bJ1n/7geL
         d+aw==
X-Gm-Message-State: AOAM532k+hCKnAC71t4YnjL8Yb8KOPaZ8Pk8YprYjQkxzBTWr8a1ktMK
        oZX9JdRdPuEhHdOjALsmONo=
X-Google-Smtp-Source: ABdhPJzr731i/EYr4+IPpMCED5W29KVSVCbX+ktyWcwNydJX70PCgqCLgby31rXUSjBrLHgGAJY+2g==
X-Received: by 2002:a63:28c3:: with SMTP id o186mr7625185pgo.206.1613722837915;
        Fri, 19 Feb 2021 00:20:37 -0800 (PST)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id f23sm1329061pfa.5.2021.02.19.00.20.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Feb 2021 00:20:37 -0800 (PST)
Date:   Fri, 19 Feb 2021 16:20:26 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, zbestahu@163.com
Subject: Re: [PATCH] cpufreq: schedutil: Don't consider freq reduction to
 busy CPU if need_freq_update is set
Message-ID: <20210219162026.00002e2b.zbestahu@gmail.com>
In-Reply-To: <20210219074249.2hcwcnakihor343h@vireshk-i7>
References: <20210218082514.1437-1-zbestahu@gmail.com>
        <20210218102029.syj6vkltlbtoxsig@vireshk-i7>
        <20210219113804.00004a7e.zbestahu@gmail.com>
        <20210219040933.2o5hhbjb6emf3xl4@vireshk-i7>
        <20210219144140.00004de9.zbestahu@gmail.com>
        <20210219074249.2hcwcnakihor343h@vireshk-i7>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 19 Feb 2021 13:12:49 +0530
Viresh Kumar <viresh.kumar@linaro.org> wrote:

> On 19-02-21, 14:41, Yue Hu wrote:
> > On Fri, 19 Feb 2021 09:39:33 +0530
> > Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >   
> > > On 19-02-21, 11:38, Yue Hu wrote:  
> > > > There's a possibility: we will use the previous freq to update
> > > > if next_f is reduced for busy CPU if need_freq_update is set in
> > > > sugov_update_next_freq().    
> > > 
> > > Right.
> > >   
> > > > This possibility would happen now? And this
> > > > update is what we want if it happens?    
> > > 
> > > This is exactly what we want here, don't reduce speed for busy
> > > CPU,  
> > 
> > I understand it should not skip this update but set the same freq as
> > previous one again for the special case if need_freq_update is set.
> > Am i rt?  
> 
> The special check, about not reducing freq if CPU had been busy
> recently, doesn't have anything to do with need_freq_update.

However, we will skip the update if need_freq_update is not set. And do
the update if need_freq_update is set.

Note that there are unnecessary fast switch check and spin lock/unlock
operations in freq skip path.

If we consider unnecessary behaviors above, then we should return right
away rather than continue to execute following code.

Consequently, we also need to consider need_update_freq flag since we
need to update freq currently if it is set.

> 
> Though previously we added the need_freq_update check there to make
> sure we account for any recent policy min/max change and don't skip
> freq update anymore. That won't happen anymore and so we don't need
> any check here related to need_freq_update.
> 
> If you still have doubt, please explain your concern in detail with an
> example as I am failing to understand it.
> 

