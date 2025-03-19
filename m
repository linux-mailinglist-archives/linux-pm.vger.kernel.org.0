Return-Path: <linux-pm+bounces-24324-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27830A69ACE
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 22:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F4821680AB
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 21:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921BE1DE3A9;
	Wed, 19 Mar 2025 21:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="ma6IT+d7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF914A1D;
	Wed, 19 Mar 2025 21:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742419440; cv=none; b=mnYSorhNE8pI5qpIdkXWcSuAgQAnbFah1+fcUsrrJ5BFTZXydCbiv4AHoUT1guCkNVGUEzQIeb/+psW8YyRdpstRGOLy47tLXAFDzQ/4ul7LhEBYtCH9kfshkxfG+R1uGWOuer0TOB66MDAEHjUkMp6/RWR4ALFvOUrbsR/0h88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742419440; c=relaxed/simple;
	bh=YsC2PH6HLyqCgb3DMrG1QZFnMFuZDxjMaNHci169mnc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YHCSJuRNJkttMz/r2me/XhCh0pJMVzh9jfbDjsdh8lQTIpkW06mrYp/lwHob3Bg4dYsbDc5L4LZFY3RryNFXPghl8jGrlMKRt6ajmbwhnIVhEuk9PwTWEbL9seLdezgxb5nZi6xhi8VhkLnxpQO3w7wCD/VMgV3VZN9pke4dTac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=ma6IT+d7; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JCBVGP005803;
	Wed, 19 Mar 2025 20:20:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pps0720; bh=XqJrfl7hvAFHoIlHnGXjypKYN2YSyNzDmZXQO
	yzzboM=; b=ma6IT+d7chDYnqtP76WOPq0gLZe4czM0D4dWeg75zg5VeYT9c5HUD
	3IoG0nR2VtY3DrHF01F1+GwObVrKlG8KnSzJJGpbhOMs++tyUuVzqtIo+uHKnYNu
	b6aw/7JjiWr5YdxSSqNcF9/JS1IMHetYBCMsjcHkjPdaH4gOrEr0+sNZ+lIZQhaN
	LKDseg4dzQvOvZEzFiH1+yfW2LeIW8yJHFAJP6cWH42VAeWceIriKskEvAW64EAf
	3L8cHkpEU8q82OOBAWQj1713pf5cnxE7A4NVfNjNkBuQliWYFlFPFDEacIYAbhGB
	M8u4k+YKIg2GBIoYM+zvKgTQc+eMlxi5Q==
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 45f87yfxvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 20:20:17 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 21035295EF;
	Wed, 19 Mar 2025 20:20:17 +0000 (UTC)
Received: from stormcage.eag.rdlabs.hpecorp.net (unknown [16.231.227.39])
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id CA365806B1A;
	Wed, 19 Mar 2025 20:20:16 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 605001)
	id 3D64764B64C; Wed, 19 Mar 2025 15:20:16 -0500 (CDT)
From: Justin Ernst <justin.ernst@hpe.com>
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Justin Ernst <justin.ernst@hpe.com>
Subject: [PATCH] tools/power/turbostat: Increase CPU_SUBSET_MAXCPUS to 8192
Date: Wed, 19 Mar 2025 15:19:37 -0500
Message-Id: <20250319201937.5368-1-justin.ernst@hpe.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Z9vZEBEKUnSCjwt-RvlmM-XNfjkTfXYH
X-Proofpoint-ORIG-GUID: Z9vZEBEKUnSCjwt-RvlmM-XNfjkTfXYH
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_07,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1011
 spamscore=0 suspectscore=0 priorityscore=1501 mlxscore=0 adultscore=0
 phishscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190136

On systems with >= 1024 cpus (in my case 1152), turbostat fails with the error output:
	"turbostat: /sys/fs/cgroup/cpuset.cpus.effective: cpu str malformat 0-1151"

A similar error appears with the use of turbostat --cpu when the inputted cpu
range contains a cpu number >= 1024:
	# turbostat -c 1100-1151
	"--cpu 1100-1151" malformed
	...

Both errors are caused by parse_cpu_str() reaching its limit of CPU_SUBSET_MAXCPUS.

It's a good idea to limit the maximum cpu number being parsed, but 1024 is too low.
For a small increase in compute and allocated memory, increasing CPU_SUBSET_MAXCPUS
brings support for parsing cpu numbers >= 1024.

Increase CPU_SUBSET_MAXCPUS to 8192, a common setting for CONFIG_NR_CPUS on x86_64.

Signed-off-by: Justin Ernst <justin.ernst@hpe.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 8d5011a0bf60..f9f8df587b76 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1121,7 +1121,7 @@ void probe_platform_features(unsigned int family, unsigned int model)
 int backwards_count;
 char *progname;
 
-#define CPU_SUBSET_MAXCPUS	1024	/* need to use before probe... */
+#define CPU_SUBSET_MAXCPUS	8192	/* need to use before probe... */
 cpu_set_t *cpu_present_set, *cpu_possible_set, *cpu_effective_set, *cpu_allowed_set, *cpu_affinity_set, *cpu_subset;
 size_t cpu_present_setsize, cpu_possible_setsize, cpu_effective_setsize, cpu_allowed_setsize, cpu_affinity_setsize, cpu_subset_size;
 #define MAX_ADDED_THREAD_COUNTERS 24
-- 
2.35.3


