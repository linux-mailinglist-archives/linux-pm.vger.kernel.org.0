Return-Path: <linux-pm+bounces-32120-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE263B1FFB6
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 09:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 849F03A55A8
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 07:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF102D8DDB;
	Mon, 11 Aug 2025 07:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uyhfMLrT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192B52D8DAF
	for <linux-pm@vger.kernel.org>; Mon, 11 Aug 2025 06:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754895600; cv=none; b=fwIZDGLiyBWtUw/AzYsmDLfi7Z+FqVExAtTC2ZhXagIItDVKSMxRDgjLKVdvK+7azZbn+6xoAVgnPvsmNRSZ46FT8RCR8ze4tYY05VNMyX36OAhVulbIJrgBWLwYRf/fcxeR2OXGVIxktxO+ubHDOAbHH4PA289DGAJZAxwDphQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754895600; c=relaxed/simple;
	bh=SjJhb9CtuJxPb/S2Z0mHEwXzWQgumrJpI93kJdVN0IE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/QuLAI8JBxLEG2nJWS1Gl3tKz2GPK7rT5wIYh37JIi2rbfrA2sKko9BAMASQdXboLmUaiFbkW479WSNdKbUfNPkJdUVUFCjsnC6M+4VHGy5gUHd8HODgNfpjjYONOA5+yZKfE23bwzqlJY+D64ClIvpWaAfk8Z4UhPAZbaTe1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uyhfMLrT; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6157b5d0cc2so5651189a12.1
        for <linux-pm@vger.kernel.org>; Sun, 10 Aug 2025 23:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754895597; x=1755500397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMVpB2gF5xo34wUJzhKOG6ELwA0I40ZxfSZXRPOtdH8=;
        b=uyhfMLrTS7oEQy7epkfXwIV4+lzGFgesKkp4Dbu5fm+el4Jn0kpZDRLJZuzM/Qz4t9
         hw9gmfHabdp+kX0EtUSslp0hj2QiXqX6Cmg/aHOImfvzcw/y/CCGBEqtxH4BPV5qbQ4Q
         zcNSjt5eYUDm7Y+xWoCWTTjGzcpESUW3G4Q/9FBk+rufBELAmHlpIeWzJx9rgzUhhkQt
         rE8LSf9K2ck3bG9LbMUDy2qFZNTzlfwKnw/p6BiqoguiRE2igVBrGWVaUU7B+Y/xOgZj
         z7TYoqX9WqzpgtcuF2XkONm3wH3jrpLkbX1sG+hgbjjKpl8RbK9MYRqWVEUxA1GDIQhb
         4Gvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754895597; x=1755500397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VMVpB2gF5xo34wUJzhKOG6ELwA0I40ZxfSZXRPOtdH8=;
        b=vYeGMO+dwIOxAUzSHKCi/Rystg6EyOv/NZQXFqiM5Zg/yVv883xq3YliEALfat1kST
         5/wFCgXv0kdqlBeg1lMLirVMZMSe1xsmQKwPr+Iuth4oGp7JtIioGQEeWJrSBJbIUJHc
         jRSkTVygU9Wr2dMvPlQ9xiCSHYZ7ezghat39EzFbadmgtmLLAy+XArvkiPa0KFsZgWxz
         3uY93vxWNJZDuHI/82onpR2Q41rGaypwCapDF5ASOM+81xWzAeGJg5o9hUGgfYwCE0L6
         KQ7z2meRQfVCwWRAZWJHZJDjiX4yUIMFNEpROPiOvKWN7HIwWQC1aPp2XLivo2zu8ZHt
         yCvw==
X-Forwarded-Encrypted: i=1; AJvYcCVNGO6q5dETSzbmpOZctHhzBhTFwwG8BUBt9IWXh+NWh1//1LZxHnPTYw4WT3j6V7NGmiqB7FzwIw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWPnqnFjuybIx40tXNYav4sXm9ff5DJZ5KX47CGLqig0cwUl8Y
	V0YppNUIWS3/WWC/VrsXsbTnMK7P7CY/4DLC3d6sM5k3bmFh4YrzE67KfjgVvb14edo=
X-Gm-Gg: ASbGncvOVAWtT/7mvZOh8g623TvXp/lwZW9p2ALOPAim14quYMqPLca6odFC07IajTO
	2ni5PcaKKEJNg4jNUiaZ9rU0NPQ99KSV96MghgpGieQ7wNX4OlEMOt0omHBSIBO/KS7dQFWD2rT
	6ACizaQyCXqIRWcXhCMgeFQR0vEcI/rdZHixDkCEJHsVBWnKCHoJsFy3hv1qk6IU+XBxbm7Dxoe
	cCjqmfgi3DxwMZ3oKRG+noYd9Kv25VeA8wPwrtEzQmSXi9fcBHgju8g8rJJYoL1Nael+3NwHFD9
	McKZmDpyDIXc9HT8Vk5eHDFc/8SQqVRLvc/HlD0w4M/WEtz4Nwdq7zxqC9QIkkaEgQk8Fw7UGgd
	Gzqt/IHOaHZPSCdSm3N9hzvfDbSg2QCY=
X-Google-Smtp-Source: AGHT+IG59zAaGN05gxf1a3fNAJiiYDiuMx9Ck7HsUXcL2Cg/rpXGrAeDxDRSfbPv3qvDB1v99j//Rw==
X-Received: by 2002:a17:907:7247:b0:af9:6813:892e with SMTP id a640c23a62f3a-af9c653ab3dmr1088021866b.51.1754895597382;
        Sun, 10 Aug 2025 23:59:57 -0700 (PDT)
Received: from eugen-station.. ([82.79.215.22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af99604e648sm971793266b.6.2025.08.10.23.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 23:59:57 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [PATCH 1/6] tools/Makefile: Add dependency on thermal for thermal-engine
Date: Mon, 11 Aug 2025 09:59:10 +0300
Message-ID: <20250811065915.3333142-2-eugen.hristev@linaro.org>
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

thermal-engine requires thermal to build, and the dependency is in place.
It is then obvious that install and clean targets should also depend on
the corresponding thermal target.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 tools/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/Makefile b/tools/Makefile
index c31cbbd12c45..a4f5577210f1 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -152,7 +152,7 @@ tmon_install:
 thermometer_install:
 	$(call descend,thermal/$(@:_install=),install)
 
-thermal-engine_install:
+thermal-engine_install: thermal_install
 	$(call descend,thermal/$(@:_install=),install)
 
 freefall_install:
@@ -209,7 +209,7 @@ turbostat_clean x86_energy_perf_policy_clean intel-speed-select_clean:
 thermometer_clean:
 	$(call descend,thermal/thermometer,clean)
 
-thermal-engine_clean:
+thermal-engine_clean: thermal_clean
 	$(call descend,thermal/thermal-engine,clean)
 
 tmon_clean:
-- 
2.43.0


