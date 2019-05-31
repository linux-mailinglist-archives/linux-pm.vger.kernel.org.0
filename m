Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8E5310DA
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2019 17:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfEaPJu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 May 2019 11:09:50 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:53487 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfEaPJu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 May 2019 11:09:50 -0400
Received: from orion.localdomain ([77.7.63.28]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N2V8T-1gaooq2QRD-013vOa; Fri, 31 May 2019 17:09:11 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org, jdelvare@suse.com,
        linux@roeck-us.net, khalid@gonehiking.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, aacraid@microsemi.com,
        linux-pm@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: [PATCH 2/3] drivers: scsci: remove unnecessary #ifdef MODULE
Date:   Fri, 31 May 2019 17:09:03 +0200
Message-Id: <1559315344-10384-3-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1559315344-10384-1-git-send-email-info@metux.net>
References: <1559315344-10384-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:vRieALr69N/p9CGP2TmTdjYIaR7yt8zI1oJIboQVelsLO9ZBK4b
 7+fLJ+7X4tp6PmW/HUQ3cXeovgj8VOqyN5fHrvXiqj2TvHm/tnl7ZT9fX4Ufhj8Eljw4E87
 kAnB0ARfOLeJoyoe8xdU7bJg2gJ7EuilpTuLbQBSqBtupjMOlZq0BazVnffUrUVtup3SGgF
 1bdYZyK7ePS8Gu7h7l5Bw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8iWc5OqMQLo=:SAi3pINLsLrKq8qqkf5y4X
 hSVd4KQuUvvD3aMzTkHaaY8+SFKLu4gYZUQb4UiDYlimTtQYK6I7AoTb/zvR6G9kpWlcXeQSD
 clMop8KQ4IAb/8+B5vPZ7iSxkdHeBqYu0LTqpLvUljw35yGz9VoLrfHTt3/9OaWMlXg/q6Uet
 T+72o8Swkm9nDHfvWsAExTUbPnmOkDgN7i7LV5dHq6IsQfzx2+lnXDLeGI2fICPql9his15JD
 qTC7R+Hix4Zw0OWYyUVAA5b3QdDNs6kNreNaMbZp4TiFjyHlvu1aRIeqU74zAj3VrhxExyPQG
 Wz2C2A2gNdCIBY5JQEqwBzbxpLzX9bWRW+DKD1WBYESMXBBpBbd205rAnvcEvyMLun9NwBLAy
 HiAVX2gvg2nxURxZEYEbhR1v8LQsCYt4A4AZ5IBUg3hvNkXq/q9MeNbN2yWy7mmpsh2FPlnJB
 qrl2mZxhjqcT3ykoQF2XZHmttU1b45Nj4z/vxpVg0GfFScIW4k/aNrVe0lg5j7S/Yv8qIZsn/
 JDEjgngwo4FSENa93fGtkniZ9YtDJCAtiRBWZnWZeE9T69SVvg26PuxWooZ7AUkXFm+2etFa0
 M+Zr0s1PvXhsPJuWcxzrteuqz/3M2FtZDUBzPeGzjjeW6N/qwyC5/otRGKw6E7gUc2260KHRY
 bLxZmH9ia9sEPntik7KptcGpkoYqpjf1WhGt9iRo8S3j6Ey2mu/2+0HwTSQHhhcMpEQgpudDi
 11gE65yfBOXMl3a168kbyuVucUmivPdMdfqZ3w==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The MODULE_DEVICE_TABLE() macro already checks for MODULE defined,
so the extra check here is not necessary.

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/scsi/BusLogic.c | 2 --
 drivers/scsi/dpt_i2o.c  | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/drivers/scsi/BusLogic.c b/drivers/scsi/BusLogic.c
index e41e51f..68cc68b 100644
--- a/drivers/scsi/BusLogic.c
+++ b/drivers/scsi/BusLogic.c
@@ -3893,7 +3893,6 @@ static void __exit blogic_exit(void)
 
 __setup("BusLogic=", blogic_setup);
 
-#ifdef MODULE
 /*static struct pci_device_id blogic_pci_tbl[] = {
 	{ PCI_VENDOR_ID_BUSLOGIC, PCI_DEVICE_ID_BUSLOGIC_MULTIMASTER,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
@@ -3909,7 +3908,6 @@ static void __exit blogic_exit(void)
 	{PCI_DEVICE(PCI_VENDOR_ID_BUSLOGIC, PCI_DEVICE_ID_BUSLOGIC_FLASHPOINT)},
 	{0, },
 };
-#endif
 MODULE_DEVICE_TABLE(pci, blogic_pci_tbl);
 
 module_init(blogic_init);
diff --git a/drivers/scsi/dpt_i2o.c b/drivers/scsi/dpt_i2o.c
index a3afd14..eb5cfe8 100644
--- a/drivers/scsi/dpt_i2o.c
+++ b/drivers/scsi/dpt_i2o.c
@@ -180,14 +180,11 @@ static u8 adpt_read_blink_led(adpt_hba* host)
  *============================================================================
  */
 
-#ifdef MODULE
 static struct pci_device_id dptids[] = {
 	{ PCI_DPT_VENDOR_ID, PCI_DPT_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
 	{ PCI_DPT_VENDOR_ID, PCI_DPT_RAPTOR_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
 	{ 0, }
 };
-#endif
-
 MODULE_DEVICE_TABLE(pci,dptids);
 
 static int adpt_detect(struct scsi_host_template* sht)
-- 
1.9.1

