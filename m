Return-Path: <linux-pm+bounces-43962-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GUvCFIGr2knLwIAu9opvQ
	(envelope-from <linux-pm+bounces-43962-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 18:41:38 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3FF23DC26
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 18:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D77F0304CE87
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2026 17:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E352D5C91;
	Mon,  9 Mar 2026 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="qiPMwYAK"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC7C2C11D5
	for <linux-pm@vger.kernel.org>; Mon,  9 Mar 2026 17:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773078009; cv=none; b=oQ2U3qjIkTYrxtjYIz0crGK5fMc9c6mHIJHCoDT74mc/CmpXLj3pFRMPjxGA/BifeK8EhOktfyS7/QcEx1V9k0XSD73TFpW1KUCUMaiHZHS5shuoNQBnfDqoNRUSb90WjtOb4IwxL8wg6dZSzDUk9JgMfEfgNchdM/fYEysIkbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773078009; c=relaxed/simple;
	bh=HUovX/F0nObGI/nwo2fOreAPd4GMsCOwudtejdISop0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BpdKfioUDxbZIAU+CTYORJqjTRtcbWPD2uqPBJ+2NGbhQzLqv+zNfNXoKWbQhCoH5aiVlou3L3tTvmWyD9v2Ci1UYJWSyYPrl/lwcETMu8tYyAf1wMZlOZYSVin8Uju6Bmx/klZKmJ6fdYgbS7apJ7mIyDEVyaLjBKheSRN8Xos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=qiPMwYAK; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=yIM7ymtRJ1rpCEhK9ooCz945t++QzOTvGcQeeAAil4w=; b=qiPMwYAK34F0p30SjMTR3JSaNb
	uFv+rfeDSCPy+naZ1F0Hq6g/h2Ma6pZQ/y2rWi7HEe2SNk8Lr3BxAh7MCtRW2evdRpNdafbztEap4
	nyUDTkUVf4OQtsO4ss2CvenuMVTDYzxSMt83W6RgTaxu9IkL5BDm9NP4342T8AmfbM4zeQe0L314e
	ihjRVW9sXVeL5rf9jS54cI0sgJmNmn1o4xTsX/T57cHH4P/kqGZPlR3xfqCFVNJ9N7PEVXa+DZ/HM
	ccb17u/W8KHtAPM0hACQbtrjDiUDDHIMsCkqigdTnNhE9pArAppv2PkYpytP4iJHhfcrU7UXA0kVk
	Q3BZpFPQ==;
Received: from ip40.wifi.igalia.com ([192.168.12.40] helo=zeus.local)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vzeaI-00CA1N-MX; Mon, 09 Mar 2026 18:40:02 +0100
Received: from berto by zeus.local with local (Exim 4.98.2)
	(envelope-from <berto@igalia.com>)
	id 1vzeaI-000000009Li-2SKG;
	Mon, 09 Mar 2026 18:40:02 +0100
From: Alberto Garcia <berto@igalia.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Brian Geffon <bgeffon@google.com>,
	linux-pm@vger.kernel.org,
	Alberto Garcia <berto@igalia.com>
Subject: [PATCH v2 1/2] PM: hibernate: Drain trailing zero pages on userspace restore
Date: Mon,  9 Mar 2026 18:39:41 +0100
Message-ID: <ef5a7c5e3e3dbd17dcb20efaa0c53a47a23498bb.1773075892.git.berto@igalia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1773075892.git.berto@igalia.com>
References: <cover.1773075892.git.berto@igalia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7D3FF23DC26
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43962-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[berto@igalia.com,linux-pm@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-0.993];
	DKIM_TRACE(0.00)[igalia.com:-];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,igalia.com:mid,igalia.com:email]
X-Rspamd-Action: no action

Commit 005e8dddd497 ("PM: hibernate: don't store zero pages in the
image file") added an optimization to skip zero-filled pages in the
hibernation image. On restore, zero pages are handled internally by
snapshot_write_next() in a loop that processes them without returning
to the caller.

With the userspace restore interface, writing the last non-zero page
to /dev/snapshot is followed by the SNAPSHOT_ATOMIC_RESTORE ioctl. At
this point there are no more calls to snapshot_write_next() so any
trailing zero pages are not processed, snapshot_image_loaded() fails
because handle->cur is smaller than expected, the ioctl returns -EPERM
and the image is not restored.

The in-kernel restore path is not affected by this because the loop in
load_image() in swap.c calls snapshot_write_next() until it returns 0.
It is this final call that drains any trailing zero pages.

Fixed by calling snapshot_write_next() in snapshot_write_finalize(),
giving the kernel the chance to drain any trailing zero pages.

Fixes: 005e8dddd497 ("PM: hibernate: don't store zero pages in the image file")
Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 kernel/power/snapshot.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 6e1321837c66..a564650734dc 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -2855,6 +2855,17 @@ int snapshot_write_finalize(struct snapshot_handle *handle)
 {
 	int error;
 
+	/*
+	 * Call snapshot_write_next() to drain any trailing zero pages,
+	 * but make sure we're in the data page region first.
+	 * This function can return PAGE_SIZE if the kernel was expecting
+	 * another copy page. Return -ENODATA in that situation.
+	 */
+	if (handle->cur > nr_meta_pages + 1) {
+		error = snapshot_write_next(handle);
+		if (error)
+			return error > 0 ? -ENODATA : error;
+	}
 	copy_last_highmem_page();
 	error = hibernate_restore_protect_page(handle->buffer);
 	/* Do that only if we have loaded the image entirely */
-- 
2.47.3


