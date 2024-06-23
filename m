Return-Path: <linux-pm+bounces-9837-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A459913DAC
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jun 2024 21:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 040522831FC
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jun 2024 19:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F98E1849CE;
	Sun, 23 Jun 2024 19:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWwcipGq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6064617FAB1;
	Sun, 23 Jun 2024 19:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719170396; cv=none; b=LlEyaglikVcNDNQ3NA9fDmHWoB2HvFrZ7Q5yMu1RCq/sEhY+m0mXBmC/6J7BAPFQUOsMZizrpkbUKN+dGOGDAWrZbNUj5nWcKo+mVTLGe0YMnJyH9CVlGQUdu3Vy1sSdhG5HR28YZpEyAz/WTbH1tbjxQZJ24iiFp3Ywac8SUrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719170396; c=relaxed/simple;
	bh=VmwSz+BAjdN9l3Gbniwi8kg+aJdHbekuX/d8gaiKTsc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RuMp4dXJ/aRv3BfT41LjavBoPbTIBMsJMfzF7zA/oXJrer0JmQEy1CphudiMGxJ/xcwyn4amGq1pQwwJkanWYCzKTQHJUz3EbdEdxLM3CQvbN/VcIKX0WNjdghuEy5DxDeB144tsZBBhVvV0ty6zfVkM5huWYdGgptktas9ISnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWwcipGq; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a72420e84feso127088466b.0;
        Sun, 23 Jun 2024 12:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719170393; x=1719775193; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4QuRUv1/L5Hp5ElG7r1g/1VWFHjTJCPmTUEIIG+Ycvs=;
        b=nWwcipGq5fH8VJsmeTDHDodC/hLqvBZeHy8nB0iKCfrsTB1QO4iON3ieoTRpAfwQ5q
         LiEswB3i2UA/tSdT3sZcPudopt12xYdsWAnpZH6GdVe/vbdp9b1+wRNVbryaVn8dr4Uv
         A1ftvKFgp9dWy7jVQ6NQjQRgybyhG+qGfTDxp2R9M0EUzfxhyD7s7sCGw2aJ5h2odbFu
         nK4AjyK/BjiEE3Bxsp4AI3+YgfzyFk2M6vxEO5nyfcS3hYrpq1hgaV1+aK+vAqiOWAaq
         ghcQmLCQoD/e2FXudfYpVaDf0k6oAM5O2TmzOCsfyxU2AnRCcOTzhfmUvToAmYUU3XZ8
         teqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719170393; x=1719775193;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4QuRUv1/L5Hp5ElG7r1g/1VWFHjTJCPmTUEIIG+Ycvs=;
        b=H0B5Eq9mnTy5OLsSVvXggvW1ChKQyqHQ7HSoW+iKqknxWONtE3QsvI6+FNqSx5CGNk
         lPbXeCb3sEf+EWvb2IvI5ylQGFO+O6TqPAK0kFwNWe7mnmG5XeP8PlZ9lXZWUuzZGQ6T
         brTBOrsASrN+G6M15NA2mKsBhY9KkzHIa1reCTQbOOy2f88zZ/QBx3Qlia7hGGBFhe2F
         ZeugnUxslPiGFz3b4XvHagvKMbYKbKG7w3MKfmxV92GOBVk6ZzDQK9R5orHwPG++SDoM
         uXLBHvVlTYMUPsP1O4kRrXDsEIFHUDFZq5kqe1niSGrcFAAmRkE76a9GF/FuiPMbsRdJ
         XrCw==
X-Forwarded-Encrypted: i=1; AJvYcCXDszv2oRteKHasBkYL4gYrL7UdAf3ygKrkTG6s0SX8rf79e1MQe1H4SQTcNZXQV9uOOC6lpxD/JiaEGMQcAsY/BXEnIIEznDGItjAMJeWhsBy+jf4UnzLUhBLm1b2mlBssrryFed0=
X-Gm-Message-State: AOJu0YzgUDLTSOAwmiss5V5Jku07QtQGc8Q9JPNmF9nRc7ZNBwPXD0nQ
	hxpjg7+Hm19OCDhzppfqkSGCSTCEdv+JxpT/6PWcRp0P6eg+zpV0
X-Google-Smtp-Source: AGHT+IG8MciAXfNEKOvsCbPiKpWoLO3O40LAUfXi3c5TkL/Npg/phJmr8qidnoMbUIBOEHt63Q6cag==
X-Received: by 2002:a17:906:2657:b0:a6f:2e80:6e04 with SMTP id a640c23a62f3a-a7245ba3902mr205831166b.19.1719170392487;
        Sun, 23 Jun 2024 12:19:52 -0700 (PDT)
Received: from [127.0.1.1] (31-179-0-202.dynamic.chello.pl. [31.179.0.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7255b56e48sm22075166b.176.2024.06.23.12.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 12:19:51 -0700 (PDT)
From: Roman Storozhenko <romeusmeister@gmail.com>
Date: Sun, 23 Jun 2024 21:19:42 +0200
Subject: [PATCH 2/4] cpupower: Add 'help' target to the 'debug/kernel'
 subproject makefile
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240623-make_help_rest-v1-2-4bd3fd51064b@gmail.com>
References: <20240623-make_help_rest-v1-0-4bd3fd51064b@gmail.com>
In-Reply-To: <20240623-make_help_rest-v1-0-4bd3fd51064b@gmail.com>
To: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Roman Storozhenko <romeusmeister@gmail.com>
X-Mailer: b4 0.14.0

Add 'help' target, describing all user-available targets, to the
'debug/kernel' subproject makefile.

Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
---
 tools/power/cpupower/debug/kernel/Makefile | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/power/cpupower/debug/kernel/Makefile b/tools/power/cpupower/debug/kernel/Makefile
index 7b5c43684be1..9e4522a42c6b 100644
--- a/tools/power/cpupower/debug/kernel/Makefile
+++ b/tools/power/cpupower/debug/kernel/Makefile
@@ -21,3 +21,15 @@ install: default
 	/sbin/depmod -a
 
 all:	default
+
+help:
+	@echo  'Build targets:'
+	@echo  '  all		  - Default target. Could be omitted. Builds "cpufreq-test_tsc"'
+	@echo  '                    kernel module against the running kernel if the "CONFIG_X86_TSC"'
+	@echo  '                    kernel config parameter is enabled. Puts the built module'
+	@echo  '                    to the current dir'
+	@echo  '  install	  - Install previously built "cpufreq-test_tsc.ko" module'
+	@echo  '                    to the running kernel "modules" dir'
+	@echo  ''
+	@echo  'Clean targets:'
+	@echo  '  clean		  - Clean "cpufreq-test_tsc" module build artifacts'

-- 
2.34.1


