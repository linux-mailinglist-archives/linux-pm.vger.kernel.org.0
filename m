Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1C713B70D
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2020 02:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbgAOBhx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jan 2020 20:37:53 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33536 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728848AbgAOBhx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jan 2020 20:37:53 -0500
Received: by mail-pl1-f195.google.com with SMTP id ay11so6068903plb.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Jan 2020 17:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zdsjxjvH/tUzmnwmoZCV321rPDTpQdI6rQfaTbsVcek=;
        b=QtF3py1rm3eu6XA5nji+v+VyJkcjLjIc3YXtcyDs5jPzHYtKdo+D4Ih/7ihMTj17pA
         ByVQfA4PTcgJVCJAg6UrUwuzDis4Ls9IjBJF/FTJyZQpAsyFwAAjPtz+NME9DIVzStb5
         b1Vr3ZrPcqLk2YVpSdY91aK8x+hpToNe5mfhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zdsjxjvH/tUzmnwmoZCV321rPDTpQdI6rQfaTbsVcek=;
        b=U0Zik/Ns369ngT7U0eE3Z9qtzse7Rt+D/VIUtq4cxkis10h/qojj/GmkeEoO9GTsfi
         xNaITlaOHHIRPBNXix7HtDyhy5YATFNQsvbpGw37XALnIFTIhIsNdL23pZDrw++yS8oJ
         AxhiL7wJZp8gmJOLf4Ifod/NHCJyeAD2vS7WFbUYcMd0zY1rqY4I2uSzu2g4jJDOy2Dp
         6hcMLv/Pyo33/UjWpiqifV9MYcB8xsFfcs0YtsCsXqmiWGsbnD6kODgbbsfUiPhvXQMV
         lME3RYz9Lvp3/2RM3Ss00SNH0QggD6DCDaDSvBBEWyD7J2seeV0dwqPtkzxJCnmkC+Q9
         go4Q==
X-Gm-Message-State: APjAAAUxzf6M+GHD27p72nJvD8wNmSAnF/qgygkfQSyyb7vyZDmB0BDy
        w/mDtjIyGr1AnKvXbxtBYBXLoA==
X-Google-Smtp-Source: APXvYqz28WpmXl65RH3fAV23Fy7l4mAowqzKZ18QFkXC1WuOSJjgmtIlb3J9Cy51syq+QYmwbMGRLQ==
X-Received: by 2002:a17:902:b087:: with SMTP id p7mr30291576plr.10.1579052272503;
        Tue, 14 Jan 2020 17:37:52 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id y76sm19949275pfc.87.2020.01.14.17.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 17:37:52 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] drivers: qcom: rpmh-rsc: Use rcuidle tracepoints for rpmh
Date:   Tue, 14 Jan 2020 17:37:51 -0800
Message-Id: <20200115013751.249588-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This tracepoint is hit now that we call into the rpmh code from the cpu
idle path. Let's move this to be an rcuidle tracepoint so that we avoid
the RCU idle splat below

 =============================
 WARNING: suspicious RCU usage
 5.4.10 #68 Tainted: G S
 -----------------------------
 drivers/soc/qcom/trace-rpmh.h:72 suspicious rcu_dereference_check() usage!

 other info that might help us debug this:

 RCU used illegally from idle CPU!
 rcu_scheduler_active = 2, debug_locks = 1
 RCU used illegally from extended quiescent state!
 5 locks held by swapper/2/0:
  #0: ffffff81745d6ee8 (&(&genpd->slock)->rlock){+.+.}, at: genpd_lock_spin+0x1c/0x2c
  #1: ffffff81745da6e8 (&(&genpd->slock)->rlock/1){....}, at: genpd_lock_nested_spin+0x24/0x34
  #2: ffffff8174f2ca20 (&(&genpd->slock)->rlock/2){....}, at: genpd_lock_nested_spin+0x24/0x34
  #3: ffffff8174f2c300 (&(&drv->client.cache_lock)->rlock){....}, at: rpmh_flush+0x48/0x24c
  #4: ffffff8174f2c150 (&(&tcs->lock)->rlock){+.+.}, at: rpmh_rsc_write_ctrl_data+0x74/0x270

 stack backtrace:
 CPU: 2 PID: 0 Comm: swapper/2 Tainted: G S                5.4.10 #68
 Call trace:
  dump_backtrace+0x0/0x174
  show_stack+0x20/0x2c
  dump_stack+0xc8/0x124
  lockdep_rcu_suspicious+0xe4/0x104
  __tcs_buffer_write+0x230/0x2d0
  rpmh_rsc_write_ctrl_data+0x210/0x270
  rpmh_flush+0x84/0x24c
  rpmh_domain_power_off+0x78/0x98
  _genpd_power_off+0x40/0xc0
  genpd_power_off+0x168/0x208
  genpd_power_off+0x1e0/0x208
  genpd_power_off+0x1e0/0x208
  genpd_runtime_suspend+0x1ac/0x220
  __rpm_callback+0x70/0xfc
  rpm_callback+0x34/0x8c
  rpm_suspend+0x218/0x4a4
  __pm_runtime_suspend+0x88/0xac
  psci_enter_domain_idle_state+0x3c/0xb4
  cpuidle_enter_state+0xb8/0x284
  cpuidle_enter+0x38/0x4c
  call_cpuidle+0x3c/0x68
  do_idle+0x194/0x260
  cpu_startup_entry+0x24/0x28
  secondary_start_kernel+0x150/0x15c

Fixes: a65a397f2451 ("cpuidle: psci: Add support for PM domains by using genpd")
Reported-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

I think the commit that this is "Fixes"ing is a stable commit, but I'm
not positive.

 drivers/soc/qcom/rpmh-rsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index e278fc11fe5c..b71822131f59 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -277,7 +277,7 @@ static void __tcs_buffer_write(struct rsc_drv *drv, int tcs_id, int cmd_id,
 		write_tcs_cmd(drv, RSC_DRV_CMD_MSGID, tcs_id, j, msgid);
 		write_tcs_cmd(drv, RSC_DRV_CMD_ADDR, tcs_id, j, cmd->addr);
 		write_tcs_cmd(drv, RSC_DRV_CMD_DATA, tcs_id, j, cmd->data);
-		trace_rpmh_send_msg(drv, tcs_id, j, msgid, cmd);
+		trace_rpmh_send_msg_rcuidle(drv, tcs_id, j, msgid, cmd);
 	}
 
 	write_tcs_reg(drv, RSC_DRV_CMD_WAIT_FOR_CMPL, tcs_id, cmd_complete);
-- 
Sent by a computer, using git, on the internet

