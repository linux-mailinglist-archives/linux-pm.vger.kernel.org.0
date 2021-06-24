Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF793B2BCE
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jun 2021 11:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbhFXJw0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Jun 2021 05:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbhFXJwZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Jun 2021 05:52:25 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBF0C061756
        for <linux-pm@vger.kernel.org>; Thu, 24 Jun 2021 02:50:06 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id d25so6899217lji.7
        for <linux-pm@vger.kernel.org>; Thu, 24 Jun 2021 02:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qqcZleP2S371WLdXJOXTAsMiO7kHRVmitjNgvjiTzrc=;
        b=Y8xRKNeDp2eAwdEwtd+znlFoFof7cIlrVRBx5CJZ7bdYNROu+Od7vtLkWOGKpS8GBX
         h+n9Abkmc4BoaOq5MYQ1eJC3ME5uYwRjrRjrkz/LqbNTZnbxW5BoY3bObS624o1cVZDV
         3j2BcKt07vswzCSPvPgudRwzlFTFr7ryvM6ChD8AcnrFSQNNBBt4PiD7W9HGI4sovVYe
         WeUA6Xwy2zfcuGumXszTGrftibl6niN9SWft0hbTxazgAvwoTs6DrSRn9froEGiqRf99
         i1i9ZE1bGaWk4u+0IYnQtVtZ4oodxT7NIXmEdsCJr5uJ+gdMp1owTBKkNm5UqVlKhHqu
         V6IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qqcZleP2S371WLdXJOXTAsMiO7kHRVmitjNgvjiTzrc=;
        b=bJFG5pwusX39+4eRsATUi0UR1NMhSc1nEgLBfFy4/nZvjkWAv2ssyU3EfmmvZ9UH/E
         QDlk8mCRuR2IshK/8b5UoHfANGaSdMKEFf6/t24J5ZAj9U/Llh0mTSU8RGCDlUXo9PqN
         N93p/xJ3Ec1r6co64oyVP1AGrD3ns1+pNOXRWiCR0BcIIIYzCBzP+l1qNqb4YTFh4wzU
         l1EcfBhFBWO/xaaI0RsbvKng33kLw8EuDwGz7oBgTSBae57ZiNqDiSm/CQSJprjgI5Sm
         56tPBh+px8CUO9FEKEztdTXKBirqIklJWiM0LF71ovXzWQRQqCPopwtL1H+iSB4dnqhE
         +Qiw==
X-Gm-Message-State: AOAM531dnfJbWM7oChmdA23vCtYPc1oQFxx951DhqgMKf45lQzjOD5Of
        yibswTIEHY5c3QP1cbCxx5eAkf2zcV/+0gdtLgSDww==
X-Google-Smtp-Source: ABdhPJw6cF3UPDUE/hjLyp07fIBsyMqwanQ2zzErcjkcsVhu+t+on9LmMD26Yn19M3ZdrE+WkHLwuv83ICSxPxjuCKg=
X-Received: by 2002:a2e:95c9:: with SMTP id y9mr3182951ljh.401.1624528204937;
 Thu, 24 Jun 2021 02:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1624266901.git.viresh.kumar@linaro.org> <09a39f5c-b47b-a931-bf23-dc43229fb2dd@quicinc.com>
 <20210623041613.v2lo3nidpgw37abl@vireshk-i7> <2c540a58-4fef-5a3d-85b4-8862721b6c4f@quicinc.com>
 <20210624025414.4iszkovggk6lg6hj@vireshk-i7>
In-Reply-To: <20210624025414.4iszkovggk6lg6hj@vireshk-i7>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 24 Jun 2021 11:49:53 +0200
Message-ID: <CAKfTPtAXMYYrG1w-iwSWXb428FkwFArEwXQgHnjShoCEMjdYcw@mail.gmail.com>
Subject: Re: [PATCH V3 0/4] cpufreq: cppc: Add support for frequency invariance
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Qian Cai <quic_qiancai@quicinc.com>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 24 Jun 2021 at 04:54, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 23-06-21, 08:57, Qian Cai wrote:
> > Viresh, I am afraid I don't feel comfortable yet. I have a few new tests in
> > development, and will provide an update once ready.
>
> Oh sure, np.
>
> > Also, I noticed the delivered perf is even smaller than lowest_perf (100).
>
> > # cat /sys/devices/system/cpu/cpu8/acpi_cppc/feedback_ctrs
> >  ref:103377547901 del:54540736873
> > # cat /sys/devices/system/cpu/cpu8/acpi_cppc/feedback_ctrs
> >  ref:103379170101 del:54541599117
> >
> > 100 * (54541599117 - 54540736873) / (103379170101 - 103377547901) = 53

I'm not sure that I understand your point. The formula above says that
cpu8 run @ 53% of nominal performance

> >
> > My understanding is that the delivered perf should fail into the range between
> > lowest_perf and highest_perf. Is that assumption correct? This happens on
> > 5.4-based kernel, so I am in process running your series on that system to see
> > if there is any differences. In any case, if it is a bug it is pre-existing,
> > but I'd like to understand a bit better in that front first.
>
> Vincent:
>
> Can that happen because of CPU idle ?
>
> --
> viresh
