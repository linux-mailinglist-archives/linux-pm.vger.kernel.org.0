Return-Path: <linux-pm+bounces-15668-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 096E799F2E1
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 18:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F314B20CF8
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 16:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2CC1F6668;
	Tue, 15 Oct 2024 16:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kk/+1tqy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8325B1B3931
	for <linux-pm@vger.kernel.org>; Tue, 15 Oct 2024 16:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729010391; cv=none; b=tDZwIc06FqvujrjWYFm7YqPCt0u7tfNtlTJh7rcvZvYcuT9fTmcK11j5Kr5q0rxxOsOHqJLIJSevq0qMPdinbYJ2o5uUjtgZfS6ttcJhyaDa/QxDz4+E8Dj0koK0huPArMjKi8zoMHXY6iB8LAl6DYXi5ChdTJH/y5ojwQge2AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729010391; c=relaxed/simple;
	bh=dM8wlTh1KzQ/FY66FG8WTb1mZEusB68zRjpPQOlcWEA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VbWXSWEOBd75HJVridBWwTjOZcxQFKt7Q3fI0fv195sdfPkQpVhSaFARhiRc85VR1QUTmtV9/O9/UiSn6e/0LEnCIne/YNg5D2EiRgbsaHTx173PkDA74a/zgvqfOvZpqk7AzYi42fSPdOr7c/eTI2aaTbH/qLAtfTj4QSDi05I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kk/+1tqy; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7d4f85766f0so4230076a12.2
        for <linux-pm@vger.kernel.org>; Tue, 15 Oct 2024 09:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729010390; x=1729615190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Demn3B9j3O8UgM925wdwEtYzhjsd7vY3/OdViFNwJas=;
        b=kk/+1tqy9CoN/Q1MyCA0GamuyZH0Xc+GAUOKAtb9626oiOXNs8Mb/jLdGPj2DBPZ2i
         P4t2n16rPwJ4YmJ5epEK7eR9sH0YR605EO5UvdVAKCyxhqcjL7iOLIFs0LcZ8UqnEzAv
         Ylr5n6FElNunbfTQo3J9vJM6c+Gk4GZtHH5iykxh67SK/JnACUYlBAbfMfEPWyeuQFgS
         43AfiEzRqsEvj0l2R+JZOpYijjwRcpMP+o+mPAy8Ng305MCHlt5G4DAPbAiZlmY3gqoy
         DO8FOjbVT3/j6zKvbIdNsM76GP5gEEE0YoBFTUJ+TBMeiqk7JzyE1M80PpfiTwg8u0hf
         n5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729010390; x=1729615190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Demn3B9j3O8UgM925wdwEtYzhjsd7vY3/OdViFNwJas=;
        b=bICSxdS2gyNiph86dCqyXCH3pIN/nZCicBw2ZqShC4LnVrEbwXjY6Og3IA6g+Lm9eF
         I3lFdf47l7aAcqHlQKOCMppcGYXLBSVnYkmzKg2MFrXmq/wMbTvg+PYnSfdNq6SNIDzY
         6XQe2NGwuMq5lljaNqSUgbUbtNhBQdiACQ40NEqtPH9ZjZXRwsJaDzk8mpr8HdB/VB1/
         4esGTT4Jd8Lmw2o32CPnrWGyyXAXtNtUXPll0WwHE6CMCum/41QOsDO8o7pnxLps6vDp
         omvfw9K7pzuhifMJ5hzTn0z+kA+zwTHP+0Lw2+F/GDXLzHUV1Xinr4Rpmt6ssx1O1xrs
         iBWw==
X-Forwarded-Encrypted: i=1; AJvYcCUkj6w3RSL88fZCrv3IVfovGj1+NR6LYxGA0bKATs9ZgUBhzCZG4VqUrneyrDn3lHCD+mNoRjPM6w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQeCUZEnyCU4tJrDZjHxpSIVsuPgwbnB8Lcu3f78r4KvpUl9L3
	2zHqX+UyzLfM16Phg4CNFKipSGJ6Tg9lVf9D8cnYiAHtdAFmy9sJ
X-Google-Smtp-Source: AGHT+IFH2cUV1TaEl/8noj9S9uyE3/W7F8IRbGr/E2tfGusYrLVnM7DUL0Vjnv9ivuBV6Z5SgIMg+Q==
X-Received: by 2002:a05:6a21:9d83:b0:1d8:a759:525b with SMTP id adf61e73a8af0-1d8bcfa53e0mr23353418637.34.1729010389743;
        Tue, 15 Oct 2024 09:39:49 -0700 (PDT)
Received: from BiscuitBobby.am.students.amrita.edu ([175.184.253.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e773717dcsm1490460b3a.20.2024.10.15.09.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 09:39:49 -0700 (PDT)
From: Siddharth Menon <simeddon@gmail.com>
To: shuah@kernel.org,
	trenn@suse.com,
	jwyatt@redhat.com,
	jkacur@redhat.com
Cc: Siddharth Menon <simeddon@gmail.com>,
	linux-pm@vger.kernel.org
Subject: [PATCH] cpupower: add checks for xgettext and msgfmt
Date: Tue, 15 Oct 2024 22:08:54 +0530
Message-Id: <20241015163854.35204-1-simeddon@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check whether xgettext and msgfmt are available on the system before
attempting to generate the .pot and .gmo files and generate.
In case of missing dependency, generate error message directing user
to install the necessary package.

Signed-off-by: Siddharth Menon <simeddon@gmail.com>
---
 tools/power/cpupower/Makefile | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index 6c02f401069e..38e7daacecf4 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -220,12 +220,20 @@ endif
 
 $(OUTPUT)po/$(PACKAGE).pot: $(UTIL_SRC)
 	$(ECHO) "  GETTEXT " $@
-	$(QUIET) xgettext --default-domain=$(PACKAGE) --add-comments \
-		--keyword=_ --keyword=N_ $(UTIL_SRC) -p $(@D) -o $(@F)
+	$(QUIET) if ! command -v xgettext > /dev/null; then \
+		echo "Error: gettext not found. Please install gettext."; \
+	else \
+		xgettext --default-domain=$(PACKAGE) --add-comments \
+		--keyword=_ --keyword=N_ $(UTIL_SRC) -p $(@D) -o $(@F); \
+	fi
 
 $(OUTPUT)po/%.gmo: po/%.po
 	$(ECHO) "  MSGFMT  " $@
-	$(QUIET) msgfmt -o $@ po/$*.po
+	$(QUIET) if ! command -v msgfmt > /dev/null; then \
+		echo "Error: msgfmt not found. Make sure gettext is set up correctly."; \
+	else \
+		msgfmt -o $@ po/$*.po; \
+	fi
 
 create-gmo: ${GMO_FILES}
 
-- 
2.39.5


