Return-Path: <linux-pm+bounces-32618-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F6CB2BF1F
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 12:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED77F4E15D3
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 10:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEA7322C69;
	Tue, 19 Aug 2025 10:40:05 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A4730F55F;
	Tue, 19 Aug 2025 10:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755600004; cv=none; b=dcj5MvZLNtqSi2hq1L119hqXlPhJ/2d60+QIbJ37AAiyrCDipQhcH2aeeg9EV+vW8eWZRczubZw7VAHf3gSjxj7L6H9rQxZJpOMb0pS1u62NfMEAUi7iY0VVL/YRQz9m9QsoBOXnL4/gcRlc+N4gxHetNiTaMeK8c88QRZNSnSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755600004; c=relaxed/simple;
	bh=vLRfYXDqfwibgedjqwsLTqZyq0oGfbA8AF4bY/frZuI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hVg1L1MwJkdA6RWC8HtaR7eyUltNqsAw2O6Oo2UuBktPV9cG1TqzMMkKjw/yxTx2xZv3JMmABja+WKtgp+reeZ8fMEstIooryHIImSlhA2XIjn8tAGOIYDlJ2Q6g2a41I+g5QwcZX2Gan04bhZanEXfX1V3Y/t54WoufLsB076A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d3346c667ce811f0b29709d653e92f7d-20250819
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:c402d57c-16c3-4066-b57c-3c3f6020acda,IP:0,U
	RL:0,TC:0,Content:27,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:27
X-CID-META: VersionHash:6493067,CLOUDID:f9bbdcea37709d91f6699389eba2f37e,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4|50,EDM:-3,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d3346c667ce811f0b29709d653e92f7d-20250819
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 589508210; Tue, 19 Aug 2025 18:39:46 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 4A74BE008FA3;
	Tue, 19 Aug 2025 18:39:45 +0800 (CST)
X-ns-mid: postfix-68A45471-16707119
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 5E388E008FA2;
	Tue, 19 Aug 2025 18:39:44 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: "rafael J . wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: zhenglifeng <zhenglifeng1@huawei.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [PATCH 0/2] cpufreq: minor cleanups around policy parsing and API
Date: Tue, 19 Aug 2025 18:39:38 +0800
Message-Id: <20250819103940.342774-1-zhangzihuan@kylinos.cn>
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

  2) Drop the redundant `new_pol` parameter from cpufreq_set_policy().
     Only drivers that implement ->setpolicy would ever care about
     policy values, and passing `new_pol` around is unnecessary.
     Callers now pass just the policy and (where applicable) the
     governor pointer; drivers can read policy->policy directly.

No functional regressions are expected for drivers which do not
implement ->setpolicy (e.g. acpi-cpufreq), as they ignore policy
values anyway.

Zihuan Zhang (2):
  cpufreq: use strlen() for governor name comparison
  cpufreq: simplify cpufreq_set_policy() interface

 drivers/cpufreq/cpufreq.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

--=20
2.25.1


