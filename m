Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62143F57A2
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2019 21:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732104AbfKHTc1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Nov 2019 14:32:27 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:55728 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732084AbfKHTc0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Nov 2019 14:32:26 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 02AD4612C1; Fri,  8 Nov 2019 19:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573241546;
        bh=ce7uFrqbivkUs8WW1oFPj3rAOkE1bz0MfUfo7m78NUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=exIRuS/SV5H1O3xegtrJnLzmdfMVQ619R2HM57Z/17MP8/SSMk0L9/8wEyQ1qD4/q
         MDjixt7pTddbJMXA3wDlynWB822JmpptaGHuFppBniFKxvk8Wk10IhVMlamQL3dof5
         Zu9nj+f/ytr3G82a3xhB4psdqY5vufp3dXiPcLUg=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from eberman-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: eberman@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3AD7B60D5C;
        Fri,  8 Nov 2019 19:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573241545;
        bh=ce7uFrqbivkUs8WW1oFPj3rAOkE1bz0MfUfo7m78NUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ha96SRlVptgcdnknaIhbpibTWOhAo7YYjB39ACciA8Ak3Tel0AgVR7NBfh+/R9/od
         jUjwJLjoLjylvQQkmBz1mYl40WVmkMmNheGBUd6aMzRBUDyTvfn2mrFJDtPPKvgh4e
         lY8se4hy/FwNFQu/ZXAGLCjEwVdhy51NM+NLW8C8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3AD7B60D5C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=eberman@codeaurora.org
From:   Elliot Berman <eberman@codeaurora.org>
To:     sre@kernel.org, tkjos@google.com
Cc:     tsoni@codeaurora.org, rananta@codeaurora.org,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Elliot Berman <eberman@codeaurora.org>
Subject: [PATCH 2/2] power: reset: Enable tristate on restart power-off driver
Date:   Fri,  8 Nov 2019 11:32:12 -0800
Message-Id: <1573241532-21554-3-git-send-email-eberman@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573241532-21554-1-git-send-email-eberman@codeaurora.org>
References: <1573241532-21554-1-git-send-email-eberman@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since reboot_mode is an exported symbol, restart power-off driver can be
compiled as module.

Signed-off-by: Elliot Berman <eberman@codeaurora.org>
---
 drivers/power/reset/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index a564237..8db1d9d 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -150,7 +150,7 @@ config POWER_RESET_QNAP
 	  Say Y if you have a QNAP NAS.
 
 config POWER_RESET_RESTART
-	bool "Restart power-off driver"
+	tristate "Restart power-off driver"
 	help
 	  Some boards don't actually have the ability to power off.
 	  Instead they restart, and u-boot holds the SoC until the
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

