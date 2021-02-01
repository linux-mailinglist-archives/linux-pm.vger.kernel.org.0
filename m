Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C4930A4AA
	for <lists+linux-pm@lfdr.de>; Mon,  1 Feb 2021 10:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbhBAJxM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Feb 2021 04:53:12 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:48532 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhBAJxL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Feb 2021 04:53:11 -0500
X-Greylist: delayed 484 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Feb 2021 04:53:08 EST
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.2.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id B8126200F18;
        Mon,  1 Feb 2021 09:44:22 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 4733D2090E; Mon,  1 Feb 2021 10:44:15 +0100 (CET)
Date:   Mon, 1 Feb 2021 10:44:15 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] cpufreq: Remove CPUFREQ_STICKY flag
Message-ID: <YBfNb91psVcf3TAS@light.dominikbrodowski.net>
References: <377d2e2d328276070ae2f26c65daa1497bb3c3cf.1612166647.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <377d2e2d328276070ae2f26c65daa1497bb3c3cf.1612166647.git.viresh.kumar@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Viresh,

Am Mon, Feb 01, 2021 at 01:35:51PM +0530 schrieb Viresh Kumar:
> The removal of such a driver is avoided if the driver carries the
> CPUFREQ_STICKY flag. This was added way back [1] in 2004 and perhaps no
> one should ever need it now. A lot of driver do set this flag, probably
> because they just copied it from another driver.

IIRC, it was required on various ARM systems,[*] as CPUs were registered as
subsys_initcall(), while cpufreq used to be initialized only later, as an
arch_initcall(). If the ordering is opposite now on all architectures (it
wasn't on ARM back then), we should be fine.

[*] https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/arch/arm/mach-sa1100/cpu-sa1100.c?id=f59d3bbe35f6268d729f51be82af8325d62f20f5

Thanks,
	Dominik
