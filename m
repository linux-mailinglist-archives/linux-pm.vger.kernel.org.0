Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F48EA6969
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2019 15:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbfICNMj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Sep 2019 09:12:39 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39796 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728854AbfICNMj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Sep 2019 09:12:39 -0400
Received: by mail-pl1-f195.google.com with SMTP id bd8so1553328plb.6;
        Tue, 03 Sep 2019 06:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Oyzje1d/Yp6dp7EJioGtvOkl1us11NkLYeaDJjiD9GM=;
        b=cKiqb3gyADk+aCJu7IOs8iEgDQUYXluRKjO+di3+uHqQil066X+3EUm51TI8r17m7x
         NyzxcR9A5Yy0DyJtgxcNocPH42Gf4E2DUG7PK+e6D9tujIDNL17+QRoy+cgv7PzCzUqz
         Kx6xuuq0pCT5PhJYDNhBFLsbA7nnFx/Wsk5bHg7eZrQLDTAOX6xRVISxbNrEvSSHSh5Y
         okD2HoBLiCEhNkUVxSxnEtKgjG9u5cnrY4ilZeLioTaPHZk7UsW5iKcw4eTDDX7dWhJH
         yVGQw9tiyyh0Sz1wWbWGYh8AgBEWWKUMAjKT/i38jf9LwURzuJS+bFiuTsw35J4b63Z2
         idEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Oyzje1d/Yp6dp7EJioGtvOkl1us11NkLYeaDJjiD9GM=;
        b=RJDRq1DYMqAVY2CUXj4RdAG3WHz7qHIUQ6o4FoQTFnWUjam7rzsUjfBznx/Lj5/Biw
         QPcfWMjLAeKnWXurjnMBvbBUdP0uEU9BA3DMMkF8z9Pg52wfHq3OoAH1iGqyWxkkRSDo
         1Z0XJk8ZDuvr4Za56YA/LHO/nYhkN8yia1JV4q/szNu0ccH2nEI/6op9eG3spCCAvUFa
         mQ1jz7n9DG8gDU+IjcZtHM+aigo7+af8MqGCWLhhCMKbHjOoZEqtmuS+Sdr3rOYp0SeZ
         /WsqpZnHUJzTDLxzST/NjtZlHGQJDpt6zZhTfvqPyoxTwi8xKb2Zz9dOA47RxPSE9gRl
         cCdw==
X-Gm-Message-State: APjAAAWuZMlVB09Q/zxXHmyDrzvdM2v92Zf4Kb7YLGY9m4LDI5uoiaOk
        WDDfTEs0ZrOOGqYMAYnZuSNZdkCU7s8=
X-Google-Smtp-Source: APXvYqwNwfUOJxTNPaZLdHPRdKE/4TFVjuEc1qWSovceJyDRuA5nM2pZrVLw6T8ZE+sLds08UA396Q==
X-Received: by 2002:a17:902:e68f:: with SMTP id cn15mr35725292plb.212.1567516358873;
        Tue, 03 Sep 2019 06:12:38 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:c96a:23e0:ac2a:c9f5])
        by smtp.gmail.com with ESMTPSA id 69sm19769823pfb.145.2019.09.03.06.12.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Sep 2019 06:12:37 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2] PM-runtime: Documentation: add runtime_status ABI document
Date:   Tue,  3 Sep 2019 22:12:22 +0900
Message-Id: <1567516342-5939-1-git-send-email-akinobu.mita@gmail.com>
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
* v2
- Change the contact person

 Documentation/ABI/testing/sysfs-devices-power | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-power b/Documentation/ABI/testing/sysfs-devices-power
index 80a00f7..1763e64 100644
--- a/Documentation/ABI/testing/sysfs-devices-power
+++ b/Documentation/ABI/testing/sysfs-devices-power
@@ -260,3 +260,12 @@ Description:
 
 		This attribute has no effect on system-wide suspend/resume and
 		hibernation.
+
+What:		/sys/devices/.../power/runtime_status
+Date:		April 2010
+Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Description:
+		The /sys/devices/.../power/runtime_status attribute contains
+		the current runtime PM status of the device, which may be
+		"suspended", "suspending", "resuming", "active", "error" (fatal
+		error), or "unsupported" (runtime PM is disabled).
-- 
2.7.4

