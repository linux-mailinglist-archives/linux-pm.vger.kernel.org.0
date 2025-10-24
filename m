Return-Path: <linux-pm+bounces-36764-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B2605C04694
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 07:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 35FFD4E0ECC
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 05:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72F313DBA0;
	Fri, 24 Oct 2025 05:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEx2dy0T"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5517363CF
	for <linux-pm@vger.kernel.org>; Fri, 24 Oct 2025 05:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761284814; cv=none; b=eeEUo/94udSEsdlK6R8264K5pefRSho52J8LxEk+6LIN7qAl2tTPhySI5CpxgE99rETPrl0r4I8HvuYsVYhci22glmNuyShl4gR91MjmDTOesb2iMolRb16Ju/5C9OWuRcwgSpdL7TVjv+W4uS89lyegHR5imJ6ybxGuDLln+eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761284814; c=relaxed/simple;
	bh=mqpBfiol+8cue8H7iv/V78L+EQtM20OQOKG+gw2a+FY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qDgp86/Ufj95GC2Wu1GU082bo/WgkJ3+o7NsP90hHssHpq+qtV3foLu1JPBof7RPyNXPb/TnMPNlTNo4lr9Ko2CTRHP6ZwIfxS8tgDCPUj7YGyWkjEoBktUVHju5WJf31/A/AMRMvNjb9eS/+5exgIsOAB6ZMQmMcTIGmTYZdGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEx2dy0T; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-290cd62acc3so19388625ad.2
        for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 22:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761284812; x=1761889612; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ggJ1ncamNDciUL/pnOvEp977Ru4f05+wirbHlcHHA4=;
        b=eEx2dy0TBQpqvGSmv3g2dkzoqBQVY7PSYbM59Oeac5cuvID8NGti7lvTBdEjS18pIE
         ubJuiP3p84imxhUjMf9KVme6z1SGPHs9PoqXXHQ4nRTPR+BynuNWQiJV15ztNP5F7UXt
         iDTSOya0ove3hTbPvAn3RccyhOO0QS/lbWQ4Bp4uBCW1K0b+3EFI/Eo/nRg4TgdFEZlg
         QdYPVP/B8eZ3E3s9L9WH53NYVtYbZLQqjMi7qksqSn32JoIp/zltawHmb9TiqG74vd6r
         TbE6fLs/ulgaWW5Pq5DYsUkCmJvcGSRRbUxZGrJVdpBWBqTBMNnj2T0+glh4V4o2EVFC
         2JIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761284812; x=1761889612;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ggJ1ncamNDciUL/pnOvEp977Ru4f05+wirbHlcHHA4=;
        b=PQGufd/HAv3lMyAmNXpjXyMb/L8cEBNzvA32K8UBZywLZxSNkPUF0zW0hxU0BbLJi0
         9YKdWWO+8Fqr9J7MKLZVdX0LqZXjIcU3CoKY1qt7ciVQuWqqUD3qgMhlnoZ6xor1XmeK
         td4ER62Hy03sW/ojhfnp/jRuZzbAHf05lNY08cQJJLBNrWnQQckhuXfXdOHVLrg+VC6r
         pWfWSE690RxmFcFV3EPL2zkwFp3g168/STB6h0Uie6hjPtfcOXKiVglxA8h2+BH7VRqU
         eELNTRasNmdamcWUPvnmnleE4XX6lOmoNkpNzSyMjxo+siioHdMG4TZe68wKa2gfjS/V
         MJlg==
X-Gm-Message-State: AOJu0YxiLYhjzVw27sMectLPtW6NmesAkg4GexTv16oI9LQiBaFjVWlo
	NKNUfaYUrd/Bg7/8x/l+NUax6zOQQ78Z4nGrKBaEg6+tUZE07AroSJ3dQlep4g==
