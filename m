Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CD752D2C1
	for <lists+linux-pm@lfdr.de>; Thu, 19 May 2022 14:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237995AbiESMoP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 May 2022 08:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237998AbiESMoL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2022 08:44:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAEFBA994
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 05:44:10 -0700 (PDT)
Date:   Thu, 19 May 2022 12:44:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652964249;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nxH/Ys7FlzkfPW7QN//IqJJdCj1MywjXCpsqJmtf0yM=;
        b=uiDtJkwqACx0RXLYZbr2UsXiGAZfvb6rn4iocvn6IT3gSkdMT4VGf+8vXmtZVi1V5nyjt1
        wycyOtPtHLOmZkv+wtd5p5J+Tznhdd1r/qPrdGdbjtVsG1gbd8pD3zH6M34rn98MykU+kX
        JIXJtsD0zpLXlZWC+XwHerw/WTTcDHQGPPpFse6bA/UOC6jZScpSHTCCDkbi0oC9s/UPar
        olGtKIKtvxyTvfNpZ2hTtU32vWbcf6hivyAAJu30qZjvka2pnj5rRDXPaY0t3/FnORC1ws
        OEnQjnoTu+s8ru5xurT1MaOU10aq/F+3ImKZB0uYcs7ko2nE1oB8v9Cawmwq3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652964249;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nxH/Ys7FlzkfPW7QN//IqJJdCj1MywjXCpsqJmtf0yM=;
        b=e/ql2E3oIG89emA5kfxsCwosS/WNXJxvvw+PbdHDjXOU64O098p4q4Nl00kAGRbHxvbsw9
        qzPo4nFizIQiF/Dw==
From:   "thermal-bot for Bjorn Andersson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/qcom/lmh: Add sc8180x compatible
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220502164504.3972938-1-bjorn.andersson@linaro.org>
References: <20220502164504.3972938-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Message-ID: <165296424840.4207.3726485083920890286.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     ef6673e8363a61ef941bae05c7913a32a104e20b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//ef6673e8363a61ef941bae05c7913a32a104e20b
Author:        Bjorn Andersson <bjorn.andersson@linaro.org>
AuthorDate:    Mon, 02 May 2022 09:45:03 -07:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 19 May 2022 12:11:52 +02:00

thermal/drivers/qcom/lmh: Add sc8180x compatible

The LMh instances in the Qualcomm SC8180X platform looks to behave
similar to those in SM8150, add additional compatibles to allow
platform specific behavior to be added if needed.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Link: https://lore.kernel.org/r/20220502164504.3972938-1-bjorn.andersson@linaro.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/qcom/lmh.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
index c7f91cb..d3d9b9f 100644
--- a/drivers/thermal/qcom/lmh.c
+++ b/drivers/thermal/qcom/lmh.c
@@ -220,6 +220,7 @@ static int lmh_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id lmh_table[] = {
+	{ .compatible = "qcom,sc8180x-lmh", },
 	{ .compatible = "qcom,sdm845-lmh", .data = (void *)LMH_ENABLE_ALGOS},
 	{ .compatible = "qcom,sm8150-lmh", },
 	{}
