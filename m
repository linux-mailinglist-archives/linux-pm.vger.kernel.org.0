Return-Path: <linux-pm+bounces-15871-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2DB9A23B9
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 15:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D0901C25ED2
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 13:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6C21DDC15;
	Thu, 17 Oct 2024 13:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzLA2yWR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1541E1DDC10
	for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2024 13:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729171346; cv=none; b=sGqhbJVslfIIsDtb7kXZJ0pW4gRZ4pNW+f9a/G7fNb4jRNJcpFYJnDhj8jzv02JrDSzu2i8rOnlbT3ZB9RY0aFe1nYDeKABg5MFubj2MLuvtC5Tn/uuyCKGzoZR/ZQ+MJFenRlC/R2uuImB7pb1kr6yo54I7c50brhxmmhjoOy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729171346; c=relaxed/simple;
	bh=WfZMiJh3om+Kzq1y94fYsiIJ/LcnwXcy5hf+cwbZSD0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oLMLx5wqy1MCZ9nyosJzk0Ig5ZQYY/clzFhqe7N0vm8rEiRvC8A9JrxIUsD4+OC2Znb1R5C5eDjvEjuS7rE66Q/8i6yYYPtn87ioxcp8eabcyWhoO3H53NmdYT0+TaLv1IhwOpmnpAag/mQCuLafEcQBoD6rgygnIk9e2QKQBL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzLA2yWR; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7ea7d509e61so492089a12.1
        for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2024 06:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729171344; x=1729776144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qU4C2JR0k8glSkcc+PsL5lAmuCmZx16joE39x2UMtfw=;
        b=AzLA2yWRtIaRpsnc0/wWzVuGu0LrR9CJdlaIyrY0s7k+pvdgnpwucwhwDJJHvnAAMx
         lmPkls28UhKLI7loVoqmI5rv4lFDZjHKBCpobgAxXXnbQR+K0MXfIy3XOLQvrSW8dh90
         rnBZ2VKf32XNcexAc91WtyyYHKuoTEcmOqSnDgTsC38lWU2P+Z/3oepyex69fuyyfl1g
         YhKscpdY8G2WDpn6jxmCsz/ekkvsn953nWtLfY3PtmGqbOWrs2edrTTnkF3yR0wToH/q
         nNlXwQRb7RTA9Cs2qtUwoine9VUi8KhvQcbNxKUGyXYJ4gUbWvcDF2t77vGTHg9bnoJj
         Xh+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729171344; x=1729776144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qU4C2JR0k8glSkcc+PsL5lAmuCmZx16joE39x2UMtfw=;
        b=kHh6RvXzbFUytcvR2Z8+6SSrT9cwxBD6Wlg0aKQqQf6K5gHxN3a5ED8J57Dep9PHxd
         84fpLxmp2UFywNIwxDAfGs7ADM/hE19CcJjK9jo4Lo9F5u3TEdteNYozlfTSIsWwQoTe
         RRLh77DrKYB5F4DuK25KsTznXvMWkb6kX8zYQKplM7AcOp44+g1rohIYHPzVlLdKrHg2
         7WtJgqaKNQUeRCpdJpG0066J14A2sW3fQALD0+J/YXj7wSV610/Rx4yqm1nJ47E4V6jK
         ePzTwG3EmTW0c3/ECsrRt99P0XvsuvdcjytLHsQgtvd5baIftEyVERTIucU8VvsTaEgj
         r/Dw==
X-Forwarded-Encrypted: i=1; AJvYcCVkzcydnyGkz2xHrZOxIfUNwHKHtI4MY+cqN0Za2DsdA7kqwmi9JzSkaDLA7TZ+cq80zId6jqA6UA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9TI+psHfSmoJrqec3lHbdFbFqQpDyS5ZGlTKm/EDhAaIBE7iL
	5x8EsaIgCSc4QNEg35mgqNs9uc2Xwb8ba/agY/v4YQt5k3E+yBTg
X-Google-Smtp-Source: AGHT+IEUUNKkYJ+XPI42SfvWdIF8LbW3Y9cmAGXwBKMUPNYIupv8HREMXIa1k2J1B3epXMjAaZuQLQ==
X-Received: by 2002:a05:6a21:1786:b0:1cf:6533:5c86 with SMTP id adf61e73a8af0-1d8bcf41d86mr32665253637.21.1729171344072;
        Thu, 17 Oct 2024 06:22:24 -0700 (PDT)
Received: from BiscuitBobby.am.students.amrita.edu ([175.184.253.10])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea9c6c15aasm4964615a12.24.2024.10.17.06.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 06:22:23 -0700 (PDT)
From: Siddharth Menon <simeddon@gmail.com>
To: shuah@kernel.org,
	trenn@suse.com,
	jwyatt@redhat.com,
	jkacur@redhat.com
Cc: Siddharth Menon <simeddon@gmail.com>,
	linux-pm@vger.kernel.org
Subject: [PATCH v2] cpupower: add checks for xgettext and msgfmt
Date: Thu, 17 Oct 2024 18:51:58 +0530
Message-Id: <20241017132158.47383-1-simeddon@gmail.com>
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
 v1->v2:
 - Checks for gettext tools outside the target definitions instead
 of inline
 - Replace command with which
 
 tools/power/cpupower/Makefile | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index 6c02f401069e..e178e14d4701 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -218,29 +218,41 @@ else
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
 		echo -n "Updating $$HLANG "; \
 		if msgmerge po/$$HLANG.po $< -o \
-		   $(OUTPUT)po/$$HLANG.new.po; then \
+		  $(OUTPUT)po/$$HLANG.new.po; then \
 			mv -f $(OUTPUT)po/$$HLANG.new.po $(OUTPUT)po/$$HLANG.po; \
 		else \
 			echo "msgmerge for $$HLANG failed!"; \
 			rm -f $(OUTPUT)po/$$HLANG.new.po; \
 		fi; \
 	done;
+endif
 
 compile-bench: $(OUTPUT)libcpupower.so.$(LIB_MAJ)
 	@V=$(V) confdir=$(confdir) $(MAKE) -C bench O=$(OUTPUT)
-- 
2.39.5


