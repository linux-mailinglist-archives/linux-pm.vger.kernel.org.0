Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9661D1D0B50
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 10:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbgEMI5Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 04:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728397AbgEMI5Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2020 04:57:25 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E17DC061A0C
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2020 01:57:25 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id g14so11303354wme.1
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2020 01:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L3D5wbM4+UOmg5X3zyhaWbHPrhXUjtC7ABKOs6rc9yo=;
        b=l5M7DQyeLT9ZtP2AGAsL3Bd2tnuVnla/JxC44sQIF4uXl5wHEwSa58d8aQ3P0/LoCt
         ht/7aaRWkRXdvMqhnLMNz4J9ItKHZIAZEAmQAqtrHbtFWtKP5NPplaIH68AQbpaWIrbP
         EEOGWgzFy120izmq5SavA0GscGogGocNzDjGwxUED/CCSzMP7GCkzWVeSbQYyJeQOMB7
         AlU8TvnvoFCk37ygEzK9QfXc2yUkYx44PB0tGROMy088nWvW9VyvYKrDxmeQvrVR/oYY
         x6JjT0XZAMuLUKF7FauiwGkcsEuE2RAc1r8iVWvx9KOA11BkyIYe9asE+9oNRESEpEGB
         3xvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L3D5wbM4+UOmg5X3zyhaWbHPrhXUjtC7ABKOs6rc9yo=;
        b=AblwAKXy4wERD2RLMRh9ZNNh5Fw1crMGllFPx9zKjwNNVkh5OvnlCkEDK/rP9zmjMY
         sWyaEbC3i6VmhWpEE6+G3O8nP/U33rYAazL8FE6DvjKkhDTm+TuuD94KjY3yNQpb+hwh
         QXxyrm4UoctEW2wt1zMHavC7HDjQrNq6tAH4Wrw4dDdBcuepcAYwk7rvekGUSXgJzGsx
         WbMofoEWDsV8sZGHkNZiImWjViheFdze5hnpL5H7stYI4hkDvi8DQeNurHtdK1LbCPTl
         GoB+Mta8D07gWBH3QKUwxuVCaYCzuTyeQp75m2mEgPcQW5nLDNp9MxGBGGV6HDz+0tg6
         JjLQ==
X-Gm-Message-State: AGi0PuY6KheMvboF2lwaDUMEzX2ZYlPtZiYKG5jv5+sJ7rv9H9SeTg8t
        Vlvzbg1UTxf2QcwM4yKBW7I2/O76P0I=
X-Google-Smtp-Source: APiQypIIh+5TVT139VH+1iFKgejig/aRcQfdqcB/1OfJwTRe5B9kfraMOZX3g/i2i2aAqIIpIRB3/w==
X-Received: by 2002:a1c:2e07:: with SMTP id u7mr41975477wmu.74.1589360243384;
        Wed, 13 May 2020 01:57:23 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id 89sm26212772wrj.37.2020.05.13.01.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 01:57:22 -0700 (PDT)
Date:   Wed, 13 May 2020 09:57:19 +0100
From:   Quentin Perret <qperret@google.com>
To:     Joel Fernandes <joelaf@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20200513085719.GA225140@google.com>
References: <CAJZ5v0iaa_VCtN608QKTYZ-A6QG_7bwxihxSgoEGv1LcSK-ksA@mail.gmail.com>
 <20200511090049.GA229633@google.com>
 <CAJZ5v0jKMgFsR0dXDt4si5hT9QF2evaoMS-13y-Qde8UpcaARg@mail.gmail.com>
 <20200512092102.GA16151@google.com>
 <CAJZ5v0hm3Tv2yZKLzM9a+kJuB1V5_eFOEKT-uM318dzeKV3_Qw@mail.gmail.com>
 <20200512135813.GA101124@google.com>
 <CAJZ5v0hN708uvurZ-3oo90qUJFw3=Eg0OmtTaOKXQgNPXhCkFg@mail.gmail.com>
 <20200512151120.GB101124@google.com>
 <CAJZ5v0inoge=nWQtv-rU_ReQUMZA5w-PZXuSpHHj1UHn-S7aSA@mail.gmail.com>
 <CAJWu+oqVc16B8nf-317Yyf9befPsjBohfG=GOdoBZyuVz==bmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJWu+oqVc16B8nf-317Yyf9befPsjBohfG=GOdoBZyuVz==bmQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey Joel,

On Tuesday 12 May 2020 at 11:49:32 (-0400), Joel Fernandes wrote:
> Also, does this series make it easier for vendors / oems / whoever to
> carry out-of-tree schedutil hacks saying that's "Ok" because that's
> not part of the core GKI? That would definitely be a bad thing to
> encourage as well. schedutil should pretty much be considered a part
> of the core GKI if the goal is to encourage everyone to move to it,
> IMO.

Sure, but I don't think the series makes it easier to carry out-of-tree
stuff. Vendors will have the choice to load the governor they want. Some
will use schedutil, some will use other upstream governors, and some will
use their out of tree crap. And that is orthogonal to schedutil being a
module or not.

The only thing that will happen is that they will complain about GKI,
and find examples of things like schedutil that is being forced on
them. Realistically, having schedutil built-in is unlikely to change
their mind about the governor they want to use, it is just likely to
give them reasons not to do the right thing and be GKI compliant.

Thanks,
Quentin
