Return-Path: <linux-pm+bounces-10314-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C263291F091
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 09:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B0BC1F227E5
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 07:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8979712FF9D;
	Tue,  2 Jul 2024 07:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eP6buZoF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D095755C1A;
	Tue,  2 Jul 2024 07:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719906998; cv=none; b=eefI97E3z1D14PlJfvH9fH1YDpuyKYfbVjZsB2IPoCWfy4Mvp6gk4dmqkGrRtpFnznZU/zJZQOwSnrlWPk3jJp/3Tn+EI5+PQ7CwNcYcQ3JlWOufYu3zuU7To/aFbzhjA4KzGIo1ZbF2dEjTjE0MGTrmfwVayyHb7xbHjMz/+u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719906998; c=relaxed/simple;
	bh=bkQnc3weswRHI7W6Mm8xk+rSJ13Bladvrf+0ktUOofU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=M7ml66usk4T+3Ww3AuOjasqEVT1VXHvVsTVTIBC/AUlffRnJD4s5BcyK7s72PKtsERfZcRpm4LtCF4JM6ek61mwWsJbqUrWkGkJur9UNabewFg+rhe8UQtn4bwbyhyluDXz9dH8/rsEZJAZaFQEl/bwcJDMzYYzK7uK1UHiZfHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eP6buZoF; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a6fe81a5838so363982566b.3;
        Tue, 02 Jul 2024 00:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719906994; x=1720511794; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JRFw+14wzSvcpBsFAqmuHO9XlGAERfrIw3u757eVjMk=;
        b=eP6buZoF7PyQ8eMoWjpsf5Koe/yDXT0RQjWyGunu6JwTwYjBGn84uIMpYWlt/6diB0
         rFHWEXsmheKEcgRhMO7lhYuEp2DJUzF9bqZjD3VDz7MF6dniiGrCtB4io1bIZwApnKzJ
         b4mjgWlJuIhud09nsAN51hFH5igr6MPfdH8gHE1Tr9PKm6t9Y/Y6wW1ANsDkNSeAXi3H
         u248V/vEUd4DK2ifnO0OYfiNUQrD2qcshUqCQFD6d4vU/LhIYLWGTeTn6MQYixtYdH2A
         BrWIe9eUhOlq1wKTfQvjb7E8cGFKAyrW1FNEwtvHSubRtBoA6o5grDdECMaH1ETN8SOz
         nEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719906994; x=1720511794;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JRFw+14wzSvcpBsFAqmuHO9XlGAERfrIw3u757eVjMk=;
        b=bHY9PoDGUVQoW+HKpFlTwja/YjwZfLDSSfL6dzPErU9g9U/Mwuu9oW/4v7gnIZcmIu
         LM0SoQnWLvGIsFiU0S+fSaQaNkhWkn8UARvlnu7yHPKKcavMfKw1VY4wxuyo30qzXCGm
         /k0D5Kt9hqRpGZ7oRnfAWhO289ERQOAbh6SECjP09BAR7wgwytK/ibMnI7iwNdej7/5d
         Fy6eUWBmYAJM6oSl5LKUtnfr5jSXgwmub1wXFfNyvdYLGrubJ6r9NnGZws19NK4LcNuI
         UQJVdw4XgfbSHs70cHvBqsCMqUMHQ2nJUCCXLHfBMscZPo5De4EmjN6T+IWOcWmiQ1tS
         H+KQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmo78TNT96DbIKAUXIzuFC3Q8teBdQDCsrjKgd7tfWTgq0z8p5RY753XAnQkEyPzu4s7pVIqqGOd6YYX/72nuq2j7uSPCv0oBSPPy4b3HU05xZTmV19jnv8uNLzradTF5fyMDZsGM=
X-Gm-Message-State: AOJu0Yzh6eQRSSDBvcz4mp6gUwJfcvT87f42SU63av5dRVVYSd1/8xkC
	qNqfCimQI5Ijxq5bwiIf/6J9PuRjh0xUiknGz3u0vsaSNrImES04qg5Epw==
