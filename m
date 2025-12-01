Return-Path: <linux-pm+bounces-38965-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 295FDC97398
	for <lists+linux-pm@lfdr.de>; Mon, 01 Dec 2025 13:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C212F3A5013
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 12:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C504530BB8E;
	Mon,  1 Dec 2025 12:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NbG7cN0u"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437CE2DA76C
	for <linux-pm@vger.kernel.org>; Mon,  1 Dec 2025 12:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764591615; cv=none; b=qYg/oTtD3m2X7jT2lMppX3JXAxnNqr+o/29KW0Agq1xAR+2kCZSQDvRk09pvhyeEvtCvu2HihYm+afdTyC2dcpSXA7SXPIbVR2pKMwqW36SDISrwaVH5+H6fBulZuKwvCYw48MO5p8Rn6Fm0ZnHYt2UufOCSmKI4lKQ+XvKTwsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764591615; c=relaxed/simple;
	bh=HBL4MLp0bimzAWVvlYaorIhiBcXFQUC74Qe+xV6eQoA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dcFtvPnLuGpQl5iCshKPhtJ4tXFjYP1QKkrP6wl/mcSIP7YZgYnZEqVsRj9KCjGTUzgPxEIDHmMNAgezJBLcAnnO1JDbTJx3ndcidrMK/tsGI4ImvvjrIjgMnpMQ+Tg7NS6pDTZh1hzyF+RgwuK+C+YAu7sjN5SCW0Xnzt2yXRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NbG7cN0u; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764591614; x=1796127614;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HBL4MLp0bimzAWVvlYaorIhiBcXFQUC74Qe+xV6eQoA=;
  b=NbG7cN0uwhWpZ9vjPuhtncRpdK/t8zwaLtTQyJqwem42TNzU7D455a1s
   H6v/RAtItX6SCalKAJ2Hsanv+oVmd/UoU7dS85l0H+hfWTaHmT4U0KEsE
   uEqxtqoOmto9c8E+TyEtfXFtfzGCF4m9AL3j4Og29tT+Ucf/vuNkEO0lV
   ROYlOhgz0yuBUH1gdubAbyFsDTViy05zZ93BCZfW1oFppqE8z6E6XQmih
   xAjeQImiDra7jIDAOjA6CEZ2+XQNLav6WVYJ3ncykH4hKAGqvro3QMRSy
   7wjxkVdRIdCCZe7DfLgmYr4XL+Bb0csZ+wyAg7cHj7+c6t3OCjE41TBfo
   g==;
X-CSE-ConnectionGUID: 4theJjGRSNanXa/oB4Di7A==
X-CSE-MsgGUID: nBdhBp6MRCeMnPsNDH/GVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="92005298"
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; 
   d="scan'208";a="92005298"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 04:20:13 -0800
X-CSE-ConnectionGUID: lFcTCJLTT7qVl6gTgkHKbg==
X-CSE-MsgGUID: gfVAX0whSwKEmO0YiJC7bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; 
   d="scan'208";a="194481728"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa009.fm.intel.com with ESMTP; 01 Dec 2025 04:20:11 -0800
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: trenn@suse.com,
	shuah@kernel.org,
	jwyatt@redhat.com,
	jkacur@redhat.com
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] tools/power cpupower: Reset errno before strtoull()
Date: Mon,  1 Dec 2025 17:47:45 +0530
Message-Id: <20251201121745.3776703-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpuidle_state_get_one_value() never cleared errno before calling
strtoull(), so a prior ERANGE caused every cpuidle counter read to
return zero. Reset errno to 0 before the conversion so each sysfs read
is evaluated independently.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 tools/power/cpupower/lib/cpuidle.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/cpupower/lib/cpuidle.c b/tools/power/cpupower/lib/cpuidle.c
index f2c1139adf71..bd857ee7541a 100644
--- a/tools/power/cpupower/lib/cpuidle.c
+++ b/tools/power/cpupower/lib/cpuidle.c
@@ -150,6 +150,7 @@ unsigned long long cpuidle_state_get_one_value(unsigned int cpu,
 	if (len == 0)
 		return 0;
 
+	errno = 0;
 	value = strtoull(linebuf, &endp, 0);
 
 	if (endp == linebuf || errno == ERANGE)
-- 
2.34.1


