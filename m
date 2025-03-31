Return-Path: <linux-pm+bounces-24657-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 061FEA76898
	for <lists+linux-pm@lfdr.de>; Mon, 31 Mar 2025 16:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11F8016AFB5
	for <lists+linux-pm@lfdr.de>; Mon, 31 Mar 2025 14:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D5C22AE7F;
	Mon, 31 Mar 2025 14:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+uSrkNt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ADA21B8F5;
	Mon, 31 Mar 2025 14:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431833; cv=none; b=IxoCyfBiHsCwqMnqwSrItIv/HoHWoikkvdSxeKQaJtAomRVeSAuHxmWASTvuT4fcvIk8Mpvj0GRMCBt2HR63NsB74Dy6wCHuyStucOo2wLrmNgL5tAVECVc1utr6iltp6pCcqdFqjhxX+4BUfHUVRZXDMKsU4lJBO74+bYe9aTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431833; c=relaxed/simple;
	bh=doh+7ARyEYWjZJvgKfbqcxfkqsBHv0qsRf5JId0INjw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fvvqITBfTqA650/HOgGi9v3z70md27VlZYhcxX/Lkk0mcePhGsdWngfkVwBxTrzQA2Kc2LNPfw20lQeoOt9vU/alx/8GuEh/J4sCyD8djKId8qZP0puN9ZG2gSc5BgAvauJNuj4QuSTFd4JPgnc/odSH/qDLQ6359aCWb3pIqFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+uSrkNt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5AB2C4CEE3;
	Mon, 31 Mar 2025 14:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743431833;
	bh=doh+7ARyEYWjZJvgKfbqcxfkqsBHv0qsRf5JId0INjw=;
	h=From:To:Cc:Subject:Date:From;
	b=s+uSrkNtiMOmBdzyCQmROJ4dTRkTYBB65PggTst+CZOQ1Ap5EsNIwU31AQcGyKIn+
	 GExquxiVL72QnsVdhwPUPW6KbkMbhzcZQREO93DicM4XMx8Ok4bW7zqF/omFRmhUTv
	 ZL40NgYaqix/okhWxUUskQ9V3PvapMyj7YiFx/x1KrAt6knoED89AoqMSEOGJPbKmA
	 ZV4Ju2TXUa9xEan87JKVs44Frqu/eXdBplJ8sHo69zohd1SBj/4vg6Yruzf3qkGGcT
	 VqNwpRA9yelU2GCMvw5ERg5s0wX+dXx+32I5ts3rhO+KUapbVnS9fiZJURHhxtyouS
	 gpXwRKqyP3h0w==
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
Subject: [PATCH AUTOSEL 5.10 1/6] pm: cpupower: bench: Prevent NULL dereference on malloc failure
Date: Mon, 31 Mar 2025 10:37:03 -0400
Message-Id: <20250331143710.1686600-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.235
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


