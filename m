Return-Path: <linux-pm+bounces-9227-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 466ED909884
	for <lists+linux-pm@lfdr.de>; Sat, 15 Jun 2024 15:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F00A71F21E3E
	for <lists+linux-pm@lfdr.de>; Sat, 15 Jun 2024 13:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5715F487B3;
	Sat, 15 Jun 2024 13:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpfTLhSL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B24482CA;
	Sat, 15 Jun 2024 13:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718457981; cv=none; b=ll/QSpFBOeKeQ+NPv9c7ftRm7N0OKSNXesHCigW2f70y4pJc1dEO2voUPzpgZW2oJOgSqgDl9ifK9VGcWYOeTQa4HweAc3/2rLHgkMuRAiIwhbfLiawa4wCxV/wFbBoCmn8yqhs7h/6CQTGd2BxkxHrP/uqe0KjKHnSWtX4aN9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718457981; c=relaxed/simple;
	bh=UgwnpvLn+spljQxkIqmVjYDa0EMETv3loKKjamYYyic=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qx+PKYQkebkBH9xCRQE5pshULuzX3xtk1FgmSd7oDjK2eEGRXdiSZ4DLF+DCil6Iervvm8Eeeqk2D90O5hRAoEAx8AgZbTPg47NTrH/6pv+KobXO/7oCdUn1HQHa6Vhj/VcBVvdT0VUerFTaRkCJL7sZ7BUxaHL53v9T5N4mkpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpfTLhSL; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57a4d7ba501so3772420a12.2;
        Sat, 15 Jun 2024 06:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718457978; x=1719062778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LNNyYwbRAxzksK/WDvgi1EfPanfSeg1kfm367EItVAI=;
        b=fpfTLhSLVHp5L+e+YVqZWzTfQtC+0s7gQYGwKWFDyNED0/Mb+f6jwNhUFlmTEIRt6q
         4T29WBwfLVqfT6YRm96A2R84EBXNxzhrTPwpm0CbrOWuSHNwXRloSBZ34eKBUrNrL+gr
         1o32tj6mjEyxgESrUH3iN9BZjFUqQj5sjn50tLmfRnG5yP7xC0NlFsg4GlCwd7iNzXV9
         ScritQ3pHMLkzDb7HCl4wcvgpIoTYk/Kq9QXRNUMbmvHjKyqZwrkJixlp9c8Oyp2WNc2
         LyMv5fF793CMqpXVuMe3cwp7BLGvXzPh3NLk7CCvo8c+vreWnCG9zpGQ5RNRUup5MqoD
         XUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718457978; x=1719062778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LNNyYwbRAxzksK/WDvgi1EfPanfSeg1kfm367EItVAI=;
        b=FxtAUyGMX5nsQRu5zrKDWbWjY5hlYFQSWuTaRvjVsuSMDYIiKsXQ4ge+WShNRztQWP
         z1QO4L+YTaz3c0ED0sx7kDjjrUodOl/nc5REI8Dw24dEgKjplfrqdQ6EmaVu+dgoZK1/
         iyI/OtrNuhPgdRYI6wfOYKpn3X0r9dyda7e7nyaGDhkNIz2U/O6xcDYiozS4cYx/j+5O
         cgEhRwsi6852YlPedJr7Df9eFe43UUKPSPKQwnMZ06jQiR2fQJVOnxYfIVsHINNl/pp4
         QIZQ2LcS3zNFHTTPa9BcZohdgbSOIq5ot8g0zB86KtPFQ8kc6wU462lGQK6302v6NrHh
         rsuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfTMED7nKeAoyBVhoqSjQ3Sh7KSog1ozh/5wqy15f1RWuWzB7pR0RzK5a1CH+rsTlGUPSHphfoqL+S07ywkaaXYu/m6It/RUdMGWxEWseeeBby7wR4BAEWZohTsHFIjph8G8pbiVk=
X-Gm-Message-State: AOJu0YzmwghWvg0+Q8k7zXzXe2GCAu1bB+eN3hlZP3K2VSxsTBg2Frp8
	IFtrrhey+xkLlkDnjrpfN+v65bABLTtfudIMlbxbnFK6xVRgNoWN
