Return-Path: <linux-pm+bounces-27386-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B71AABCDD2
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 05:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 462584A3DC4
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 03:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3CF257455;
	Tue, 20 May 2025 03:26:09 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E9313C3CD;
	Tue, 20 May 2025 03:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747711569; cv=none; b=ceQPupb9k6jYO2w73I6uB+33utqyae08rfXQiVUN2dDOOp/axXSosIJL42yZ5iQ6Glg4utRl9DMUVGYVaNC4JLUyIQ0sqhCZaagtgnAirG+uaLfWg5fB+sbu3xqSRjozcAGVcjOu1/hEnmXmEWkt3HUehK2MO3XTPpwNv3N5alI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747711569; c=relaxed/simple;
	bh=Ce1stjmKd1SeeDt5rAy+aPPT0UwVSQP0hncyimk6dFw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N6Njwq3JQyhFe7e+dahVkmIsAuhA17xHafh/6Wdcfk8EV0gC8Zj6SqDADFQ/ISba5nFWQI9Fgr9lMcRdGaGNJUbeandEWriunLo4Y3kTiPBkrmPNlWFZYj+xo5aND4t2Pg/dBQ7ucafMC2DjgmKBt51ihday/kzGrxQbrwSRW3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2256a87e352a11f0b29709d653e92f7d-20250520
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:5cf46822-bcc4-4ae1-a95a-bc11dd089c0c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:3d2dc94f2c8adf2d4324e835b2217efb,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2256a87e352a11f0b29709d653e92f7d-20250520
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 106061420; Tue, 20 May 2025 11:25:52 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id B4B38E003505;
	Tue, 20 May 2025 11:25:52 +0800 (CST)
X-ns-mid: postfix-682BF640-597826294
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 22024E006100;
	Tue, 20 May 2025 11:25:48 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: rafael@kernel.org,
	len.brown@intel.com,
	pavel@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	tzungbi@kernel.org,
	a.fatoum@pengutronix.de,
	jani.nikula@intel.com,
	joel.granados@kernel.org,
	paulmck@kernel.org,
	zhangguopeng@kylinos.cn,
	linux@weissschuh.net,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [PATCH 0/3] PM / Sleep: Introduce and use system sleep lock helpers 
Date: Tue, 20 May 2025 11:25:42 +0800
Message-Id: <20250520032545.29558-1-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch series introduces wrapper functions for locking
system_transition_mutex used in system sleep (suspend/hibernate) code,
and refactors the existing usage in kernel/power to improve maintainabili=
ty,
readability, and future extensibility.

Currently, mutex_lock/unlock(&system_transition_mutex) is used directly
in multiple places in the suspend and hibernation paths. This results in
boilerplate repetition and makes it harder to change the locking mechanis=
m
later if needed (e.g., for debugging, tracing, or replacing the mutex
with another primitive).

Summary:

- Patch 1 replaces mutex_lock with lock_system_sleep.

- Patch 2 adds a non-blocking `try_lock_system_sleep()` for code paths th=
at
  should proceed only if the lock is immediately available.

- Patch 3 replaces remaining uses of `system_transition_mutex` in
  `kernel/power/` with the new helper functions.

This change brings all system sleep transition locking behind well-named
abstractions, preparing the code for future evolution while simplifying
reasoning and avoiding repeated direct mutex usage.

 include/linux/suspend.h  |  2 ++
 kernel/power/hibernate.c | 11 +++++++----
 kernel/power/main.c      | 12 ++++++++++++
 kernel/power/suspend.c   |  7 +++++--
 kernel/power/user.c      |  6 ++++--
 kernel/reboot.c          |  5 +++--
 6 files changed, 33 insertions(+), 10 deletions(-)

--=20
2.25.1


