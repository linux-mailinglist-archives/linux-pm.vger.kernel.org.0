Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9201CB24F
	for <lists+linux-pm@lfdr.de>; Fri,  8 May 2020 16:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgEHOwQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 10:52:16 -0400
Received: from foss.arm.com ([217.140.110.172]:49654 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbgEHOwQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 8 May 2020 10:52:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BF8F1FB;
        Fri,  8 May 2020 07:52:15 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 048B93F305;
        Fri,  8 May 2020 07:52:11 -0700 (PDT)
References: <20200507181012.29791-1-qperret@google.com> <jhjftcbtoo6.mognet@arm.com> <20200508131508.GB10541@google.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Quentin Perret <qperret@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, sudeep.holla@arm.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, viresh.kumar@linaro.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, fweisbec@gmail.com, tkjos@google.com,
        kernel-team@android.com, Ionela Voinescu <ionela.voinescu@arm.com>
Subject: Re: [PATCH 00/14] Modularize schedutil
In-reply-to: <20200508131508.GB10541@google.com>
Date:   Fri, 08 May 2020 15:52:07 +0100
Message-ID: <jhjeerutr6w.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 08/05/20 14:15, Quentin Perret wrote:
> Hey Valentin,
>
> On Thursday 07 May 2020 at 22:34:17 (+0100), Valentin Schneider wrote:
>> I'm curious; why would some Android device not want to roll with schedutil?
>>
>> When it comes to dynamic policies (i.e. forget performance / powersave, and
>> put userspace in a corner), I'd be willing to take a stand and say you
>> should only really be using schedutil nowadays - alignment with the
>> scheduler, uclamp, yadda yadda.
>>
>> AFAIA the only schedutil-related quirk we oughta fix for arm/arm64 is that
>> arch_scale_freq_invariant() thingie, and FWIW I'm hoping to get something
>> regarding this out sometime soonish. After that, I'd actually want to make
>> schedutil the default governor for arm/arm64.
>
> As in setting CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL=y in the arm64
> defconfig? If so, you have my Acked-by already :)
>

I'm actually thinking of making it the unconditional default for arm/arm64
in cpufreq's Kconfig, following what has been recently done for
intel_pstate.

>> I'm not opiniated on the modularization, but if you can, could you please
>> share some more details as to why schedutil cannot fulfill its role of holy
>> messiah of governors for GKI?
>
> I guess I answered some of that in the other thread with Peter, but all
> in all I'm definitely not trying to make an argument that schedutil
> isn't good enough here. I'm trying to say that mandating it in *GKI* is
> just likely to cause unnecessary friction, and trust me there is already
> enough of that with other topics.

Right, I appreciate it must be an "interesting" tug of war. My own opinion
has also already been expanded in the rest of the thread; i.e. we should
strive to make schedutil good enough that folks don't feel like they still
need to use ondemand/whatever frankengov. That said, even without GKI, I
get that making some vendors change their already tested-and-tuned setup is
an obstacle course in and of itself.

> Giving the option of having sugov as a
> module doesn't prevent us from making it a default for a few arches, so
> I think there is ground for an agreement!
>
> Cheers,
> Quentin
