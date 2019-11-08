Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99BEEF5BEE
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2019 00:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfKHXlH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Nov 2019 18:41:07 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:38790 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbfKHXlA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Nov 2019 18:41:00 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2C0B661431; Fri,  8 Nov 2019 23:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573256460;
        bh=Tx7ydNVYcAhAUVVQSsDerUIhj463VOZnpzpEyLdGsVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i+fuSzJFebMPm442ya5GwFywLAyNOhqg2k5btAgRG9EwasCOnvjkboj8fNC8jyiI2
         1/zMvXje32tW5KSCArq/KRMnQxXjmkZWLjP8HGBNYnMp8c13z5RbFMyNwJrYV0runx
         l+mWbWxrq3nRImNGwtdMJdqtj3DLMaF8nlcQCXck=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6E25C613EB;
        Fri,  8 Nov 2019 23:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573256459;
        bh=Tx7ydNVYcAhAUVVQSsDerUIhj463VOZnpzpEyLdGsVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a8Rxa7sfmGjnRpjLIRwpcFozdHJjcMVWssJYkU2QaxWJ+i/FZwg3Dn1HCrDpWltOM
         5q+k5A4+iHTSWz+cCh5eCyvyYlu5iE2evQd9uqyb0PAs69az9KB5ufy86KynC+XdiU
         5PIt0Brdji3Z09RWo+7hg/g1/Yjj/06/TCFCwMIc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6E25C613EB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=eberman@codeaurora.org
From:   Elliot Berman <eberman@codeaurora.org>
To:     sre@kernel.org, tkjos@google.com, gregkh@linuxfoundation.org
Cc:     tsoni@codeaurora.org, rananta@codeaurora.org,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Elliot Berman <eberman@codeaurora.org>
Subject: [PATCH v2 1/2] reboot: Export reboot_mode
Date:   Fri,  8 Nov 2019 15:40:51 -0800
Message-Id: <1573256452-14838-2-git-send-email-eberman@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573256452-14838-1-git-send-email-eberman@codeaurora.org>
References: <1573256452-14838-1-git-send-email-eberman@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Export reboot_mode to support kernel modules wishing to modify reboot_mode.

Signed-off-by: Elliot Berman <eberman@codeaurora.org>
---
 kernel/reboot.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index c4d472b..b1fbc22 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -32,7 +32,9 @@ EXPORT_SYMBOL(cad_pid);
 #define DEFAULT_REBOOT_MODE
 #endif
 enum reboot_mode reboot_mode DEFAULT_REBOOT_MODE;
+EXPORT_SYMBOL_GPL(reboot_mode);
 enum reboot_mode panic_reboot_mode = REBOOT_UNDEFINED;
+EXPORT_SYMBOL_GPL(panic_reboot_mode);
 
 /*
  * This variable is used privately to keep track of whether or not
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

