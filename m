Return-Path: <linux-pm+bounces-43920-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mTtgN7sQrmki/QEAu9opvQ
	(envelope-from <linux-pm+bounces-43920-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 01:13:47 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6B1232D9A
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 01:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A57C9300C253
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2026 00:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C3014EC73;
	Mon,  9 Mar 2026 00:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="X3CSB+lv"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AF013DBA0
	for <linux-pm@vger.kernel.org>; Mon,  9 Mar 2026 00:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773015222; cv=none; b=X8qCkdaiPm7QYVxOCivjy/Ryi3Irzxev9dJHusZHbLL/WcH+qOe0c9y2v8EnfP/4L34Fd8azfptEN9x85Qk9T/y3gAlxMZxIkdT4unF+UCEee1uPI4SaTt7+Spz5zU1ZMyY9ygfM7WfmoBbIcx86b3kO4uzuNI0jcphEa3cVSK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773015222; c=relaxed/simple;
	bh=7hge/c1FzFJxU6cYFtojBvp62U7nFskSXoiBCW0A3W8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ALd+xE5BjZR2zlPnRp593j4QdeF3LP7Fgzw2o9HEickJnR1Sml8kt+pJXFnIv8nGkNorY7WEwMWRlNX1qJwMFGDVUV+y5rcVQloCBeuV6kioquPwABftX+scPSguCjxm4XudV1n6VLedds8O1rHQnEHwkkwQWBK+H8nhDJWsy64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=X3CSB+lv; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=8qTiUAobwljUSNsBcEDXvYGVw0VHcwFFCh0XG+hdXq0=; b=X3CSB+lvrdoQhgXCGbAjivLMnY
	Yq2ZnO3+lqm5pe7RRuoVUQpz5r/2B4qie9d8xX3hvHZPY72t/McoNUKLdEfw0mLK2l/RIyD83PfzL
	NHqWVYt0XwvAEVpuqfx0bsNwlGKoWG2aMGREmnmpFvTxUnrQcT24dsAaqzUB5XYvy4719W569GAT/
	ZcRM9m7YLYlz8icifFZs0jDN0NIZRmKAZJWQFuoiTebx8963n/gkQVL5kkR9+ZRunMtSnswfg0WCj
	Gj6pq+NKtrhjIGgRRMHG01clUwp0YMQ0ivhQHUCTevUv654UWNsUpp6LeeTdRYKRSr3CpoFxH+v+D
	t4CBv92w==;
Received: from 94.pool92-176-6.dynamic.orange.es ([92.176.6.94] helo=perseus.local)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vzOFT-00BaN5-O3; Mon, 09 Mar 2026 01:13:27 +0100
Received: from berto by perseus.local with local (Exim 4.98.2)
	(envelope-from <berto@igalia.com>)
	id 1vzOFS-00000000oD4-3BlS;
	Mon, 09 Mar 2026 01:13:26 +0100
From: Alberto Garcia <berto@igalia.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Brian Geffon <bgeffon@google.com>,
	linux-pm@vger.kernel.org,
	Alberto Garcia <berto@igalia.com>
Subject: [PATCH] PM: hibernate: Drain trailing zero pages on userspace restore
Date: Mon,  9 Mar 2026 01:12:50 +0100
Message-ID: <20260309001250.192841-1-berto@igalia.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3F6B1232D9A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43920-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[berto@igalia.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-0.118];
	DKIM_TRACE(0.00)[igalia.com:-];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
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

Fixed by calling snapshot_write_next() in the SNAPSHOT_ATOMIC_RESTORE
handler before snapshot_write_finalize(), giving the kernel the chance
to process any trailing zero pages.

Fixes: 005e8dddd497 ("PM: hibernate: don't store zero pages in the image file")
Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 kernel/power/user.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/power/user.c b/kernel/power/user.c
index 4401cfe26e5c..d5f189c4c93e 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -319,6 +319,14 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 		break;
 
 	case SNAPSHOT_ATOMIC_RESTORE:
+		/*
+		 * We need to call snapshot_write_next() one last time
+		 * before finalizing in order to process any trailing
+		 * zero pages.
+		 */
+		error = snapshot_write_next(&data->handle);
+		if (error < 0)
+			break;
 		error = snapshot_write_finalize(&data->handle);
 		if (error)
 			break;
-- 
2.47.3


