Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED4236CBE1
	for <lists+linux-pm@lfdr.de>; Tue, 27 Apr 2021 21:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238938AbhD0TpM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Apr 2021 15:45:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43146 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238917AbhD0TpL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Apr 2021 15:45:11 -0400
Date:   Tue, 27 Apr 2021 19:44:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619552666;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fYJbqVm154M4wRRddc9WhP90qDZP6522B1CRQOzWhVg=;
        b=jUJ/kMBs2TmDtofrx1qXU26Q7fqUouFfkNFgQyM5SZq9WdXiqigDjsTjKMdqRIuuyCJK+P
        MYiOjbF1ezbrPZLsPWbAC0HXOu4zrjHnahgO9baUftHJialVY8N86J2gloG3ukM4LdxRem
        9g8DKitTGaACMhUI7O2Rc7JsbXDbdxReTjftWjR8EM4OWw7s5hOv8xMTMP+0uGsSO4uerB
        4JhHcsQCfgEx+wEaEZZGiF+SZv3mP/nk2cIc6Wy6Jo0ToOGghsFIbO4zIQ4FkV9cCA+TMR
        pQfA+Tcm2FYs/DMGbW9Cur62Mpln3uWQYlR7wIF70w0uUBQU7U/QLUmZdBFjHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619552666;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fYJbqVm154M4wRRddc9WhP90qDZP6522B1CRQOzWhVg=;
        b=Z7qZc5eDLLWTqUVhwZefkO7n57is3nbQWhmzUL7+0PoqAMQG1afou6D7SoIArNZkUsrjc+
        OHiKbLtv6Oi671BQ==
From:   "thermal-bot for Ansuel Smith" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/tsens: Add support for ipq8064-tsens
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210420183343.2272-9-ansuelsmth@gmail.com>
References: <20210420183343.2272-9-ansuelsmth@gmail.com>
MIME-Version: 1.0
Message-ID: <161955266600.29796.7426770607445648491.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     6b3aeafbc12c18036809108e301efe8056249233
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//6b3aeafbc12c18036809108e301efe8056249233
Author:        Ansuel Smith <ansuelsmth@gmail.com>
AuthorDate:    Tue, 20 Apr 2021 20:33:42 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 22 Apr 2021 14:10:17 +02:00

thermal/drivers/tsens: Add support for ipq8064-tsens

Add support for tsens present in ipq806x SoCs based on generic msm8960
tsens driver.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210420183343.2272-9-ansuelsmth@gmail.com
---
 drivers/thermal/qcom/tsens.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 83e01cb..4c7ebd1 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -968,6 +968,9 @@ static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
 
 static const struct of_device_id tsens_table[] = {
 	{
+		.compatible = "qcom,ipq8064-tsens",
+		.data = &data_8960,
+	}, {
 		.compatible = "qcom,mdm9607-tsens",
 		.data = &data_9607,
 	}, {
