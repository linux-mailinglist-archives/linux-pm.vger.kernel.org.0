Return-Path: <linux-pm+bounces-10096-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A3891A0C8
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 09:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BD54282B7A
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 07:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C815C4D599;
	Thu, 27 Jun 2024 07:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8HjsznB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D926F06B;
	Thu, 27 Jun 2024 07:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719474586; cv=none; b=PY2UH9mfZ259WOcHa+hDJHYMkY+NklPEM1epqy77AiSftGR47aAB7MM4eoM/7OxmElIc6JTuPSdR2U1Tc/m2E5UNb6+nW7CBc/kuWjssacHqzg3WxxjZ2BFT9iZyZuBSaIEWqDF5aQM/BFRXKRsn37KSyqKIpUTuIBNNV0n5nwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719474586; c=relaxed/simple;
	bh=VBS7l1Y6dpKRf25Fksk69nla/+FiUOCdcDC4whXK0rc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CPzCji9Q1x2NAVp5+jmf1k25KlhAm4O45UspNxPmYuFuRrzIax79jZQpPZbtYQBR2oOyZIIaDGE5zpuy38f2DF/W6OACH5NCOWYcDAlRVNy/IuKODbBjzVSBFfhmvLZB3buNq5mfpsGTnPdQUyAvi/99OL3k02yuIeRU2EX/KKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8HjsznB; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57cc1c00b97so1270649a12.0;
        Thu, 27 Jun 2024 00:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719474583; x=1720079383; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7ZyQRaSSQ/7eqGphUQHmgx4BtgjEMaKDZJG4UeoRumc=;
        b=l8HjsznB2/J6YCePl+J4tnMlykZa0PuOmg9NwiOReqWeSyZDpLiKg7n4pYsPDUrQBf
         QiewlcyXgtzdt0kvIUjFp7Pki4pEOpglqoQBJSPhL953kie1GB8FAU6GPOztAK5eXgBC
         TXrNzBEI4cwLBhT1UTRm/OhwCtChLbrmdMctlAxm6dz8NEDaTmmufnXwT9deXrrmOdnS
         ZryfHjs/e7EU2opKgqgjINGjjIxH6Y1KOrpsVL4vsiA5LivyX3Efvb/KnwORCj+j8+Jn
         yDd/QFxCB2Hur+lF51GMMi7/dViDPnAZtn9nIjpjleX15RhJQCqCqiAP9b7Sj5vtakZ0
         wemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719474583; x=1720079383;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ZyQRaSSQ/7eqGphUQHmgx4BtgjEMaKDZJG4UeoRumc=;
        b=bhV2TEQHcH7YhJmL+E6nOeOf8bc8l+ZIGnbCaYvmPKI2LvODhQjrggqlXrK5etUPBU
         QWEQwBn97/SdE5LOV+ObzH+RunkFy+YfWYquptXmZNEk1/aZNh4JDDDa7I7oWrfWWbLb
         70EZVj3KkM1rCCXbefcPvxAkPuKZD/OOR+7KYTAYrxAkx3zIsuR4LBrB+dMUfeigtgt5
         /Rk4XUBthxLUl9QWdKSuXkIFE/i5e6VMg2LtwJMEPGHi5V5noTuhPnUVGMlVWZ+G7Jr7
         LbUy8H3YupYzg/LnQ42IMfRFlAaAweXFuziFPQm2jIrTfIDeumma6WsnOQed9EK/s7Mk
         RcTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCO4tX1QAJ8Emvr3kSWnxqxCYU0tgMaBWDDM7H/2hqWNb0We5WeOKmPxCGIWDXMZTFin64dcjJLwCbWgXLyXq9DHLFRNl91EAb3F1TjKiUdHm6Wb8z07JMJoduj9mXwIUKacq7II8=
X-Gm-Message-State: AOJu0YzPazLYxNBpyGe3mb1cBBFxSLX6DzRdeN1PiZwMu0MjqlO9q0az
	s69cQT+xNZVcjSPMMS9BZiakdUU8D21CmMjq704e7DZYJ8Te79zg
X-Google-Smtp-Source: AGHT+IGmcSIdBDRM7NegP0Vcar8hMssKT6SQ76fvSOj3wlrFGrJq/83LAUv7P2esZ9dqCt0fukpn+Q==
X-Received: by 2002:a50:8d50:0:b0:57c:677a:a941 with SMTP id 4fb4d7f45d1cf-57d4bde097amr8015583a12.40.1719474583052;
        Thu, 27 Jun 2024 00:49:43 -0700 (PDT)
Received: from [127.0.1.1] (31-179-0-202.dynamic.chello.pl. [31.179.0.202])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-584d0c9ddadsm526447a12.2.2024.06.27.00.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 00:49:42 -0700 (PDT)
From: Roman Storozhenko <romeusmeister@gmail.com>
Date: Thu, 27 Jun 2024 09:49:37 +0200
Subject: [PATCH v3] cpupower: Make help command available for custom
 install dir
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-fix-help-issue-v3-1-85318a3974e4@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJAZfWYC/2WMwQ6CMBAFf4X0bE271EI9+R/GA5QVNgFKWm00h
 H+3EA9Ej/PyZmYW0BMGds5m5jFSIDcmyA8Zs101tsipScxAgBJaGn6nF++wnziF8ER+KnKrRF1
 rBQVL0uQxPbbg9Za4o/Bw/r31o1zXbwrkbypKLnlhhDambJTG+tIOFfVH6wa2piLsdfjTIenaS
 oNQVgqt3OvLsnwAryWk4+sAAAA=
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
Changes in v3:
- fix: append the previous value of "MANPATH" to a new one instead of
  its replacement
- Link to v2: https://lore.kernel.org/r/20240622-fix-help-issue-v2-1-6c19e28a4ec1@gmail.com

Changes in v2:
- Fixed spelling errors
- Simplified man pages search approach by the 'MANPATH' variable usage
- Link to v1: https://lore.kernel.org/r/20240621-fix-help-issue-v1-1-7906998d46eb@gmail.com
---
 tools/power/cpupower/utils/cpupower.c | 43 ++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/tools/power/cpupower/utils/cpupower.c b/tools/power/cpupower/utils/cpupower.c
index 9ec973165af1..a7777e693fa7 100644
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
+	char *page, *man_path, *exec_dir, *man_env;
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
 
@@ -97,6 +102,32 @@ static int print_man_page(const char *subpage)
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
+		man_env = getenv("MANPATH");
+		if (asprintf(&man_path, "%s/../man:%s",
+			dirname(exec_dir), (man_env ? man_env : "")) > 0) {
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


