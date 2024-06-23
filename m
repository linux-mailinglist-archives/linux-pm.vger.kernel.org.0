Return-Path: <linux-pm+bounces-9836-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB66F913DA8
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jun 2024 21:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C98301C21669
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jun 2024 19:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9016A1836F2;
	Sun, 23 Jun 2024 19:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/G/weMA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8638146008;
	Sun, 23 Jun 2024 19:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719170394; cv=none; b=TxaseVbGiIVN9gUt/w9Sxb56oIeEuRzZMnL1oY/QOlGd9vynt9le1lL2b9g3bynnsarvNnNJMD+ydk9TviNHcSPCXMTe9sYLEGXjUU8g953MhHgKLBCuf3hMJrd+ZaFFos9ear3rzzX84HvPppFDgt21z6GwUABUW7c10gJddVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719170394; c=relaxed/simple;
	bh=00qXA6IL7Yw/S9twvSBbKymSZnnafOIvWhYBnU7NjjA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qMmZ6p/A+3lPpqp2ogBbSLTfWByq+vZuAdDQp8Axm8vrw6DDagX4obYaMEzrO3ulHLKNVUX2xmhqpYbeqBnTfVXSo/43mJg7JeWiQXz9h3fML74gQDP/H+3Ko30sGgx0xzGWt0PRxqQ8mw1UojKEXjOx3FlFjE8AROp/oGdA+64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/G/weMA; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7241b2fe79so102464266b.1;
        Sun, 23 Jun 2024 12:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719170391; x=1719775191; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WaTIi5aYkZaCgsP3IdLGfbPnML7N0WxBYlilWAaafU4=;
        b=P/G/weMAfwaibjvgmqocAUZo/pX2ty9VARq5KJMqkNQizapi8LIVKzfz8zGmshSKo7
         dNwLrqfq9JibgidLaFbZPiJOB4NTp4IGfAWRQ34sL7mQDOklFuKy/WPxL4zA+wlaNGsF
         F2cBbg7zwMGWrB/rZch+A9bFXxJ31PNQbzVaqdJT6/bAw6/r01GXLyZEdGghjhlP3vKd
         j3aqb86KxqDy8Q49bb7pNjF3psAngQDvzNxqJfdgnk5Z1B6diYZUs+0ay79Ti4n9b0Kc
         SAqdYYUeAYiSHE3U2/NzIkr0UMNFVU4YwgA7iBXM1gtVj8kOSx7XF40wNpTioxAdkQII
         /KBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719170391; x=1719775191;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WaTIi5aYkZaCgsP3IdLGfbPnML7N0WxBYlilWAaafU4=;
        b=HUFNwG4Z+mncdWT3GQnwlXTqBl2vqXmJMxX+jeCHtLUuOHuJf7ysV1uY1e5UECW5Jz
         9wq7SkqYj3ZLaF06JlkLRekJdVGdXPkiXBuaEA5XApU3K8pZDksrBS259q307OL6FosK
         cPC/gSu9WSodWUByEOvlQYf8y1WhMdJ4beCJfmR/MWf8feS0hpAg28qfShY9kA9M6Xpb
         s+rOTL1Y9Dm6n1U8jIIEGVyR4DERavLVv69D6GCLr4l/q2ypEGD/E/BU2UPbGGl6olZZ
         3eLuvWk9hszgdS0AkFL+SoPV/gMx7XQcY31k1/Rdb5vZhHyBAFXS/DKCgAP9IarNOK9C
         xkTA==
X-Forwarded-Encrypted: i=1; AJvYcCXwUcvtXUJSLvJdejrwefmFfDMi4TWwgQcIZCm6ZWVNtWvMLaRbWwIRrJwdIpklnJ+LFF3FiC+2FLJrWPa0+xat4IcTWAEbMcxvKX9P9Zm3HpETGJF6hikpyEKpsN4cg9sBpkYr/zc=
X-Gm-Message-State: AOJu0YziDrhH9aBna3rw4w6lOiRrEFfqiGBVkSHCM3gZjZ++6fN6nSEB
	ytC/k8I8qhzS2yw0E/u8RR8q7UkSA1YMxIsyDHWKPaSPPS7gRMBD
X-Google-Smtp-Source: AGHT+IG3csI2gQK9zlXBPvg68Su41NrzsH15u4ipxEnqF+lxNb2ItVc/R+ZUCCcBECx6wd2Se2kLDQ==
X-Received: by 2002:a17:907:a70d:b0:a72:542f:8251 with SMTP id a640c23a62f3a-a72542f830amr62708266b.56.1719170391045;
        Sun, 23 Jun 2024 12:19:51 -0700 (PDT)
Received: from [127.0.1.1] (31-179-0-202.dynamic.chello.pl. [31.179.0.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7255b56e48sm22075166b.176.2024.06.23.12.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 12:19:50 -0700 (PDT)
From: Roman Storozhenko <romeusmeister@gmail.com>
Date: Sun, 23 Jun 2024 21:19:41 +0200
Subject: [PATCH 1/4] cpupower: Add 'help' target to the 'bench' subproject
 makefile
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240623-make_help_rest-v1-1-4bd3fd51064b@gmail.com>
References: <20240623-make_help_rest-v1-0-4bd3fd51064b@gmail.com>
In-Reply-To: <20240623-make_help_rest-v1-0-4bd3fd51064b@gmail.com>
To: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Roman Storozhenko <romeusmeister@gmail.com>
X-Mailer: b4 0.14.0

Add 'help' target, describing all user-available targets, to the
'bench' subproject makefile.

Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
---
 tools/power/cpupower/bench/Makefile | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/power/cpupower/bench/Makefile b/tools/power/cpupower/bench/Makefile
index a4b902f9e1c4..81c862297782 100644
--- a/tools/power/cpupower/bench/Makefile
+++ b/tools/power/cpupower/bench/Makefile
@@ -41,3 +41,15 @@ install: $(OUTPUT)cpufreq-bench
 clean:
 	rm -f $(OUTPUT)*.o
 	rm -f $(OUTPUT)cpufreq-bench
+
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

-- 
2.34.1


