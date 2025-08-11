Return-Path: <linux-pm+bounces-32123-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C033AB1FFBE
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 09:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA07D17B4A6
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 07:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7722D8DAF;
	Mon, 11 Aug 2025 07:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wsEuCQ5b"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2772D94AB
	for <linux-pm@vger.kernel.org>; Mon, 11 Aug 2025 07:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754895612; cv=none; b=Yc/qb0/ulNBprQixHAn27zHaQ/6SuTjVhIKDCC2Le4rOSftU9xpTU9t7pSdqhm5It/qwhFL06wFRh1jUKLRaBv+akGFBXx5VF4BpgbuZlApJFfQCROd3N+Xp4H7x2XqwagwyX0Y53Pz61LIIdjHVdRHl7+unuFJ0hqxCuOBNjr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754895612; c=relaxed/simple;
	bh=DcAe9wT6QC5QyxeiRgMQA8wNpqFV14uYDM6dcM6/kxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E3ffdiEhoMidrn4IVL85r5pSEe8AOVTOwZNFPgHkqhEYJHhzHuOnqCeDtPLc06s7aIIMfzoMc2h2YPpUWJfACIGroqfN+Yh8A0NFH9Xt+R3sfemSAOuILAIkcSGH6aJFC9lJhYEeQfO86+JGaD2mdmHd8mH3LorVxc1SZVsx6Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wsEuCQ5b; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-af9618282a5so782713766b.2
        for <linux-pm@vger.kernel.org>; Mon, 11 Aug 2025 00:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754895600; x=1755500400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJU4sqEwL+qXvcHvb/mnK0Ms4HACkHUUGa4uEQrj1+w=;
        b=wsEuCQ5btj+I44s1w7tK0zLMF4ecGe3SlRFC2endUZB/W8/uCeEqJyge8Do3QbZ/7r
         5Ht0+EVx4h2Ol51FiWuLKtKvxRalgQKWHqBCHiDwkE9v4TEJ3dBLzZs3mUzIP0GUWmij
         9Gy/TuYoODoXDo7FHr7fx13zpLyXexu4y//HpfH1ZN+WKv8f6Lz0F9yNBnSW6ICuBq0f
         5nQCD7+W+psvHjo1+x6Bq/TEx8AVUbuh6HBFcC4vSn8abCXuCOPNlENjz1R/xT9V1KeG
         iCPZHIFd3VdKBR2HhEbfPdV6iKLmMiptBI8cOGN8Umm1Mp3643QCJBg9p5FkywUW9yAh
         QIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754895600; x=1755500400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJU4sqEwL+qXvcHvb/mnK0Ms4HACkHUUGa4uEQrj1+w=;
        b=NQf59ATZ6cjYhDMb6zdW6PXH1Wgn0boMqG8z12Gi5qESVUhDGpmps6Vvm704/XjgsM
         gZgRp+aPbF7mgZrFf4AOnGCYDj+slV1o+xKAJUHI0hqXt7mCOkwVRtRZ7HdCHVg6nTtG
         IC45eLTD/EJhHbnMFFRi0ljMUXJZtEAqLc0Yqsv8hvse4FWd0Ni/QtS07OH/nGxWyXh1
         4AyAtvZimCDfrlxjNCBsu430MPrMcuVWlEueb4DyguPwDG2cLFvdICa9Z5QxTN1NJCsV
         D8nC9R5/ByUliEuIWMinE8WKmRtL0WJ1Goxy2hcw9pYdCBbTAuGsIgWJGMabC120SpEp
         fTvg==
X-Forwarded-Encrypted: i=1; AJvYcCVtX/VVy0x2/qIz7H/PKQGlMQL6tdBNyo5QXGwMO3bfH461d6g7/p9TUyvZVIOFiG1YcsHOZeWdIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwE+RwhVt5ZGpJfh0wDtngqpQVbT3ZUP3HNogL2AYABN5AUj83J
	ZYNM0UvT+Fhfi/vAldjEeGXVw16jQCJJWgBanaQdGr/dFS3qU2QJetMbOj5MDFcZLqg=
X-Gm-Gg: ASbGncs71a7xm6VqTYgix/4tczKyNP3wN04NLEKtEUHzOQgPElCDfy8oOOgb3Ei2xqK
	W5t1xDbRJjeIBkXZslVEOfC8rvRZbvfygKdXVm7nfLktSpFIvvCXvaJdFWl5WE4KFEgib/NHE5g
	f7w8SwGcTP+XNqM2Qd3rZWjd5CNg3MAhgyvJLdCEg0mlMO8P5Yu77dx3rdiGx2WWzLdePCzo39O
	DsG14OzElSuwL5WtcVug1g5PnOYIDsc4BAoU+mAUxV/LWLtl3mdXDk2PIKnf54qfBVkKPKz7Oar
	cWRduGECx4AzVwncQ0YMIk9cjzNuNAzqJaz+twHufm3XadYTk+/5unO6F6EzZ33ZhvzvNrlrHHo
	R59gDPCxOEMJutE6o7pMRezNRKiwcG6Y=
X-Google-Smtp-Source: AGHT+IGTU1SlnJAzBr7ngcTzox/8GCPXwlpgRLhzLsNN44/ljJtO9ZCxmOJsox/oA4D7YHsrf8RWJg==
X-Received: by 2002:a17:906:c113:b0:aeb:fc49:3f56 with SMTP id a640c23a62f3a-af9c645da46mr1126322466b.15.1754895600428;
        Mon, 11 Aug 2025 00:00:00 -0700 (PDT)
Received: from eugen-station.. ([82.79.215.22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af99604e648sm971793266b.6.2025.08.10.23.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 23:59:59 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [PATCH 4/6] tools/thermal/lib: Fix dependency to host libnl
Date: Mon, 11 Aug 2025 09:59:13 +0300
Message-ID: <20250811065915.3333142-5-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250811065915.3333142-1-eugen.hristev@linaro.org>
References: <20250811065915.3333142-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The include path should be created according to host pkg-config
especially when building with a different sysroot or cross compiling.
Thus, call the pkg-config to obtain the correct path instead of
accessing directly from root host file system, which is incorrect.

Fixes: 3b7c5e8adf9c ("tools/thermal: Add util library")
Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 tools/thermal/lib/Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/thermal/lib/Makefile b/tools/thermal/lib/Makefile
index b8fded7f22b8..51a2a2ab7de8 100644
--- a/tools/thermal/lib/Makefile
+++ b/tools/thermal/lib/Makefile
@@ -47,7 +47,6 @@ else
 endif
 
 INCLUDES = \
--I/usr/include/libnl3 \
 -I$(srctree)/tools/lib/thermal/include \
 -I$(srctree)/tools/lib/ \
 -I$(srctree)/tools/include \
@@ -55,6 +54,12 @@ INCLUDES = \
 -I$(srctree)/tools/arch/$(SRCARCH)/include/uapi \
 -I$(srctree)/tools/include/uapi
 
+VAR_INCLUDES = $(shell pkg-config --cflags libnl-3.0 libnl-genl-3.0 2>/dev/null)
+ifeq ($(VAR_INCLUDES),)
+VAR_INCLUDES = -I/usr/include/libnl3
+endif
+override CFLAGS += $(VAR_INCLUDES)
+
 # Append required CFLAGS
 override CFLAGS += $(EXTRA_WARNINGS)
 override CFLAGS += -Werror -Wall
-- 
2.43.0


