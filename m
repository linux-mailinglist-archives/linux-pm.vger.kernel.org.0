Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDDD031B588
	for <lists+linux-pm@lfdr.de>; Mon, 15 Feb 2021 08:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbhBOHLa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Feb 2021 02:11:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhBOHL2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Feb 2021 02:11:28 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DD8C061574;
        Sun, 14 Feb 2021 23:10:46 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id u11so3181525plg.13;
        Sun, 14 Feb 2021 23:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kG7o9TXRTb0hxLW0YdJ/y+yccAFjnMWzFB3U1A5mywg=;
        b=n5uPaAdphFj4QWOsQ7YE0k42JmJVn0KpHhmDasMqYLqOUBk0hvpreMVp2XlINgmS8m
         D0DhLKdlO3Uyg70oqbZEHBqfrnlS8ZXrjbCmm8mQaC8GQ8V5aIEx91jzJiSd2nCNfpcF
         PmmFGHsy6EoT/VfaMCh61U/NpED90ecdAvGikCT4XvuRo0Wubm3tUkPLzDelCAFFUkho
         gBnO9J4oTs+hQD3aHSoc0Vuyzi2JHcX0F8Eaq+ZmFvjhkIzsIlvN2hLsIDMhZgjt3v+A
         IDIfQWAXMVvJHwQVByHWHp7LeiX2k8Y3ZtnDfrz3Te1YrGL4Tn2Ag1Ss0mJwuuWiSdAV
         xhMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kG7o9TXRTb0hxLW0YdJ/y+yccAFjnMWzFB3U1A5mywg=;
        b=EJlqXkqHAqiC3HnIoA2r6wk2VxPnEqNe8G9VZfwhFXOmpseuWQm9Q7x5QF0TvZNIgB
         Sdvo/0kM9cU5vZxHJxiEsO7rH8cOebhPLqfi5M1GM69VALJKsLn4qhWQP1gnn2KduRFJ
         ZIybEER+ff1amW28YDj/6XfZt/5BjHXdaeYrzZprQQvKTKjFq/2ZTfkE9f7zhuiY5RLH
         3MU0Lqeb0t/3vmUJ8OOZhARoviC6ZRq3WuVqTUKyzaYPvhcSztI3dcWpN8Z6fasfJqUh
         fkdVcboUHV6eXfggJzvOOASiYKkFpV3LMJrGvbPM8FPM+mkLLOlPR5qo2tWrH+04n+V7
         ZUPw==
X-Gm-Message-State: AOAM531mhx0kK64H/EHF9jOon7ZEuFJpH09Lz9nl7S3CGmaNbadAiTSR
        X984NTyfxGtCLdzTSqC9ono=
X-Google-Smtp-Source: ABdhPJwUCe1VPM98AwqzG6U1jkQqxJaLEIGzqICJmJISQUn7jriEXteS7abf5wkCrIv0rdNo2D+LSA==
X-Received: by 2002:a17:902:bccc:b029:de:8483:506d with SMTP id o12-20020a170902bcccb02900de8483506dmr13959966pls.53.1613373046565;
        Sun, 14 Feb 2021 23:10:46 -0800 (PST)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id x20sm16191527pfi.115.2021.02.14.23.10.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Feb 2021 23:10:46 -0800 (PST)
Date:   Mon, 15 Feb 2021 15:10:46 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Yue Hu <zbestahu@163.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yue Hu <huyue2@yulong.com>, zhangwen@yulong.com
Subject: Re: [PATCH] cpufreq: schedutil: Don't use the limits_changed flag
 any more
Message-ID: <20210215151046.00001894.zbestahu@gmail.com>
In-Reply-To: <20210215063008.hsdkrs4bw7wt3wye@vireshk-i7>
References: <20210208030723.781-1-zbestahu@gmail.com>
        <CAJZ5v0hmgQp--uhRMZbqZnOvQPy9zLfQx_u=xAewmV=LgT6rPA@mail.gmail.com>
        <20210214114421.00000550.zbestahu@163.com>
        <20210215063008.hsdkrs4bw7wt3wye@vireshk-i7>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 15 Feb 2021 12:00:08 +0530
Viresh Kumar <viresh.kumar@linaro.org> wrote:

> On 14-02-21, 11:44, Yue Hu wrote:
> > On Fri, 12 Feb 2021 17:14:03 +0100
> > "Rafael J. Wysocki" <rafael@kernel.org> wrote:  
> > > This may be running in parallel with sugov_update_next_freq() on a
> > > different CPU, so the latter may clear need_freq_update right
> > > after it has been set here unless I'm overlooking something.  
> > 
> > Whether this logic is also happening for limits_changed in
> > sugo_should_update_freq() or not?  
> 
> It is but it shouldn't have any side effects as we calculate the next
> frequency after cleaning the limits_changed flag. Your patch would
> have been fine, but it is not anymore because of commit 23a881852f3e
> ("cpufreq: schedutil: Don't skip freq update if need_freq_update is
> set").
> 
> It made a considerable change after which your patch adds a bug. With
> 23a881852f3e, need_freq_update is updated/cleared after the next
> frequency is calculated, while earlier it was cleared before it. And
> so even with the race condition taking place, there were no issues.
> 

Okay, clear.
