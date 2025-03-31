Return-Path: <linux-pm+bounces-24652-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C43FBA76854
	for <lists+linux-pm@lfdr.de>; Mon, 31 Mar 2025 16:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6CD0166F9A
	for <lists+linux-pm@lfdr.de>; Mon, 31 Mar 2025 14:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC8B223337;
	Mon, 31 Mar 2025 14:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gr9y2khR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E2D21480A;
	Mon, 31 Mar 2025 14:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431731; cv=none; b=ezdCtixqofBYVSPjIpv4TcSzFlr8SH7TATz4iWGafXIQmsivS0cQ+0j05TBkmkViZfF9/+7741mlvODlDaiEg6huEOkfSNhpAusKpX/JCphK6PDpi/kRiitNaCTUJcmQF6W6hOJ73o78UyAhYoaqSV3AfKkz+bAHc+zokti4wPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431731; c=relaxed/simple;
	bh=doh+7ARyEYWjZJvgKfbqcxfkqsBHv0qsRf5JId0INjw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ohAWoU9UZUVJkTEC72UkTYwA4IgME4Q5HLyQy+iKKUUSG98BrEgspyPiCElMRvXMPTtceN2N1jsGnRTcXGCQEY57V0Gp+0AYi2wWKquoH9cqs4LhdpbqTNfubR+GvnGkjDLzHAE8bc/7MEhNGS3VNpzqZ/r6+zsBDahEwmHuAjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gr9y2khR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 010CFC4CEE3;
	Mon, 31 Mar 2025 14:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743431731;
	bh=doh+7ARyEYWjZJvgKfbqcxfkqsBHv0qsRf5JId0INjw=;
	h=From:To:Cc:Subject:Date:From;
	b=gr9y2khRuByenPf5GGMdxv7uJNhzbVUilWJCVVpspdtZzXxdCSxYBwgMZzQAG2SML
	 oBCYbfwKL8E4+opaoVL6IbUv6S/9iL/8JgjuHq1Y4Gbfs33PwrmK5OwL41caz0wo8H
	 1G9nWTrdTbBRtiRhwNB6HKURLZF/s82ps52bvYwBBhXGtXNRxvpeI/6oyWzvJ6LPcs
	 fWHPLuDs4qOhE/iDOWzucMryL1xPF0KwmMGIR1nGXZBQCGw02xmc4HZpqM4WJtHTxq
	 OltBoQ7mffskN9+c46vE4XG/FAcYIqADfX9kcZ0Xxl0N8SmCf9WEULA/vK7Sq5fAEZ
	 sgxaEA/66q86g==
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
Subject: [PATCH AUTOSEL 6.12 01/13] pm: cpupower: bench: Prevent NULL dereference on malloc failure
Date: Mon, 31 Mar 2025 10:35:15 -0400
Message-Id: <20250331143528.1685794-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
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


