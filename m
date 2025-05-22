Return-Path: <linux-pm+bounces-27485-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA76AAC052D
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 09:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8189817DAF1
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 07:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D46822173A;
	Thu, 22 May 2025 07:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZO4y/2m8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB121A841C;
	Thu, 22 May 2025 07:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747897357; cv=none; b=Mr+QqCRvoIDD/yC8uQUygPJvdI9PjacxBqMmoFdgunb1eqy3NjeZG9P4bvY3K5JEbLVp5yPfG895EhENU3eMrIVnpWOvyDXGqVkj6UHoZfMtnEXUnJk6KkkjOKYHPwPokFKx1l8ww+MMA+ZDTAjDZxzZWBK49GIVq7HqFKRdZ5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747897357; c=relaxed/simple;
	bh=uA2NaTnSrsjaw+u1a1w4m99SGUK5RHR7xtImeGhk49g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h+APQYwf3QfxLLvnKT+J/U/YBTkg/8rA3piVrTY/QPRv+JTRpuv8TLWseOw5dNmeDoYUNeJhQ565+J4GzgCvxMrs38ZSGrYC+me5AehjDvpL47C5NK1yosR/B+2BhmQHm8o8u02G0Zvm8gXsahpHMT+CcMUZCW79hE8wu7TBQ6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZO4y/2m8; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-30ea8e2bbaaso4538598a91.2;
        Thu, 22 May 2025 00:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747897355; x=1748502155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jGtCz5gnhXYzL9ayCi6Yx/k+BthTHNTVsByaVh8/+D0=;
        b=ZO4y/2m8ylkHghvF74kzQLrWPnJ6mZPQJIgecpOG7oaD5tp+SdhNWKKLn6EEM9/1e2
         gf+hRFwGdHmKfTLz3mGCoVZm2GMfDfCqqWrX5qmcFh6XFTPYtkfTieZb5t0Uemrgu9fD
         oRXZE+7iNTPtzbea2XBsa05VwJrRk6l7NI5gkaJCUpympg3zz71RCCFY0axr5dVx31zO
         VNm8/kMgGBih3i0USszpGDRz5w8So4MoQvpJ5vqvsAtZ1YHTPE6ns74MAdrWN3Fahifv
         wbE3iCJvS53uSHzYVSGHiW+ii7byb+lQExKaqxnHVolyzutLbqF2koLJ5xOaUXaXZT0F
         TcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747897355; x=1748502155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jGtCz5gnhXYzL9ayCi6Yx/k+BthTHNTVsByaVh8/+D0=;
        b=f5NEvHeaKdZ8adA62/0CvWzqcTZbJRCTouAJf3bu/NTFUwMKMCnZmZkHkHb1+qv1r7
         Xblo1pH6+nVD+RqoJ+9HNxM6u02ZhQQkZru54lc1xWwyhmNALcdP0W5p5CyG/pDjLoSo
         NqQiheWNP+pUgOZ4rLEsfOryKko6LuaK9aFnKmmSHteilF0zb8elMHsAPYmwde3JoKrm
         qkcMEFQ+xGXhGi5J5NF4plHy3d11klzKrkoTbMYh6EguUbNkZKvj9FUu7XFiJtlX/CES
         PsVBO3TYTGA9hm2k6FtWw188e/5YsS9UbnOAsmE+VXEkIYlnMg7t9+DDm7lfNklspkHt
         cujw==
X-Forwarded-Encrypted: i=1; AJvYcCUxdw+JeBMFG5PZ1sVQv4mqnqXsUkmRHHCtwdxQSeI7jPZI6C9LjFlpqtGPc/fGyq+JeiEaiOPjgBo=@vger.kernel.org, AJvYcCXYfOTrnVaNFN/ODgMtwn+TW/f/WCplsPHHDuJAtMsl/T3ZItgknCiBLMVDWDiBPzE7XnGLMAYssungBg3p@vger.kernel.org
X-Gm-Message-State: AOJu0YxMp7x+UUp8hDQHltDJ51aD6lb1T3LnIW4NIJuxIanQ2C2/q/j4
	GoT3/jFkpLZRWo6kCWsfCMFSbMPMkO+3U/wv3Ibl3tyXcv0zgljifnFIQD4kI/r5
X-Gm-Gg: ASbGnctTQp7PmyXNbaIvl42ZAt8eGv4LGXQRNwh2ftczvDVTwB70z4rU6LIdj2qzycq
	2RxjMpvZAsSI9kcoUBHd6Mart94Ewg0dftMAh7zaL1TKE1LLHQFdHKi5WGJqQ5f5UuW1nyNbapb
	R9JLmrfsfbVwZqGaV14+MvgNSxT6oah/UFBWbkgAk2pQ3Rx47GKCHhSbCGfRT2fLk//1WrCIpeC
	lCvlmviQLu9AstAWqSZbM3ae9Ah+7IykOYzOSEvsL0gisaSZ6p+tVUpjYskjTN8/3Ii3byE2+rn
	AxeG/RIzSO5ifjaZBAOg3Q0TZCWIkR3kvsvvXjIjTz5Vtss5yakDEqNgp67rapW73DPbY1x06V1
	pkeV9t80zL4jMFA==
X-Google-Smtp-Source: AGHT+IGLZQvgE6vIaT87y4QlfLMbqTSQVnSQp3oMK/aK4G8bVgQ/LuMqQC40bpRTNLSNHvIWBuWD5A==
X-Received: by 2002:a17:90b:3e8e:b0:2ff:4e90:3c55 with SMTP id 98e67ed59e1d1-30e7d5ac887mr34551529a91.27.1747897354183;
        Thu, 22 May 2025 00:02:34 -0700 (PDT)
Received: from SHOUYELIU-MC0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2982c04d12sm3646879a12.21.2025.05.22.00.02.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 22 May 2025 00:02:33 -0700 (PDT)
From: shouyeliu <shouyeliu@gmail.com>
To: ray.huang@amd.com,
	gautham.shenoy@amd.com,
	mario.limonciello@amd.com,
	perry.yuan@amd.com,
	corbet@lwn.net
Cc: linux-pm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shouye Liu <shouyeliu@tencent.com>
Subject: [PATCH] Documentation: amd-pstate:fix minimum performance state label error
Date: Thu, 22 May 2025 15:01:41 +0800
Message-Id: <20250522070140.17557-1-shouyeliu@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the AMD P-States Performance Scale diagram, the labels for "Max Perf"
and "Lowest Perf" were incorrectly used to define the range for
"Desired Perf".The "Desired performance target" should be bounded by the
"Maximum requested performance" and the "Minimum requested performance",
which corresponds to "Max Perf" and "Min Perf", respectively.

Signed-off-by: Shouye Liu <shouyeliu@tencent.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 412423c54f25..e1771f2225d5 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -72,7 +72,7 @@ to manage each performance update behavior. ::
   Lowest non-        |                       |                         |                       |
   linear perf ------>+-----------------------+                         +-----------------------+
                      |                       |                         |                       |
-                     |                       |       Lowest perf  ---->|                       |
+                     |                       |          Min perf  ---->|                       |
                      |                       |                         |                       |
   Lowest perf ------>+-----------------------+                         +-----------------------+
                      |                       |                         |                       |
-- 
2.19.1


