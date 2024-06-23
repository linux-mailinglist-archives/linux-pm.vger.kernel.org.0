Return-Path: <linux-pm+bounces-9839-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E7C913DB0
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jun 2024 21:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E455B21ACC
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jun 2024 19:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF32185E5E;
	Sun, 23 Jun 2024 19:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBE7PXyR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530B01849F6;
	Sun, 23 Jun 2024 19:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719170397; cv=none; b=Vz3CK3nhffwL5HrveOJiT18i7YFnIQRtf9j7HVgS9MjeikwIuTHosCHRv6mdaiwMIUy/IhXFvqojK1W4hN/d9UJr535Va6c2jOYxfT5VHC7GxvXZIfa3ukGV+nuJlXFHsCUQbVYhoz9jMonM4LZTSI+TOWLFC0IcIsjns+2bNZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719170397; c=relaxed/simple;
	bh=xa2KLdq7W6RVjQg6+y9BC11X3FDbzdTyZBQ4OiqCKvg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rWNR6cuhUITJSE5d7/S6TsnWSl1nf7hm2QEdPM8IwrboFOaMc7xfKKD3yc6gBoFnl6UrHSCtojGAMAbzsw7VA1YkdckL4QZtdSYM7nO6OwwrL29TgSYSJnPTcNkiJPSFxo9/ZVC8zq6bxfvS2cf8ykEI/YUO8e+AgPTg4xpYmO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PBE7PXyR; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57d10354955so3930190a12.1;
        Sun, 23 Jun 2024 12:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719170395; x=1719775195; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TU8jQiuoTxoPN82zxmj2fSUzOkEC0jhTRueQItJpgyQ=;
        b=PBE7PXyRi0VRM/B3qhLgcG9IVwDcfnDWff+B+7aFbFt0OMr8BR1J0xXYA5XmXBkZKh
         2FDUbCxSI9AzA2j6FyPQCdv2ih7uy0/tKD61Y9ecsCi+nx7pmYDHnctB4FzoroFytzOb
         NgbJLbwdCPV+xtAMwil9ddXrTMUp6VjL8dbhOCznSMWxThX9uNTxmGTKoSbRTePzzvgt
         gylFuMZPc5UW37o3sNoi6SUW1TJekAsX8iQl7v2aQeAgMhnRX8Y/0O3FUotCCBF5d5HJ
         me909VmAhQxI/ONXodZCHnxQ20DCZNbG0rILY2GOEMU/jpxPwRVrzb+YU2Jpl8919Yo+
         xZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719170395; x=1719775195;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TU8jQiuoTxoPN82zxmj2fSUzOkEC0jhTRueQItJpgyQ=;
        b=JDvZRnbHp3A+yw3gqUanOsC4m8QD1IRep0HF962fAhkTrMnntBmLAzxg+jhtTyUS8M
         al9gPCEQhUiM5pkkbxWhcOCqa1en8WZJbWANnGR7mz3fg+up3F805C8GfXSO88vDuqRz
         ei/UKnm2/IWueuOm0ZWVZ+tTjlbKO9CJfbvLv+/u663gw2XFNZj62uEGjtgsk/g7wX92
         CjT3u/14qHMC8gsAzHSJi2DHQoYVooRNfetGvPus64o/oKLLce4Lz5O2Ccu3LRTLAfPH
         GyyGl3tNC6oDZJ6kW3GKaWGxA5o5GXrRFF/+foa8dlnXb/etAFvmwzYZVnOL+MEUykQ0
         S/HQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrYPLgduUmr6ik01OIz0kM8S9ReltyGZF/vuJeLHXu8TWIKOrH8s/Gd9AqnfVqC/fisgbszZ3HvSsTyb3lO5xumEQoq12SqBjumkXo3q96JkMRRMIQ3+iGEEdZJ9uIeUB6G9o6EQ0=
X-Gm-Message-State: AOJu0Yw/xUPTYqTOrpfSfKKZ3XedqLO9tDAjGLgbjZ2oY9qFpqyD6Trc
	LMSElNd0CXALFZArlzWSDZckeKCDgntUcu6k7mpGu5XyAvWKAsaVXMBlEA==
X-Google-Smtp-Source: AGHT+IEMj3QReGXW2XCosud9QQe++cQSZMwGjwTD1Bb7BQ39HC1Di8QIpikkv+2SVm6o9K9/M2LFFg==
X-Received: by 2002:a17:906:720e:b0:a6f:ac90:754d with SMTP id a640c23a62f3a-a7242c9ca1cmr183888566b.29.1719170394486;
        Sun, 23 Jun 2024 12:19:54 -0700 (PDT)
Received: from [127.0.1.1] (31-179-0-202.dynamic.chello.pl. [31.179.0.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7255b56e48sm22075166b.176.2024.06.23.12.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 12:19:53 -0700 (PDT)
From: Roman Storozhenko <romeusmeister@gmail.com>
Date: Sun, 23 Jun 2024 21:19:44 +0200
Subject: [PATCH 4/4] cpupower: Add 'help' target to the 'debug/i386'
 subproject makefile
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240623-make_help_rest-v1-4-4bd3fd51064b@gmail.com>
References: <20240623-make_help_rest-v1-0-4bd3fd51064b@gmail.com>
In-Reply-To: <20240623-make_help_rest-v1-0-4bd3fd51064b@gmail.com>
To: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Roman Storozhenko <romeusmeister@gmail.com>
X-Mailer: b4 0.14.0

Add 'help' target, describing all user-available targets, to the
'debug/i386' subproject makefile.

Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
---
 tools/power/cpupower/debug/i386/Makefile | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/power/cpupower/debug/i386/Makefile b/tools/power/cpupower/debug/i386/Makefile
index b3f771039b17..361265170986 100644
--- a/tools/power/cpupower/debug/i386/Makefile
+++ b/tools/power/cpupower/debug/i386/Makefile
@@ -39,4 +39,16 @@ install:
 	$(INSTALL) $(OUTPUT)dump_psb $(DESTDIR)${bindir}
 	$(INSTALL) $(OUTPUT)intel_gsic $(DESTDIR)${bindir}
 
+help:
+	@echo  'Build targets:'
+	@echo  '  all		  - Default target. Could be omitted. Put build artifacts'
+	@echo  '                    to "O" cmdline option dir (default: current dir)'
+	@echo  '  install	  - Install previously built project files from the output'
+	@echo  '                    dir defined by "O" cmdline option (default: current dir)'
+	@echo  '                    to the install dir  defined by "DESTDIR" cmdline'
+	@echo  ''
+	@echo  'Clean targets:'
+	@echo  '  clean		  - Clean build artifacts from the dir defined by "O" cmdline'
+	@echo  '                    option (default: current dir)'
+
 .PHONY: all default clean install

-- 
2.34.1


