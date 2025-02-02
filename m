Return-Path: <linux-pm+bounces-21225-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBD7A24F18
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 18:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B652B3A5135
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 17:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9826E1FAC46;
	Sun,  2 Feb 2025 17:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvjPdS3I"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D4A1FB3
	for <linux-pm@vger.kernel.org>; Sun,  2 Feb 2025 17:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738516378; cv=none; b=lJoc1FPjx+QqraLncbszcYKc6vFKVWo9yZx5DsTSM4bAnVSaWMs2+4F++jGUAeduvWAmhZDsG+huVzH/JZgy7T82XUMV4IxMyxP84J9J4wzB52DaTKRnHsk99KEUhTxoPZtg882vIu+ZXgtvzW+FvMGmN7+LcgDNibX7Il8i2dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738516378; c=relaxed/simple;
	bh=YpoCBFRyDucXp1U1wc7UCPdWl5hqKNieTjRsh0K14q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r5CKzM1kisbG44h15cTX0aY4SWBmGh3MOdcoyv4IHCK4MYZJDRCrxkcBi+8wm3vki+OzNRgbjvP3Zusz5g1qO6GecFpiGnwTKb29EAm5iF8gX7yvSZYR1fmhRL/QeAxZjB8pvazLg/4uM7K9bQk0sQ9CZGUs4uVXubLLe4LrjDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvjPdS3I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5741C4CED1;
	Sun,  2 Feb 2025 17:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738516377;
	bh=YpoCBFRyDucXp1U1wc7UCPdWl5hqKNieTjRsh0K14q0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=UvjPdS3Izb8x8nGumPXRBmyn4Upqqrd36MkiOj/5ABPKoX3vrtt1Z/0eaX48y3WhE
	 mzMgsM5k5OCUZgwwtltiW34aB1aM9LnXAi0W3/wGbUja/h05W1WsC9jHvsRlmARi76
	 57+X+ha2QhCH0QEBGCNYrrmyvilfDdXCjOLnSryMgL11wtoTJlAXci4Nxm1R5nYFJe
	 J12iMXWt/PnYN5cRVbqxZY53sDsZ6i3rV/iCx6V/ILPkZGB+o6IhoEm9YFxrtw5Gkk
	 y0+ge/2g1jjHt7a0V98DNNx132vi/12MnNzuhvixwGhdvsBr0pe9Hc3xuIYr3X1/Cn
	 GTg1nl8z4JD7Q==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 02/25] tools/power turbostat: Add initial support for ClearwaterForest
Date: Sun,  2 Feb 2025 11:09:18 -0600
Message-ID: <6b47ed23e2f1bc2c177da47437970e6208ac9ea0.1738515889.git.len.brown@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <e8a99af68c068865dbac7f3330e97bf8e96edf33.1738515889.git.len.brown@intel.com>
References: <e8a99af68c068865dbac7f3330e97bf8e96edf33.1738515889.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Zhang Rui <rui.zhang@intel.com>

Add initial support for ClearwaterForest.
It shares the same features with SierraForest.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 540336138ce9..e203f109dd2e 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1037,6 +1037,7 @@ static const struct platform_data turbostat_pdata[] = {
 	{ INTEL_ATOM_GRACEMONT, &adl_features },
 	{ INTEL_ATOM_CRESTMONT_X, &srf_features },
 	{ INTEL_ATOM_CRESTMONT, &grr_features },
+	{ INTEL_ATOM_DARKMONT_X, &srf_features },
 	{ INTEL_XEON_PHI_KNL, &knl_features },
 	{ INTEL_XEON_PHI_KNM, &knl_features },
 	/*
-- 
2.43.0


