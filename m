Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A93EB72ECB
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2019 14:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfGXMXn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jul 2019 08:23:43 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35785 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728320AbfGXMXn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jul 2019 08:23:43 -0400
Received: by mail-pg1-f195.google.com with SMTP id s1so14851675pgr.2;
        Wed, 24 Jul 2019 05:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0Bq95a2dWVmqz5wpwfPumDSp43fWJu9vdyxhDDJqOMY=;
        b=n9v9I85DopyF8lDXxoXj54Nrffh0NnCfFwcRCDSRJZFktQzwj+hq3miAABZLmwKWpI
         l4h6g4weiqFPGT/1cDC9ct5bM+mOuur/6fxrHakB3ZB0HB8yb/Ncs0kCpaB97DM0TEUu
         enCrZCAOlZY8e5GCoArIjd/vl1Lel1/UM4Nz4tIcvsnPEyL88BhyA0bQTIH1CLu7TPgw
         ThvP07sN5OF+iNlDCU/6ooRT8SOnUGbTPSqbXu7Ob0P6h9Uh64gPSY60+I2+tMoTPfmq
         0d6dI3qSVLPcBiPOYfLE+U/XMh8jG81AqTLJWCYIZyRa87/jo5LlylBABzW4kLrfJ9Sq
         ZBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0Bq95a2dWVmqz5wpwfPumDSp43fWJu9vdyxhDDJqOMY=;
        b=rgUWRNtw6bOE6SEosqm2xpXR6x/eXuSS5uLUlVlcFwJc9AoMtQUzGFYN24fjl3FswV
         0lIkpwSklclXCM7MrI2EvkesoqtG7y5zUMMJTcwnO1qYHoqgoTsdCBN2rQu1OIyv/kp8
         i6BkT1k+AAutCjxUVTmKEpsgsbM+2ubzd0VEjw6YnNK0KlJpCtwH83HmXRBCenXG0pMW
         /HQARXBYpT/7liA5bP9iCTrYhd4TksJSDNlOQZ4T62o7jHocgYbTxtN/Lr8l4YWKdl3G
         Mi39ij6Y004PtnFnqyoRs0pgr2LqnGzdR/wYekMuamwLAHJ7LM8j4Wxlp2+Dg/3pYDYn
         RYrQ==
X-Gm-Message-State: APjAAAXHPCVqJfYpB9c0yKCxhkGzEmNSqfmT+otjAZV/CUD69a7sGrrQ
        yNfsY6Dw1x6LrALNKH+/yhxeaj+YY4s=
X-Google-Smtp-Source: APXvYqzu0fGYSv0LhgIKNSwmtMHib3axd4F73YkpMilFBpe1KUQUST21hwYTOIOUA1cNdcuwTWW39Q==
X-Received: by 2002:a63:9e56:: with SMTP id r22mr24339698pgo.221.1563971022888;
        Wed, 24 Jul 2019 05:23:42 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id a3sm48233918pfo.49.2019.07.24.05.23.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 05:23:42 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] thermal: intel: Use dev_get_drvdata
Date:   Wed, 24 Jul 2019 20:23:37 +0800
Message-Id: <20190724122337.21910-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Instead of using to_pci_dev + pci_get_drvdata,
use dev_get_drvdata to make code simpler.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/thermal/intel/intel_pch_thermal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/intel/intel_pch_thermal.c
index 99f8b2540f18..4f0bb8f502e1 100644
--- a/drivers/thermal/intel/intel_pch_thermal.c
+++ b/drivers/thermal/intel/intel_pch_thermal.c
@@ -371,16 +371,14 @@ static void intel_pch_thermal_remove(struct pci_dev *pdev)
 
 static int intel_pch_thermal_suspend(struct device *device)
 {
-	struct pci_dev *pdev = to_pci_dev(device);
-	struct pch_thermal_device *ptd = pci_get_drvdata(pdev);
+	struct pch_thermal_device *ptd = dev_get_drvdata(device);
 
 	return ptd->ops->suspend(ptd);
 }
 
 static int intel_pch_thermal_resume(struct device *device)
 {
-	struct pci_dev *pdev = to_pci_dev(device);
-	struct pch_thermal_device *ptd = pci_get_drvdata(pdev);
+	struct pch_thermal_device *ptd = dev_get_drvdata(device);
 
 	return ptd->ops->resume(ptd);
 }
-- 
2.20.1

