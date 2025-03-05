Return-Path: <linux-pm+bounces-23527-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B809CA50F2E
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 23:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05AD418848D1
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 22:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E808F20896A;
	Wed,  5 Mar 2025 22:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NjdAoXf4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5A9206F10;
	Wed,  5 Mar 2025 22:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741215224; cv=none; b=K3XNZ8deNIMxbDkg2mDPkE2SVRfodghNMgWCVtx4vaCgQQJBtB/cfxtRKMPZINTbi/dZ2vNYPHRGT/J2AXgkXApFjjZuy1C1X4r+mcqvLsm9XwexqR8/vCEfdR0Avjphp61sSxbABvywV9hYb7d1r+XnH9P2QxR8WOurKHQ3ry0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741215224; c=relaxed/simple;
	bh=ltt1rrUve+QJqi/9+uUhUJMVw+1kdsj6Hv1OtXOgqUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iun/EP/ZyIOCFTaLKQAJPf7nulzwPDQ5LJV6TzOGzJWrCLusn65eObDjtoF4967F2dxc3zytKk+bO31BMzVTZI0FaAXAGquHplbQ0otcZpkvO9f/H2VNf1xdwlLpz62DhfucST8EiTdXZgbVmAM2Pw4FWEI9Hsz9FgnjBeK5QsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NjdAoXf4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1653BC4CEE0;
	Wed,  5 Mar 2025 22:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741215224;
	bh=ltt1rrUve+QJqi/9+uUhUJMVw+1kdsj6Hv1OtXOgqUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NjdAoXf4DFAk3SJLKzf87fNdU0U8gU0yjGNWVbnsCzk2huOT8C2J0ghMaLMpFFIPM
	 MrZO+MhzmK3zXg51Q941qyzPYgL6Fax7CVAx7Ci609GqrqcfwJQj63CRGevffa7eod
	 CrSRMeqUzcZIvavyDOcZo0D5XuiotamkH0UT7vDc=
From: Shuah Khan <skhan@linuxfoundation.org>
To: shuah@kernel.org,
	trenn@suse.com,
	jwyatt@redhat.com,
	jkacur@redhat.com
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] pm: cpupower: Fix cmd_monitor() error legs to free cpu_topology
Date: Wed,  5 Mar 2025 15:53:39 -0700
Message-ID: <20250305225342.19447-2-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250305225342.19447-1-skhan@linuxfoundation.org>
References: <20250305225342.19447-1-skhan@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cmd_monitor() calls get_cpu_topology() to allocate memory for
cpu topology and fails to release in error legs.

Fix it to call cpu_topology_release() from error legs.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
index e123aa578881..0380d2e70016 100644
--- a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
+++ b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
@@ -427,11 +427,13 @@ int cmd_monitor(int argc, char **argv)
 
 	if (avail_monitors == 0) {
 		printf(_("No HW Cstate monitors found\n"));
+		cpu_topology_release(cpu_top);
 		return 1;
 	}
 
 	if (mode == list) {
 		list_monitors();
+		cpu_topology_release(cpu_top);
 		exit(EXIT_SUCCESS);
 	}
 
-- 
2.45.2


