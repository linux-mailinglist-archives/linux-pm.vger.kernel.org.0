Return-Path: <linux-pm+bounces-9226-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D3A909861
	for <lists+linux-pm@lfdr.de>; Sat, 15 Jun 2024 14:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A1D4283B0B
	for <lists+linux-pm@lfdr.de>; Sat, 15 Jun 2024 12:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C6145028;
	Sat, 15 Jun 2024 12:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRngFdxC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D293EA71;
	Sat, 15 Jun 2024 12:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718456202; cv=none; b=R3Tn0bSFVvaMGuies0e3US0aThjiLAvusalaunVn1VFUVpx9gfTdyhwlwgrxjIJsiVmWryWWk61OtSbvoPaJMyNqHPHbv+PyHrFivwBbYdpeuQQGrpIELs1rOMnK6szT1JCiXUoJvY1g+Sm36/Z3NsRTxB/o8iJFyY0YSDPkL9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718456202; c=relaxed/simple;
	bh=94yitstrn/YMrChHyOwtFhAgJr8p2OA0d7b8iZAJOQI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EdV/lOnuEydw3sDNBr5WA696dxiGqe0JoYlgu8XpIhWeBrHfsFhxwOjrxQRaKYtZE3CR1Y9ZDvZtOyWwnq6dILmWAZhaScZs66G0/kCDvNJhwSwiyBfm/FT5X4c/sOF+xgQY0ZNaMCh2Doi4W4oIEj5wqqYh+m0BeGy4Dbo7HcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRngFdxC; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ec0f3b9cfeso19409901fa.0;
        Sat, 15 Jun 2024 05:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718456199; x=1719060999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9uQZPSsruFcOyb4vkjanLohPm8OoIjb2fDZP406slAo=;
        b=VRngFdxC99P0EJNTTFQ+IIUvtRNAdTkTsxwsgnYLOxplsc4E4meR+abxsghMRmohv6
         0e7EjO9bPMtuML1g0HTndgWaeVr7WJzIRIfZiGKR9CV0XgSf9cfwAg2krxa3gjFFa2Po
         SIFrexz/cJMtMMYqgUEvT7qz5AqyWZ8zoP/gxOnrAZq0sZN3bF2S5uDdXE04ncdUv4Ks
         9qc1cKxW4dAG4L/+Zc139LAlYnrc6MLf4JM/wCpuiMdwm2LpDQSmqw7thKuxr/VAiIY4
         5gjijNtCcF6SsZvLkD4T+hF4D2tR7keUd0tyt8bymxWhRoW4mHZithp+Sa6ZC61GZ94C
         jbgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718456199; x=1719060999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9uQZPSsruFcOyb4vkjanLohPm8OoIjb2fDZP406slAo=;
        b=t0FMXbmtEC4Tx2Dn9oLyj8308RBlYMYlCaJoXMyXz97yf0xApFcsybGh40ylCcdXvO
         ixb5sBZPR44+tjvecFsq5ahbsVxXax05LpvB2SykvO6jThMpciapOywCORNMFYK+qOWY
         FJR5O6RTtoWhDn1bvL84YtrNv7Q1RABBmKkT17AuXlFdLMgbZLawo3YFFaBZbeam56XW
         iSo1GhKnobzJOxB/zc7vrTF71d0t0tp2Vk7eyNbUYoQcqir/kL3k5XdY1iEbZoIaCY4S
         23b52WADZYnEc8zWsUdNIxhA0Im/SA6qIjq8LS2p0DeRP84RyN/Njgcncy4xhn/DfAFS
         AOzA==
X-Forwarded-Encrypted: i=1; AJvYcCWOaqYwCucJj1edG9l2EmOEz+wVELukYlvVf+G6DddjW6zy8ba1kX3tjdiIV9GBzhusJENeN4I7PcGmHwgX5g8IiZJt5wzXO/qYcbt3oMIFhx77s+2UOJS+wxxVM4rKjR/rFw6rc+g=
X-Gm-Message-State: AOJu0Yz/earwuiTwlztRTZfTVSMB/5+WedVa3H8z7vLqldQBs6xFyCq0
	AV0fKEsCwG8/bT0UmCrKUDz8jAWJcGXBNwjFkHx2CjnMYHQKr1IR
X-Google-Smtp-Source: AGHT+IHamFpUNV4TfylNYJK4I3fnAM9UdlBWoZFUGH5RZWAh8eg3Mx3F15feGgZH2zNFFVpPAhQ5Sw==
X-Received: by 2002:a19:ca49:0:b0:52c:85a8:669 with SMTP id 2adb3069b0e04-52ca6e6599emr2844745e87.20.1718456198413;
        Sat, 15 Jun 2024 05:56:38 -0700 (PDT)
Received: from localhost.localdomain (31-179-0-202.dynamic.chello.pl. [31.179.0.202])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca2de6b99sm726257e87.79.2024.06.15.05.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jun 2024 05:56:38 -0700 (PDT)
From: Roman Storozhenko <romeusmeister@gmail.com>
To: Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roman Storozhenko <romeusmeister@gmail.com>
Subject: [PATCH v2] cpupower: Improve cpupower build process description
Date: Sat, 15 Jun 2024 14:56:17 +0200
Message-Id: <20240615125617.180521-1-romeusmeister@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enhance cpupower build process description with the information on
building and installing the utility to the user defined directories
as well as with the information on the way of running the utility from
the custom defined installation directory.

Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
---
V1 -> V2:
 - Improved commit description
 - Make changed line lenghts 75 chars
 - Refactored the description
 - Link v1: https://lore.kernel.org/linux-pm/20240613-fix-cpupower-doc-v1-1-9dcdee263af1@gmail.com/
