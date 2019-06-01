Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2DC531F9B
	for <lists+linux-pm@lfdr.de>; Sat,  1 Jun 2019 16:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfFAOCe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 1 Jun 2019 10:02:34 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:54587 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfFAOCa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 1 Jun 2019 10:02:30 -0400
Received: from orion.localdomain ([95.114.112.19]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MS3vJ-1h8iCv3O8p-00TSvX; Sat, 01 Jun 2019 16:01:46 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org, jdelvare@suse.com,
        linux@roeck-us.net, khalid@gonehiking.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, aacraid@microsemi.com,
        linux-pm@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: [PATCH 2/3] drivers: scsi: remove unnecessary #ifdef MODULE
Date:   Sat,  1 Jun 2019 16:01:39 +0200
Message-Id: <1559397700-15585-3-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1559397700-15585-1-git-send-email-info@metux.net>
References: <1559397700-15585-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:g52S7+6K+q7a6APcfLktQhtu6ysHVyU98fi+mu/EcNS2n+TBuZt
 a8WSpwzjfTZQh17F+xrRcraDx578GIi1tpiQ/rZ6OhbFzrLYTScnlur1ZUSxWWt7MBmIFR2
 MECVgJKk8DrwvVZm0XgHMGOempAKuwdBeM/fVJ/EUlHMaf3O+9gpiIjNuKKsv3uberbFF6o
 5crXOBT37nAt7QTHbw7Iw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:z05ZqzbJR2I=:xRzDes0nICf8as6QyE5kyp
 JRZUQd3TBI5k6cgFV4h0/rWxs8I+kKBTjpl3l8H0BiS6XTGo7AOBIyD2U6Po+mANLSoPDf5m0
 ErP/6ywGyTIB19Z4bN1RNaOYuqlLzsB0N6QMIZVJ8VT1Dw0vzp6xOyATN7MKXHnvNNc/PtL02
 jfnv/ks80t8drbIvWpxKUaiCEUEiK+Up6nLUo2nNbIOPc0Es5/rJBPAennFdmtHr/o4XCTlsF
 n9yuG+DZ3zAwpAzOLK7bCSIAer9oSGtd37i1IJR2Qohd+sHBZ/rPzadtAufL/U2qCOSZtfaEu
 BrONKjeSgbRavmljSGskd3VqIMQfAaqNPIfaNzq6Wm9HXSKUu76BBtgeHfGLJDUeNzATSxelX
 U+I3Qrb5XSZQGNGTWf6VbsV80jByhlpIwMQzaJv2cFc4cRzTEi8x95D8BGQ3yAZwp7F/Pj3El
 qLAYf2ZaPjBBTLSDbKt4TQU/TXO7E5UGLOaplyhwxwFNMfjPmQUuH9ftO1aoMJ3TiW1aMUnGc
 x2pgfQb2qRU+TIsQ3n5mlrMiVMgZjd4sFAq90zQ7uXeo4hHnE1wdqc4UFK55EA9pcEvx7Zj+H
 ryawlrQnliSamCk5wtFS81Q8x/0C01o0V6tADTjV7DorTn2EFs9AYQdUPyLmsjhZmZ15CyoIz
 Mx18H6Qy8x0prwveBbO/1UroNMcUQmAxBDyzUqphtvSjzIujtaWmXrhfECYq7uLHg7s6Q1Nan
 oAnwhjy7dsHuHOyE32xYfP/gGOUAhWyw+8Q6qQ==
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
index abc74fd..9b28f9f 100644
--- a/drivers/scsi/dpt_i2o.c
+++ b/drivers/scsi/dpt_i2o.c
@@ -177,14 +177,11 @@ static u8 adpt_read_blink_led(adpt_hba* host)
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

