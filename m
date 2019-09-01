Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBF8A49BF
	for <lists+linux-pm@lfdr.de>; Sun,  1 Sep 2019 16:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbfIAOJJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Sep 2019 10:09:09 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:42557 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfIAOJI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Sep 2019 10:09:08 -0400
Received: by mail-pl1-f172.google.com with SMTP id y1so5379841plp.9;
        Sun, 01 Sep 2019 07:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KF+zGa6kDBGyIzjB8q6ncJTi5g5RmfTkgmRl7beZwwE=;
        b=qyu8f5kYlF1g6yzHHH7wODDMxBMLxMXfcE46hLBPz4jgspzMG1s0DX9ex7tz3h9OOh
         9ixr5QOrsKonTf/dsJ0AsJPLfyxOQbAjTOKBvTp75nGp9S+XQZnGhiPcbDO+XsxwJrv0
         /LrAqzJfaWPDUbiC+cg44MuL1iCmYPXr1zbi+Eapff9gwVIp4FGRUNgFBLELzZl2hj0P
         Pa+0swR3Uij6U0FT8hi9lLQYW+agbh8Ac5D0ccG7aa3CodIlsDUrv+kYhmua+mFqg2Qk
         w1wn4Ab+gx/KjFwBT/Eg0ac8DrTITtNKSJBrql1eUbS/+aXIM2JShdnoTE5x+4+iA3p9
         or1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KF+zGa6kDBGyIzjB8q6ncJTi5g5RmfTkgmRl7beZwwE=;
        b=RACDXf5cfgHxC2zth15w2IDwEHsC5rZSRL0ZaxsuIXWwt6U5f5+89UNex//+OSNudR
         1ZACYCCYbyyK/qfakX83UrLf21HJ9j86SiFZbc7pP+1NgmBKaTZoDU8kgjvs+yG/hilm
         ZCOvnFvK9213D2I1vUBA9ZBSjXB8dZoctKda3IRDIk7oKjRxfEzGILTx3ZsMCdlLYypj
         W45rEjteXIe68xZMBLPew+/v1AocxbKPVDxnriswRfBvBYOv5kT610Kfm9aS6dHi2sDp
         pTn43sOuJR0XO8ClSwRGeS2yQVUUKc6LXfNlhhjkxXFbcfqG1qq9qNtGBJISXCwZWpLE
         lUjQ==
X-Gm-Message-State: APjAAAXNX8pRoXHnFiygX88Px1NganHHk2aDPCFgTvt6JcZyfS1RCqmZ
        8qvRgbpMVTTV4hkkmTJd+CtptgNvZjU=
X-Google-Smtp-Source: APXvYqwWCCvtRgfSXgex7RNJYVyPbn3CTwgyrCFp1ycPJ2xl2B4CySORxNyZ09xlB+JBSivP+rZyFw==
X-Received: by 2002:a17:902:fe01:: with SMTP id g1mr24916707plj.154.1567346947952;
        Sun, 01 Sep 2019 07:09:07 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:90ef:3420:44ea:a84])
        by smtp.gmail.com with ESMTPSA id c1sm11985651pfd.117.2019.09.01.07.09.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Sep 2019 07:09:07 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/2] PM-runtime: Documentation: add runtime_status ABI document
Date:   Sun,  1 Sep 2019 23:08:51 +0900
Message-Id: <1567346932-16744-1-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

/sys/devices/.../power/runtime_status is introduced by commit c92445fadb91
("PM / Runtime: Add sysfs debug files").  Then commit 0fcb4eef8294 ("PM /
Runtime: Make runtime_status attribute not debug-only (v. 2)") made the
runtime_status attribute available without CONFIG_PM_ADVANCED_DEBUG.

This adds missing runtime_status ABI document.

Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 Documentation/ABI/testing/sysfs-devices-power | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-power b/Documentation/ABI/testing/sysfs-devices-power
index 80a00f7..3e50536 100644
--- a/Documentation/ABI/testing/sysfs-devices-power
+++ b/Documentation/ABI/testing/sysfs-devices-power
@@ -260,3 +260,12 @@ Description:
 
 		This attribute has no effect on system-wide suspend/resume and
 		hibernation.
+
+What:		/sys/devices/.../power/runtime_status
+Date:		April 2010
+Contact:	Dominik Brodowski <linux@dominikbrodowski.net>
+Description:
+		The /sys/devices/.../power/runtime_status attribute contains
+		the current runtime PM status of the device, which may be
+		"suspended", "suspending", "resuming", "active", "error" (fatal
+		error), or "unsupported" (runtime PM is disabled).
-- 
2.7.4

