Return-Path: <linux-pm+bounces-20282-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E28BDA0A6E3
	for <lists+linux-pm@lfdr.de>; Sun, 12 Jan 2025 03:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F03CB167A91
	for <lists+linux-pm@lfdr.de>; Sun, 12 Jan 2025 02:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8C8611E;
	Sun, 12 Jan 2025 02:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b="Zz1j/V6e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L+BLe5zA"
X-Original-To: linux-pm@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC88010F4;
	Sun, 12 Jan 2025 02:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736647306; cv=none; b=j6f2q8rr/etzNn9TBjhLQZkM32rGAHlzb4AEOlOr1skRHKdxumSG7XhSV3HlBD8qmESrpnmhZYCdciPsD+G73HAryosMGwFU/0snMVd6LbM/MP9wwaZ3Ck96mMwn3bruPAAks/wxa/cxi8RZxu8o1BN4Yi3fB+WSfxJhOBsklAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736647306; c=relaxed/simple;
	bh=Dlwaj7rPawpw8zYfPKC+xeBhCtnl+DmBD6nK1hGaxfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QFtsgpad2gAqCPOC4LKCQawDwEyIf+mQLMw8VHRB6WS4BCuCsdek8pAUxmSRXQk0p4HJAIh7xOUSvQuJ7mS5Uh0hRKHUtk1ehbAZzgvOqTaH+5TLCVZ8TEO5798n3QHNkzPEc+6UaOGHRqzi6OuPrc2DFEf8vjfqi0QRiB03eX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com; spf=pass smtp.mailfrom=davidreaver.com; dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b=Zz1j/V6e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L+BLe5zA; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidreaver.com
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BA29A2540103;
	Sat, 11 Jan 2025 21:01:42 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sat, 11 Jan 2025 21:01:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=davidreaver.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1736647302; x=1736733702; bh=TpeIoDATxs
	isnMNoEwo4GRZnOSdlm0MBzd0wFXTRka4=; b=Zz1j/V6ed+DSlhDw9QdlBq8Li1
	GnZetf+AD3iqrKviNJFWnYaqV3CnZbqnZ3i4AnmYwu7RoW6Q3ECD8v7lxeEjb0Ai
	1wAE2kt7o7Q6DwtA1KkhJv8AFK0O+pGmRvPiTzImfuAZW3yy31urJfvbAgtW1eqs
	vYMirF/KsrykbUY2MM0z7X3NXpAcofjhfcUFFhAV1SOT7xdwmTEWx+4cn7byq/fz
	vaOnKdURPwXevoq6ijRiTQzBJ4aSXW7Upi/6lhl1BJGNr4XYGJE5wE9idKqIKlN4
	UpXiq4NLm8vu0zXKvk4trUiImXslJ9z7eYOgbPWR/k3yF1AP0yg136pAtdNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736647302; x=1736733702; bh=TpeIoDATxsisnMNoEwo4GRZnOSdlm0MBzd0
	wFXTRka4=; b=L+BLe5zAnpAvjc1OotgRC507gHhqBuUE8OieHW2KKK2xvDFxSFW
	p/I0YuoQBozBgEodeB/sF2cdgjzOiCnrzQw+xU1PxlXUbuOLrgP9N1hlcJi86CkK
	6dYCzA/m6ZRpRxOtLDJIergeNV+SjpLb+NXxUVtW8ppDMfSIpq7CU1/8Jk53n6st
	2WR8eB7BOyIi3Js87UBjgUibZbIF/rcNJsQl4JMYFEwuUyrD3+fRVoiDk6l0AKAx
	U/jHnC1IQB3t9Un+yCljCqQqmwGkOSY1cNUok7RWFucAlTuILtFsAtz7mHJ2E1yG
	JsuSk+kE2ePS5kLQG3w3Wm7Z1rwyZtY12bA==
X-ME-Sender: <xms:hiKDZ9ZbGWNybcdh3O-F_TrJNFCUhV6PPEmzXc-ZTfCbs97eX6_4LA>
    <xme:hiKDZ0Z6jH9gg0Nos2rqQhSJ3rWL5zxfd1k0AjmkJ4WG59TCL3fYje2GsdxNQnaaO
    U2YDBgT-pZw-ymRo94>
