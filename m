Return-Path: <linux-pm+bounces-39618-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD03CC1096
	for <lists+linux-pm@lfdr.de>; Tue, 16 Dec 2025 06:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00DDF300EA39
	for <lists+linux-pm@lfdr.de>; Tue, 16 Dec 2025 05:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0D1335083;
	Tue, 16 Dec 2025 05:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y27/fzQE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3172731AA8D
	for <linux-pm@vger.kernel.org>; Tue, 16 Dec 2025 05:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765864420; cv=none; b=VwXWGuFoeQy5qtVw4KaEumjfrYJ+Lhv6F4oFGWG4ZmENQobspjsaaOQacKIh/U7QbLYu4kbK+3aXy5/KvisFftd4/bn5LByQw2JLvxGzlC6mdKY2f4QenC5oDTFXHOIADlN02fZL11UwJG4RslKoXUocL9TIq+aaPgwjytgWySw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765864420; c=relaxed/simple;
	bh=ht7aCwA39/RdzPYlfjwRUAlcPTEd88ErkRahgpcJnoU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kjf/Sf88rLoHVOWyvEMCZMSZ/9OkTcf8xCYRLMSfxlT/I9L0yqxOhrsXcbCUbqTsG/4sQkiwAEpjKAzE+vgPsFbTw0wMZxBBvsxwxnbwBKGr826zfkAjbEZo5XelhaGsOgXIZKb/ekjwHKUppiG1oOQiCEc1/k1WfQf+JNqd9e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y27/fzQE; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a110548f10so3229435ad.1
        for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2025 21:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765864412; x=1766469212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MncoL4J5El8AvquNiDQs2cAUbtdq/qB67h41aRjACM0=;
        b=Y27/fzQEpLv4i3Dis51QHOvCYOPQz17Bn3gY3FXU4lWRydxozUgFRRD8/kbaxRp0m9
         avz0nEvXuQkQsolAlQ5c7D6j0SsDEHq7Wz4LTNPoPrpGVtTg2lW8Oy60B+k7JG5YUM0z
         cnJJfeq70NF6R0ocX+kW10xbt3VxVq4Ps1swMkNF6OlqWiAFOv3QwMYZ4o6whmsTyQqr
         uMv5nPfM6eu1d7MV9Xx8IWUuKPadmzl0TYPkgZXSzWUbn8mm41eU6w/734fib1ikS+Up
         u7Qm+WiQTfDT7pKiZmfrN3B4GATxR/yM0RbpNCHb1sp0D1TLpQPethuQOtg7iOpURwRf
         GPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765864412; x=1766469212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MncoL4J5El8AvquNiDQs2cAUbtdq/qB67h41aRjACM0=;
        b=Ru2aHlV2L/jR332/STco77KJZXKC4fW5oA42+5SMaF/PnGfpiFry3/m4ARbW/H8YnD
         XMNxfHqJf0h9F5VJPEP2pzSp+S4an+jXx0EYIt8RERxraeEnTPYWeAXfl3E9N90SeGm/
         j64Ta2rkrbdJs57hfTdxuIfhFBoDBDqvEYTyN4riROkcN4+rWn1ZwNQj95EXiZ96LiI3
         m4z52XcMIN4x6htOYYar6wMW6vJtlf2i3q5eaJM3Ik4CfGeYStmHj3IOWRXict6D6X7g
         k0zI+hIAnUgMAERyAcDcl/xzA8OO23aPFdPgd4dtLZWw0g2pHi+goxyknO4Ok7Riu0Nb
         Wn8g==
X-Forwarded-Encrypted: i=1; AJvYcCXDtCA+GmCvpLeMHhkX3miqD9fueCbhrrbSWcEMEgJONiLsqxPm/rSDbmYskASQ0YgAtvTa9Fbsxw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ+CTbV4D+8ZZLhGpzOaLUCzQuGBs7kOUywvsR5FjNtY79bxLf
	YYMWbuFDtxLbXrZnf8yO9mQiB7n2K9/Dxo7pvd5igQ3oENq5d6wbE7oL
