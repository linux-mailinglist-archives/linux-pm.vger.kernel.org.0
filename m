Return-Path: <linux-pm+bounces-21800-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 373DAA307F7
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 11:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DC3D7A3327
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 10:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B9F1F2C5B;
	Tue, 11 Feb 2025 10:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nxx39yYh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7161F2BA6;
	Tue, 11 Feb 2025 10:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739268348; cv=none; b=JKruegZFyhyixiQ8UBkOLWCNBxTwlsbUIeQ1Fg52Zz5VRakWIx0zQ6S+bzaRkgdlN5lab062fuU9Fou2Uo5A+J1fX/cyY6wu6MzjwZDfqRfM/1B/1q7rQMErPli/+SyS06VouAHfVwDZRtlHEW/QNNnoefb/lz4piJAfjmY8K+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739268348; c=relaxed/simple;
	bh=3zkyfWpptUkYiCfOPRk2QRhH3P2OMstKZ+rV6oFSubY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=usVXotuiAAjn1w05D1r+UANLiS2j8KznLy/Ugfa0nc4dNL1ApLy34PskqJJxCBqKIuyNiKzd+Jcz0TmVrvQhAiUP8Ryjrvz8g+7AEn4QlVDT2mWCALyYgMH04UP82nTBw5TbkqZr9JMCq8sr0uLDM4woLbyIWEV/AbFoYiEj0CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nxx39yYh; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21f5a224544so43839325ad.0;
        Tue, 11 Feb 2025 02:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739268346; x=1739873146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NlJmnKHx1lwCXmiIBkyeorsVWdoLFgtXUGK/oyDO4pM=;
        b=Nxx39yYhgZOdsO187ddSrqobwdsHDGR+nVhdASST3BHsF6/838DaZL7tKGE0Gtjg5K
         dsOiRj4G2a5307tZloXwTMRQuExRwpF2JqZU+YBHRae9VaVysz1UKPEe0ph/D7UNQxVV
         xMPyjD6BptZcToMRHmv4Hn7oD8XfVBaS6v3UJJ9hPAXgxIZGlOXh9N+9kDcs83L69oe5
         Q1AZDQMiMkgigAe3YWld9aiKPm+q6QpsHV1XYFx/5cJflra36e7nUSiZlxs97Tr6mGw/
         mb6RIFdB1o+PEf+J8Gs/GtlbS7LEAFgygsNXqKYbu7uyPGWbXCT8AlWmONRmmExzLU89
         5gAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739268346; x=1739873146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NlJmnKHx1lwCXmiIBkyeorsVWdoLFgtXUGK/oyDO4pM=;
        b=dK6uDp5rkIcxVkAR/KhUL1k+YVHBivlIajPphwEiWrrp2x+7ExERLGYLCRKip1OtU4
         /fMO16CPjlhughpPtuXjSZZ1iLl4oQ/1S/XRTdwCV8PHW4v28BtTakGuUUjKH4vqV8Br
         ngzw08ork461Nvb/kX3HpPsi4TvekI+LWkb8uWDO7GyJdgKLg/HkM7JEFt4++URX7Qlc
         cN2MiznXvRtNWcBzXZcNCrE6x1BFKuT18mvQ02c2Uf9Aa9l1DfNdT7lr8eiMddD73pzF
         S5tndG8qB9MFP9m4MZ0NCwGCn/cly9TX+aOzh0hUeQKzEdrGB/E5WBT7uT3JeJtpEFO1
         i0TQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnc4Jlsdi4SY3IlVWNfAAVcMkN5QitP/5T7I45H2Ea5LMPzUx+b2Ho4lX5mNVd4c2aVo2VNwwRolSg/ig=@vger.kernel.org, AJvYcCXW8yWLYYkw+es+nfL52tRdQ+V2aLfYPqO8uuInUTCZ4Rxin2fApJ25S4xixwVV9AzfeZ/gev0GnH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyqnH5CBQSWSSwGI52fbzc3zJs09ZbTnhif4EK+uPEEIaTRKai
	3xBN89NEghs2JLn6AWoMgzLFXT9lYFcvxDLjApc5dNZl0//AZgOt
X-Gm-Gg: ASbGncvOSjMy1kQKKpb5LYDWFsJ9oxOeOV41mwzBAvd7l4nAHAPzaLs18M2QbISm+tx
	RjtPrkoSPe7l7JwLnlF8Ff47abHKU8Qx95MozgI95wZfN2gRT7WQPHLrye12edpNndJfdk7qfST
	O3S20VtATrG/ZYd3vOJ2u5Aq8LDrcxoQv5h1pAY3BmTHB/PZztFTKmtaRFKBcHQFidi0Kngd7Xb
	xz44WZafY5Wiaukst7SInfq2IozaVEB/9Y/T4cJyclNsTcuA/iJIBLC9rjxXZn5i0ThInkvR2a7
	6eqEd50lDsRzK79HNUWYiqQmBV359Ef++9540mgKhJ/uY66N6nxlyG/mIaQ7
X-Google-Smtp-Source: AGHT+IEYCLyM1if/1HHbXJy/5vtng8QSMrWKzlyhT/lzwguDALJrJrH36PvxKE2cmIwoas5S01rlMg==
X-Received: by 2002:a17:902:ef4c:b0:216:7c33:8994 with SMTP id d9443c01a7336-21f4e7aff63mr266343325ad.53.1739268345868;
        Tue, 11 Feb 2025 02:05:45 -0800 (PST)
Received: from localhost.localdomain (59-124-78-22.hinet-ip.hinet.net. [59.124.78.22])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f365616ecsm92740135ad.100.2025.02.11.02.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 02:05:45 -0800 (PST)
From: Yiwei Lin <s921975628@gmail.com>
To: trenn@suse.com,
	shuah@kernel.org
Cc: jwyatt@redhat.com,
	jkacur@redhat.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yiwei Lin <s921975628@gmail.com>
Subject: [PATCH] cpupower: monitor: Exit with error status if execvp() fail
Date: Tue, 11 Feb 2025 18:05:30 +0800
Message-Id: <20250211100530.5918-1-s921975628@gmail.com>
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

Signed-off-by: Yiwei Lin <s921975628@gmail.com>
---
 tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
index f746099b5dac..0fc0e229739d 100644
--- a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
+++ b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
@@ -6,6 +6,7 @@
  */
 
 
+#include <errno.h>
 #include <stdio.h>
 #include <unistd.h>
 #include <stdlib.h>
@@ -295,6 +296,7 @@ int fork_it(char **argv)
 	if (!child_pid) {
 		/* child */
 		execvp(argv[0], argv);
+		exit(errno);
 	} else {
 		/* parent */
 		if (child_pid == -1) {
-- 
2.34.1


