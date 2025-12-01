Return-Path: <linux-pm+bounces-38950-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F9EC95B3B
	for <lists+linux-pm@lfdr.de>; Mon, 01 Dec 2025 05:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBA4D3A163C
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 04:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A0D1E47C5;
	Mon,  1 Dec 2025 04:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cLHxObQV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334101F5F6
	for <linux-pm@vger.kernel.org>; Mon,  1 Dec 2025 04:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764564006; cv=none; b=LuVX8VSFeelymPMSq6gjHp5X40KJG8ZetFDFLUbFYsn5s3eA57FM8FQ3DOZlKPnQBSnqt9MlEFb6FCNxaZt8oph4JokCwWOU8XhTSfveU9na9qDNNhxVcc15qK/ttFMVRfDGiFIESONAj0O2+JC4tJpKrZfGyzzvzYoGKOdy1y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764564006; c=relaxed/simple;
	bh=dLxGc7MuSNNkYKcqqq7Msvu5pXb0vV/WZMh9XQ02mO0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tq5oPupfxVYKC46GkqREV4YYBBzIZvGQFDzyBMPccycNWppi+IJy6gPI93qDVk3l1J6Y1bN+J2fi60SqXdA8PIGK9NCeQljY7XG/3bJRhhhHwrVCtyn6gopYoEfMc5008xeluwj5a6xVq1+j+3o/7N1kd1JNTbpTONhy4BDiplY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cLHxObQV; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764564005; x=1796100005;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dLxGc7MuSNNkYKcqqq7Msvu5pXb0vV/WZMh9XQ02mO0=;
  b=cLHxObQVy+Xo6G53req63k9/hMoPKgRD3wn01PJjJaQH0sw4p7nC6eer
   M2Ry0UQ9ub6wBP+le/gBs5dMdZ3HCi1jhT7zx7esNwVxDpYWtyPBaajHd
   HFPfSM62Rl73a7ENgEUxRzKdAOu2+dj+LX/C+D0ER5Ti+g5T7HK6JZooQ
   VCn7HXtdr+VVyPgESkVLU2CnLn2snsm8roERYfvCyIQiQQw8nMvrR6/Jh
   CbJ5pQJeH8tWdW94xWQ6sw2d0u6vjo6rZwTtjNzcQvQhcVd9fOrNXOMSp
   gAO654pHFYfKIQtVQBdiLpFuqjnM94i7Qp/HeG1FyYCC2JJ4MiEY/JQIN
   A==;
X-CSE-ConnectionGUID: NsyUcbPATYaYzNs3ZGx8SA==
X-CSE-MsgGUID: ba367VqARkSaZFJscMFK4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="66565323"
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; 
   d="scan'208";a="66565323"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2025 20:40:04 -0800
X-CSE-ConnectionGUID: FPaXBz1jQ8CDuv34YauYBg==
X-CSE-MsgGUID: iL28JYyPRo6d30djNCMgZQ==
X-ExtLoop1: 1
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa003.fm.intel.com with ESMTP; 30 Nov 2025 20:40:03 -0800
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: lenb@kernel.org
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] tools/power turbostat: Enable header iteration option
Date: Mon,  1 Dec 2025 10:07:40 +0530
Message-Id: <20251201043740.1450548-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

getopt_long_only() never listed the -N flag. Include `N` in the short
option string so `-N` is parsed like its long form, allowing users to
set header iterations consistently.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 807b2d7f1809..7f5ce392a338 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -11044,7 +11044,7 @@ void cmdline(int argc, char **argv)
 	}
 	optind = 0;
 
-	while ((opt = getopt_long_only(argc, argv, "+C:c:Dde:hi:Jn:o:qMST:v", long_options, &option_index)) != -1) {
+	while ((opt = getopt_long_only(argc, argv, "+C:c:Dde:hi:Jn:N:o:qMST:v", long_options, &option_index)) != -1) {
 		switch (opt) {
 		case 'a':
 			parse_add_command(optarg);
-- 
2.34.1


