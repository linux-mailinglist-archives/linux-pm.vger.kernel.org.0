Return-Path: <linux-pm+bounces-9830-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12178913AC1
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jun 2024 15:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42AD81C20B2B
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jun 2024 13:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0129E1802B3;
	Sun, 23 Jun 2024 13:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLqhd2nb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D84145FE5;
	Sun, 23 Jun 2024 13:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719148221; cv=none; b=hgvSoW6/KnhrjkFhq8iRCyzY7DIkkSq1/f2xgRXBirQWN3H9YJc+drJjajnYdsE29tkqYLmz0C2sBFzerK1B8fo8Do3p9pO4wuPXM0pd8AYzmWHPAi2irVD91zIvpofvT5kswgok90tlQ7TVkZPzqQcY+asXtjMfWKf6WniW4uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719148221; c=relaxed/simple;
	bh=6JYUsKtf8H17efiWyRLkJQ3nIZSzd+F1OIP2SWlNpA4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WErsLWXkETAQg94ORw86ivQxFlMU23SNBlCpguBGRl6QxDzoLyXd637/BTYr76tRzSFCiltDDu2nxtmM1OQsfrnfI/cy3U5lPqZwcJLM2JwYPYumjE5l67L0RxPmlrJl2367id3iyn0gnOu/dAnQTn08+J6+ZfNL9ISmVccBlQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MLqhd2nb; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a725282b926so16425466b.0;
        Sun, 23 Jun 2024 06:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719148218; x=1719753018; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4NxXE05caueMt/ZkHF5FeOgGTppp1VBuaLqzInuGo1g=;
        b=MLqhd2nbuZyXmt/gLzWESf9IJhahKMLkugYoA3tjzd27y78QVeGt3b4VQANMSDV4da
         N7Txryggpr+ON6QpW37mHnExPenrthiDCZXJq46NOzKNCVrN5duTfyPZ8hviYOH5WzSc
         IVM9fBJ2wKxhr8cCv5fKdYN4VV8N05yQinLWJAVwtBh98MrG5YHoWowg10IVE4aRMLqS
         l0ZgCgqIDNGiTXOy7Si6XY3LAjdq2zvxpA3dbqyyTLD/uU2gQZBjh6m3renR/cDxpQ+t
         6w+ByNZhQcVN5adXOY8OrQrZh9xoVp1uLYkFjs3Z6o4RZBLEenUSyXnKLrRrwuP2vz0E
         1ugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719148218; x=1719753018;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4NxXE05caueMt/ZkHF5FeOgGTppp1VBuaLqzInuGo1g=;
        b=SoI0DKJuRSww1ws2nG5oeVh0E7ClOsXzNHkwIJ5a96gQnYoWnjBzeFb5G6xDT4tGO1
         adzYBXodRDAG0nHEAKE7nMb1rZlU9zAcpOzjN16JaVrmpw2Ebw6t5KqXxbsQiheMv5V1
         X8mN6qjDtfiuObqzSguinp8SGDR0ywh3NiSND9Yj58Nx49i1yVtnyp0R4YJf8ylf19EZ
         A7XYRKuw97ai8b6m8lBymjTehpKJhAJW1xnXYFe1/NdNDi7dlJwJAX7QhQQnQHnFHsim
         knnMKWSl+l+ITam6sLXQnf+ObCkYAK9JJInla6kUVnYflh0fPqXdYoyUP63vSsG8xwu6
         EXHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWX2UIBDQzyttBMZ7qx+tU5lFIAYwFOH8hLZkOdh9FKi/wnR3YlQ/pBntHtcfyVuLUuQQba6h2pJD379dWMgp2+G9NGqgcsY+tRF++/lpoaSyR3ujnDdfD5J5LrmJP0HnvIlLq3NHI=
X-Gm-Message-State: AOJu0Yzu0vBqL3rH496G2bFsamvHjYlcalzL0Qd6p7v7NqzGS+RdapsT
	2rw0Sdr7Q89QyydnrDoubjMi55S9R+Nb7hmBA6PoorpqjSboyMnmTOJXgQ==
X-Google-Smtp-Source: AGHT+IFkePlt/NZqqDVE+fn2755KJxhFwZdTIwCvmh69HKsLsKgyjz1K2Qzmd046qadk0zkAYUTbIw==
X-Received: by 2002:a17:906:3ac9:b0:a6f:6960:5e18 with SMTP id a640c23a62f3a-a7245ccdd31mr129010366b.22.1719148218081;
        Sun, 23 Jun 2024 06:10:18 -0700 (PDT)
Received: from [127.0.1.1] (31-179-0-202.dynamic.chello.pl. [31.179.0.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7244cbce5bsm110241166b.79.2024.06.23.06.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 06:10:17 -0700 (PDT)
From: Roman Storozhenko <romeusmeister@gmail.com>
Date: Sun, 23 Jun 2024 15:10:10 +0200
Subject: [PATCH] cpupower: fix lib default installation path
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240623-fix-lib-install-v1-1-bcbd03b78d87@gmail.com>
X-B4-Tracking: v=1; b=H4sIALEeeGYC/x2MQQqAIBAAvxJ7bqHUCvpKdEh3qwWx0Igg/HvSc
 WBmXkgchROM1QuRb0lyhAJtXYHbl7AxChUG1SjT9ErjKg96sSghXYv3qO1AzpGl1XRQqjNyUf7
 jNOf8Aezczc1hAAAA
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

The utility is built for the current machine and doesn't change bit
depth.
Fix the issue by changing library destination dir to "/usr/lib".

Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
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


