Return-Path: <linux-pm+bounces-27854-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88258AC8BC8
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 12:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 673807AAD8E
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 10:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C492222CC;
	Fri, 30 May 2025 10:01:01 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BE822B588;
	Fri, 30 May 2025 10:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748599261; cv=none; b=rorwaSBCchoTqjE/J/MCKUR39bwjmPEBIF2emWQ690Hgr3x5XquKTMcZTCAaJXOB+9JQxxxk2iOkgtEANmm3P9ElDzaTlE0XqUUtWz54JRwIlBptjbNVEVkxb5s6VcnavQq70apbs2Ip268OR/8bwUaKfvypUo9jBqiwcwRsB3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748599261; c=relaxed/simple;
	bh=HxTekDcfHvPbg4zlci3wAFstgpbm6hnuF6zxpsDkBpM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FelChk1OqZC4K3hUCTc2oQwbaU72l4l0pIy4SoUezQTA0z6L951OmWWQx/O03x6lGCc3t/KjIvKn+/spFNqE1/Zy2N0f76M+YFlqsbbvOIOvWLmmt4QyJNhnnjKiLE5WkUtjg6ZzsNdexhxaDZERLUaTpzq+VZ2/PAv/uhSOG4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f79117da3d3c11f0b29709d653e92f7d-20250530
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:f0869a2c-80ac-4a14-855b-fae5cca669e5,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:6493067,CLOUDID:5d5f85b7ecbd36a1ef69e3a930dfcd62,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:5,IP:nil,URL
	:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SP
	R:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f79117da3d3c11f0b29709d653e92f7d-20250530
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 602863747; Fri, 30 May 2025 18:00:50 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id B6D36E003506;
	Fri, 30 May 2025 18:00:50 +0800 (CST)
X-ns-mid: postfix-683981D2-3374552
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id AD36FE003505;
	Fri, 30 May 2025 18:00:49 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: rafael@kernel.org,
	pavel@kernel.org,
	len.brown@intel.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [PATCH v1] PM: hibernate: Avoid redundant resume_device assignment in resume_store()
Date: Fri, 30 May 2025 18:00:36 +0800
Message-Id: <20250530100036.11954-1-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In resume_store(), if the device number written to /sys/power/resume
is the same as the current swsusp_resume_device, we can skip reassignment=
.
This avoids unnecessary locking and improves efficiency slightly.

Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
---
 kernel/power/hibernate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 519fb09de5e0..504a1c2465ce 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -1291,6 +1291,9 @@ static ssize_t resume_store(struct kobject *kobj, s=
truct kobj_attribute *attr,
 	if (error)
 		return error;
=20
+	if (dev =3D=3D swsusp_resume_device)
+		return n;
+
 	sleep_flags =3D lock_system_sleep();
 	swsusp_resume_device =3D dev;
 	unlock_system_sleep(sleep_flags);
--=20
2.25.1


