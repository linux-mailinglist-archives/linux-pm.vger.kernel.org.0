Return-Path: <linux-pm+bounces-40417-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C0807D011B4
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 06:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9715B30090C8
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 05:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEE5314D06;
	Thu,  8 Jan 2026 05:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="OG+74xTH"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC19316907;
	Thu,  8 Jan 2026 05:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767850362; cv=none; b=KcKuSLLJ/ObM8LHdghSMoaNZjcXJPwysjgYLDjZqaVgvyMg2saS7Bls9G9ryOd+rUO+8Y60xy6YMKwAsXOA6ytfoW5K/b3J4wMQLcfhRBRytJ85UJs18vMfrMwdGG/xI91Mdune5vSwImZQi5Cbj8HYP04sZIMl0VN64vmT0WpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767850362; c=relaxed/simple;
	bh=J4DwyMS6de8BpkEYc7jdXGTm8GfItIWYblTA/b67bEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QPr85I4BsnHwqr687a8ZsTFhi+Y41ojWYpJAWyfZ55AAvERWCQ60TfL8T/scvpa8V9reXgnlS9sunNnTrKK/URi3C/BgQ/WXA/et3BEHa8IYNFyTdenG8VSJhwbZsTyJUtLfwRK+t7AIksAnp16mQ8OBZ7BRsGSTQWH3GRwB9qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=OG+74xTH; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=kbRrHvbGNHiAo2u6YcZTMI1SyjuIImVhTBv78uBUNAA=; b=OG+74xTHe0LXOC0VKQMb2rkaST
	zNOYKMbwDWJYvzwerZOECCJiaEpkPWSZ8/7A1TlKC68RUfiXDqB0dLYtu66nYI3ARCpFoKf+ClxPz
	C+TyVhQlTUkhIAPMYxPuDikfSSzGihCJybcTMxbT8t5PqX0+03bTeToySg1elTSvX5+Kec983FPn2
	FEXeSfJ+xOnxJpxxfUPnP+eiG/wRpeKW4YJqFXrXB/I8vD99yc+67VtWzdEshqTrF/j8DeCnnC/X3
	etVtkawekyKfc0U6vJ5NIDMWeHoUO/E4E4hWz/wE9qiduH/BDUgKs58zagj1Zg/FX4GGYMF2d6qDF
	l5YAzsaQ==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vdidJ-002qDP-Fe; Thu, 08 Jan 2026 06:32:30 +0100
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
Subject: [PATCH v2 for 6.19 1/4] PM: EM: Fix yamllint warnings in the EM YNL spec
Date: Thu,  8 Jan 2026 14:32:09 +0900
Message-ID: <20260108053212.642478-2-changwoo@igalia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108053212.642478-1-changwoo@igalia.com>
References: <20260108053212.642478-1-changwoo@igalia.com>
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
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
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


