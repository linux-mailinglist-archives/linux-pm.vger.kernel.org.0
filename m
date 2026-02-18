Return-Path: <linux-pm+bounces-42796-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APKqKyoslWlkMgIAu9opvQ
	(envelope-from <linux-pm+bounces-42796-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 04:04:10 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A3B152C75
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 04:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85D37302B38E
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 03:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25D8272803;
	Wed, 18 Feb 2026 03:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbO1Xxzx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5A619DF4F;
	Wed, 18 Feb 2026 03:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771383847; cv=none; b=MC90Qj0w+hq3OB0vOiJZRLhG17x4iMkQ5IioNyHNvpnKW5RQwh365+vXM/9O7QivvhZuES7vPu2YltyrNDjFk9Nw0H3y2GXcDho9+m+nZ0s3ej9vZ6gZlio3TLJm/wsO1jKuTcNTHE++kpWgMSTXmhKnGHQT7k39g4EhF1mlEGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771383847; c=relaxed/simple;
	bh=n5C8O2UjAbnVhM65NF7FyqtQEYGhu8ksdxvDSsZVZbs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=POTq1N8JY0iIdiJq05JGXmmy4wqhCnKVNZVBrYpoQL7t5+atjYL9pasdhem44zHVg115luU23W2onF5gGPbIC7h3OLMfLgyRevtNb4nkVl9siS/QHt9ZEXcOmB3BO6Ip7UY5yH//wz4NyBM3/cWoyl8MrvtXxlC241JiQTvCA2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbO1Xxzx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E00C4CEF7;
	Wed, 18 Feb 2026 03:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771383847;
	bh=n5C8O2UjAbnVhM65NF7FyqtQEYGhu8ksdxvDSsZVZbs=;
	h=From:To:Cc:Subject:Date:From;
	b=mbO1XxzxGJZIJn7HVragMojD/kYwPYiuLtWHisIFGcGAuNZJbrYg6DIHLM3a/8wi5
	 3HjLALFo+oT8O0yzt4Sqp8ZiI7W8g2XiVYGZh5Cbr7/tZ92RhzU8wQgEzZ0YXW33cL
	 SB7QnBHN6Dsk/pzT18Ju17r7C/+lrEf72bYXRwKnCWBLllX8NJAYpGLyMe2iucXuBz
	 awDMVtdu9XFhVoPr5kskaH2isRPIpk5TNTh1zftW84eImghdN0/FltjvFY27DvAAKd
	 jexnAw0oby+HbsX07Me7ky68KiqOHo4rDrD42BWPU9LUzdrCKlxjCd25PIacN2TqiF
	 QzJAYG3tbCk5Q==
From: Len Brown <lenb@kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] turbostat-v2026.02.14+AMD
Date: Tue, 17 Feb 2026 21:02:03 -0600
Message-ID: <20260218030402.694540-1-lenb@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42796-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[lenb@kernel.org,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 35A3B152C75
X-Rspamd-Action: no action

Hi Linus,

Please pull this turbostat-v2026.02.14+AMD patch.

thanks!
Len Brown, Intel Open Source Technology Center

The following changes since commit 51496091dd37b405e6e399a9638da3f1da3f4c64:

  tools/power turbostat: version 2026.02.14 (2026-02-13 14:08:33 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git tags/turbostat-v2026.02.14+AMD

for you to fetch changes up to cfd5ff044914fd5f7fae2403675b68593f986055:

  tools/power turbostat: Fix AMD RAPL regression (2026-02-17 20:47:16 -0600)

----------------------------------------------------------------
turbostat-v2026.02.14+AMD

Fix regression on AMD in 2026.02.14

----------------------------------------------------------------
Len Brown (1):
      tools/power turbostat: Fix AMD RAPL regression

 tools/power/x86/turbostat/turbostat.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

