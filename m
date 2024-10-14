Return-Path: <linux-pm+bounces-15587-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 997BB99BE85
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 06:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F71FB23AEF
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 04:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A8F1547D8;
	Mon, 14 Oct 2024 03:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q22JjSKW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467A61547C9;
	Mon, 14 Oct 2024 03:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878274; cv=none; b=et9cBoY0DRu+mZxjGenDeS26bdkFO2T18Hu8faL2x0kNv+YveS6rKZtSsGm4cS74rlzXHo0fI4rx6AyKBCPvLCVbshM4VQAYzgQ+/UqaOQ53BJMwTT9Nl1JMdynRmYO00yu5NE+UMcqRrg9/XFPCb2oZHXdItB/VyMCmVxoPLH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878274; c=relaxed/simple;
	bh=NHueDwG/Yb0tNMRQqG4HMYO4CTuQuVefVT3WIOaAKLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MK/TIgpaAYLuE6WWtUu0gJuoD2sQMuK3b6W55tUfwywTgTYmse5dlqkxy6XHUx5KYR6R+SS2a6AmvVvGYmPkEkY/LFwWpEh3st/O3tPMUfJLkfhBTv9OwmMtcsDtf6IJyhkVw1INdOHOiwxP1vkFtqQe/AsaVmHGqfFMBYK49Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q22JjSKW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117F7C4CECF;
	Mon, 14 Oct 2024 03:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878274;
	bh=NHueDwG/Yb0tNMRQqG4HMYO4CTuQuVefVT3WIOaAKLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q22JjSKWq+aCzEuFrCKuoTk/xYj6U4395tN5DYkZlrKSZ4iAQym6rTbIGiymXPGIl
	 nf9U9qEGJ/e1uA+yGREz3gW2t1yi+BVNrsn/HieaUC5zpcJoZZkYXCrr0iLI6H4zov
	 gxMu4QLjVIndxhvU3PXLf2SbTrooxwR/2J/CZvU2DmF0Jh2BVaeQtu25N+V05nuoRo
	 3EQtqsMYvsJPnO8J482v4pjffSsQNXBLOyJdIY/E/hfD7d0kgg3aEbXY5HpUEBX3s9
	 669gaJzGhg0kP33PcTZViDuxaCDqcfOL91o9xBgHNU7dEJzaBzgZtwzrrV7qj3Buyx
	 omzzoR23utrqQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 15/20] powercap: intel_rapl_msr: Add PL4 support for Arrowlake-U
Date: Sun, 13 Oct 2024 23:57:17 -0400
Message-ID: <20241014035731.2246632-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014035731.2246632-1-sashal@kernel.org>
References: <20241014035731.2246632-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.3
Content-Transfer-Encoding: 8bit

From: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>

[ Upstream commit f517ff174ab79dd59f538a9aa2770cd3ee6dd48b ]

Add PL4 support for ArrowLake-U platform.

Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Link: https://patch.msgid.link/20240930081801.28502-5-rui.zhang@intel.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/powercap/intel_rapl_msr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index 733a36f67fbc6..1f4c5389676ac 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -147,6 +147,7 @@ static const struct x86_cpu_id pl4_support_ids[] = {
 	X86_MATCH_VFM(INTEL_RAPTORLAKE_P, NULL),
 	X86_MATCH_VFM(INTEL_METEORLAKE, NULL),
 	X86_MATCH_VFM(INTEL_METEORLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_ARROWLAKE_U, NULL),
 	{}
 };
 
-- 
2.43.0


