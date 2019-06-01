Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC74C31F95
	for <lists+linux-pm@lfdr.de>; Sat,  1 Jun 2019 16:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbfFAOCY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 1 Jun 2019 10:02:24 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:45583 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbfFAOCY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 1 Jun 2019 10:02:24 -0400
Received: from orion.localdomain ([95.114.112.19]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MRTIx-1hCWtT12Ht-00NOdl; Sat, 01 Jun 2019 16:01:46 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org, jdelvare@suse.com,
        linux@roeck-us.net, khalid@gonehiking.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, aacraid@microsemi.com,
        linux-pm@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: [PATCH 1/3] drivers: cpufreq: cpufreq-nforce2: remove unnecessary #ifdef MODULE
Date:   Sat,  1 Jun 2019 16:01:38 +0200
Message-Id: <1559397700-15585-2-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1559397700-15585-1-git-send-email-info@metux.net>
References: <1559397700-15585-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:nfIs3M5FOuPpOWeQmPLfkL+4Fg523wZ6xXAuALO2Ha+N5bjyhpn
 uUy//sej4pWYzh7safog17YAfo6BFsqZu2oQMDwpZkE6gxge5M1dzE5tAHCM8r08n4yFAeE
 +ewXaFzvHuLhvjvMSElD3Qrig+e4VkqZZW4lKJAVVQnW7tb+IbDXvDLhu2Tyv/3ZFEVRyq+
 B/pdXEKL0jOQJYcBEQZYw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SCLzH4zfWGo=:Vk9WwMr7sIqImVhrbQY8mv
 zHoKpUip1zBm7pMLwu4Z+MReUFmhqjWHpTnJH9kwzpHh+muLpEUwJTMQORWCBnO83qaJ2OgNP
 kDCNW/fvwDy2/gjtpqYx4C+Y35P8AM7PWcNZHhoXFfvdtIeSJ/kyfvkg1IdDucg4moNvp84OI
 HUkIcJobLjZqNNuXQwOX1szm5NO8zFRsPjkAsP9NoRZabTWss8xSWCrKHHP8MFqM+UiJ0zYqz
 MaiNAa63CVkuR5CktqYfWaEicH8s7JClXBjKDakQLzgca3vKFoTtNPh9tuCn8ch0QIHY03jOb
 3T3W6oM5Ns/UxIDbnBxb/h+b0WzNeH8OkjzazzWgMureftYMzErd0SoICjQ56LklbZY9Nlk5N
 4Ted9GC0cAfKbfp7xsv5fqD3WDf2CbY08nGN3RYmycsv/dY3fYqRU23gYV0A51O/qDN0Xyzec
 +dMcHnZ3mgi+9LY6yWEPGzSSOTSQV5YbqITj/8lKkOdOsFdnIrIu4VVSZU/usMXPyU0u7F+QV
 FLOJTfALYwFlLgvnNx9oG4Tjw6ZR/+oBpW48QWPVzjE9oacVJR2kKhuvyM04wz/ojBEIaEkjx
 fOoiuOhS0xgndIjHtgNcRx5A1K5JkOx1oy1liIvi3pchy9HVpqrtKTGBy/bRMi0mqq2AqMvV+
 Z9/Kn53nk6vLgEZ20t3q9k4e3EhRzqYQByJYiRSE0F248w10ypI+Wny3tvqenLdz4ot+6EXq4
 0cc1VD1kZBFTPIbsn4iiVAcTBmGpkFgh7Ba2cg==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The MODULE_DEVICE_TABLE() macro already checks for MODULE defined,
so the extra check here is not necessary.

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/cpufreq/cpufreq-nforce2.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-nforce2.c b/drivers/cpufreq/cpufreq-nforce2.c
index cd53272..6dd1827 100644
--- a/drivers/cpufreq/cpufreq-nforce2.c
+++ b/drivers/cpufreq/cpufreq-nforce2.c
@@ -374,13 +374,11 @@ static int nforce2_cpu_exit(struct cpufreq_policy *policy)
 	.exit = nforce2_cpu_exit,
 };
 
-#ifdef MODULE
 static const struct pci_device_id nforce2_ids[] = {
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2 },
 	{}
 };
 MODULE_DEVICE_TABLE(pci, nforce2_ids);
-#endif
 
 /**
  * nforce2_detect_chipset - detect the Southbridge which contains FSB PLL logic
-- 
1.9.1

