Return-Path: <linux-pm+bounces-9742-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73017911E59
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 10:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4C3E1F20E38
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 08:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0005616F843;
	Fri, 21 Jun 2024 08:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTd/qoj+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D80083CDA;
	Fri, 21 Jun 2024 08:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718957596; cv=none; b=GNexAO7A9+khP+Y5ACFZr6OJWSUIZrqO69kc8eLRHfAXtF5dnCYyQ9toPXwMFlE+7HxWq3byo+4+U0YYTZfKHpQrBtYAioULz1hGWFWDr9MONMGnTSPGINrV8g4SVZ/YSE3OeLBM+d/9O2clWgkEny4kH3HnOo4MqFXwiZ6fCXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718957596; c=relaxed/simple;
	bh=8+VZHTU2jFGo52Yyrj/mk50mKDw9czDVv92M41YAUd8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oKxXdFkFMCNtB4Vh0mWkJa9oN/ANstY6yRbo1x45Qt+le1iLpD0mVZQER9YYjvL3vFphbO7n3diQew3xzOe+dTVTb/JePD4dr6mZsxx2W6wFH/HwelQ/GoAozpEwLMsHkuLVduJT11XU/hNJQIwus+lyLpSwmEyinkYowdy153k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTd/qoj+; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a6f09b457fdso177852366b.2;
        Fri, 21 Jun 2024 01:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718957593; x=1719562393; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1sN2kaOXNFqFWe9kiqdAd1f/ImH+CzYIHZyEKRSmTnc=;
        b=UTd/qoj+7663XtYIgub4g5w31RSN36/zvkS3MBKtzYPdpAXCbALxMteDmM1FG3bHFb
         G9K0zCRkI6scz44KT+SFInpt0DFuaF26UZ+F1evYDZbVZd8lSMIC/64b+D3ZS1RPmBVr
         ibgnydYW9oPUt7o78+GrBcHKHSbOfBdaUCnydKStd2ba++XrUgM1UbA1dboHA3Wyd9dI
         Kr+XLg6/40VSOs8OdR7SBAuB6R/g3iSvpZ1s/HW9vMC6xsIrtylVoNy6cptJTtixsArx
         S3CMcFm6Uhh6uf7YBsuITzJjisUUdVHLwtodJ02DB0uoSTyPiYCxjTsq0l59pBd6a+bE
         Mypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718957593; x=1719562393;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1sN2kaOXNFqFWe9kiqdAd1f/ImH+CzYIHZyEKRSmTnc=;
        b=fPlRwnxHoopldRK0SN9Z5Mf3Ydempouh3cLtviHE+loU/By27tSFaGwkQQPx5VGnyp
         7nzP6rOVS0KNTmrg6QSqjrKMOseufHcswH3+bbfuCaOTHH3a+OWa6BEMdjJxCR1NeEZe
         mCCVWMtBmpYpr+7IDt37zD595NFhKvbdksL3tBS/Oqg+SxMHT4xG71xgIuc61q1dvRK1
         613JeDa91ts0MPnL0KCEsELq88F4j/ZGTDzFaAHLTXd2RA3bIHidNldJoCIdxLzVBVYI
         7lLkHuARrGnykoXG/QlCbNz8Sa1n4P6oOmV/vefl1HCwIn8Y4CO2CHFK4m8mplK4VTuM
         u+zA==
X-Forwarded-Encrypted: i=1; AJvYcCURac45r74q0j5hhyzPZwqtbdyWeOn85CVJMyd/i4WSwTxbb/QWIc45AI/3DHrPcaLyTpYIPMqlMjE8TS3KnUiPnzsciw8V8e56oOGefLaRh5GRTjyp3lrS3z/100VtIbJbggKkvFQ=
X-Gm-Message-State: AOJu0YxtGl93ACzkQfaDKAegdMmplRUalGKwtCgthGc3BBE06DbdQJ4l
	hdZywE444jJF+50iYiLyDVxFcJtTRHkbyFE2KFoedL7trLIfEPey
