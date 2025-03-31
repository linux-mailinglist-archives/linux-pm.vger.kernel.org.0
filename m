Return-Path: <linux-pm+bounces-24654-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60286A7686B
	for <lists+linux-pm@lfdr.de>; Mon, 31 Mar 2025 16:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA04C16ABEC
	for <lists+linux-pm@lfdr.de>; Mon, 31 Mar 2025 14:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240FC215160;
	Mon, 31 Mar 2025 14:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljMkU0ZT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92D0214A9E;
	Mon, 31 Mar 2025 14:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431768; cv=none; b=Yq8RbSYCaDHtY9S7OZMlzBVp5jy0naY4shcgkKHmitcFYPpWfrOcmgnJHkKRiKdRDFREj5HLZxE8kEbTDygpUgMrqjHPVmqCzIqNymj8lsBBzS121aun+3OMlZYg/we8j+tui5l0Hc3SDXISciW6Wz4koB2fNbM/5RqkZaB+WS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431768; c=relaxed/simple;
	bh=doh+7ARyEYWjZJvgKfbqcxfkqsBHv0qsRf5JId0INjw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TACTikY1nEpsbkIWDj9i051jVlAOKeu4cWQq9gKWjp2R6REeCacwZgPiG/WK8KtmfTtfaffQ9sP8f7DqjQvklRnUQ7nfKyHr9cFbNMDrFN0mWAKKbxWPBqoYSxe353BfvKNh7M09QfCGADnyAY/Ud06Wq5CSIYfq864+KoEEmek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljMkU0ZT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 861D4C4CEE3;
	Mon, 31 Mar 2025 14:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743431767;
	bh=doh+7ARyEYWjZJvgKfbqcxfkqsBHv0qsRf5JId0INjw=;
	h=From:To:Cc:Subject:Date:From;
	b=ljMkU0ZTSkVpdqNEDtcXMslKTI5/mn64mOWQLFNme+IyyhyNk4HbtCyZJpKbljwBT
	 2F5PiFOKNNHrs8hCeQ3oTg1ZaSrxTjVpcdeeTtVYJ9qynNalmS1OaHQzGWL0Vj2uSt
	 yZfYuB/LAcGtjD7IlFuiro+nqxuAQZ23k8ufRBp6tBmHGl6yS6f++e8Zne7MSmQtx1
	 GBp08hT2s28GBtq0xbNRG14i4cUBtaOExW1FI4MRtPufc/RQBDW5sro6k6ySv1WHOK
	 yYLRYN7ddHiK202Jk9iZPEnaEavB8xHtD7/q1z427Qeoxcnade8wH2Y8A8sWSmGeQ3
	 /M9QzhK3WrKfw==
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
Subject: [PATCH AUTOSEL 6.6 1/9] pm: cpupower: bench: Prevent NULL dereference on malloc failure
Date: Mon, 31 Mar 2025 10:35:54 -0400
Message-Id: <20250331143605.1686243-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.85
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


