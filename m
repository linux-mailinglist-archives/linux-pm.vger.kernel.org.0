Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 387D725AC51
	for <lists+linux-pm@lfdr.de>; Wed,  2 Sep 2020 15:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgIBNuS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Sep 2020 09:50:18 -0400
Received: from foss.arm.com ([217.140.110.172]:38378 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727819AbgIBNtx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 2 Sep 2020 09:49:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1B68101E;
        Wed,  2 Sep 2020 06:25:34 -0700 (PDT)
Received: from bogus (unknown [10.57.4.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7803F3F68F;
        Wed,  2 Sep 2020 06:25:32 -0700 (PDT)
Date:   Wed, 2 Sep 2020 14:25:30 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        dietmar.eggemann@arm.com, catalin.marinas@arm.com, will@kernel.org,
        valentin.schneider@arm.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/5] arch_topology, cpufreq: constify arch_* cpumasks
Message-ID: <20200902132530.GE25462@bogus>
References: <20200901205549.30096-1-ionela.voinescu@arm.com>
 <20200901205549.30096-5-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901205549.30096-5-ionela.voinescu@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 01, 2020 at 09:55:48PM +0100, Ionela Voinescu wrote:
> From: Valentin Schneider <valentin.schneider@arm.com>
>
> The passed cpumask arguments to arch_set_freq_scale() and
> arch_freq_counters_available() are only iterated over, so reflect this
> in the prototype. This also allows to pass system cpumasks like
> cpu_online_mask without getting a warning.
>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
