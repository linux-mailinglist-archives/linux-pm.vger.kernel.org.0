Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC762F57A1
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2019 21:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732131AbfKHTc1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Nov 2019 14:32:27 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:55702 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731825AbfKHTc0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Nov 2019 14:32:26 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B2B286128C; Fri,  8 Nov 2019 19:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573241545;
        bh=3DCd1rdLCFOhl/vl+cJRz+MG4RyUG5d3Ipp22QOCRcs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JMsblRVQ9sA9/EUzFNS9U6ceR8NZ/nD81sOkDsiiJD/qChzUptWwSMv0g0cFQv11U
         I2tlI3j05ruqqqUUBO3IZ92EHcA5eDpO94P5Ya3bOwlSpsqsv5So1mlw4tlolob+Gu
         vmkUtKgqVJaQ3ic6ttheaYRf/Lv9fLvQ8E0bhjrU=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B1C64611FA;
        Fri,  8 Nov 2019 19:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573241545;
        bh=3DCd1rdLCFOhl/vl+cJRz+MG4RyUG5d3Ipp22QOCRcs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JMsblRVQ9sA9/EUzFNS9U6ceR8NZ/nD81sOkDsiiJD/qChzUptWwSMv0g0cFQv11U
         I2tlI3j05ruqqqUUBO3IZ92EHcA5eDpO94P5Ya3bOwlSpsqsv5So1mlw4tlolob+Gu
         vmkUtKgqVJaQ3ic6ttheaYRf/Lv9fLvQ8E0bhjrU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B1C64611FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=eberman@codeaurora.org
From:   Elliot Berman <eberman@codeaurora.org>
To:     sre@kernel.org, tkjos@google.com
Cc:     tsoni@codeaurora.org, rananta@codeaurora.org,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Elliot Berman <eberman@codeaurora.org>
Subject: [PATCH 1/2] reboot: Export reboot_mode
Date:   Fri,  8 Nov 2019 11:32:11 -0800
Message-Id: <1573241532-21554-2-git-send-email-eberman@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573241532-21554-1-git-send-email-eberman@codeaurora.org>
References: <1573241532-21554-1-git-send-email-eberman@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Export reboot_mode to support DLKMs wishing to modify reboot_mode.

Signed-off-by: Elliot Berman <eberman@codeaurora.org>
---
 kernel/reboot.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index c4d472b..6518370 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -32,7 +32,9 @@ EXPORT_SYMBOL(cad_pid);
 #define DEFAULT_REBOOT_MODE
 #endif
 enum reboot_mode reboot_mode DEFAULT_REBOOT_MODE;
+EXPORT_SYMBOL(reboot_mode);
 enum reboot_mode panic_reboot_mode = REBOOT_UNDEFINED;
+EXPORT_SYMBOL(panic_reboot_mode);
 
 /*
  * This variable is used privately to keep track of whether or not
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

