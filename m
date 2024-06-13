Return-Path: <linux-pm+bounces-9099-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABA3907A3F
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 19:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8919D1F23E06
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 17:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66B81494D0;
	Thu, 13 Jun 2024 17:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5xNKWzj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD076F06A;
	Thu, 13 Jun 2024 17:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718301150; cv=none; b=IxjmTARYTrEzYavpFQ5MTOHhEf26kqs4H9qa+fd8OzUBdmgFN2XMVMpgtN9GF3/Vg86IsScAbzA3TcAoMNPOHkiShi4CRgBON/eJ1MsHB5Et4DUcs2yTwI+umkH/fT9xpbn+SoHhAnfvBOpN1lAbabQHauAvRXaIHLaTZnWDweM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718301150; c=relaxed/simple;
	bh=KOe894IYHoviRuHhq9DyO9T0+zIpKC3zQvcDURDDzTY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YOiTu4bi+TVJTchAkd5RvHaaR6DHzh/rCi+0MTk5CMnGSHHWwneuCtd9//c+a4pkq6mdMzvApDbqT56nfcHR+Fm1jLkyuyRw5k761c++qh5BUSLC048HeT6J2dMgVAWgf1UV2JhotOwdS5uOnheG96obkdJAwcLs0gqQ6udD7JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5xNKWzj; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a68b41ef3f6so167035166b.1;
        Thu, 13 Jun 2024 10:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718301147; x=1718905947; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mg5kuhNg6apmOphycfBoA2Z8Kjn9MT4/U+x5+QgaktU=;
        b=H5xNKWzjWXeWp7yjYp69rBNLPTHEJRPT4rbieKhLMJ3vLPNstZAK+DgQnVEG347XV+
         lI5rfzKSxiOAgB8yDQkeFEBUvtGBne7YxKOvWjoKwYi+ODiyflknMMa1o1UUDLA3T9aI
         waFQM+fzyifZbO3iUZmgB3QK/CqWS9FGKtc4Dso1dwW/9xLpHo0rsA3J0TsgE0pQBQSt
         bTnyflVrjBlFv1I4PHxEuYYr1v3KbSE0ZpJossTw3Ojd4N+Gnzk1yxk5iMEh346B3aCY
         IVaZwjBDev6bIGrUca+Rdb49kqyfiyftDbtsXnV63QLTT4zMQBp8Fh5QMuejAekxWA3Q
         0Zcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718301147; x=1718905947;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mg5kuhNg6apmOphycfBoA2Z8Kjn9MT4/U+x5+QgaktU=;
        b=Ysfd6xQsYUK++wW5T7GCymCHxERoKht6+QcNbNELrL8YTAKPRf5G9gqIMHC6o4m1sH
         c/6oQN1RMbdj7DtHBt8Vz5u7LlQUhQd28PGcrSU7dJRNnwLeTRLEEciBkeZyKx1KKD8P
         sSOyuEw000pExECzrvSY8tRTqZqgepgsGjqMoKpjPZjkrORlzlGKzYGO306b1jmO642Q
         ybz0+4DsMe0HT0r5xkBaJY/B1Zs1EgcTR8OguaN265lhhN699x2RgOkHuXQGRFJr4gwB
         QfGz62thtaX+9qUC+hrvrq877cpmGrgK8DcKxnd3SGqorI+CDfoDwA/2RtNbXyMudXDr
         1f0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8k7YAZNEVWHPFKeR08ioLweeJnYXvCsl27NNF1d30bCNLGCdKnF7uzBRQDshTSKyFPsCuXrr7YLAiRGcKpBOEZVT9H8qHGh8X5s4l
X-Gm-Message-State: AOJu0YztxD1OEZaJ1jt09bgaozx3N9WeWAA7J+LY/VlTV1BmVb3q0pb2
	Q8HTSZSxclrHoKtC83XyESFz2vf7TOXtLGG2FhTV3QQt0XD1/ZkF
X-Google-Smtp-Source: AGHT+IEigelKXrjAtqntyQRpHWo4bZWSNLTsFiAgOs7AwhKK5OPfChHtidFqQyUtBELxVZp4Y/h1lg==
X-Received: by 2002:a17:906:2c02:b0:a6f:24fe:f2a7 with SMTP id a640c23a62f3a-a6f60cf1dcbmr36668966b.10.1718301147252;
        Thu, 13 Jun 2024 10:52:27 -0700 (PDT)
