Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 942D7114D02
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2019 08:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfLFHzo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Dec 2019 02:55:44 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38503 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfLFHzo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Dec 2019 02:55:44 -0500
Received: by mail-pg1-f194.google.com with SMTP id a33so2692794pgm.5;
        Thu, 05 Dec 2019 23:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b6sEPD+7f9rrFrxPhOl7e8WDEqgliGQGOKb/WtjO5Ls=;
        b=JjCpjTdldUb5Ee7hf+FyCpro5m3bK+w+nKTnerlO61bkactO3Pyg/DYFivgT6NI8PC
         B84PnZ/bCNOr4p+Wn1tV2ToQPvy1XTdvyjLTTWTw3Bzs/1VNYstBAOfITJT+uZKlmMgu
         FjPUmvVbd1Kouub0lAIwtbreOKXF7zzrgdp0Sq571C/7L1rY/ph5vovRfrbuGKiRqM8n
         kCC12Ye/dNaLbAoEcrXrmKI6QMG2tJFKVn75gQajCMFMcbDpi7DEe4mnmMyzru7bCH9Q
         vcDpwm+GtdGap0BMgwSEzhqlnN06LkyGZGzJbRConkvc1zdr7h04fs0j6s8xV0vgr/H/
         nWeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b6sEPD+7f9rrFrxPhOl7e8WDEqgliGQGOKb/WtjO5Ls=;
        b=fegqUmbvyGXUU1z8cA5iS8oRmzwMxwMmovO3yfD+fWpZambgqHFHX6HNzj8wU/LBZD
         ycxtRAlJIykeL30cYCZNk4XdfbEUgb1yt1tSS/8043Eba/Jnsq5861VTvxpSOn5hnj0l
         aCd7zGXl1UBpBNGFC/EeyhKZPLfhdFmlY1RDZf5G8n+P2CrBe9QddBF9uD1LjjA6ZPv0
         lt0vjSUOs4FW5O7ZWnTzBCGYh/Aokc76vNqr/cdZ6TCY+fZgx/Kr7eMK013GghEqYTYR
         l35BDZz49Nro/DqE2tY3alD8mJFAmyWE5isrYriInkTzFuWycfzIneu+V7y8wRsspLGk
         nS3w==
X-Gm-Message-State: APjAAAUr/lUnVnfnkWahIcMengqpZYTBR6Igg9Yrcycmw7nnitNckfy8
        oUYCNWTk0FsompfOBeeCa9Q=
X-Google-Smtp-Source: APXvYqxYsMlnlr32fMRFumCNpuqkIcvwFIN120LLG60hSJicwgrN05/T+i/EfDN6esL3zZuRH8S3dA==
X-Received: by 2002:aa7:90c4:: with SMTP id k4mr12870805pfk.216.1575618943947;
        Thu, 05 Dec 2019 23:55:43 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id q3sm15890301pfc.114.2019.12.05.23.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 23:55:43 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] thermal: intel: fix unmatched pci_release_region
Date:   Fri,  6 Dec 2019 15:55:31 +0800
Message-Id: <20191206075531.18637-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The driver calls pci_request_regions() in probe and uses
pci_release_regions() in probe failure.
However, it calls pci_release_region() in remove, which does
match the other two calls.
Use pci_release_regions() instead to unify them.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/thermal/intel/intel_pch_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/intel/intel_pch_thermal.c
index 4f0bb8f502e1..5f7798b8d35f 100644
--- a/drivers/thermal/intel/intel_pch_thermal.c
+++ b/drivers/thermal/intel/intel_pch_thermal.c
@@ -365,7 +365,7 @@ static void intel_pch_thermal_remove(struct pci_dev *pdev)
 	thermal_zone_device_unregister(ptd->tzd);
 	iounmap(ptd->hw_base);
 	pci_set_drvdata(pdev, NULL);
-	pci_release_region(pdev, 0);
+	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 }
 
-- 
2.24.0

