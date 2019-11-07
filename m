Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA9CF2A52
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2019 10:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733292AbfKGJNl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Nov 2019 04:13:41 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46743 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733139AbfKGJNl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Nov 2019 04:13:41 -0500
Received: by mail-lj1-f193.google.com with SMTP id e9so1359450ljp.13
        for <linux-pm@vger.kernel.org>; Thu, 07 Nov 2019 01:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LPQPuxtLS0wBLc1/+9eubfNrLFMix+bCX6gszcE70UI=;
        b=bEULiHmOuf1HTGFS6AMXpNax+qNhL5eCmZTs+2IVLBW1UN9AReDNy88JQLc9RmoT0/
         AglWvZ4JyemQBu4NXnKYeQYM0Zpqmhw5eGnh0Xo3seIxGnEm6eDyVgzRGAUZdEZ2QFe/
         uC5D6iKkSoV2H4uvTbDoP2UaF9KHAdp5VncBV2UPBWUtH2dSO8rcM8jdWVJrf+Osd7uv
         2RR9xCRjOW8Ou2jwK0LbMje29i+QlpbqBZVajPT85Ef8XV0smsMPNZg1l6cPoKbm23Lq
         DJE3HvfVQMWCG3A1r3ylgbF32kj5o/7QZCOdXbw3EMT/qJ1Y0cTHkJEVE96ToztyZT3b
         ht9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LPQPuxtLS0wBLc1/+9eubfNrLFMix+bCX6gszcE70UI=;
        b=byMwJX0AEiTQI6HQPX9W2k/hDLU3DXTFYzHMnaPXxqRCPgPyv5FR31p/g3S2/QFSs8
         KigamOdy2SCxhsY1H9AR28hXH7tCXVaK8mPdEHDoyZ+rlldv03BIpmpz1LWnc2cguQ03
         cJ1zRIa/5c+AQ9kx1vHlY+2Bydsp2mzZoU2IG5JjluTMuGE4mHffaMPayyeHo9vJfYRj
         6IDbE3ZD2vjbEmILbFtN+gqXO/BPaKwSMi00VDyVCGfhyplbc5D4uXQ47blXYxvyba/W
         dCP3TwOSHC3F1yqseCfgmzlPdVMLVDwpVORaWGh3F6y8rZd9h5HCwecCFYCCv7exMdBJ
         rXYg==
X-Gm-Message-State: APjAAAUZIxIcqQr3lfPngK8oX6T52i6k8/DEGWNfRhGjhvV5g2NgJZ7B
        yQBL/EHxT6ZCcdD9jj6udc7Ba4gDF+TB7A==
X-Google-Smtp-Source: APXvYqyCjFuNgyt3EBG/w74fgOl3eGm+zGJoqmESg11K2TzP1tc8+EvvcSZonnSAzeV2OuHFP/I7uA==
X-Received: by 2002:a2e:2a43:: with SMTP id q64mr1607074ljq.242.1573118018614;
        Thu, 07 Nov 2019 01:13:38 -0800 (PST)
Received: from centauri.lan (ua-84-217-220-205.bbcust.telenor.se. [84.217.220.205])
        by smtp.gmail.com with ESMTPSA id i18sm840879lfc.82.2019.11.07.01.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 01:13:37 -0800 (PST)
Date:   Thu, 7 Nov 2019 10:13:35 +0100
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 08/13] cpuidle: psci: Add a helper to attach a CPU to
 its PM domain
Message-ID: <20191107091335.GA1914942@centauri.lan>
References: <20191029164438.17012-1-ulf.hansson@linaro.org>
 <20191029164438.17012-9-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029164438.17012-9-ulf.hansson@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 29, 2019 at 05:44:33PM +0100, Ulf Hansson wrote:
> Introduce a PSCI DT helper function, psci_dt_attach_cpu(), which takes a
> CPU number as an in-parameter and tries to attach the CPU's struct device
> to its corresponding PM domain.
> 
> Let's makes use of dev_pm_domain_attach_by_name(), as it allows us to
> specify "psci" as the "name" of the PM domain to attach to. Additionally,
> let's also prepare the attached device to be power managed via runtime PM.
> 
> Note that, the implementation of the new helper function is in a new
> separate c-file, which may seems a bit too much at this point. However,
> subsequent changes that implements the remaining part of the PM domain
> support for cpuidle-psci, helps to justify this split.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes in v2:
> 	- Reorder patch to be the first one that starts adding the PM domain
> 	  support.
> 	- Rebased.
> 
> ---
>  drivers/cpuidle/Makefile              |  4 ++-
>  drivers/cpuidle/cpuidle-psci-domain.c | 36 +++++++++++++++++++++++++++
>  drivers/cpuidle/cpuidle-psci.h        | 12 +++++++++
>  3 files changed, 51 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/cpuidle/cpuidle-psci-domain.c
>  create mode 100644 drivers/cpuidle/cpuidle-psci.h
> 
> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
> index ee70d5cc5b99..cc8c769d7fa9 100644
> --- a/drivers/cpuidle/Makefile
> +++ b/drivers/cpuidle/Makefile
> @@ -21,7 +21,9 @@ obj-$(CONFIG_ARM_U8500_CPUIDLE)         += cpuidle-ux500.o
>  obj-$(CONFIG_ARM_AT91_CPUIDLE)          += cpuidle-at91.o
>  obj-$(CONFIG_ARM_EXYNOS_CPUIDLE)        += cpuidle-exynos.o
>  obj-$(CONFIG_ARM_CPUIDLE)		+= cpuidle-arm.o
> -obj-$(CONFIG_ARM_PSCI_CPUIDLE)		+= cpuidle-psci.o
> +obj-$(CONFIG_ARM_PSCI_CPUIDLE)		+= cpuidle_psci.o
> +cpuidle_psci-y				:= cpuidle-psci.o
> +cpuidle_psci-$(CONFIG_PM_GENERIC_DOMAINS_OF) += cpuidle-psci-domain.o
>  
>  ###############################################################################
>  # MIPS drivers
> diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> new file mode 100644
> index 000000000000..bc7df4dc0686
> --- /dev/null
> +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> @@ -0,0 +1,36 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PM domains for CPUs via genpd - managed by cpuidle-psci.
> + *
> + * Copyright (C) 2019 Linaro Ltd.
> + * Author: Ulf Hansson <ulf.hansson@linaro.org>
> + *
> + */
> +
> +#include <linux/cpu.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/pm_domain.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/psci.h>
> +
> +#include "cpuidle-psci.h"
> +
> +struct device *psci_dt_attach_cpu(int cpu)
> +{
> +	struct device *dev;
> +
> +	/* Currently limit the hierarchical topology to be used in OSI mode. */
> +	if (!psci_has_osi_support())
> +		return NULL;
> +
> +	dev = dev_pm_domain_attach_by_name(get_cpu_device(cpu), "psci");

Hello Ulf,

here you use dev_pm_domain_attach_by_name(), which will call
genpd_dev_pm_attach_by_name(), which will call genpd_dev_pm_attach_by_id(),
which will call __genpd_dev_pm_attach(virt_dev, dev, index, false);
the last argument is power_on, which here is always set to false.

In older versions of your patch series, psci_dt_attach_cpu() called
dev_pm_domain_attach(dev, true), where the last argument is power_on.
Interestingly enough (for the non-ACPI case), dev_pm_domain_attach()
ignores the power_on parameter, and simply calls genpd_dev_pm_attach(dev);
which will call __genpd_dev_pm_attach(dev, dev, 0, true);
the last argument is power_on, which here is always set to true.

In other words, your previous patch series always powered on the power
domain, while the newer versions do not. Is this change intentional?
Perhaps psci_dt_attach_cpu() should call dev_to_genpd(dev)->power_on()
after attaching the power domain? (In order to be consistent with the
previous behavior of this patch series.)


Kind regards,
Niklas

> +	if (IS_ERR_OR_NULL(dev))
> +		return dev;
> +
> +	pm_runtime_irq_safe(dev);
> +	if (cpu_online(cpu))
> +		pm_runtime_get_sync(dev);
> +
> +	return dev;
> +}
> diff --git a/drivers/cpuidle/cpuidle-psci.h b/drivers/cpuidle/cpuidle-psci.h
> new file mode 100644
> index 000000000000..0cadbb71dc55
> --- /dev/null
> +++ b/drivers/cpuidle/cpuidle-psci.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __CPUIDLE_PSCI_H
> +#define __CPUIDLE_PSCI_H
> +
> +#ifdef CONFIG_PM_GENERIC_DOMAINS_OF
> +struct device *psci_dt_attach_cpu(int cpu);
> +#else
> +static inline struct device *psci_dt_attach_cpu(int cpu) { return NULL; }
> +#endif
> +
> +#endif /* __CPUIDLE_PSCI_H */
> -- 
> 2.17.1
> 