Received: from [127.0.1.1] (31-179-0-202.dynamic.chello.pl. [31.179.0.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56db6201sm93956566b.80.2024.06.13.10.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 10:52:26 -0700 (PDT)
From: Roman Storozhenko <romeusmeister@gmail.com>
Date: Thu, 13 Jun 2024 19:52:10 +0200
Subject: [PATCH] Improve cpupower utility build process description
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240613-fix-cpupower-doc-v1-1-9dcdee263af1@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMkxa2YC/x2MywqAIBAAfyX23IJWCvYr0SF0rb2oKD0g/Pek4
 8DMvFAoMxWYuxcyXVw4hgay78AeW9gJ2TWGQQyT0HJEzw/adKZ4U0YXLRpvRq2cVFZqaFnK1Jx
 /uay1fjv1JEhiAAAA
To: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Roman Storozhenko <romeusmeister@gmail.com>
X-Mailer: b4 0.13.0

Describe more precisely build and install 'make' processes for the default
and the user defined directories. Show how to run the utility from the
custom installation directory.

Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
---
Enhance cpupower build process description with the information on
building and installing the utility to the user defined directories
as well as with the information on the way of running the utility from
the custom defined installation directory.
This description is based on my experiments with building the utility
and each newly described step has been tested.
---
 tools/power/cpupower/README | 133 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 123 insertions(+), 10 deletions(-)

diff --git a/tools/power/cpupower/README b/tools/power/cpupower/README
index 1c68f47663b2..ec0d5551ae96 100644
--- a/tools/power/cpupower/README
+++ b/tools/power/cpupower/README
@@ -22,16 +22,129 @@ interfaces [depending on configuration, see below].
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
+the installation of the build results, that is the utility, library, man pages,
+etc...
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
+The output directory for the 'make' command is the current directory and its
+subdirs in the kernel tree:
+tools/power/cpupower
+
+$ make
+
+install
+-------
+
+'make install' command puts targets to default system dirs:
+libcpupower to /usr/lib
+cpupower, cpufreq-bench_plot.sh to /usr/bin
+cpufreq-bench to /usr/sbin
+man pages to /usr/man
+
+$ sudo make install
+
+To put it in other words it makes build results available system-wide, enabling
+any user to simply start using it without any additional steps
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
+$ make O=/home/hedin/prj/cpupower/build DESTDIR=/home/hedin/prj/cpupower install
+
+Notice that both variables 'O' and 'DESTDIR' have been provided. The reason is
+that the build results are saved in the custom output dir defined by 'O'
+variable. So, this dir is the source for the installation step. If only 'DESTDIR'
+were provided then the 'install' target would assume that the build directory is
+the current one, build everything there and install from the current dir.
+
+
+clean and uninstall (default directory)
+---------------------------------------
+
+'clean' target is intended for cleanup the build catalog from build results
+'uninstall' target is intended for removing installed files from the installation
+catalog
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
+Use 'O' command line variable to remove previously built files from the build
+dir:
+
+$ make O=<your_custom_build_catalog> clean
+
+Example:
+$ make O=/home/hedin/prj/cpupower/build clean
+
+Use 'DESTDIR' command line variable to uninstall previously installed files from
+the given dir:
+
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
+When it comes to run the utility from the custom build catalog things become a
+little bit complicated as 'just run' approach doesn't work.
+Assuming that the current dir is '<your_custom_install_catalog>/usr', issuing
+the following command:
+
+$ sudo ./bin/cpupower
+will produce the following error output:
+./bin/cpupower: error while loading shared libraries: libcpupower.so.1: cannot
+open shared object file: No such file or directory
+
+The issue is that binary cannot find the 'libcpupower' library. So, we shall
+point to the lib dir:
+sudo LD_LIBRARY_PATH=lib64/ ./bin/cpupower
 
 
 THANKS

---
base-commit: 6906a84c482f098d31486df8dc98cead21cce2d0
change-id: 20240613-fix-cpupower-doc-9f9365d15c16

Best regards,
-- 
Roman Storozhenko <romeusmeister@gmail.com>


