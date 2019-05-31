Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A792D310E9
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2019 17:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfEaPKP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 May 2019 11:10:15 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:57807 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfEaPKP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 May 2019 11:10:15 -0400
Received: from orion.localdomain ([77.7.63.28]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MHoZM-1hLEQr02bu-00ExVB; Fri, 31 May 2019 17:09:11 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org, jdelvare@suse.com,
        linux@roeck-us.net, khalid@gonehiking.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, aacraid@microsemi.com,
        linux-pm@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: [PATCH 1/3] drivers: cpufreq: cpufreq-nforce2: remove unnecessary #ifdef MODULE
Date:   Fri, 31 May 2019 17:09:02 +0200
Message-Id: <1559315344-10384-2-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1559315344-10384-1-git-send-email-info@metux.net>
References: <1559315344-10384-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:AJheLpqoCJKbh6Psp+1Aqo/PyA4RuHOgwjoUpGVJuTXuR6QfiD4
 gt34TkkfESTrbAeNrt1ni2kUVHZ6MDEnErBlyN638nhUJDyM18ZaBgONmUM7O3HgrhBrQm7
 ihsmaC7fHGMHq8L2Sgi74UuUcAi4N0QzjP+mBe1H3SVdjiNHb8oHOKrJetvWIJYvHgNktrD
 daZE8Tab/M1BWb2Man7uQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qHX4061IyVQ=:hCuUIvpC9QTPluiqGmqw/+
 uRykCwCRpIe0OdB5gTV9n2PrNOtMjomKVLyqVPITGGAMxWeNoiPpi1l8RkMY1BLRha0b1f8n+
 wZi/7zE7tTbAYAPLq9hGToxizzx3EpVQ6LoOIsafPMbkb6Ra0ZNmZjdX6oxPuXnLOOvNv/w5W
 MZNgf4bcYTSj/vSYVS5JmAoEthTBc2jv8vcHD3znGnHHcTHAAVeLDEOv9YCTFJHv4OvKaddVd
 Z5YtbsuREczNcvLqpHLmy673pK4tYKwLpI0FP7B7RtHHaaYEvrNg5vIXsAVZLfofco3E5DKh4
 IwQMvqSQut32S+EA//6IYrt1Yj0Sg7I8kevLUHiHtPGAPgyu7qyP6UU0juNh7ss3Y90rt9q6P
 YQhRAVpbSAhJ/uIMQZPxOpDrQXb2E8WYRTd4uNK2qwCdazVKjt2yhayA+3qKLN10pgYTKc9eh
 9b9cSGvxbAB7XTro5aWU6AU3TE43vLpT+21epTkMWG1+0m7VEp/8pjnpE7XV5smlfjftbmJ7b
 z+vgz9tMZJELVXgw2jaNtU0bgw9ZnW10/0BH/+bgYI0bsWkEoCtCA3A/uQgMUYTNDZCkflqp0
 Cp7ZwJEvNdK001VE7Yun8GTLxQ2ZT/UxTWMpOo/z+nEjUbZMtA+KxjQjHz6s9TWDOgKtosuAn
 vzw3QG2zdh95eC9HAJ15vBNAQ+nt9uoFqOUCMut+qeks6+gB4M4DpdI8AUtlCn6T9+CV5nGSl
 6Y82LiOO8CZ6DVsAnHKTAVz6xyMaJ9l3r5XjDw==
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
index 33c309a..b8a6c9e 100644
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

