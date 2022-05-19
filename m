Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB4F52DEC5
	for <lists+linux-pm@lfdr.de>; Thu, 19 May 2022 22:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235255AbiESUwj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 May 2022 16:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234953AbiESUwi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2022 16:52:38 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B594C2BE3
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 13:52:37 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id n23so8499763edy.0
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 13:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w7n9soc+YeiEuDs+/wVe5880ZbNB6SfvRzmD9yZCDg0=;
        b=DBEkcJxwMHgrSW6HcJcRibGMLRAHktxTfe210zz70+cSSKn6ZpUgiva+kk1wpf11Zn
         AEG+Mgw1hd0KW2hE0Q1vG6WOtJs0wkwyzpBg39QhS4doVKGMJsExBp8t3Mh2Q11oNnXz
         Uj83mLI19GvO9WWx9wIiJ6kgKwKQLuX9IR+/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w7n9soc+YeiEuDs+/wVe5880ZbNB6SfvRzmD9yZCDg0=;
        b=5WkZKRUc65i8idT/kvPR8B6k2MtAZnPQyxcleRhsx/0M2dg3RqH4QgQyJ2mOrIbnnd
         C6CzlMZPPlbYywQT/aHeLaPMx0EXHpfGdYbSF51oJ3bo5X9ugsJwRFH1itqxagcxcOV2
         3/JqOfy4Dycm6OAt36pAsWyUsqCI8GSUJ4e9fMxXYJMJ2IoX+6DukkLsn7N4RTN3oqGJ
         IycmuoFUWf640GIE4KKsQIoPEXZlxjXLL7WZ2W8oUS+1z3DxB0BJA+90gsUbvHOEoTGZ
         bXTnuWGF/rS8cbDuP+yTvtFtWKWhc0qf6y6B4k/EdB03WyaT7MGO10YKLTKX0C6MYdN8
         Y6HQ==
X-Gm-Message-State: AOAM532dot882sb3t2hB6pBf3h65kRUg+k7CUv2DerJ8ecIn3Juk2qMu
        V2bbXyaY/8wOWF5bXwLRvw88eRBjxcGP3g==
X-Google-Smtp-Source: ABdhPJxNXtzzC1o8jHyTxqmHBpu/l+Pyco4C5nc9/95wsyhJIJD24jXFQtl055axoIGakL4+8Ufk+Q==
X-Received: by 2002:a05:6402:2750:b0:42b:2616:7cdb with SMTP id z16-20020a056402275000b0042b26167cdbmr689839edd.306.1652993556092;
        Thu, 19 May 2022 13:52:36 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id d24-20020a1709067a1800b006f3ef214e25sm2417419ejo.139.2022.05.19.13.52.34
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 13:52:35 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id s28so8643183wrb.7
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 13:52:34 -0700 (PDT)
X-Received: by 2002:a05:6000:2c1:b0:20c:5e37:3ed1 with SMTP id
 o1-20020a05600002c100b0020c5e373ed1mr5575002wry.342.1652993554192; Thu, 19
 May 2022 13:52:34 -0700 (PDT)
MIME-Version: 1.0
References: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org> <20220518225355.784371-3-ebiederm@xmission.com>
In-Reply-To: <20220518225355.784371-3-ebiederm@xmission.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 19 May 2022 13:52:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UFK7h0oHGJ23y37ShO+z4vt9ubGE9E4m=jMECgNAAHgA@mail.gmail.com>
Message-ID: <CAD=FV=UFK7h0oHGJ23y37ShO+z4vt9ubGE9E4m=jMECgNAAHgA@mail.gmail.com>
Subject: Re: [PATCH 03/16] kdb: Use real_parent when displaying a list of processes
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Will Deacon <will@kernel.org>, Tejun Heo <tj@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, linux-ia64@vger.kernel.org,
        Robert OCallahan <roc@pernos.co>, Kyle Huey <khuey@pernos.co>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Miller <dougmill@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Wed, May 18, 2022 at 3:54 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> kdb has a bug that when using the ps command to display a list of
> processes, if a process is being debugged the debugger as the parent
> process.
>
> This is silly, and I expect it never comes up in ptractice.  As there
> is very little point in using gdb and kdb simultaneously.  Update the
> code to use real_parent so that it is clear kdb does not want to
> display a debugger as the parent of a process.

So I would tend to defer to Daniel, but I'm not convinced that the
behavior you describe for kdb today _is_ actually silly.

If I was in kdb and I was listing processes, I might actually want to
see that a process's parent was set to gdb. Presumably that would tell
me extra information that might be relevant to my debug session.

Personally, I'd rather add an extra piece of information into the list
showing the real parent if it's not the same as the parent. Then
you're not throwing away information.

-Doug
