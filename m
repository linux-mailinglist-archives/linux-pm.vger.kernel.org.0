Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 500121CF8A1
	for <lists+linux-pm@lfdr.de>; Tue, 12 May 2020 17:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgELPL1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 May 2020 11:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgELPL1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2020 11:11:27 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E442AC061A0C
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2020 08:11:25 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id z72so14172513wmc.2
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2020 08:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LyoECAT36i8bO5QxWOOhIIYUcxOgBZAsoJFxVPKvt6I=;
        b=ZKR2a98xYHPdTkB+W2l2sMwRBoJk77ZyEzNIwcoGwiKV9bAbweE4tLsR9g7cG1Bm+F
         6qibsKpJARmJxO9FyFgpcohBYQrEA6Pwo6uOLcLhntSmxoOtJetL2YfJRzu8JuA+wLC/
         4hDdu2gRASZpm1CgGZHVJ/8PMd5lCSBo6Aw2PmNuueWRwrIYS3e5SDhNkXNJ+kszNIwa
         qSTGoe7iIoaGQBy6QZxLYfYz8Jj1PPstLjXUiGW6rTELuPzBdgLnUgODxzA0/SfdNrpM
         QRI24qiGd+gEzSdn6KOjwohgrJaGKGmBIPsSaXMXYqf7gJHDtKdCdPtsYnK1mndR9uep
         qOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LyoECAT36i8bO5QxWOOhIIYUcxOgBZAsoJFxVPKvt6I=;
        b=gvdkutXUhWbLeNeBPocMuNya823K+MSwBLBqSw0QnxBVtTGvRNLWUqyVT3PQRegg1v
         icOXmsl9D6hXTSf0gxmk2ZQiNXS3KHikvHzFBzBu3YGjQ65tPwz0jZm8m8KrYDKKRgdf
         0adijpwjy3Gf0Ddv7oJwksPY7CN3LUvAuharEfZceJIjbEyaSfUWn62jZHZf4fmWbqJL
         oNChmuvc7U0AMRs+WZ71Y3dHKmqUkMaMDc/dxeRxV4jL7KXBIbV70UUN7FsO3Wf6cQo0
         Ze7fzSnPEFQZtFfaXjpx8nPjwofhE3fwXC/TVF9Z6eWziVVQcbls63A2ZPnpBSAC5JpM
         DXzA==
X-Gm-Message-State: AOAM5314tt1qZ8W01T02NdL8jKo/R1PNynnpUwDCGESWn3kXER6Wnhvv
        gAMC/w+J9N5GBq1Xizdp//NqgQ==
X-Google-Smtp-Source: ABdhPJyjLsXc7vLO4481w5CdnVSV9amTZl3i6r9RUnZaHjQHlNbUcLUUXHD79itPtLbuTMt6YduFXA==
X-Received: by 2002:a7b:cb88:: with SMTP id m8mr3148842wmi.37.1589296284344;
        Tue, 12 May 2020 08:11:24 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id t4sm24983251wri.54.2020.05.12.08.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 08:11:23 -0700 (PDT)
Date:   Tue, 12 May 2020 16:11:20 +0100
From:   Quentin Perret <qperret@google.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Todd Kjos <tkjos@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>
Subject: Re: [PATCH 00/14] Modularize schedutil
Message-ID: <20200512151120.GB101124@google.com>
References: <20200508111612.GA252673@google.com>
 <20200508113141.GB5298@hirez.programming.kicks-ass.net>
 <20200508130507.GA10541@google.com>
 <CAJZ5v0iaa_VCtN608QKTYZ-A6QG_7bwxihxSgoEGv1LcSK-ksA@mail.gmail.com>
 <20200511090049.GA229633@google.com>
 <CAJZ5v0jKMgFsR0dXDt4si5hT9QF2evaoMS-13y-Qde8UpcaARg@mail.gmail.com>
 <20200512092102.GA16151@google.com>
 <CAJZ5v0hm3Tv2yZKLzM9a+kJuB1V5_eFOEKT-uM318dzeKV3_Qw@mail.gmail.com>
 <20200512135813.GA101124@google.com>
 <CAJZ5v0hN708uvurZ-3oo90qUJFw3=Eg0OmtTaOKXQgNPXhCkFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hN708uvurZ-3oo90qUJFw3=Eg0OmtTaOKXQgNPXhCkFg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday 12 May 2020 at 16:08:56 (+0200), Rafael J. Wysocki wrote:
> If some piece of kernel code is modular, it still needs to be build.
> The difference is when and how it gets loaded, so can you possibly
> elaborate here?

Sure thing, sorry if that wasn't clear.

The end goal with GKI is the following: Google will release a single
binary kernel image (signed, etc etc) that all devices using a given
Android version will be required to use. That image is however going to
be only for the core of the kernel (no drivers or anything of the sort).
Vendors and OEMs, on their end, will be responsible to build and ship
GKI-compatible modules for their respective devices. So, Android devices
will eventually ship with a Google-issued GKI, plus a bunch of
vendor-provided modules loaded during boot.

This is a significant shift from the current model where vendors
completely own the kernel, and are largely free to use the kernel config
they want. Today, those who don't use schedutil are free to turn the
config off, for example.

But GKI changes that. The 'core' GKI config is effectively imposed to
the entire ecosystem. As of now, because it is 'bool' we have no choice
but to compile schedutil in the core GKI as some (most) partners use it.
But as you can imagine, that is not the preferred option of those who
_don't_ use schedutil. Modularizing avoids any potential friction since
the vendors who want to use it will be able load the module, and the
others will simply not. That really is the reason for that series.

Then there is an important question: why should upstream care about all
that stuff? That's obviously debatable, but my biased opinion is that
GKI is a good thing(TM). It's our opportunity to put some order in the
android ecosystem and to reduce the delta with mainline. That'll
definitely take time, and there will be Android-specific churn in GKI in
the beginning, but we'd like to keep that as small as possible, and to
converge to 0 looking forwards.

I hope that helps!

Thanks,
Quentin