X-Gm-Gg: ASbGncu5j6swOMIMFFJpYLvASLsJq9VOFdNOjEGt87BHCC7+Er4M4vHNWVDGU9Vvp7p
	tIJyF+WMz/EVi51+cwBsRDvctRiDo1hh3aj/pdAxmuAGGy/ALhgqVN+Lx1O0z5PtYvxPzILfK7M
	G20UoNMP6I5xNYdual4u25Hqb+o0vfsea8g7IkPY8fo81QskX0W1vj9/BqfhsML5iMyUd3WltvQ
	V41cRPg6FOtciKC4Cyk0UNWHUZsBsDdAsEbU5u81tWprxTS7XH7VDEcOOWr8UQX7lnZxc1qgy3a
	Lhl617yqWmBJqTMRCFYIOBiEdLhR6S3vpryI6Po6jjDm7ScT04SxNVxx9It7Yl9zAH1JdZ7wLzf
	ed1gnBeC3dtlP0dWCxVeLcSaogVHAsKyAyKbyZcdiDhLufp42auVk/qmSdDmXG7oubRslVZrD1f
	u7/cKqj+q4Es02QsCcXvrccQ/6
X-Google-Smtp-Source: AGHT+IED860gfaQv/cIbLbAE3Ob/+vCo3S53KTjbuXMq01F6yEMwVKlQ1VuMUBWy2yfJ0IQefiHMDw==
X-Received: by 2002:a17:902:da87:b0:269:8f2e:e38 with SMTP id d9443c01a7336-2948b95c2c0mr11575655ad.6.1761284812493;
        Thu, 23 Oct 2025 22:46:52 -0700 (PDT)
