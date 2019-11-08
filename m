Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1B50F5BEC
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2019 00:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbfKHXlC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Nov 2019 18:41:02 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:38900 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728633AbfKHXlB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Nov 2019 18:41:01 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 02E2C6146C; Fri,  8 Nov 2019 23:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573256461;
        bh=ce7uFrqbivkUs8WW1oFPj3rAOkE1bz0MfUfo7m78NUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TlrX1J4Io/NfsnQ/fwZH8ZCiSS1dxeuPN+jMehL6DyMdNyqOlXkvZM7xuaeCmatJc
         UOIV/YCvEWCRnZ2lBekZPBPgdPQak8dP2xPHsSADE8floF00Z6GO/Q+j/2z2EojL3r
         fwq2nPBiqVbH8BvGdGXnkmlf/BCZezIHy4BFljIY=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F3DB06141A;
        Fri,  8 Nov 2019 23:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573256460;
        bh=ce7uFrqbivkUs8WW1oFPj3rAOkE1bz0MfUfo7m78NUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TXyjitDQr7w1mD0USB2kSrEWv900ff6wRrfzT04f+VnTZIOpzu45d0zTfnxHks3GH
         uR/fQgAkn4VOnZA7LLd02nvmv1gbnJCC15U/a6/rDupHRupP4T93sMu82Z3Qwgvk6G
         LIZpkrZ7XwOblELLWjM3HkB3lLtscoGrdW7lDUYo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F3DB06141A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=eberman@codeaurora.org
From:   Elliot Berman <eberman@codeaurora.org>
To:     sre@kernel.org, tkjos@google.com, gregkh@linuxfoundation.org
Cc:     tsoni@codeaurora.org, rananta@codeaurora.org,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Elliot Berman <eberman@codeaurora.org>
Subject: [PATCH v2 2/2] power: reset: Enable tristate on restart power-off driver
Date:   Fri,  8 Nov 2019 15:40:52 -0800
Message-Id: <1573256452-14838-3-git-send-email-eberman@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573256452-14838-1-git-send-email-eberman@codeaurora.org>
References: <1573256452-14838-1-git-send-email-eberman@codeaurora.org>
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

