Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 470C9EB6E8
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 19:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbfJaS27 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Oct 2019 14:28:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33664 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfJaS27 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Oct 2019 14:28:59 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A323A60B10; Thu, 31 Oct 2019 18:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572546538;
        bh=H2Iz/pUnQMf04bxJGH12r7cX3YO7brMgUFKejUjQM1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ks8JAuSYi1huOoPvddManF0RgPajJThPTbqNIc1Fl5V+fjV2V/XxThvza//5KxOKs
         Fl0cZiwgnXNW3/5RLwWPLP8g+dVbGdasxaJ1X6vHuak8ByeICBxaBD1vAuiNA/cpEN
         Ox3Hj/j/mhX/JL4hrB7F1u/uSowzKCzMpx+Hg/Ow=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E5F8C60913;
        Thu, 31 Oct 2019 18:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572546538;
        bh=H2Iz/pUnQMf04bxJGH12r7cX3YO7brMgUFKejUjQM1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ks8JAuSYi1huOoPvddManF0RgPajJThPTbqNIc1Fl5V+fjV2V/XxThvza//5KxOKs
         Fl0cZiwgnXNW3/5RLwWPLP8g+dVbGdasxaJ1X6vHuak8ByeICBxaBD1vAuiNA/cpEN
         Ox3Hj/j/mhX/JL4hrB7F1u/uSowzKCzMpx+Hg/Ow=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E5F8C60913
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v1 2/2] interconnect: Remove unused module exit code from core
Date:   Thu, 31 Oct 2019 12:28:52 -0600
Message-Id: <1572546532-19248-3-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572546532-19248-1-git-send-email-jcrouse@codeaurora.org>
References: <1572546532-19248-1-git-send-email-jcrouse@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The interconnect core is currently always built in:

 menuconfig INTERCONNECT
	bool "On-Chip Interconnect management support"

So remove the module_exit function and symbolically rename module_init
to device_initcall to drive home the point.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/interconnect/core.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index c498796..61aba50 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -805,12 +805,7 @@ static int __init icc_init(void)
 	return 0;
 }
 
-static void __exit icc_exit(void)
-{
-	debugfs_remove_recursive(icc_debugfs_dir);
-}
-module_init(icc_init);
-module_exit(icc_exit);
+device_initcall(icc_init);
 
 MODULE_AUTHOR("Georgi Djakov <georgi.djakov@linaro.org>");
 MODULE_DESCRIPTION("Interconnect Driver Core");
-- 
2.7.4

