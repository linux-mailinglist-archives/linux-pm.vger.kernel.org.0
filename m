Return-Path: <linux-pm+bounces-39926-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 33869CDD453
	for <lists+linux-pm@lfdr.de>; Thu, 25 Dec 2025 05:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC1863014DE8
	for <lists+linux-pm@lfdr.de>; Thu, 25 Dec 2025 04:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF5B22425B;
	Thu, 25 Dec 2025 04:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="TWwztiAT"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF9118A6CF;
	Thu, 25 Dec 2025 04:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766635303; cv=none; b=foctiHDu7+c1QYpG9baWKpc8ze8Tv7/VBzpOUBfivJcSYybiWaiGU5FAV1ft7kMsb/LZhSYL95YkE/i3JpzvQtzSyh7D6A5dAO3Gl8QV3ZZDctjSyksnw7fc8CqInZrvhJ1fFy/NWftyOCttEpjNiuvVYvz2aHTuEMHYKqJAYlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766635303; c=relaxed/simple;
	bh=hJysfRjJTushzuu59PdwNmXhK03fRR3ksyu3RLmpdxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R+CazO3UGSUInxh+e43HCGIxvvdb6I1mrGbXBJVUk2THRVYZXd2tZhvY7bEA/19g9io8beSWsL+5CF+irTDhagySV4gfcIZ8R8X84hTKZIiA0lImrjcwX2Pn8mY1htyZ3oTenDr4Bs2rwXzGJcnS9qoB+tS2fNu/wE4Jmjik7+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=TWwztiAT; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=UhWTOkAZA+dz1Nq7KQoFDikneq1yPjcN1s7NbbqCjLE=; b=TWwztiATrz8Gd7l5XTQS/8RaRT
	XoXNANof8Wb2SScTkVZUMkWo0qb8ocnLLuC9M90fSI+jQ+MwrBMREFOpjZESk2chpbzrqb0c9rBNk
	N3inC2SqgboE2QSkVl4GXNE/0VxzVx6KVnIDxiBVhvmVyAhQ1aq0divlpiQIf3VZRP39XpK5JaEGZ
	AIa4jWjvvk299mGtrq6TeyBEw+ebJ2YkX0Ldy3pb4SxamtO3nW5o9G7BX0R9LK7U4lRVPTQUDCJBJ
	d2/S682xS34kQVy7xhShvUailKl43GC9HsfsQl7dJqWzWrWl7GYmD/g4l2MlnRrH+iL6isFfFdc0d
	xXwh1yJA==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vYcXO-00GLl3-S7; Thu, 25 Dec 2025 05:01:19 +0100
From: Changwoo Min <changwoo@igalia.com>
To: lukasz.luba@arm.com,
	rafael@kernel.org,
	donald.hunter@gmail.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	lenb@kernel.org,
	pavel@kernel.org,
	changwoo@igalia.com
Cc: kernel-dev@igalia.com,
	linux-pm@vger.kernel.org,
	netdev@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH for 6.19 1/4] PM: EM: Fix yamllint warnings in the EM YNL spec
Date: Thu, 25 Dec 2025 13:01:01 +0900
Message-ID: <20251225040104.982704-2-changwoo@igalia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251225040104.982704-1-changwoo@igalia.com>
References: <20251225040104.982704-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The energy model YNL spec has the following two warnings
when checking with yamlint:

 3:1    warning missing document start "---"  (document-start)
 107:13 error   wrong indentation: expected 10 but found 12  (indentation)

So let’s fix whose lint warnings.

Fixes: bd26631ccdfd ("PM: EM: Add em.yaml and autogen files")
Suggested-by: Donald Hunter <donald.hunter@gmail.com>
Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 Documentation/netlink/specs/em.yaml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/em.yaml b/Documentation/netlink/specs/em.yaml
index 9905ca482325..0c595a874f08 100644
--- a/Documentation/netlink/specs/em.yaml
+++ b/Documentation/netlink/specs/em.yaml
@@ -1,5 +1,8 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
-
+#
+# Copyright (c) 2025 Valve Corporation.
+#
+---
 name: em
 
 doc: |
@@ -104,7 +107,7 @@ operations:
       attribute-set: pd-table
       event:
         attributes:
-            - pd-id
+          - pd-id
       mcgrp: event
 
 mcast-groups:
-- 
2.52.0


