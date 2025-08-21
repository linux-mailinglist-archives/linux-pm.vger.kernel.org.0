Return-Path: <linux-pm+bounces-32786-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7471B2F332
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 11:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D57C13B8AD9
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 09:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F060284B33;
	Thu, 21 Aug 2025 09:00:41 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CCF211290;
	Thu, 21 Aug 2025 09:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755766841; cv=none; b=kE5ViX9tI2+Y5hT5tqbmGI9FA/mGmps7BUBdlUrDo1un/iD1kRYlOc/mpsRH3dtN9zAnVGUDBZALmIL7IVxI8ur1b+btqwQ7+5SkJeS8NZMVhqE+tboxYG2UYSS6Ah7sAsNvFxL78Nzw0iwkW4jdQiDxgGhfOKnUhBgbkJEWcms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755766841; c=relaxed/simple;
	bh=QUY/UaZiiOx6V+FIyRDl9I9wD5NyPLsd3Ph1u1WzjCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LUl4p1J1v3CMa+N8hVuN/mAbr7NVoCfCYwF0es/KTnc6RBMwLDo7lVvXqNlOLcipCoUHuXA9k891Yrl//9G5QCFgnZtunzlyUBy1g7OgH/1GnKqpWmV1pZyCNskJ8INGkYDFK2ObbaTcsdqWunQ6v4qCjy/XSp+TGzm25CIvOTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 495bacc67e6d11f0b29709d653e92f7d-20250821
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:12310d2a-1f2e-421e-a5f7-012fc967c580,IP:0,U
	RL:0,TC:0,Content:40,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:40
X-CID-META: VersionHash:6493067,CLOUDID:1e4ae7e1df7ed10e5de58169619e1a48,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4|50,EDM:-3,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 495bacc67e6d11f0b29709d653e92f7d-20250821
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1840988436; Thu, 21 Aug 2025 17:00:29 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 6216AE008FA3;
	Thu, 21 Aug 2025 17:00:29 +0800 (CST)
X-ns-mid: postfix-68A6E02D-262011774
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 982FCE008FA2;
	Thu, 21 Aug 2025 17:00:28 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: "rafael J . wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: zhenglifeng <zhenglifeng1@huawei.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [PATCH v2 0/2] cpufreq: cleanups and minor fixes
Date: Thu, 21 Aug 2025 17:00:18 +0800
Message-Id: <20250821090020.167786-1-zhangzihuan@kylinos.cn>
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

Changes since v1:
	- Dropped the second patch from v1, which was not needed.
	- Kept the first patch as-is (already Acked).
	- Added a new second patch to simplify driver registration checks

Zihuan Zhang (2):
  cpufreq: use strlen() for governor name comparison
  cpufreq: simplify setpolicy/target check in driver verification

 drivers/cpufreq/cpufreq.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

--=20
2.25.1


