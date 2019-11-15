Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F612FDBEC
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2019 12:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfKOLDp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Nov 2019 06:03:45 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33790 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbfKOLDp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Nov 2019 06:03:45 -0500
Received: by mail-lf1-f68.google.com with SMTP id d6so7728028lfc.0
        for <linux-pm@vger.kernel.org>; Fri, 15 Nov 2019 03:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0F7zdvisCztvSZbyo1EvoXH0ott3e3tl9NiIJpij2a0=;
        b=arpWgUiut+0/FjbZ8f+UHt/t9t/VsAL1xks15UgJS+fxN5uCi/d5bMxdGb0F+RAqFH
         mv63ONrV0cYmcbsb+SZ7V+T7RhMf0HcSbAmmVrFz3ueL04aX0W7STXZI3fSXqO8RvnOX
         MDPmic+3lTLCfE3shgRQ05TJSK5qKNVaUDLvaUL8ck32gy3hLD0O2twOfGw/up57lB0I
         b+Cuik8yv8xvZzfyatAyyHso23WhPKm6OH7JAHaffVoNkErBhO1Kp2/GOJmzYm3OFOyv
         QqjSvhGT+yfdrPYw+k/yDwf7ttguAbzfGvGjZYswEY/RXYdao8PbhRV+qrg0y+uX5og6
         W3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0F7zdvisCztvSZbyo1EvoXH0ott3e3tl9NiIJpij2a0=;
        b=X/RjzSUOEKNPkGKWJOwQp9iOk9Dc1jBvfrHhNJk0HudLbl5gvc+kze/Di1dYoQjAkH
         ogPlmW1kpalzcMg4Xd/RJbkoYDsWunssY7LHp6SbEX43tGv5CwuXcAy0XMWlasBW4gOH
         1FXyTD5wuaM+6ALa+vzjZV+cAo5UTS8BIsDoxtCr2dqHLWyDJDmjQ8/XpV6AOVPzAQMH
         R6VMutyk6dBejHtkAcJLDhg+mf/ciT7Ug6n38EKjsPb8h/aEfY4XT9DOLB7zWyeCnWFp
         K08eBdUR2d3LNpFCIBZ/R/9X+3cXGlnTuDdugFyz6kglPk+zw2Exmq80tkxakU5I5pyY
         IStg==
X-Gm-Message-State: APjAAAWfl2rKQAsHRD+5Wyt/xc2x7tQZJ5UF6EI8MjzJLX9YIjU2StAc
        Mxh/ghE2yq4muHpWzMs4fnf0N/FSK17ZBlgresZ2Kw==
X-Google-Smtp-Source: APXvYqzNFr0pVMd/dd6uUBcaV2TCKX6w6VTIRDrMGjPTmj4/XSZ1U72gqjsmZn8F1xWAA67T8qUuhi8cacRdkAOdWlE=
X-Received: by 2002:a19:ed12:: with SMTP id y18mr10424378lfy.151.1573815823472;
 Fri, 15 Nov 2019 03:03:43 -0800 (PST)
MIME-Version: 1.0
References: <1573751251-3505-1-git-send-email-vincent.guittot@linaro.org>
 <20191115095447.GU4114@hirez.programming.kicks-ass.net> <CAKfTPtCTcrq1E1H8A3TL1xvALUrQ7ybPoERJ+C2O2+QXpVEZGQ@mail.gmail.com>
 <20191115103735.GE4131@hirez.programming.kicks-ass.net> <CAKfTPtDi_-h6g+rhV04XXjqpWprC2vT6hgLZSrTW5rdD54PrQA@mail.gmail.com>
 <20191115105110.GG4131@hirez.programming.kicks-ass.net>
In-Reply-To: <20191115105110.GG4131@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 15 Nov 2019 12:03:31 +0100
Message-ID: <CAKfTPtC3g4iCxvAJo9Km9fZ0fPSw5Jt9TY2+xF7kxGmOZ66gxw@mail.gmail.com>
Subject: Re: [PATCH v4] sched/freq: move call to cpufreq_update_util
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Doug Smythies <dsmythies@telus.net>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sargun Dhillon <sargun@sargun.me>, Tejun Heo <tj@kernel.org>,
        Xie XiuQi <xiexiuqi@huawei.com>, xiezhipeng1@huawei.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 15 Nov 2019 at 11:51, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Nov 15, 2019 at 11:46:01AM +0100, Vincent Guittot wrote:
> > On Fri, 15 Nov 2019 at 11:37, Peter Zijlstra <peterz@infradead.org> wrote:
>
> > > Sure, but then it can still remember the value passed in last and use
> > > that state later.
> > >
> > > It doesn't _have_ to completely discard values.
> >
> > yes but it means that we run at the "wrong" frequency during this
> > period and also that the cpufreq must in this case set a kind of timer
> > to resubmit a new frequency change out of scheduler event
>
> But if, as you say, we're completely shutting down the event stream
> when everything has decayed, that's still true, right?

But It doesn't because there is nothing else to do.

This patch does 2 things:
- fix the spurious call to cpufreq just before attaching a task
- make sure cpufreq is still called when cfs is 0 but not irq/rt or dl

There are somehow related but not fully
