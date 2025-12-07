Return-Path: <linux-pm+bounces-39269-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B667BCAAFF2
	for <lists+linux-pm@lfdr.de>; Sun, 07 Dec 2025 01:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BD09E3005D0E
	for <lists+linux-pm@lfdr.de>; Sun,  7 Dec 2025 00:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F0E1D63F3;
	Sun,  7 Dec 2025 00:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="coy/8GRZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9FC35965;
	Sun,  7 Dec 2025 00:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765068464; cv=none; b=ONaDBsv34mWBfF7hKqd7D4zDjHkgGlDAz2nqU4Y+89es/+xCT3tEgB+PXBJ/S/gDiPkWCsr5jv8pri3XSM3o1HueNtkPQ4vuL4jomUtc76tI+rajYwEBYnd3Kkp17e/74fryHLTgezBh729a05A4dc99W7jJnl6BDH5LesDq5YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765068464; c=relaxed/simple;
	bh=7fLftqxZw1yXBlTthiEFPzfncPEc9sSS3KOwUnxqTwM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=juv8iNfHcLcfD4FegEL7SGhiFPp5uTgy9mFt2LZr6hFMncIzencaIiM5Fc27IJo6P+BmZYz/U9Fj+Gs8vUbPQxtZVCsaWo/SvVG/I9pJpTHYC1XRN/369FW3TbufePLbDwkXw4Kbbmsvs2dDrGXcCL+eP7Sdwgr2tFZrxWkIxPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=coy/8GRZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC10FC4CEF5;
	Sun,  7 Dec 2025 00:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765068464;
	bh=7fLftqxZw1yXBlTthiEFPzfncPEc9sSS3KOwUnxqTwM=;
	h=From:To:Cc:Subject:Date:From;
	b=coy/8GRZuoMbr6M64r5eXBG6gA+bH+freCUXfZVK7mAIXq2OG4rphN+q1SjIQPodp
	 HJoEu1k0rKCm50ZTozkQ3BB8eZYYD78sUD3CJGNFPpUOB1v940+1eHXeU/l8d9FFhe
	 jcW4kHClrCaB9TozywOLsZBeTe+FsKfAfjVEA9zBHrhI1yzeiyvetZ+c1brm+5msst
	 zVgo9uf6WnXzO8ih/IJJkDCCwnC3m2Zpifw2ERUfbtw0N50qv/z7pnx4k8uoQT/Nzg
	 dk4C3majEPHfFkLItUJ17QgmSmWNAqLcCA1I+73OdrmivPmpoeV1PmXJId3nX2cId0
	 9VnUtJmDKPqxA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	lukasz.luba@arm.com,
	rafael@kernel.org,
	pavel@kernel.org,
	lenb@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH net] ynl: add regen hint to new headers
Date: Sat,  6 Dec 2025 16:47:40 -0800
Message-ID: <20251207004740.1657799-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent commit 68e83f347266 ("tools: ynl-gen: add regeneration comment")
added a hint how to regenerate the code to the headers. Update
the new headers from this release cycle to also include it.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: lukasz.luba@arm.com
CC: rafael@kernel.org
CC: pavel@kernel.org
CC: lenb@kernel.org
CC: linux-pm@vger.kernel.org
---
 include/uapi/linux/energy_model.h | 1 +
 kernel/power/em_netlink_autogen.h | 1 +
 kernel/power/em_netlink_autogen.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/include/uapi/linux/energy_model.h b/include/uapi/linux/energy_model.h
index 4ec4c0eabbbb..0bcad967854f 100644
--- a/include/uapi/linux/energy_model.h
+++ b/include/uapi/linux/energy_model.h
@@ -2,6 +2,7 @@
 /* Do not edit directly, auto-generated from: */
 /*	Documentation/netlink/specs/em.yaml */
 /* YNL-GEN uapi header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
 
 #ifndef _UAPI_LINUX_ENERGY_MODEL_H
 #define _UAPI_LINUX_ENERGY_MODEL_H
diff --git a/kernel/power/em_netlink_autogen.h b/kernel/power/em_netlink_autogen.h
index 78ce609641f1..140ab548103c 100644
--- a/kernel/power/em_netlink_autogen.h
+++ b/kernel/power/em_netlink_autogen.h
@@ -2,6 +2,7 @@
 /* Do not edit directly, auto-generated from: */
 /*	Documentation/netlink/specs/em.yaml */
 /* YNL-GEN kernel header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
 
 #ifndef _LINUX_EM_GEN_H
 #define _LINUX_EM_GEN_H
diff --git a/kernel/power/em_netlink_autogen.c b/kernel/power/em_netlink_autogen.c
index a7a09ab1d1c2..ceb3b2bb6ebe 100644
--- a/kernel/power/em_netlink_autogen.c
+++ b/kernel/power/em_netlink_autogen.c
@@ -2,6 +2,7 @@
 /* Do not edit directly, auto-generated from: */
 /*	Documentation/netlink/specs/em.yaml */
 /* YNL-GEN kernel source */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
 
 #include <net/netlink.h>
 #include <net/genetlink.h>
-- 
2.52.0


