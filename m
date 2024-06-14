Return-Path: <linux-pm+bounces-9144-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C032390856F
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 09:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 751721F28E64
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 07:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D82718307E;
	Fri, 14 Jun 2024 07:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3EYExRU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CEA142E80;
	Fri, 14 Jun 2024 07:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718351818; cv=none; b=GU6CFap8srbIobZNTvLT0kyWM1DdUmyVGc6gTQy9F2ng6a1m2wmOxxxrxVd2QgyTmgsi1kh5lnJkRb3KPIshvRXbpBhG0RAoHQ0GEiGtPffmffh9+Qxl3feD0JLsO7Slzdl16DhSHWSc5ytjV/Dotjlug1u8ThvO6x0fRBiDBLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718351818; c=relaxed/simple;
	bh=nUFKyARcWy2uSMLzAzinGAPULSmGJh8N5IGQ7ihfZcA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NmazEpMNhtx+cFPnM/f9NdvboFrU67RE/LDKtOJ3IIGD3lsJu7hsU0dgFpcSQ7CFB6A+t/QZgQvfnc8W6QuMy16Z/wtFEP1YovdolIE4+jZShH6onfycNU8juVixVO4Ikv77lv5XDey8ECPpfZHrmKXslSvbLLkUPzYRPH+pWos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3EYExRU; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6f253a06caso232405666b.1;
        Fri, 14 Jun 2024 00:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718351815; x=1718956615; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JDOif5JyBV4rbSGZWH0kGnPLkS7eG7oH/YJ4mNYY/60=;
        b=f3EYExRUjRG51RpjjG0EYTszh8felaoEALsEqzN9wXAPHBk/VzCHM/+IjHKpG2f7OI
         l9bKYC10TY0I3IM1Cbsa+U2FOkhjFUTFCrkEk79oOGDRfCrG4Ac4EPliClICi6I+NizG
         iR7M3qOR2/sFW1YZvncx8GfLdOjBs7z/o7g72B0NPzzasJPfOgtokyJqZAORloucdMTa
         j7zSn0a7TvT6Xvr6BwD7O34Sj872bTrIaOnrnuxk0KyoVYD8X+fOQS9CqTZ+G2Q85IH+
         YZth1EnaocgU7Go2Ca2Te9PdJjlRiGswkHX2exm28oImWfe2Nm1ey6lta1UQC8uWVQVW
         w6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718351815; x=1718956615;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JDOif5JyBV4rbSGZWH0kGnPLkS7eG7oH/YJ4mNYY/60=;
        b=HXflvtjVolleauIx6arFagT/nLp3Fld8fECsnnjX7NUleiCGT3HpgSTW9doyiwFcpu
         jdMNzIacRK76+Y9n91xyVSAXVeJBry11toWcUaWf855Isx518yv3gqRGuUnTLMrx3q/j
         Z3vquG09EMNpRXBevzRwbjh4vEtUnH9P+Hlih+WbEtvN9NiRXqkYsy+xrUl+cIE3crs7
         70LWPkX5c2sT1YLmkDV+oQKQAMb5RU+LqQqd0VmxvDFQcrwyVnPnCDHdHW54CVVdfxk2
         k68dKpCAxSksjjlQsBJoOQQORcITunhISEVMtoQOO7hffruWONf8KY7s8HCLbbCxB7aO
         5Lqw==
X-Forwarded-Encrypted: i=1; AJvYcCXO8eLGTmtQa85/4OER6DsYZB3uNOo+8YL7qhuekgXSEpjwKeA0ibchnhC9LQ+D7PKx2JxsmMs6zhiIkJp8n9TzQLy0RhW03AJT9v/B
X-Gm-Message-State: AOJu0Yw9uxp8zQWmP4RRBI5uV3R/68f8yepi9vssVCAIZhbMIWc+vSBn
	cQu47zJu3r5HJUkLojW6KaWMljtZmQOC70X36ieZusUGhUeMHFAFeaaV3A==
X-Google-Smtp-Source: AGHT+IEOT5FTpIwBSVj8zrDu1PDpjdLyrByHXc0nfoQfNORbQs1DrO3LCu46VApAbQhbYmh+arrlGA==
X-Received: by 2002:a17:906:556:b0:a6f:5fe4:f78d with SMTP id a640c23a62f3a-a6f60d5f8ecmr175427366b.44.1718351814209;
        Fri, 14 Jun 2024 00:56:54 -0700 (PDT)
Received: from [127.0.1.1] (31-179-0-202.dynamic.chello.pl. [31.179.0.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f427b0sm156398166b.156.2024.06.14.00.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 00:56:53 -0700 (PDT)
From: Roman Storozhenko <romeusmeister@gmail.com>
Date: Fri, 14 Jun 2024 09:56:38 +0200
Subject: [PATCH] cpupower: Add 'help' target to the main Makefile
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-make-help-v1-1-513118646b71@gmail.com>
X-B4-Tracking: v=1; b=H4sIALX3a2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDM0Nj3dzE7FTdjNScAl1DE2NTy0RLE+NU8yQloPqCotS0zAqwWdGxtbU
 AD9V16lsAAAA=
To: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Roman Storozhenko <romeusmeister@gmail.com>
X-Mailer: b4 0.13.0

Add 'help' target descriding building and cleaning targets
to the main Makefile

Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
---
Make "cpupower" building process more user friendly by adding 'help'
target to the main makefile. This target describes various build
and cleaning options available to the user.
---
 tools/power/cpupower/Makefile | 37 ++++++++++++++++++++++++++++++++++++-
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

---
base-commit: 6906a84c482f098d31486df8dc98cead21cce2d0
change-id: 20240613-make-help-14359a943e7b

Best regards,
-- 
Roman Storozhenko <romeusmeister@gmail.com>


