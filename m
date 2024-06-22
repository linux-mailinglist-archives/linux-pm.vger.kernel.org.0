Return-Path: <linux-pm+bounces-9809-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A8791340E
	for <lists+linux-pm@lfdr.de>; Sat, 22 Jun 2024 15:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 204E4B2295D
	for <lists+linux-pm@lfdr.de>; Sat, 22 Jun 2024 13:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C37D14E2C2;
	Sat, 22 Jun 2024 13:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWjgqTvh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DCDB67D;
	Sat, 22 Jun 2024 13:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719061283; cv=none; b=AdqQvJUGZLuAdRurgpZa+mU1v2ZXDsb8m43BW/exl0xrR2jadQjtyNjFm5LLAfvfc4bcVpl9iSkRBUszCFOdHlbAlnPujN+V745DojRxww8i/0ynkOMlb93MA4AfHUvzx0/AehrHMHg4CVofyi9MphNkCIpZ5STl4hefQjpQtG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719061283; c=relaxed/simple;
	bh=ol+zGZiWM1DKuT5zahghz+wU4aJwG4tjLHjAz8moIsM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oCTjmcyhT1bruBr3S5UUF/1KZLhrtVIAmsAP6k0B/PPPzHck3Wo9JfLP0a1huj708nruPztI7ksCzRvn+uzf0DKRtQlanJsjD+VDD8trrxbEWO69tpm/97Vn6+g1SNwYbxCN39buOIPamM7+VoYZ/5LVtQM4mDz89KYiMA2niRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWjgqTvh; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a63359aaacaso427293866b.1;
        Sat, 22 Jun 2024 06:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719061280; x=1719666080; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=71HCn4pM6lNH1TSuaduFc92zwHDPMLbUYJs68bSQmlY=;
        b=QWjgqTvhUcTgApdIAU7E/mBUIAE8SpP2a+GNOjJr0NWUc/wldBbMCuN8ukE4XdCYKg
         I1ZOj1o2ikOzpwzaQzqxF8iUUFx3mlHKLF79kIlOPCLu/kshsVza4FNTkhDwdeD8L3Mn
         +TeaFZ4H0jHIJshKbNGTx9zlOlZmqapMA7BMjm3z48DABZwQAzxxwQzTNtrlcdUJBHV2
         UwExl/lsdJy736pdezUpiL0/QK3+cnxBjPa0Udlp8xsZuqv272meg8C20nJyXE8pBic6
         acIpU49kb437816KbvrB3xFKYZCYLeDjEd/z7D2Up/JyzNS5yjXvnD40Kyu8L0vtIJg7
         28bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719061280; x=1719666080;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=71HCn4pM6lNH1TSuaduFc92zwHDPMLbUYJs68bSQmlY=;
        b=GkUq7NdINrNXC6+BnZlM4Aw4VEpSYD5d7GH4kipusOVaSIXE22YS3TWYOcVmKAnHFn
         aUBz4TEcLIz0wRZ7bFLcyV/tuBVkMlCn5Jziiq60kl4PTZFzGT4aCqRNqbvx9py+cnXr
         MzCJwO2gnEtgy8lbBiuH+nqO6qhY6PaAGlaYVzLl9KlwkE65Zrh52m7pOvolKFa+epoM
         WZWj19fCj9ulgQKiCgIWetOzPrWqaZN3/oVEmgbLwUC1ujH/AazzIf8zTLCAwCW1jLG3
         57V/Aowpu3Z0AHJXN5pfM7qaoH5wCHSEkM9sTAlYZEZ7g6QJe7zm6H6dl/UemwMfBGcc
         vLHg==
X-Forwarded-Encrypted: i=1; AJvYcCVRlTnv9HjWnPtujLyEc1jtWDMEhg+b8VYTfNhJCPfACTJ8grW5ahvKUs9omX1YER0ziXMiWYvFabLu7Bujk4LC72ZjSBg4rznyiK+gcVcKDLvOtocb7Iq3BkNRsARwxWaTPZWoe48=
X-Gm-Message-State: AOJu0YwG3xR0Z61w3pPiBBfroPjmI0/LkMPXy2tSXH9ElVByN8pSdqys
	RLw4u4GG5gX2fpvUzd89IC9n/6PkfZOXELeoFk2qPtUHiFA7pGJO
X-Google-Smtp-Source: AGHT+IGzCCmzYTaJI/Ajs079t6qeRBMAuK4TtFbQkCzQk/kxTFSgjkEOw+iHy0pz6A0nPfLdksSbmQ==
X-Received: by 2002:a17:907:104a:b0:a6f:13fe:75d1 with SMTP id a640c23a62f3a-a6fab7cf96dmr655611666b.64.1719061279681;
        Sat, 22 Jun 2024 06:01:19 -0700 (PDT)
