Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D89D4DE86
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2019 03:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfFUBUO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Jun 2019 21:20:14 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:36560 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfFUBUO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Jun 2019 21:20:14 -0400
Received: by mail-vk1-f201.google.com with SMTP id r197so1939074vkf.3
        for <linux-pm@vger.kernel.org>; Thu, 20 Jun 2019 18:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sZPDagH2N6OInO/tFeMg9JGeODlstxnUOt5waxS+/Vg=;
        b=pHH18yoAvnmfW2qvCxuOEiD2FV/+42fWKCvrpZZu8PPhOc9gYupxE7PK6VpLmLQXUU
         fve//NFkOKVWipooUBEnA3UcVzYHXWHFA03vNawm1eIL/hRriG8rI4pyD1VJdMiEJqZ8
         80BEkDl7fWc5uJnNPpj/k+AzYjq/FMeNUF2Z5fTF7XHJdfi2rOzjvKpjlcQFPRd/3wr2
         QirOfocXpfj5d2J3a+xkXF0J8R5o3pIsDbCwMiw5l1FgVBqeBAZ7mzDeR2s80FZYb/CK
         wHA8vGJZMP21IqcWXFBAXYdudMiW7M/o0z+aQXYnQOjnTbV8Ev4KFD8GEpSTuHMRcwT0
         mINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sZPDagH2N6OInO/tFeMg9JGeODlstxnUOt5waxS+/Vg=;
        b=AjIvvHWhtXUExCFsD9BMUkvPF4gciyLlFp01n1R4VM1hfRYst8oSZgP/7xrltnimS6
         h73EYLrh/J8yZrNYFP7eS87qnfYdbck2rrDZqZVGvvrY+mGAFSXQjpNUkVyjgo0qer4f
         +vmdJQzp5A1QtCWy+3lt7Nbnh9fZRLdxpOJPo7/hnyBrxE0Mluq4DnQVmWn+BdAO4wk5
         H9K0ucZbxzt3HyUkRSF/XjsWc0enjL6Jpwf11XGq0HXXFksJ6omWk05NkXPY7F8CNjea
         vlleMdpJ7nXE2PwbGvE5/tWJ1uSVhw+YdEeDudCQQaim8vW9ve5x+SAEB/kBB7zUsrhL
         kymg==
X-Gm-Message-State: APjAAAX+Degp0qtPur50kcW78T5H0Vyh5FiJZ3WV+RSAqyD5uYjV8LG4
        Dr/bEIl0o83VdXFTO2FzbHbiivCxSjqQMcQWD6Ytzg==
X-Google-Smtp-Source: APXvYqxckCwmVhY53ts462jqSAK1H90HXXRRUJIVr6hr3RrpbKSlGb9nn3biH5pst2z8ewo9K52wgg7v3ry/ZnfMXaIzJg==
X-Received: by 2002:a1f:23d6:: with SMTP id j205mr8388245vkj.52.1561080012958;
 Thu, 20 Jun 2019 18:20:12 -0700 (PDT)
Date:   Thu, 20 Jun 2019 18:19:21 -0700
In-Reply-To: <20190621011941.186255-1-matthewgarrett@google.com>
Message-Id: <20190621011941.186255-11-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V33 10/30] hibernate: Disable when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Josh Boyer <jwboyer@fedoraproject.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>, rjw@rjwysocki.net,
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
Cc: rjw@rjwysocki.net
Cc: pavel@ucw.cz
cc: linux-pm@vger.kernel.org
---
 include/linux/security.h     | 1 +
 kernel/power/hibernate.c     | 4 +++-
 security/lockdown/lockdown.c | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 2d3c69b9fd04..deac722f0d86 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -85,6 +85,7 @@ enum lockdown_reason {
 	LOCKDOWN_MODULE_SIGNATURE,
 	LOCKDOWN_DEV_MEM,
 	LOCKDOWN_KEXEC,
+	LOCKDOWN_HIBERNATION,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index abef759de7c8..5804ffeb8622 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -32,6 +32,7 @@
 #include <linux/ctype.h>
 #include <linux/genhd.h>
 #include <linux/ktime.h>
+#include <linux/security.h>
 #include <trace/events/power.h>
 
 #include "power.h"
@@ -70,7 +71,8 @@ static const struct platform_hibernation_ops *hibernation_ops;
 
 bool hibernation_available(void)
 {
-	return (nohibernate == 0);
+	return nohibernate == 0 &&
+		!security_is_locked_down(LOCKDOWN_HIBERNATION);
 }
 
 /**
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 94af1c3583d8..42b7bc467ef6 100644
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
2.22.0.410.gd8fdbe21b5-goog

