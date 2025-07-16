Return-Path: <linux-pm+bounces-30906-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B61B075F1
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 14:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 393BD1C26A10
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 12:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5552EA72F;
	Wed, 16 Jul 2025 12:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R88IL4R8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919C82F50A7;
	Wed, 16 Jul 2025 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752669747; cv=none; b=XuiPnRlMXdC46Ov9gbp09tOHS5Vak4F0GJ+t3OTe8EGWMOuE4T1B5JKO8CzLnvsVXpUeltQsKiXb+v7WfnXyyKv+sHK3s+laDCiaTMbTpHg3bsqoJCz9SqJxWRZTfjYZ5XwT2xuX8+VhclWiW0cfk1ZGq/bC4qQuvuVFMV8xxvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752669747; c=relaxed/simple;
	bh=LdY2FA6e8vNjYb+3yFFkKdBdvl2VddseAmXA5ewCPOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jUEHl6IAXtmmL2ElRg2DrTg8qq9oZKziEUxkLFovUG/EVKW67OyG2jN0LYC0rySqUhyP8Ej45CeFjJ2DB8xe1v560e42kMOqSVHIMmRHy5N5l2JJIlcM0R28VnAtW+4Xrjdwhk/ik7VOdoZzwzNd6Hf/+/FEMQp8l2F1AXVeQXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R88IL4R8; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7490acf57b9so4675837b3a.2;
        Wed, 16 Jul 2025 05:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752669745; x=1753274545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=57Q2fhzh+9ypYiu1C19WAgFO9FIiKdNlSYbPpfQ2oEc=;
        b=R88IL4R8rk2I66nwyOk5jk0JbJnJVjI/lWNCRm/ZQF3f5ci5IdKdGw0IQUlGPnUabI
         I9thk5/EtAaflL3qRXH80otvGWx6Ero156+I2IdvyEgE3RNYrK1MstMsa/bluiqJWih8
         I0n66eDAugP5nrm4PM2wCjj+HeKdy518aSRIfK27caPHMUd8otypbLRI4oK9wqbF9uAh
         WWYTD/PsSAn0DezTtqLLluEDrYTP7+RV++M1zsptSKNhTLT1fGFrxiy5KRbPxo+eltcS
         UanSaPVxwUn/TeYMQ2Br8Egt8H2blYkFL7XWSUptS+6GYx85BgPRTme+FlA/mMN526na
         uD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752669745; x=1753274545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=57Q2fhzh+9ypYiu1C19WAgFO9FIiKdNlSYbPpfQ2oEc=;
        b=wMYS4grQUyz88MnN3ECoGFAaV89F9M549PWqYarbgfV1j8WAoC+KocRq0UWgPJZR25
         PF0IOawiDPBQshxSRYTDerTLEp11JA88VgVYoCp8QO63pbg981F8gJvTR3wbgC6EEXwA
         yk9GfBcwUNNJWHuDDwgoSU7i7el82QTqluduvTPI4jC0kDsWLGRMb+CYV5UWruiUUZ4M
         NLq5oCJD+fQI2QZtsIkIh3/ntyk0KhIHOBjbTZnHkb86F0PamYmWpjiT1oywzpT+AUSP
         pxvcl+5dIolpEHp/g02hItkAEdcYf8O3hauzj/MShvNCbOBPsYOX2iln01fOwkyIKPyj
         pq4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBtfoToROLtf2ATYM52GvKe18gskPIbwsDWZCNKJ9nU8/xQDpzlExeRd4YAIJyWVpm6TI/mVVChBc=@vger.kernel.org, AJvYcCWPNQq4IkWgiVE7uwvPSn7v0Wvo3xJB1RDniRvkAmRgJAfQQ8WzGhdBiz7zwmnloxEIp71sCYGDisIMGNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZqcdi73+bFYufk7kCSCC9K2R7VphoQYvXsyI7l5g/+qnamd1M
	e32QKQgJLqsXfIMe1nAy9UkEjzy5zSV5yz5eIxThsVxh73F8VWqZp8vp
