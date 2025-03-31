Return-Path: <linux-pm+bounces-24655-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C26A7687E
	for <lists+linux-pm@lfdr.de>; Mon, 31 Mar 2025 16:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 411687A145D
	for <lists+linux-pm@lfdr.de>; Mon, 31 Mar 2025 14:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C22B2163BD;
	Mon, 31 Mar 2025 14:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONngiiDw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F60B215787;
	Mon, 31 Mar 2025 14:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431797; cv=none; b=bgdnXsOvRHDtH7DMk8dmJSwmJkT32YwqEjyBnNl6NpTkCTUTnlhVZ7ftB8HwMj+Covcgvxkl1L50jrW+FF5cMnzF5SaGRvXceUTFP156epIb9TvpJA39htgmxZdP0FSGB2QZaDBJeFqetAfXHV9O74A+QhXMY5gF7SVuFJEuSoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431797; c=relaxed/simple;
	bh=doh+7ARyEYWjZJvgKfbqcxfkqsBHv0qsRf5JId0INjw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KPFRYGMaNSGcectNvQqrxlIunHJ2MYTLTYc6cwgbpi32KYsFGzK/4YvIL+ZaakwGhi82T8pkuJRYmE7KQ/Xvtxx91fauKAWOGhMddZMgD+cw1JxK/yKmXKL5G0O0UJTa3lPMPa2WQEMSfq8bfCq49d9gHV3+TWooKGRfNaWavr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONngiiDw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C44A8C4CEE9;
	Mon, 31 Mar 2025 14:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743431797;
	bh=doh+7ARyEYWjZJvgKfbqcxfkqsBHv0qsRf5JId0INjw=;
	h=From:To:Cc:Subject:Date:From;
	b=ONngiiDwbRoEUhdXZyNkRSqkmwstJzEuTolFTeaIdutfYdXq+YE6O1jTIBIYLxX7s
	 NEgJIRO0JganFq8bEXLjyIiSvp+YBYbfplHT1bu7PJY06BOmPwVYLnQSZNlQpB/bO4
	 BEso+C3blIEs10Ze4A6zEY14d7dxuOcjcaLOHCjPHYXYKaSLbHA9U5g7x968QCqM2i
	 aK6dMhz6Q2eWinnk0YAbu9fgtTl77tgZrjFheSwBSkNK4QzriAX/cWZlhJJj5LrzcG
	 JzgyTtm8LoTZKPWWHvXTnZJJMqRLT8ZGVkU3FlOJsWqPy7zF4jzawd3fw5FyJ8jvV1
	 5/UI6prBItspg==
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
Subject: [PATCH AUTOSEL 6.1 1/6] pm: cpupower: bench: Prevent NULL dereference on malloc failure
Date: Mon, 31 Mar 2025 10:36:27 -0400
Message-Id: <20250331143634.1686409-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.132
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


