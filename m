Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664BB3608C8
	for <lists+linux-pm@lfdr.de>; Thu, 15 Apr 2021 14:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbhDOMEY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Apr 2021 08:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbhDOMEX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Apr 2021 08:04:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2898BC061761
        for <linux-pm@vger.kernel.org>; Thu, 15 Apr 2021 05:04:00 -0700 (PDT)
Date:   Thu, 15 Apr 2021 12:03:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618488237;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UnAM0l0ccn3vp02JttG0idveXMP9yz/enayw7IaY6lg=;
        b=XcVImZX+ef5qq2ydE7ii4qkonUYfA3/JAaLzjMhYgmNEnoHDMFvqVStO1rr5crDR4MlOlS
        lNTZx1CfNtNXUMQ7LKgWUNar646dMQU04jLt+pOwu0fDAZhchTTnFF1xYj6jud4nBxSzAp
        Gg/N9U2zkyVFGVuIwJkfpu4qHLZlJ7ga4VPHoaq08uAhvrjrxQg2FeUwsfN+7v0ZbxG6m8
        NkykMg/OhxxWlP1qmOHZbzfAVEeteJBkKSu796+AvXONN13uB23p2okpzTgh2A+NHTOd00
        6RQtdJk+KII5IwkebaK3FF9lYr6AdN3/Aus/kYx8GMy3a8KAFs2qObAEg+CCJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618488237;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UnAM0l0ccn3vp02JttG0idveXMP9yz/enayw7IaY6lg=;
        b=GwTIxWoT7Nhb+GAK993wLUTVi1m0O4h8T86gB963XD6PTiyf+Hwio1ExJNtBcTw92gxdml
        QhhXdPd/hHFMqgDw==
From:   "thermal-bot for Ansuel Smith" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/tsens: Add support for ipq8064-tsens
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210404144823.31867-9-ansuelsmth@gmail.com>
References: <20210404144823.31867-9-ansuelsmth@gmail.com>
MIME-Version: 1.0
Message-ID: <161848823675.29796.15733072604504065193.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     0960379da3629895a96cea0decae412fa570fea8
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//0960379da3629895a96cea0decae412fa570fea8
Author:        Ansuel Smith <ansuelsmth@gmail.com>
AuthorDate:    Sun, 04 Apr 2021 16:48:22 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 15 Apr 2021 13:21:43 +02:00

thermal/drivers/tsens: Add support for ipq8064-tsens

Add support for tsens present in ipq806x SoCs based on generic msm8960
tsens driver.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210404144823.31867-9-ansuelsmth@gmail.com
---
 drivers/thermal/qcom/tsens.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 54382c6..139e580 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -968,6 +968,9 @@ static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
 
 static const struct of_device_id tsens_table[] = {
 	{
+		.compatible = "qcom,ipq8064-tsens",
+		.data = &data_8960,
+	}, {
 		.compatible = "qcom,msm8916-tsens",
 		.data = &data_8916,
 	}, {
