Return-Path: <linux-pm+bounces-40031-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBE2CE915F
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 09:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5B4A3025157
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 08:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8338C324B19;
	Tue, 30 Dec 2025 08:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="UOJKUXP1"
X-Original-To: linux-pm@vger.kernel.org
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EE43246EC;
	Tue, 30 Dec 2025 08:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767083755; cv=none; b=ke5s9IiV3liSXDzJeR2YxomrzqfhbVIDiJ7RRfihfyTKAGIe6iQGUsaedxIzjqiy5Y/Hcs3iFjAyNdAfEM9zMknCnj2OX8GtozgkjNlqI2wkgPkOGZF/ju4XiQhRKCdafvf2mo/KummcOwWh54EAIJjs+u2Jxu8WwDFrVEpbd5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767083755; c=relaxed/simple;
	bh=pgYQTbbzTQHceI2w6PURtP4b9zBJAxRmuPk6bhXSV3A=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=R8XyUzh7SBl+4/EupenMFpSXo9z9dWtl0/X80KN3txET85tRM48ssjQNYRlsU4zhOJSAT3v7VmTpZvgP3YyXFy/v17KwJJzRPaGfVVfvr3K2OvujqpakwQ7piyCY/P6js1iUFYa/QDPGpPvUMwcoNIe8ZkakLKWc9PoDX5peEaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=UOJKUXP1; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1767083741; bh=4t9UiJ/TAyEd2QPMPRzUsrDKNkvd6izh2offNQBvV2s=;
	h=From:To:Cc:Subject:Date;
	b=UOJKUXP136qzB/DHbbh2YZy9fAww1Ss+nVzhwqFedqKcTFvAe8/mAYIyNnd7rwrpZ
	 QUIJtqNs0wTSKuGG9mrOPRLm4hLaTxh5ZDkrUJLPwnFk9nLZE33+sxCUqjR/UxnGou
	 3O7nuqJrQCMEMNF1Z1C4qPebAqM0X260eATK8dOk=
Received: from huangjiping-System-Product-Name.msnode ([116.237.165.226])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 4F99E8F8; Tue, 30 Dec 2025 16:19:57 +0800
X-QQ-mid: xmsmtpt1767082797tpn4x8vc8
Message-ID: <tencent_FFD1C08721AB1823AB10E04FFFD29F357C06@qq.com>
X-QQ-XMAILINFO: MIbv1O9N9h62AuYXbW593opYEG6Kk7Ygg3s51J1czdYK8oEorm7Y0CWlCqC9+Y
	 I4ckB/lApTbE8EAEezhQo6d4z1J3T7NQ9ZeSsAoTsb8B4gQkgdNO/Ex90FwfPVIRCnELwpxr+4T3
	 xe6pSKd8eBgp/rMiyncatPh2/C+r7tb23CVP7/3La25gzRABflYyPVZD9VtS27L4UriYwjnpJBYS
	 Wd9NUOrkjqpkuUMbdZRReY91FcReXS2l5UWxOiis5Y507LvSgsuLvQrYUvfe7Uaw7J4xysXKO3ra
	 8JFr7wKBznkc3QK6ktN6wurJ2muoYPvFyMFyh/OyjkmKZAOiaZc6tnHuPSJpcNIZdzBBxNqga3VG
	 0jGnsvwrRUNp4WdDbu1/vxz03WwZLwQWjPaB7IFTkJTEKXChJkiljZRKFKnAvlfAxrBoP6zc53v5
	 LYDmswfaNrpZRZr9ESG7z3g4sRQMysJEcHmz5nEof5G/99Px0no7Avf4zDoJ8upRb/+Nw1FqMXO/
	 R4UeKIn5+vmgpJiLDrzlBvH25qXFKet2QBSJAJxT/hez4g/Te2du3FYnUAj3c4PeJppRz9LpTpq/
	 3irGEzqVsh6p6ijgkaXnorMq7JXueI+fgzwaSQn/yCaIUeF+qqhjYbRzD2W9XC9WOHwy5hr5wjDv
	 Rn27IgMSkhSKFVRIw/4AY2RTs+yCy+GgsfctdbaZqlC2prVYJkd6coxPu0tpPJJZ+8vzlVxqU2LZ
	 CokngX1LgjW52Bx1dFzaVqG2+fY4HlagVtsbFAiYGAm/TKa+yF6C+gV95aOJE109bKuvhXf5S7/i
	 woy2iWHbDy9TIr0k1l+gN0lugGOi+bKdw8pkZxumNZF1e9NE+iSLTkZnGO8DE+gkDYxHQELvrN1A
	 Wk3uWYxE8FarovxJnV6g/+2vxeEvlidEEeQ7Gb1Feh4jyA5PNTgB9fcbY+RRWdSRhLTc3PZQPd00
	 JjODrjjxWqT0aT0cIwCuT0z5X3hw6DJLV40BdGA1haTDUtdH71imuHTU8Ok3DL4KkP0xIPqW990z
	 Vh04GOaVa+Mswq8aBiVRSKXg31rfk=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: jiping huang <huangjiping95@qq.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jiping huang <huangjiping95@qq.com>,
	jiping huang <jipinghuang686@gmail.com>
Subject: [PATCH] thermal: add the setting logic for cdev state while trip->threshold modified dynamically.
Date: Tue, 30 Dec 2025 03:19:43 -0500
X-OQ-MSGID: <20251230081943.3077264-1-huangjiping95@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

  In the current gov algorithm, only when temperature > trip_threshold
and the temperature rising, in both cases where temperature <
trip_threshold and temperature dropping, cdev ->states will be updated.
  In theory, if the trip_threshold is modified runtime and there are
still situations where the temperature remains unchanged or decreases
when the throttle is true, and where the temperature rises or remains
unchanged when the throttle is false, then the cdev ->state should be
updated by comparing temperature with the trip threshold again.

Signed-off-by: jiping huang <jipinghuang686@gmail.com>
---
 drivers/thermal/gov_step_wise.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/gov_step_wise.c b/drivers/thermal/gov_step_wise.c
index 65974fe8be0d..d1fe7e28297f 100644
--- a/drivers/thermal/gov_step_wise.c
+++ b/drivers/thermal/gov_step_wise.c
@@ -49,9 +49,9 @@ static unsigned long get_target_state(struct thermal_instance *instance,
 	}
 
 	if (throttle) {
-		if (trend == THERMAL_TREND_RAISING)
+		if (trend == THERMAL_TREND_RAISING || cur_state <= instance->lower)
 			return clamp(cur_state + 1, instance->lower, instance->upper);
-	} else if (trend == THERMAL_TREND_DROPPING) {
+	} else {
 		if (cur_state <= instance->lower)
 			return THERMAL_NO_TARGET;
 
-- 
2.34.1


