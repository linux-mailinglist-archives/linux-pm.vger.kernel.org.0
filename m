Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF0336BB47
	for <lists+linux-pm@lfdr.de>; Mon, 26 Apr 2021 23:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbhDZVhi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Apr 2021 17:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235538AbhDZVhh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Apr 2021 17:37:37 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541B1C061574;
        Mon, 26 Apr 2021 14:36:55 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id y1so14030867plg.11;
        Mon, 26 Apr 2021 14:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nnvTC2gtVVCd0mSMj/05A70ERgumEKKzDpQ3v91EDxU=;
        b=YWk8pQm3q+fJ1BhihoU49PohuIVt+eUXRMMnY3MGJyINBA+oQ8B5Xm4QiN3MBMnP/7
         fHBzTZU/y7vVgKNHH5rFbp+jDlnDnIaP/d/63+XbRdlvf8TkACT2UA0wdU+GWlsc/Njw
         VY4a6LJtvyIp2zdhNjJcoLz10sojsANk0qOPyDJv7xP9+u75eJPCJKotHLo6q9t0E0J9
         l9euNU22D/FJl/aVV9ZpScROMHnst+jG2gLwLZbsHKEL+7f+LJvACDOWjcwzZjGvyrSn
         dZM1854yzYHKBjNd0PiUkU81/x56Qb2/gWedoABpEh8lrROgoEcIhh1XQLj220RTesAp
         nUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nnvTC2gtVVCd0mSMj/05A70ERgumEKKzDpQ3v91EDxU=;
        b=kqlBLBsJcMgYJNGcx4FNgIgz8B5OAmt5ZLN7Z8PBnIPCb+k3/23H5kXSX9SjlIyKe9
         LoSwmh+60cIx6DXiTnevUW3Gdk/o+OVIFwSp7LgMPyKi9JSCx6n3poUBm/ALGevSAm5/
         E+79aD/wVxRCjK58Ezlxq1Q9tG5SU0uz+kXPRZ3bs4kgaRy6HE6+1Psy3yh+PqTC1zuX
         AgSDZUz1RY/TXcSTWn4RpZKEIqUCkdff8JgXwufNl/US5Ckwi1o4IHktI1cB9CTa9RJe
         rdF5AJyBMeo9givVj5pPBZhSnvfUpmDftSvib/l5H4aYUwsgRNvfsoUV+ktveu54j08F
         bYfw==
X-Gm-Message-State: AOAM532t27XBDnlz9fKJQRqWFiDfeVTmIjJl0YrFZj2LFGiVYw3njgdZ
        YT6G4VXn6IiQZel9jB7pJp9xEVkETO8=
X-Google-Smtp-Source: ABdhPJzjMdkrrpCMHW3hDXknHyl2LOjnQRzu8kaVy2jXo+ToqPsb7HuEEUo2/+DWqtz2/ef0kZ9tuQ==
X-Received: by 2002:a17:90a:4313:: with SMTP id q19mr1262817pjg.158.1619473013925;
        Mon, 26 Apr 2021 14:36:53 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id r1sm492609pjo.26.2021.04.26.14.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 14:36:53 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM STB AVS TMON
        DRIVER), Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        linux-pm@vger.kernel.org (open list:BROADCOM STB AVS TMON DRIVER),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH] thermal: brcmstb_thermal: Interrupt is optional
Date:   Mon, 26 Apr 2021 14:36:46 -0700
Message-Id: <20210426213647.704823-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Utilize platform_get_irq_optional() to silence these messages:

brcmstb_thermal a581500.thermal: IRQ index 0 not found

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/thermal/broadcom/brcmstb_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
index 8df5edef1ded..0cedb8b4f00a 100644
--- a/drivers/thermal/broadcom/brcmstb_thermal.c
+++ b/drivers/thermal/broadcom/brcmstb_thermal.c
@@ -351,7 +351,7 @@ static int brcmstb_thermal_probe(struct platform_device *pdev)
 
 	priv->thermal = thermal;
 
-	irq = platform_get_irq(pdev, 0);
+	irq = platform_get_irq_optional(pdev, 0);
 	if (irq >= 0) {
 		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 						brcmstb_tmon_irq_thread,
-- 
2.25.1

