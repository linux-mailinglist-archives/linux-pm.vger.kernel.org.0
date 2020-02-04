Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E34D152018
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2020 18:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbgBDR6l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Feb 2020 12:58:41 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:41750 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbgBDR6i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Feb 2020 12:58:38 -0500
Received: by mail-vs1-f65.google.com with SMTP id k188so11911486vsc.8
        for <linux-pm@vger.kernel.org>; Tue, 04 Feb 2020 09:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tzVO/i3RlK8wTW0CtIUDqXR3obK88NMKP/u+iDd4rUQ=;
        b=O5VDOtm/ib9l1nZlkLp5aAjoHDGmbe/pDbvrnrOFQxx0ugJzt1szBuYP/xwnZgETip
         P7HAfIEw3unJXYEVS4ie/bxig8VQ0AorpiyBzWFvlFBu2KjH3y4NnS7MNtts3L5btYIC
         ij6sGv8mGSatOqli5mxV83kZVF3PE/4COaxgB7LSHF5HBP1q8UWGxi8IFnO4JFFHivpB
         4P+JhkKMxD2r24UnI3YkDjuXSbSgbHBTDZuRqnMayX0j18RWJJ47chbBK1li9ZMqSFeQ
         hiZrZN3Z8qSqzz9dE8/gSy8tALakqrzvM01IHNEFKAhrSTNr8tFlilhaAGg4OUOCOCvD
         kdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tzVO/i3RlK8wTW0CtIUDqXR3obK88NMKP/u+iDd4rUQ=;
        b=pyRPJp11cveDxgi7FNDSOl/g9wLel+NRf/3qEThyV+3OaF6Z0qIfZLplkNQ5Yd90X2
         RqfLP0YAjT0yoN3AHer3/CbUnpLfELbnS4L2xrFySgguMmwjijOuJZoyCfr5+WzGkrvP
         u4iibtx+XBVu9MaTL9c6uY9uN/T4CA4UZFa56lJ22Jy3A5FanFOAVxuQ7llAf+nmNnxy
         Hzv93Chmwymp7S2UGP27lDhiW4tcAg1ooPJpthOofyQu2yFN7f5gRwDeDYmgEticnZC0
         jbEfXoEIC5+oX75rXbLu0iPPWQ79J/6DxWfv1lGGVXunJhiQXQEvEboaYSzK1z1dgVM1
         nC6g==
X-Gm-Message-State: APjAAAWAsnD7eTvk54xRtyLg4SSh2n9ditTOtnUwl7uVd1wkuqvGjTXo
        F4XPX5nKXfsxjqn7GAuOPleAGpGJuCCwnIU92/nOEg==
X-Google-Smtp-Source: APXvYqy8K0HZyom2Se94kPkPrPAC4jNuAoEYRybckINHoKbQmKOYiKuIMKD8CqYzd04t+SoQUijdLLODpClkxzUnst0=
X-Received: by 2002:a05:6102:757:: with SMTP id v23mr19931507vsg.35.1580839116928;
 Tue, 04 Feb 2020 09:58:36 -0800 (PST)
