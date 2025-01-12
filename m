Return-Path: <linux-pm+bounces-20286-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 489A4A0AA75
	for <lists+linux-pm@lfdr.de>; Sun, 12 Jan 2025 16:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4412C188698A
	for <lists+linux-pm@lfdr.de>; Sun, 12 Jan 2025 15:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE85E1BBBD7;
	Sun, 12 Jan 2025 15:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b="ABOQ6pNQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SsGU9rsx"
X-Original-To: linux-pm@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4296B1B87F1;
	Sun, 12 Jan 2025 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736695652; cv=none; b=YlRaaP20jqHsQjFkY5SOuXDZFtdNKFQ6lsgbCForE/C04mB0gDqoOwG7j/hOioqI6kp1qBQ49Q191ApohVb9vVc/AJ/Nc8uZF/T3zV86qQ8gI+ybfYpZW6B4WLw4H7tkGoilsE8q7bz/aP7IUlNf6bvanuKfHn89RNJ2E+rzG34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736695652; c=relaxed/simple;
	bh=m80bTON8+0D60GagRiEUG3vf/RTyAS1oZXFLEEZ1RZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qey7WEWl/mJlevsw4dYKr3Lxc3CdU++WX7XEgehUho5KWKz+aNr07azAiTkBIQx/nEa3sI22HIMc9w4xdCpfte08X7NHB5OBeg6MdBePkfqB6Y7Pvas9C+qfbYVwLiEvB706aXdG9LzRyTmHsfkhqYMJW+bF+KOtK3noRZSxgjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com; spf=pass smtp.mailfrom=davidreaver.com; dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b=ABOQ6pNQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SsGU9rsx; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidreaver.com
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3A4FA254013E;
	Sun, 12 Jan 2025 10:27:29 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sun, 12 Jan 2025 10:27:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=davidreaver.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1736695649; x=1736782049; bh=QyheYS6cKw
	DEhzsywIw4eYoDpMnSfkgd8PrJ6LEBzI8=; b=ABOQ6pNQath2ys7/59efyD5U82
	iH4rEF6vcACu3zb691TqsNSsBCLoqW9ye9qROCAhbrFty0pP90DLDEATtM1/wgz7
	sxYrtujwDYPCZxNTPa8T1CDtlu8Xyc29azxwrKLpha7aWC4F2oP/EaQJsSBH6NIv
	HTFTrpo8PCQbtPkbPcgQ3F0/1kZC3E/rmVUWo+C+ZKWLSqHILTfZftWaoGOVbQZp
	rXVkxwdwyh9qRxC7eMMT+HXqL+eLHePOGJjUjhf4KOK9uv1pPW5rbZJT5M3uL4u8
	NQs0mwE30FfAfRTVT+lplHk7URHnmyl2jp6JdY5DK3DQubIqtpFItFVXBz4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736695649; x=1736782049; bh=QyheYS6cKwDEhzsywIw4eYoDpMnSfkgd8Pr
	J6LEBzI8=; b=SsGU9rsx2vie65PJ9gMh8pPqgZBJYX7vossogRgh8t7fAIavvD1
	PbZVpZ3WfVL5h+FSjBb3JBxsVUjP2I/dM6o8oHOObdYNGuS/tF2poMj7IFG0WsDB
	ySI5otUCAVWl5BmmY2laC1A5pUXKMedLh3gF/q8FtMtexM7/FTJXIPywlZygYbfZ
	hifDt8sKpa+iM1ZHlJZcmSDWua4XbWdOrDLSrZ8fUWKhcDZsKdg/NotyrnkuhQHf
	e40B6tERRM8McRk4+Q5LQQ7Wwi4SAIH/OuRPlAHJ/dqoZCtXUh571EYk18LXyEGf
	rG8d2PITETbSf9EUbt3+sYxKAZp6VDNQ2sQ==
X-ME-Sender: <xms:YN-DZ1I52x7rmaDtidsu1Jkifr7cWDhar-q0H1c2Fr6pyBeeLdCZlA>
    <xme:YN-DZxIwZVRpz37ul4voB1iBosX012BmNHj7BJ63zg1xxKbXTTWArk7PufjBABcXo
    9mijFDKxiyaZeSKap0>
X-ME-Received: <xmr:YN-DZ9v7PbwiUR8-KGy3jJC9RTbIrSNmpFocFEO0nt-0SvBCpHR1nZvSykPY7ajd-yTk9OsIv7xbs2bspCiiewMkOKQSSoA_hxwTdwEWtmnBMLc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehvddgjeejucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:YN-DZ2ZqcjP1zy_-GrLSzIxmWdjDdRSeqAAeZxn43dgfEUitVBgegg>
    <xmx:YN-DZ8a1mnkDfHTlpgzfwFIH-nVVgd-XEblnwUmIE2tMeZsxy-fXZw>
    <xmx:YN-DZ6DlnY3c_Yd3LVVCFv4DdplRI6KsySvrJ1LoVpCA5ECcEEwVYg>
    <xmx:YN-DZ6YWpgqM7pdyb1YMWmXZPjyh-p-IZL3WBw-RN9dmH18S1dvd_g>
    <xmx:Yd-DZ87iorK3Y4xmkCXqkJuzAENlGJDsv3O0Dp0_8sWd0msdtooDQzZk>
Feedback-ID: i67e946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 12 Jan 2025 10:27:27 -0500 (EST)
From: David Reaver <me@davidreaver.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>
Cc: David Reaver <me@davidreaver.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v2] pm: Replace deprecated kmap_atomic() with kmap_local_page()
Date: Sun, 12 Jan 2025 07:26:55 -0800
Message-ID: <20250112152658.20132-1-me@davidreaver.com>
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

Apologies, I tried testing a CONFIG_HIGHMEM kernel in QEMU and clearly made
an error because there is an obvious typo. Any pointers to test setups for
testing CONFIG_HIGHMEM in a VM would be appreciated! Here is v2 of the
patch.

V1 -> V2: Fix typo kmap_page_local() -> kmap_local_page()

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
+		dst = kmap_local_page(last_highmem_page);
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

