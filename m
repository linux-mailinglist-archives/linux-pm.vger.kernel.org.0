Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9219E22FE71
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jul 2020 02:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgG1AUY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 20:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgG1AUX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2020 20:20:23 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCB1C061794
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2020 17:20:23 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id i19so9994906lfj.8
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2020 17:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nc/nP5wKiguMneXbXSJeuwd2J2JdfIPm6d2gp9TDTp4=;
        b=K57xCEgmCnx3un1myMyG3doUk8PfyAxh6wpSJCXTTatOfILXA2k61QBey0SYiLzT6A
         hv0hibIl7n/ebSO6pNjoOBnaxB83yqhWFxsPhJVnk4N1s8fiN/QkHPTbrqWUojBe3AIK
         n2Dy++TUdhfTGTKqOsw1597ysxfLrxiEzAnKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nc/nP5wKiguMneXbXSJeuwd2J2JdfIPm6d2gp9TDTp4=;
        b=n7EMdJ0qY1GM8CJEcJ3RaySL7yzbxEdv+PkktIfCgxasf/ZEBIy7dO81SWxksFDcdb
         bQmLR2CzsUbm76MFW3wlhtw9z06kvMmHL60PPoFQLdhO45UIda+TqoHObjc5TH3azTWl
         45QdFpOsB4Pqo5n+Hw3zQnqt2Wu6Flnhy1zyk9uFJxIehI+m7egQbpy/i/vFvwU3DJZf
         ELi9hm5XIk2gOSIwXLCZcWQm7gdjXzb0nWfluaEMbig20rHvSYGISb2B/Z8/YQ1nIuFr
         ipI+dONZ9M6WS+S6QkTqIYOTnC/nJwTqYR93ylKIIa+/x2Az3CP4nBlCTxtEiPAEy+71
         aWrQ==
X-Gm-Message-State: AOAM530sFLdFKxrALHNS4DonEd/TVbWyGwNcuYfgqZpbN84vjYt74o16
        Gh8mn9ZkUCAPLOIYFwM0YCWd6tl7ASs=
X-Google-Smtp-Source: ABdhPJxoYldIlSVwrGd9fO3VFa3r/TYwY7xz45T3VRITzC0X8jI2r4Usa4TWZeVYC9HPWN2BnptBTg==
X-Received: by 2002:a19:f207:: with SMTP id q7mr6555381lfh.148.1595895621225;
        Mon, 27 Jul 2020 17:20:21 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id m20sm3731762lfb.72.2020.07.27.17.20.20
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 17:20:20 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id b30so9985978lfj.12
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2020 17:20:20 -0700 (PDT)
X-Received: by 2002:ac2:522b:: with SMTP id i11mr13077378lfl.30.1595895619719;
 Mon, 27 Jul 2020 17:20:19 -0700 (PDT)
MIME-Version: 1.0
References: <87h7tsllgw.fsf@x220.int.ebiederm.org>
In-Reply-To: <87h7tsllgw.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Jul 2020 17:20:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj34Pq1oqFVg1iWYAq_YdhCyvhyCYxiy-CG-o76+UXydQ@mail.gmail.com>
Message-ID: <CAHk-=wj34Pq1oqFVg1iWYAq_YdhCyvhyCYxiy-CG-o76+UXydQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] exec: Freeze the other threads during a
 multi-threaded exec
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 27, 2020 at 2:06 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Therefore make it simpler to get exec correct by freezing the other
> threads at the beginning of exec.  This removes an entire class of
> races, and makes it tractable to fix some of the long standing
> issues with exec.

I hate the global state part of the freezer.

It's also pointless. We don't want to trigger all the tests that
various random driver kernel threads do.

I also really don't like how now execve() by any random person will
suddenly impact everything that might be doing freezing.

It also makes for a possible _huge_ latency regression for execve(),
since freezing really has never been a very low-latency operation.

Other threads doing IO can now basically block execve() for a long
long long time.

Finally, I think your patch is fundamentally broken for another
reason: it depends on CONFIG_FREEZER, and that isn't even required to
be set!

So no, this is not at all acceptable in that form.

Now, maybe we could _make_ it acceptable, by

 (a) add a per-process freezer count to avoid the global state for this case

 (b)  make a small subset of the freezing code available for the
!CONFIG_FREEZER thing

 (c) fix this "simple freezer" to not actually force wakeups etc, but
catch things in the

but honestly, at that point nothing of the "CONFIG_FREEZER" code even
really exists any more. It would be more of a "execve_synchronize()"
thing, where we'd catch things in the scheduler and/or system call
entry/exit or whatever.

Also, that makes these kinds of nasty hacks that just make the
existign freezer code even harder to figure out:

> A new function exec_freeze_threads based upon
> kernel/power/process.c:try_to_freeze_tasks is added.  To play well
> with other uses of the kernel freezer it uses a killable sleep wrapped
> with freezer_do_not_count/freezer_count.

Ugh. Just _ugly_.

And honestly, completely and utterly broken. See above.

I understand the wish to re-use existing infrastructure. But the fact
is, the FREEZER code is just about the _last_ thing you should want to
use. That, and stop_machine(), is just too much of a big hammer.

                Linus
