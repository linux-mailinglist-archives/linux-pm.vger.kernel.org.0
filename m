Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3439E9525D
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2019 02:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbfHTASj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Aug 2019 20:18:39 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:41674 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728988AbfHTASh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Aug 2019 20:18:37 -0400
Received: by mail-pg1-f202.google.com with SMTP id b18so3484086pgg.8
        for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2019 17:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dNVh2iEH8Vj5QaP2UTGBHWYWiLKLUyALWKFvKJ3rNPk=;
        b=s+DzVRUaCC07PkCzszpSdYfvTDGl8hxUTCDu/FpF5b4WNQAmCbk6BOrwtJXUoFR6Uz
         qKm/vW6UcajgcQNbuCy/wUqoTzb68lOw8pytLYFdDjt3L0bszBv6MJlhpX/W5PUC9TpY
         8AX7s/PxVrj8PbsOCZi0M6Dwr0BexH+KjnuS/B9q0DCyAkJ9k9Og7T4oCTwqUM3loX8X
         APyKduoOLI+CQCWk+EDINB1/1Sy/dGLCuGyBGFyMwA8wNU1tWivpS7m1mJNEdM/ahsl+
         888b9JvYy2AlusJGjtmnpS9xM8sUy6qm69rS3ahSS5Hw/shTovUguhjEUiK5vOG3eo0m
         1c+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dNVh2iEH8Vj5QaP2UTGBHWYWiLKLUyALWKFvKJ3rNPk=;
        b=czBxRm8bKxqpMfdU2VQoGaUtrpuPyF+GJGcQYn3h1rt5dciAtv8MgoGFBNk0RQ52pV
         61RGgw7ONHt7phvQDT58jC+RiDaeCj/7sbt1MonNJ/ggZTJy/EonEM+Dmfon5iXSrsVc
         kA6M1iaw/1fs12CbN5SVnkjyg9wM6udDOtonm+3ULFCNn6vUAgI15hshw0Iz2watC7fc
         2h+yf2T4rOBVRKZdS5oybmI4nxDzKr0zakyRTTe21kXq3t6//fssqrDlzBAqQkYCNEoF
         4cC3ODrGAAuRWTx/V8u+dKP/Z/G5f+ImMkM6tZiUpQGqV0H89QQsjw2pngidBXfy24Ho
         YYyQ==
X-Gm-Message-State: APjAAAWW/mGnMypCRH0fqxCHORGRSVPX5VXIHD/NyhyadsaxNw5FkFuD
        tq+/Cfi7TfEeNq/EkCR7rFwiNi2Mjr/01cjP7JTtFg==
X-Google-Smtp-Source: APXvYqw50UpcJtkF5rTCGf6S95KEpqO+4K8LOnMXigUv6lRcqmdRjDrchpQ3c4/aZXcS0zPEWytHlafdl8iJSlsaMVhMZg==
X-Received: by 2002:a63:e48:: with SMTP id 8mr21980312pgo.389.1566260316132;
 Mon, 19 Aug 2019 17:18:36 -0700 (PDT)
Date:   Mon, 19 Aug 2019 17:17:46 -0700
In-Reply-To: <20190820001805.241928-1-matthewgarrett@google.com>
Message-Id: <20190820001805.241928-11-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH V40 10/29] hibernate: Disable when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Josh Boyer <jwboyer@fedoraproject.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>, rjw@rjwysocki.net,
        pavel@ucw.cz, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Josh Boyer <jwboyer@fedoraproject.org>

There is currently no way to verify the resume image when returning
from hibernate.  This might compromise the signed modules trust model,
so until we can work with signed hibernate images we disable it when the
kernel is locked down.

Signed-off-by: Josh Boyer <jwboyer@fedoraproject.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: rjw@rjwysocki.net
Cc: pavel@ucw.cz
cc: linux-pm@vger.kernel.org
Signed-off-by: James Morris <jmorris@namei.org>
---
 include/linux/security.h     | 1 +
 kernel/power/hibernate.c     | 3 ++-
 security/lockdown/lockdown.c | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index b607a8ac97fe..80ac7fb27aa9 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -106,6 +106,7 @@ enum lockdown_reason {
 	LOCKDOWN_MODULE_SIGNATURE,
 	LOCKDOWN_DEV_MEM,
 	LOCKDOWN_KEXEC,
+	LOCKDOWN_HIBERNATION,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index cd7434e6000d..3c0a5a8170b0 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -30,6 +30,7 @@
 #include <linux/ctype.h>
 #include <linux/genhd.h>
 #include <linux/ktime.h>
+#include <linux/security.h>
 #include <trace/events/power.h>
 
 #include "power.h"
@@ -68,7 +69,7 @@ static const struct platform_hibernation_ops *hibernation_ops;
 
 bool hibernation_available(void)
 {
-	return (nohibernate == 0);
+	return nohibernate == 0 && !security_locked_down(LOCKDOWN_HIBERNATION);
 }
 
 /**
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index aaf30ad351f9..3462f7edcaac 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -21,6 +21,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_MODULE_SIGNATURE] = "unsigned module loading",
 	[LOCKDOWN_DEV_MEM] = "/dev/mem,kmem,port",
 	[LOCKDOWN_KEXEC] = "kexec of unsigned images",
+	[LOCKDOWN_HIBERNATION] = "hibernation",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.23.0.rc1.153.gdeed80330f-goog

