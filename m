Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBED685024
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2019 17:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388620AbfHGPmY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Aug 2019 11:42:24 -0400
Received: from foss.arm.com ([217.140.110.172]:50498 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387827AbfHGPmY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Aug 2019 11:42:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 769C8344;
        Wed,  7 Aug 2019 08:42:23 -0700 (PDT)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72BB53F706;
        Wed,  7 Aug 2019 08:42:21 -0700 (PDT)
Date:   Wed, 7 Aug 2019 16:42:20 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org,
        viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net,
        catalin.marinas@arm.com, will@kernel.org,
        daniel.lezcano@linaro.org, lkp@intel.com
Cc:     dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        mka@chromium.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 3/3] thermal: cpu_cooling: Migrate to using the EM
 framework
Message-ID: <20190807154217.a4rxvj4uerptq52r@queper01-lin>
References: <20190801124643.17112-1-quentin.perret@arm.com>
 <20190801124643.17112-4-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801124643.17112-4-quentin.perret@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

On Thursday 01 Aug 2019 at 13:46:43 (+0100), Quentin Perret wrote:
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 9966364a6deb..340853a3ca48 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -144,6 +144,7 @@ config THERMAL_GOV_USER_SPACE
>  
>  config THERMAL_GOV_POWER_ALLOCATOR
>  	bool "Power allocator thermal governor"
> +	depends on ENERGY_MODEL
>  	help
>  	  Enable this to manage platform thermals by dynamically
>  	  allocating and limiting power to devices.

FYI, the kbuild bot just reported a randconfig build issue with this.
THERMAL_DEFAULT_GOV_POWER_ALLOCATOR 'select' THERMAL_GOV_POWER_ALLOCATOR
unconditionally. And I just learned 'select' will force the option ON
and totally ignore its dependencies. That is, we can end up with IPA
force-compiled in, and no PM_EM, which is broken.

So I guess the simplest fix is to do 'select ENERGY_MODEL' in this
patch, instead of depending on it.

I'll send a v7 with this fixed shortly.

Thanks,
Quentin
