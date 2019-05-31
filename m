Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1FB310E8
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2019 17:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfEaPKM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 May 2019 11:10:12 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:44159 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfEaPKM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 May 2019 11:10:12 -0400
Received: from orion.localdomain ([77.7.63.28]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MatZt-1h099n0hvH-00cSMW; Fri, 31 May 2019 17:09:12 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org, jdelvare@suse.com,
        linux@roeck-us.net, khalid@gonehiking.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, aacraid@microsemi.com,
        linux-pm@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: [PATCH 3/3] drivers: hwmon: i5k_amb: remove unnecessary #ifdef MODULE
Date:   Fri, 31 May 2019 17:09:04 +0200
Message-Id: <1559315344-10384-4-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1559315344-10384-1-git-send-email-info@metux.net>
References: <1559315344-10384-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:UFXCTI+KzrMW9xbCJ12euR95G6kfoQ3hucMGBBHRk8vAmA8h++y
 atYci0mi+NPhgAE1qhS6aZ9fGOnaGrLanWLtyFr96kZuMR4dOIvcznbAJDB9G2EeSOK6AS0
 lGVHgmvWbj42YrhlmZlOZLH2a2664ODGUNdeTJS1NeKevgeQCC8/7SMQUfNUrn0boYWSrA+
 1Hs6drrmGWuHAgOwRG04g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2bZ6GxbGq4A=:ulLt4MudFSLl1iwUUZQWW6
 1HlUAPB291wGvY/suiq7ef/3DgpQB7zw1CELV8v9xLGZI5pZ7hNnJFnZxt/uhZtL8yz9gM6AF
 pEUD4OWbgd8aN/lqcrOSltvBpVBIFFzaDEzp9lej83UkigEap+16tP/HQKZPRm2YXY7fS4GdZ
 sxALxl0IIIfwiCV6qV6e/WcwRHdYzZX/E1MmELfLhLmiU4YN9ofSR62E0GF7WGhyRSy44y9HV
 nGyCMsp2SjgeEUMtPzgBLiDrhlPiGTJlEgTmR29AsC0nij/mlaIKehcjHIrFBcHzcELKqFJoR
 ZDEATb8yRVuyWDbLcNExBx1w1+N1gDVXN0UAIrU7oI/BepyLZHKao0LoTIzHhtJWl9EKd22HD
 0tu0/Je45iqqaLMw3Ie9zymLbMLX59VfsrbKtLMRc2gkMfVzTNtOLNtwd17cdsP4qmOICkF8a
 YdyPbs6FmGuJNICL4rA308o80o8J24AQk6sJtcyIuQBivSHzSVrB1MaByuBLl/4k0gQ4uAtpz
 GFXsQtt7Gr4v+EnfMAuBsigtybzCe/dutPGZjXedmrPk29OrGGCKgDD8K5vbl/pGp9IdSK0vm
 Hr8Js3sXUE83hR2V59JQqfcl9nyYj5juyuA9y8fUAPibfZLpAcxf5sBwMXziqjwwhzs9yEth+
 brLvA60uevkbOKmlEQ35cayuxpHD9RlW5uxAWm+VynpY6HAoZDlVz2EoVZ2Cdso6xsJFcs94S
 3Y2FVSOy6m2lFLYFvY+0lZoE0Ki+BSZKeWCcYw==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The MODULE_DEVICE_TABLE() macro already checks for MODULE defined,
so the extra check here is not necessary.

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/hwmon/i5k_amb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/hwmon/i5k_amb.c b/drivers/hwmon/i5k_amb.c
index 2cf73d8..622405b 100644
--- a/drivers/hwmon/i5k_amb.c
+++ b/drivers/hwmon/i5k_amb.c
@@ -495,14 +495,12 @@ static int i5k_channel_probe(u16 *amb_present, unsigned long dev_id)
 	{ 0, 0 }
 };
 
-#ifdef MODULE
 static const struct pci_device_id i5k_amb_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_5000_ERR) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_5400_ERR) },
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, i5k_amb_ids);
-#endif
 
 static int i5k_amb_probe(struct platform_device *pdev)
 {
-- 
1.9.1

