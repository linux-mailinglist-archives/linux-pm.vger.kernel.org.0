Return-Path: <linux-pm+bounces-24658-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF05A768A3
	for <lists+linux-pm@lfdr.de>; Mon, 31 Mar 2025 16:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECE287A142F
	for <lists+linux-pm@lfdr.de>; Mon, 31 Mar 2025 14:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F83922D4DD;
	Mon, 31 Mar 2025 14:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3atrgKf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C8921B9F6;
	Mon, 31 Mar 2025 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431851; cv=none; b=cfVLgVkYynSmXRYSgCd+So6RIXM8xkO6S6F2r6l3Ye6SG2hzYmORo90GBSNhnRh13LqPvQiAzAFlHO39cR75RqZNdcA2AT+PAmwpXmwd7UkZS92j7ckfJlqNJj299Eg1R+IZnhWQqYRi5HqDpKIINPznH2fPTZIiKevyfb9FO2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431851; c=relaxed/simple;
	bh=doh+7ARyEYWjZJvgKfbqcxfkqsBHv0qsRf5JId0INjw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EhvqlLfBG/owoGBfXP9ueugCJSyVZ8qTscD7r5xYqdnxZ9LpwYhx+r8V8/0PF0CXaH318lnvZeFQQKPf5qXEA7sJrh7BnkA1PkWaIHT2stOzEivOsZbG2HCP2BbVA5zniIOMi8NH27cSUAKbnz3fEefe/ACr4YQ3K1gZSMoR+xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3atrgKf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AAD2C4CEE4;
	Mon, 31 Mar 2025 14:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743431850;
	bh=doh+7ARyEYWjZJvgKfbqcxfkqsBHv0qsRf5JId0INjw=;
	h=From:To:Cc:Subject:Date:From;
	b=k3atrgKfckisFLP/9gKDGvlWCvIe2BVdG+IH6il79cD2Fe8xe3o+IKTfcsS+/gD0Z
	 xfxRXCAY6CKJzdJ1jRcyKLMcU30cQ5DslY+kc1HYYMM3hiXpA0RhYg0nAiHP8t8QmW
	 lfLuvrBm0GH09bIMJ4x+ZA7/Tk/hZsJQfPGiyw3U16GKNdUHXXbSLPZDRdmcEqSe1y
	 6SWqVx258NG52PNTDBQhRav/92R3mpNBb0f+nz/aPubCYQP3VoLwwu01hf89PVe8/Z
	 h/QaP9jcYRcNzgCRCfhAwLGhCR4BZU0cdTI4gfSU54Ei5LcdQro8+tiZONjfsXc7NO
	 dMh0VsyH4IpBQ==
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
Subject: [PATCH AUTOSEL 5.4 1/5] pm: cpupower: bench: Prevent NULL dereference on malloc failure
Date: Mon, 31 Mar 2025 10:37:22 -0400
Message-Id: <20250331143728.1686696-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.291
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
index e63dc11fa3a53..48e25be6e1635 100644
--- a/tools/power/cpupower/bench/parse.c
+++ b/tools/power/cpupower/bench/parse.c
@@ -120,6 +120,10 @@ FILE *prepare_output(const char *dirname)
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