X-Google-Smtp-Source: AGHT+IGRfof+CWgm0E47jiiOZvBTdunoNDcShffSWcpWkZ8dzL2AXDRCYbELQi8dMFGU6MtNPTrmeg==
X-Received: by 2002:a17:906:d83:b0:a65:7643:3849 with SMTP id a640c23a62f3a-a6fab7d6be4mr443486766b.73.1718957593073;
        Fri, 21 Jun 2024 01:13:13 -0700 (PDT)
Received: from [127.0.1.1] (31-179-0-202.dynamic.chello.pl. [31.179.0.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf560977sm55996566b.183.2024.06.21.01.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 01:13:12 -0700 (PDT)
From: Roman Storozhenko <romeusmeister@gmail.com>
Date: Fri, 21 Jun 2024 10:13:08 +0200
Subject: [PATCH] cpupower: Make help command available for custom install
 dir
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-fix-help-issue-v1-1-7906998d46eb@gmail.com>
X-B4-Tracking: v=1; b=H4sIABM2dWYC/x2MQQqAIBAAvxJ7bsHMkvpKdEjbciEqXIpA+nvSc
 WBmEghFJoG+SBDpZuFjz1CVBfgw7Sshz5lBK21UW3W48IOBthNZ5CJsbO2Ncq412kKOzkjZ+If
 D+L4fhkHge2AAAAA=
To: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Roman Storozhenko <romeusmeister@gmail.com>
X-Mailer: b4 0.14.0

When the 'cpupower' utility installed in the custom dir, it fails to
render appopriate help info for a particular subcommand:
$ LD_LIBRARY_PATH=lib64/ bin/cpupower help monitor
with error message like 'No manual entry for cpupower-monitor.1'
The issue is that under the hood it calls 'exec' function with
the following args: 'man cpupower-monitor.1'. In turn, 'man' search
path is defined in '/etc/manpath.config'. Of course it contains only
standard system man paths.
Make subcommands man pages available for user using the following rule:
Render a man page if it is installed in the custom install dir, otherwise
allow man to search this page by name system-wide as a last resort.

Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
---
 tools/power/cpupower/utils/cpupower.c | 54 ++++++++++++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 7 deletions(-)

diff --git a/tools/power/cpupower/utils/cpupower.c b/tools/power/cpupower/utils/cpupower.c
index 9ec973165af1..da4bc6de7494 100644
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
@@ -21,6 +23,8 @@
 #include "helpers/bitmask.h"
 
 #define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))
+#define MAN_REL_PATH "/../man/man1/"
+#define MAN_SUFFIX ".1"
 
 static int cmd_help(int argc, const char **argv);
 
@@ -80,14 +84,17 @@ static void print_help(void)
 
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
 
@@ -97,7 +104,40 @@ static int print_man_page(const char *subpage)
 		strcat(page, subpage);
 	}
 
-	execlp("man", "man", page, NULL);
+	/* Get current process image name full path */
+	if (readlink("/proc/self/exe", exec_path, PATH_MAX) > 0) {
+
+		man_path = malloc(PATH_MAX);
+		if (!man_path) {
+			free(page);
+			return -ENOMEM;
+		}
+
+		exec_dir = strdup(exec_path);
+		if (!exec_dir) {
+			free(page);
+			free(man_path);
+			return -ENOMEM;
+		}
+
+		*man_path = '\0';
+		strncat(man_path, dirname(exec_dir), strlen(exec_dir));
+		strncat(man_path, MAN_REL_PATH, strlen(MAN_REL_PATH));
+		strncat(man_path, page, strlen(page));
+		strncat(man_path, MAN_SUFFIX, strlen(MAN_SUFFIX));
+
+		free(exec_dir);
+
+		/* Check if file exists */
+		if (access(man_path, F_OK) == -1) {
+			free(man_path);
+			man_path = page;
+		}
+	} else {
+		man_path = page;
+	}
+
+	execlp("man", "man", man_path, NULL);
 
 	/* should not be reached */
 	return -EINVAL;

---
base-commit: 2102cb0d050d34d50b9642a3a50861787527e922
change-id: 20240619-fix-help-issue-573c40bb6427

Best regards,
-- 
Roman Storozhenko <romeusmeister@gmail.com>


