Return-Path: <linux-pm+bounces-13977-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1411974673
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 01:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 556B51F26809
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 23:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587A51AC42D;
	Tue, 10 Sep 2024 23:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KAC1Exzg"
X-Original-To: linux-pm@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE0F1A76C7;
	Tue, 10 Sep 2024 23:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726011632; cv=none; b=DdCYwsYOKJXqnG3VXpoBdTQE/4DsS/alEqmpFvN7eZN94uAuFTGqLmN9ICE1+J801g1kSpZyhzc1oLVxe1vicaeKrXvIJbLfUgKvJGAiCe0qoRoS+zVrCnkflcIuW+9RA2lg61SpdytQeAfuGnkqkEigQ0d9zywE2LeRhIckxcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726011632; c=relaxed/simple;
	bh=otCCHPGh5Xa+SKJyOFHoUooZ/wgc+zG4eZqBGQFiz+c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DCcbVxtW4UzEJanxqATtaOhlC3mpFqMStUU79sQ2UO1eHdORSF8r5QnpbgrVKAzp2I62uz17QTpbzRUsXDESpYc1PKul2hN4N0yacJHBF0SMWaCb/QLNO4NOSoXPr819h0PNqVOWtBAgd7AbJFinOI8wF5y+OqbdRwIvJE0YGFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KAC1Exzg; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=GuteD
	rwp8EN3+m3sswrUea0nvaTPrbgw1zr2R2cVouk=; b=KAC1Exzgt5nWYuQHf8KeP
	LhgvIS4KHiEjZGzcBdz19vxoDev7LWnoHHguxGk06oI/+44XANhpp7tQUwjOboDe
	ZB+DHQd6Sp4aCBj5XFVDhyxTiMlKICTp3/wxLPZJB/nnJVOX62FUZ4wj/cSb39SY
	7urIp++fAwuAUui/fpcHiM=
Received: from iZbp1asjb3cy8ks0srf007Z.. (unknown [120.26.85.94])
	by gzga-smtp-mta-g0-0 (Coremail) with SMTP id _____wDHz9bL2OBmjxlgGg--.35070S2;
	Wed, 11 Sep 2024 07:39:56 +0800 (CST)
From: Qianqiang Liu <qianqiang.liu@163.com>
To: ray.huang@amd.com,
	gautham.shenoy@amd.com,
	mario.limonciello@amd.com,
	perry.yuan@amd.com
Cc: rafael@kernel.org,
	viresh.kumar@linaro.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qianqiang Liu <qianqiang.liu@163.com>
Subject: [PATCH] cpufreq/amd-pstate-ut: Fix an "Uninitialized variables" issue
Date: Wed, 11 Sep 2024 07:39:24 +0800
Message-Id: <20240910233923.46470-1-qianqiang.liu@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHz9bL2OBmjxlgGg--.35070S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF4DWryUCr48ury8CF48WFg_yoW3KFc_C3
	48W397Xa1jqw1j9a1UAF15Jw1xK3WfWw48ZF97t3sxA3WIyrZYvws7Zr1kua4rXw4UtF17
	W3yUtF4vk39rAjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xREveHDUUUUU==
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiLw1WamVOGP3eJAAAsq

Using uninitialized value "mode2" when calling "amd_pstate_get_mode_string".
Set "mode2" to "AMD_PSTATE_DISABLE" by default.

Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>
---
 drivers/cpufreq/amd-pstate-ut.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index c291b3dbec38..f66701514d90 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -270,7 +270,7 @@ static int amd_pstate_set_mode(enum amd_pstate_mode mode)
 
 static void amd_pstate_ut_check_driver(u32 index)
 {
-	enum amd_pstate_mode mode1, mode2;
+	enum amd_pstate_mode mode1, mode2 = AMD_PSTATE_DISABLE;
 	int ret;
 
 	for (mode1 = AMD_PSTATE_DISABLE; mode1 < AMD_PSTATE_MAX; mode1++) {
-- 
2.39.2


