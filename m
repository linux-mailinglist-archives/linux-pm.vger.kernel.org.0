Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF00170795
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2020 19:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgBZSYj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Feb 2020 13:24:39 -0500
Received: from foss.arm.com ([217.140.110.172]:40968 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbgBZSYj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 26 Feb 2020 13:24:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A04A330E;
        Wed, 26 Feb 2020 10:24:38 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 47F283F881;
        Wed, 26 Feb 2020 10:24:36 -0800 (PST)
References: <20200226132947.29738-1-ionela.voinescu@arm.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, suzuki.poulose@arm.com, sudeep.holla@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com, rjw@rjwysocki.net,
        pkondeti@codeaurora.org, peterz@infradead.org, mingo@redhat.com,
        vincent.guittot@linaro.org, viresh.kumar@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 0/7] arm64: ARMv8.4 Activity Monitors support
Message-ID: <jhjftex438f.fsf@arm.com>
In-reply-to: <20200226132947.29738-1-ionela.voinescu@arm.com>
Date:   Wed, 26 Feb 2020 18:24:26 +0000
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Ionela,

On Wed, Feb 26 2020, Ionela Voinescu wrote:
> v4 -> v5:
>  - v4 can be found at [6]
>  - [1/7] rebased on top of latest tip/sched/core and fixed conflicts;
>    applied Reviewed-by from Valentin;
>  - [5/7] applied Reviewed-by from Valentin
>  - [6/7] applied Valentin and Pavan's suggested fixes; reworked
>    arch_cpu_freq_counters (now arch_freq_counters_available) and
>    confined it to the arch topology driver as recommended by Valentin
>    and Lukasz;
>

I don't really have any more comments for v5. AFAICT what we are missing
now is Sudeep's ack for the arch_topology bits, and if Catalin / Will
are okay with it I think this can all go through the arm64 tree.
