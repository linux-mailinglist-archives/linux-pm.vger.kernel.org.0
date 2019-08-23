Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 716239A4E8
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2019 03:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732066AbfHWBbx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Aug 2019 21:31:53 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40185 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730934AbfHWBbx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Aug 2019 21:31:53 -0400
Received: by mail-pg1-f194.google.com with SMTP id w10so4757944pgj.7;
        Thu, 22 Aug 2019 18:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zbm2W6XHpS0o9PhGxMT9TLzTRXLWIz95ylnC0MpzjRg=;
        b=KZ677euCxtMab8taDO/wlSoAYq71OUSPix+KiHFb9O146idZumCItHZl2o9lIZ17jP
         kl/H8NZPklv75tjKVpUaKNdUkZp9w1U7YV2QMNYVIoMq+6uWI2lfvEtvaHuuIBNUiD02
         9hjCJvJO23ioQgBnebHP2B/0oArjBV9/7bEK4rOoL3+cZNX4pA1101oZv6M+ehMDFljS
         CnBcDpjVr/E1z+kqEPI2yGDU/0i+XftMx9fgbtoPIFVxZ4n43KkYuFmiMVHMX8WsZaVe
         Rt0Ij9T6CO1p53yk5T+j6Bu5Ei0zf8pmJENMi4WBAn4VxhQ5oNq3f1Hu+c5fb3XmNW6t
         AI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zbm2W6XHpS0o9PhGxMT9TLzTRXLWIz95ylnC0MpzjRg=;
        b=lUNkKc48VFFs6H23hmCy+a6Y8ChjJeSjdl27K3rWQYhGCaQpraSUalNsarGjarc7XK
         fcQmwUIW+pWJf+LXYjC0VLvIKL8c6kIR+elDHeg3E9y8oyVH9JLHaJy0mUslbRZCYzTo
         cyW71LMMf9FNKVzI4aEfaX89tr97L57s+LXfOwCztna3hqQ8wf5L7BoOqfKHSE7aE84P
         aP1xLnTDJfb68YwDeBeQYd2+Qgioy9FzLgtZ8JCY2P8uUOH18uZRG/bC8HM5veOhMSdy
         9+b03knRaYte3o8PQOaiTSOV/n/AhHpPp57MEosbPKdM4TcorX+xFzirj5npH6FXP3Bv
         kz2A==
X-Gm-Message-State: APjAAAVqtn5OahOz9VSQQ1YSBTeg5akPo4GztG2LWOtFrCljXNEic9BJ
        GGD021hd2krgLiIbEhLWvz4=
X-Google-Smtp-Source: APXvYqxAWiknUQM9s9bLrknCPab7TrgAbcx4NM00ohq5njwe2xBK3NtCB280gj8dVGMYoc1F6/fLVQ==
X-Received: by 2002:a17:90a:d793:: with SMTP id z19mr2613966pju.36.1566523912675;
        Thu, 22 Aug 2019 18:31:52 -0700 (PDT)
Received: from localhost.localdomain ([106.51.105.240])
        by smtp.gmail.com with ESMTPSA id v21sm636002pfe.131.2019.08.22.18.31.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Aug 2019 18:31:52 -0700 (PDT)
From:   Rishi Gupta <gupt21@gmail.com>
To:     rui.zhang@intel.com
Cc:     edubezval@gmail.com, daniel.lezcano@linaro.org,
        alexios.zavras@intel.com, gregkh@linuxfoundation.org,
        amit.kucheria@linaro.org, allison@lohutok.net, tglx@linutronix.de,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rishi Gupta <gupt21@gmail.com>
Subject: [PATCH] thermal: intel: int3403: replace printk(KERN_WARN...) with pr_warn(...)
Date:   Fri, 23 Aug 2019 07:01:42 +0530
Message-Id: <1566523902-9302-1-git-send-email-gupt21@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Direct invocation of printk() is not preferred to emit logs.
This commit replaces printk(KERN_WARNING) with corresponding
pr_warn() function call.

Signed-off-by: Rishi Gupta <gupt21@gmail.com>
---
 drivers/thermal/intel/int340x_thermal/int3403_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
index f5749d4..a7bbd85 100644
--- a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
@@ -181,7 +181,7 @@ static int int3403_cdev_add(struct int3403_priv *priv)
 
 	p = buf.pointer;
 	if (!p || (p->type != ACPI_TYPE_PACKAGE)) {
-		printk(KERN_WARNING "Invalid PPSS data\n");
+		pr_warn("Invalid PPSS data\n");
 		kfree(buf.pointer);
 		return -EFAULT;
 	}
-- 
2.7.4

