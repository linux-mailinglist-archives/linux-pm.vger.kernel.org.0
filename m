Return-Path: <linux-pm+bounces-30628-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A564CB00ADC
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 19:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01ABA5843D8
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 17:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED18A2F2735;
	Thu, 10 Jul 2025 17:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Exp633wo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBE8266B41;
	Thu, 10 Jul 2025 17:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752170079; cv=none; b=gql7PEj+0ywMsBj62AcMGc0kxwiXeUHeJ7NC3H6Kr+MXfy4YthH8EeudYpH1Qrf0Sqv2qPejhGPBi9r9l9KVCJyIVWAq1IE3Th3tWo2BB+kmR00pJ1whLO0Qm4XRHqyRS5K+wez5AM22ra55Rl1FilgEVvB3Dnf9FLVlRv6N2cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752170079; c=relaxed/simple;
	bh=jQQeRieZ7pRGi+z7yw6sLkaXJ3c1Id4neVF9B6GLF4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pu17bfhsqlzrLVZpzAC2KMC4IfZbkIK2fWFa882tAeXKWdtuu6n0NHs5MqNV9PX4fc9xEQIjJ9joFdX9bYaNhlI/Av52Yl2th6Bqo3iHqgM6SWuJTaw7a8uX87ONcbDecmpCgGJVvzC/OCsGHRMuTwN2K4S5Ku6Qk0bsCjuFNno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Exp633wo; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b2c4e46a89fso1249191a12.2;
        Thu, 10 Jul 2025 10:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752170077; x=1752774877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rXxvi+5q4QFQw8v85rfTWOMN7g2ZTWMoWhyMZwHTM50=;
        b=Exp633woWBLNxrgeLUm72HIhNq3JlVlSvpnFWgMJMrCbgO8SucbdoPhxrsqq1Bv/TC
         qSOP8xvm0jaA/SP6Fr3oJyGa0pFvMhen2BASH84ruoCrVw+5u9nnA6+xgQkd+kRWUoi8
         lb5iMs8oFO35OaCtSWoFkcc/yRbyWg03RbUT5G+DkfJKQpSBQW1OJwf4AzryFXK+WxXU
         Y+7AJmKmntLdKQdVldqUG2FATYbLbLaXilCH6RRhgjJw/t8tzZ8bD04C9HDny/andNyV
         WVHuuzvrHb1NZ0RHUDu7GHPQCJ/2S4wCpzaI0ZtVhB36+5FkDdgtbvtM8uNpWQTh8vCr
         7l1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752170077; x=1752774877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rXxvi+5q4QFQw8v85rfTWOMN7g2ZTWMoWhyMZwHTM50=;
        b=Pxf+M/+gvclhO8xdSl5XqKOvnEc8UASqqC57T97lgbnsOSHK5ABudMonM2H88yPfjU
         ArChz7CDV31MM5qQa7pdr6Ge/YyIgsuDGMkDv+PxgGJf5sMTFlVWR3S8yMUULujj9UrM
         pudNtYFhv9uFH0VuenzdwsLPD72Ch6Vbxvs2p6CwXdfSfqhsy1LfRpnR4Fs6C1SZ9QrW
         CW/OniLf09ljskslx5RZl+nQ+85rXZRDjjoPt8vMYPLKxXMz1wEPhYFlKk15rn7r1b/j
         nj2vB/844vGPOipYFC2LNWWimQSr6beI5XDF/AtstLMQ+bKvYL5Fnqsc8i8VD3+u/0J9
         iU2A==
X-Forwarded-Encrypted: i=1; AJvYcCUpKBCKiq3O3nRnasyOu5dLVaMVPLbGQercYe1P/jy2GeMEn0jhOU0aNTdgbZHF6a1A3p1Q7x7mveQ=@vger.kernel.org, AJvYcCW+vFHGLuXjKqkfe7SSIV889R/pXrEiyQJwkpSgX8ylPAxcY2MidZ9XIgdt5Jc9o6EYOEoDtl9L7QFC1Kop@vger.kernel.org, AJvYcCXq91HBYw+I3FVxGWGGcBduPdjJ4llJgPVvt4gPIXBz3gmnbgYJWwp4DQOx3SiXeOJ6tGuBApFrQfJ8Lg4x@vger.kernel.org
X-Gm-Message-State: AOJu0YyyETmya/P5AjJeLCi1edfSNBJAxrsoZARoLx10ZkZMfjL0Ng+F
	3LX0HHsgC6Saw2qXQm072Px6BG9iKa4qBEt+6k5YgIEp+ZzcO3q0BQGM
X-Gm-Gg: ASbGncuqErQRjB7rTDJx91JLGSPkG+mu6c1BSeU6shFoIaJGHL/z+Gyr9uV+r7ULSse
	xqO8EgLRWHkBx8ufhq/qq2dN1bDS0fFG3G9maJcxDNx1et1JzcbGQgCs+LMAlXfUKXvCY8nMo95
	PyMpIp5KNJ1PpFldJgq5484FP8ZQ/YxzL2ojFmOGt0XemGFfs18ygoMGdMzdEi8oNypJJZCILGG
	SHIOE5+Y428aETJyXjEIfCtCaRKDOAIeX7OQXOPbIv2M7hE/GkxR2+03sOJKhEuOuk1n73Dirgl
	dLglWG8DkrYr12EnoHrBlBTFKEkeuq1OUYWn0asmA9uHBWKaAHSqdYUGLqq5Z1xwrxeLpHEW9GE
	P
X-Google-Smtp-Source: AGHT+IHdHFmXufRa/zotSV6mFnexsIVBhnLZI862K14IVzlEoidavjo6EHbFOG2l+bSLn/XhPu5DFw==
X-Received: by 2002:a05:6a20:a10a:b0:201:85f4:ad07 with SMTP id adf61e73a8af0-23120a0413emr378471637.33.1752170077326;
        Thu, 10 Jul 2025 10:54:37 -0700 (PDT)
Received: from gmail.com ([2402:e280:3e9b:22f:79aa:4a35:715c:d62c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe6f841csm2730885a12.57.2025.07.10.10.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 10:54:36 -0700 (PDT)
From: Sumeet Pawnikar <sumeet4linux@gmail.com>
To: amitk@kernel.org,
	thara.gopinath@gmail.com,
	rafael@kernel.org
Cc: rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	sumeet4linux@gmail.com
Subject: [PATCH] drivers/thermal/qcom/lmh: Fix incorrect error message
Date: Thu, 10 Jul 2025 23:24:25 +0530
Message-ID: <20250710175426.5789-1-sumeet4linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was showing wrong error message as ARM threshold
thremal trip for setting LOW threshold thermal trip.
Fix this incorrect error message for setting LOW
threshold thermal trip.

Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
---
 drivers/thermal/qcom/lmh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
index 991d1573983d..95324b2f893d 100644
--- a/drivers/thermal/qcom/lmh.c
+++ b/drivers/thermal/qcom/lmh.c
@@ -204,7 +204,7 @@ static int lmh_probe(struct platform_device *pdev)
 	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_TH_LOW_THRESHOLD, temp_low,
 				 LMH_NODE_DCVS, node_id, 0);
 	if (ret) {
-		dev_err(dev, "Error setting thermal ARM threshold%d\n", ret);
+		dev_err(dev, "Error setting thermal LOW threshold%d\n", ret);
 		return ret;
 	}
 
-- 
2.43.0


