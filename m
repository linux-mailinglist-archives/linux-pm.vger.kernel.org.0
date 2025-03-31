Return-Path: <linux-pm+bounces-24647-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D20A76814
	for <lists+linux-pm@lfdr.de>; Mon, 31 Mar 2025 16:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D11BB3ACBC7
	for <lists+linux-pm@lfdr.de>; Mon, 31 Mar 2025 14:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2347821504A;
	Mon, 31 Mar 2025 14:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9SlQduH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9B7215040;
	Mon, 31 Mar 2025 14:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431656; cv=none; b=DagN9HXtwqt/x2a5+upMbmiBYxOVLMydoIDIhPAjlXyJGWQQlj6ouV+AeGmSI6qpxMi1NvAlpxaaZOfhHUS5lXvNs09bCSn7ytRRL1WEc/j4+G7Kq4qHzUYSDd7qAlVrdQI/ljw5W1AgvtYVHovADpXoW7pAzn79dHfobj5xLPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431656; c=relaxed/simple;
	bh=OwDSW0Yx5MMteLWtiExux18IwLA6wIA5DFoE2zRAAfM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iw0/FuqR7SOOpEpSckF+dEc9DNMeyd5t1pY9b6FpJLiJY0V3DoH5kw7nvsrz924bqgYYMnU9WJL80RWRfnczkhtRlDpqWxzcgpReGk6yK9iXg+4czxDtBMg7QlYqj7pYIPMSzwxLwTKIR4Tz5Q2FJecwQO7fwlBeHhkXBQ2eVY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9SlQduH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903EAC4CEE3;
	Mon, 31 Mar 2025 14:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743431655;
	bh=OwDSW0Yx5MMteLWtiExux18IwLA6wIA5DFoE2zRAAfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k9SlQduHPUQUje7cnq9wP16jlfwLcEm7PBX1E9Z5Tp3YQOBxdnSSE9YR2mvGxIEbS
	 poeWsZBGROfQ60N5UTzp5X0TdnCiwt7cje3orUgtAtNWt1b90ll9Lipl8Yk+UdK/pl
	 X1w7xXoF2RUd/Zv6thnmScCXFVL6wQLE/TFQR+pt6sxpkg4KsliErdMacjqbUY84wS
	 eIxX91vJaCFqoKwPfYE3MVGhw97T7P6uDFr7QmM/cVV3vp8mDiDfpMNVm2QxBdDcY0
	 bwQIgT/chx710DuzIFyN5mebz7n9gKfnWHObj09Mo4c3qGUJm4Ml573PwJ4LohPc15
	 ZZO5HogrUKGLw==
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
Subject: [PATCH AUTOSEL 6.14 02/18] pm: cpupower: bench: Prevent NULL dereference on malloc failure
Date: Mon, 31 Mar 2025 10:33:52 -0400
Message-Id: <20250331143409.1682789-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331143409.1682789-1-sashal@kernel.org>
References: <20250331143409.1682789-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
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


