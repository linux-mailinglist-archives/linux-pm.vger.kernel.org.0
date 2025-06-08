Return-Path: <linux-pm+bounces-28227-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C34BAD13A8
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 20:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 458943A7F75
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 18:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EECE1AA7BF;
	Sun,  8 Jun 2025 18:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGAsYKr7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9C51A3BD7
	for <linux-pm@vger.kernel.org>; Sun,  8 Jun 2025 18:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749406735; cv=none; b=hwMC5/cy4P+BpNdRcL6HYBbntQgrGpS99PV5j52UgekFbYNUsKcO43dugF5Lu9XAgbSVKh38OyDNdHkdhJhtwDRoT67ElvGOZiWfpr6KBeSKcBxQ8oVGh3u9SWbG/abOkMEAcruIKikjX/W06Q0wl22qQfolpSQuYmJEouFbs70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749406735; c=relaxed/simple;
	bh=ZhJ2gLrasD2U78bWqLudH48AH8DIqnqflUJNr7IS02Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7hcxFO+r4pXVGkI1LQx9wsEYwNpXRIcNXVUypb3gZ+R9nW3LCxwDN3WkkRexcq9vNuIOk8xR7V+FYHLHBFriLzVSXkNWG+cxKta5SAvpN8P5VB8Kxm1A4e32W304yrrQyGmYulk6ZSGV28u/6NTlXxNFPrn2/1W4x7rIYZ5VUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sGAsYKr7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B6BC4CEF0;
	Sun,  8 Jun 2025 18:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749406734;
	bh=ZhJ2gLrasD2U78bWqLudH48AH8DIqnqflUJNr7IS02Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=sGAsYKr7tsOEd+i8fp+lycbyzUlNo802bOJLFlu2sNQiva1DGfwGar2Yz9EnrJhAD
	 L1gMzGbzB1zCGBv1y56mGtyle2kb7xd3uX8EBQ1nfO253xEgfk248XfQT2ldhuMuvG
	 gfmDoiOl0eHWF2+0pXb1wx7PrXLYCojv3vD0fd14IdCsVDd3gRPMAnRazIyWUxVhyK
	 9xyOE4rJS48b7Uf2UGY1n9dSAyjZGHUz4NcBFwVqXc8+uhxDd9rZh6oojbsgDAlzsX
	 L8U/N9nUN+0hRRBzPddEkQgKYE4XPqW+r/CEs6LMx2138actMfChVW38fw1yqAhpVW
	 y4i/WPHengzUA==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 02/18] tools/power turbostat.8: pm_domain wording fix
Date: Sun,  8 Jun 2025 14:17:01 -0400
Message-ID: <04c332f20ef2cdc945d1666e1625f925a67bafb7.1749406068.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <780da8a9557f2d114aaffda0eb0a517fe6a244c8.1749406068.git.len.brown@intel.com>
References: <780da8a9557f2d114aaffda0eb0a517fe6a244c8.1749406068.git.len.brown@intel.com>
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

turbostat.8: clarify that uncore "domains" are Power Management domains,
aka pm_domains.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.8 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index 183d9c0fb315..fb11108aaf42 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -204,8 +204,8 @@ The system configuration dump (if --quiet is not used) is followed by statistics
 .PP
 \fBUncMHz\fP per-package uncore MHz, instantaneous sample.
 .PP
-\fBUMHz1.0\fP per-package uncore MHz for domain=1 and fabric_cluster=0, instantaneous sample.  System summary is the average of all packages.
-Intel Granite Rapids systems use domains 0-2 for CPUs, and 3-4 for IO, with cluster always 0.
+\fBUMHz1.0\fP per-package uncore MHz for pm_domain=1 and fabric_cluster=0, instantaneous sample.  System summary is the average of all packages.
+Intel Granite Rapids systems use pm_domains 0-2 for CPUs, and 3-4 for IO, with cluster always 0.
 For the "--show" and "--hide" options, use "UncMHz" to operate on all UMHz*.* as a group.
 .SH TOO MUCH INFORMATION EXAMPLE
 By default, turbostat dumps all possible information -- a system configuration header, followed by columns for all counters.
-- 
2.45.2


