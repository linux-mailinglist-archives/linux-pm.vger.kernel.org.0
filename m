Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06B957175B
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 13:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732042AbfGWLrf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 07:47:35 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:43191 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732032AbfGWLre (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jul 2019 07:47:34 -0400
Received: by mail-vs1-f65.google.com with SMTP id j26so28587764vsn.10
        for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2019 04:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=geUtppPrfRUg4NfGL34dbIx6S9V8ieUS4VVaIVpw7T8=;
        b=XHQrWRNWIaq7gVu+WqM3lUbu5At0fR8soQbqJWerzBGj3iq8Jh7FQC7HnYdnsrOw/2
         4h/UOI2Ijk7FIguCbMP3BBZ1T4Rh3tPZWKVodUrEvqoPW+kWoqco+yb87JwscfUzvEFs
         zehINR8WOnJCyVs3GU2GnoHiLBKmYJuKJVoxAOSZnOyBJHjfqTxEd8Z69ehjQ93WugMB
         ZUw6rrD+qlQUD/hrb9TP3Xpm/L8iW5DfSAW+9zgbQNC12ySW9S83Rpw49/bhMFpjwvqq
         rwncfnzLh0DIOBSPVbSG0QHW6FSz+tpga99c6gZT3oNQJmKlt+iLpPliZjBAEhXiOfL0
         /UDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=geUtppPrfRUg4NfGL34dbIx6S9V8ieUS4VVaIVpw7T8=;
        b=o2p9q9N8VHQ4GxsH4R89OqpWaXuyQFtCrZvhH4Ku3K4cN9aEIRC/P0xQ6y7z67QV23
         ZPpnPBBQHqYWhl1ojVwdVX63uTtEY0nIUj2Y1McMZ3acM0c+zHeIuIZ1XxiHcCTMX5ST
         kk/pM37C84/indf4TPjylqJH6nG/zEJ5Ozyrz29q30uWLhK7SP59ATeOBr5T7MV1Zo6G
         dxOFu9IODYTtOx/s2Kf3/ZQ5WtwuuMIIFObjEWYdEs/vyWr0zxUqFKbY/qAWeNjpEEcF
         uRIVRffuoutdKbs4zfxmW2pGO314fUXLqd+M4D5J/rlzSB59WRFDPfTXQxGcCTaym+XL
         4xCQ==
X-Gm-Message-State: APjAAAXFHSmfBtRCayR/HGPSa044jyri3VYMLX0hoZQAsViheV9/8Znr
        EyQfWt8WgS73yKYiL2CkAOaDiy4ACeeGWoP+nN55Uw==
X-Google-Smtp-Source: APXvYqyQ7eltBtSxqPsnhCuQloUKpx1CQdA3jlUrwfbQpQPR8C3fB3pvMyrBd8baT9CeIxn12qkGDoiwZQb6qlcis+s=
X-Received: by 2002:a67:ee16:: with SMTP id f22mr46522596vsp.191.1563882453209;
 Tue, 23 Jul 2019 04:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190722153745.32446-1-lorenzo.pieralisi@arm.com> <20190722153745.32446-5-lorenzo.pieralisi@arm.com>
In-Reply-To: <20190722153745.32446-5-lorenzo.pieralisi@arm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 23 Jul 2019 13:46:56 +0200
Message-ID: <CAPDyKFppc32r=3w3g5nmHWDR5qR1vxsYjQ1b_GQoc_Gk=ni24A@mail.gmail.com>
Subject: Re: [PATCH 4/6] ARM: psci: cpuidle: Introduce PSCI CPUidle driver
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LAKML <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

[...]

> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -0,0 +1,150 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * PSCI CPU idle driver.
> + *
> + * Copyright (C) 2019 ARM Ltd.
> + * Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> + */
> +
> +#define pr_fmt(fmt) "CPUidle PSCI: " fmt
> +
> +#include <linux/cpuidle.h>
> +#include <linux/cpumask.h>
> +#include <linux/cpu_pm.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/psci.h>
> +#include <linux/slab.h>
> +
> +#include <asm/cpuidle.h>

This should go away, right?

> +
> +#include "dt_idle_states.h"
> +
> +static int psci_enter_idle_state(struct cpuidle_device *dev,
> +                               struct cpuidle_driver *drv, int idx)
> +{
> +       return CPU_PM_CPU_IDLE_ENTER(psci_cpu_suspend_enter, idx);
> +}
> +
> +static struct cpuidle_driver psci_idle_driver __initdata = {
> +       .name = "psci_idle",
> +       .owner = THIS_MODULE,
> +       /*
> +        * PSCI idle states relies on architectural WFI to
> +        * be represented as state index 0.
> +        */
> +       .states[0] = {
> +               .enter                  = psci_enter_idle_state,
> +               .exit_latency           = 1,
> +               .target_residency       = 1,
> +               .power_usage            = UINT_MAX,
> +               .name                   = "WFI",
> +               .desc                   = "ARM WFI",
> +       }
> +};
> +
> +static const struct of_device_id psci_idle_state_match[] __initconst = {
> +       { .compatible = "arm,idle-state",
> +         .data = psci_enter_idle_state },
> +       { },
> +};
> +
> +static int __init psci_idle_init_cpu(int cpu)
> +{
> +       struct cpuidle_driver *drv;
> +       struct device_node *cpu_node;
> +       const char *enable_method;
> +       int ret = 0;
> +
> +       drv = kmemdup(&psci_idle_driver, sizeof(*drv), GFP_KERNEL);
> +       if (!drv)
> +               return -ENOMEM;
> +
> +       drv->cpumask = (struct cpumask *)cpumask_of(cpu);
> +
> +       cpu_node = of_get_cpu_node(cpu, NULL);
> +       if (!cpu_node)
> +               return -ENODEV;

You should free drv in case of error here (goto out_kfree_drv; etc).

> +
> +       /*
> +        * Check whether the enable-method for the cpu is PSCI, fail
> +        * if it is not.
> +        */
> +       enable_method = of_get_property(cpu_node, "enable-method", NULL);
> +       if (!enable_method || (strcmp(enable_method, "psci")))
> +               ret = -ENODEV;
> +
> +       of_node_put(cpu_node);
> +       if (ret)
> +               return ret;

You should free drv in case of error here (goto out_kfree_drv;).

> +
> +       /*
> +        * Initialize idle states data, starting at index 1, since
> +        * by default idle state 0 is the quiescent state reached
> +        * by the cpu by executing the wfi instruction.
> +        *
> +        * If no DT idle states are detected (ret == 0) let the driver
> +        * initialization fail accordingly since there is no reason to
> +        * initialize the idle driver if only wfi is supported, the
> +        * default archictectural back-end already executes wfi
> +        * on idle entry.
> +        */
> +       ret = dt_init_idle_driver(drv, psci_idle_state_match, 1);
> +       if (ret <= 0) {
> +               ret = ret ? : -ENODEV;
> +               goto out_kfree_drv;
> +       }
> +
> +       /*
> +        * Initialize PSCI idle states.
> +        */
> +       ret = psci_cpu_init_idle(cpu);
> +       if (ret) {
> +               pr_err("CPU %d failed to PSCI idle\n", cpu);
> +               goto out_kfree_drv;
> +       }
> +
> +       ret = cpuidle_register(drv, NULL);
> +       if (ret)
> +               goto out_kfree_drv;
> +
> +       return 0;
> +
> +out_kfree_drv:
> +       kfree(drv);
> +       return ret;
> +}
> +

[...]

Kind regards
Uffe
