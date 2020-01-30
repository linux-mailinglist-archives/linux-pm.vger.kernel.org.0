Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6143114D507
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2020 02:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbgA3Blg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jan 2020 20:41:36 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46069 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgA3Blg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jan 2020 20:41:36 -0500
Received: by mail-ot1-f66.google.com with SMTP id 59so1579333otp.12;
        Wed, 29 Jan 2020 17:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2P8mIQM2+gpGwwpWHO7MIWsL+16CozNLtmz3AeK6KJA=;
        b=sh4KnuZPnRoQwLcdY0e21qeGh/RWA9KkP9Xk6BJa9lr+DwN0U5HxoXsVrMTKefUF2z
         xwCqC9eiI+Qy/ZyiVxzhWNmb1faaD9Xpv+8eUaRcq1F3y+CmuIpE/RT4Tzv70wMzTY/4
         4H3m1olAIjuotpPfb0MQyMYNnFPO8bhpxH0rIJPZV1J3od0WRmrIJj9hvo+R6wfP4FHS
         y5hqf0Ty2PyndwVfeQkzHspDrb9II6JQj/IrNY+gDfHDSiq7T1pWwBe/+yqWcN2KKQSp
         dkspeeCwD9+l/kO0PffVUSyHijvVdI8lsEV/dGHJu49spPpLVWzwehLRfREsvZuNa97e
         7aAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2P8mIQM2+gpGwwpWHO7MIWsL+16CozNLtmz3AeK6KJA=;
        b=V2Tqqnd8qGZC0+cNER460B7wi8zq+03LgnQappyhSjTvBuDjI+crbn4LMdC5QNTJHM
         95wIEQLo1MgJy3iz9GQQU/K6k5un9aYOnl7iLWesFDm4DGUmRJwhZVxYLdzNKKyZS/k/
         D0ePb+iaID6GP9PS71Iuy3FNtvGmixzkJESbtC+a4uH2n8a0LfTxfrAqYAlCAE+YUoGv
         nCBuoeSj58NcgTZSybqOTkXDjrONYRR+vr3pSA2IEcr+axK247A0V7q4CaVT+cvYANln
         aE7GY9Aec9B5n8QePqhNZAeqYBhtJ+leAY09LjdxXvIZ132gR/OPktkC5t0YjAomdtis
         a3TA==
X-Gm-Message-State: APjAAAVbYSwkZR3B/IEx7Z16oQmltiw+fKSE+evtYbdACYhH9Jg7oPN+
        eEcU4juny069OU4tAcipOSE=
X-Google-Smtp-Source: APXvYqwx8XNMC2oG239rd8MwmWT71BEAXssFRVi4DTH6NF10X2y0cEiI33G9V1m33fi6InTuE/2zRw==
X-Received: by 2002:a9d:8f1:: with SMTP id 104mr1637192otf.107.1580348495040;
        Wed, 29 Jan 2020 17:41:35 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id j45sm1313526ota.59.2020.01.29.17.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 17:41:33 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] power: avs: qcom-cpr: Avoid clang -Wsometimes-uninitialized in cpr_scale
Date:   Wed, 29 Jan 2020 18:41:30 -0700
Message-Id: <20200130014130.51313-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Clang warns (trimmed for brevity):

../drivers/power/avs/qcom-cpr.c:570:13: warning: variable 'reg_mask' is
used uninitialized whenever 'if' condition is false
[-Wsometimes-uninitialized]

../drivers/power/avs/qcom-cpr.c:520:13: warning: variable 'new_uV' is
used uninitialized whenever 'if' condition is false
[-Wsometimes-uninitialized]

Due to the fact that Clang's static analysis happens before any
optimization passes are taken into account, it cannot see that both
branches in the if statement must be taken because dir cannot be
something other than UP or DOWN due to the check at the top of this
function. Change the else if condition to else to fix this false
positive.

Fixes: bf6910abf548 ("power: avs: Add support for CPR (Core Power Reduction)")
Link: https://github.com/ClangBuiltLinux/linux/issues/840
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/power/avs/qcom-cpr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/avs/qcom-cpr.c b/drivers/power/avs/qcom-cpr.c
index 9192fb747653..e8831e4aee05 100644
--- a/drivers/power/avs/qcom-cpr.c
+++ b/drivers/power/avs/qcom-cpr.c
@@ -517,7 +517,7 @@ static int cpr_scale(struct cpr_drv *drv, enum voltage_change_dir dir)
 		dev_dbg(drv->dev,
 			"UP: -> new_uV: %d last_uV: %d perf state: %u\n",
 			new_uV, last_uV, cpr_get_cur_perf_state(drv));
-	} else if (dir == DOWN) {
+	} else {
 		if (desc->clamp_timer_interval &&
 		    error_steps < desc->down_threshold) {
 			/*
@@ -567,7 +567,7 @@ static int cpr_scale(struct cpr_drv *drv, enum voltage_change_dir dir)
 		/* Disable auto nack down */
 		reg_mask = RBCPR_CTL_SW_AUTO_CONT_NACK_DN_EN;
 		val = 0;
-	} else if (dir == DOWN) {
+	} else {
 		/* Restore default threshold for UP */
 		reg_mask = RBCPR_CTL_UP_THRESHOLD_MASK;
 		reg_mask <<= RBCPR_CTL_UP_THRESHOLD_SHIFT;
-- 
2.25.0

