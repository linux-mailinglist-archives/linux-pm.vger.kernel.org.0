Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686D1316C75
	for <lists+linux-pm@lfdr.de>; Wed, 10 Feb 2021 18:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbhBJRV5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Feb 2021 12:21:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:43590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232097AbhBJRV4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Feb 2021 12:21:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5E8764EC7;
        Wed, 10 Feb 2021 17:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612977677;
        bh=3XsRZ7GaXx8P2kZhXGx8Nf98E9I8mJO0HBDDnM97tTI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=fVMn/+wSlxJDfg8IIIAwSZ3aB/5/73hoMqc177Y6KIUTjK2aEvxqKbxFm1g8yxstH
         SFfvtWT0YCA8iOxmhdBh4ZbbNexcYtiUx5KHG8sq5niB0nfC03/TZD9UCtU49bd7Xa
         2PWr+uCLshusoY43a99IIflIONLDO9NoAvPN1rAS3ky9rPIfZniAZePooEuE4BzZ/j
         pP5eCNNr/s5yCqECttj1H8tIjLE+WAnq7GlvTo2bGNHiTT4YTk4AHQIVHz7gbtwCe+
         b+/OdeWdPdEyklKJXnYa5CJmPWkQsSZpoG2GiNr27Jfkj7SuCcmBsELRTagiYX6mu5
         l3kwv2NzKSL/A==
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 3/3] power: supply: s3c_adc_battery: remove unused pdata in suspend/resume
Date:   Wed, 10 Feb 2021 18:21:08 +0100
Message-Id: <20210210172108.334896-3-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210210172108.334896-1-krzk@kernel.org>
References: <20210210172108.334896-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The "pdata" local variable is not used in suspend/resume handlers since
commit 7776bcd241e0 ("power: supply: s3c-adc-battery: Convert to GPIO
descriptors"):

    drivers/power/supply/s3c_adc_battery.c: In function ‘s3c_adc_bat_suspend’:
    drivers/power/supply/s3c_adc_battery.c:405:28: warning: unused variable ‘pdata’ [-Wunused-variable]

    drivers/power/supply/s3c_adc_battery.c: In function ‘s3c_adc_bat_resume’:
    drivers/power/supply/s3c_adc_battery.c:422:28: warning: unused variable ‘pdata’ [-Wunused-variable]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/power/supply/s3c_adc_battery.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/power/supply/s3c_adc_battery.c b/drivers/power/supply/s3c_adc_battery.c
index de98aea53a24..dc700066d7bc 100644
--- a/drivers/power/supply/s3c_adc_battery.c
+++ b/drivers/power/supply/s3c_adc_battery.c
@@ -402,8 +402,6 @@ static int s3c_adc_bat_remove(struct platform_device *pdev)
 static int s3c_adc_bat_suspend(struct platform_device *pdev,
 	pm_message_t state)
 {
-	struct s3c_adc_bat_pdata *pdata = pdev->dev.platform_data;
-
 	if (main_bat.charge_finished) {
 		if (device_may_wakeup(&pdev->dev))
 			enable_irq_wake(
@@ -419,8 +417,6 @@ static int s3c_adc_bat_suspend(struct platform_device *pdev,
 
 static int s3c_adc_bat_resume(struct platform_device *pdev)
 {
-	struct s3c_adc_bat_pdata *pdata = pdev->dev.platform_data;
-
 	if (main_bat.charge_finished) {
 		if (device_may_wakeup(&pdev->dev))
 			disable_irq_wake(
-- 
2.25.1