---
 tools/power/cpupower/README | 160 +++++++++++++++++++++++++++++++++---
 1 file changed, 150 insertions(+), 10 deletions(-)

diff --git a/tools/power/cpupower/README b/tools/power/cpupower/README
index 1c68f47663b2..2678ed81d311 100644
--- a/tools/power/cpupower/README
+++ b/tools/power/cpupower/README
@@ -22,16 +22,156 @@ interfaces [depending on configuration, see below].
 compilation and installation
 ----------------------------
 
-make
-su
-make install
-
-should suffice on most systems. It builds libcpupower to put in
-/usr/lib; cpupower, cpufreq-bench_plot.sh to put in /usr/bin; and
-cpufreq-bench to put in /usr/sbin. If you want to set up the paths
-differently and/or want to configure the package to your specific
-needs, you need to open "Makefile" with an editor of your choice and
-edit the block marked CONFIGURATION.
+There are 2 output directories - one for the build output and another for
+the installation of the build results, that is the utility, library,
+man pages, etc...
+
+default directory
+-----------------
+
+In the case of default directory, build and install process requires no
+additional parameters:
+
+build
+-----
+
+$ make
+
+The output directory for the 'make' command is the current directory and
+its subdirs in the kernel tree:
+tools/power/cpupower
+
+install
+-------
+
+$ sudo make install
+
+'make install' command puts targets to default system dirs:
+
+-----------------------------------------------------------------------
+| Installing file        |               System dir                   |
+-----------------------------------------------------------------------
+| libcpupower            | /usr/lib                                   |
+-----------------------------------------------------------------------
+| cpupower               | /usr/bin                                   |
+-----------------------------------------------------------------------
+| cpufreq-bench_plot.sh  | /usr/bin                                   |
+-----------------------------------------------------------------------
+| man pages              | /usr/man                                   |
+-----------------------------------------------------------------------
+
+To put it in other words it makes build results available system-wide,
+enabling any user to simply start using it without any additional steps
+
+custom directory
+----------------
+
+There are 2 make's command-line variables 'O' and 'DESTDIR' that setup
+appropriate dirs:
+'O' - build directory
+'DESTDIR' - installation directory. This variable could also be setup in
+the 'CONFIGURATION' block of the "Makefile"
+
+build
+-----
+
+$ make O=<your_custom_build_catalog>
+
+Example:
+$ make O=/home/hedin/prj/cpupower/build
+
+install
+-------
+
+$ make O=<your_custom_build_catalog> DESTDIR=<your_custom_install_catalog>
+
+Example:
+$ make O=/home/hedin/prj/cpupower/build DESTDIR=/home/hedin/prj/cpupower \
+> install
+
+Notice that both variables 'O' and 'DESTDIR' have been provided. The reason
+is that the build results are saved in the custom output dir defined by 'O'
+variable. So, this dir is the source for the installation step. If only
+'DESTDIR' were provided then the 'install' target would assume that the
+build directory is the current one, build everything there and install
+from the current dir.
+
+The files will be installed to the following dirs:
+
+-----------------------------------------------------------------------
+| Installing file        |               System dir                   |
+-----------------------------------------------------------------------
+| libcpupower            | ${DESTDIR}/usr/lib                         |
+-----------------------------------------------------------------------
+| cpupower               | ${DESTDIR}/usr/bin                         |
+-----------------------------------------------------------------------
+| cpufreq-bench_plot.sh  | ${DESTDIR}/usr/bin                         |
+-----------------------------------------------------------------------
+| man pages              | ${DESTDIR}/usr/man                         |
+-----------------------------------------------------------------------
+
+If you look at the table for the default 'make' output dirs you will
+notice that the only difference with the non-default case is the
+${DESTDIR} prefix. So, the structure of the output dirs remains the same
+regardles of the root output directory.
+
+
+clean and uninstall
+-------------------
+
+'clean' target is intended for cleanup the build catalog from build results
+'uninstall' target is intended for removing installed files from the
+installation directory
+
+default directory
+-----------------
+
+This case is a straightforward one:
+$ make clean
+$ make uninstall
+
+custom directory
+----------------
+
+Use 'O' command line variable to remove previously built files from the
+build dir:
+$ make O=<your_custom_build_catalog> clean
+
+Example:
+$ make O=/home/hedin/prj/cpupower/build clean
+
+Use 'DESTDIR' command line variable to uninstall previously installed files
+from the given dir:
+$ make DESTDIR=<your_custom_install_catalog>
+
+Example:
+make DESTDIR=/home/hedin/prj/cpupower uninstall
+
+
+running the tool
+----------------
+
+default directory
+-----------------
+
+$ sudo cpupower
+
+custom directory
+----------------
+
+When it comes to run the utility from the custom build catalog things
+become a little bit complicated as 'just run' approach doesn't work.
+Assuming that the current dir is '<your_custom_install_catalog>/usr',
+issuing the following command:
+
+$ sudo ./bin/cpupower
+will produce the following error output:
+./bin/cpupower: error while loading shared libraries: libcpupower.so.1:
+cannot open shared object file: No such file or directory
+
+The issue is that binary cannot find the 'libcpupower' library. So, we
+shall point to the lib dir:
+sudo LD_LIBRARY_PATH=lib64/ ./bin/cpupower
 
 
 THANKS
-- 
2.34.1


