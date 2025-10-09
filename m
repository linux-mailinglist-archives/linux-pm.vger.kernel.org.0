Return-Path: <linux-pm+bounces-35883-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 64769BCAB65
	for <lists+linux-pm@lfdr.de>; Thu, 09 Oct 2025 21:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC5384FCC55
	for <lists+linux-pm@lfdr.de>; Thu,  9 Oct 2025 19:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFF9254864;
	Thu,  9 Oct 2025 19:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArEfk2SV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B3D23A9AD;
	Thu,  9 Oct 2025 19:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760038459; cv=none; b=V0ylW/wWPhhSgMEWgOKxGBM/pqyhAeilLRlpo5La8c6OGgVdUNQ8hlqxn50pNTEaUxuLvAP4fpmvx1W4y6Nna04ihx1MZ8ziQWxLnPS2GRH1ZgCUpiAj/+4Iod9bJb6E3ZVFpNlnyNH13C7kS5MrGuEQo1jiqK2vLrMKyYe9WCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760038459; c=relaxed/simple;
	bh=8HiEbeLQ4eILUOcHGbv+e+VKBDpS1Nnq500kcdoPbsw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rtFxZq6bRcNmCKH1o0DjVeMUT5fe8ehpZMfMyXQzeGv4454t4vd5k+acCG/RNd8wjgTZGg0drWIcP9v8nQjL/8FnXMYPahdLJkqOQt7NyYThuZka5rzk4NQX+qYt2PquYYY4YipPI8e9MYD7OV0k2R7kcMrWPFygVM1oDAPOjA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArEfk2SV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E24C4CEF8;
	Thu,  9 Oct 2025 19:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760038459;
	bh=8HiEbeLQ4eILUOcHGbv+e+VKBDpS1Nnq500kcdoPbsw=;
	h=From:To:Cc:Subject:Date:From;
	b=ArEfk2SVMHYlwTRXt3oSB9ij60lfrDwdFw0kQWHWZrzt4BZ+1oL1NMuIaLd1kaViw
	 7h6ydT2mD9WuVZkxNeueenPhr4+E6QeWHamz+XMUQ3G32oGSf6Kfy7qoRMFIsT2Rn0
	 252Er5IJA6XJ3vVvUxc5d6xaOD3mCcZzkKbuI7OYD8FB3+OlEHLGconF9aJEwOL7vc
	 WV/cmQQfCiQVGEvFBUF5aiyfbSF0lTzwzHaSzRR++Gy5/tG5NmoveTjpeMJSpDFMyN
	 8WvKVAh0wFNZtBqRCWxNVUwYR6Lv7j7xXNW5yZ3ReAz1Bj042/nnC0JhTYlwh05EEG
	 6gf8Dj/1pvfLA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1] PM: hibernate: Rework message printing in swsusp_save()
Date: Thu, 09 Oct 2025 21:34:16 +0200
Message-ID: <10750389.nUPlyArG6x@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The messages printed by swsusp_save() are basically only useful for
debug, so printing them every time a hibernation image is created at
the "info" log level is not particularly useful.  Also printing a
message on a failing memory allocation is redundant.

Use pm_deferred_pr_dbg() for printing those messages so they will only
be printed when requested and the "deferred" variant is used because
this code runs in a deeply atomic context (one CPU with interrupts
off, no functional devices).  Also drop the useless message printed
when memory allocations fails.

While at it, extend one of the messages in question so it is less
cryptic.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/power/snapshot.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -2110,22 +2110,20 @@ asmlinkage __visible int swsusp_save(voi
 {
 	unsigned int nr_pages, nr_highmem;
 
-	pr_info("Creating image:\n");
+	pm_deferred_pr_dbg("Creating image:\n");
 
 	drain_local_pages(NULL);
 	nr_pages = count_data_pages();
 	nr_highmem = count_highmem_pages();
-	pr_info("Need to copy %u pages\n", nr_pages + nr_highmem);
+	pm_deferred_pr_dbg("Need to copy %u pages\n", nr_pages + nr_highmem);
 
 	if (!enough_free_mem(nr_pages, nr_highmem)) {
-		pr_err("Not enough free memory\n");
+		pm_deferred_pr_dbg("Not enough free memory for image creation\n");
 		return -ENOMEM;
 	}
 
-	if (swsusp_alloc(&copy_bm, nr_pages, nr_highmem)) {
-		pr_err("Memory allocation failed\n");
+	if (swsusp_alloc(&copy_bm, nr_pages, nr_highmem))
 		return -ENOMEM;
-	}
 
 	/*
 	 * During allocating of suspend pagedir, new cold pages may appear.
@@ -2144,7 +2142,8 @@ asmlinkage __visible int swsusp_save(voi
 	nr_zero_pages = nr_pages - nr_copy_pages;
 	nr_meta_pages = DIV_ROUND_UP(nr_pages * sizeof(long), PAGE_SIZE);
 
-	pr_info("Image created (%d pages copied, %d zero pages)\n", nr_copy_pages, nr_zero_pages);
+	pm_deferred_pr_dbg("Image created (%d pages copied, %d zero pages)\n",
+			   nr_copy_pages, nr_zero_pages);
 
 	return 0;
 }




