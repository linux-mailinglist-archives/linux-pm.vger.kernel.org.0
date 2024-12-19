Return-Path: <linux-pm+bounces-19473-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EDE9F71BF
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 02:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9B081631E0
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 01:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9774AEE2;
	Thu, 19 Dec 2024 01:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QPXg7s8B"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028E53594B
	for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2024 01:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734571620; cv=none; b=c5v1OvMlluSXM43aj8b8Cw8s4oVRY/wG8WEhHIKG7CJFNxn5p68HF6ZXXr5tlwFGYuW7iiMM0YtmGcALZlQwSQl3DDiSxkhmksdoFTj7OSXGp2oCO5Q/KwBjmkXTsz/MR49b2hn0wU3mfSYFCfEq5tdoOThEWpi0RXkRr0FkXZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734571620; c=relaxed/simple;
	bh=99wPxfN53ST3AJXTzazPQKk4Xg2gm6uJg1UvVQ3McAY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TQ+uetBS3wZBVk81LoTaLpq/dER9R86PcfavDjrkY6oiuj7XBjCTJLBBtQtGkfJEOraWwhyhEiTs7RugzBEUNGlvVJMFEm5jjP62FiaCvo2ONNsuIafX8/uMAyzUJlCaObcjGAB2Q9LekeuRgAeWYUmfa+2VSbQ+Qyar+uo8hC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QPXg7s8B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734571617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=neKHHOrqLKTUJZm/c1ca9O8pPG3z2Q1aYrdHAAhgiWs=;
	b=QPXg7s8BSC7/VyyDyKkiiYlYLu3nY2E7R8zWIuyCv5Shtu94zPGWhAHilUzh7FXat7YITr
	0al46y4ne2yMruWlykwD/VHqYrPdgMOXUD4vQjuShLz9BGoDhz1fBAUbqIS30tgKxCH/Im
	eywV4klDacO3kZyX+6tDB/hj2vm1xj8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-fY7an27GOmSgEhlv0hhvOA-1; Wed, 18 Dec 2024 20:26:56 -0500
X-MC-Unique: fY7an27GOmSgEhlv0hhvOA-1
X-Mimecast-MFC-AGG-ID: fY7an27GOmSgEhlv0hhvOA
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d884999693so4773156d6.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Dec 2024 17:26:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734571616; x=1735176416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=neKHHOrqLKTUJZm/c1ca9O8pPG3z2Q1aYrdHAAhgiWs=;
        b=ZsE+XyABnp945IPgwIFSKNmubCYkp54X1sws+l4He89fVD2CU5cEPX35pKKXWaIAr9
         +L6Yxvk6Teu/Rk5XKBXmNVbHSJUvCJhbg3iTCn+cUQocVDkmXCk5K+aW6VBNt20cXsxk
         VQ8goj6ujKtHNA8v0d9iUqNcVZu+itLd8MuD5YPJ2ZyQB9Y5llzJCSmOMBGwd+Lkp2jf
         Za/Go5xX/Jk5pqfjV/NuE8bPgKn6dbvmdWu0FNSllEoOjiXJTdPVbcyDiDA7uord6Si4
         +0XFs59Ss70o3UqzcSSVFyhVnkoBdKF/DG9qMwI0mxioKjZC6gNy89VlcueQdZp3irq0
         K/Tg==
X-Forwarded-Encrypted: i=1; AJvYcCX4XdxYOU5BSHd4PBPlFIanaVjSWibpAVt+2goEr310Kgbqqo+ytSt4xnhNXe9peYkN23R6gBOgdA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQb6NMw6TrMgJOg79ROv0sT773LlfRu/6NY0trAevJQPFN8WFK
	Rzh1gRmUi8roP2Lwt63vPszEfyEolf9NBuLhblPddY37fHUCtH2xOUdREIHPXWVB0jR/WG3kOSo
	14tBu9xUwyu+dmO5NJjOzgHNqcPE8zZ9G/ac5T4lJZBg1cls3rcvTA750
X-Gm-Gg: ASbGnctvFbzvnNG/OzzQwW6lnO8Wh7kESxHsuKg0AqFAeF86XKNyPu4ZQfsnu1F/5us
	IPsyFKdzWoZfmhTjGq+9YgoyYUvcdq0URCxA613nCWGdLuvIJAtxIRtrksoJA9Vdt1zNnfwdjfH
	J8FylkFoK9WVI0RYbRFzPZhUd5rrOrhfCbi927YlryksLS5kJ4idjWW6F+1EIShRCYTsl8GjsAo
	wbfVwJB8NU+iJoW3MAUslSxpl6vMCDTLIRImrjh06PXhfmbmWN644LKy0dzMUTPWs6C
