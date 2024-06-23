Return-Path: <linux-pm+bounces-9838-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE77913DAD
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jun 2024 21:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF0211C21668
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jun 2024 19:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2431849FA;
	Sun, 23 Jun 2024 19:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzCAbqqL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF629184121;
	Sun, 23 Jun 2024 19:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719170396; cv=none; b=u80ASLdll1m62km7D3zOFtMnOruWkAd6OwNXdAIviLGvslFSjzQfOSEEw9rNDp96Nu2B4ovDu1Wh54keEO2DhKDk5NgqCb9zoi4dj/l6iOFk+B9dVxjYLTX3m/aUfxjTM84cyp0E5smod2l56dLOa4y7VB+KVF+3psm0wQfBzV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719170396; c=relaxed/simple;
	bh=ffSXY0Ups+C9EqoExRjE1Ykww8QMqpXJaodcArBoaO8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DmL/kUhfYBCRiRHtuLT57hdmAvjSYTqWQKXTIqgCkYnpakeCOcV3nDi1Eia0Hf2kkDqZdyZD2zAHUG90vhpF/VWKA+MF2OopqZ1Ab5BeOf4YDFyC5TEA14lT49KZsp+ozWYyHFaZYUmnGtMHoq1y6o69kdNuqbTmL3vGxGUnxiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YzCAbqqL; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a72459d8d6aso82426266b.0;
        Sun, 23 Jun 2024 12:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719170393; x=1719775193; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KluxZFImXf3jUaAoYhwBsEtDYQ+FE6oJ0LC1KjnPSEs=;
        b=YzCAbqqLN2Qp64WXWTeHwxVZLkthMP9+dntZgOHEfThmcv2Rpa3jqXKwiJhup2HE+y
         8KFNlOesb5z3leFVP0xNFpR+Jbhw4+PpIzwFuVS7D+XqAekYdLL4W9jBveXfcHvDHjS4
         3L+1nMHdmvXCQU903Pj5swb7BtL/vzZihEz9gAWsKhDmG+uKvIO8xWZxf8Yrt+Jhv+37
         dtGUbqdRbUfLYooV0LbEWwCLW1RgLtW3NiheCqQNKl9da75VfRaNUCfaJ9zXesmUXlst
         vD38DfRuybJbxZVw8zSSLt8eLMW3Vqq+jNGT+4QL9Brlu7VSgHdBWs+TUC82vmObbzWy
         Lk6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719170393; x=1719775193;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KluxZFImXf3jUaAoYhwBsEtDYQ+FE6oJ0LC1KjnPSEs=;
        b=VAMbcpg4tulzYT+CKL5ifS4RVWqviZisIWK/dYjp5ZSL6WLYd6CoT/tw206dUNCYB9
         ItjVaPgWBiBpUNtyJyaBiqt5Weeia0F6zqWRRM6cfvtYtncun133U/42pAISvr3iM20w
         yIis/DFCNJYNPgO3LpkAWwEVxjky8WKW3OfLPRER+P8sAlggeF1it1v9hVly9AtIZ3AJ
         lcojGvb2KWaRGYPe8CYR4L3nIcntWTyi2AfW71+mGxa1Z+GStZppPcARPkOL0kxJgR4b
         qnvkTWPkPDsemCeno4gfBK7CRNLT5ml9itK2tix1sDBSuwg+4BoIsxnchMIQA1m6FLKm
         fGTQ==
X-Forwarded-Encrypted: i=1; AJvYcCU82/bcnsBHYWXDV4F7/xgEgl09gtorm1F3/yJ7+d8q8j7mkZ1BNn8zGrh1IXmRFa1F96b0TjAMM14rZZEednybVa4iER3jXwbv98kTpmRZi4Glpc76JVq3pD4Zm6ZGwEnLzwPCZfs=
X-Gm-Message-State: AOJu0YyYoMj55gFRBbaGRPqS2iHXKEd7OgEyGOgCej1PLs9sv8pSi8w5
	QaacW+aVmbcTJR1qpbdFyNqltLGT3h3uNvMumLaswEWAptj5+/Ib
X-Google-Smtp-Source: AGHT+IE9K9KZPtMOgI4pHg3Qou3vt2CyTTXulRVx0CL5pTUhEO58v4uMcmVvW8nmv+7bxwpMcjqMng==
X-Received: by 2002:a17:907:c78a:b0:a6f:af87:b426 with SMTP id a640c23a62f3a-a7245b5660bmr220939166b.20.1719170393183;
        Sun, 23 Jun 2024 12:19:53 -0700 (PDT)
Received: from [127.0.1.1] (31-179-0-202.dynamic.chello.pl. [31.179.0.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7255b56e48sm22075166b.176.2024.06.23.12.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 12:19:52 -0700 (PDT)
From: Roman Storozhenko <romeusmeister@gmail.com>
Date: Sun, 23 Jun 2024 21:19:43 +0200
Subject: [PATCH 3/4] cpupower: Add 'help' target to the 'debug/x86_64'
 subproject makefile
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240623-make_help_rest-v1-3-4bd3fd51064b@gmail.com>
References: <20240623-make_help_rest-v1-0-4bd3fd51064b@gmail.com>
In-Reply-To: <20240623-make_help_rest-v1-0-4bd3fd51064b@gmail.com>
To: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Roman Storozhenko <romeusmeister@gmail.com>
X-Mailer: b4 0.14.0

Add 'help' target, describing all user-available targets, to the
'debug/x86_64' subproject makefile.

Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
---
 tools/power/cpupower/debug/x86_64/Makefile | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/power/cpupower/debug/x86_64/Makefile b/tools/power/cpupower/debug/x86_64/Makefile
index b1b6c43644e7..4b35b2474182 100644
--- a/tools/power/cpupower/debug/x86_64/Makefile
+++ b/tools/power/cpupower/debug/x86_64/Makefile
@@ -28,4 +28,16 @@ install:
 	$(INSTALL) $(OUTPUT)centrino-decode $(DESTDIR)${bindir}
 	$(INSTALL) $(OUTPUT)powernow-k8-decode $(DESTDIR)${bindir}
 
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


