Return-Path: <linux-pm+bounces-7770-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98ECB8C47B3
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 21:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA9F31C22F80
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 19:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9E8768FD;
	Mon, 13 May 2024 19:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kubH592O"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AEE762EB
	for <linux-pm@vger.kernel.org>; Mon, 13 May 2024 19:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715629272; cv=none; b=G6ir9QVctsuwnBXiU5KUQtMe6mXPbYgyrsGRAqIGntnvUbOADlueUar0qs8V3dnMjLm2YvHFU+jZquWDoNvYRHjzS5G1dsX3mPhjkduKTpooniYVNccvY4MKrd+78C579x8I5rWJg8mvHuNaioLSO7uQh6l+UN6R4xQD/KV6ZQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715629272; c=relaxed/simple;
	bh=so3123PfFd+h8gUGZ4Xq4sVz4sm6kwzPl0Hz5FkFXjM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QPu0AFBAiOuIfhG1ahLybqE+y5G62M4p+COqofivuhyKLZlzx3M+DziozGCgT/DaOv23pYpvSGkcGz00Ejsobng7rF6XT9eP3L35OhZZ4eFc8WLvZ4C3tJzz6QsmmjKqEfLq4Ec4BpkX97g6ePwLg2OKiDQ6QKLR2UiBuVfPBuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kubH592O; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-61804067da0so47564657b3.0
        for <linux-pm@vger.kernel.org>; Mon, 13 May 2024 12:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715629269; x=1716234069; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QKslB0wfymcIT+PaTwJz5eZ19AWexcaBVIPJtPDQaIE=;
        b=kubH592OxW9DcnrdShRcj34vls0MVF7XkZFrM19d6rFVphcrMjIOb0Vq3L6ZwVcNZW
         kkhxX8VL8eXqesVCNEU9poIjjqH36vEhfVWkgmE4ckKjcdv/0wVKXD2PeG53+e+UPksk
         aahv4ohwYOR2xSk+hOnazIhnh7FQb8dVw0Em2VxoO9/6Te796ggPptKj16Zm3JU2AFGe
         TbyEV5E79GxXdIkVzE6Ib+c0bAZSPk4ntxdFsT8xrFnuDbJtnv9vfrr4tQPCJpFxm15d
         HLJcAxPiLmVjqm+c20pFR8RI0IOJ3Aa5hCxi+mzSYlGcCXAXn9JXd3toEX0yZxTXcaB9
         dtwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715629269; x=1716234069;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QKslB0wfymcIT+PaTwJz5eZ19AWexcaBVIPJtPDQaIE=;
        b=mdpQyu7Ixi4u9g6zal9gA8uFGKitJFr2jwQDYFy8PQs6+aHieOrp0hSjcA7LlIZLHK
         zWEdCWF0jy99WA2FDgYh1CsGVsi0GqW0ofCFCajyT1JQCaIq20T+Vg+NzS/+KvAotDT+
         qAUP5PuKEY+97PsVye/JZs/6NtbOX8niwzjirUKG7l78cVfPaNddE/rQ5UYk8TuW37vD
         c7oBJVmiNnE9nwY4wNuQOYpc5i6eq3fIzAYp+fmNCcNCgaBZ3+394MTZaiCNdZoQEBrM
         v01Xa8Q2Fa0nAd17fFg3Dda2kPEWLQZ6MMWYLlxQjQ8z+rzRYJLg4rhQOYJ3B3Et1Za2
         yPOw==
X-Gm-Message-State: AOJu0YxXz54xeIl1FMO4ETGw/imd2zyGFq+9Ih6UM7eWN77a/n9vK9PH
	aGkOsLAQroioHkG7yOZQgrBXGCCxcPEniuZNBdqwQct9W/CZuwhH3Whxqg==
X-Google-Smtp-Source: AGHT+IEalFDCSAFzY4eYNXaG4iHBheSodw/+yzANTAO3RHU7YB0lVaDP4uq51ntIXbRy5BvX5ZIEYA==
X-Received: by 2002:a05:690c:6f8d:b0:61a:da7e:1f66 with SMTP id 00721157ae682-622aff75ff2mr121758407b3.2.1715629268384;
        Mon, 13 May 2024 12:41:08 -0700 (PDT)
