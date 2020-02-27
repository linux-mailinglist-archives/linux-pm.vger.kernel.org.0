Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1C21721BC
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2020 16:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbgB0PAE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Feb 2020 10:00:04 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34770 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729225AbgB0PAE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Feb 2020 10:00:04 -0500
Received: by mail-lj1-f194.google.com with SMTP id x7so3812157ljc.1
        for <linux-pm@vger.kernel.org>; Thu, 27 Feb 2020 07:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hxeWwBcREguPRl0YSA1dgvNqgcNAs0sxdnLT2TcjVKw=;
        b=DKqDIIpoLHVG44IrAEf+PRHSTcuSWfXxD+2nA4ZhpMhTgNtxZdbDaqPGFFDw+AIADp
         DeglF7v8V6yRy4zI355DozwcmtVhYZR1Jv7+oiNimsV+QjPzdgsM7oWJUt1R/XVEoViO
         3d7Vpatif8yuhVEL2Ld1D5sSk8ecfgDl+KLKpxqM6VZh3GExDDdg4+rEhY1Bc038TJSw
         Cc1slFgYx641oA0ubt+0ogIgg5uLSKald1Kn3c7wCbA0I3LEISHpCPYLH0MN8CgGZtJU
         2fzyQvaHkQ/yVP7aZE6d2hIk0SpCqJw+wPuDgT9LO3ZU7VpdATq+8D5nBXGBVl/HO7Ye
         dP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hxeWwBcREguPRl0YSA1dgvNqgcNAs0sxdnLT2TcjVKw=;
        b=duJRmn73VRD0qkbewN/vdnh+EsEkEIQxmrVsdZD0H1jO6oLh5bTjdLaxAfIUJMJgwF
         Tp6Er00RZ5mNhq06lnLuh4K77PSc6gno5h2bPdwlQovDAM0Y+GInaRSVEgdnMnS6MdeJ
         5Nm1VpeQSNbBTTainon5tujUBzr6a0WYcTAwSNTdIwkkN+2iTdZVb8MVn0vdMv8gVwLE
         Y0nACn+ZvlAIJJ+rjhKorSBTZ0rIVEzX2kxwA3gqXj7vwSO4rI/N5E9jzNaXrGlEQLFA
         JLZlHvA0UgTcjDSKwkJmTz4NL2/uUgU0fcXUHNAInVqFNaOFkJqg59asMNJS6xnzqAPz
         muvg==
X-Gm-Message-State: ANhLgQ2WnD5kjSAcYqWPcRo8ixNmfE3/4ojNGEGZJXWsmfuO00PY5czP
        gTL0GpGMwhgObcofWRN1LEBVml4MSs3nMPCyaBvcTA==
X-Google-Smtp-Source: ADFU+vtEkEqJMoxuvqwe9HyeeqaH1txbxfmCDLVTHZYAoZWVbLPzsQkGedE2YbfF1pCcxvkyjdjR7crgmlE2z2mN8mg=
X-Received: by 2002:a2e:5304:: with SMTP id h4mr3074729ljb.75.1582815602132;
 Thu, 27 Feb 2020 07:00:02 -0800 (PST)
MIME-Version: 1.0
References: <20200227124551.31860-1-ulf.hansson@linaro.org> <20200227124551.31860-5-ulf.hansson@linaro.org>
In-Reply-To: <20200227124551.31860-5-ulf.hansson@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 27 Feb 2020 15:59:25 +0100
Message-ID: <CAPDyKFqeHLeMrOEPg1p6WaLOApRzJbzNL343d2d43bEQxOAz5w@mail.gmail.com>
Subject: Re: [PATCH 4/4] cpuidle: psci: Allow WFI to be the only state for the
 hierarchical topology
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 27 Feb 2020 at 13:46, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> It's possible that only the WFI state is supported for the CPU, while also
> a shared idle state exists for a group of CPUs.
>
> When the hierarchical topology is used, the shared idle state may not be
> compatible with arm,idle-state, rather with "domain-idle-state", which
> makes dt_init_idle_driver() to return zero. This leads to that the
> cpuidle-psci driver bails out during initialization, avoiding to register a
> cpuidle driver and instead relies on the default architectural
> back-end (called via cpu_do_idle()). In other words, the shared idle state
> becomes unused.
>
> Let's fix this behaviour, by allowing the dt_init_idle_driver() to return 0
> and then continue with the initialization. If it turns out that the
> hierarchical topology is used and we have some additional states to manage,
> then continue with the cpuidle driver registration, otherwise bail out, as
> we did before.
>
> Reported-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> Fixes: a65a397f2451 ("cpuidle: psci: Add support for PM domains by using genpd")
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/cpuidle/cpuidle-psci.c | 47 ++++++++++++++++++++++------------
>  1 file changed, 30 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> index 7b459f987c50..7699b2dab622 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -56,16 +56,19 @@ static int psci_enter_domain_idle_state(struct cpuidle_device *dev,
>         u32 *states = data->psci_states;
>         struct device *pd_dev = data->dev;
>         u32 state;
> -       int ret;
> +       int ret = 0;
>
>         /* Do runtime PM to manage a hierarchical CPU toplogy. */
>         pm_runtime_put_sync_suspend(pd_dev);
>
>         state = psci_get_domain_state();
> -       if (!state)
> +       if (!state && states)
>                 state = states[idx];
>
> -       ret = psci_enter_state(idx, state);
> +       if (state)
> +               ret = psci_cpu_suspend_enter(state);

Looks like I should set ret to idx, if ret == 0 - as to instruct
cpuidle about what state we did enter. I will update that in the next
revision, but awaiting for some comments first.

> +       else
> +               cpu_do_idle();
>
>         pm_runtime_get_sync(pd_dev);
>

[...]

Kind regards
Uffe
