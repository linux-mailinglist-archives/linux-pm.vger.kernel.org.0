Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E53461C9D4F
	for <lists+linux-pm@lfdr.de>; Thu,  7 May 2020 23:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgEGVe2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 17:34:28 -0400
Received: from foss.arm.com ([217.140.110.172]:39620 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgEGVe2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 7 May 2020 17:34:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78E1B1FB;
        Thu,  7 May 2020 14:34:27 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61AE93F68F;
        Thu,  7 May 2020 14:34:19 -0700 (PDT)
References: <20200507181012.29791-1-qperret@google.com>
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
In-reply-to: <20200507181012.29791-1-qperret@google.com>
Date:   Thu, 07 May 2020 22:34:17 +0100
Message-ID: <jhjftcbtoo6.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


(+Ionela)

Hi Quentin,

Apologies for sidetracking this a bit.

On 07/05/20 19:09, Quentin Perret wrote:
> Android is trying very hard to use a single kernel image (commonly
> called Generic Kernel Image, or GKI), closely aligned with mainline, to
> run on all Android devices regardless of the vendor.
>
> The GKI project intends to not only improve the status quo for Android
> users directly (less fragmentation simplifies updatability), but also
> to benefit upstream by forcing all vendors to agree on one common
> kernel, that we push hard to be aligned with mainline.
>
> One challenge to implement GKI is to avoid bloating the kernel by
> compiling too many things in, especially given that different devices
> need different things. As such, anything that can be turned into a
> module helps GKI, by offering an alternative to having that component
> built-in. This is true for pretty much anything that can be made
> modular, including drivers as well as other kernel components, such as
> CPUFreq governors.
>
> Indeed, in practice, Android devices often ship with only one CPUFreq
> governor enabled, and don't require any other that would simply waste
> memory for no benefits. All CPUFreq governors can already be built as
> modules with one notable exception: schedutil. Though popular in
> Android, some devices do not use schedutil, which is why it would be
> preferable to not have it unconditionally built in GKI. This series is
> an attempt to solve this problem, by making schedutil tristate.
>

I'm curious; why would some Android device not want to roll with schedutil?

When it comes to dynamic policies (i.e. forget performance / powersave, and
put userspace in a corner), I'd be willing to take a stand and say you
should only really be using schedutil nowadays - alignment with the
scheduler, uclamp, yadda yadda.

AFAIA the only schedutil-related quirk we oughta fix for arm/arm64 is that
arch_scale_freq_invariant() thingie, and FWIW I'm hoping to get something
regarding this out sometime soonish. After that, I'd actually want to make
schedutil the default governor for arm/arm64.

I'm not opiniated on the modularization, but if you can, could you please
share some more details as to why schedutil cannot fulfill its role of holy
messiah of governors for GKI?
