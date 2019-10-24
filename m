Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B892E377E
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2019 18:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436744AbfJXQKs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Oct 2019 12:10:48 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:46662 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436675AbfJXQKs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Oct 2019 12:10:48 -0400
Received: by mail-vs1-f68.google.com with SMTP id x20so4872059vso.13
        for <linux-pm@vger.kernel.org>; Thu, 24 Oct 2019 09:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oPwRqVuZioNI5zzCe4McyYpyDcYBDdDoUcrFlLvw0Z4=;
        b=gG+a4r7xFkaTQbedGAdReWkvrW0hGRkyNIIaN6kzW4HynlY+NnLny7ki8JJEw1aoiJ
         OVq9R1i9BMm5i7hAvC/w6BfWOJ9sQHAW2fmeAWeh8pftG60gWobLI4obPybcYq+NY2jW
         ZIuQ1x3NoUB4Mahmxa+ycyMP/mxnG3mQfAbLE5RDhkWr9UNW6Hu63R2m4IsSMm+NTlI2
         HrZjdpFHJ33cHazd0sQmk8Phle5IWpAR9jL2sr3xVB6A96loIWiTyO6FLz93OpFDf4lG
         irZaMytK7YfNzTmwpUyjwLgoqkEia+W1kbr/YuQecKZqufm/C49e2+1nLflevoghJpn8
         tbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oPwRqVuZioNI5zzCe4McyYpyDcYBDdDoUcrFlLvw0Z4=;
        b=hXVC4fhOrvb/gHK23tcapbUGJlM37hWo/JLI1fjndgMvK6ADuUanLa0KqAqQcFe/k/
         9lpkBkfihDz5R2ze6bDzto2RUKu9F1T7IiwEyb6jP9kihYeczEe574fDXzsMfPtaY/Ft
         PDKK3vwQEk0aPyCB6asQAE89U62cDQrRcw0Ey3Mp6d5dTXaKn+CUktLpGMLt25DFXs+O
         i81md3wF+vK9j2LxwhUfwJTdu2LubdupybVOHhMALVhGqFUrFfBpKR1ymejJ3c/Lzm4d
         wkzdoHAdViAFvq9V6KeBAulz347Nix4CjMHibISrPb9VZZP6+r0j1UW5tijUmekX8VSk
         IbTw==
X-Gm-Message-State: APjAAAXYBNavBA+lNQ+JUlbEpaNYdcScxGJJZu34t8u9AtovtKuMIcqq
        HihvlyU7r0M+tzRSEom20gvr67kX1xWAUb5dDkLqgQ==
X-Google-Smtp-Source: APXvYqyFadXXYwQn6laGK9LBnkuyUL2KPLGVwe6A8SKL7OI6lBq84d6gdVTaE0vwr9XB80Mx6lz2fnshXN8DSlUDlwI=
X-Received: by 2002:a67:ead4:: with SMTP id s20mr7203435vso.165.1571933445627;
 Thu, 24 Oct 2019 09:10:45 -0700 (PDT)
MIME-Version: 1.0
References: <20191010113937.15962-2-ulf.hansson@linaro.org> <20191024151834.17036-1-sudeep.holla@arm.com>
In-Reply-To: <20191024151834.17036-1-sudeep.holla@arm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 24 Oct 2019 18:10:09 +0200
Message-ID: <CAPDyKFqOTpwZ_o0Z6hAFDXf9wJM82a_P8fcKkZY-ZfW-d9LFVQ@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: psci: Align psci_power_state count with idle
 state count
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 24 Oct 2019 at 17:18, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> Instead of allocating 'n-1' states in psci_power_state to manage 'n'
> idle states which include "ARM WFI" state, it would be simpler to have
> 1:1 mapping between psci_power_state and cpuidle driver states.
>
> ARM WFI state(i.e. idx == 0) is handled specially in the generic macro
> CPU_PM_CPU_IDLE_ENTER_PARAM and hence state[-1] is not possible. However
> for sake of code readability, it is better to have 1:1 mapping and not
> use [idx - 1] to access psci_power_state corresponding to driver cpuidle
> state for idx.
>
> psci_power_state[0] is default initialised to 0 and is never accessed
> while entering WFI state.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/cpuidle/cpuidle-psci.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> Hi Ulf, Lorenzo,
>
> Just to avoid confusion, I thought I will just write this patch as I was
> about to make reference to this in my review.

As discussed with Lorenzo, I said I was going to adopt his review
comments, which means I already have a patch for this locally.

Nevermind this time, but I would appreciate if this kind of
bikeshedding can been avoided future wise.

Kind regards
Uffe

>
> Regards,
> Sudeep
>
> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> index f3c1a2396f98..361985f52ddd 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -30,7 +30,7 @@ static int psci_enter_idle_state(struct cpuidle_device *dev,
>         u32 *state = __this_cpu_read(psci_power_state);
>
>         return CPU_PM_CPU_IDLE_ENTER_PARAM(psci_cpu_suspend_enter,
> -                                          idx, state[idx - 1]);
> +                                          idx, state[idx]);
>  }
>
>  static struct cpuidle_driver psci_idle_driver __initdata = {
> @@ -89,12 +89,14 @@ static int __init psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
>         if (!count)
>                 return -ENODEV;
>
> +       count++; /* Add WFI state too */
>         psci_states = kcalloc(count, sizeof(*psci_states), GFP_KERNEL);
>         if (!psci_states)
>                 return -ENOMEM;
>
> -       for (i = 0; i < count; i++) {
> -               state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
> +       for (i = 1; i < count; i++) {
> +               state_node = of_parse_phandle(cpu_node, "cpu-idle-states",
> +                                             i - 1);
>                 ret = psci_dt_parse_state_node(state_node, &psci_states[i]);
>                 of_node_put(state_node);
>
> --
> 2.17.1
>