MIME-Version: 1.0
References: <20200115013751.249588-1-swboyd@chromium.org>
In-Reply-To: <20200115013751.249588-1-swboyd@chromium.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 4 Feb 2020 18:58:00 +0100
Message-ID: <CAPDyKFrQoWaj6uc4Ej_0sUk01X=denmu=v6vq-KgNePbNxkwmw@mail.gmail.com>
Subject: Re: [PATCH] drivers: qcom: rpmh-rsc: Use rcuidle tracepoints for rpmh
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 15 Jan 2020 at 02:37, Stephen Boyd <swboyd@chromium.org> wrote:
>
> This tracepoint is hit now that we call into the rpmh code from the cpu
> idle path. Let's move this to be an rcuidle tracepoint so that we avoid
> the RCU idle splat below
>
>  =============================
>  WARNING: suspicious RCU usage
>  5.4.10 #68 Tainted: G S
>  -----------------------------
>  drivers/soc/qcom/trace-rpmh.h:72 suspicious rcu_dereference_check() usage!
>
>  other info that might help us debug this:
>
>  RCU used illegally from idle CPU!
>  rcu_scheduler_active = 2, debug_locks = 1
>  RCU used illegally from extended quiescent state!
>  5 locks held by swapper/2/0:
>   #0: ffffff81745d6ee8 (&(&genpd->slock)->rlock){+.+.}, at: genpd_lock_spin+0x1c/0x2c
>   #1: ffffff81745da6e8 (&(&genpd->slock)->rlock/1){....}, at: genpd_lock_nested_spin+0x24/0x34
>   #2: ffffff8174f2ca20 (&(&genpd->slock)->rlock/2){....}, at: genpd_lock_nested_spin+0x24/0x34
>   #3: ffffff8174f2c300 (&(&drv->client.cache_lock)->rlock){....}, at: rpmh_flush+0x48/0x24c
>   #4: ffffff8174f2c150 (&(&tcs->lock)->rlock){+.+.}, at: rpmh_rsc_write_ctrl_data+0x74/0x270
>
>  stack backtrace:
>  CPU: 2 PID: 0 Comm: swapper/2 Tainted: G S                5.4.10 #68
>  Call trace:
>   dump_backtrace+0x0/0x174
>   show_stack+0x20/0x2c
>   dump_stack+0xc8/0x124
>   lockdep_rcu_suspicious+0xe4/0x104
>   __tcs_buffer_write+0x230/0x2d0
>   rpmh_rsc_write_ctrl_data+0x210/0x270
>   rpmh_flush+0x84/0x24c
>   rpmh_domain_power_off+0x78/0x98
>   _genpd_power_off+0x40/0xc0
>   genpd_power_off+0x168/0x208
>   genpd_power_off+0x1e0/0x208
>   genpd_power_off+0x1e0/0x208
>   genpd_runtime_suspend+0x1ac/0x220
>   __rpm_callback+0x70/0xfc
>   rpm_callback+0x34/0x8c
>   rpm_suspend+0x218/0x4a4
>   __pm_runtime_suspend+0x88/0xac
>   psci_enter_domain_idle_state+0x3c/0xb4
>   cpuidle_enter_state+0xb8/0x284
>   cpuidle_enter+0x38/0x4c
>   call_cpuidle+0x3c/0x68
>   do_idle+0x194/0x260
>   cpu_startup_entry+0x24/0x28
>   secondary_start_kernel+0x150/0x15c
>
> Fixes: a65a397f2451 ("cpuidle: psci: Add support for PM domains by using genpd")
> Reported-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Sorry for the delay and many thanks for fixing this!

> ---
>
> I think the commit that this is "Fixes"ing is a stable commit, but I'm
> not positive.

Correct, the commit is in Linus' tree by now.

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

>
>  drivers/soc/qcom/rpmh-rsc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> index e278fc11fe5c..b71822131f59 100644
> --- a/drivers/soc/qcom/rpmh-rsc.c
> +++ b/drivers/soc/qcom/rpmh-rsc.c
> @@ -277,7 +277,7 @@ static void __tcs_buffer_write(struct rsc_drv *drv, int tcs_id, int cmd_id,
>                 write_tcs_cmd(drv, RSC_DRV_CMD_MSGID, tcs_id, j, msgid);
>                 write_tcs_cmd(drv, RSC_DRV_CMD_ADDR, tcs_id, j, cmd->addr);
>                 write_tcs_cmd(drv, RSC_DRV_CMD_DATA, tcs_id, j, cmd->data);
> -               trace_rpmh_send_msg(drv, tcs_id, j, msgid, cmd);
> +               trace_rpmh_send_msg_rcuidle(drv, tcs_id, j, msgid, cmd);
>         }
>
>         write_tcs_reg(drv, RSC_DRV_CMD_WAIT_FOR_CMPL, tcs_id, cmd_complete);
> --
> Sent by a computer, using git, on the internet
>