Received: from [127.0.1.1] (31-179-0-202.dynamic.chello.pl. [31.179.0.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf560526sm193940766b.152.2024.06.22.06.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 06:01:19 -0700 (PDT)
From: Roman Storozhenko <romeusmeister@gmail.com>
Date: Sat, 22 Jun 2024 15:01:07 +0200
Subject: [PATCH v2] cpupower: Make help command available for custom
 install dir
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240622-fix-help-issue-v2-1-6c19e28a4ec1@gmail.com>
X-B4-Tracking: v=1; b=H4sIABLLdmYC/13MQQ6CMBCF4auQWTumrbVYVt7DsKAwwiRASatEQ
 3p3K3Hl8p/M+zaIFJgiVMUGgVaO7Occ6lBAOzRzT8hdblBCaWGkxTu/cKBxQY7xSXguT60Wzhm
 tSsijJVD+2MFbnXvg+PDhvfur/F5/lJL/1CpRYmmFsfbSaUPu2k8Nj8fWT1CnlD7Ap4KMrAAAA
 A==
To: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Roman Storozhenko <romeusmeister@gmail.com>
X-Mailer: b4 0.14.0

When the 'cpupower' utility installed in the custom dir, it fails to
render appropriate help info for a particular subcommand:
$ LD_LIBRARY_PATH=lib64/ bin/cpupower help monitor
with error message like 'No manual entry for cpupower-monitor.1'
The issue is that under the hood it calls 'exec' function with
the following args: 'man cpupower-monitor.1'. In turn, 'man' search
path is defined in '/etc/manpath.config'. Of course it contains only
standard system man paths.
Make subcommands help available for a user by setting up 'MANPATH'
environment variable to the custom installation man pages dir. That
variable value will be prepended to the man pages standard search paths
as described in 'SEARCH PATH' section of MANPATH(5).

Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
---
Changes in v2:
- Fixed spelling errors
- Simplified man pages search approach by the 'MANPATH' variable usage
- Link to v1: https://lore.kernel.org/r/20240621-fix-help-issue-v1-1-7906998d46eb@gmail.com
---
 tools/power/cpupower/utils/cpupower.c | 41 ++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/tools/power/cpupower/utils/cpupower.c b/tools/power/cpupower/utils/cpupower.c
index 9ec973165af1..1b1b79c572ad 100644
--- a/tools/power/cpupower/utils/cpupower.c
+++ b/tools/power/cpupower/utils/cpupower.c
@@ -12,6 +12,8 @@
 #include <unistd.h>
 #include <errno.h>
 #include <sched.h>
+#include <libgen.h>
+#include <limits.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/utsname.h>
@@ -80,14 +82,17 @@ static void print_help(void)
 
 static int print_man_page(const char *subpage)
 {
-	int len;
-	char *page;
+	char *page, *man_path, *exec_dir;
+	char exec_path[PATH_MAX];
+	int subpage_len;
 
-	len = 10; /* enough for "cpupower-" */
-	if (subpage != NULL)
-		len += strlen(subpage);
+	if (!subpage)
+		return -EINVAL;
 
-	page = malloc(len);
+	subpage_len = 10; /* enough for "cpupower-" */
+	subpage_len += strlen(subpage);
+
+	page = malloc(subpage_len);
 	if (!page)
 		return -ENOMEM;
 
@@ -97,6 +102,30 @@ static int print_man_page(const char *subpage)
 		strcat(page, subpage);
 	}
 
+	/* Get current process image name full path */
+	if (readlink("/proc/self/exe", exec_path, PATH_MAX) > 0) {
+		exec_dir = strdup(exec_path);
+		if (!exec_dir) {
+			free(page);
+			free(man_path);
+			return -ENOMEM;
+		}
+
+		/* Prepend standard search path for man pages with relative path
+		 * to custom install man directory
+		 */
+		if (asprintf(&man_path, "%s/../man:", dirname(exec_dir)) > 0) {
+			setenv("MANPATH", man_path, 1);
+			free(exec_dir);
+			free(man_path);
+		} else {
+			free(page);
+			free(exec_dir);
+			free(man_path);
+			return -ENOMEM;
+		}
+	}
+
 	execlp("man", "man", page, NULL);
 
 	/* should not be reached */

---
base-commit: 2102cb0d050d34d50b9642a3a50861787527e922
change-id: 20240619-fix-help-issue-573c40bb6427

Best regards,
-- 
Roman Storozhenko <romeusmeister@gmail.com>


