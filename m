Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C734A3A407D
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jun 2021 12:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbhFKK4t (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Jun 2021 06:56:49 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:42711 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbhFKK4s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Jun 2021 06:56:48 -0400
Received: by mail-ot1-f41.google.com with SMTP id w23-20020a9d5a970000b02903d0ef989477so2717428oth.9;
        Fri, 11 Jun 2021 03:54:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vqb7EkFR0CrAyT8gJlgsG4YszMGVRbShkwh2bFf2+Ck=;
        b=Z95+QGfhCQ/f2AzCcDtEMSNBKG9egbRYIA5z8CTDeQYcj+GGAcgBaz8ctQou6y7pj5
         mqxX/GIpPyR5ml3IZDcAZMiYSLBN9IXDe/erV6q3ahGyF0+LpJPCsoVrwur6YvsiR3jq
         7zhS1YCbp6MSyVtS7RGLAHwacPktPPrLqq0Fv1Pp1cRl3HWcipx2i8Cubi4bdSLS2W1Y
         NfxLQnjKcI4Js4nQudM0Yv5r0g4GsWZ5gbTkeO6yuSimEyu4zhxhlO0Pw5MiQliNh90p
         1gPa/Kz5utHUilJl1D5LAj2oy3mgg5wI84YOn/511/jrOmnHI/FUM5JlYuTd32tqyEwN
         BYWQ==
X-Gm-Message-State: AOAM532c2pAWC/jlFnzpPY7QoKq5Yr/m5PjtLnC/fXmBmo+5S+8f2l+p
        tu4WylqB2IgJM550dQSmHvjC/T1o//x+kKwh9UU=
X-Google-Smtp-Source: ABdhPJy0oqZGRAywQkUpK2/3RElDxmqRCSiK2DPi6TNubs2LywuwfqfS/IwEK2fVHsBPWjcEVc4rAMU4Eb9FixfOXY8=
X-Received: by 2002:a05:6830:1bf7:: with SMTP id k23mr2689884otb.206.1623408878176;
 Fri, 11 Jun 2021 03:54:38 -0700 (PDT)
MIME-Version: 1.0
References: <a71c48fb0150f505680da68a82b4e4fca9a18439.1623381430.git.viresh.kumar@linaro.org>
 <YMMSt65aj0KKHy1A@hirez.programming.kicks-ass.net> <20210611074008.57u27wtyqv4ossde@vireshk-i7>
In-Reply-To: <20210611074008.57u27wtyqv4ossde@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 11 Jun 2021 12:54:26 +0200
Message-ID: <CAJZ5v0hQ_7cdTNiXuFtmwiiLXxZ1WzxmLrPA+Hp4Tp7i-qS4EQ@mail.gmail.com>
Subject: Re: [PATCH V2] Revert "cpufreq: CPPC: Add support for frequency invariance"
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Qian Cai <quic_qiancai@quicinc.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 11, 2021 at 9:40 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 11-06-21, 09:37, Peter Zijlstra wrote:
> > Alternatively: "depends on BROKEN" ?
>
> This is what I wanted to do, but Rafael didn't like it :)
>
> https://lore.kernel.org/linux-pm/28308fc0d38f252baf90e6ffb31fd2f8660be273.1623311808.git.viresh.kumar@linaro.org/

Right.

For new things I prefer to either fix them properly before the release
or revert and redo in a better way in the next cycle.
