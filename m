Return-Path: <linux-pm+bounces-24650-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC85FA76834
	for <lists+linux-pm@lfdr.de>; Mon, 31 Mar 2025 16:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D58E316622B
	for <lists+linux-pm@lfdr.de>; Mon, 31 Mar 2025 14:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14A422156E;
	Mon, 31 Mar 2025 14:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BU1jfacc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86B422156D;
	Mon, 31 Mar 2025 14:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431696; cv=none; b=kXF/JFyU6oooBIuXTSxHRGeFMFkJ2yGhSoidu953bE3gsn5oDN4VwpzKR4P84kmtQtxIkPPy5Gk3/R7mfh3trkzoUzO9odcnw/0QNtMhGi3O8qONcDcfvA63FPrj8gumqLBjU5nuM2XgQOG+zQlpL/fvw3Nffq1mcKp7IqHJMRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431696; c=relaxed/simple;
	bh=OwDSW0Yx5MMteLWtiExux18IwLA6wIA5DFoE2zRAAfM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Id5/krto/LTyPowYqXvM0ysuXX2Sj7DgkuMdUzGmc5PXWuv28T/0L04f3GvkdG1G7LGSPPctzMxtABKQ+SG8aoJt4FM/aKw013lLkxaOKuGXYi2mqU9L5uIXeQReYMxdjazJn0LfNJuNKdWTS40Ud0LO6G6dI3e3aHVTH+miy9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BU1jfacc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC7BC4CEE3;
	Mon, 31 Mar 2025 14:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743431696;
	bh=OwDSW0Yx5MMteLWtiExux18IwLA6wIA5DFoE2zRAAfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BU1jfaccERxRKeAaN6nOFGfU1OsGMDs7r3gU3nimIhKeDiGPRBYiGJJJVcimVTBeu
	 ZCbr386NlVCZb0v8d4gHVEpGb9nQZU1wDbEvwEC+hNh2xDp/Ju7De0RI4T0TIpX4Ui
	 jjkSGESsnM7zta0TedIcIOU27cWIFUMtheXUHbCYI0hghIXlDzujfBu9O3WL3EP1BX
	 qb9sw3cEm4kHBJRGfECFUHNto/P6mMDLW18dFHbN6QoVy/5rP0qkvmxHd8oXNEAS64
	 xQdphM5y6h1W769hDdLBnXLzJRtdRzAA6PMVqFd3hdAttwcT1cabmGYXSaSf3gqFDq
	 dHE1DjewLhvfA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhongqiu Han <quic_zhonhan@quicinc.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	trenn@suse.com,
	shuah@kernel.org,
	jwyatt@redhat.com,
	jkacur@redhat.com,
	peng.fan@nxp.com,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 02/16] pm: cpupower: bench: Prevent NULL dereference on malloc failure
Date: Mon, 31 Mar 2025 10:34:36 -0400
Message-Id: <20250331143450.1685242-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331143450.1685242-1-sashal@kernel.org>
References: <20250331143450.1685242-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
Content-Transfer-Encoding: 8bit

From: Zhongqiu Han <quic_zhonhan@quicinc.com>

[ Upstream commit 208baa3ec9043a664d9acfb8174b332e6b17fb69 ]

If malloc returns NULL due to low memory, 'config' pointer can be NULL.
Add a check to prevent NULL dereference.

Link: https://lore.kernel.org/r/20250219122715.3892223-1-quic_zhonhan@quicinc.com
Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/cpupower/bench/parse.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/power/cpupower/bench/parse.c b/tools/power/cpupower/bench/parse.c
index 080678d9d74e2..bd67c758b33ac 100644
--- a/tools/power/cpupower/bench/parse.c
+++ b/tools/power/cpupower/bench/parse.c
@@ -121,6 +121,10 @@ FILE *prepare_output(const char *dirname)
 struct config *prepare_default_config()
 {
 	struct config *config = malloc(sizeof(struct config));
+	if (!config) {
+		perror("malloc");
+		return NULL;
+	}
 
 	dprintf("loading defaults\n");
 
-- 
2.39.5


