Return-Path: <linux-pm+bounces-21238-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8070A24F25
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 18:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81A693A511D
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 17:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48011FBC85;
	Sun,  2 Feb 2025 17:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fO+umJvE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9081D1FAC58
	for <linux-pm@vger.kernel.org>; Sun,  2 Feb 2025 17:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738516398; cv=none; b=p/2s9YwDwlTLS5DaHa5G1EIUKaqDO9whSJLjAXP0xo2qRzh6MaoS1o3Wr7QxoJfylXcP6gZwAdIl6LPdAATzuG5GCx6jf77s1eEpwGhwmd5VM5S+JOn2uZutHennoy5+d88bBziuuLBG6YaZOcDEtdEBT12bmba7K1KcZOuGqig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738516398; c=relaxed/simple;
	bh=WmfjOgS7hlMT/ZPiOYjYQeFGWmHwA8wgdwYjiEshNOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ddIgTDf3UAzfrTIK3TMtgWrXZZE2ZpL9O2HLu4avf5yByipdp4uoPQzmZeyErtNBt7lekqJd3PJ1ihBXh11cdSMVfXKZlCpaPX86q9AsllZALAuhl0HdztOnBcBHAp2e6ohBlNwWEIAyC0tve0Tk50SruKxBaoYgky1SGC2IeG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fO+umJvE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302FBC4CED1;
	Sun,  2 Feb 2025 17:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738516398;
	bh=WmfjOgS7hlMT/ZPiOYjYQeFGWmHwA8wgdwYjiEshNOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=fO+umJvECJiOBvoJy31pBZOavkauBMqwPOdMSatyi/ViDin19g/RBax6VutNUSYi2
	 ins+fuw515fH2ESvbMqs9tDHxDnSFWHHBDGQfjI1WgweerGuHbESiRZS5x2OJjRV6M
	 W118fNFPOjUW6sEhzVK/Jj1ib9t9hqPw27XJsDbWy2IVJgn+U0aIrAlym6GEUL/FUW
	 g+MsrTXkzwdML1BU8enTSFzKKDmhOFOYcQdYUdwBHX9Kma78j+gSXFGP/ahAzilmci
	 d48W6FiMeaF6Ihfo3q6ze4XozwShSFL43Jt3fSmwcCiTWgF9zekCLUm5YUpzo6KK1Y
	 UKPiKPhcFZj8A==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 15/25] tools/power turbostat: Return default value for unmapped PMT domains
Date: Sun,  2 Feb 2025 11:09:31 -0600
Message-ID: <34537ddd208d614dbefeb97823ae1c79e7771588.1738515889.git.len.brown@intel.com>
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

From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>

When requesting PMT counters with --add command, user may want to skip
specifying values for all the domains (that is, cpu, core, package etc).
For the domains that user did not provide information on how to read the
counter, return default value - zero.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 6b72b922e2f5..60b1ade8659b 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4615,7 +4615,8 @@ unsigned long pmt_gen_value_mask(unsigned int lsb, unsigned int msb)
 
 unsigned long pmt_read_counter(struct pmt_counter *ppmt, unsigned int domain_id)
 {
-	assert(domain_id < ppmt->num_domains);
+	if (domain_id >= ppmt->num_domains)
+		return 0;
 
 	const unsigned long *pmmio = ppmt->domains[domain_id].pcounter;
 	const unsigned long value = pmmio ? *pmmio : 0;
-- 
2.43.0


