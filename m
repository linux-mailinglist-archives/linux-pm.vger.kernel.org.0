Return-Path: <linux-pm+bounces-32124-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5808B1FFC1
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 09:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E17E3B87CF
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 07:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92B32D949A;
	Mon, 11 Aug 2025 07:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SpPWb/4X"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDF12D9792
	for <linux-pm@vger.kernel.org>; Mon, 11 Aug 2025 07:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754895615; cv=none; b=OMEwPBNJXEth2esCC2/WSoQaQRfNAGoxXm7UXUL+DlkcRrzqmz9jxBIyzdTMYQ1dkpaMvaBZ2cANhl7j7CDF2p4YEDtF/ZZCn/TwTEhZ0P7KF35u/eXGT1uQ89bTtcPGjql8YWZjycSOXHdYgD6blIOmfeUzwi+NUoqvyxt+6Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754895615; c=relaxed/simple;
	bh=c89j4EY7hDQL8ksYXICLyPLxPExiEVG6FrPm7HouZf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WvvgC/2HFRyQ8gdtoODoro/325VVOIAXVRfr5tM5beypF7i18sALTAr4xS16jWY8zVcnpbSd07dO/QKAzbXZOiuQP2DIrNAajk7rvgKFrZ/Wi8bnkt1PiI1qAwuN0+rL2G/NhXXNndhPKJIHA0BQCroLUUwh8M5PUWrCzaN/N8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SpPWb/4X; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-af96524c5a9so523575366b.1
        for <linux-pm@vger.kernel.org>; Mon, 11 Aug 2025 00:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754895601; x=1755500401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GxFM3KEowHZ9Np37d1Ahrypz2fgPPBHOq5fRBicy60E=;
        b=SpPWb/4XMpyc/tJm6w0I4KWDxAEXCvXX2MQsyD73mBRogeOdRlOMGdunrqZpeBtXYX
         qhYu428+HytLyl+7jUF6dmy2MkAj1/2AvIoCqlAqL0g96yepeWXT9hY082t5iGDpyX/m
         hrioWQGfj3V3/UJTPQ4XTOzhfwrAnZ7bgwBrmWLjtM5MBn81Bo1JSQyp81x+8hh/5aO2
         KECIyQIBVUZVBe2vHc+dUH8rFXTfMjaPxVrNM7xCRsDocJImxMQXtHeEVcn1swZkaWgF
         u2z2ZGijGRhuzMqOgIxslwH5F2hqUN0vkY0l1HcRaM8PopobyhNSHMX7iOJeTbTKLRnB
         Qs4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754895601; x=1755500401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GxFM3KEowHZ9Np37d1Ahrypz2fgPPBHOq5fRBicy60E=;
        b=htCTJ++0jBr1oixxms8ixukhGu3CQGJgEEBUwzRQ2kQcl2T3ES3VbhrTHC8YBjJIzu
         RPWyghOax7ESa4raBAU8j34FVN5ikFzL/iFLPH5B9teW34aLsHi7oADlWCQVkvvNkY9x
         kCxVcy5so1GXV3GUE6ZgJI4V68zsWb33KoipPB/fSlydfDuttDPgBigTVTAG+AcMJgEi
         1FdAHi8ovyhJOwMenNeQzhYVZYV/Z8MGppUAc60N8rX9ArKWmavQE4sfUf2Gz5O6uqM9
         7Xr0C3EZyP7W9LWJUCTncBxQ1kwkLWKIsVgwIFvkbKRTK2VZPDhcsGhz3OPt1pj/+KDT
         auBA==
X-Forwarded-Encrypted: i=1; AJvYcCXXYkKqIndAsvkrT8MIG8ztca5UnA7ef1/K7WSVT4oC0s3z3xPsXwCMYDRhIvxfQZPO6/lg4mZDbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEuzuLSSgmkRYPPGh9+xKxgie0myXhgWvI3oA91y5InnIySIgP
	JyJ/Fy/BJPSyhZmR3yTqlSRb12iD0xhALxhcjt/FfZcYuo1cTeEehSihtgOZMufim34=
X-Gm-Gg: ASbGnctJ6tqINV2zWTSBD2qCTFX1jpxe9f4mWOk1psj4Ty63qT1ryaQJfEbey412H52
	7tg5AbqhOCvZa7/+hUGEkV1iFEB5m2WqdIKiOVHYHBComhGxJtDf/Bvbx7tes0jbVFJbUY3lDAi
	VbQbtBprqJjUXHKcNRAio/3iQoH4hL6n919okcma9GS+kC15MKqFLDfbuaOxIiOwkE+Z8ddJGW/
	lSZW2m8/gdubeSEB/LZ5f8DJ3CnJRZVqoAOQzFGCkIHgX2TEiXflaReqb107eT5gy+TXrU3pLp8
	5WjNk2FQIjZ4mbtuvM1kUmdAOtBjV1G3yP9oxWL81bxYQCyHGjwk1FO9l4etqzfpQWmFigsnERj
	URGLD0eaxU6ok8dnqM+TxPqDi3YQZUm4=
X-Google-Smtp-Source: AGHT+IFStzTtotqZ1x8RtkFHasRBLezl/MmS+Mh21B3OJrF9cx9oMuSnWhZUtyCl9adlZ9MKETng5g==
X-Received: by 2002:a17:907:1ca9:b0:ade:405:9e38 with SMTP id a640c23a62f3a-af9c63d47a6mr1133777666b.24.1754895601414;
        Mon, 11 Aug 2025 00:00:01 -0700 (PDT)
Received: from eugen-station.. ([82.79.215.22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af99604e648sm971793266b.6.2025.08.11.00.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 00:00:00 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [PATCH 5/6] tools/thermal: Fix thermometer/thermal-engine thermal tools dependency
Date: Mon, 11 Aug 2025 09:59:14 +0300
Message-ID: <20250811065915.3333142-6-eugen.hristev@linaro.org>
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

Thermometer and thermal engine depend on thermal tools library.
This lib should be built and installed accordingly.

Fixes: 110acbc6a451 ("tools/thermal: Add a temperature capture tool")
Fixes: 077df623c834 ("tools/thermal: Add thermal daemon skeleton")
Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 tools/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/Makefile b/tools/Makefile
index a4f5577210f1..9cc71b302b19 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -108,9 +108,11 @@ tmon: FORCE
 	$(call descend,thermal/$@)
 
 thermometer: FORCE
+	$(call descend,thermal/lib)
 	$(call descend,thermal/$@)
 
 thermal-engine: FORCE thermal
+	$(call descend,thermal/lib)
 	$(call descend,thermal/$@)
 
 freefall: FORCE
@@ -150,9 +152,11 @@ tmon_install:
 	$(call descend,thermal/$(@:_install=),install)
 
 thermometer_install:
+	$(call descend,thermal/lib/,install)
 	$(call descend,thermal/$(@:_install=),install)
 
 thermal-engine_install: thermal_install
+	$(call descend,thermal/lib/,install)
 	$(call descend,thermal/$(@:_install=),install)
 
 freefall_install:
@@ -207,9 +211,11 @@ turbostat_clean x86_energy_perf_policy_clean intel-speed-select_clean:
 	$(call descend,power/x86/$(@:_clean=),clean)
 
 thermometer_clean:
+	$(call descend,thermal/lib,clean)
 	$(call descend,thermal/thermometer,clean)
 
 thermal-engine_clean: thermal_clean
+	$(call descend,thermal/lib,clean)
 	$(call descend,thermal/thermal-engine,clean)
 
 tmon_clean:
-- 
2.43.0


