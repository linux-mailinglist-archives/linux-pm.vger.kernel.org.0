Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C58D584351
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jul 2022 17:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiG1Plx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jul 2022 11:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbiG1Plw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2022 11:41:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2FE675B7
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 08:41:51 -0700 (PDT)
Date:   Thu, 28 Jul 2022 15:41:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659022909;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TTpZHwAxh3kB1hJsasc4lTwdQ/DPtpmF7LA9z8bpdjQ=;
        b=BQx7cI7Ez+Glv7MpH+cKcxu2lst/y0PokytqnCssRcZV4ZKSbXQAv9FRzi3qjKKB3mQP1c
        /p+ReOjYWnuCr/3R2bJJTO1dFVMXliBLg30JI3/44hByvpr62mxU3EUf1/rNiwhFnDxDug
        qKmjLXuKBWl4Tk3Fy45ELKCSJEVjUBHEfq+KbGN8AWgFqCaYEZ6JMtDApUryvNVeHAiVWi
        NLtpw7JrkhgwGw/VeP83Xgvix7HIIGNxG9XNXonYnW8CXnROUGLQSW5X35L9F+9vg/c695
        xJl02rkzRZ22U1iebot/1VpD5OeJ2Aizf0L4C+L86gwgOSJ3P6sULtJRwadjqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659022909;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TTpZHwAxh3kB1hJsasc4lTwdQ/DPtpmF7LA9z8bpdjQ=;
        b=Rg9eLNMFomYtOx4HB2IRqN7w980M2qn0xaH6d1aJGGNx1ohp2cealQojFn7Pf4RmCXestY
        n7IwnaHcad4AF6DQ==
From:   "thermal-bot for Jin Xiaoyun" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/k3_j72xx_bandgap: Make
 k3_j72xx_bandgap_j721e_data and k3_j72xx_bandgap_j7200_data static
Cc:     Hulk Robot <hulkci@huawei.com>,
        Jin Xiaoyun <jinxiaoyun2@huawei.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220613063111.654893-1-jinxiaoyun2@huawei.com>
References: <20220613063111.654893-1-jinxiaoyun2@huawei.com>
MIME-Version: 1.0
Message-ID: <165902290872.15455.10401267632566847325.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     4aaec53b84418e83fcee6907fcff177df1f12f44
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//4aaec53b84418e83fcee6907fcff177df1f12f44
Author:        Jin Xiaoyun <jinxiaoyun2@huawei.com>
AuthorDate:    Mon, 13 Jun 2022 14:31:11 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 28 Jul 2022 17:29:48 +02:00

thermal/drivers/k3_j72xx_bandgap: Make k3_j72xx_bandgap_j721e_data and k3_j72xx_bandgap_j7200_data static

Fix sparse warnings:

drivers/thermal/k3_j72xx_bandgap.c:532:36: sparse: sparse: symbol 'k3_j72xx_bandgap_j721e_data' was not declared. Should it be static?
drivers/thermal/k3_j72xx_bandgap.c:536:36: sparse: sparse: symbol 'k3_j72xx_bandgap_j7200_data' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jin Xiaoyun <jinxiaoyun2@huawei.com>
Link: https://lore.kernel.org/r/20220613063111.654893-1-jinxiaoyun2@huawei.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/k3_j72xx_bandgap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
index 27d4cae..115a44e 100644
--- a/drivers/thermal/k3_j72xx_bandgap.c
+++ b/drivers/thermal/k3_j72xx_bandgap.c
@@ -530,11 +530,11 @@ static int k3_j72xx_bandgap_remove(struct platform_device *pdev)
 	return 0;
 }
 
-const struct k3_j72xx_bandgap_data k3_j72xx_bandgap_j721e_data = {
+static const struct k3_j72xx_bandgap_data k3_j72xx_bandgap_j721e_data = {
 	.has_errata_i2128 = 1,
 };
 
-const struct k3_j72xx_bandgap_data k3_j72xx_bandgap_j7200_data = {
+static const struct k3_j72xx_bandgap_data k3_j72xx_bandgap_j7200_data = {
 	.has_errata_i2128 = 0,
 };
 
