Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB6D28365D
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2019 18:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732452AbfHFQKi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Aug 2019 12:10:38 -0400
Received: from foss.arm.com ([217.140.110.172]:36094 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732203AbfHFQKh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 6 Aug 2019 12:10:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF139344;
        Tue,  6 Aug 2019 09:10:36 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 996D33F575;
        Tue,  6 Aug 2019 09:10:35 -0700 (PDT)
Date:   Tue, 6 Aug 2019 17:10:33 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LAKML <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 4/6] ARM: psci: cpuidle: Introduce PSCI CPUidle driver
Message-ID: <20190806161033.GD16546@e107155-lin>
References: <20190722153745.32446-1-lorenzo.pieralisi@arm.com>
 <20190722153745.32446-5-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722153745.32446-5-lorenzo.pieralisi@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 22, 2019 at 04:37:43PM +0100, Lorenzo Pieralisi wrote:
> PSCI firmware is the standard power management control for
> all ARM64 based platforms and it is also deployed on some
> ARM 32 bit platforms to date.
>
> Idle state entry in PSCI is currently achieved by calling
> arm_cpuidle_init() and arm_cpuidle_suspend() in a generic
> idle driver, which in turn relies on ARM/ARM64 CPUidle back-end
> to relay the call into PSCI firmware if PSCI is the boot method.
>
> Given that PSCI is the standard idle entry method on ARM64 systems
> (which means that no other CPUidle driver are expected on ARM64
> platforms - so PSCI is already a generic idle driver), in order to
> simplify idle entry and code maintenance, it makes sense to have a PSCI
> specific idle driver so that idle code that it is currently living in
> drivers/firmware directory can be hoisted out of it and moved
> where it belongs, into a full-fledged PSCI driver, leaving PSCI code
> in drivers/firmware as a pure firmware interface, as it should be.
>
> Implement a PSCI CPUidle driver. By default it is a silent Kconfig entry
> which is left unselected, since it selection would clash with the
> generic ARM CPUidle driver that provides a PSCI based idle driver
> through the arm/arm64 arches back-ends CPU operations.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>

Once the error path issues pointed by Ulf are resolved,

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> ---
>  MAINTAINERS                    |   8 ++
>  drivers/cpuidle/Kconfig.arm    |   3 +
>  drivers/cpuidle/Makefile       |   1 +
>  drivers/cpuidle/cpuidle-psci.c | 150 +++++++++++++++++++++++++++++++++
>  4 files changed, 162 insertions(+)
>  create mode 100644 drivers/cpuidle/cpuidle-psci.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 783569e3c4b4..c2bf8ce65e83 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4286,6 +4286,14 @@ S:	Supported
>  F:	drivers/cpuidle/cpuidle-exynos.c
>  F:	arch/arm/mach-exynos/pm.c
>
> +CPUIDLE DRIVER - ARM PSCI
> +M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> +M:	Sudeep Holla <sudeep.holla@arm.com>
> +L:	linux-pm@vger.kernel.org
> +L:	linux-arm-kernel@lists.infradead.org
> +S:	Supported
> +F:	drivers/cpuidle/cpuidle-psci.c
> +
>  CPU IDLE TIME MANAGEMENT FRAMEWORK
>  M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
>  M:	Daniel Lezcano <daniel.lezcano@linaro.org>
> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
> index 48cb3d4bb7d1..929b57424ea4 100644
> --- a/drivers/cpuidle/Kconfig.arm
> +++ b/drivers/cpuidle/Kconfig.arm
> @@ -13,6 +13,9 @@ config ARM_CPUIDLE
>            initialized by calling the CPU operations init idle hook
>            provided by architecture code.
>
> +config ARM_PSCI_CPUIDLE
> +	bool
> +

[nit] I understand the intention to keep it hidden, but can't we have
the dependency and selection of other config as part of this patch to
make it more complete ?

--
Regards,
Sudeep
