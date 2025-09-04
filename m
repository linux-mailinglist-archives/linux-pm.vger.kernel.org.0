Return-Path: <linux-pm+bounces-33778-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9EBB4306A
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 05:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCFAE1BC74FD
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 03:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DA926B2D3;
	Thu,  4 Sep 2025 03:22:28 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDBA23875D;
	Thu,  4 Sep 2025 03:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756956148; cv=none; b=kT30r0kFMgYu8zF1Vjyf7lcD7aNh0rxKSjMz2GfJWqaQhPIBwT0pGdtle6DOq1jHsiz6BoFqJ2T3Kdh2BgacFlznMMXhXVMcRILHB+ZKQXRwGVwb9b3cIu0G2eQCoSpK8pAt2q4gUDhGfP7JjVv1CHe0SjwBAYn5eYcjRFY2mp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756956148; c=relaxed/simple;
	bh=iDKUp7MUy7dgr0C2FyAFxllVOl2HoJ5YjabrF0Yj4bI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=gfyPAyw0jWDTN/LFqF+hUee23uBpxl1RUM5+7K1+5MKYp9+wZnuPRBspaRMD0ISPed4K2i1SGaAW9COsl4vchIMJMJzpzQ5I4zSeu7/nTVJ8/rjSsmdPcl7IgUN+vpLhLZFfN35tuvGkw9jB1L+wlRR69t/R93qhk0YE8jv8MJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5c4e48d0893e11f0b29709d653e92f7d-20250904
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:cf8d650f-e84a-4973-8b9b-40525fe9c724,IP:0,U
	RL:0,TC:0,Content:34,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:34
X-CID-META: VersionHash:6493067,CLOUDID:b94927d9bb52012ab223db94077570a5,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850,TC:nil,Content:4|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5c4e48d0893e11f0b29709d653e92f7d-20250904
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 674417792; Thu, 04 Sep 2025 11:22:17 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 80C82E008FA3;
	Thu,  4 Sep 2025 11:22:17 +0800 (CST)
X-ns-mid: postfix-68B905E9-155737605
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 53ED8E008FA2;
	Thu,  4 Sep 2025 11:22:16 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: "Rafael J . wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Saravana Kannan <saravanak@google.com>
Cc: zhenglifeng <zhenglifeng1@huawei.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [PATCH v1 0/3] cpufreq: Clean up frequency table handling
Date: Thu,  4 Sep 2025 11:22:07 +0800
Message-Id: <20250904032210.92978-1-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

This series contains a set of cleanups around cpufreq frequency table
handling.

The first patch drops the redundant @freq_table parameter from
cpufreq_frequency_table_verify(). This has already been Acked, but is
included here to avoid build issues with the following changes.

The second patch makes sure that policy limits are always enforced
even when a driver does not provide a frequency table. This removes
the implicit dependency on the table and makes the enforcement logic
consistent across drivers.

The third patch makes cpufreq_frequency_table_verify() internal,
since no external user should call it directly after the parameter
removal and the refactoring.

Together these patches simplify the API surface, reduce redundancy,
and make policy enforcement more robust.

Zihuan Zhang (3):
  cpufreq: Drop redundant freq_table parameter
  cpufreq: Always enforce policy limits even without frequency table
  cpufreq: Make cpufreq_frequency_table_verify() internal

 drivers/cpufreq/cpufreq.c         |  2 +-
 drivers/cpufreq/freq_table.c      | 18 +++++++-----------
 drivers/cpufreq/sh-cpufreq.c      |  8 ++------
 drivers/cpufreq/virtual-cpufreq.c |  5 +----
 include/linux/cpufreq.h           |  5 +----
 5 files changed, 12 insertions(+), 26 deletions(-)

--=20
2.25.1


