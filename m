Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 344A016AF85
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2020 19:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbgBXSoI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Feb 2020 13:44:08 -0500
Received: from foss.arm.com ([217.140.110.172]:41830 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbgBXSoI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 24 Feb 2020 13:44:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71CB51FB;
        Mon, 24 Feb 2020 10:44:07 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 407B43F703;
        Mon, 24 Feb 2020 10:44:05 -0800 (PST)
References: <20200224141142.25445-1-ionela.voinescu@arm.com> <20200224141142.25445-6-ionela.voinescu@arm.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, suzuki.poulose@arm.com, sudeep.holla@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com, rjw@rjwysocki.net,
        peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 5/7] cpufreq: add function to get the hardware max frequency
In-reply-to: <20200224141142.25445-6-ionela.voinescu@arm.com>
Date:   Mon, 24 Feb 2020 18:44:03 +0000
Message-ID: <jhjlforygek.fsf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Ionela Voinescu writes:

> Add weak function to return the hardware maximum frequency of a CPU,
> with the default implementation returning cpuinfo.max_freq, which is
> the best information we can generically get from the cpufreq framework.
>
> The default can be overwritten by a strong function in platforms
> that want to provide an alternative implementation, with more accurate
> information, obtained either from hardware or firmware.
>
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
