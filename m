Return-Path: <linux-pm+bounces-15873-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 513129A23DC
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 15:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83D1F1C217CD
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 13:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1901DE2CF;
	Thu, 17 Oct 2024 13:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kE0FQhn5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7B71DDA31
	for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2024 13:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729171952; cv=none; b=se65HPb0zubQemZ9al51px+hTY9NwYb/834OBjbJRQQF2SLEKoX8PE3p87YVvD4yWmP4QvYdXE8Biza5eQVIZkOJuiETTV3K2LcYuWXHZyPiG66y9K/fsFwG9r+0xc06YzYUTEjQnvbUBGw5fWU/Nxa1TGTUybDkRtS4kU8wxiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729171952; c=relaxed/simple;
	bh=yrbxDtcXYbO4jYQGz2XlxaZdr6yPRAqCGmMe+uVklaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dptf7UW2/qLXhrTgwRwyjTZeg+xU7kj49dE0Yx0+pbNl1Noe4oQEioI7Vfdx7rNd7ihPGPSp0MtFsTp6Ob4B3SZbdDRrbpmCfsKQLWpk28TRN9FX9nGCyIxO8bMUmSExsbndTvDhowH0rreG3uekx53EvoeC36HRniImjEaE+sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kE0FQhn5; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ea16c7759cso655069a12.1
        for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2024 06:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729171950; x=1729776750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v/y0IwS7leeAJzRabHltuM8sNnOvFVUcrzRx5DznXzU=;
        b=kE0FQhn5cpMkyU1WY+XTlU64keaJi376uxq80jNkHy6bTkPZY0lBt1p+ulcdOwueLG
         QZyJy0G3PbPRqZusJhfQMcDVQOdAFkEnYTOLpI3mSO+OZ0MNRpWqlA6lGF13W6bxLsUg
         yzpCGGE3fVB0xSiJzPbHqOk0MidDMdQ8QKCAYV5U8L1IYUbawkchVikEXA5Bi8+mraAV
         w7f6ntotiEIfKBycd1dphgBnqHgoSoT0SpiAypSjO1e27lYDKMCX7GfNoAbWoKW2o768
         oQS7OXgRsUXltyHTDRSVJRm0hIsLbqBWwpiyYM2GnZZU9nQkDPKPrqRF9F8naIxHIGjh
         6PcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729171950; x=1729776750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v/y0IwS7leeAJzRabHltuM8sNnOvFVUcrzRx5DznXzU=;
        b=hkVjSy+Bq/kmmbcu6l0JSZFekJOc6tx1lL2MmBOdZNxmfCGoVzKdEYoOh/E1o+ICqW
         hPphjFk4JfLTU33UqThBZYsrLWXUvqJmwSrYO+IbdvnNa6GvIvzeHM8ZFTteLfj5gwiC
         MOM/hQKX6JxTNrPyV65EMrN9QImaYh3nmWBl/IglO0SSDL4isulJZP73sZk/NU2w+jHJ
         MBLh0wI2Yu+8yxne//WeXqSRZhNlzS03AQlTsGY7m5RDp4yp7z+m1rzuVUdQV9r3fEn9
         cxbsf/UuMGY5xmlmpLBadfrB47lGIqiH/pTx1Z4rY31pVuXHEcWz2Mw0WnZ6U/hXcpp4
         0Vng==
X-Forwarded-Encrypted: i=1; AJvYcCUNxaEdwD4g6nHDduCi3T1HuQ/i4j4bmjUgY/KwxVcWIC4Xx2jbk3ckape3FF/skbupjKRvRkTFZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWmO3EpP+ybGJQmJqBfQdPujrLk6yAi5RF08oBQzb3FqXdQeMD
	Fs+2MkWIz2hJeRnbWS2Xwmmp9FobaImN7TO+ScvrE2fTOcRoQJ6f
X-Google-Smtp-Source: AGHT+IEAO6+aif64bXrDdYCQhdjv9QF/rYnq+T7k/0IFFhEPdw1Zo3lQ0pvYsVMGQyJ4/p/fsN6Iig==
X-Received: by 2002:a05:6a20:21d4:b0:1d9:a1c:7086 with SMTP id adf61e73a8af0-1d90a1c7235mr6955157637.44.1729171949870;
        Thu, 17 Oct 2024 06:32:29 -0700 (PDT)
Received: from BiscuitBobby.am.students.amrita.edu ([123.63.2.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea9c715e3esm4891078a12.90.2024.10.17.06.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 06:32:29 -0700 (PDT)
From: Siddharth Menon <simeddon@gmail.com>
To: shuah@kernel.org,
	trenn@suse.com,
	jwyatt@redhat.com,
	jkacur@redhat.com
Cc: Siddharth Menon <simeddon@gmail.com>,
	linux-pm@vger.kernel.org
Subject: [PATCH v3] cpupower: add checks for xgettext and msgfmt
Date: Thu, 17 Oct 2024 19:02:23 +0530
Message-Id: <20241017133223.53070-1-simeddon@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check whether xgettext and msgfmt are available on the system before
attempting to  generate GNU gettext Language Translations.
In case of missing dependency, generate warning message directing user
to install the necessary package.

Signed-off-by: Siddharth Menon <simeddon@gmail.com>
---
 v1->v2:
 - Checks for gettext tools outside the target definitions instead
 of inline
 - Replace command with which
 v2->v3:
 - Update commit message
 
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


