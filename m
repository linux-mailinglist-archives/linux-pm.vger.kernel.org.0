Return-Path: <linux-pm+bounces-43961-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJ5nK/sFr2knLwIAu9opvQ
	(envelope-from <linux-pm+bounces-43961-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 18:40:11 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 544E523DBE1
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 18:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5B68E3014FEB
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2026 17:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A0C2F49F6;
	Mon,  9 Mar 2026 17:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="inWiGtRw"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCE12D592F
	for <linux-pm@vger.kernel.org>; Mon,  9 Mar 2026 17:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773078008; cv=none; b=jaU4ZzH4x9P97EwqfPaRHsxYu+HjMVvECxgXLrUNf7/i8DFtR8qTT0OvOsB9F3OXzkk6upQVtdE//DKGkzXqJ0sCI0jjXStWFN6nUbWaa4qpcA4wc0SngeLrh69bnR82IqkEjvpfKM/DDENZ5fXLMa9i32zyz5BX7vwGoKgNGXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773078008; c=relaxed/simple;
	bh=4of+esMVwsHs7EZ6T3Gqq0jbZOi8pJA6uhU/GzYviJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iP7928qSQIFKkuSrKlE2HacLSYp57BFCCdABFDrmPknl4rIh6GW8kcagwE/sOWCzDSsZKERtz1V51jIRPhp8ioxwDSioxQs2YGunQPP0ZFSuLC2NHL9chgxZCWCckbtbP5zE4YQlNdHdOU5uKCt/3BUff2GluZKHL4I/emZmvMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=inWiGtRw; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=kEiLvmpYmEETqxz0fvpkS+CaWS9KTMfrZBkdWOGWtIY=; b=inWiGtRwSdbOruWP2Qvek2rV8J
	PzRdheLsM1G85vmPwkeJvzD48teNs5tC9k1f75V9IHlU40+C3+0zXGaizuGMSY1Ty9rBEjoHrBiTU
	NXzF8X2euepAbNP1DKUsVlKLPlmQsQr9qLkhdGDxM1JCQTuL1t4KDliHuHkRd5HOOOyfIZEufCkXH
	wMyNJqhfJhCVycWyC0s3RAwQ7x5wpFUBrS+7YawwMFH4na0FYFc5pSErsq8e8mUCvmGzEFyE2Djd0
	p5nt1bbhnHSDpPRuXh2dmTllhwFyDI9n/nXu1oJkxi59hyCukPLx40sbNlZcQtkUJuA5EtJzPqPi/
	Hgm6misg==;
Received: from ip40.wifi.igalia.com ([192.168.12.40] helo=zeus.local)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vzeaI-00CA1M-MF; Mon, 09 Mar 2026 18:40:02 +0100
Received: from berto by zeus.local with local (Exim 4.98.2)
	(envelope-from <berto@igalia.com>)
	id 1vzeaI-000000009Lf-2Jud;
	Mon, 09 Mar 2026 18:40:02 +0100
From: Alberto Garcia <berto@igalia.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Brian Geffon <bgeffon@google.com>,
	linux-pm@vger.kernel.org,
	Alberto Garcia <berto@igalia.com>
Subject: [PATCH v2 0/2] PM: hibernate: Drain trailing zero pages on userspace restore
Date: Mon,  9 Mar 2026 18:39:40 +0100
Message-ID: <cover.1773075892.git.berto@igalia.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 544E523DBE1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43961-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[berto@igalia.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-0.992];
	DKIM_TRACE(0.00)[igalia.com:-];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi,

Here's v2 of the patch.

Changes from v1:

- The extra snapshot_write_next() call happens now at the beginning of
  snapshot_write_finalize(), but only when handle->cur is in the data
  page region.

- We return -ENODATA if snapshot_write_next() returns > 0 (indicating
  that the kernel was expecting another page).

- A second patch changes the userspace restore code to return -ENODATA
  when snapshot_image_loaded() fails.

Regards,

Berto

Alberto Garcia (2):
  PM: hibernate: Drain trailing zero pages on userspace restore
  PM: hibernate: return -ENODATA if the snapshot image is not loaded

 kernel/power/snapshot.c | 11 +++++++++++
 kernel/power/user.c     |  7 +++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

-- 
2.47.3


