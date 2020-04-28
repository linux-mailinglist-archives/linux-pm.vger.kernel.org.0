Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F7E1BB732
	for <lists+linux-pm@lfdr.de>; Tue, 28 Apr 2020 09:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgD1HFT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Apr 2020 03:05:19 -0400
Received: from imap3.hz.codethink.co.uk ([176.9.8.87]:52240 "EHLO
        imap3.hz.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgD1HFT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Apr 2020 03:05:19 -0400
Received: from [80.225.8.234] (helo=aijekuh.aijekuh)
        by imap3.hz.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1jTKIu-0001Bp-QS; Tue, 28 Apr 2020 08:05:17 +0100
From:   Kejia Hu <kejia.hu@codethink.co.uk>
To:     agross@kernel.org, bjorn.andersson@linaro.org, sre@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Kejia Hu <kejia.hu@codethink.co.uk>
Subject: [PATCH] power: reset: qcom-pon: reg write mask depends on pon generation
Date:   Tue, 28 Apr 2020 08:04:37 +0100
Message-Id: <20200428070437.14016-1-kejia.hu@codethink.co.uk>
X-Mailer: git-send-email 2.11.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Instead of hardcode the mask, it should be depends
on which generation of pon it was.

Signed-off-by: Kejia Hu <kejia.hu@codethink.co.uk>
---
 drivers/power/reset/qcom-pon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-pon.c
index 22a743a0bf28..4a688741a88a 100644
--- a/drivers/power/reset/qcom-pon.c
+++ b/drivers/power/reset/qcom-pon.c
@@ -34,7 +34,8 @@ static int pm8916_reboot_mode_write(struct reboot_mode_driver *reboot,
 
 	ret = regmap_update_bits(pon->regmap,
 				 pon->baseaddr + PON_SOFT_RB_SPARE,
-				 0xfc, magic << pon->reason_shift);
+				 GENMASK(7, pon->reason_shift),
+				 magic << pon->reason_shift);
 	if (ret < 0)
 		dev_err(pon->dev, "update reboot mode bits failed\n");
 
-- 
2.11.0

