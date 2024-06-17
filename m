Return-Path: <linux-pm+bounces-9355-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E2F90B91B
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 20:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 843C228B108
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 18:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41215199233;
	Mon, 17 Jun 2024 18:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrVicxvG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848CF195815;
	Mon, 17 Jun 2024 18:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647577; cv=none; b=h+jT+ZNG9McVegUV2fVjE+CE0Y9VGSb36Yy42aKLP4pW6iwyWPdufEg7A1RDPln57pTUEgnpp/vW7An838XYBueD08njVr7CH0YucZYv9vrEfGY3pGBBlYLSOElKRBHcEz3PIsroK9zRdDKDqDd6py64UTibKd9xyBzhIdZn/es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647577; c=relaxed/simple;
	bh=3AMq0gYeuzXOoruOhp5BKicT9hKRQPLbej4HKeTM5Os=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=C18NgFqGJmxPR3v+Ga1IK+8C5Cg71ALOlSkzM3axjjPZxuLKS/XIwMJywC4NgYkgEghvZ7eL7GgN5oHfJXcN/qOAMy0C695PPL1x/Cy0eo+QBwPOpEPWQgMnwmabNvzwsLqUUm55GhOPxJwJNtEzwOhiTTQnPZZAzyDnT+ni1EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrVicxvG; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a6f0e153eddso595287866b.0;
        Mon, 17 Jun 2024 11:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718647573; x=1719252373; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lUISvzcrDyCit8PNRnbQzAbUSZEteCiaihQ3g2SOKCA=;
        b=KrVicxvGljhO4f0dD32vrkzgy0ntlnXz+G7ol9m1aAGU2TZd0JirIyWfly8tjHF/Uf
         B/Hy18qd7yYVAsTgoUG3RwGoHgwHfoaeE0+3GAa1oLO/F53PBW2BLsWVs2tOkVROGbNQ
         iAB+Yhmu6Avm+PBxDHintCOz+PZG4PSqP1WVb6tQwSwarEAB3dbX/twa87Ga0TZnArgN
         i6CYiXzPZIHtJmSCJBZfJ0FBPDadEPHQg2wuQ7igs/7ogqCFjNKxodbtGes9zuj2RXWO
         OKVcKb8E55oXueB/g6/DLMQOf3HjEvGe6TJHTa/MBU4TPK1ZqeGeop/tIy4Ee6sQs/JC
         lcOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718647573; x=1719252373;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lUISvzcrDyCit8PNRnbQzAbUSZEteCiaihQ3g2SOKCA=;
        b=BIMBb1ggHQMP880HRNCegrxweBJkVpLgRrwcMedyP1SNbGiOHduaq0wYZBEwiKEv7W
         qdWnWmR1qG6CZ5HnKjPq/8OoGZpevjsYXTUqJTpGdZqr157b180I+8pat/PbPuuGuJNv
         pI7v6pbAXYBHGmN2X+8VD+lRJWEneoS12cHbr20pbfIU/C0JJDJpjBheYfIs0u3RNyel
         SZgJ5WjUl+oGVzNgkv2yvlOIKjR/U1wXQEsPCugoaeSqusOym9lf6BwjiM6EjM6IcWke
         uTyNYPIivMU6YpA5znl5ODeACtM/JFtVHqqmbUuemoseZjPEvaMyinKao2nLltyuJmPo
         JSZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuWxKT6hTPUB27hHYIF3nhExX0Fm0i8fZvMTawGyv5aId1EM7fGW1xLwuArZWr3wJYvMHjBnC/nEG7/OQaFuGRr3EW0tt7zsW0LVAjxKLyS4Fzbvlpf8nFm7ew7nkdxPIq6nvMeQY=
X-Gm-Message-State: AOJu0Ywo+U3hDr1Yzqsw34IElqoXo08v9P5aQMk4912NxpCN3BvJ6MaM
	DB3ldlfcZY8IFWNY2zImZka6khyPgwZnAl8CfTW+vSRz2Y1z16a4hYbpJQ==
X-Google-Smtp-Source: AGHT+IEMFYDPSu1qgIgiLLkA57g1Y51O2z6R+OMPXA+p7HakfS4BoNAISIFGd86E/4RT8iEpRWOALg==
X-Received: by 2002:a17:906:37d9:b0:a68:bfd7:b0f3 with SMTP id a640c23a62f3a-a6f60d2975bmr686454766b.21.1718647573320;
        Mon, 17 Jun 2024 11:06:13 -0700 (PDT)
Received: from [127.0.1.1] (31-179-0-202.dynamic.chello.pl. [31.179.0.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f600cde92sm465175866b.205.2024.06.17.11.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 11:06:13 -0700 (PDT)
From: Roman Storozhenko <romeusmeister@gmail.com>
Date: Mon, 17 Jun 2024 20:05:57 +0200
Subject: [PATCH] cpupower: Replace a dead reference link with working ones
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240617-fix-man-ref-v1-1-81c218212e60@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAR7cGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDM0Nz3bTMCt3cxDzdotQ0XTNDE4sks0RTc8ukVCWgjgKgYGYF2LTo2Np
 aAF0r7GhdAAAA
To: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Roman Storozhenko <romeusmeister@gmail.com>
X-Mailer: b4 0.14.0

Replace a dead reference link to a turbo boost technology description with
a reference to a root page of the technology on the Intel site, and add
another one, describing power management technology, which includes short
description of the turbo boost.

Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
---
During my review of 'cpupower' documentation I decided to read about
the Intel's Turbo Boost Technology and found that the reference link is
dead. I couldn't find this article on the Intel's site. After careful
reviewing of available articles and manuals I decided to replace this
link with two others that could substitute the disappeared one.
---
 tools/power/cpupower/man/cpupower-monitor.1 | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/power/cpupower/man/cpupower-monitor.1 b/tools/power/cpupower/man/cpupower-monitor.1
index 8ee737eefa5c..b73830256166 100644
--- a/tools/power/cpupower/man/cpupower-monitor.1
+++ b/tools/power/cpupower/man/cpupower-monitor.1
@@ -172,9 +172,11 @@ displayed.
 "BIOS and Kernel Developer’s Guide (BKDG) for AMD Family 14h Processors"
 https://support.amd.com/us/Processor_TechDocs/43170.pdf
 
-"Intel® Turbo Boost Technology
-in Intel® Core™ Microarchitecture (Nehalem) Based Processors"
-http://download.intel.com/design/processor/applnots/320354.pdf
+"What Is Intel® Turbo Boost Technology?"
+https://www.intel.com/content/www/us/en/gaming/resources/turbo-boost.html
+
+"Power Management - Technology Overview"
+https://cdrdv2.intel.com/v1/dl/getContent/637748
 
 "Intel® 64 and IA-32 Architectures Software Developer's Manual
 Volume 3B: System Programming Guide"

---
base-commit: 6906a84c482f098d31486df8dc98cead21cce2d0
change-id: 20240617-fix-man-ref-6148b6a579be

Best regards,
-- 
Roman Storozhenko <romeusmeister@gmail.com>


