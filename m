Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10EF8EA1EB
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2019 17:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfJ3Qjc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 12:39:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:46594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbfJ3Qjc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 30 Oct 2019 12:39:32 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78A97218AC;
        Wed, 30 Oct 2019 16:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572453571;
        bh=uPpsLnIwswK4MvCgYfMrudAcG0whDitorkLSfI+nb3Q=;
        h=From:To:Cc:Subject:Date:From;
        b=xdkOfd1yvSJdwDk7TNjX9HOowIi2HLFtg17p6P0NFVvETxTk1VqoKCMxbdUwfIY0G
         DZEaIhwLkmobqT0No607KZqrpOI73RtwYdp6hgKBYTEm/tdOwc6pELf22IPS+wmtY1
         dpYphs9pdwMIH6/RoQNz9Eu0TDrTa7y2xV7Z/TMQ=
Received: by wens.tw (Postfix, from userid 1000)
        id 66E5F5FB7D; Thu, 31 Oct 2019 00:39:28 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Markus Mayer <mmayer@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: brcmstb: enable hwmon
Date:   Thu, 31 Oct 2019 00:38:07 +0800
Message-Id: <20191030163807.17817-1-wens@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

By defaul of-based thermal driver do not have hwmon entries registered.

Do this explicitly so users can use standard hwmon interfaces and tools
to read the temperature.

This is based on similar changes for bcm2835_thermal in commit
d56c19d07e0b ("thermal: bcm2835: enable hwmon explicitly").

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

This patch was only compile tested. A similar patch [1] was submitted to
the downstream kernel, which I did build and actually run on a Raspberry
Pi 4.

This one for mainline is much simpler, as it does not need to deal with
the error path or device removal, due to the use of devres.

 [1] https://github.com/raspberrypi/linux/pull/3307

---
 drivers/thermal/broadcom/brcmstb_thermal.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
index 5825ac581f56..8353aaa4d624 100644
--- a/drivers/thermal/broadcom/brcmstb_thermal.c
+++ b/drivers/thermal/broadcom/brcmstb_thermal.c
@@ -21,6 +21,8 @@
 #include <linux/of_device.h>
 #include <linux/thermal.h>
 
+#include "../thermal_hwmon.h"
+
 #define AVS_TMON_STATUS			0x00
  #define AVS_TMON_STATUS_valid_msk	BIT(11)
  #define AVS_TMON_STATUS_data_msk	GENMASK(10, 1)
@@ -343,6 +345,12 @@ static int brcmstb_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/* hwmon not enabled by default. Enable it here. */
+	thermal->tzp->no_hwmon = false;
+	ret = thermal_add_hwmon_sysfs(thermal);
+	if (ret)
+		return ret;
+
 	dev_info(&pdev->dev, "registered AVS TMON of-sensor driver\n");
 
 	return 0;
-- 
2.20.1

