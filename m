Return-Path: <linux-pm+bounces-33554-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EFFB3E174
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 13:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E94B13BA48B
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 11:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B702E314B7A;
	Mon,  1 Sep 2025 11:26:04 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E83D1F3BBB;
	Mon,  1 Sep 2025 11:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756725964; cv=none; b=S6ygR32XUrGlkLqDYRETwISIJU7vLl6EZcQFRpR/TElXPgLM64db3pjJbMQYjwizSqUw9sgCZjsgNPsga3XUthC/enxrNzSEjgV1KNy4pGQNiEe2ZsUYWoNKH0JkNcvuXYeoZyD+m1CvC9PM/u0GryxdAiZbbNDDwMi4SUzoGIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756725964; c=relaxed/simple;
	bh=EPolO3DT4+VFpRvraRubn8ZTgBhrMgGZ0MjTW5il0Y4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lhA7+vNQzsbSdREVqL7Nj6aXQSnlSN2umXUOf7vHIzWaSDpS0JfvdZtc1i4gpF9FOHzfuSyzi8zWf1XxnqqstZr8vlOtlCeThHB0a8c7zv/3a0VbiJRfIcs3zA7bQ7hObYpQBr/9iC8LKXkD434mHXzs5mQGxe40FqJiCJGvyos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6ce5c020872611f0b29709d653e92f7d-20250901
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:ccbefb36-1908-4efa-8038-8dcbf0c576a2,IP:0,U
	RL:0,TC:0,Content:44,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:44
X-CID-META: VersionHash:6493067,CLOUDID:8e941fce5a6d8950d68825d0171b6643,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850,TC:nil,Content:4|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6ce5c020872611f0b29709d653e92f7d-20250901
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 387754835; Mon, 01 Sep 2025 19:25:55 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id CF8AAE008FA5;
	Mon,  1 Sep 2025 19:25:54 +0800 (CST)
X-ns-mid: postfix-68B582C2-6736662
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 2762EE008FA4;
	Mon,  1 Sep 2025 19:25:53 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: "Rafael J . wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: zhenglifeng <zhenglifeng1@huawei.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [PATCH v1 0/3] cpufreq: drop redundant freq_table argument in helpers
Date: Mon,  1 Sep 2025 19:25:48 +0800
Message-Id: <20250901112551.35534-1-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patchset updates the cpufreq core and drivers to fully adopt
the new policy->freq_table approach introduced in commit
e0b3165ba521 ("cpufreq: add 'freq_table' in struct cpufreq_policy").

Motivation:
- The frequency table is per-policy, not per-CPU, so redundant
  freq_table arguments in core helpers and drivers are no longer needed.
- Removing the extra argument reduces confusion and potential mistakes.

Patch details:

1. cpufreq: core: drop redundant freq_table argument in helpers
   - Remove freq_table parameters in core helper functions.
   - All helper functions now use policy directly.

2. cpufreq: drivers: remove redundant freq_table argument
   - Update cpufreq drivers to match the new core API.
   - Calls that previously passed a separate freq_table argument
   - No behavior changes, only API consistency.

Zihuan Zhang (3):
  cpufreq: Drop redundant freq_table parameter
  cpufreq: sh: drop redundant freq_table argument
  cpufreq: virtual: drop redundant freq_table argument

 drivers/cpufreq/cpufreq.c         |  2 +-
 drivers/cpufreq/freq_table.c      | 14 ++++++--------
 drivers/cpufreq/sh-cpufreq.c      |  2 +-
 drivers/cpufreq/virtual-cpufreq.c |  2 +-
 include/linux/cpufreq.h           |  7 +++----
 5 files changed, 12 insertions(+), 15 deletions(-)

--=20
2.25.1


