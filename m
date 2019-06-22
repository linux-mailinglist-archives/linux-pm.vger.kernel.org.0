Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36C5D4F28E
	for <lists+linux-pm@lfdr.de>; Sat, 22 Jun 2019 02:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfFVAGi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Jun 2019 20:06:38 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:36870 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfFVAE1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Jun 2019 20:04:27 -0400
Received: by mail-pf1-f201.google.com with SMTP id x18so5321262pfj.4
        for <linux-pm@vger.kernel.org>; Fri, 21 Jun 2019 17:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=E1ydClCjIQanqkYubDCe4fTQ8CyYEUPCl76Zws+exX4=;
        b=Mw1nxxDCj3KPV9UNkkVTuYDyrqaNw9yfe8VMRM7ZPzqyoc628ni6A1ID84X/NQY/eG
         TjqgdDZ2eclCmQYBtR64hrRsKfdJ0/b2ea/MKIjVjf5Schmnsf9z4DGGkKrP3ZMtf/4Z
         5fExcPm/lB+/BHv/goxmhPnXnifnIxGZIkdJL93w+OXXSyC4vIJylekCmcsMP9+JbsT+
         gVi97q0IioDlBycYNesWz61vacRTWYh1YbLAOH7R2x6khfBxHVRBC8C//eYSarvexPeG
         Uo1SHVP2bSJa/A300oItLeqbJObzG1tatKWOxjfQ/shMDZS2UzCNHcLYt+NAQWt6dMzw
         3Daw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=E1ydClCjIQanqkYubDCe4fTQ8CyYEUPCl76Zws+exX4=;
        b=ekEBUicgAKii/FL1VxR+ctTJhZsfqLczJbynCmgQJYhIRUxQNi2+txEgZdhF+tNun/
         G0Yea9q7NmzFZId+f3IOw/qsexs9TQm5aKsQkrYPPI7Q0v7/lzGnphVExlBt/HMmL2j6
         DTRDWP4Qv7EKngQKbfBiRtnAyE1E3OXl1Vv/QmCRN2dPFL9pEv8xFzZBOf2WmpeTf/lb
         4LvYwTK3SMDz3F3wJsv5CbhxrAmO0wEi3unVIXNTxZZ5HQ5rbtf4XXoMB87bAOClr+b0
         4XJJWCAQQWwpOYmHLi2pZWEu0LauvT/SYnto7fsOKF2U9W6CLs6AqZAI3+Fwxlu0iDPY
         I1jQ==
X-Gm-Message-State: APjAAAURYb0FiaDhrBhoODFX4ExZmWvKvYHeCp/zeMvjVdOeK+YxKcAb
        5SVEejLpvD7W70YhNDTI3f5gmM8T6L+88bywN2IZxw==
X-Google-Smtp-Source: APXvYqzVsoigFEz9xV2syvjuZK/rAiWYW9AdGJzJFdfPo/qG/n7y42EqV0+KSVGLK/rbmx1Vz0/09WNn5tQlIgfdmqn5eA==
X-Received: by 2002:a63:e304:: with SMTP id f4mr20804148pgh.187.1561161866832;
 Fri, 21 Jun 2019 17:04:26 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:03:39 -0700
In-Reply-To: <20190622000358.19895-1-matthewgarrett@google.com>
Message-Id: <20190622000358.19895-11-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V34 10/29] hibernate: Disable when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Josh Boyer <jwboyer@fedoraproject.org>,
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
 kernel/power/hibernate.c     | 3 ++-
 security/lockdown/lockdown.c | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 00a31ab2e5ba..a051f21a1144 100644
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
index abef759de7c8..3a9cb2d3da4a 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -32,6 +32,7 @@
 #include <linux/ctype.h>
 #include <linux/genhd.h>
 #include <linux/ktime.h>
+#include <linux/security.h>
 #include <trace/events/power.h>
 
 #include "power.h"
@@ -70,7 +71,7 @@ static const struct platform_hibernation_ops *hibernation_ops;
 
 bool hibernation_available(void)
 {
-	return (nohibernate == 0);
+	return nohibernate == 0 && !security_locked_down(LOCKDOWN_HIBERNATION);
 }
 
 /**
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 08fcd8116db3..ce5b3da9bd09 100644
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

