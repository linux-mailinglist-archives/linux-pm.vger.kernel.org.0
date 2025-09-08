Return-Path: <linux-pm+bounces-34137-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB28AB487AA
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 10:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4406717B111
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 08:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0042ECD13;
	Mon,  8 Sep 2025 08:57:53 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE68914AD2D;
	Mon,  8 Sep 2025 08:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757321873; cv=none; b=sx/RPYtsl/mS37OlbfQmyROQ2HWDjMm3dyhioUmXGcMUs2PRrbpmrEhh/5fb9C9GJU+1iiQV52bSmYLel2aRR9eRPzIY1MRsEwvF7DO3csq/nsZuztvamIbiSU3UvGiUUt9XzK/mNkYnH5r1ilak/XA1q9PVzfUw0LRcy47W+NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757321873; c=relaxed/simple;
	bh=tORqqtQGMQE+nPWwjJ1DNrtvijIxuC58V28a+mkd01A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BEMUIZ7DHYxKDjpKH/QLddWw8H1a4KbWFvRfiSZYw129Brf6GvUS8iQGOEQmRKkP5LWHoFhEvoSNWLPQH6UeDHKeSDmO+q+a8/C/L/G/L95tE1zVRYYZmEWEeEIXqlkDDznlViaDOrXJE0Yo8cboFv390XDC+mVi4ySc0wlYVAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e0da60428c9111f0b29709d653e92f7d-20250908
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:3f6622ce-d622-45db-ae7c-b0bfb1542f52,IP:0,U
	RL:0,TC:0,Content:29,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:29
X-CID-META: VersionHash:6493067,CLOUDID:6b10639a48e4e42831fe6cfdab41c73c,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850,TC:nil,Content:4|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e0da60428c9111f0b29709d653e92f7d-20250908
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 260334981; Mon, 08 Sep 2025 16:57:41 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id B4ED9E008FA7;
	Mon,  8 Sep 2025 16:57:41 +0800 (CST)
X-ns-mid: postfix-68BE9A85-48786850
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id F198DE008FA3;
	Mon,  8 Sep 2025 16:57:40 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: "Rafael J . wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: zhenglifeng <zhenglifeng1@huawei.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [PATCH v1] cpufreq: Add defensive checks during driver registration
Date: Mon,  8 Sep 2025 16:57:38 +0800
Message-Id: <20250908085738.31602-1-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently, cpufreq allows drivers to implement both has_target() and
has_target_index(), which can lead to ambiguous or incorrect behavior.

This patch adds defensive checks in the driver registration path to
prevent invalid implementations. For example, a driver is no longer
allowed to implement both has_target() and has_target_index() at the
same time. These checks help catch driver mistakes early and improve
overall robustness, without affecting existing valid drivers.

Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
---
 drivers/cpufreq/cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index a615c98d80ca..cead6d4fa1ad 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2922,6 +2922,7 @@ int cpufreq_register_driver(struct cpufreq_driver *=
driver_data)
 		return -EPROBE_DEFER;
=20
 	if (!driver_data || !driver_data->verify || !driver_data->init ||
+	     (driver_data->target_index && driver_data->target) ||
 	     (!!driver_data->setpolicy =3D=3D (driver_data->target_index || dri=
ver_data->target)) ||
 	     (!driver_data->get_intermediate !=3D !driver_data->target_intermed=
iate) ||
 	     (!driver_data->online !=3D !driver_data->offline) ||
--=20
2.25.1


