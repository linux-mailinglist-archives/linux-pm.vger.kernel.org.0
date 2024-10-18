Return-Path: <linux-pm+bounces-15914-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1F59A33F7
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 06:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EDBD1C20DB6
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 04:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760CB16F8EF;
	Fri, 18 Oct 2024 04:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNa7p8iW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BB013AA3F
	for <linux-pm@vger.kernel.org>; Fri, 18 Oct 2024 04:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729227193; cv=none; b=JuPsZo7aXshh8m0XockCsXh5vxjTAtgiNRoqLE6Rj9m4XdGHmTnVJceRmlAdCvaEHclzcNy2wBqYP6tPQZs0Mon8wnJOhLZCk+KrU48fPXfujLbqBsVmt0i3qYAuSMK0T1lBmg2xzdD8KQ6Pmp3XP+8cwX9ZRRJkGbKYwKBYLbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729227193; c=relaxed/simple;
	bh=z9lpcwdlXA2KeJYX8Y1zpgGOdVm40/mQ5tHpkO3H1N4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b1pR8NCI+S6Z7uYvhMYo7aUHQT/6T7EoqLnMoDnfGuLaeuqh+2GFISbBI86IGTQHyVNl6cxj1XSL3hVdP1Lf2DthI8hS6s/8f7iVoyraKF6T3UDpz+8PlveddnKqSSId0X7XCn7LnFKs4wvsmnGCPcE5kpaOplGxIIWx+vKi0VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNa7p8iW; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-718e9c8bd83so2037766b3a.1
        for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2024 21:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729227191; x=1729831991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EUM68sDm3swWUHIcOs0kpY1MQ+31ZApbU6jqhI1AgKE=;
        b=UNa7p8iWRC57uq2AnJ8KydDeUtMWxR1hgh7nImdcPJ8du00K7/Ccn1T3+iZ8LEnjDG
         hartD5wpHKtuIqh2LOXD0bxnl4gADyb5XwoAwFTwox5d6BSAIIDhXreRFnf6y7+yZ18E
         9sQuudWvT5JiWuIAQkmW75iCWo6YLL2BVmfovBwmAX31RBWVblM86cwfA6bWI+GGHu2P
         qIqF/hMvWEU9MeiSlQXwfpWZYN7g9PDKtrnLYo34oGCDFHMMmKgzmf+A25JA4BEhjD7U
         0/QxIzOtvNDI7Cfev8rGAIAvhY8JXidi3x0gu2S7e69r2rNJE0oMZz8wboFUtvWFQzvX
         L3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729227191; x=1729831991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EUM68sDm3swWUHIcOs0kpY1MQ+31ZApbU6jqhI1AgKE=;
        b=mCTNl0pWh5xOAdGf/xZORGUUBt4lFUcUXojCuIrgBFJoeAYadr4bnPwvwWAZh7c3Yu
         3UH7Ux1Kct9xiAxbtK3Z9NNyRT8LDhRi6iQs4MMAk9yYRrVedp2YHnN9PVWdYXENrKwR
         7axGhARJrxhvBuO7ruUHGFyOH29gdD1iJf9QlCVTdPTGwtZk/FhfmlDfOe6hION6lZ0R
         9SwD1AGUIxLVhPSNOXFP5ELKyL//BRYPa9+bnUkYk3dzXPgzUlrR3k4ptC/jI3HNC+Re
         6TYuFYa8KmHC4e25Ex0laauOakYvG7z44fML0oDWSuO8xrj453L9phN9QTQj8ArUSEoG
         07TA==
X-Forwarded-Encrypted: i=1; AJvYcCWSBoRr2L6UnjPt/uPmj0xLWfqNt3SWG5Wdl+kimv8nyRshvTDtsPVDcFr34lTzXmjAgf5/Zn//EA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEvH+zQ8apgNmDMlO+8mPeONXtjSrURZuzlzbB879mx4HtQVZi
	5LuXtTi6XVA17wTH1t3DOs1Z55+rzqvp7frM0+FN7CUQMNQ0a6l3
