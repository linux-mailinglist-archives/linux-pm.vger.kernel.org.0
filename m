Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F14EF13B9F4
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2020 07:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgAOGyC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jan 2020 01:54:02 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:37852 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725962AbgAOGyC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jan 2020 01:54:02 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1579071241; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=s37LLIPYFReLdb0u97Mk+1cz4+bjCaaV9gp2iuq6M2Q=;
 b=FRROdTi6ZsUIAcih1sbvGK+5AEowGCbzXyxQQAJ64ggdcAW3t3oiigbrxuVINDqtgRnwMnTF
 4LhFOdCP/RA/UXDQX3CysvdlrlmEwzYvPF+ZpB9aqHoIlN5zc5UECeVUg7NuNHjFVPrPva7d
 d8b4jqNeAnxc0VaO8DtY0el7knA=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e1eb707.7f0b1c4a9030-smtp-out-n02;
 Wed, 15 Jan 2020 06:53:59 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4A89EC447A1; Wed, 15 Jan 2020 06:53:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 90F2BC433A2;
        Wed, 15 Jan 2020 06:53:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 15 Jan 2020 12:23:57 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] drivers: qcom: rpmh-rsc: Use rcuidle tracepoints for rpmh
In-Reply-To: <20200115013751.249588-1-swboyd@chromium.org>
References: <20200115013751.249588-1-swboyd@chromium.org>
Message-ID: <00798be85df85beff8edcf26767dddc2@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-01-15 07:07, Stephen Boyd wrote:
> This tracepoint is hit now that we call into the rpmh code from the cpu
> idle path. Let's move this to be an rcuidle tracepoint so that we avoid
> the RCU idle splat below
> 
>  =============================
>  WARNING: suspicious RCU usage
>  5.4.10 #68 Tainted: G S
>  -----------------------------
>  drivers/soc/qcom/trace-rpmh.h:72 suspicious rcu_dereference_check() 
> usage!
> 
>  other info that might help us debug this:
> 
>  RCU used illegally from idle CPU!
>  rcu_scheduler_active = 2, debug_locks = 1
>  RCU used illegally from extended quiescent state!
>  5 locks held by swapper/2/0:
>   #0: ffffff81745d6ee8 (&(&genpd->slock)->rlock){+.+.}, at:
> genpd_lock_spin+0x1c/0x2c
>   #1: ffffff81745da6e8 (&(&genpd->slock)->rlock/1){....}, at:
> genpd_lock_nested_spin+0x24/0x34
>   #2: ffffff8174f2ca20 (&(&genpd->slock)->rlock/2){....}, at:
> genpd_lock_nested_spin+0x24/0x34
>   #3: ffffff8174f2c300 (&(&drv->client.cache_lock)->rlock){....}, at:
> rpmh_flush+0x48/0x24c
>   #4: ffffff8174f2c150 (&(&tcs->lock)->rlock){+.+.}, at:
> rpmh_rsc_write_ctrl_data+0x74/0x270
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
> Fixes: a65a397f2451 ("cpuidle: psci: Add support for PM domains by 
> using genpd")
> Reported-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
> 
> I think the commit that this is "Fixes"ing is a stable commit, but I'm
> not positive.
> 
>  drivers/soc/qcom/rpmh-rsc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> index e278fc11fe5c..b71822131f59 100644
> --- a/drivers/soc/qcom/rpmh-rsc.c
> +++ b/drivers/soc/qcom/rpmh-rsc.c
> @@ -277,7 +277,7 @@ static void __tcs_buffer_write(struct rsc_drv
> *drv, int tcs_id, int cmd_id,
>  		write_tcs_cmd(drv, RSC_DRV_CMD_MSGID, tcs_id, j, msgid);
>  		write_tcs_cmd(drv, RSC_DRV_CMD_ADDR, tcs_id, j, cmd->addr);
>  		write_tcs_cmd(drv, RSC_DRV_CMD_DATA, tcs_id, j, cmd->data);
> -		trace_rpmh_send_msg(drv, tcs_id, j, msgid, cmd);
> +		trace_rpmh_send_msg_rcuidle(drv, tcs_id, j, msgid, cmd);
>  	}
> 
>  	write_tcs_reg(drv, RSC_DRV_CMD_WAIT_FOR_CMPL, tcs_id, cmd_complete);

Thanks Stephen,

Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
