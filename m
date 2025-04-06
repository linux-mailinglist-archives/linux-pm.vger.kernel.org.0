Return-Path: <linux-pm+bounces-24858-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D112A7CFD7
	for <lists+linux-pm@lfdr.de>; Sun,  6 Apr 2025 20:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2602716F7C3
	for <lists+linux-pm@lfdr.de>; Sun,  6 Apr 2025 18:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7AE1A8F68;
	Sun,  6 Apr 2025 18:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lwgg59pn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE30B1A8409
	for <linux-pm@vger.kernel.org>; Sun,  6 Apr 2025 18:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743965911; cv=none; b=fX+zDc3TAZ6zeg5lmzpuWkUhZdWZbVEE11MKcfHvXxz7XpyHswcHue8QvkAxh9mgHiYkqEpCDKLW7fzVHnozqDx3upBicVtpngVMeFf+QPSow83iTmSIR95KU1A9t3LhRBqe6GVF2onSCUoJhsOcesPJTVYQ2pUjPAdrKaSp/j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743965911; c=relaxed/simple;
	bh=yhc+OVt4LkWAucBB9PRBBBzCOtPpxvS4irABHPVOOUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fIT8bnErfkDwDKvzDkkXkYElYNi0R/Bz4HShH/WTtAxHk94paMfDzl4gm/56hPe22qMibAGfLoKjltemrv6ykKUW5Hec9GCuhq23xoY6Mhn2U0xDmKtb+KiadaaQyk74CsLUqiOVPifykN8iX1lHsmtJPfZh+Ethy75Bs4tjHrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lwgg59pn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C00C4CEE7;
	Sun,  6 Apr 2025 18:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743965910;
	bh=yhc+OVt4LkWAucBB9PRBBBzCOtPpxvS4irABHPVOOUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=Lwgg59pn+4zx3JybQ15IuUFiqrvtop8Tsuz501opfd336wxIaqbgW9K1OnzlANDmF
	 Z7j+D7BjZx1s0OaCO+Fq0GfI7UmSYRmSubuvJ5H2ngP5Rntpqms/W1uL3vQB1+7mOJ
	 dCfPTDf2VF0T6C0V2hv0moflmZoVWVH/Pn+Em2BIAKVSRSGgdnS46hwsXVlXQf1+gf
	 8bF4/GUV2q+PSs1QopUt7gB87ZLsSrO5xC4W5MTUIyyHhSGG9xO3evY0Hjl+vNFk7z
	 zFV/EbByiyLKW54T1RzRZemKlLKIFMwNROyXpC7WtE/WMI+XIdv6RJ9R9pURpKO+7B
	 KzrQZ2nG9+q/g==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 07/10] tools/power turbostat: Document GNR UncMHz domain convention
Date: Sun,  6 Apr 2025 14:57:16 -0400
Message-ID: <3ae8508663372b93c5556a887e96ed0ca5df0711.1743965272.git.len.brown@intel.com>
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

From: Len Brown <len.brown@intel.com>

Document that on Intel Granite Rapids Systems,
Uncore domains 0-2 are CPU domains, and
uncore domains 3-4 are IO domains.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.8 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index 144565151e1e..e86493880c16 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -205,6 +205,7 @@ The system configuration dump (if --quiet is not used) is followed by statistics
 \fBUncMHz\fP per-package uncore MHz, instantaneous sample.
 .PP
 \fBUMHz1.0\fP per-package uncore MHz for domain=1 and fabric_cluster=0, instantaneous sample.  System summary is the average of all packages.
+Intel Granite Rapids systems use domains 0-2 for CPUs, and 3-4 for IO, with cluster always 0.
 For the "--show" and "--hide" options, use "UncMHz" to operate on all UMHz*.* as a group.
 .SH TOO MUCH INFORMATION EXAMPLE
 By default, turbostat dumps all possible information -- a system configuration header, followed by columns for all counters.
-- 
2.45.2