X-Google-Smtp-Source: AGHT+IEh0TFZ1ULj49zw9AlQ+kVE08m8FyR8qBlPy29r0N4DcWIu8tP3XLOulwMeWDHWpzqI3Xi+iA==
X-Received: by 2002:a17:907:845:b0:a75:2387:7801 with SMTP id a640c23a62f3a-a752387794bmr393026166b.61.1719906994188;
        Tue, 02 Jul 2024 00:56:34 -0700 (PDT)
Received: from [127.0.1.1] (31-179-0-202.dynamic.chello.pl. [31.179.0.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aaf638fesm394175866b.68.2024.07.02.00.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 00:56:33 -0700 (PDT)
From: Roman Storozhenko <romeusmeister@gmail.com>
Date: Tue, 02 Jul 2024 09:56:25 +0200
Subject: [PATCH v2] cpupower: fix lib default installation path
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-fix-lib-install-v2-1-9b84dcd3c22b@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKiyg2YC/3WNyw6CMBREf4Xctde0BYW48j8Mi76Am5SWtKTRk
 P67lb3LM5k5c0CykWyCR3NAtJkSBV9BXBrQi/SzRTKVQTDRsbtocaI3OlJIPu3SOWxVb7Q2ykz
 dDepqi7ZWTuNrrLxQ2kP8nAeZ/9L/rsyRo9LKsGodzNA/51WSu+qwwlhK+QLJwvGKrgAAAA==
To: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Roman Storozhenko <romeusmeister@gmail.com>
X-Mailer: b4 0.14.0

Invocation the tool built with the default settings fails:
$ cpupower
cpupower: error while loading shared libraries: libcpupower.so.1: cannot
open shared object file: No such file or directory

The issue is that Makefile puts the library to "/usr/lib64" dir for a 64
bit machine. This is wrong. According to the "File hierarchy standard
specification:
https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard
https://refspecs.linuxfoundation.org/FHS_3.0/fhs-3.0.pdf

"/usr/lib<qual>" dirs are intended for alternative-format libraries
(e.g., "/usr/lib32" for 32-bit libraries on a 64-bit machine (optional)).

The utility is built for the current machine and doesn't handle
'CROSS_COMPILE' and 'ARCH' env variables. It also doesn't change bit
depth. So the result is always the same - binary for x86_64
architecture. Therefore the library should be put in the '/usr/lib'
dir regardless of the build options.
This is the case for all the distros that comply with the
'File Hierarchy Standard 3.0" by Linux Foundation. Most of the distros
comply with it. For example, one can check this by examining the
"/usr/lb64" dir on debian-based distros and find that it contains only
"/usr/lib64/ld-linux-x86-64.so.2". And examine that "/usr/lib" contains
both 32 and 64 bit code:
find /usr/lib -name "*.so*" -type f | xargs file | grep 32-bit
find /usr/lib -name "*.so*" -type f | xargs file | grep 64-bit

Fix the issue by changing library destination dir to "/usr/lib".

Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
---
Changes in v2:
- Enchance changelog by providing more details
- Link to v1: https://lore.kernel.org/r/20240623-fix-lib-install-v1-1-bcbd03b78d87@gmail.com
---
 tools/power/cpupower/Makefile | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index cd0225a312b4..6c02f401069e 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -67,6 +67,7 @@ LANGUAGES = 			de fr it cs pt ka
 bindir ?=	/usr/bin
 sbindir ?=	/usr/sbin
 mandir ?=	/usr/man
+libdir ?=	/usr/lib
 includedir ?=	/usr/include
 localedir ?=	/usr/share/locale
 docdir ?=       /usr/share/doc/packages/cpupower
@@ -94,15 +95,6 @@ RANLIB = $(CROSS)ranlib
 HOSTCC = gcc
 MKDIR = mkdir
 
-# 64bit library detection
-include ../../scripts/Makefile.arch
-
-ifeq ($(IS_64_BIT), 1)
-libdir ?=	/usr/lib64
-else
-libdir ?=	/usr/lib
-endif
-
 # Now we set up the build system
 #
 

---
base-commit: f76698bd9a8ca01d3581236082d786e9a6b72bb7
change-id: 20240623-fix-lib-install-3b7dccdbdf45

Best regards,
-- 
Roman Storozhenko <romeusmeister@gmail.com>


