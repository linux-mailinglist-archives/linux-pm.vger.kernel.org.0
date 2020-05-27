Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB9A1E3EAA
	for <lists+linux-pm@lfdr.de>; Wed, 27 May 2020 12:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbgE0KJO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 May 2020 06:09:14 -0400
Received: from foss.arm.com ([217.140.110.172]:35584 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729678AbgE0KJN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 27 May 2020 06:09:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D58AB55D;
        Wed, 27 May 2020 03:09:12 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BEC213F6C4;
        Wed, 27 May 2020 03:09:10 -0700 (PDT)
References: <20200526151619.8779-1-benjamin.gaignard@st.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org, hugues.fruchet@st.com,
        mchehab@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, pavel@ucw.cz, len.brown@intel.com,
        vincent.guittot@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC RESEND 0/3] Introduce cpufreq minimum load QoS
In-reply-to: <20200526151619.8779-1-benjamin.gaignard@st.com>
Date:   Wed, 27 May 2020 11:09:05 +0100
Message-ID: <jhjk10xu1tq.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Benjamin,

On 26/05/20 16:16, Benjamin Gaignard wrote:
> A first round [1] of discussions and suggestions have already be done on
> this series but without found a solution to the problem. I resend it to
> progress on this topic.
>

Apologies for sleeping on that previous thread.

So what had been suggested over there was to use uclamp to boost the
frequency of the handling thread; however if you use threaded IRQs you
get RT threads, which already get the max frequency by default (at least
with schedutil).

Does that not work for you, and if so, why?

> When start streaming from the sensor the CPU load could remain very low
> because almost all the capture pipeline is done in hardware (i.e. without
> using the CPU) and let believe to cpufreq governor that it could use lower
> frequencies. If the governor decides to use a too low frequency that
> becomes a problem when we need to acknowledge the interrupt during the
> blanking time.
> The delay to ack the interrupt and perform all the other actions before
> the next frame is very short and doesn't allow to the cpufreq governor to
> provide the required burst of power. That led to drop the half of the frames.
>
> To avoid this problem, DCMI driver informs the cpufreq governors by adding
> a cpufreq minimum load QoS resquest.
>
> Benjamin
>
> [1] https://lkml.org/lkml/2020/4/24/360
>
> Benjamin Gaignard (3):
>   PM: QoS: Introduce cpufreq minimum load QoS
>   cpufreq: governor: Use minimum load QoS
>   media: stm32-dcmi: Inform cpufreq governors about cpu load needs
>
>  drivers/cpufreq/cpufreq_governor.c        |   5 +
>  drivers/media/platform/stm32/stm32-dcmi.c |   8 ++
>  include/linux/pm_qos.h                    |  12 ++
>  kernel/power/qos.c                        | 213 ++++++++++++++++++++++++++++++
>  4 files changed, 238 insertions(+)