X-Google-Smtp-Source: AGHT+IGnuy50OAvHsW/aijdGSia7g0PVNE6+3jvWWG3aOrqmnmitqgtx4lNMW1wFPF0/qSxgPlP4gA==
X-Received: by 2002:a17:906:2288:b0:a6f:1443:1e24 with SMTP id a640c23a62f3a-a6f60d3fd34mr336483366b.34.1718457977660;
        Sat, 15 Jun 2024 06:26:17 -0700 (PDT)
Received: from localhost.localdomain (31-179-0-202.dynamic.chello.pl. [31.179.0.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56ed3685sm297823066b.126.2024.06.15.06.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jun 2024 06:26:17 -0700 (PDT)
From: Roman Storozhenko <romeusmeister@gmail.com>
To: Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roman Storozhenko <romeusmeister@gmail.com>
Subject: [PATCH v2] cpupower: Add 'help' target to the main Makefile
Date: Sat, 15 Jun 2024 15:26:13 +0200
Message-Id: <20240615132613.182899-1-romeusmeister@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make "cpupower" building process more user friendly by adding 'help'
target to the main makefile. This target describes various build
and cleaning options available to the user.

Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
---
V1 -> V2:
 - Enchanced patch description
 - Reformat patch
 - Link v1: https://lore.kernel.org/linux-pm/20240614-make-help-v1-1-513118646b71@gmail.com/
---
 tools/power/cpupower/Makefile | 37 ++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index b53753dee02f..cd0225a312b4 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -332,4 +332,39 @@ uninstall:
 		rm -f $(DESTDIR)${localedir}/$$HLANG/LC_MESSAGES/cpupower.mo; \
 	  done;
 
-.PHONY: all utils libcpupower update-po create-gmo install-lib install-tools install-man install-gmo install uninstall clean
+help:
+	@echo  'Building targets:'
+	@echo  '  all		  - Default target. Could be omitted. Put build artifacts'
+	@echo  '                    to "O" cmdline option dir (default: current dir)'
+	@echo  '  install	  - Install previously built project files from the output'
+	@echo  '                    dir defined by "O" cmdline option (default: current dir)'
+	@echo  '                    to the install dir  defined by "DESTDIR" cmdline or'
+	@echo  '                    Makefile config block option (default: "")'
+	@echo  '  install-lib	  - Install previously built library binary from the output'
+	@echo  '                    dir defined by "O" cmdline option (default: current dir)'
+	@echo  '                    and library headers from "lib/" for userspace to the install'
+	@echo  '                    dir  defined by "DESTDIR" cmdline (default: "")'
+	@echo  '  install-tools	  - Install previously built "cpupower" util from the output'
+	@echo  '                    dir defined by "O" cmdline option (default: current dir) and'
+	@echo  '                    "cpupower-completion.sh" script from the src dir to the'
+	@echo  '                    install dir  defined by "DESTDIR" cmdline or Makefile'
+	@echo  '                    config block option (default: "")'
+	@echo  '  install-man	  - Install man pages from the "man" src subdir to the'
+	@echo  '                    install dir  defined by "DESTDIR" cmdline or Makefile'
+	@echo  '                    config block option (default: "")'
+	@echo  '  install-gmo	  - Install previously built language files from the output'
+	@echo  '                    dir defined by "O" cmdline option (default: current dir)'
+	@echo  '                    to the install dir defined by "DESTDIR" cmdline or Makefile'
+	@echo  '                    config block option (default: "")'
+	@echo  '  install-bench	  - Install previously built "cpufreq-bench" util files from the'
+	@echo  '                    output dir defined by "O" cmdline option (default: current dir)'
+	@echo  '                    to the install dir  defined by "DESTDIR" cmdline or Makefile'
+	@echo  '                    config block option (default: "")'
+	@echo  ''
+	@echo  'Cleaning targets:'
+	@echo  '  clean		  - Clean build artifacts from the dir defined by "O" cmdline'
+	@echo  '                    option (default: current dir)'
+	@echo  '  uninstall	  - Remove previously installed files from the dir defined by "DESTDIR"'
+	@echo  '                    cmdline or Makefile config block option (default: "")'
+
+.PHONY: all utils libcpupower update-po create-gmo install-lib install-tools install-man install-gmo install uninstall clean help
-- 
2.34.1