X-ME-Received: <xmr:hiKDZ_9Lk-je2a0Hlwmn9lm38hFfmEdq1ZmRWBXbRztDOqWUW0HehXsCgAnTLYVK8ONInWPJL6PXtWKfRM82hfFrxwtOUwyToBzvP4Gz6U0BwrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehuddggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfh
    rhhomhepffgrvhhiugcutfgvrghvvghruceomhgvsegurghvihgurhgvrghvvghrrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeevjefgueffgfelvdeigfefgfdvtefhuddvheeffeeg
    gfejteelhfegvedvhfefleenucffohhmrghinheplhifnhdrnhgvthdpkhgvrhhnvghlrd
    horhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    mhgvsegurghvihgurhgvrghvvghrrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphgrvhgvlhesuhgtfidrtgiipdhrtghpthhtoheplhgvnhdrsghrohifnh
    esihhnthgvlhdrtghomhdprhgtphhtthhopehmvgesuggrvhhiughrvggrvhgvrhdrtgho
    mhdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehirhgrrdifvghinhihsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:hiKDZ7rh9dJ6tbn3dYlvy0zNH2tuw7JYAEEaXel5NjVWldVWP6bV9w>
    <xmx:hiKDZ4r8OVtni0r7GZzxDj_mGWNd-n8SPFIvPj3i-4S17kh8ZHBtfA>
    <xmx:hiKDZxQfs-yquHGPgKjGSI2ngJoSAmBgUFePSjheXsm9tOE4ZszTaQ>
    <xmx:hiKDZwrFPSdw1pV1ItNiYQaQlxxcfKFIXnHndLtZ22z60vbWX3sy1A>
    <xmx:hiKDZwIiwRVYUjieRbEHY8JgHR7l1xPc8gCqMdaJukBTIGHC2E6qnK52>
Feedback-ID: i67e946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Jan 2025 21:01:41 -0500 (EST)
From: David Reaver <me@davidreaver.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>
Cc: David Reaver <me@davidreaver.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] pm: Replace deprecated kmap_atomic() with kmap_local_page()
Date: Sat, 11 Jan 2025 17:55:32 -0800
Message-ID: <20250112015535.191527-1-me@davidreaver.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kmap_atomic() is deprecated and should be replaced with kmap_local_page()
[1][2]. kmap_local_page() is faster in kernels with HIGHMEM enabled, can
take page faults, and allows preemption.

According to [2], this replacement is safe as long as the code between
kmap_atomic() and kunmap_atomic() does not implicitly depend on disabling
page faults or preemption. In all of the call sites in this patch, the only
thing happening between mapping and unmapping pages is copy_page() calls,
and I don't suspect they depend on disabling page faults or preemption.

[1] https://lwn.net/Articles/836144/
[2] https://docs.kernel.org/mm/highmem.html#temporary-virtual-mappings

Signed-off-by: David Reaver <me@davidreaver.com>
---
 kernel/power/snapshot.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index c9fb559a6399..87f4dde4a49d 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -2270,9 +2270,9 @@ int snapshot_read_next(struct snapshot_handle *handle)
 			 */
 			void *kaddr;
 
-			kaddr = kmap_atomic(page);
+			kaddr = kmap_local_page(page);
 			copy_page(buffer, kaddr);
-			kunmap_atomic(kaddr);
+			kunmap_local(kaddr);
 			handle->buffer = buffer;
 		} else {
 			handle->buffer = page_address(page);
@@ -2561,9 +2561,9 @@ static void copy_last_highmem_page(void)
 	if (last_highmem_page) {
 		void *dst;
 
-		dst = kmap_atomic(last_highmem_page);
+		dst = kmap_page_local(last_highmem_page);
 		copy_page(dst, buffer);
-		kunmap_atomic(dst);
+		kunmap_local(dst);
 		last_highmem_page = NULL;
 	}
 }
@@ -2881,13 +2881,13 @@ static inline void swap_two_pages_data(struct page *p1, struct page *p2,
 {
 	void *kaddr1, *kaddr2;
 
-	kaddr1 = kmap_atomic(p1);
-	kaddr2 = kmap_atomic(p2);
+	kaddr1 = kmap_local_page(p1);
+	kaddr2 = kmap_local_page(p2);
 	copy_page(buf, kaddr1);
 	copy_page(kaddr1, kaddr2);
 	copy_page(kaddr2, buf);
-	kunmap_atomic(kaddr2);
-	kunmap_atomic(kaddr1);
+	kunmap_local(kaddr2);
+	kunmap_local(kaddr1);
 }
 
 /**

