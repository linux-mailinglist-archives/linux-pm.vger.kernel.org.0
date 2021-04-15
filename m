Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0950C3608DE
	for <lists+linux-pm@lfdr.de>; Thu, 15 Apr 2021 14:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbhDOMEb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Apr 2021 08:04:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59446 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbhDOME1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Apr 2021 08:04:27 -0400
Date:   Thu, 15 Apr 2021 12:04:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618488244;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EyA9r7gloau9jxs7WHdGpVLJPIeRrimcZBblgtb6kps=;
        b=C9R5FSYXdduUoZBGyXKVUM8qRAJYAI7sWTG0DMIHL/p7Ht0I6DkbDk6AluhntIi0Z2aYxX
        irXFkST7kcKFbNeZH6jTyxWUqN9YpeYsSX8Fn0PHbmpzYP+l4TysxjoDTbYYcKTpZqEAmA
        iduPt258RgPUfasjMo/QvBxSyfBquGtsr8QQq+TRzVoQvtNpNpMcjcMLW2t/D0F5QD2heg
        cclpM5+TvHJ/X3p3wyx++aUGe4cwpY9xPYhEbnSaXGK4IeCor+poItBmoOL30yaf7HUqzw
        5gtXQ+QRU6u5wsQnwTUDfu7q1qu8kYKnW5UWLb8fx9Ur0jb6Np+IF1vWVDvz6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618488244;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EyA9r7gloau9jxs7WHdGpVLJPIeRrimcZBblgtb6kps=;
        b=QkAuLsxJV6kM46doE+e3na3vT/CLYbKhD9hbkg+pXVNS9azwrdLWJ+zzbYlSdUsQDrCXH6
        4HcCLMRtgtAE0fCg==
From:   "thermal-bot for Konrad Dybcio" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/qcom/tsens_v1: Enable sensor
 3 on MSM8976
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210225213119.116550-1-konrad.dybcio@somainline.org>
References: <20210225213119.116550-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Message-ID: <161848824383.29796.4586635689446429556.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     007d81a4519f04fa5ced5e9e28bf70cd753c398d
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//007d81a4519f04fa5ced5e9e28bf70cd753c398d
Author:        Konrad Dybcio <konrad.dybcio@somainline.org>
AuthorDate:    Thu, 25 Feb 2021 22:31:19 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 17 Mar 2021 20:08:30 +01:00

thermal/drivers/qcom/tsens_v1: Enable sensor 3 on MSM8976

The sensor *is* in fact used and does report temperature.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Acked-by: Thara Gopinath <thara.gopinath@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210225213119.116550-1-konrad.dybcio@somainline.org
---
 drivers/thermal/qcom/tsens-v1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
index 3c19a38..573e261 100644
--- a/drivers/thermal/qcom/tsens-v1.c
+++ b/drivers/thermal/qcom/tsens-v1.c
@@ -380,11 +380,11 @@ static const struct tsens_ops ops_8976 = {
 	.get_temp	= get_temp_tsens_valid,
 };
 
-/* Valid for both MSM8956 and MSM8976. Sensor ID 3 is unused. */
+/* Valid for both MSM8956 and MSM8976. */
 struct tsens_plat_data data_8976 = {
 	.num_sensors	= 11,
 	.ops		= &ops_8976,
-	.hw_ids		= (unsigned int[]){0, 1, 2, 4, 5, 6, 7, 8, 9, 10},
+	.hw_ids		= (unsigned int[]){0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10},
 	.feat		= &tsens_v1_feat,
 	.fields		= tsens_v1_regfields,
 };
