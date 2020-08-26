Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA632531DB
	for <lists+linux-pm@lfdr.de>; Wed, 26 Aug 2020 16:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgHZOtR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Aug 2020 10:49:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726988AbgHZOtJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 26 Aug 2020 10:49:09 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77922221E2;
        Wed, 26 Aug 2020 14:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598453349;
        bh=eaW0aBiOy01iK8S2RsXiRKkJ6drv51HgzFij3kxD4oA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EIcsim/r+XSjD0HHyIoS3Ng6iKV/5nUgqCui0TSYKp4aYcsObrLGH3YgQ/gdponOm
         mxl5ZXg0kCiY+/4GrlTVjdKcQgoPwQVPmM+XZPJGSBuF81Pr7fs5S1f9VV+P3FPzhQ
         D/VyFqRG1IIbgPQh8rUifP49+7Iw8IiZ78eJsMtM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        David Lechner <david@lechnology.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/5] power: supply: cpcap: Simplify with dev_err_probe()
Date:   Wed, 26 Aug 2020 16:48:55 +0200
Message-Id: <20200826144858.9584-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826144858.9584-1-krzk@kernel.org>
References: <20200826144858.9584-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and also it prints the error value.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/power/supply/cpcap-battery.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
index 90eba364664b..295611b3b15e 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -747,11 +747,8 @@ static int cpcap_battery_init_iio(struct cpcap_battery_ddata *ddata)
 	return 0;
 
 out_err:
-	if (error != -EPROBE_DEFER)
-		dev_err(ddata->dev, "could not initialize VBUS or ID IIO: %i\n",
-			error);
-
-	return error;
+	return dev_err_probe(ddata->dev, error,
+			     "could not initialize VBUS or ID IIO\n");
 }
 
 /* Calibrate coulomb counter */
-- 
2.17.1

