Return-Path: <linux-pm+bounces-10063-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5D19187C7
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 18:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7210F28A99B
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 16:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6313A18FC94;
	Wed, 26 Jun 2024 16:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWA5VqzL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DFE18F2FB;
	Wed, 26 Jun 2024 16:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719420326; cv=none; b=EeYqtLXuwdkzuyKBitcEmT1KTbcggpv76ZWubStdAXj4tB8m4J9bwSXY7zlYLa05rj0ko0RFhLMKZjRDmXsjyPPt83fm20iRtr3ky2WGPSj3X0MjVm5Sgnk7JGqUkon3DNgocG1D3Zz1I9WfxvY/5EAIPTDZk+QIX1Hj5DnVYFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719420326; c=relaxed/simple;
	bh=2Uzn37QnW/sB+xogUrcLf3O9WMjn2ZQf2EU2y2FpU0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JkKzR5MeREqFOGQiDPdIuq7CgqzZidVTobKrLIUgGRHqai2jkXMZ0KJL4B9yeyIIV8EtvvzhaqDT65JeWp4qz4LNjSsl8VARvHVqEk43W/iMS4bV6ZgbcaUiVj5mZ+gCto4PAZqVvjkjK+mST2z9T2l3IFwG/jpXkXk9XvEzpEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWA5VqzL; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a724598cfe3so582508266b.1;
        Wed, 26 Jun 2024 09:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719420323; x=1720025123; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DpdLLGkG+TIt8lLvN2sr4YidzuKVAO190LfJyAXBO6E=;
        b=jWA5VqzLEZMdaJqRGjtgiR7xCOXRKxTzXlTPP62kFrUZMgUZZtU3J4bP87nemP2MKK
         WZD7lc0B/YVVXy+PrWNZbXHrwckCHTqr9Ds5zat1tMOfwD6lyeczwJ6lAC7J6yBLZvIj
         wACeQk7+HkTwrOFMVwE/m0oKZun4aBMCh+EE6Gp1IUETtMISoy14KQj36DehGfYjuQGR
         S4qkJUJCXCwT1HA/GD4ntiYdBIRF0RuXdjcfGI/A3JKKPqErhhvCqcuIPkSU7WRDUMa4
         ZXz7dLD3/eRHNX3190gAGAXRvULA5jYpEfDmkeK1yWtgAAnNk/AGFbvQRHFhXaodslsH
         6wfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719420323; x=1720025123;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DpdLLGkG+TIt8lLvN2sr4YidzuKVAO190LfJyAXBO6E=;
        b=gDvVLqAl5S3MMGF+8sMhdAUebFuAtCEfG0zBQ7OWGcLawmHaheOvfZNmQtSI4w0iXJ
         thfnz2UVE6/zj8ga+0YPHFi2JWTQi+e7rccBrTAKRtMkWv3bH/Zsn7oDcl1q5/bt0xk7
         wX9urbKtj5vqnRyc7iVD6h7bPgu5V0p/AuYZHCqlXsjlCE+SJOqQU8N52wH6DJdXmGrG
         pE+Dn6WiM0l6e2GfiIt9gFE0EMrH0r6htgstOHmzI+iKOXhx3otjkxephe6sm/xgzxgM
         LEOBC+rGjz0nIaV5Uj6WdtpkbWYDcJfJN9hzXERJ3eAjNpiKWy/E9g0qMLx7gNsMWlR+
         gjWg==
X-Forwarded-Encrypted: i=1; AJvYcCXHnfMIjRt24VtXAtc4EG0v2HBciOwSKXP2VZ2OREQZvFHMIKNw+m2eaPEjJ6pT8BDxfXGBTByGy/fLdaR6+0PwKSnT06Sn0BBsVvP9
X-Gm-Message-State: AOJu0YzGtDA3nrDcktTkdRvTCLAPXIW+XNVEk/CNcLMfjItb5eqYEnxA
	tOaDqIsf8kLGzXsDZLKny61o+qv3lFSIWnV0F+EUSYLM6/CDRFTq
X-Google-Smtp-Source: AGHT+IG/CSAouP4IJG+hBEjoPTqguJSobv59Lf4z4OxCLmpyxQZTUQE/vqFO9BkhT0uyablhjvvtVw==
X-Received: by 2002:a17:907:104c:b0:a72:455f:e8b with SMTP id a640c23a62f3a-a724599a00cmr851759266b.0.1719420322789;
        Wed, 26 Jun 2024 09:45:22 -0700 (PDT)
Received: from [127.0.1.1] (31-179-0-202.dynamic.chello.pl. [31.179.0.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7258814940sm302889966b.7.2024.06.26.09.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 09:45:22 -0700 (PDT)
From: Roman Storozhenko <romeusmeister@gmail.com>
Date: Wed, 26 Jun 2024 18:45:17 +0200
Subject: [PATCH] cpupower: Disable direct build of the 'bench' subproject
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-fix_bench_compilation-v1-1-d039bd5fa551@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJxFfGYC/x2M0QpAQBAAf0X77OqsS/gV6TpnscXRnaTk320ep
 2bmgUSRKUGbPRDp4sR7ECjyDPziwkyKR2FAjUZXWKmJbztQ8Iv1+3bw6k4plEOqG2zK2pcGpD0
 iifh/u/59PyOZtAlnAAAA
To: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Roman Storozhenko <romeusmeister@gmail.com>
X-Mailer: b4 0.14.0

Execution of the 'make' command in the 'bench' subfolder causes the
following error:

$ make O=cpupower/build/ DESTDIR=cpupower/install/ -j8
"  CC      " cpupower/build//main.o
"  CC      " cpupower/build//parse.o
/bin/sh: 1: "  CC      "cpupower/build//system.o
  CC      : not found
  make: *** [Makefile:21: cpupower/build//main.o] Error 127
  make: *** Waiting for unfinished jobs....
  /bin/sh: 1:   CC      : not found
  /bin/sh: 1:   CC      : not found
  make: *** [Makefile:21: cpupower/build//parse.o] Error 127
  make: *** [Makefile:21: cpupower/build//system.o] Error 127

The makefile uses variables defined in the main project makefile and it
is not intended to run standalone. The reason is that 'bench' subproject
depends on the 'libcpupower' library, see the 'compile-bench' target in
the main makefile.
Add a check that prevents standalone execution of the 'bench' makefile.

Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
---
 tools/power/cpupower/bench/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/power/cpupower/bench/Makefile b/tools/power/cpupower/bench/Makefile
index a4b902f9e1c4..34e5894476eb 100644
--- a/tools/power/cpupower/bench/Makefile
+++ b/tools/power/cpupower/bench/Makefile
@@ -1,4 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
+ifeq ($(MAKELEVEL),0)
+$(error This Makefile is not intended to be run standalone, but only as a part \
+of the  main one in the parent dir)
+endif
+
 OUTPUT := ./
 ifeq ("$(origin O)", "command line")
 ifneq ($(O),)

---
base-commit: 0fc4bfab2cd45f9acb86c4f04b5191e114e901ed
change-id: 20240626-fix_bench_compilation-a2e892938c34

Best regards,
-- 
Roman Storozhenko <romeusmeister@gmail.com>


