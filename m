Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7743BE661
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jul 2021 12:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbhGGKfe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Jul 2021 06:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbhGGKfd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jul 2021 06:35:33 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53471C061574
        for <linux-pm@vger.kernel.org>; Wed,  7 Jul 2021 03:32:53 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id a6so2087204ljq.3
        for <linux-pm@vger.kernel.org>; Wed, 07 Jul 2021 03:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wcak1Ofe83x621el2UdGBAdUl4Gwiq6BpwH465FUa/Q=;
        b=Y1qc5v5k67GQNdZB1sTiF7YHlYMBYpG/38vj5qm50DsU/b/FucLbo42Gv/QRHwGk4X
         0931LHtXjhC95nZrs4IzuF3qbHRY9NYqfTd7aMMKUMU7vHyqhXTfFeMOMdDcGQVSyxO5
         99J8eCiw5ZQ1/bx629RAszYcQ8iywZgns6J2Y7zn5Gh9q2HmdgNrUoPLaBp5ZQWxEEGs
         bDU2ffuWf3PxjZVEgwW10lxMMBChGTgSpnth64FwsLC2qclBwYbolQO98Omveqe7rOv4
         CXo1FJWvkI0UuEIbbWLaxJ5ktB4MZcwQCvYC4Udq5Zuml5020M+f5kJyDX5mbwMrPbc8
         jpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wcak1Ofe83x621el2UdGBAdUl4Gwiq6BpwH465FUa/Q=;
        b=Qpe0ziCnm9aVZU5xMdfMYaYWoyuj/xATKs1TeYHVRtcFhncifG9g0sjK8alNXqq5cW
         G496ZG634PEU1Vt/fSOfkFn+gKwTHWeZKal86DBNbX+w5SFGr27uCmNAJOmbccimWI91
         4K3UFwdL1k2rxggbz8hucIaP3wFAo+sYiYpezI06aTUXU4IGX8Q2sSRMFHbKna2ZR3L6
         xzhupGNM+h6QMqd1wf3gJz6fMMWn2f7LWIfo8FcAYL5HN0+xu51QXRWk0UtE6ufID9zB
         MXj3ZVJcby0ZvSjroQXqyExOKmwoXsvJvUCe5cuqIJlCqSqlOt3Sx69R3EhsOhIB6zC4
         hlYQ==
X-Gm-Message-State: AOAM533TI1ZvQtHCJUb227XSGhA6w5r+xEsUiiXAi6XGXuIcf+YfJLJK
        MJ1pboqJk7Y6c2481TO5pnZGWtwxzUAL/HEUwAHL0w==
X-Google-Smtp-Source: ABdhPJyoGPaTT4NqVW7oko9qqSadcXDgrjhAb6CjaJY5L2LLlSJq4CCRMT8Am0i8tG6L0QTEE9k+/7shY9ecU/LKLW4=
X-Received: by 2002:a2e:8941:: with SMTP id b1mr19154447ljk.284.1625653971625;
 Wed, 07 Jul 2021 03:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210625152603.25960-1-lukasz.luba@arm.com> <20210625152603.25960-2-lukasz.luba@arm.com>
 <CAKfTPtAV9GjQaXc2FV0OuEzTGQw9hFiKpwMfAxP-JQ_QFCUC3w@mail.gmail.com>
 <a6a49480-7d5d-fd0e-3940-0b6baac5acc0@arm.com> <CAKfTPtAbck=mTR4g9L1hVGzN2dz4PjKNXoDZeMH19HGwpW3Buw@mail.gmail.com>
 <2f43b211-da86-9d48-4e41-1c63359865bb@arm.com> <CAKfTPtDk1ANfjR5h_EjErVfQ7=is3n9QOaKKxz81tMHtqUM7jA@mail.gmail.com>
 <297df159-1681-f0a7-843d-f34d86e51d4c@arm.com> <CAKfTPtCEo+gkV2TMhOHSnuUyu5BC54o-B4Hb=QbzgT6Dft-PhQ@mail.gmail.com>
 <27916860-33b1-f0a0-acff-4722a733c81b@arm.com> <CAKfTPtB2ogGbGBjJNRBB5jvN24q-tXFR+BpJ31fzsTd2=pDTHQ@mail.gmail.com>
 <ee3ebbaa-7b6d-416d-2caa-197c2713dd4e@arm.com>
In-Reply-To: <ee3ebbaa-7b6d-416d-2caa-197c2713dd4e@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 7 Jul 2021 12:32:40 +0200
Message-ID: <CAKfTPtAN6-ytxa2Qj3=z27e8ZBoqGrWAZce9CojL3wbZSotUsQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] sched/fair: Prepare variables for increased precision
 of EAS estimated energy
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Chris Redpath <Chris.Redpath@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@google.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, segall@google.com,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        CCj.Yeh@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 7 Jul 2021 at 12:29, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 7/7/21 11:11 AM, Vincent Guittot wrote:
> > On Wed, 7 Jul 2021 at 12:06, Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>
>
> [snip]
>
> >> No. It's in 0.1uW scale, so 800Watts. Which is 16 CPUs * 64Watts
> >
> > Oh! you want 0.1uW precision .... This doesn't seem realistic at all.
> > I'm not even sure that the power model can even reach an accuracy of
> > 1mW
> >
>
> True, the EM is registering platform with 1mW precision, but 1uW

Do you mean 1uW or 0.1uW ?

> precision makes more sense for internal EAS calculation. I don't
> force platforms to report 1uW power, I just want to operate on
> it internally. PowerCap and DTPM also operate internally on 1uW,
> so it's not that unrealistic that some kernel components want
> better resolution.
>
> But as Peter suggested, we might skip 32bit platforms for this issue.
> I have to discussed this internally.
