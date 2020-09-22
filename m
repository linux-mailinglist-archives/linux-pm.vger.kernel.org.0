Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 566162745D8
	for <lists+linux-pm@lfdr.de>; Tue, 22 Sep 2020 17:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgIVP5R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Sep 2020 11:57:17 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45872 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgIVP5R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Sep 2020 11:57:17 -0400
Received: by mail-oi1-f194.google.com with SMTP id z26so21527977oih.12;
        Tue, 22 Sep 2020 08:57:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H7GTMYyDTGfT2GkuPOYpbPR9aCxeCsMt4Pl5zwmZ3aQ=;
        b=ZHoXZYi+V2kiyf52ylq5HGU18/Y5PtAZUFjAIpn7h4AJG7Si2wE6xY8zTjAYzygwr9
         KJCmBiSggH5RfRPEJe6yNfUJUnpjP1KtLS8d9CoEbRvFz23kNYkRxgRF3AL8zS94cTrv
         bVVnL2jrRDGf1Ry+AueSEhCtyVZ+22AcZe0kkkXbi8DJvBlk/8dakqYnysGSwGKd1++s
         QTV+2GbM2bunuVf6R811zs7EzoXdHlbbLNNej2g74j/e3gL2WtHA1it425+u1Ma0fxO1
         NyCLSXuoNg1As4p7tHNIev2JIdUNntG9taz7Fw2Edk9cxtwOapT452suhCL0iBRhbGKw
         0WhA==
X-Gm-Message-State: AOAM533SDzECuY+1loteK2dtR9KscopLi8GPoWIMZL088jbRUQyPHdXj
        9/NE7PTQyv3pkXo5NcJnNbPpSysckaqS1t8oxQ4=
X-Google-Smtp-Source: ABdhPJySETBo8YtEgNAde+S5KENFHtSP29em06c8SeyWbwPKS6nl0wIvxxd16q5d/ROKSfXuO6+g7rbOC9AHW8Joloc=
X-Received: by 2002:a05:6808:491:: with SMTP id z17mr3163364oid.110.1600790236736;
 Tue, 22 Sep 2020 08:57:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200902210116.7360-1-ilina@codeaurora.org>
In-Reply-To: <20200902210116.7360-1-ilina@codeaurora.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Sep 2020 17:57:05 +0200
Message-ID: <CAJZ5v0gWVVPF_S_=1WyXAiB0Gse6PO8VZQf0yAr=in15CM3w7w@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: record state entry failed statistics
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sorry for the delay.

On Wed, Sep 2, 2020 at 11:01 PM Lina Iyer <ilina@codeaurora.org> wrote:
>
> When CPUs fail to enter the chosen idle state it's mostly because of a
> pending interrupt. Let's record that and show along with other
> statistics for the idle state. This could prove useful in understanding
> behavior of the governor and the system during usecases that involve
> multiple CPUs.
>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
>  drivers/cpuidle/cpuidle.c | 1 +
>  drivers/cpuidle/sysfs.c   | 3 +++
>  include/linux/cpuidle.h   | 1 +

The documentation needs to be updated too to cover the new state attribute.

>  3 files changed, 5 insertions(+)
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 04becd70cc41..8dbf71f6138d 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -302,6 +302,7 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
>                 }
>         } else {
>                 dev->last_residency_ns = 0;
> +               dev->states_usage[index].failed++;
>         }
>
>         return entered_state;
> diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
> index 091d1caceb41..f166687b3bcd 100644
> --- a/drivers/cpuidle/sysfs.c
> +++ b/drivers/cpuidle/sysfs.c
> @@ -256,6 +256,7 @@ define_show_state_time_function(exit_latency)
>  define_show_state_time_function(target_residency)
>  define_show_state_function(power_usage)
>  define_show_state_ull_function(usage)
> +define_show_state_ull_function(failed)

And what about calling it "rejected" instead of "failed"?

>  define_show_state_str_function(name)
>  define_show_state_str_function(desc)
>  define_show_state_ull_function(above)
> @@ -312,6 +313,7 @@ define_one_state_ro(latency, show_state_exit_latency);
>  define_one_state_ro(residency, show_state_target_residency);
>  define_one_state_ro(power, show_state_power_usage);
>  define_one_state_ro(usage, show_state_usage);
> +define_one_state_ro(failed, show_state_failed);
>  define_one_state_ro(time, show_state_time);
>  define_one_state_rw(disable, show_state_disable, store_state_disable);
>  define_one_state_ro(above, show_state_above);
> @@ -325,6 +327,7 @@ static struct attribute *cpuidle_state_default_attrs[] = {
>         &attr_residency.attr,
>         &attr_power.attr,
>         &attr_usage.attr,
> +       &attr_failed.attr,
>         &attr_time.attr,
>         &attr_disable.attr,
>         &attr_above.attr,
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index 75895e6363b8..911b99273eba 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -38,6 +38,7 @@ struct cpuidle_state_usage {
>         u64                     time_ns;
>         unsigned long long      above; /* Number of times it's been too deep */
>         unsigned long long      below; /* Number of times it's been too shallow */
> +       unsigned long long      failed; /* Number of times it failed to enter */
>  #ifdef CONFIG_SUSPEND
>         unsigned long long      s2idle_usage;
>         unsigned long long      s2idle_time; /* in US */
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
