Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C50161EBD
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 14:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbfGHMsC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jul 2019 08:48:02 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:35573 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbfGHMsC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jul 2019 08:48:02 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MOV26-1i9GEl2RX4-00PwCX; Mon, 08 Jul 2019 14:47:49 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: thermal: processor_thermal: mark pm function __maybe_unused
Date:   Mon,  8 Jul 2019 14:47:20 +0200
Message-Id: <20190708124743.3585020-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jY8CsqninBJpp72LoWm3o2SSyMZUEEdi4Q2VjdlrSS7nCJ5qWnp
 J32z7Feh6adkH6Nc7yWZOASWH+fdm4qJyfe6CvlAwXH4PttOnAING/xy9G4RcFkdisxVWVU
 y/qmLnw/oO8KFQJ+4Gc2dfVxnmuxc6/bdkWN63voVw4WWQNEr09JaMbqMLDlNdKLE5w122D
 tCSS6FFSk7OliH1Tt23bw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2j81dPrWY9o=:8gBKlza1wKZkyDVk8DRBc+
 ejlgGPfmLCeLyzLHCcraEgn4/WheSxAb8Quyjp5JLrGNSfsfnB6Q5oEVYZQetrB0Cm8gEYEmF
 cNbNi21YmC9QcSDN1e4O0C01v96CzUlAH0+D5F0o4p8sCg1ReV/B5Kz0vJ5J6Se3LjpnlnuVs
 4vHRx3URNOKPVYb2uvOW7sJgWufVIOKnUedj/G29nXc3CJmDIeDLCbVObftkHc6yGGlpctbiI
 rRhedgaVb3QBfgiCDIYR3Y9zh30ieqlgNYHDegDA8I4u3pgHLl46pgx+nOh7dKkW+WZ9KRHzU
 Q7qG+ttFAdWdRuRUDdIszSyuNe0olLxT5CDO7Oc/drcvYPoBTj1fVjNFDWkmvCN+yQJpMS4jA
 lJtaCtJ/f6nZrZZx4g6ADel2HdBz/KTIAbUpZ6eChWJlWx23muYkimM02HOVxqllnPNoHaFe3
 TgiAG75ZJThZ4/rJcXQt9Lp7Mp903IdXq6Crvx0dB+Qgv7tDSyelsY8qQtSD6LFVV2pwoa2cD
 8/SBEMq3+Y2VGHYPQkLBPNIJwjKM/zel/YegrBjTIovw4mf9NeRKFkAlqETK199l5vj+iCUfn
 bP7RBMQHXnwQ3SnsSAv2SAcZWmaKFXTpRKQM5+cBJ2xbttOqNIkrHE80OMM5s7KQDsPWG3SNp
 ZexqwDKDDZQyZcEJSdP4huCZiBhOraSyQxp854/yn/dmeHJiCvZ1PvMQaoD9r26aCXrARirtr
 sLMWEJ/hbvF8HFlxx3GoMTKhSxn9rmcstvIP5Q==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Without CONFIG_PM, we get a harmless warning:

drivers/thermal/intel/int340x_thermal/processor_thermal_device.c:446:12: error: 'proc_thermal_resume' defined but not used [-Werror=unused-function]
 static int proc_thermal_resume(struct device *dev)

Mark it __maybe_unused to shut up the warning.

Fixes: aaba9791fbb4 ("drivers: thermal: processor_thermal: Read PPCC on resume")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 .../thermal/intel/int340x_thermal/processor_thermal_device.c    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
index a3210f09f366..5ce639a99330 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -443,7 +443,7 @@ static void  proc_thermal_pci_remove(struct pci_dev *pdev)
 	pci_disable_device(pdev);
 }
 
-static int proc_thermal_resume(struct device *dev)
+static int __maybe_unused proc_thermal_resume(struct device *dev)
 {
 	struct proc_thermal_device *proc_dev;
 
-- 
2.20.0

