Return-Path: <linux-pm+bounces-23857-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0105A5C8E1
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 16:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14E327A1031
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 15:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D4925F78C;
	Tue, 11 Mar 2025 15:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F73jGOUh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9B723817F
	for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 15:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741708360; cv=none; b=D2LFGY3b8AQEXNB59PQHD55to/TBDdXEyIrDSp9M+XU//l2hM8NJ6N7PV8XtLZfyLcF+SM3xgRCri8x1Z44qgKHglHlL+pG3OiwTXW81B2wM4ixP3ix095303hjjAhduKAcmBCZcjrWHCbp+HGpWxcRZrejgVBQFyv6HY4BDm58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741708360; c=relaxed/simple;
	bh=ztEolFNqNrVXWdojLuisCDPSAVC4Io8YB5nRMSjxFyA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kGg3FE9zNhiA+zl5ATaKE13xTnvLMDM4gAMsr31+uC0pm/mRySgWmMIvACSoCUFOQrt2llAC7bsBUPm/S2hj7sTyUBeHreoLKLqvlEaKl67Plug1hKccP1rojIcmKIxKKBB2y0nH3uyXmtMhuWaw1OAJup5Fawp/hsh5R4l3d0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F73jGOUh; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2fee05829edso11122586a91.3
        for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 08:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741708358; x=1742313158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DcmWzwoSl+911hGU0IlxWihm5rr75YSGXCS1y9n386o=;
        b=F73jGOUhhUrjM4u2l4AqRMv9mB3oXGDb0kx5B5kqVoEB+gn/KXnQNZivB6SdxH5S72
         E/q0b1mJ64TymzDc9SFqb7+rdbUdCYp4QbxMQzS6Hx8OebRf3A78P2uPmQ0IYdAnTejf
         cDtxYZ9qpk8gH199A8re8amMkBWtaJP+QQh0zrOfodEjWcjXxYgiDPYQVWx6LqrTqG7B
         HMuzuXCnUhFIE72eRv9e1c4LI3pmKwDJAb2TUri19t0Xbdxci4UHBBcqeeDsCO9sXd4S
         ydER3H4lsYmzZ4L9OQewrfrIpK8/iprgTfJzMaTQ3IAyMyMBL9Lh2cW7+GYMcjrvHi/G
         BROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741708358; x=1742313158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DcmWzwoSl+911hGU0IlxWihm5rr75YSGXCS1y9n386o=;
        b=jqyhG26EoP079Wc1/eZbmxcIG+df/O+vzHpK3xKivXFaWBy7vf1niMB2g7xqUgsRcq
         MxN8lyu/JpQWsoSGcgVTDyIJm5tTWcxT8++4H15T42KL6pwQ/MNJYuv8ZxZqXOVjVENr
         /bWkmEUCRIUiqBQ5KjuRvEla6siF3ZjMZbp+kKRB/bGGQChs6h0j56JOw/13+Rp+grSh
         DIceNk3Az4R3LYy9N4OCsmVCSmDlVGdObyPKM7PZ46y5GmCArAqsXp3z7hKKS33M0IWS
         HnWjSuPxJ8z4Xwe6MwK1IdYzEGFV1R2d0bOEHx4OdWPsoDP3prWidTdnKvOBGIFfZGu0
         Qrrw==
X-Gm-Message-State: AOJu0YwTeXOZDQ1k3205Gw3l+SAPcwwahiS2uGytjVCGQoHBd2gBEQ0u
	NsOUJCSRGeNDGLZ2TlIc1oxful7JJ4UkFtz2jIWwKF39/bdEfUUvXtvvvA==
X-Gm-Gg: ASbGnct4dDXCsJ/D4340WqQGW8l3DeujX9QEkNM2zMAv4K7S9DjlJisSWsCIIVlcCeS
	VsDh67rdwNLDlu66Bua5i1k9gIX2YMjAieFgElgEh8TLGKeXmvdVqUM6RLgOHWHOZ0FYY7lUQjH
	cU2lLCm7/pVXWUMdUVs++jszXI/tulB/suHE4GVPJcIxoHqPyfQybB9KheRBoSEIpjcFbLSajC2
	jtHz/HW+MUAWFO02b4FCOXTJ956NsgMCmujtqN2YuF9QaBoJqLGpyuQgLqU2inJN/JQy17E06qM
	DQc9ljOEooJEejrZduE9NQ2XWk0RazZncimsf95bmbSGnuRc+y9PxHqJ3w9mz665Cuzsy6xTxvO
	hKJk+zkmr2JY+yLrcCqZaM4VOXKgm8P4+Mo/D/g==
X-Google-Smtp-Source: AGHT+IHHSOqIF3r1ZlB1vh+zAWjg7pnih/EVW0J0QHNClc8/+NidizUaZ01aJVUpT4AArbzI8qxoLA==
X-Received: by 2002:a05:6a21:2d08:b0:1ee:63d7:1d32 with SMTP id adf61e73a8af0-1f544935b64mr29338303637.0.1741708357931;
        Tue, 11 Mar 2025 08:52:37 -0700 (PDT)
Received: from test-suraj.qjz2hk5f2gku1a3adsvczrat5c.xx.internal.cloudapp.net ([20.9.134.79])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af5083d4baasm6541391a12.56.2025.03.11.08.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 08:52:37 -0700 (PDT)
From: Suraj Patil <surajpatil522@gmail.com>
To: linux-pm@vger.kernel.org
Cc: Suraj Patil <surajpatil522@gmail.com>
Subject: [PATCH] cpufreq: Fix typo in raspberrypi-cpufreq.c
Date: Tue, 11 Mar 2025 15:52:34 +0000
Message-ID: <20250311155234.467191-1-surajpatil522@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Suraj Patil <surajpatil522@gmail.com>
---
 drivers/cpufreq/raspberrypi-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/raspberrypi-cpufreq.c b/drivers/cpufreq/raspberrypi-cpufreq.c
index 5050932954e3..b5c3e5d42470 100644
--- a/drivers/cpufreq/raspberrypi-cpufreq.c
+++ b/drivers/cpufreq/raspberrypi-cpufreq.c
@@ -78,7 +78,7 @@ static void raspberrypi_cpufreq_remove(struct platform_device *pdev)
 
 /*
  * Since the driver depends on clk-raspberrypi, which may return EPROBE_DEFER,
- * all the activity is performed in the probe, which may be defered as well.
+ * all the activity is performed in the probe, which may be deferred as well.
  */
 static struct platform_driver raspberrypi_cpufreq_driver = {
 	.driver = {
-- 
2.43.0


