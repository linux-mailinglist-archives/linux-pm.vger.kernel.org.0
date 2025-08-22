Return-Path: <linux-pm+bounces-32889-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD7EB30FDD
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 09:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 759C7188F626
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 07:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADEB2E2F18;
	Fri, 22 Aug 2025 07:04:40 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382CA2253F9;
	Fri, 22 Aug 2025 07:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755846279; cv=none; b=ldr88lgjiyNgyauwI6Sa6g5q6r6BuKn2tu2cf0lctHqfCl69Z4SRxqS4TyKKTad//4C3PZR5rhYy0Ttfxglc63WofoQ02YUFWmmS8RpbRrKmbDc0brlRFK0cj5bEAxw+VrNStKzp6rCBx7S+XVDQEceNGKz6sFnf5IcxBhWbWT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755846279; c=relaxed/simple;
	bh=F9AEUqmn/NekpYItgVpHC4OprnZUh+JhGF6cYJ4hrWg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fIs9GYG1pHki0E/72V27ufR0OIHa4xHEfH4V7LxCP3jiafyaMR0RSx2jc8mo6ZH17G4QKEo1J5+X7uCrHt3MPnpxWg9JgS4LHZ7ezYggijYW8eCZTqY19E6QSKLfObwY4tDoGsf1cOtvV9APBkp5ZS+LCJiTR5t2SIw7RNyGX5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3eb916507f2611f0b29709d653e92f7d-20250822
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:9910f657-f544-4765-a940-77a8abdc5dd4,IP:0,U
	RL:0,TC:0,Content:36,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:36
X-CID-META: VersionHash:6493067,CLOUDID:cecc2b5f2ffdb34e62039edd32a44217,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850,TC:nil,Content:4|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 3eb916507f2611f0b29709d653e92f7d-20250822
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1972000434; Fri, 22 Aug 2025 15:04:28 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 71AA9E008FA3;
	Fri, 22 Aug 2025 15:04:28 +0800 (CST)
X-ns-mid: postfix-68A8167B-754843306
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 3F954E008FA2;
	Fri, 22 Aug 2025 15:04:27 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: "rafael J . wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: zhenglifeng <zhenglifeng1@huawei.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [PATCH v3 0/2] cpufreq: Cleanups and minor fixes
Date: Fri, 22 Aug 2025 15:04:22 +0800
Message-Id: <20250822070424.166795-1-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series contains two small cpufreq cleanups:

  1) Use strlen() as the length argument for strncasecmp() in
     cpufreq_parse_policy(). This makes comparison more permissive
     (prefix match), which is consistent with the intention in our
     deployment and improves readability over using CPUFREQ_NAME_LEN.

  2) The second patch is new in this version. It simplifies the validatio=
n
     logic in cpufreq_register_driver().This makes the registration code=20
     more straightforward without changing functionality.

Changes since v2:
    - Fix code suggested by Viresh Kumar

Changes since v1:
	- Dropped the second patch from v1, which was not needed.
	- Kept the first patch as-is (already Acked).
	- Added a new second patch to simplify driver registration checks

Zihuan Zhang (2):
  cpufreq: use strlen() for governor name comparison
  cpufreq: simplify setpolicy/target check in driver verification

 drivers/cpufreq/cpufreq.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--=20
2.25.1


