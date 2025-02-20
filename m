Return-Path: <linux-pm+bounces-22546-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10126A3DAC3
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 14:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4609918910AF
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 13:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23A61F7586;
	Thu, 20 Feb 2025 13:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBqyb+TA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447851F7545;
	Thu, 20 Feb 2025 13:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740056741; cv=none; b=LauE9TkZn1LQH5UAYNKQ6+fWrdzFuPsvs50gYQLyJd4b/6b73+kNYv81+L8z2zp8KnOv+Wn4F/a+TBlNtdgCEcgLTVnesfw6Aq/1dcQorCQX8gY4I4guiDN8pOzxlp55ned4j3Txv6Ypaok6NPIIcTjr/wU2bI3hRkr/H/Pz/yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740056741; c=relaxed/simple;
	bh=TrV6ro0Q1mSgBsAukVJAZaVwERtuN8w1JgS+lCFgTbw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FF0z51dKq4Pn4STfApfhkiZLGgMINhy+c+i1JukEMGa1uWGp2ZlYeBZEKrLeWU1ZuSd4s/f5KDrfLaV++XaEaTP/dttxHsmiH73KrwDyxepu3TzsOPf9hF8Ka6Qqg/7dwa9rUF7SZwDtYgfBeg3ejVrzUnhoWNUGNuw5nGpKeIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBqyb+TA; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2211acda7f6so16958355ad.3;
        Thu, 20 Feb 2025 05:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740056739; x=1740661539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HxUOw6vbJaKxcjkUoKdp/eCfpF+qsW/WJEb9V0265yE=;
        b=eBqyb+TAhNBilCcbUd+xaZvL25HHrkTivEGj9E2j8NB11DYIRDSrofCDH9hSAOtyui
         Ug3IcVKH+e9l9uzwj6R2t7Z1HQP722ysGr9OcE5+Ofj0CMnz2yQZSjMaF5w6g14RnEKa
         ZOVvvridm2m2yf+mp+J95glmNygYSuPuth02PWjUxTPKp6x77z5tEtho167C8DK31lo5
         45f76QQixvpjm4dyC73CGu/mq3xuvyEhC6diCHPs3wTZbJpjy8ZVJMwhPo8ckLmek834
         pI7wZXUmL13CymlO3yceJkcps35Sbw0STuE3j+Mr1dDA3JZhoq7RpoFI5iyP+fDtthEm
         dWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740056739; x=1740661539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HxUOw6vbJaKxcjkUoKdp/eCfpF+qsW/WJEb9V0265yE=;
        b=Yfrm54SYTTM660e5DESH8JWLpVz4V3sD4n93pkCRb5v3NdxQbxgbHUB2hYENQEoTgN
         tPkmRy4K7ZdzuYa97HE2sluBpeMmLLa6spfrh68nOKWMHtwdgY1kKurGRm5BdjvdqJ4I
         l+gqJPJ5xXbK2EcnnQ/EtIbSFhIPvYJ45phx5H/QsBZTLg00/x53GwVO/x+D2Y7/fUB/
         EvxDgyQSiNGqiJGkjJfl2Za2w40xvd0kJwZ00/tzxHm8Rb686bZjMEKuejAMV/SRc4dC
         QQchmv5Aw2IQD/FBi3d6reDfK47lpqzTJDsjiu9Q9b9/dzyf9a/h3mVd9p2HpNeX8zt0
         +Rgg==
X-Forwarded-Encrypted: i=1; AJvYcCV60wN+Z+4bwh1a9a7JFjZrZbiRN4Y7o/2RZpiHhPy+2wsX622zbDLFrVzZ2vC9Z/xoYXh9JjPFzps=@vger.kernel.org, AJvYcCWdQ5MWMyfBRi7DBJJz6hAQkzhDaMN8/HjPhKaM03Mn/6vG2VMdeuLwehbR08gM6RInnSQnhvqIKQA3wjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXi6jxHW7IvBiNQMlQ7r3waSETKEregsP82fJY+QXb+f3rmyrw
	2uuETyZmJQxDkTx/N4ezFZonRp63NDNUjyE1lp2Fn1ALLvNytn0tHAJ4vuBY
X-Gm-Gg: ASbGncsCqYxZE/WwiXls2o1J8WTNFYL9uA8jSVgmEbaAh6/qKWdxEJcrsVS3P+4YweY
	u9RCw2LeFh30JjspUyidliGZWJsjEWJtt744mvgt/K3JNSVYgbT8ibp/xH0wNQkVEQPLNllGNq8
	i4hiurMtgdpKgcd9cpa9sNJzUAS8iMO4aOjkKHFzh6wspwb50I6aWG3mkUH2ZrJUTNzD1ZgtgVU
	Zxo6HvO34Kk79Hd+nhYzXB2cb0YCL1XrwDtd7OkTQeL3pTTBDLxWhOPitSGsYCy+10uvZccbACD
	adZyU4Rus6urjx3loGpVyi/mSyyWkVEOIoAiarM/T7q43+4z715aYgqiFkuW
X-Google-Smtp-Source: AGHT+IEkHNR/ifb1J09lA9COzE6lvZ+RXEoIQ7uRtxeNfu7hh8P2HHSAQIVFk1lpabaRpwAmDLewHw==
X-Received: by 2002:a05:6a21:999e:b0:1ee:7f20:e44a with SMTP id adf61e73a8af0-1eed4e52f66mr12190355637.9.1740056739422;
        Thu, 20 Feb 2025 05:05:39 -0800 (PST)
Received: from localhost.localdomain (59-124-78-18.hinet-ip.hinet.net. [59.124.78.18])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7326a52f865sm9592455b3a.80.2025.02.20.05.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 05:05:38 -0800 (PST)
From: Yiwei Lin <s921975628@gmail.com>
To: trenn@suse.com,
	shuah@kernel.org
Cc: jwyatt@redhat.com,
	jkacur@redhat.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yiwei Lin <s921975628@gmail.com>
Subject: [PATCH v2] cpupower: monitor: Exit with error status if execvp() fail
Date: Thu, 20 Feb 2025 21:05:29 +0800
Message-Id: <20250220130529.4515-1-s921975628@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the case that we give a invalid command to idle_monitor for
monitoring, the execvp() will fail and thus go to the next line.
As a result, we'll see two differnt monitoring output. For
example, running `cpupower monitor -i 5 invalidcmd` which `invalidcmd`
is not executable.

---
V2:
- fix according to review from Shuah
---

Signed-off-by: Yiwei Lin <s921975628@gmail.com>
---
 tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
index f746099b5dac..7f8958f68eaa 100644
--- a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
+++ b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
@@ -6,6 +6,7 @@
  */
 
 
+#include <errno.h>
 #include <stdio.h>
 #include <unistd.h>
 #include <stdlib.h>
@@ -294,7 +295,10 @@ int fork_it(char **argv)
 
 	if (!child_pid) {
 		/* child */
-		execvp(argv[0], argv);
+		if (execvp(argv[0], argv) == -1) {
+			printf("Fail to execute %s\n", argv[0]);
+			exit(errno);
+		}
 	} else {
 		/* parent */
 		if (child_pid == -1) {
-- 
2.34.1