X-Google-Smtp-Source: AGHT+IHap8eyDqegI30D8SMqekZLAsLe6xv/XWlwJ0ttVB9Gl2b0I46AgamIUhWrfolOBTL3+XpHEg==
X-Received: by 2002:a05:6a00:1493:b0:71e:667c:8384 with SMTP id d2e1a72fcca58-71ea4259bcemr1473380b3a.9.1729227191168;
        Thu, 17 Oct 2024 21:53:11 -0700 (PDT)
Received: from localhost.localdomain ([2409:4073:2ec8:87f1:8c25:95c6:b05c:ec36])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea34a9a07sm537671b3a.192.2024.10.17.21.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 21:53:10 -0700 (PDT)
From: Siddharth Menon <simeddon@gmail.com>
To: shuah@kernel.org,
	trenn@suse.com,
	jwyatt@redhat.com,
	jkacur@redhat.com
Cc: Siddharth Menon <simeddon@gmail.com>,
	"John B . Wyatt IV" <sageofredondo@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH v4] cpupower: add checks for xgettext and msgfmt
Date: Fri, 18 Oct 2024 10:22:48 +0530
Message-Id: <20241018045249.9373-1-simeddon@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check whether xgettext and msgfmt are available on the system before
attempting to generate GNU gettext Language Translations.
In case of missing dependency, generate error message directing user
to install the necessary package.

Tested-by: John B. Wyatt IV <jwyatt@redhat.com>
Tested-by: John B. Wyatt IV <sageofredondo@gmail.com>
Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Siddharth Menon <simeddon@gmail.com>
---
 v1->v2:
 As suggested by Shuah:
 - Checks for gettext tools outside the target definitions instead
 of inline
 - Replace command with which
 v2->v3:
 - Update commit message
 - Removed the unwanted space under msgmerge introduced in v2
 v3->v4:
 - Added suggested-by and tested-by tags
 - Updated changelog to be more descriptive
 
 tools/power/cpupower/Makefile | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index 6c02f401069e..84987f91d11f 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -218,17 +218,28 @@ else
 endif
 	$(QUIET) $(STRIPCMD) $@
 
+ifeq (, $(shell which xgettext))
+$(warning "Install xgettext to extract translatable strings.")
+else
 $(OUTPUT)po/$(PACKAGE).pot: $(UTIL_SRC)
 	$(ECHO) "  GETTEXT " $@
 	$(QUIET) xgettext --default-domain=$(PACKAGE) --add-comments \
 		--keyword=_ --keyword=N_ $(UTIL_SRC) -p $(@D) -o $(@F)
+endif
 
+ifeq (, $(shell which msgfmt))
+$(warning "Install msgfmt to generate binary message catalogs.")
+else
 $(OUTPUT)po/%.gmo: po/%.po
 	$(ECHO) "  MSGFMT  " $@
 	$(QUIET) msgfmt -o $@ po/$*.po
+endif
 
 create-gmo: ${GMO_FILES}
 
+ifeq (, $(shell which msgmerge))
+$(warning "Install msgmerge to merge translations.")
+else
 update-po: $(OUTPUT)po/$(PACKAGE).pot
 	$(ECHO) "  MSGMRG  " $@
 	$(QUIET) @for HLANG in $(LANGUAGES); do \
@@ -241,6 +252,7 @@ update-po: $(OUTPUT)po/$(PACKAGE).pot
 			rm -f $(OUTPUT)po/$$HLANG.new.po; \
 		fi; \
 	done;
+endif
 
 compile-bench: $(OUTPUT)libcpupower.so.$(LIB_MAJ)
 	@V=$(V) confdir=$(confdir) $(MAKE) -C bench O=$(OUTPUT)
-- 
2.39.5


