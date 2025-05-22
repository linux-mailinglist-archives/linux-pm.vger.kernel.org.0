Return-Path: <linux-pm+bounces-27477-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CB3AC0282
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 04:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1A841BA6E86
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 02:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C299313C8EA;
	Thu, 22 May 2025 02:35:31 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F381F92A;
	Thu, 22 May 2025 02:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747881331; cv=none; b=T5EDOk66ix6ZrOcMaNpE+aAA7MJPyYGtXncCWedYcJ32ei868gnraMo6VDP0NEMDuBAkknvVw52nZz3IGgsHwQORzShceTRdngzfkyjVW4FId4P1iapdx4UdA1WX/1QYrG4AwT7V+Mxrk7ZsPm/yQXwmclXA9a7hSD/7h5oNwgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747881331; c=relaxed/simple;
	bh=63M06YZciWrO32ny4WrHmNnrZASyO0GXqI7vUurNqOA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z5vafG4edOMuoMkGAV+n5V/qpugYC9rUOAB3nXXsoUbxYrYlN+l232nyeTFbrbpdShPwpB68BxdWBwYUIgeavqGBZIr0vGkhahCMTQtdZQlt/PcR6LEQpFxdMbjbg1P/TiX1S88lp81f1JdJ8TmVycXSOvBxE7JT5ehJV/g5Vyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 68700db436b511f0b29709d653e92f7d-20250522
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:221870d2-6de2-44d4-9a1b-ea24b782e830,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:570af180dfd3bde387f2acee1b101686,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 68700db436b511f0b29709d653e92f7d-20250522
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1693527093; Thu, 22 May 2025 10:35:21 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 98AD7E00351A;
	Thu, 22 May 2025 10:17:00 +0800 (CST)
X-ns-mid: postfix-682E891C-450249442
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 204E2E003519;
	Thu, 22 May 2025 10:16:58 +0800 (CST)
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
Subject: [PATCH v2 0/3] PM / Sleep: Introduce and use system sleep lock helpers
Date: Thu, 22 May 2025 10:16:46 +0800
Message-Id: <20250522021649.55228-1-zhangzihuan@kylinos.cn>
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

change log:
    V2:
    Fix PF_NOFREEZE leakage on try_lock_system_sleep() failure.

Zihuan Zhang (3):
  PM / Sleep: Replace mutex_[un]lock(&system_transition_mutex) with
    [un]lock_system_sleep()
  PM / Sleep:  Introduce try_lock_system_sleep()
  PM / Sleep: Replace mutex_trylock(&system_transition_mutex) with
    try_lock_system_sleep()

 include/linux/suspend.h  |  2 ++
 kernel/power/hibernate.c | 11 +++++++----
 kernel/power/main.c      | 14 ++++++++++++++
 kernel/power/suspend.c   |  7 +++++--
 kernel/power/user.c      |  6 ++++--
 kernel/reboot.c          |  5 +++--
 6 files changed, 35 insertions(+), 10 deletions(-)

--=20
2.25.1