Received: from lenb-Intel-NUC8i7HVKVA.search.charter.net ([2600:6c60:4a00:22d:edc9:ad0e:d214:6024])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e26fc1csm22266417b3.71.2024.05.13.12.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 12:41:08 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 01/15] tools/power turbostat: Add "snapshot:" Makefile target
Date: Mon, 13 May 2024 15:40:37 -0400
Message-Id: <231ce08b662a58d4392da998699b3d4a7e2e87cf.1715628187.git.len.brown@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240513194051.283919-1-lenb@kernel.org>
References: <20240513194051.283919-1-lenb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

Kernel developers often need to diagnose remote customer systems
with the latest turbostat, yet customers are running binary distros
with out-dated turbostat and the customer has no experience
cloning linux kernel trees.

Add a turbostat "snapshot" makefile target to create a standalone
source snapshot from the developer's git tree, appropriately hacked
so that the customer can build turbostat without a kernel tree.

Include the turbostat binary in the snapshot, for convenience in
those situations where the source and destination are trusted,
(and have new enough glibc to execute).

The snapshot is named with the date it was taken rather than
the turbostat VERSION, as it could occur between VERSIONS...

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/Makefile | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/Makefile b/tools/power/x86/turbostat/Makefile
index 92e139b9c792..2d6dce2c8f77 100644
--- a/tools/power/x86/turbostat/Makefile
+++ b/tools/power/x86/turbostat/Makefile
@@ -3,6 +3,8 @@ CC		= $(CROSS_COMPILE)gcc
 BUILD_OUTPUT	:= $(CURDIR)
 PREFIX		?= /usr
 DESTDIR		?=
+DAY		:= $(shell date +%Y.%m.%d)
+SNAPSHOT		= turbostat-$(DAY)
 
 ifeq ("$(origin O)", "command line")
 	BUILD_OUTPUT := $(O)
@@ -22,9 +24,30 @@ override CFLAGS +=	-D_FORTIFY_SOURCE=2
 .PHONY : clean
 clean :
 	@rm -f $(BUILD_OUTPUT)/turbostat
+	@rm -f $(SNAPSHOT).tar.gz
 
 install : turbostat
-	install -d  $(DESTDIR)$(PREFIX)/bin
+	install -d $(DESTDIR)$(PREFIX)/bin
 	install $(BUILD_OUTPUT)/turbostat $(DESTDIR)$(PREFIX)/bin/turbostat
-	install -d  $(DESTDIR)$(PREFIX)/share/man/man8
+	install -d $(DESTDIR)$(PREFIX)/share/man/man8
 	install -m 644 turbostat.8 $(DESTDIR)$(PREFIX)/share/man/man8
+
+snapshot: turbostat
+	@rm -rf $(SNAPSHOT)
+	@mkdir $(SNAPSHOT)
+	@cp turbostat Makefile turbostat.c turbostat.8 ../../../../arch/x86/include/asm/intel-family.h $(SNAPSHOT)
+
+	@sed -e 's/^#include <linux\/bits.h>/#include "bits.h"/' ../../../../arch/x86/include/asm/msr-index.h > $(SNAPSHOT)/msr-index.h
+	@echo '#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))' >> $(SNAPSHOT)/msr-index.h
+	@echo "#define BIT(x) (1 << (x))" > $(SNAPSHOT)/bits.h
+	@echo "#define BIT_ULL(nr) (1ULL << (nr))" >> $(SNAPSHOT)/bits.h
+	@echo "#define GENMASK(h, l) (((~0UL) << (l)) & (~0UL >> (sizeof(long) * 8 - 1 - (h))))" >> $(SNAPSHOT)/bits.h
+	@echo "#define GENMASK_ULL(h, l) (((~0ULL) << (l)) & (~0ULL >> (sizeof(long long) * 8 - 1 - (h))))" >> $(SNAPSHOT)/bits.h
+
+	@echo PWD=. > $(SNAPSHOT)/Makefile
+	@echo "CFLAGS +=	-DMSRHEADER='\"msr-index.h\"'" >> $(SNAPSHOT)/Makefile
+	@echo "CFLAGS +=	-DINTEL_FAMILY_HEADER='\"intel-family.h\"'" >> $(SNAPSHOT)/Makefile
+	@sed -e's/.*MSRHEADER.*//' -e's/.*INTEL_FAMILY_HEADER.*//' Makefile >> $(SNAPSHOT)/Makefile
+
+	@rm -f $(SNAPSHOT).tar.gz
+	tar cvzf $(SNAPSHOT).tar.gz $(SNAPSHOT)
-- 
2.40.1