Received: from gmail.com ([202.133.210.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dda85dcsm43750525ad.7.2025.10.23.22.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 22:46:52 -0700 (PDT)
Date: Fri, 24 Oct 2025 05:46:47 +0000
From: Zuo An <zuoan.penguin@gmail.com>
To: linux-pm@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>, 
	"John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>
Subject: [PATCH] tools/power/cpupower: Support building libcpupower statically
Message-ID: <x7geegquiks3zndiavw2arihdc2rk7e2dx3lk7yxkewqii6zpg@tzjijqxyzwmu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The cpupower Makefile built and installed libcpupower as a shared
library (libcpupower.so) without passing `STATIC=true`, but did not
build a static version of the library even with `STATIC=true`. (Only the
programs were static). Thus, out-of-tree programs using libcpupower
were unable to link statically against the library without having access
to intermediate object files produced during the build.

This fixes that situation by ensuring that libcpupower.a is built and
installed when `STATIC=true` is specified.

Signed-off-by: Zuo An <zuoan.penguin@gmail.com>
---
 tools/power/cpupower/Makefile | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index c43db1c41205..a1df9196dc45 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -37,9 +37,7 @@ NLS ?=		true
 # cpufreq-bench benchmarking tool
 CPUFREQ_BENCH ?= true
 
-# Do not build libraries, but build the code in statically
-# Libraries are still built, otherwise the Makefile code would
-# be rather ugly.
+# Build the code, including libraries, statically.
 export STATIC ?= false
 
 # Prefix to the directories we're installing to
@@ -207,14 +205,25 @@ $(OUTPUT)lib/%.o: $(LIB_SRC) $(LIB_HEADERS)
 	$(ECHO) "  CC      " $@
 	$(QUIET) $(CC) $(CFLAGS) -fPIC -o $@ -c lib/$*.c
 
-$(OUTPUT)libcpupower.so.$(LIB_VER): $(LIB_OBJS)
+ifeq ($(strip $(STATIC)),true)
+LIBCPUPOWER := libcpupower.a
+else
+LIBCPUPOWER := libcpupower.so.$(LIB_VER)
+endif
+
+$(OUTPUT)$(LIBCPUPOWER): $(LIB_OBJS)
+ifeq ($(strip $(STATIC)),true)
+	$(ECHO) "  AR      " $@
+	$(QUIET) $(AR) rcs $@ $(LIB_OBJS)
+else
 	$(ECHO) "  LD      " $@
 	$(QUIET) $(CC) -shared $(CFLAGS) $(LDFLAGS) -o $@ \
 		-Wl,-soname,libcpupower.so.$(LIB_MAJ) $(LIB_OBJS)
 	@ln -sf $(@F) $(OUTPUT)libcpupower.so
 	@ln -sf $(@F) $(OUTPUT)libcpupower.so.$(LIB_MAJ)
+endif
 
-libcpupower: $(OUTPUT)libcpupower.so.$(LIB_VER)
+libcpupower: $(OUTPUT)$(LIBCPUPOWER)
 
 # Let all .o files depend on its .c file and all headers
 # Might be worth to put this into utils/Makefile at some point of time
@@ -224,7 +233,7 @@ $(OUTPUT)%.o: %.c
 	$(ECHO) "  CC      " $@
 	$(QUIET) $(CC) $(CFLAGS) -I./lib -I ./utils -o $@ -c $*.c
 
-$(OUTPUT)cpupower: $(UTIL_OBJS) $(OUTPUT)libcpupower.so.$(LIB_VER)
+$(OUTPUT)cpupower: $(UTIL_OBJS) $(OUTPUT)$(LIBCPUPOWER)
 	$(ECHO) "  CC      " $@
 ifeq ($(strip $(STATIC)),true)
 	$(QUIET) $(CC) $(CFLAGS) $(LDFLAGS) $(UTIL_OBJS) -lrt -lpci -L$(OUTPUT) -o $@
@@ -269,7 +278,7 @@ update-po: $(OUTPUT)po/$(PACKAGE).pot
 	done;
 endif
 
-compile-bench: $(OUTPUT)libcpupower.so.$(LIB_VER)
+compile-bench: $(OUTPUT)$(LIBCPUPOWER)
 	@V=$(V) confdir=$(confdir) $(MAKE) -C bench O=$(OUTPUT)
 
 # we compile into subdirectories. if the target directory is not the
@@ -287,6 +296,7 @@ clean:
 	-find $(OUTPUT) \( -not -type d \) -and \( -name '*~' -o -name '*.[oas]' \) -type f -print \
 	 | xargs rm -f
 	-rm -f $(OUTPUT)cpupower
+	-rm -f $(OUTPUT)libcpupower.a
 	-rm -f $(OUTPUT)libcpupower.so*
 	-rm -rf $(OUTPUT)po/*.gmo
 	-rm -rf $(OUTPUT)po/*.pot
@@ -295,7 +305,11 @@ clean:
 
 install-lib: libcpupower
 	$(INSTALL) -d $(DESTDIR)${libdir}
+ifeq ($(strip $(STATIC)),true)
+	$(CP) $(OUTPUT)libcpupower.a $(DESTDIR)${libdir}/
+else
 	$(CP) $(OUTPUT)libcpupower.so* $(DESTDIR)${libdir}/
+endif
 	$(INSTALL) -d $(DESTDIR)${includedir}
 	$(INSTALL_DATA) lib/cpufreq.h $(DESTDIR)${includedir}/cpufreq.h
 	$(INSTALL_DATA) lib/cpuidle.h $(DESTDIR)${includedir}/cpuidle.h
@@ -336,11 +350,7 @@ install-bench: compile-bench
 	@#DESTDIR must be set from outside to survive
 	@sbindir=$(sbindir) bindir=$(bindir) docdir=$(docdir) confdir=$(confdir) $(MAKE) -C bench O=$(OUTPUT) install
 
-ifeq ($(strip $(STATIC)),true)
-install: all install-tools install-man $(INSTALL_NLS) $(INSTALL_BENCH)
-else
 install: all install-lib install-tools install-man $(INSTALL_NLS) $(INSTALL_BENCH)
-endif
 
 uninstall:
 	- rm -f $(DESTDIR)${libdir}/libcpupower.*
-- 
2.51.1