X-Gm-Gg: AY/fxX4KXRdSrfFQ7cFVD1VnsMVqv0zOvCNR46aCAPAiUgxv7n+DYIJJaa4VWwp4pmx
	qR2yLOA8sRh1FT+msYGYkoNzWNZFM5DJdHoVjC84e2qhCBiXtMBKRADebwhazsRbiU4sObkghiQ
	UBynuMUO38TCo521q4dhrWukQUgVWoJX6uNpJyrCedfmRaZDyD6oD1ml6WB+BDvUvStTmiz52Df
	R5vphNAO3F0kl3RWJQnC84Aj9nCDyFnkIlkdgdBLWPjHhTsa37ZsDFvg/BuyidN4lYWuz10/wPi
	j+h9pTx1RWGYPFDX9nmabMzaSzcqrCC6aWV/B69OfwQaRtt9Fi9KvwERAU9pKuNMbsaN3J7mJzc
	vNWdmcApwrK5u8l8Nj4PwGA04q1PXGZKj9nAZtOJKnA3Pt1WUXxep4aZjMqjP8AVAaqGGvEH9p6
	afQRZk8dTtVGazdUDSZa/e
X-Google-Smtp-Source: AGHT+IHlO9dTRrnnOwgtEjc9dR0KmxJlpQDIlf7LaY+F28cguSQy75elhq/r7OBkP4FdWFKAp6P0sg==
X-Received: by 2002:a05:7301:4d0d:b0:2a6:cb65:1974 with SMTP id 5a478bee46e88-2ac2f8b2b5amr3472470eec.1.1765864412245;
        Mon, 15 Dec 2025 21:53:32 -0800 (PST)
Received: from localhost.localdomain ([183.14.133.101])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f392500cdsm33433791c88.7.2025.12.15.21.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 21:53:31 -0800 (PST)
From: Frank Zhang <rmxpzlb@gmail.com>
To: heiko@sntech.de,
	ulf.hansson@linaro.org
Cc: linux-rockchip@lists.infradead.org,
	linux-pm@vger.kernel.org,
	chaoyi.chen@rock-chips.com,
	sebastian.reichel@collabora.com,
	quentin.schulz@cherry.de,
	Frank Zhang <rmxpzlb@gmail.com>
Subject: [PATCH v2] pmdomain:rockchip: Fix init genpd as GENPD_STATE_ON before regulator ready
Date: Tue, 16 Dec 2025 13:52:47 +0800
Message-ID: <20251216055247.13150-1-rmxpzlb@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RK3588_PD_NPU initialize as GENPD_STATE_ON before regulator ready.
rknn_iommu initlized success and suspend RK3588_PD_NPU. When rocket
driver register, it will resume rknn_iommu.

If regulator is still not ready at this point, rknn_iommu resume fail,
pm runtime status will be error: -EPROBE_DEFER.

This patch set pmdomain to off if it need regulator during probe,
consumer device can power on pmdomain after regulator ready.

Signed-off-by: Frank Zhang <rmxpzlb@gmail.com>
Tested-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Tested-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v2:
- Simplified the regulator check logic, trun off pmdomain if need
  regulator.
---
 drivers/pmdomain/rockchip/pm-domains.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 4f1336a0f49a..997e93c12951 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -879,6 +879,16 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 		pd->genpd.name = pd->info->name;
 	else
 		pd->genpd.name = kbasename(node->full_name);
+
+	/*
+	 * power domain's needing a regulator should default to off, since
+	 * the regulator state is unknown at probe time. Also the regulator
+	 * state cannot be checked, since that usually requires IP needing
+	 * (a different) power domain.
+	 */
+	if (pd->info->need_regulator)
+		rockchip_pd_power(pd, false);
+
 	pd->genpd.power_off = rockchip_pd_power_off;
 	pd->genpd.power_on = rockchip_pd_power_on;
 	pd->genpd.attach_dev = rockchip_pd_attach_dev;