X-Received: by 2002:a05:6214:e6d:b0:6d8:8a60:ef24 with SMTP id 6a1803df08f44-6dd0918e5b5mr92324216d6.9.1734571615896;
        Wed, 18 Dec 2024 17:26:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2yDULLdpZOuZJSxavMDC9v15EeM2OTT0Cf1nbCHYB7AD7elp9vtO9jnuLUeqVHgDWiRJ92g==
X-Received: by 2002:a05:6214:e6d:b0:6d8:8a60:ef24 with SMTP id 6a1803df08f44-6dd0918e5b5mr92323866d6.9.1734571615559;
        Wed, 18 Dec 2024 17:26:55 -0800 (PST)
Received: from thinkpad2024.redhat.com ([71.217.66.209])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd181d82fbsm1567176d6.123.2024.12.18.17.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 17:26:55 -0800 (PST)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Shuah Khan <skhan@linuxfoundation.org>,
	Thomas Renninger <trenn@suse.com>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-pm@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH] pm: cpupower: Add install and uninstall options to bindings makefile
Date: Wed, 18 Dec 2024 20:26:02 -0500
Message-ID: <20241219012606.38963-1-jwyatt@redhat.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Installs the .so and .py files generated by SWIG to system's site packages
directory. This allows the Python bindings to be used system wide. This
commit also includes documentation on setting up and installing the Python
bindings.

Signed-off-by: "John B. Wyatt IV" <jwyatt@redhat.com>
Signed-off-by: "John B. Wyatt IV" <sageofredondo@gmail.com>
---
 tools/power/cpupower/bindings/python/Makefile | 10 ++++++++
 tools/power/cpupower/bindings/python/README   | 25 +++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/tools/power/cpupower/bindings/python/Makefile b/tools/power/cpupower/bindings/python/Makefile
index e1ebb1d60cd4..741f21477432 100644
--- a/tools/power/cpupower/bindings/python/Makefile
+++ b/tools/power/cpupower/bindings/python/Makefile
@@ -11,6 +11,7 @@ HAVE_PYCONFIG := $(shell if which python-config >/dev/null 2>&1; then echo 1; el
 LIB_DIR := ../../lib
 PY_INCLUDE = $(firstword $(shell python-config --includes))
 OBJECTS_LIB = $(wildcard $(LIB_DIR)/*.o)
+INSTALL_DIR = $(shell python3 -c "import site; print(site.getsitepackages()[0])")
 
 all: _raw_pylibcpupower.so
 
@@ -28,6 +29,15 @@ else ifeq ($(HAVE_PYCONFIG),0)
 endif
 	swig -python raw_pylibcpupower.swg
 
+# Only installs the Python bindings
+install: _raw_pylibcpupower.so
+	install -D _raw_pylibcpupower.so $(INSTALL_DIR)/_raw_pylibcpupower.so
+	install -D raw_pylibcpupower.py $(INSTALL_DIR)/raw_pylibcpupower.py
+
+uninstall:
+	rm -f $(INSTALL_DIR)/_raw_pylibcpupower.so
+	rm -f $(INSTALL_DIR)/raw_pylibcpupower.py
+
 # Will only clean the bindings folder; will not clean the actual cpupower folder
 clean:
 	rm -f raw_pylibcpupower.py raw_pylibcpupower_wrap.c raw_pylibcpupower_wrap.o _raw_pylibcpupower.so
diff --git a/tools/power/cpupower/bindings/python/README b/tools/power/cpupower/bindings/python/README
index 0a4bb2581e8a..952e2e02fd32 100644
--- a/tools/power/cpupower/bindings/python/README
+++ b/tools/power/cpupower/bindings/python/README
@@ -48,6 +48,31 @@ To run the test script:
 $ python test_raw_pylibcpupower.py
 
 
+developing/using the bindings directly
+--------------------------------------
+
+You need to add the Python bindings directory to your $PYTHONPATH.
+
+You would set the path in the Bash terminal or in the Bash profile:
+
+PYTHONPATH=~/linux/tools/power/cpupower/bindings/python:$PYTHONPATH
+
+This allows you to set a specific repo of the bindings to use.
+
+
+installing/uninstalling
+-----------------------
+
+Python uses a system specific site-packages folder to look up modules to import
+by default. You do not need to install cpupower to use the SWIG bindings.
+
+You can install and uninstall the bindings to the site-packages with:
+
+sudo make install
+
+sudo make uninstall
+
+
 credits
 -------
 
-- 
2.47.1