X-Gm-Gg: ASbGnctTvLQTuFwoe99lMrZIhAul2QhIPJq2qRH0dIZIsqExzYMpwI7GhhLvHqOivn0
	FAP5SpPV9RUQgbWTaER3fKyFm6/bV5G8IVhImjQf0lIu6T3FK0ox8Rvw2OepNOHgJrG1w/S6OyM
	VUP+ygFkW9krKgeSXpIErTTfomnc7UXLgRc2qs0ea5BaWgOE0v+yYWEL/Us2fJ5mL/tltud0YPw
	bRQ/+1uVOVN3sHQAAi9OeBaPcW1pkx+rmR8ys4SLTeOEJ5QI5NeHoqZ9/KEhNfC+w/ArX4roZ6s
	CjX3lCGI8LiHvY724ni5+atzOIRmTAOA4N9szvlCXz9RtLMLcl08knYXElaljRR9KE90EH6VzWR
	hRcRhoQpF4pRxn+E6Hsly8wjYtXY89WF9vTCdtW0AgKze+M8xDDTCBHeJKdVEqVnPtpnLBEbTmd
	k=
X-Google-Smtp-Source: AGHT+IGADh+QdEdZfpb4G+4TIgboVAA3ciqlURmOA/3x2Ybx4N+nax8niUc7GqwwwWHdataRV/gtKQ==
X-Received: by 2002:a05:6a20:a10f:b0:230:69f1:620a with SMTP id adf61e73a8af0-2381313f837mr3801675637.42.1752669744745;
        Wed, 16 Jul 2025 05:42:24 -0700 (PDT)
Received: from SIQOL-WIN-0002-DARSHAN.localdomain ([27.57.176.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f4aabdsm13714705b3a.124.2025.07.16.05.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 05:42:24 -0700 (PDT)
From: Darshan Rathod <darshanrathod475@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <len.brown@intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Darshan Rathod <darshanrathod475@gmail.com>
Subject: [PATCH] power: snapshot: Fix coding style issues
Date: Wed, 16 Jul 2025 12:42:16 +0000
Message-ID: <20250716124216.64329-1-darshanrathod475@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up various coding style violations in snapshot.c identified by
checkpatch.pl.

- Add a space after control flow keywords (for, if).
- Correct indentation from spaces to tabs for a variable declaration.

These changes have no functional impact and improve compliance with the
Linux Kernel Coding Style.

Signed-off-by: Darshan Rathod <darshanrathod475@gmail.com>
---
 kernel/power/snapshot.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 2af36cfe35cd..501df0676a61 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1536,7 +1536,7 @@ static unsigned long copy_data_pages(struct memory_bitmap *copy_bm,
 	memory_bm_position_reset(orig_bm);
 	memory_bm_position_reset(copy_bm);
 	copy_pfn = memory_bm_next_pfn(copy_bm);
-	for(;;) {
+	for (;;) {
 		pfn = memory_bm_next_pfn(orig_bm);
 		if (unlikely(pfn == BM_END_OF_MAP))
 			break;
@@ -2161,13 +2161,13 @@ static const char *check_image_kernel(struct swsusp_info *info)
 {
 	if (info->version_code != LINUX_VERSION_CODE)
 		return "kernel version";
-	if (strcmp(info->uts.sysname,init_utsname()->sysname))
+	if (strcmp(info->uts.sysname, init_utsname()->sysname))
 		return "system type";
-	if (strcmp(info->uts.release,init_utsname()->release))
+	if (strcmp(info->uts.release, init_utsname()->release))
 		return "kernel release";
-	if (strcmp(info->uts.version,init_utsname()->version))
+	if (strcmp(info->uts.version, init_utsname()->version))
 		return "version";
-	if (strcmp(info->uts.machine,init_utsname()->machine))
+	if (strcmp(info->uts.machine, init_utsname()->machine))
 		return "machine";
 	return NULL;
 }
@@ -2361,7 +2361,7 @@ static int unpack_orig_pfns(unsigned long *buf, struct memory_bitmap *bm,
 		struct memory_bitmap *zero_bm)
 {
 	unsigned long decoded_pfn;
-        bool zero;
+	bool zero;
 	int j;
 
 	for (j = 0; j < PAGE_SIZE / sizeof(long); j++) {
-- 
2.43.0


