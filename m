Return-Path: <linux-pm+bounces-24856-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B09EA7CFD6
	for <lists+linux-pm@lfdr.de>; Sun,  6 Apr 2025 20:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F00B1887D25
	for <lists+linux-pm@lfdr.de>; Sun,  6 Apr 2025 18:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B88B1A7262;
	Sun,  6 Apr 2025 18:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNFEbdRE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7783E1A5BAA
	for <linux-pm@vger.kernel.org>; Sun,  6 Apr 2025 18:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743965909; cv=none; b=YeuEBYLGM4vuk7stYWSlKS+/FZaqAEQq2jv4Hkbo6frU9ibhojbZP5qe+lxIqhBjg8PJVxFsErBZoCrbhHcRjKN3cy3+kqoOo1Ql3CzOd5uWTip86X7UE0j0zmxC7abuDAwMzJXlYbFROOfuu1BYbakvbPYukvfI5groWa/g1n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743965909; c=relaxed/simple;
	bh=6dxvlMJtzHBprvASZggI+VYGDRBseTStoDal0K69vZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i3+NmzzLqpsCVVvm+mVVmnOl5n0VArrELfgIvYhubL5/bIzV4bX/NC+Dt/WsJ1RTMZUqPL4hcSG4XhfmQt1jilw5wKJTVjDb8jlJA7TLaMav5p9hJ0cBYAIiZANFTZT2cFO+PMlnzJwEfK6/oUiQV5aqCOH7TpiedJ3TjcHc/C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNFEbdRE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D34EC4CEEA;
	Sun,  6 Apr 2025 18:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743965909;
	bh=6dxvlMJtzHBprvASZggI+VYGDRBseTStoDal0K69vZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=HNFEbdRE31Yzl9Zb0BqTfy5J92yZ1B8DLm+82Zlv+fzRBSJRRo1E40pUBD01tWXIs
	 vCb0EcgQiCUgarGDINbXK9DLoowPmNIL/DNH+9s5F+mbSFDEJzBRQ9ZKAuYz+UwsCK
	 TPk6fKwke2CNUTXM/JA2fENtSEMA/qcyULj8ADJeJ9TBB6Qd6CAfgsxq/jXQM9Jeq4
	 VNQP5ionfF7XQ9W99bbSx6qnno+/QjSnywjv+cFwXa3ECj2AMxaiynfQP2pyubOHAE
	 TwAGdUun0oS9b3pVgJWW1M/5m9tP/DTwyk+XUdHrLxil5uEAHycqlFYpO1weDFc3tL
	 up/taYZ3x0AoA==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Justin Ernst <justin.ernst@hpe.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 05/10] tools/power turbostat: Increase CPU_SUBSET_MAXCPUS to 8192
Date: Sun,  6 Apr 2025 14:57:14 -0400
Message-ID: <eb187540d13ae260b91dbca7257bc44bd83ca8c6.1743965272.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <1c7c7388e6c31f46b26a884d80b45efbad8237b2.1743965272.git.len.brown@intel.com>
References: <1c7c7388e6c31f46b26a884d80b45efbad8237b2.1743965272.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Justin Ernst <justin.ernst@hpe.com>

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
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index f29e47fe4249..218aca958923 100644
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
2.45.2


