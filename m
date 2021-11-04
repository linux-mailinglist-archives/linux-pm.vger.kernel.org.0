Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 697764459F4
	for <lists+linux-pm@lfdr.de>; Thu,  4 Nov 2021 19:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbhKDStT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Nov 2021 14:49:19 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:43804 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbhKDStS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Nov 2021 14:49:18 -0400
Received: by mail-ot1-f49.google.com with SMTP id n13-20020a9d710d000000b005558709b70fso9543097otj.10;
        Thu, 04 Nov 2021 11:46:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DibJrm4A9ig/vBo1EjDioFiIQk3mKd4WJjbVURulMb4=;
        b=00mdBxoJEW9fR8XnU1n/NPoPkzeAbFAzBaKS+RQRzEp7MIKf9WUDrneiLSGm5g2jWD
         yioFEY2MSAd5X8b8Kys44ZIOq8KHbR1bWtomHDRIMAJ5e1yD3lNI9pv/VlVD00T6a914
         mZpYqNIWzQzKyJfiGb9oBoeM4Cfu/LoFcZ1rR/7Y6casys1ivCfPoQ3fgTNURAwRgMcj
         0zKNKbG/+55SU+Nqn+sFVmpUQZ8PNlHND2Qk+FCTO00gAUGnmz5UlgLBk1BzhU8vSiwo
         pBupOysB0xZIXHYQJ3cQVbO34291y+0F27mZJBig1sxmklGj6TTqsYtvyZwYUQq/baPu
         bawA==
X-Gm-Message-State: AOAM533z0jfPDtsONomY2UBoHxzSRfkk6SsjAy+VFU8XLjPHVnkv5Q7J
        MntElKJqAPBxuz9fZ7+2yDmzoBIr2AyW96ktGNc=
X-Google-Smtp-Source: ABdhPJwQnNjp3uYgBocO01tJttUYZD/1g6MMnI1UZa5kkK2HlPf3uKpAJyavXP4I/0VCGiDu5nLKWC0dOwvQGzLN8DY=
X-Received: by 2002:a9d:a64:: with SMTP id 91mr33119161otg.198.1636051600270;
 Thu, 04 Nov 2021 11:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <20211029123855.80344-1-ulf.hansson@linaro.org>
In-Reply-To: <20211029123855.80344-1-ulf.hansson@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 4 Nov 2021 19:46:29 +0100
Message-ID: <CAJZ5v0gMNP_MLCJiZq8FCCOXxh+V31gTCx5OCNpP-__9Pq0_uA@mail.gmail.com>
Subject: Re: [PATCH v2] PM: sleep: Fix runtime PM based cpuidle support
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Anup Patel <anup.patel@wdc.com>,
        Len Brown <len.brown@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 29, 2021 at 2:39 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> In the cpuidle-psci case, runtime PM in combination with the generic PM
> domain (genpd), may be used when entering/exiting a shared idlestate. More
> precisely, genpd relies on runtime PM to be enabled for the attached device
> (in this case it belongs to a CPU), to properly manage the reference
> counting of its PM domain.
>
> This works fine most of the time, but during system suspend in
> dpm_suspend_late(), the PM core disables runtime PM for all devices. Beyond
> this point, calls to pm_runtime_get_sync() to runtime resume a device may
> fail and therefore it could also mess up the reference counting in genpd.
>
> To fix this problem, let's call wake_up_all_idle_cpus() in
> dpm_suspend_late(), prior to disabling runtime PM. In this way a device
> that belongs to a CPU, becomes runtime resumed through cpuidle-psci and
> stays like that, because the runtime PM usage count has been bumped in
> device_prepare().
>
> Diagnosed-by: Maulik Shah <mkshah@codeaurora.org>
> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Changes in v2:
>         - Moved away from using cpuidle_pause|resume() to solve the problem, but
>         instead just waking up idle CPUs is suffient, due to other recent merged
>         changes.
>
> ---
>  drivers/base/power/main.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index ac4dde8fdb8b..2fb08d4f1aca 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1463,6 +1463,7 @@ int dpm_suspend_late(pm_message_t state)
>         int error = 0;
>
>         trace_suspend_resume(TPS("dpm_suspend_late"), state.event, true);
> +       wake_up_all_idle_cpus();
>         mutex_lock(&dpm_list_mtx);
>         pm_transition = state;
>         async_error = 0;
> --

Applied as 5.16-rc material, thanks!
