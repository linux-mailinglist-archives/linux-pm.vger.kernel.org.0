Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15DD01CA7E2
	for <lists+linux-pm@lfdr.de>; Fri,  8 May 2020 12:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgEHKEc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 06:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgEHKEb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2020 06:04:31 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C889C05BD43
        for <linux-pm@vger.kernel.org>; Fri,  8 May 2020 03:04:31 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id v12so1155877wrp.12
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2020 03:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3ahmjo7zWj9jAF2hUJ67B2bDxaSBhv7Y9eLaU0WOfHs=;
        b=Ow1M+5cpGoKhWIgArtKKdDwzijj4tPOSBLNMT4uEWbCCdOY+v3p+h51Tuyq/2uxqdO
         qwYA6XIh2oBLvDb5IYdxEienwVhPwBQ6WPyyHW4iy3BTjThXhZRLOqg7rcb2dc3Q4qSM
         zd+XliY65XMylQmL3UkGsQqEYt+rNjKCcDT8WOPaCNtA/+WxGOHgUy7Q+MZeXre3FEJB
         Uvz1guxee4h+GfdY5rM5IDKy/68yXPskbFLb7PpMUEwOZTcxRB7nODkAkJGSRhyn/KwL
         Qu+AxulP295egIYe3FFgQDt+ZxGhz/S4aGq68urvQbL3qqNCvDcYy0Mnqb2ld+Wx+6ei
         a01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3ahmjo7zWj9jAF2hUJ67B2bDxaSBhv7Y9eLaU0WOfHs=;
        b=iHeZUHyzRtd/QCv9XuQagcBTk1/dyjXX3lxryVkZ6yQJ89uZxGpb4/76CnDt3yaILH
         uJSJPUMopR7r6BFoHEqG9SNDZ+moZUcOcHW9YJmQh15fnQeCtcrKcPPJCi5Khdg5CRSC
         KmFhT2EvGpFqctbn8DLdtLyZLOpsNyABlrFtEyqwRbOrUGGb4wZ3w3wYCIswoA8ak45+
         y9YiG4hQ/6/3DGSvqt7QJCvLKEVNCUVAPEPjHvucKU8PhfiJgLy1/wfxcEEihej/2wK+
         A0zqcs7fCZt9Ddr+A3YvpjPszaaDtckrMIpbrHKLH7khouMpr5cRQcbd4gYNOSTRGnAs
         ABwA==
X-Gm-Message-State: AGi0PuYXGTOKKGrnr8tD1LXCLHSL5Wa2PUf0HEC56H56ysHG5NT68D8a
        FMAFGAmGeFm3mgBpDltrEw1s1Q==
X-Google-Smtp-Source: APiQypLKry7qhaWWoWsKrrbZvd9kXc6HTKRQxi4oXWoq/OWFOW1Rb0C+lIlByPLfibQJKGURGtJt7w==
X-Received: by 2002:adf:fa92:: with SMTP id h18mr2098339wrr.260.1588932269512;
        Fri, 08 May 2020 03:04:29 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id c25sm12210763wmb.44.2020.05.08.03.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 03:04:28 -0700 (PDT)
Date:   Fri, 8 May 2020 11:04:25 +0100
From:   Quentin Perret <qperret@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, sudeep.holla@arm.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, viresh.kumar@linaro.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        fweisbec@gmail.com, tkjos@google.com, kernel-team@android.com
Subject: Re: [PATCH 08/14] sched/core: Export runqueues per-cpu array
Message-ID: <20200508100425.GA239353@google.com>
References: <20200507181012.29791-1-qperret@google.com>
 <20200507181012.29791-9-qperret@google.com>
 <20200508080759.GL5298@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508080759.GL5298@hirez.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Friday 08 May 2020 at 10:07:59 (+0200), Peter Zijlstra wrote:
> On Thu, May 07, 2020 at 07:10:06PM +0100, Quentin Perret wrote:
> > It will be needed by schedutil once modularized, export it.
> > 
> > Signed-off-by: Quentin Perret <qperret@google.com>
> > ---
> > This is only needed for cpu_rq() -> cpu_bw_dl() in schedutil, so there is
> > probably an alternative if exporting this isn't desirable.
> > ---
> >  kernel/sched/core.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index dbaf3f63df22..537eb45b4274 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -36,6 +36,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_se_tp);
> >  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_overutilized_tp);
> >  
> >  DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
> > +EXPORT_SYMBOL_GPL(runqueues);
> 
> NAK, never going to happen.

Well, I should have seen that one coming :-)

As mentioned in the commit message, we might be able to work around.
I'll cook something for v2.

Thanks,
Quentin
